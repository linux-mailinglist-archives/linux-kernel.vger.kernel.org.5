Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB917DA84A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjJ1RrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 13:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJ1RrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 13:47:03 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3B7DE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 10:47:01 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7e5dc8573so25784847b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1698515220; x=1699120020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rGRHJq5XxBk3mPS491SXCV9EYeHu4LPb1hhgXysvmzc=;
        b=cqr5Tyy/U6LMwaujct7t1hsFvNew3e2ra5J8MjRE1W9/bcK0EaDZ0SKQi0MBBd3bFf
         Y62j9eori0MEgXtgfE/FLxKXWr3cA5P1h2i3aOiz5h4M/VlTr7J3+RcGzblLvQICnvyj
         z9vYhDMa/sPewfCIreUSYW9TSYH+IZDS4PTW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698515220; x=1699120020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGRHJq5XxBk3mPS491SXCV9EYeHu4LPb1hhgXysvmzc=;
        b=ICU6QAh/xp/VFF6tjzZymNUyZN37M6NViFKsIsyPJ1+2wh5mEh9vYf3h4+3uPH9IOF
         /8Gsy9pE9JA56yO4gsu+yp0Cs8IXsmO/e/xIVQfrnS1A51Ofdj7CSpyfuUWNEfo55gDP
         6N6SPY9p5UF+0lgkRK6LlWgsidcBZUVFcnDMPRAuRZwwtJMdYBQEJfQ3mNrn1sDOI904
         dNsuZSNi0yatoPZ56tkmLWqAcw+jpscYZYMTrxnnKHqtcAHCHTSSTw3IW8jlBqWwv9p+
         DDa1fpVqNG2wYbSFHUDWZDk8JIW/cU+APU8JHqOeOnJGfeAmkOLd4GNYxrek48egO1L5
         jDGw==
X-Gm-Message-State: AOJu0Yxkg8SbG731Zou4mT1O+jvpvU/kecZIQwLl+yc0ip/OZPyu3MZ4
        iOIeQl8L848Tv0SY/fKz4c5Bvth1Al2lvNKHoN5Z8g==
X-Google-Smtp-Source: AGHT+IGXRjNnhhdqaoipWk6VZ5hrfdtVVPNu/L9nJPUPTvZEKsMQnpsl+PWfx97fU2XdNXezazlJUw==
X-Received: by 2002:a25:c78a:0:b0:da1:13b7:8a87 with SMTP id w132-20020a25c78a000000b00da113b78a87mr4794254ybe.15.1698515220216;
        Sat, 28 Oct 2023 10:47:00 -0700 (PDT)
Received: from bill-the-cat (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com. [2603:6081:7b00:6400::13d])
        by smtp.gmail.com with ESMTPSA id m14-20020a0ce8ce000000b0066d11743b3esm1797690qvo.34.2023.10.28.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 10:46:59 -0700 (PDT)
Date:   Sat, 28 Oct 2023 13:46:56 -0400
From:   Tom Rini <trini@konsulko.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH RESEND] get_maintainer: add email addresses from dts files
Message-ID: <20231028174656.GA3310672@bill-the-cat>
References: <829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 01:17:45PM -0800, Joe Perches wrote:

> From: Shawn Guo <shawnguo@kernel.org>
> 
> MAINTAINER file will get bloated quickly if individual section entry
> is created for each .dts/.dtsi file.  Add the email address from dts
> files to get_maintainer output for saving unnecessary patching on
> MAINTAINER file.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Joe Perches <joe@perches.com>
> ---
> 
> Hey Andrew.  This was originally sent a year and a half ago.
> 
> Link: https://lore.kernel.org/all/20210809080204.8381-1-shawnguo@kernel.org/
> 
> Please pick this up.  Thanks.
> 
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 2075db0c08b8..15aa8f947f4b 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -436,7 +436,7 @@ sub maintainers_in_file {
>  
>      return if ($file =~ m@\bMAINTAINERS$@);
>  
> -    if (-f $file && ($email_file_emails || $file =~ /\.yaml$/)) {
> +    if (-f $file && ($email_file_emails || $file =~ /\.(?:yaml|dtsi?)$/)) {
>  	open(my $f, '<', $file)
>  	    or die "$P: Can't open $file: $!\n";
>  	my $text = do { local($/) ; <$f> };
> 

This seems to have not been picked up, and would be useful for the tool
to have both for the kernel itself and other projects which also use it
and MAINTAINERS files. Can this please be picked up? Thanks!

-- 
Tom
