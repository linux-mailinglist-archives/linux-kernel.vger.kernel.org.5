Return-Path: <linux-kernel+bounces-12975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47681FDDD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 08:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDE1B221C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 07:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FE747B;
	Fri, 29 Dec 2023 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvYR1fLp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5FB63BD;
	Fri, 29 Dec 2023 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4006b251aso54471235ad.0;
        Thu, 28 Dec 2023 23:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703836012; x=1704440812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJFWJxAHzDVPnXxezr+IcCLPeTJ3qyaH1h5ca3yL3j4=;
        b=mvYR1fLpXsM3nCzNXDAOsqhPeGcu9RwesVcgBQRNdgxQVhGZciSd6DvQm1272uujLz
         CWlbhb00VjW4KUW6X1Dq36EmtpKBdXaO055LHKYdrV9Ut53wTWHiA3gHm2dp/XmzH1/B
         rAPa9KLvOb7d/AxCgxKTG5aRc6PmKE13lxYVDe99aAan1xr2zWlkJ13DcCS+zgOvuAhq
         SLnVX5+w4asClzGu+Iaqe7hSNLQG8Ejy/XaEU9WzYzfbGPBy0ewbcPEQgmvQ1BrT7bef
         g/VyhmJXkLFRaPrXSwsce3J9zmDb4Jd7RRt6UzjSmN/sBvSmXG7F4doNekREIIRk9Z5p
         rOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703836012; x=1704440812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJFWJxAHzDVPnXxezr+IcCLPeTJ3qyaH1h5ca3yL3j4=;
        b=Nj+szTIRnUpk4AQPYX3RWTpLu00pus5A0S+thr0Nmh06JHRk72zcNMYVGc5cztizyY
         53yiNysSKxqzwUlTYnzK+WeqKGirQVTN8fAcZmq3XNwh4/Oxlb2ma9l2dsB1RiQ4bB8O
         FdzT1oeuTpnUkFtyM0SEKZS96AtyQ5epCONcnvc5dFsrKitKBX9uR44rdGWbXHBkI2Bn
         5QqzmfBFgW3Jyn40iTyzkhDXZAY9cCqSVm3XEasYY+viAQ4KuyOZ6Nim/teBbf5+rB2D
         cilUoSCbYt1SHWYOj+c16qysnRcC8Rx38le59075dJi60PUKWXkSV5w/kSArxSGWQtmN
         m3ZQ==
X-Gm-Message-State: AOJu0YwDSZPdUV7D53mfc8VT78DAphNeu6hIphvVzWBex5pgBGYHnFwT
	GvlEKz4MEdlQuOStR5WVWg8=
X-Google-Smtp-Source: AGHT+IGcW2OzSf2MWS5bb2Bg2MOgbzD+aoHFVcD5msV+vYD8AK3vYLa7MvMRIIH3jUTi3e8iLM8reQ==
X-Received: by 2002:a17:903:25cb:b0:1d3:c730:f0a2 with SMTP id jc11-20020a17090325cb00b001d3c730f0a2mr11773683plb.118.1703836012320;
        Thu, 28 Dec 2023 23:46:52 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:1995:632f:ef1e:946e])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d058ad8770sm15064252plh.306.2023.12.28.23.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 23:46:52 -0800 (PST)
Date: Thu, 28 Dec 2023 23:46:49 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, Hermes Zhang <chenhuiz@axis.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - filter gpio_keys -EPROBE_DEFER error
 messages
Message-ID: <ZY55abKFwTLnVGtw@google.com>
References: <20231229013657.692600-1-Hermes.Zhang@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229013657.692600-1-Hermes.Zhang@axis.com>

On Fri, Dec 29, 2023 at 09:36:57AM +0800, Hermes Zhang wrote:
> From: Hermes Zhang <chenhuiz@axis.com>
> 
> commit ae42f9288846 ("gpio: Return EPROBE_DEFER if gc->to_irq is NULL")
> make gpiod_to_irq() possible to return -EPROBE_DEFER when the racing
> happens. This causes the following error message to be printed:
> 
>     gpio-keys gpio_keys: Unable to get irq number for GPIO 0, error -517
> 
> Fix that by changing dev_err() to dev_err_probe()
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>

Applied, thank you.

-- 
Dmitry

