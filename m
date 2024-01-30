Return-Path: <linux-kernel+bounces-44245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819E0841F49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3536C288780
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6E59B7C;
	Tue, 30 Jan 2024 09:22:43 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B85821B;
	Tue, 30 Jan 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606562; cv=none; b=NjAPDwDYJo3+HnXHOERcC6yPHpnJ917gBKAYjXWfZk0NcRtCfLYw4zsB2FAuiv6bh203rsAkwrC7F/qxLZPBM48mutuqq1TW4RlH8MxM2/6XcETGEKfpzR9FkunGkd9v9kq26pTC386gH+/cpKuVFOWZPYXRPJmrHm0c3gRZtHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606562; c=relaxed/simple;
	bh=3FaXiBg+ttcHCxyhLX5SxGC4C48vfhGTHfFGfydFHHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+fg6OZO++XpT5YLwo+whxBJVw2WDBFvFFY96YZkh5hpLEHc+qRGIXt8dk6rx8JqqnPkVKhEBfEV5xJiUBjRWNQyuiuB+UmswiBMetwIhbpIE0rm2lNq0sKzh09rvLC/HKwI4Gpum5JTbe8Pb/JzdqeGYYAK0KmlrGzL4W/zJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a271a28aeb4so449809766b.2;
        Tue, 30 Jan 2024 01:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706606559; x=1707211359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdKd23f1J6yGmBgl+M5aVLp5kmWUlm4oxH8bB0nJi6k=;
        b=vzarZfHNQtj1FjJ+lNilK1LFuoRXvt6a5OHaeSuYnbCDv4Sv/2zywVwq5OOnCdy9db
         kcnX3FOPCgaGwJyNVahjgbunIgL1dbsNgAM26L1q1opIjwR024kaAwM2Dxnfn86OfrG8
         lTNYam3vzHgfyy9VsDJkP7Vmoz4F4qtU93JU8umlurbOeh6rlE+RDTWEB1vLGvOc5pbn
         WGu2Vag4GCIPmnzddBHCUe42ZQoZWD9TdMrIsDuvf62euHZeZWsvh4PDEhJi5YUZInZ8
         eY5InSuF655eHRGMGASju0TdbcHm9QpJz4+UmQRWKTFDVqYH3GWNNUB9qfCd4jxR8WnX
         116w==
X-Gm-Message-State: AOJu0Yx7VIFOGlbrAWRKLigEGEBVn7L4H5m6PwgxCyxFXy/c6GHL1l37
	ZHldraKkmuYuvuw2WtWMkqslNtZLgfAdKL7IWr60ja+cBoXaWPOn
X-Google-Smtp-Source: AGHT+IE+mGmGxjygvwBRDOJm7IEcs8uZLlvzYKx1CiWSGHAdIlcYcKjfXBgTFYfKS+qB7I/AwI4VAQ==
X-Received: by 2002:a17:906:1d03:b0:a35:499b:9644 with SMTP id n3-20020a1709061d0300b00a35499b9644mr5901234ejh.15.1706606559292;
        Tue, 30 Jan 2024 01:22:39 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-017.fbsv.net. [2a03:2880:31ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id mc4-20020a170906eb4400b00a338fedb9ebsm4936377ejb.54.2024.01.30.01.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:22:39 -0800 (PST)
Date: Tue, 30 Jan 2024 01:22:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Matthew Wood <thepacketgeek@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: netconsole: move netconsole_target
 config_item to config_group
Message-ID: <Zbi/3Z/a/PCYha0W@gmail.com>
References: <20240126231348.281600-1-thepacketgeek@gmail.com>
 <20240126231348.281600-3-thepacketgeek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126231348.281600-3-thepacketgeek@gmail.com>

On Fri, Jan 26, 2024 at 03:13:37PM -0800, Matthew Wood wrote:
> In order to support a nested userdata config_group in later patches,
> use a config_group for netconsole_target instead of a
> config_item. It's a no-op functionality-wise, since
> config_group maintains all features of a config_item via the cg_item
> member.
> 
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

