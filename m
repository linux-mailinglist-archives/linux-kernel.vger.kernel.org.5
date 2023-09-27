Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4C7B0F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjI0XFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI0XFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:05:49 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E771BF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:05:48 -0700 (PDT)
Received: from [127.0.0.1] ([98.35.210.218])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38RN562E2996730
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 27 Sep 2023 16:05:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38RN562E2996730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1695855907;
        bh=HXgJLMzftVenTX7snv+76PmkqXCNjUpaVfDOYZ0nsrw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WOtK88Ds78WFSPQRu9p/Pkq2Igt/O18DjyosGJH4gksKyxg0Ub4XVL7lIeRccXKZB
         r0E/Xt6OPSj89VibpiJ2SgYt2VOy5+9S+i2NKio7B7BnM2qW0mNPvkSouuJe+OU8ty
         HV3woems6JYjuBgezlCtg7Wf97rGzjBzWhEfzti/gBboZKinKGOfw8hF8iuRElJ3IR
         zO4xEi6PsoLWnIgIwc/8dHuRrhrpf4rjUPzIyxt6s+ORKAcNSI2K2LCT9tOL0qFf+5
         Of3wZN0rLHYD44XOtC77P8pXUp1HyVgISyr5IsffqbsSTxheAKg/rmiHirOreK2fv/
         g2HfsBOm0OwOA==
Date:   Wed, 27 Sep 2023 16:05:04 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: compile boot code with -std=gnu11 too
User-Agent: K-9 Mail for Android
In-Reply-To: <2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183>
References: <2058761e-12a4-4b2f-9690-3c3c1c9902a5@p183>
Message-ID: <6580AF56-86B2-4C2B-BC28-8100ADE1C345@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 27, 2023 8:42:11 AM PDT, Alexey Dobriyan <adobriyan@gmail=2Eco=
m> wrote:
>Use -std=3Dgnu11 for consistency with main kernel code=2E
>
>It doesn't seem to change anything in vmlinux=2E
>
>Signed-off-by: Alexey Dobriyan <adobriyan@gmail=2Ecom>
>---
>
> arch/x86/Makefile |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- a/arch/x86/Makefile
>+++ b/arch/x86/Makefile
>@@ -43,7 +43,7 @@ endif
>=20
> # How to compile the 16-bit code=2E  Note we always compile for -march=
=3Di386;
> # that way we can complain to the user if the CPU is insufficient=2E
>-REALMODE_CFLAGS	:=3D -m16 -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_=
EXPORTS \
>+REALMODE_CFLAGS	:=3D -std=3Dgnu11 -m16 -g -Os -DDISABLE_BRANCH_PROFILING=
 -D__DISABLE_EXPORTS \
> 		   -Wall -Wstrict-prototypes -march=3Di386 -mregparm=3D3 \
> 		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
> 		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=3Dnone)

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
