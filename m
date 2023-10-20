Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2817F7D099D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376438AbjJTHid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376317AbjJTHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:38:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BEF91
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:38:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so3870485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697787507; x=1698392307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/KThKo4jmYx+C7nHHaCwoPbIW3yJzTHN31FdSecDUqs=;
        b=vlTk2avxHFGhBdY6WTwWDpNMp/iLNi9GnCo0yYbzFxEkuxGTRtnOenPJmKwHgwx1Il
         yI4NBApvD0oLsY+gWfzSsDpDGCCIRy1GMQ8zSQvbbYyCUvjEhGKqPuoQjCDxC995iwZd
         eXoBiY2qp8cb2bjSOYZdmPZtLo2E5e8xLap6srPaH0UynMOCWlx4C2BQ02mKVqoRe7p+
         s3SLycjAK6kd6aVzf9W7Qg3m+9WTH6Wwzksu/Zh3iIyBizX18GAHa3KP71lt+T5BHwf+
         VLwMYY85ncvuTsusVAD263jFtqu6zRylr7kAMW+H4BooaYzdXyY72woSxnb79MrgwwG4
         0jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787507; x=1698392307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/KThKo4jmYx+C7nHHaCwoPbIW3yJzTHN31FdSecDUqs=;
        b=lZIOHZm0NCG4tbKVmuGeAK9+Wvbz9tFVrE3lE6ht5ule/S+YpLMtN6Yy38sfG+/Q+p
         lh9oSd36fm4nHoZjWd5k24C52sQTr4BM30QQkw2fiUJwpAhUwAoAnsa2rPm/2iYQv1/8
         sz68C+1syoLWF0mei3BJZiNpprc1aSFJcAx9TkxeJ1kuyNs69M91s1JBIUy16oQRJEH3
         wmzInUkf+mCPI0QYUCOF7kyi5uu2QqCVYF5To9a0al7DGhv56v8WmC4F8cz1IEwqlIwx
         yQi1YEfcBTSx1Mzg1jV1GnzbVjxdHeOEv9ZshQmLS/XSSHW6osaDg1bFEi5QbO6RW86v
         1I8Q==
X-Gm-Message-State: AOJu0YwTt/WnHsBkaUYoS1jBVZSDPIvJEk4j2sl9jHska8gtB5kzf1e+
        TtOxRc5iM8np72CCgWy2hoFnj8iOHq6oa4ekpWI=
X-Google-Smtp-Source: AGHT+IGYvrLjEn/0tZV4BoVeorM/lJEq8yk5rw3LmUxqDDNSi0iUcz3I5+xYYfWFtT8WkV4Z9Yac0g==
X-Received: by 2002:a05:600c:3b84:b0:3f6:9634:c8d6 with SMTP id n4-20020a05600c3b8400b003f69634c8d6mr874813wms.18.1697787507093;
        Fri, 20 Oct 2023 00:38:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x10-20020a05600c21ca00b003feea62440bsm1451580wmj.43.2023.10.20.00.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 00:38:26 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:38:23 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     kenechukwu maduechesi <maduechesik@gmail.com>
Cc:     shreeya.patel23498@gmail.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rts5208: Add parenthesis to macro arguments
Message-ID: <3371515f-aaac-4449-83af-e7f10d60eae3@kadam.mountain>
References: <20231020065439.GA3579@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020065439.GA3579@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 11:54:39PM -0700, kenechukwu maduechesi wrote:
> Checkpatch suggests using (reg) and (host) instead of reg and host
> 
> The use of parenthesis in the macro argument '(reg)' ensures proper
> precedence and resolves potential issues that may arise due to the
> surrounding code context. This modification adheres to the recommended
> coding style and improves the readability or maintainability of the
> code.
> 
> Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
> index 2e101da83220..7d3373797eb4 100644
> --- a/drivers/staging/rts5208/rtsx.h
> +++ b/drivers/staging/rts5208/rtsx.h
> @@ -39,17 +39,17 @@
>  /*
>   * macros for easy use
>   */
> -#define rtsx_writel(chip, reg, value) \
> +#define rtsx_writel(chip, (reg), value) \

This will break the build.  But also someone already fixed this in
linux-next.

>  	iowrite32(value, (chip)->rtsx->remap_addr + reg)

regards,
dan carpenter

