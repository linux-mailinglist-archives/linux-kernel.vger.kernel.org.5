Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0681337D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573398AbjLNOrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjLNOrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:47:32 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C0115;
        Thu, 14 Dec 2023 06:47:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c701bd9a3cso2405347a12.0;
        Thu, 14 Dec 2023 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702565259; x=1703170059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sof1gkerYbku5v+b3jW5lmXu1VdUZ0QZgBhWQoXBGdc=;
        b=Kkp5xwOtxrYv10OSa5shZ21cAy928zSXM36Qw1ckljhPbPIGgnp5VIFhO04gf2ms49
         lwMhceJJEhjJesldb717PFdsOWpIMPPdTP7pPN1e0AQj8hdzZhfejl6BJw+pHQ1fV8nW
         13ERwX6ypl3x5UW42Tbdq2eZWa3nw2oNHW8zBBg/OMSDwdllQnuFQKUPWFZNtt7M1TnV
         NMlqxndxrnPYARe8XBCIo8SyCeHvyoRSPvYKpScYRvAIa07Tlg5ZK4nBwh41h/4G9f8i
         GwqfJdrwW8tYQHbSEuT735zHRaac1nhDvLPzqnWmcEwxtfDhG+VuJfhc2dSGSPqQBrBd
         IZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565259; x=1703170059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sof1gkerYbku5v+b3jW5lmXu1VdUZ0QZgBhWQoXBGdc=;
        b=me0jY1fgPwEfhYun08c2BU6iKeZuX/N5dkk8aeba+BMS3DuFLzI7zUgCoxrrVAxEMs
         7V0IcNcHpzmQqA6r4ch2r+XiVP2EdLUOIgCrHsTu9PYxDpgMW2bYstIT0NDkwyxOUehL
         fDxeVd3+KXGcyiKtawOOcWDDYZxISlfPAo9PBPFK13i0y3w/gSTJ8WnhjKS8GcKMjoXV
         rWfKYgjUwhlAxp/6ADwahrxMEVxj5mqvKN+hjF+kFYMVvuwXTqdeJF0WLseMAevy5E/i
         vpkrWOg/XKt65rhTLvynb7OKE8eaEVujBFf6QvN47k1oDVF0Dy+Pe45MnVxVfenFZ/KL
         sMgA==
X-Gm-Message-State: AOJu0YxQ3ira8sxeg1kp3tS8dfNj4pkwbcN1cwbpWvkekVzMuVc9QeBj
        061n226x2G/cl7+b8RxpPaBvE3GHAcE=
X-Google-Smtp-Source: AGHT+IHawo4hfwDtk3k2HkdR8iPUFBOsPm5v1cld8SI6HPoRP6qWJjkIxc29qlJ3dhzd2ztBxSDNcA==
X-Received: by 2002:a05:6a20:1445:b0:18c:14e2:ad8c with SMTP id a5-20020a056a20144500b0018c14e2ad8cmr4954016pzi.25.1702565259046;
        Thu, 14 Dec 2023 06:47:39 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b006bdd7cbcf98sm11901912pfo.182.2023.12.14.06.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:47:38 -0800 (PST)
Date:   Thu, 14 Dec 2023 22:47:34 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXsVhtkitzaJFUyl@rigel>
References: <ZXnU3tMYCc2Rw8Qv@rigel>
 <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
 <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
 <CAMRc=MfaHKKKNkXW0L1FPjCH4VvG22Vn9q8z9tupZCtCEKZU2g@mail.gmail.com>
 <ZXoO8B0N3S49GnvX@smile.fi.intel.com>
 <ZXpJueTnmtUIecCd@rigel>
 <ZXplMThBSD53UV0s@rigel>
 <CAMRc=MeZg0xg7ASA3x4PxCYymCmCEp0zZbUgGTCCzrjPaPZCag@mail.gmail.com>
 <ZXsSnTcnAsopYodl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsSnTcnAsopYodl@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:35:09PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 10:40:26AM +0100, Bartosz Golaszewski wrote:
>
> ...
>
> > > Opinions?
> >
> > Yeah, don't make it a kernel doc. It's a private structure, no need to
> > expose documentation for it in docs. Just use a regular comment - say
> > what it is and why it's here.
>
> I agree with Bart, make it plain comment if needed.
>

It is a plain comment in v2.

Cheers,
Kent.
