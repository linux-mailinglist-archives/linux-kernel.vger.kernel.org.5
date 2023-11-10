Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E97E8119
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjKJSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjKJSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:22:58 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39EA43F1D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:19:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so3926195a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699636780; x=1700241580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng5PxaHEUakeDJDrRTqAaFPDP7NquJ67qdCuJTYti9U=;
        b=P1w6LNW215qlv/aq0OAY7cGFT/JZZ/sKP1yfeLZ88yuwIH0RUJ8NklJZjss5bKvmH3
         9uB9D/SuX4/BjF97Vc+TyCBKmNEwqxgE9/lDn+ntZ+rbDz+YWgtvrwFzUbnYkT6eMc1/
         /OM1WeSPw5j4Y8QI2NUYTrTkRkR60o2Gn2xac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699636780; x=1700241580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ng5PxaHEUakeDJDrRTqAaFPDP7NquJ67qdCuJTYti9U=;
        b=jp7wGVGnku/Wx7/9YKB6P1gF2vkGJgC845jQRtEoDr+Cns8Ho1xuGODEIY6GVyeKx3
         5kKVYcDsbifyG1xfKB2Vi37jOYydYH/oHMWx72EpLbEYXw4Y+ZVK93jLHwWTaMxEGAU5
         vT6Y4ErCSr1Po8zkPovqxgBaSBvP5RstkEPvb21RGmVBzADZM5l0HaNwTEA7KSwZCv2p
         vodtSHlMyqeHdd8aDdFiIZVzj65O5c0KhDLi4hb2/PU7f4WkDO+r5IIJAFgQuPY+zGAq
         aPgjt5bq7czGa+VOGqOIpc67T10Fl6B6wFwJJiIBW6mryL8Ut5Ro9XylY/qkFKokUgoK
         f24w==
X-Gm-Message-State: AOJu0YzaerGjtDIF03Uq6f1FcZVfz1lfylw2WMC9wLqICe3XmklZiePe
        uDxMd1iR79Na7quxgoW+UnP4VWG2hXkss2oLXf4YDWlW
X-Google-Smtp-Source: AGHT+IGSxDotoYlhaj849V7CplZ4mgYPBbcXvyzt59Pb7iGBj2qMYWMtkCByQnmAcIlk0Lt8oWonrQ==
X-Received: by 2002:aa7:d387:0:b0:53d:a1c0:410f with SMTP id x7-20020aa7d387000000b0053da1c0410fmr15688edq.2.1699636779926;
        Fri, 10 Nov 2023 09:19:39 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7cb94000000b00543597cd190sm1350083edt.47.2023.11.10.09.19.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:19:39 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so3925022a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:19:39 -0800 (PST)
X-Received: by 2002:a05:6402:2805:b0:544:a26c:804c with SMTP id
 h5-20020a056402280500b00544a26c804cmr9296ede.16.1699636778871; Fri, 10 Nov
 2023 09:19:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
In-Reply-To: <CAJvTdKn-xtmin9OjnzHg8wy4PM8Lc3Per=3y3UWORhjdroYP3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 09:19:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
Message-ID: <CAHk-=wjvJ44a9Z=tkR2o-heQ4XLp0sgynDOhe6JH2fgg=MMMXA@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat for Linux-6.7
To:     Len Brown <lenb@kernel.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 at 21:03, Len Brown <lenb@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

Even though this is a user-space tool, not kernel code per se, I
really want a signed tag..

And yes, I'm trying to get to that point even for kernel.org accounts. Please?

              Linus
