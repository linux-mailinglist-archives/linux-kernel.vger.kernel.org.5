Return-Path: <linux-kernel+bounces-91223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F8870B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C87281BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D697AE66;
	Mon,  4 Mar 2024 20:19:49 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE04487BC;
	Mon,  4 Mar 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583589; cv=none; b=U8bncJqGxVqLvAN+x8B9GR9PX1QMakmzJqWAp/tKZPtrnhsvc0HM4fcBmviWaiyYyZsUEm5zaGmfw9GDoC0VcrWwfTslPbpKgdcHfmlrKq8+gNK0FQPECabvWb2cpJvyo47FMNTIN0Uu7MWplHY8OyjwlDjfL/rwRio9bmOvfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583589; c=relaxed/simple;
	bh=49a77s0C9FZNB4YeeUiMH0dVIfYK3W0bPQSOC3L37RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQWJv+tueib3VXdYzTHXepKYQhcLEhE7ZTgIEXqzybtW9YR2Gq5AlAnwXCMytYpXEVInb6szlY0UEQjYaWwi9UIhA5f0WsCJmySt1ReeFQnjBWbOGRfCcOE5uJ//6O/FHkW9n2RwTT8ITSffY3aHQmZrXpFU2hLw4GSFClesYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso7474721a12.0;
        Mon, 04 Mar 2024 12:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583586; x=1710188386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTOxl5O+qRGOc8sxMe8xhuxN1uI4p5ZBwgf8IvJZw4U=;
        b=OdOGsu9uHVokgfq8AjRAdwU7mfNLfwoLHTBSnwotkYP6KnxVxql7T0kSOSkJ7OnxPj
         s4B/av4jCQVbq7rAUfrjQ6qBIjy9eQayPHfDk0gM7tRIgf0G6Qksf1bMMsSxDyAH+55l
         NEN/2PeYNvvb35CIvDJZ4s0PUAVOMX7ZNofQPa5cgZeAogpIiE+TqLqcbOkiW+COMCUA
         5d55hvEojzUbuc4XQk+oLHYztqMPJORV1y1asYJE0UEez2/5ZRchbQeprfIINUGQDACN
         akM4wmWpXlca3SJ/cAPBh5NbtypXFOYC9RJxBo2tDjOGNFti+Id0IRGgs8ZpYvlDImE0
         5ErQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYtd90C1yNBJLVliSbV6LAlGMpQySs/EGOS4NuEjfvu808xvMmswIa/8EfgU6LjkTZm2cAFDuBVNmyeUNs/tR80q0w7tdZFa1V3S2KTrkRG6bYRrGNroOm1fX4PMXCTfJqx47Rkfe3PwRL8nj+f2SsPIogwsPrOTSo6jDREhqd
X-Gm-Message-State: AOJu0YwG8PI2ecV/1GMvxJnx+vGZJcMtuMjmLCtlf3RzpnB07CZ+q0rQ
	ofUsdaJqV+BldIS7RZp2vugyv+yYmD+wB3V/0hWeG0HfueqogFxK
X-Google-Smtp-Source: AGHT+IFDdMRoCemUXBEIYEFoavOUyqcNM1zYCfABGMtYUSVoMeQ39K6dfrLi734YDAvfQYUNvD0GFA==
X-Received: by 2002:a17:906:348b:b0:a45:a348:32ad with SMTP id g11-20020a170906348b00b00a45a34832admr71416ejb.74.1709583585824;
        Mon, 04 Mar 2024 12:19:45 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id i20-20020a170906445400b00a44e3c8423dsm2978299ejp.24.2024.03.04.12.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:19:45 -0800 (PST)
Date: Mon, 4 Mar 2024 12:19:42 -0800
From: Breno Leitao <leitao@debian.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: ppp: make ppp_class constant
Message-ID: <ZeYs3nSgGiiWrSfC@gmail.com>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-3-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-3-8fa378595b93@marliere.net>

On Sat, Mar 02, 2024 at 02:05:59PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the ppp_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviwed-by: Breno Leitao <leitao@debian.org>

