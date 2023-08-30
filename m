Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B578DF42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjH3THK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343808AbjH3RAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:00:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1A319A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:00:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so4605900b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693414845; x=1694019645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=paqr7IEUngLUmzTVJvkle5mzcucO5xLM3OCyOtioyC8=;
        b=SE+7XPT9i0QcBZZJAzF4Mdwsr9ZsBV3hrhZNJwftU6lHH2fjxLSgzXbzVlsNWcu03r
         Cch2Mx0pZOgNjOQkJj4amljs4i5Ox2LQ9C3ve6JMDlRW5uLUY0HmocQZz8TdJa8R9ucQ
         vbF52buatDeVFlZ42kI35Dzh7m/b7OBIwOFVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693414845; x=1694019645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paqr7IEUngLUmzTVJvkle5mzcucO5xLM3OCyOtioyC8=;
        b=gquH6UjDaFLhWod8yZpFMT+tzsf7vVRjZE1O4z2/p2LJ26FLyw/Ed05V8ZFAhVP2Y3
         n6zypAWbbFu8+ZQEIR5DZ5JTilEfQeN2rkZq/dfoLO/L3S3UYlekd8J8UOnaYXRNv+f+
         M7G0M6lp5NV7Tqc7GjIyxEC1HkoGJ5y070HkoU8tSPg5gxc1grtEp1mj9pGxr/Xjo6sI
         0WVGhkoyb2VZmKl8FB05WAshy9aP/rgdrJaYEnG7fWUxwBBzKy1I+rem4c2xvKtpqdwm
         WBbIoflrnWyg7JXESzDuRlO8cTChEwtXR0vX5VW2CkQUPsWDgr1rQ3eAlFf1kkBdVX5Q
         yiNA==
X-Gm-Message-State: AOJu0YypoWNDUYfec4XH3mPX89mqYCvaJRWxgk7rDgk9bJabG6Ly7Ylw
        eZYkRrvKxrMZPb8eL1bbDlPMrg==
X-Google-Smtp-Source: AGHT+IGXDbYwc6/HGX5fSa/1UeccMSrlYOvlNtS3oK4QC2iC/+wQWuDom34YcWAgVPT+FOM97fB4OA==
X-Received: by 2002:a05:6a20:f384:b0:138:5a28:e8cc with SMTP id qr4-20020a056a20f38400b001385a28e8ccmr3121257pzb.37.1693414844691;
        Wed, 30 Aug 2023 10:00:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a29-20020a056a001d1d00b0068c5bd3c3b4sm4748401pfx.206.2023.08.30.10.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:00:43 -0700 (PDT)
Date:   Wed, 30 Aug 2023 10:00:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
        Enlin Mu <enlin.mu@unisoc.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yunlong Xing <yunlong.xing@unisoc.com>,
        Yuxiao Zhang <yuxiaozhang@google.com>
Subject: Re: [GIT PULL] pstore updates for v6.6-rc1
Message-ID: <202308300957.BCD878259@keescook>
References: <CAHk-=wi_WxZ2dEsQR0-wDtYAh4sxVEQkU7HK5JSboVv7v7NwcQ@mail.gmail.com>
 <B085ADB4-4B8C-4998-BB33-DA67C45483E9@kernel.org>
 <CAHk-=wjRD_LnCbwSRM20Fg54xhrFBLwgO=X23bdconx3wKokxg@mail.gmail.com>
 <202308282035.5AFD431B@keescook>
 <CAHk-=whbqsYC4nDc7HpWEYo7EnA603T35jSP4om6HMWpVZSc_w@mail.gmail.com>
 <CAMj1kXGJCBj2JQFkUgd26H-abagcpO+7z_--6HV42VeaqCsEnQ@mail.gmail.com>
 <CAHk-=wgaY2+_KyqVpRS+MrO6Y7bXQp69odTu7JT3XSpdUsgS=g@mail.gmail.com>
 <CAMj1kXHde34XNukpbCcbScetWKzv9m7nX2WCw8-zspPKc5g4zw@mail.gmail.com>
 <20230830060506.GA1015@sol.localdomain>
 <CAMj1kXGZ11VS=Tr8i5oKsdXkAuGt+k5GLUvVqzrYBg6UEs=HQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGZ11VS=Tr8i5oKsdXkAuGt+k5GLUvVqzrYBg6UEs=HQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:48:48AM +0200, Ard Biesheuvel wrote:
> In any case, I'll rate limit the error so it doesn't clutter up the logs.

Great; thanks for looking at it!

A related issue I'm going to tackle is dealing with the risk of
ever-growing record counts for backends that don't treat their storage
as a circular buffer. (e.g. ramoops will overwrite the latest record
when it runs out of empty areas, but EFI will just keep on writing new
records.) It's clear we can't depend on userspace to do this clean-up.
I think pstore tossing the oldest records above a (configurable) limit
(say, 32) per dump type makes sense...

-- 
Kees Cook
