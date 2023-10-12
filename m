Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66C7C6A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjJLKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjJLKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:03:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6D9DC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:03:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4066692ad35so8260285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697105024; x=1697709824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=naHWFuzj+O/OIKMTuO8BWcLy46hs0izi1SX0wAhmMBk=;
        b=KRBCRkviNOwF3xGVLxjYmF41buHNuk7NLvtSEHHfO4iULqrtxfRi7R/ei+uvrXV7YF
         DEewHq3Ky+p2fqxQB1ZQWzllx9uEKpwwleu6h4XvyOT06HOS/nmNtbeU2R7bIHbIfq2m
         o/4qLrsQNIv35JbkelbiDGc9gsf1I4ir0dacJKmecTzDDqzwKUDtSblvsGMnd0t5OMTl
         M9badLkPJwJLFJkL5F6HVtXssmsXHaELzxXqe8UEaCakZsStixS4rETXM0s8pDo6FbZk
         0KsrybvQEUklsFs2zyV7N/SUAuhlyuVf4owzoHocePyicOqtXOUxUD2MPYUKDotLBdjG
         kmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105024; x=1697709824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naHWFuzj+O/OIKMTuO8BWcLy46hs0izi1SX0wAhmMBk=;
        b=PskxJJ5KSwZBYnIAj2qeKBmnDtYT+vo4adOgegO9dv6Zra8+80rtznFzWktk/TZnXY
         784o/VEi7I2+FyA4LrJg/VuTdF/arooqFtBzp4V+WOK8MR8t7Tmhy9MYMmpDDD11/ej4
         dQVpOGtyL4121osBP6+ThK2JPTZYXs5bg3SfxpKJd+V7Eh6XvSsluxYvmNylGfUeiU0t
         Dt88g3o2SscVqQ7RdkiNySNftMJLRYlkF6mWxmtj498hnAMubC5TLGwLeYG2i0I2stqe
         RbqOm6DqGlW6IdBNRTuhOMq4Wr4msWJadGgack5VaeinFsKkLs/1y2CTt4NrURvd7dw/
         eaQg==
X-Gm-Message-State: AOJu0YwvFeTzPm520ial1TB8zfnrLcNWsGe1ffjnd1DJRcQHj19CKPcu
        DkJWxVQjkuuWP4N/IN5SaR9IYQ==
X-Google-Smtp-Source: AGHT+IEx/ZN42k0swgkOxVEFQnusXfXt4HkdyCUOTkip0GsO1HHgMMPkxUmUkZ3E16VALcDrC8+Bcg==
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id o6-20020a05600c378600b00405359ac965mr21794161wmr.4.1697105023805;
        Thu, 12 Oct 2023 03:03:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n26-20020a05600c3b9a00b004068def185asm19559178wms.28.2023.10.12.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 03:03:43 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:03:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging/wlan-ng: remove strcpy() use in favor of
 strscpy()
Message-ID: <f0c12a00-ad9e-45b2-9cb2-7a84f4f10ef9@kadam.mountain>
References: <ZSeD1UojAgrsOh16@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSeD1UojAgrsOh16@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long email, because I have seen a bunch of people sending
strscpy() fixes and I want to explain how to write those correctly.

On Thu, Oct 12, 2023 at 08:27:49AM +0300, Calvince Otieno wrote:
> strncpy() function is actively dangerous to use since it may not
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is kind of an over statement.  This code has a " - 1" which
ensures that there is a NUL terminator.

> NUL-terminate the destination string, resulting in potential memory
> content exposures, unbounded reads, or crashes. strcpy() performs
> no bounds checking on the destination buffer.

This strcpy() sentence is unrelated to the commit.  No one was
considering using strcpy().

> The safe replacement
> is strscpy() which is specific to the Linux kernel.
> 

When you're writing the commit message, instead of talking about vague
theoretical stuff, what we want to know is the information specific to
the code you are checking.  In *this code* will the resulting string
be NUL terminated?  The other danger that strscpy() is designed to avoid
is a read overflow.  Is PRISM2_USB_FWFILE NULL terminated?  The
potential problem with strscpy() is that it does not pad the rest of the
string with zeroes and strncpy() will.  Maybe it looks something like
this:

	char buf[16];

	strscpy(buf, src, sizeof(buf));
	copy_to_user(user_pointer, buf, sizeof(buf));

If "src" is less than 15 characters long then the last characters are
a stack information leak.  So we need that analysis as well.

But then there is just the other regular string copy stuff you should
review as well.  How big is the dest buffer?  Where does s3plug[i].len
come from?  How do we know it's valid?

Sometimes these questions are quite difficult to answer, but it's not
clear from your commit message that you have tried to look for the
answers.  The question that is 100% necessary to answer is about padding
because we want to avoid introducing information leaks (security bugs).

> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2fw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
> index 5d03b2b9aab4..57a99dd12143 100644
> --- a/drivers/staging/wlan-ng/prism2fw.c
> +++ b/drivers/staging/wlan-ng/prism2fw.c
> @@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
>  
>  		if (j == -1) {	/* plug the filename */
>  			memset(dest, 0, s3plug[i].len);

Pay attention to this line.

> -			strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
> +			strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);

Alright, so your code has a bug where you kept the " - 1".  When you
introduce a bug, then you should always assume that other people have
probably made the same mistake.

The simplest approach is to do a:

	git grep strscpy | grep " - 1"

But the better approach would be to write a Smatch or Coverity check to
prevent these in the future.  I will add this to my lore todo list:

KTODO: write a Smatch check for strscpy(dest, src, len - 1);

regards,
dan carpenter

