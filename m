Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466A6803B03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjLDQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLDQ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:59:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EE7E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:59:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-33318b866a0so4411694f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701709174; x=1702313974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VW6ZEKeTAlPv+01U3KpzrPDmkbuFSecehjWoA2e6+hQ=;
        b=M74fErTU7IIFfESMYR2PIhrfnjKT2tapGtcESI+Ks9961gDR/FVGNFIwdpzB6BgRNh
         qBDbKkKjMszwDIYExzJ3kmdHuxPjV6a3myP1E+1E/ZA7xJ/IszLhdJWkd7HbS31j8AFO
         rPtZugK70NzVAt6FAEycEKQgNkdr86VJivRwjkHT3tpQ0tn9wpKrkNlmo0wawr5RA/2h
         R/LiJGTYgqOX5/OBXfFegFEin3Db2ncz362gMQklqG07XDbKscVfq0JH2kuY3QhygC/M
         5QU1o9mdRdGBK/jN1SZV8drle0h2OFi8bwktXhX9+RUtQVjNkZ8htmU2M/PIWwzPWvHP
         3Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701709174; x=1702313974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW6ZEKeTAlPv+01U3KpzrPDmkbuFSecehjWoA2e6+hQ=;
        b=CzkYY1pGQRgE2WOunS8a9xWaJi7/l9Ei5ctRQfyZkISUsWSWyiSJ7oFYNlAj1sJlTr
         7IjwQYES05IzRfdWnW5QyJJz33yUtq4WUdJI1F5TrM2wMzeWIXFIlNE2dRCNPnZIcE8m
         qVQsYnFkfEwqjQEde6JK8JZlmzDEfgVk63j4GO/wDTl3BIChedJwCOw+ucyaQobabkU8
         IU3EUrwCa5Yq5yQx5M18/Vw4YRvZ1ARWY4z/1hT36lP7CErK9pNUL0UPoNx6tqLSVaoe
         mbnpg834SxJ2LrO9AIqfJaPonSZDzn0yBuTNSLP1Fn9WJfGBIfKUwfSuoG8QH5BpIFfu
         Hrsw==
X-Gm-Message-State: AOJu0YwK3lWOOGTLfThMoA/C/pkFr3k3zIC8BdSX5ixt82F/KCdka+ZD
        hQwFYh/bGiDbvKbc1OcqGcE6Fg==
X-Google-Smtp-Source: AGHT+IHaL3ty79uYhfKsJFnFrKTOOoQTADVZipWg49o81gK38O85rKNT/7xxht0aYKZlpg2yjKro4A==
X-Received: by 2002:a05:600c:1e22:b0:40b:5e21:cc39 with SMTP id ay34-20020a05600c1e2200b0040b5e21cc39mr2684911wmb.100.1701709173702;
        Mon, 04 Dec 2023 08:59:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c139300b0040841e79715sm15796431wmf.27.2023.12.04.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:59:33 -0800 (PST)
Date:   Mon, 4 Dec 2023 19:59:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: nxp-ptn3460: fix i2c_master_send() error
 checking
Message-ID: <bb28e859-215d-4279-bc7e-f601352d06df@suswa.mountain>
References: <0cdc2dce-ca89-451a-9774-1482ab2f4762@moroto.mountain>
 <75c11af4-3f5e-4909-a3d3-8feea947d4ea@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75c11af4-3f5e-4909-a3d3-8feea947d4ea@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 02:53:05PM +0100, Neil Armstrong wrote:
> On 04/12/2023 13:29, Dan Carpenter wrote:
> > The i2c_master_send/recv() functions return negative error codes or the
> > number of bytes that were able to be sent/received.  This code has
> > two problems.  1)  Instead of checking if all the bytes were sent or
> > received, it checks that at least one byte was sent or received.
> > 2) If there was a partial send/receive then we should return a negative
> > error code but this code returns success.
> > 
> > Fixes: a9fe713d7d45 ("drm/bridge: Add PTN3460 bridge driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This is from static analysis and code review.  It's always a concern
> > when you add stricter error handling that something will break.
> > 
> >   drivers/gpu/drm/bridge/nxp-ptn3460.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > index d81920227a8a..9b7eb8c669c1 100644
> > --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> > @@ -56,13 +56,13 @@ static int ptn3460_read_bytes(struct ptn3460_bridge *ptn_bridge, char addr,
> >   	ret = i2c_master_send(ptn_bridge->client, &addr, 1);
> >   	if (ret <= 0) {
> >   		DRM_ERROR("Failed to send i2c command, ret=%d\n", ret);
> > -		return ret;
> > +		return ret ?: -EIO;
> >   	}
> >   	ret = i2c_master_recv(ptn_bridge->client, buf, len);
> > -	if (ret <= 0) {
> > +	if (ret != len) {
> 
> This is impossible, i2c_transfer_buffer_flags() returns len as-is if no error, so
> ret can only be negative or equal to len. The original code is right.

It works, but it's not "right".  The <= 0 could be changed to < 0.  The
"len" variable is EDID_LENGTH (128).

regards,
dan carpenter

