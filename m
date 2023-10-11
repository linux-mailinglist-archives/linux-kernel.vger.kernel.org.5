Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD867C5DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjJKTkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjJKTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:40:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C824F90
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:40:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso30487066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697053228; x=1697658028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVl38Ae3MA1xvwdhRWvEEbB9B8NTnsPXuOCuz2mqvUg=;
        b=SvshN5Em05dtrahJYtzGtQNyKD7hPvvOZrzChC1GVBDNoGMKpYAvV/uKWe5wanEWw/
         dTtIWaIIv9bw1+EQ/OMeRWsyD8YQL0y8EDtvOkUOFIvcSL3T+SDr/prKYv4O2bQ6EIWj
         zPErdAUUB7bkB+moVpMwz/QBqdAsrxg0JSTEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697053228; x=1697658028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVl38Ae3MA1xvwdhRWvEEbB9B8NTnsPXuOCuz2mqvUg=;
        b=OLfmeJ8sgYaBvCDoYZozSNKr2Q/m2PIyY6GllIZgsMWb6C7BCT3XwpjaUbQAyrSNBh
         bLrdC0KW5pVF6hsqKgR+9Ed8amU6VKtia91W2YUmLjLNww+5BVVMCsOj4VFI+WMEcdBJ
         3QWFbL0E0j3VjADdZQmnl+tq4CdQBs8erfA1GyC/RD+7tfpf0wHUuq540qGMYH55mscK
         o0vm1f2ATO4JEqa4/foN9ZN7X2ACGHOvRwEAAa2VqCYQyKr1rSiXyCmnucKQtBxZZhyu
         T+r6BxeKtTsic9Ft5sx3qM0lBT6crXqwJGsiVG43c/H96I2hsqT7rhzMKTAjFGmR1VSf
         uCAg==
X-Gm-Message-State: AOJu0Yxq36JHro3fxLPzn+y1F8vlHIPIqhSMMKqkRJNyCkb3laUK1XIK
        gBRiqsWguR0EmmB507s3lidu/DLV+NbPUZJr094IiFyf
X-Google-Smtp-Source: AGHT+IHgBNAoyNblyP+SiA3K64Rz3WM4ClYjmtmDCxfPO4mPfjI1fubBtBYasXJ1n0tUpNFP5pg5Ng==
X-Received: by 2002:a17:906:738b:b0:9ae:3f7a:f777 with SMTP id f11-20020a170906738b00b009ae3f7af777mr21111261ejl.9.1697053228021;
        Wed, 11 Oct 2023 12:40:28 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709064a4100b009b65a698c5csm10288962ejv.57.2023.10.11.12.40.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 12:40:26 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso494429a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:40:26 -0700 (PDT)
X-Received: by 2002:a05:6402:1812:b0:52c:e607:3866 with SMTP id
 g18-20020a056402181200b0052ce6073866mr19918632edy.32.1697053226359; Wed, 11
 Oct 2023 12:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <CAFULd4Y8NSArDqH=VMy8F97eNosUUGxrBMEyHH=MytjUBSCmjg@mail.gmail.com>
 <CAHk-=whMr8V_q3dq4iS0dpx4Nssu+aYWz+mA36p2ykA+OXTjXA@mail.gmail.com>
 <CAFULd4Z-F0mFov5zhLya=OfPnQx=oOHkyLqs_UVTbQaWjk7AMA@mail.gmail.com> <CAFULd4bPPRmdwUCehKhx=cSVAK8r+6+7cEL24WdUNCPO3Y5Rbw@mail.gmail.com>
In-Reply-To: <CAFULd4bPPRmdwUCehKhx=cSVAK8r+6+7cEL24WdUNCPO3Y5Rbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Oct 2023 12:40:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSn8fY4xF-=Bz=qPcbmT_Yzzb4jvvtMBuNQksk94Y=dw@mail.gmail.com>
Message-ID: <CAHk-=wiSn8fY4xF-=Bz=qPcbmT_Yzzb4jvvtMBuNQksk94Y=dw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 00:45, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> In fact, rdgsbase is available only for 64-bit targets.

Not even all 64-bit targets. That's why I did that ALTERNATIVE() thing
with X86_FEATURE_FSGSBASE, which uses the kernel instruction
re-writing.

So that suggested asm of mine defaults to loading the value from
memory through %gs, but with X86_FEATURE_FSGSBASE it gets rewritten to
use rdgsbase.

And again - I'm not sure it's any faster, but it's _potentially_
certainly better in that it doesn't use the cache-line.

           Linus
