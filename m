Return-Path: <linux-kernel+bounces-162013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306908B54A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D463E1F22321
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABF2D05D;
	Mon, 29 Apr 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuGJYnty"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058D2942C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384820; cv=none; b=LRO+XTpUW+3oxL2K4aNzrG7ScOPO+2yQNPxtjMKuhTTHYA7UfkjKO18GFWR8qN4VJP6eQ0fhlk8QoW1dj0DvQ5GRtlfepQongqtntry7KVv083GfYS5o0YtXCoAFY5okAA2HU4k929OJJTBn+Gh6xVqQi6CbROJtqzSIWmQZFrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384820; c=relaxed/simple;
	bh=/dZqyz1It+w2R7umVEzwzcTipCzDfzUlkwHTD8s6SOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUcHXWyt0TAEt9V3ENecQFQSjaGX4R7YK8W/xgtebDT1BKGBvEEbuWBI6wYCx2N35bfN0ld28C5b8Odd9dUis0jlQC//0QJNY2SmVhCD9hRt6J7O+D9ljDg/eycOk1i8ArIvluX8pV9YZr3koMX0cdmzPUu0+FeB40AlyvcJewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XuGJYnty; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso6604191e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714384817; x=1714989617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6herh9L8Ye+/rY/8ZqWIyzGEwHPKIW0DS7qwT7CViEU=;
        b=XuGJYnty+ZRGrIATEfSFGRS3XgebTfwirFADxAQKjI7u7kZRf6ugFzo8E2Ns8tq23n
         iDe1l5s228aPfXQZcnwCVmw8DF3bcAfJhe/CeDaJi7UIstQMwW9oubAaYCBVvp2wtFZO
         vcO7mwBVZGveMMEc/0rEzISnVow4/WMB+JKhnX1SS9lK95+LJjD5iOT9yicwLGqS3+jy
         a0FiYVYH3ASWjME152KcEP8tYwJhlV1xm7BFar17nJzvslq1TLK42k7AODtioh5L1TwX
         mQj+EGo1oC0YNxQ2wpDutTrOSaP19cmogDUT7/7zuhRYHlZ5YgUN9GeO4htMSSqT+UY1
         24tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714384817; x=1714989617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6herh9L8Ye+/rY/8ZqWIyzGEwHPKIW0DS7qwT7CViEU=;
        b=diizMuhVSrn/DIGkqfX6tTsQmYn67wbCo/tKsCYwzZOVEL4YH7iBe5v2JFcNYaCsvn
         uI2LChB705KNSxoi7u2YSfV1R/GAR8Vlj854yaO9c65nL/NUMwRPX5GYqvEH090SWpFM
         S0w13wEESeNCoxFwxebKvAAoAv/gjbCoOVH1ykJeJHMQPKRLoUY1jrS7Shi4ku1v+j3e
         DziUauXaCfRBViYASyGhqACTuTK5CtcIlRL4mg12GjkwChwaaeMRHc+UOpAR01RFa8qH
         ixAebrcQ/eqVSEveHeENu5OVUL79rCLGMrYrlTqSIp0nAvScl7nLBz/UW7WWg5DJv7xZ
         Z0JA==
X-Forwarded-Encrypted: i=1; AJvYcCWocq3HXm9M3PY9lPGwI25WBmP1FoQ8rmcgf3beM7J4kGu6hjZiL0PCn3pAX0lNzb4yNyN6sH0bI9Aa5chyHNB3x05o+/1IAPt6iScY
X-Gm-Message-State: AOJu0Yy4ylSJ8/UiDrsFj6uFq12Lmu1JBq3i+Flqh+2us+Cbzb5QdMLo
	wVsHC1L3YBkKqQV+K0cX3mVbJiMfSkrxyux1WZztM0GdJ4ieV72u8w3xGlIGb4Q=
X-Google-Smtp-Source: AGHT+IHw8pGwH4w5X5Ob/iDCnRmh06lGOKdejVGcTb2jrtnhOlzwS6yCZfh7Y3XAS52rVxcDVy2pwg==
X-Received: by 2002:ac2:44cf:0:b0:51d:9aa7:23e with SMTP id d15-20020ac244cf000000b0051d9aa7023emr2088320lfm.65.1714384816684;
        Mon, 29 Apr 2024 03:00:16 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b00a5910978816sm2568ejb.121.2024.04.29.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:00:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:00:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Fix missing put_device(region_dev)
Message-ID: <9254b051-3221-4877-b6ce-68bc2bb9f217@moroto.mountain>
References: <20240429013154.368118-2-lizhijian@fujitsu.com>
 <bdfa663d-9a00-484c-80f7-75d7fa130cd3@web.de>
 <2ea9506e-4be7-48a2-bcc8-4ae543a7f1b5@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea9506e-4be7-48a2-bcc8-4ae543a7f1b5@fujitsu.com>

On Mon, Apr 29, 2024 at 08:26:19AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 29/04/2024 16:00, Markus Elfring wrote:
> > …
> >> Simply put_device(region_dev) if region_dev is valid in the error path.
> > 
> > Please improve the change description with a corresponding imperative wording.
> 
> Yeah, I always overlook this point. thank you.
> 

Greg has a bot that responds to Markus's reviews for USB.

https://lore.kernel.org/all/2024042547-shimmy-guileless-c7f2@gregkh/

regards,
dan carpenter


