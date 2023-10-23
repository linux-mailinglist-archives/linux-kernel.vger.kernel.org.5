Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E367C7D3960
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjJWOcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjJWOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:32:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E12D68
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:32:50 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so50666181fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698071568; x=1698676368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zLfZKHxVydtU/EGWqXKarc7iejpbu5G0JHAWOhD6zo=;
        b=JMza0nv10PyH1JNzrqXrSfm2Dn4ei2SwL54trvXuUnbGLSdKNus+5Fc0Vc6PYHIh0J
         p/XXqqxiR4LK94U43ZtcOwngmZsvBgXFtAFigg7fS8RdOYDh8AvG0VDqjeZmL1jiEkT5
         ZMJWDeB669/w7BRuCrSdNA0hSkw3r+WZNVfa0EEkBCH/+k1Y602SvB12DzpSK1TJ1YK/
         jdIi9BYxP1zwfV3qmKX3X1R1wfMh5gL0mYciyIASvD7thAGdCehAbgt4g6lqYRrkMcVK
         BA+HvVjSWRkjiF5qiwurwcEkVs819edIE8+EQvvymcxUMbT4M1vXYYIW1iZO93kzjHV9
         mHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071568; x=1698676368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zLfZKHxVydtU/EGWqXKarc7iejpbu5G0JHAWOhD6zo=;
        b=ro1zDaxYx9YHO6jTqOFXbPuDiY8s053+jZ9nOPK2OtS/K9k+51I/9LeOBGQUpdD+/B
         3/HB9uaMjb8HzT9v1JW3DTB9mL80RmURrdU0xrhe5cSHZ/elOiC4WOcZ+91rRxwxG/kb
         A4x0pQ+6fNO0tDWCQEx7/zroPlmJLHzXY5pqAi/9vZpMHrIXI6GCqCa8QHhvxdoe+S9S
         I9vik+ZAv+ygMQ950GOwfHi+2GWuo3AJwWA08jLc0HoFO36ooE5wc8EUnP/lF7bB7dan
         8/xHR8zVTnVBst/ZiNcLGO8/7M1wNQUiaIgIFlozcWUBN8z5F6o2l6+dT0cAx33qZHLe
         VRFQ==
X-Gm-Message-State: AOJu0Yy92NzcSne3J5iFcWIM08u2ViiAFd8W9+BbBIOFeyRZh1MMTYCd
        kFVbnPmS2pJBjYsl6pV+VdpjnQ==
X-Google-Smtp-Source: AGHT+IHWAvcn3DtHE1zZNxaFAmobec0SjV+b2xWBbgNDrpNvHCcScjtF3CCZpq1XsfYEUllNhe1Dyg==
X-Received: by 2002:a2e:a7c7:0:b0:2c5:1867:b0bd with SMTP id x7-20020a2ea7c7000000b002c51867b0bdmr6020677ljp.23.1698071568320;
        Mon, 23 Oct 2023 07:32:48 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r5-20020a056000014500b0032db4825495sm7854704wrx.22.2023.10.23.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:32:47 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:32:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: media: av7110: Fix various formating issues
Message-ID: <052d566b-574a-439c-8113-b894406a4407@kadam.mountain>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
 <20231020232332.55024-6-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020232332.55024-6-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 01:23:32AM +0200, Jonathan Bergh wrote:
>  drivers/staging/media/av7110/av7110_av.c | 29 +++++++++++++-----------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> index 82d4c02ae3ef..bdef95244121 100644
> --- a/drivers/staging/media/av7110/av7110_av.c
> +++ b/drivers/staging/media/av7110/av7110_av.c
> @@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
>  		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
>  		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
>  
> -		if (((sync &~0x0f) == 0x000001e0) ||
> -		    ((sync &~0x1f) == 0x000001c0) ||
> +		if (((sync & ~0x0f) == 0x000001e0) ||
> +		    ((sync & ~0x1f) == 0x000001c0) ||

You introduced this yourself earlier.  Which is good.  But better to
not create the issue in the first place.

regards,
dan carpenter

