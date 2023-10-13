Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998987C8085
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJMIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJMIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:39:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3B107
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:39:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso19684205e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186350; x=1697791150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qdwDG1vEaBdbFUB+whbPTpmPJ6lJzSaWGwO7+4KqPYE=;
        b=rDSQXf17kwmVXFj40LZgFnpLKcC/W+av5f4nFTNWd5b9XMBrKsZH+GCkyi+heY39Sa
         bygivT+EnZ57M2puNlsGiYB5TyH3x591LhLEGweaoB5LFjtgZSM+kdS/fmHbWvN0jc7b
         vBiGKnGN4+0sDN2Df3t3A1Z/ujvdUyF9ukQszF6+TXprXAKqGGPqa6vu5Vg+q8CE+rsm
         nZU4q3RKAKWR1mQoFEbhhFHenRqpM1SiVotpeF8J5nZeirIY0XphPaHYBoW2UZc79wR1
         5szBQpoE7zZJ07G4dts+iYqgaBa/hiXYdthWclW1tHJCkzbdLUcljBnS2uWjuOXLxbUq
         r0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186350; x=1697791150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdwDG1vEaBdbFUB+whbPTpmPJ6lJzSaWGwO7+4KqPYE=;
        b=J2IZZBouSqaXAmwwywtgWN8BfD0FQG2jZ7XF+6XDwY8kAB+SRHi67LV2q2Bag7u7iU
         pBWP/G1Bi8/bFHg5lxTX21D3GpXzEPsjIAtmHu+I2vkvTLgl+Qn690jCEDEMKCT5pJEP
         RtrKBJ88niybaMWfmPuGR7e/Nd6nLTh5cKNCuDqWLIVKkG3k7+wSlt0nYcmJh/GvVEp2
         v8x8GWtqq3oijsKi582c+Rauz73u86SNTmGRmNgz74C79P4p2mdOIKdBqpMsAO09Xkni
         fxOBiVqCoqXDwDXESCLaanT2w5FHglbD+8X0L24R9W56YWGxE/Ja+aqIRk/CMn5IxB51
         k4ig==
X-Gm-Message-State: AOJu0YwOEYFLxT81BztHp2y1yfNkBVBk6rEsTJi+stw+QR/PHekPfTHx
        shdeT3i7M1FPSBrh9Cp/mfo/KQ==
X-Google-Smtp-Source: AGHT+IFpVpEtTclVCUangy6zX9KZjNxgy07inPEmD50g49TR1PiZoKifFM25RtoWuG8BSTEDS/n5Mw==
X-Received: by 2002:a05:600c:21d1:b0:405:3ae6:2413 with SMTP id x17-20020a05600c21d100b004053ae62413mr23348145wmj.25.1697186349795;
        Fri, 13 Oct 2023 01:39:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n25-20020a1c7219000000b003fe1c332810sm1901966wmc.33.2023.10.13.01.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:39:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:39:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging/wlan-ng: remove strcpy() use in favor of
 strscpy()
Message-ID: <ece235b1-b3b3-4803-8462-793e7c950f32@kadam.mountain>
References: <ZSf8VcH8JQ+L+Z/r@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSf8VcH8JQ+L+Z/r@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:01:57PM +0300, Calvince Otieno wrote:
> In response to the suggestion by Dan Carpenter on the initial patch,
> this patch provides a correct usage of the strscpy() in place of the
> current strcpy() implementation.
> 
> strscpy() copies characters from the source buffer to the destination
> buffer until one of the following conditions is met:
> 	- null-terminator ('\0') is encountered in the source string.
> 	- specified maximum length of the destination buffer is reached.
> 	- source buffer is exhausted.
> Example:
> 	char dest[11];
> 	const char *PRISM2_USB_FWFILE = "prism2_ru.fw";
> 	strscpy(dest, PRISM2_USB_FWFILE, sizeof(dest));
> 
> 	In this case, strscpy copies the first 10 characters of src into dest
> 	and add a null-terminator. dest will then contain "prism2_ru.f" with
> 	proper null-termination.
> 
> Since the specified length of the dest buffer is not derived from the
> dest buffer itself and rather form plug length (s3plug[i].len),
> replacing strcpy() with strscpy() is a better option because it will
> ensures that the destination string is always properly terminated.

Ok, the original code also ensured that the destination string was NUL
terminated.

Here is what I want this commit message to look like:
===
Checkpatch encourages everyone to use strscpy() instead of strncpy().
The advantages are that it always adds a NUL terminator and it prevents
a read overflow if the src string is not properly terminated.  One
potential disadvantage is that it doesn't zero pad the string like
strncpy() does.

In this code, strscpy() and strncpy() are equivalent and it does not
affect runtime behavior.  The string is zeroed on the line before
using memset().  The resulting string was always NUL terminated and
PRISM2_USB_FWFILE is string literal "prism2_ru.fw" so it's NUL
terminated.

However, even though using strscpy() does not fix any bugs, it's
still nicer and makes checkpatch happy.
===

> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---

v2:  Update the commit message.  Remove the " - 1" from the strcpy().

regards,
dan carpenter


