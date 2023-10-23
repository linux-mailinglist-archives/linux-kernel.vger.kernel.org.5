Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE57D3A21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJWO0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:26:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055C6100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:26:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4079ed65471so27830875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698071175; x=1698675975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ibdm669iv9OJcE/KkdIFiBrAQ0+k5qbSY1Q4FYfsL4s=;
        b=fCMzxp5Fse15xzLkg6RG3CAvdg6fbORtUTOBfpmgLuiL/xYcr1q5xhb2RHFJed57sW
         Ly0O3x0X0p0deKvPqDyeeC3V7VSifTRSE2aSFtD6Q2UEQOBqDaxPMc8b4TXZvcEneX0c
         bX5R7xn7YpW9Lz8PygRkVOQkOCVuWXXE1WKkxlfw/fpXRc6S/YpjY9fsuIZVn/+sxqlm
         5v0EW0ajBcnXOy5OK6fUUiJac+zRDgvj9fVrTtf+OtVpeDO0zs9E5riOz+Fr7Bg5Sh1i
         9FGJuh+4Md/ucOHmefPXAJAUeQ50Lt/LfdirrfWbmTrqt1QIWMmB1BR2h/fzmNsT33Ob
         q50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071175; x=1698675975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibdm669iv9OJcE/KkdIFiBrAQ0+k5qbSY1Q4FYfsL4s=;
        b=h/Re0Y0P+LSs+LZ14qZips3ONwqOBkLTBUN90T7/wHTLwojPrnnw8dohDLZb5CqjSj
         SxmLhYlHySQUeEW02Eze4BU1UginVCe5RWf4jSqITPfiWT0hWPwFwTMxMXIWyzuIlxKz
         NGHHkoQ/bEzgpiNScC8tmyP7mXME1m/QybNNm2jarfPtNnCrTg6bZXyp7G8mqzF7dG+k
         heDwSnuJgrR4gdlckqHRkUNfZYuaNirqiJhkZDfrpAG1vUsSCPZy0d3y+DIeEEGTm6M1
         K2MP8A6dRVdTJzQJ7hy+vHthIn3RB7SeTuuIOc7ZTss6MjrA+9V+f04iPY2yPcjKRiNO
         w7zA==
X-Gm-Message-State: AOJu0YyQOEYNJmY8T/TFcqdavPpWM5vqOmkuLShzqxHrZZitsTIolS0H
        kZSl+V6UZAyNgo4VZw6XuJeWHQ==
X-Google-Smtp-Source: AGHT+IETpcAooUqMOCjkLve2ojvd0kVcymHo1QQx78Fc+2Tm7dO7RE2+Z3X3F4g6UdNhGVSJC4hmDQ==
X-Received: by 2002:a05:600c:5493:b0:406:5463:3f51 with SMTP id iv19-20020a05600c549300b0040654633f51mr7197630wmb.25.1698071175401;
        Mon, 23 Oct 2023 07:26:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm14091003wmf.5.2023.10.23.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:26:15 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:26:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, error27@gmail.com,
        linux-staging@lists.linux.dev, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] staging: media: av7110: Fix various whitespace
 checkpatch errors
Message-ID: <b301c9a1-7536-46c5-878e-7cd79e3a4742@kadam.mountain>
References: <20231020232332.55024-1-bergh.jonathan@gmail.com>
 <20231020232332.55024-3-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020232332.55024-3-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 01:23:29AM +0200, Jonathan Bergh wrote:
> Fixed the following checkpatch errors relating to whitespaces:
>  * extra whitespace after '~' symbol
>  * remove whitespace before/after parentheses for switch statement and
>    function parameters as well as after switch keyword
>  * ensure whitespace before '{' braces
>  * remove whitespace between function name and '(' parentheses
>  * ensure whitespace after ',' commas in parameter lists
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/staging/media/av7110/av7110_av.c | 28 ++++++++++++------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
> index af3845406626..482dfc548b16 100644
> --- a/drivers/staging/media/av7110/av7110_av.c
> +++ b/drivers/staging/media/av7110/av7110_av.c
> @@ -241,8 +241,8 @@ int av7110_pes_play(void *dest, struct dvb_ringbuffer *buf, int dlen)
>  		sync |= DVB_RINGBUFFER_PEEK(buf, 2) << 8;
>  		sync |= DVB_RINGBUFFER_PEEK(buf, 3);
>  
> -		if (((sync &~ 0x0f) == 0x000001e0) ||
> -		    ((sync &~ 0x1f) == 0x000001c0) ||
> +		if (((sync &~0x0f) == 0x000001e0) ||
> +		    ((sync &~0x1f) == 0x000001c0) ||

These should be:

	if (((sync & ~0x0f) == 0x000001e0) ||
	    ((sync & ~0x1f) == 0x000001c0) ||


>  		    (sync == 0x000001bd))
>  			break;
>  		printk("resync\n");

regards,
dan carpenter

