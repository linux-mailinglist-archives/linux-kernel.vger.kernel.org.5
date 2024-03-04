Return-Path: <linux-kernel+bounces-91222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9C870B67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8DF7B25831
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77987BB04;
	Mon,  4 Mar 2024 20:19:22 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4497BAF7;
	Mon,  4 Mar 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583562; cv=none; b=UGplq1fpAXPwOlicdzmyAxP2Y0zXBRWyL+kg8COlxPW111SE7+ZlTttSZH8/wCoINBrNn1hFvncdmncUr7IESWqoGUc1x54DD3SG2z+dDo6MRqG9FL7GMTEESYqH0+DF0Zi6Uc/8h4KDZ8uTD4W3ji4fpnmRWH4Ki/xpXZ2jhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583562; c=relaxed/simple;
	bh=cZLqTYaiOu2bk9deA+g54OjJ2LadNtfU7hA7K/nKNM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CChWoGlY66+0/mzb1lBThXp0UBVvFpAALBpGEuf92kR0F8Wo0Hij+Yu9dA9JRDQvV8djP5zkTOg9GxG/mEw4farn/CCD8WIm0wZ5b9fFij8iNam4sSdKXMSGbDfEc0pp/SZfbJ7EOvsEr375Z0wMSDUwm9lUFQrxDznaGN264Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a456ab934eeso163486466b.0;
        Mon, 04 Mar 2024 12:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583559; x=1710188359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLBb+T9z5q+g5UgFeOXXQ/ZVAkRZaqhWpyHrBugMSCI=;
        b=Z4jyjFiAfHgKHgY4BJhuZV6Yv8swM6d00bws7ZocepP9MaLGbb4O6lm4xoBC+nmdkK
         wFK4+VzFBJs8PoU5EKJHzkHDOrneG9fAzFM1s5P7vTbLPpDAq/1abUYswYj0aWwPqZc2
         ZTtb4cWNnqdqZ4gBxapXrDCMQ81vot1+qrIMX9WRS/iKTXzrO/suu5Ef4DnuDlKOxjcU
         fqNNpL5DcDZZBDPCNGKqYQVRUC7qfFPXilL+cW0Gi6c68mg0VFXHVQEGWj7eouS25Z7h
         1vB37qVtFohC1txvy9yqJm1Ibf+xbLQ3M4j6PHa/KVeEG+M/g0V4Rn5jAAe6cT6i+4bZ
         VC1g==
X-Forwarded-Encrypted: i=1; AJvYcCXVp2S3rwTK0nbYqopKYuuSt89rjV1aPi1eq2dWvtgV7qaCUK7ofV9yLweVPPwC8hkD4F2JUgst2ZUSSXKXusToruxAe5uBTLudtgE8UTfT3rm/ma9xRvfH0x1pg/obuAL1j0Lvs+Hu6lMGRtI9C08WHbmo+BStM2S41UdySKk9
X-Gm-Message-State: AOJu0YzJgs7qSr6kFKtOn7TJFElhsovZM983J86Fn8fWzJdDdqWw9a0e
	rqUV+th6wLkIAKLrNYE3Zfc9q0qXxVoKL1BNVddsVcmSiLJR1xGM
X-Google-Smtp-Source: AGHT+IHVh3TH5B0Fu/qX11N+HGXIGYiif+MCCFo90LFmFwuCKns4eQHrYi06IzUsH8sLH9WcZ2o1GQ==
X-Received: by 2002:a17:906:a89a:b0:a45:5b6c:e524 with SMTP id ha26-20020a170906a89a00b00a455b6ce524mr2134919ejb.65.1709583558999;
        Mon, 04 Mar 2024 12:19:18 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906049100b00a40f7ed6cb9sm5239682eja.4.2024.03.04.12.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:19:18 -0800 (PST)
Date: Mon, 4 Mar 2024 12:19:16 -0800
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
Subject: Re: [PATCH net-next 6/6] nfc: core: make nfc_class constant
Message-ID: <ZeYsxHCK43NAx3UY@gmail.com>
References: <20240302-class_cleanup-net-next-v1-0-8fa378595b93@marliere.net>
 <20240302-class_cleanup-net-next-v1-6-8fa378595b93@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240302-class_cleanup-net-next-v1-6-8fa378595b93@marliere.net>

On Sat, Mar 02, 2024 at 02:06:02PM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the nfc_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Reviwed-by: Breno Leitao <leitao@debian.org>

