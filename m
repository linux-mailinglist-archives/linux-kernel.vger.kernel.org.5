Return-Path: <linux-kernel+bounces-89407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7486EFF8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E371F21E06
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56914284;
	Sat,  2 Mar 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7Wxz9Li"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC00613FF1
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373592; cv=none; b=J2rYqcjEhxXoadFUYxlk1x9EaIf6o1cal5nNDWVdouL98qoOuHHC8WEtXzjs33CzmE7/gwNPdbNmBia+o1JYYUrR5F7250xj++XIeTfg5A50KY8m5CK+NCvLyJQE8EhaDxJOS8Ykih9/57isOZt8JAPBwxdJqryKjAu9nQEpEls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373592; c=relaxed/simple;
	bh=/0GFsJ+1/uHwP0+rcrGwi4dtraL0RyOLUoywuy05330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8sSbcaqqWcwnq7H46jyLmp37JbMUfLL38ihtrWUHO/viINOj9ykSvoHatmkZUgOTZBFsAayXxP9o5Ymk5HGML9f9TjkQI9sm71rgzWozXONEBNE5dJxItjcH/wvxEs9hwnS5cW+7U9nTOcTgReOOOj3oY/LV9YlnNb3VuIPWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l7Wxz9Li; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412d67e4e91so1176695e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 01:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709373589; x=1709978389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXevwhgIr2J2YRRZ5pTYABsmmlbW89cM1iNV1W0EhcQ=;
        b=l7Wxz9LiZVMUn68zuaquq+z33QQTyD5a8apPGccQzDOSWJCiIAd00BbbppIGkrshr3
         /b/vZw6vKC9yaRVnrasO/aUoSN48I0nmflv7X4O7JDZ2YXKvl4fEmtNk0O/6E/K1EvXh
         io34SLGAIJkxA83GPhbgAVVuvYdb4CgRo5pllm29PyHWm567j0flAddfSktok0VxS6lP
         5qU+3gzRg6s+SML8fPZ55iAOpOvBRj2zKxCTUIg4VaLyTmBNfpsd4/0k1RZI+P7OX/pI
         KrvqNwQDYsfbzDuXgfgnjUBUWN+h2dQfDSEumsLkol1YRTs3rvXO1rlYqb2c/Yvhz9OU
         l0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373589; x=1709978389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXevwhgIr2J2YRRZ5pTYABsmmlbW89cM1iNV1W0EhcQ=;
        b=KAzcUbyLkjCuOwFfsJdnsUe+ZkeJAiovYh3fs+fzbGwHQi0HJVFwHRTL8xIsbl5nY/
         JAMlQO40lIVOjI/1GyRSIFYNQs/3XJ+aGoMkL3hhIzpKXlCstqzPOacfVgHAZISiJATV
         4INItlrsWw8FoqPJwwl4FlkwF1sURqjfE45GLcM3UCSXmeEPowjEowCaS5VvyZB6+LdU
         IOJA4uXP5xZ2vAzvJXIt0UB/qhbpogElV5CPRhp7V/QH6xSexV6KZwOJOCa5hC2yGT40
         GsKlhAKltet4FQshT9DH1SQVps7aCkPR4UAGapaEgGhf6dt1zTFG4qczwkD+e68h+RaF
         shIw==
X-Forwarded-Encrypted: i=1; AJvYcCUc5K0bVDa6jbr5kXJm2rF/Y8pXhIxj+Dgl+IhHSO42gUigLWn3cSfRbERnbcHUB6teiJqeZt8TC3Zwtodl+yqz91fS/TKGSoKWLL0g
X-Gm-Message-State: AOJu0YxoA1ZCdOSdjiuziNK0TIfKVgMhdaff1sy+wAdPqgbRZr06n3QJ
	hc3Tm17XOxvj4OaOspbn2dwnZJ/PHDb8UwTVRrmN5OSMmxvtQGVZnhqdhKjY21o=
X-Google-Smtp-Source: AGHT+IGp8XtRUBc+woL08R4bjKNomQ6c36yPs4xmUB7xf/YAncZBACwwvcMHn7i4i9lCZGd9kOTtyw==
X-Received: by 2002:a05:600c:5192:b0:412:afed:5cfb with SMTP id fa18-20020a05600c519200b00412afed5cfbmr3731099wmb.15.1709373589034;
        Sat, 02 Mar 2024 01:59:49 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b00410bca333b7sm10876433wmz.27.2024.03.02.01.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:59:48 -0800 (PST)
Date: Sat, 2 Mar 2024 12:59:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Message-ID: <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301190425.120605-1-m.lobanov@rosalinux.ru>

On Fri, Mar 01, 2024 at 02:04:24PM -0500, Mikhail Lobanov wrote:
> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
> Assigning the channel the result of executing the get_channel_from_mode function
> without checking for NULL may result in an error.

get_channel_from_mode() can only return NULL when light->channels_count
is zero.

Although get_channel_from_mode() seems buggy to me.  If it can't
find the correct mode, it just returns the last channel.  So potentially
it should be made to return NULL.

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index d62f97249aca..acd435f5d25d 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
 static struct gb_channel *get_channel_from_mode(struct gb_light *light,
 						u32 mode)
 {
-	struct gb_channel *channel = NULL;
+	struct gb_channel *channel;
 	int i;
 
 	for (i = 0; i < light->channels_count; i++) {
 		channel = &light->channels[i];
 		if (channel && channel->mode == mode)
-			break;
+			return channel;
 	}
-	return channel;
+	return NULL;
 }
 
 static int __gb_lights_flash_intensity_set(struct gb_channel *channel,

