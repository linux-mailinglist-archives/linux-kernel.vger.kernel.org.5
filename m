Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929CF7D59B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjJXR2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:28:52 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC6128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:28:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0ecb9a075so32504285ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698168530; x=1698773330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5+vnHpkaeDGkL4KU8yjQESLCmsVuX8ylTfakxaPTtU=;
        b=WSiqAtdN8PzA+kCu8lcgn/moDnuGBVsVifULPm264T9xl2ixUN+CEzB/G8SfDDTV8K
         pM/NokKvdXpktq5+3wT1s+7bXFZ5Wz1n07B/3QbktvU3O8cA6e2u08kUIjzMEkJ+g75q
         FuGmP5bOxY51HjMomrGGTqXaam5F5M+pWfakg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698168530; x=1698773330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5+vnHpkaeDGkL4KU8yjQESLCmsVuX8ylTfakxaPTtU=;
        b=R6HNAWrP+35GvNne8x7y5dyOUHyQa7j4ncBQQnhrH7g18N4C69b/zb99cot2BAo9VB
         RVv3CjlU5q9rS8xt9DMRA1kMlaKaTLAxJdL3KJUqTF4aUZmOOWUZ0szBdAXI7Xl/6NI/
         mdry+KRMGCgVFF9enugvfuYIwcTE0chIQRYaeECC662CjMn174aqY1Rg4HFCu7vkPJxV
         JScxvtm+yblHFxed/KauFCbhGaOhM2j4vjvFxqj8LYv6C6WBQiU1Q1dYHckpYsXqn3MU
         kGzWpytyVK7v6Y6D+bW//OWSG8i01cCRq0PofI+A7VN3tglFl2avdeq56B+q2XzgQoBW
         4PGg==
X-Gm-Message-State: AOJu0Yyv49lBiugDtbm6Ac+u2ZdVsMgj3cgb4xvFiNHPgKPOFjn9V6Q2
        jyL6wz0rnfmhkyIa96+G8iPXQQ==
X-Google-Smtp-Source: AGHT+IFQks8f7taxe/T8lJX4HzjJyBwLcpA05m1ZgzLrUenz+1s8G0m8uqUjTVMkOtGRSqaCkc2qWw==
X-Received: by 2002:a17:902:ce88:b0:1ca:59bf:6cc9 with SMTP id f8-20020a170902ce8800b001ca59bf6cc9mr13033744plg.57.1698168529819;
        Tue, 24 Oct 2023 10:28:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001bb1f0605b2sm7650806plf.214.2023.10.24.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 10:28:49 -0700 (PDT)
Date:   Tue, 24 Oct 2023 10:28:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/ctcm: replace deprecated strncpy with strscpy
Message-ID: <202310241027.516C46AA@keescook>
References: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:35:07PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chid to be NUL-terminated based on its use with format
> strings:
> 
> 	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO, "%s(%s) %s", CTCM_FUNTAIL,
> 			chid, ok ? "OK" : "failed");
> 
> Moreover, NUL-padding is not required as it is _only_ used in this one
> instance with a format string.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> We can also drop the +1 from chid's declaration as we no longer need to
> be cautious about leaving a spot for a NUL-byte. Let's use the more
> idiomatic strscpy usage of (dest, src, sizeof(dest)) as this more
> closely ties the destination buffer to the length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, all looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
