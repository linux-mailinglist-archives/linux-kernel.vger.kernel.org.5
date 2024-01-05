Return-Path: <linux-kernel+bounces-17812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B77182530C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF16B210C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5472C871;
	Fri,  5 Jan 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2WG5mDwH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8D2C857
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40b5155e154so16351275e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704455020; x=1705059820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3kGqPETt9k7grf39pi8sU+581W84Ft4rteGJGKyNE8=;
        b=2WG5mDwHiQyUKzaleDWv5OK3Is6JoddOMTNdW7afaYlLqjiWyNebl/wRrrBbVpKx7L
         2RJf8EGd2zlhHm7WlXLHd8UKk9Dc6XZJWeH71NIUoLUetkBEWvEipH9prCr2WLpGfbd1
         212RHF9DvNbZfsrGDfSOdmYs8bvmAHiBeIqty2aE/ycBMlqorjuhTnMQWlnIiXLpyTYs
         D9wvzlcEM82EI6cf3oLNC+4egs6Q9E6UjiVkJ7x6V0zptR4VpcXDN8Iq5T57iYeeg4xV
         hnSivow9+ql2nvgnl4cEANolDFdqb308Rej6yIAzV/RsgMjT3E5GfNVnzPubgxuoG7Lw
         ilBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704455020; x=1705059820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3kGqPETt9k7grf39pi8sU+581W84Ft4rteGJGKyNE8=;
        b=W9eOyJDR3g3zIN2Z/8K57YroRtedGMwn8gXyjjPP8gzgcjwMmVGe8EQCFqY8sZw+Yg
         8KX/zifUyWe4auG9JBkb8SgjXQ3qLMuJddqhOXjNyoIlcvLjrjhtEPIHWExq0e6x71hA
         HjFINboaObCn0CGQmdzTSm9AfEp5dBNLYnfcJrkQ2b52oBi9iF2T3SRT6AIaHdi6VPK7
         Zzt9ntvugRVFB1rztVjWuR8HZ7zpSZq14lLOnR3St+1t9BCMgyfmkn+Nd8ARJIggsMrl
         rwjvEGQ+NFTPypm9UuZY7bclgOE9x+SZkKT5Vmy+kYwyvQVV/CCJzalLraGAT5N3XBiT
         RBew==
X-Gm-Message-State: AOJu0YxfwB5z/CAVwaXoF+9Soi5HdXkpbltRJ3Ds9ikVlg+tEzyaBXz4
	Bz0E2JNxlLINaESNvgDO0pExAsJmd3C9jg==
X-Google-Smtp-Source: AGHT+IGW3eudwDbD2LphnyuymzvawOk5islyitmnMc1lb8gf8qjEVFFiByU/S8G4KfTNybKOpsfaig==
X-Received: by 2002:a7b:cb16:0:b0:40c:6d5f:e88c with SMTP id u22-20020a7bcb16000000b0040c6d5fe88cmr977192wmj.185.1704455019886;
        Fri, 05 Jan 2024 03:43:39 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600c474500b0040e34835a58sm1319547wmo.22.2024.01.05.03.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:43:39 -0800 (PST)
Date: Fri, 5 Jan 2024 12:43:38 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v16 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <ZZfrauRNNJsUGCRr@nanopsycho>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
 <20240105113257.381090-1-justinlai0215@realtek.com>
 <20240105113257.381090-9-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105113257.381090-9-justinlai0215@realtek.com>

Fri, Jan 05, 2024 at 12:32:57PM CET, justinlai0215@realtek.com wrote:
>Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.
>
>Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>---
> MAINTAINERS | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 53b7ca804465..239aae94dc0f 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -18476,6 +18476,13 @@ L:	linux-remoteproc@vger.kernel.org
> S:	Maintained
> F:	drivers/tty/rpmsg_tty.c
> 
>+RTASE ETHERNET DRIVER
>+M:	Justin Lai <justinlai0215@realtek.com>
>+M:	Larry Chiu <larry.chiu@realtek.com>
>+L:	netdev@vger.kernel.org
>+S:	Maintained

Quoting the beginning of the file:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.

I guess it should be "Supported" in your case.


>+F:	drivers/net/ethernet/realtek/rtase/
>+
> RTL2830 MEDIA DRIVER
> M:	Antti Palosaari <crope@iki.fi>
> L:	linux-media@vger.kernel.org
>-- 
>2.34.1
>
>

