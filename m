Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5457A874F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjITOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbjITOkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:40:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202130DB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:39:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fb98745c1so5267800b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695220741; x=1695825541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVjsOZJ8bggozwjwCYWOh6I0B4C7rlCVK2zz6fw/jxM=;
        b=oLhZUBgxnlIIUZPa957EPD5fIoTDDgXtpuaaxFvro0mvz3v1gI8FAo4R+RXDGbWA0W
         Y1UvZ1QA5G08pZbDNK/Aek+0jZMYAO8HpZeSIW2nGSJRrBVSEEHoCgv2g/0I8+iJ4iK8
         I3Ig0LTD3/hG+BukCYaNPvMK7/ee8yk7tw7rJtJe2T1Ga/swRSDef4Ix+fP16t9pHT44
         d7Np6Bf7pc3a4VKkTnBsOPdR5KcGnTU6u9WNeckZSZb8kow/5NAKLrYr1eq+eHWmQEck
         mXeeU11NKZRpzSNk7b2Ghvb67T/HBbnQh045Lju/+DZ6RIWQNGpUcGL4tJUSxP0lI3zW
         T/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220741; x=1695825541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVjsOZJ8bggozwjwCYWOh6I0B4C7rlCVK2zz6fw/jxM=;
        b=Oj6nYtHLOMaq7c0/Yy9b8fsd4YQ1RmxevT/tfynM+hh90RPGZCD/u2epeArTsFSLE4
         SOSeBlD8DlstoRqSqx7/x/Uz+2jWdKrhl5vn5P/kxphkJQp2O4vBYfeJA6+C2q6AMePv
         zaxbuhbHzmT4IcBpdRq4p85JZkEx2I2FpVulJbQGYg9zrdUWrFhmIIIKGno1RwH4CVtS
         l5unD+yQDnYRQm0sRnGkfHmR3j7cakSG5RkfJYleSg1jyjVACDfVR3zbjgrlSMjdZdGf
         sT5jPVNiD98Xz19eTrX+JSyYOrTugEEfyYjoPzW1sh5htbx0rr7G2oKBNcI5mVUsqLdz
         aL6w==
X-Gm-Message-State: AOJu0YzpinFjSYIXm9BOjetUNYAsoXcyX+/62IuMfp0eyY3PjA+/4W08
        lUVjuFUS5f7+2utLGf7WsXMcwcInxCOn/hY/6oVMfQ==
X-Google-Smtp-Source: AGHT+IEr2Lac4PW5MEs8w2glHD2rv5IneEoO2/iHMRaS9AnyeCZ7nvHVBgJDCdg7GwNcp3Cwv5ypWCr2gQmimN6JYbQ=
X-Received: by 2002:a17:90b:38d2:b0:271:bc40:5097 with SMTP id
 nn18-20020a17090b38d200b00271bc405097mr2554985pjb.30.1695220741330; Wed, 20
 Sep 2023 07:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
 <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20230920-8503c6365655d3ef3dadfd53@fedora>
In-Reply-To: <20230920-8503c6365655d3ef3dadfd53@fedora>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 20 Sep 2023 20:08:49 +0530
Message-ID: <CAK9=C2WWzc_M49-S+Gi509a6-gk3-89sAZn-ZCRhsQc4JwUpoQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 6:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Sep 20, 2023 at 08:40:07PM +0800, Inochi Amaoto wrote:
> > >On 20/09/2023 14:15, Inochi Amaoto wrote:
> > >>> On 20/09/2023 08:39, Chen Wang wrote:
> > >>>> From: Inochi Amaoto <inochiama@outlook.com>
> > >>>>
> > >>>> Add two new compatible string formatted like `C9xx-clint-xxx` to i=
dentify
> > >>>> the timer and ipi device separately, and do not allow c900-clint a=
s the
> > >>>
> > >>> Why?
> > >>>
> > >>
> > >> If use the same compatible, SBI will process this twice in both ipi =
and
> > >> timer, use different compatible will allow SBI to treat these as dif=
ferent.
> > >> AFAIK, the aclint in SBI use the same concepts, which make hard to u=
se the
> > >> second register range. I have explained in another response.
> > >
> > >What is a SBI? Linux driver? If so, why some intermediate Linux driver
> > >choice should affect bindings?
> > >Best regards,
> > >Krzysztof
> > >
> >
> > SBI (Supervisor Binary Interface) is defined by riscv, which is an inte=
rface
> > between the Supervisor Execution Environment (SEE) and the supervisor. =
The
> > detailed documentation can be found in [1].
> >
> > The implement of SBI needs fdt info of the platform, which is provided =
by
> > kernel. So we need a dt-bindings for these devices, and these will be
> > processed by SBI.
> >
> > [1] https://github.com/riscv-non-isa/riscv-sbi-doc
>
> Yeah, this is the unfortunate problem of half-baked bindings (IMO)
> ending up in OpenSBI (which likely means they also ended up in QEMU).
> This T-Head stuff is coming across our (metaphorical) desks, so we are
> obviously going to try to do things correctly. I may end up speaking to
> Anup later today, if I do I will point him at this thread (if he hasn't
> seen it already).

RISC-V ACLINT is one of those unfortunate non-ISA specs (like
SiFive PLIC) which is implemented by various organizations but
not officially ratified by RVI.

The SiFive CLINT has flexibility related limitations which makes it
not useful for multi-socket and mult-die systems. The SiFive CLINT
is also not useful for systems with AIA because with AIA M-mode has
a new way of doing M-mode IPIs. Due to this reasons, the RISC-V
ACLINT spec breaks down traditional SiFive CLINT into two separate
devices namely mtimer and mswi. This allows platforms to implement
only the required set of devices. The mtimer as defined by the ACLINT
specifications also allows platforms to place mtime and mtimecmp
registers at different locations.

Refer, https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc

We need a separate DT bindings document for ACLINT MTIMER
and ACLINT MSWI because these are separate devices. The
Sophgo sg2042 SoC should add their implementation specific
compatible strings in this document.

Regards,
Anup
