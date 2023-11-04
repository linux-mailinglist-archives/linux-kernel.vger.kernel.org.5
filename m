Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAB7E0EA5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjKDJlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:41:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A611BC
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:41:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso38100121fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699090860; x=1699695660; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd+JVCBsQTb3vo5vpK8dzy/SOidwl06tgE7kBJob/WI=;
        b=Ixg0tBHhZGHRasPzGvGNsJYRBaECi8v4Th59cRq3xJCmnqyfZFcoThgtO1RTnIKZKB
         XkTSQdn3iq3BeC0hJedK17XGw+LFvJjX4p4YMPMn0XAcAC7rBYYdgqSNBsQMC0y4bIif
         YrOiXN5YFPRqDrfYoVnVtacW0awEI3xPrcV1KxEBXDDIXcYT+RUyJ7ToRIIFWtxkGAXj
         FmYtZSYywI1cvxjABxb7SMP4Hv/cdeER6bHggHJHJfth/xIQLSBZygBg0rAijzFLztBB
         EU8tzGg/mFBe7qx5VPZL0Om4M9Sl9HPczVu6yB8iOuPm4OOkFsb5ndb3JyN4Opol8eWH
         9w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699090860; x=1699695660;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd+JVCBsQTb3vo5vpK8dzy/SOidwl06tgE7kBJob/WI=;
        b=DyUARpQhj9HiAwZ57VnyY4IjKkaM4yPVlgUowxCDG85d4ZniLf8PHHZXl2bLEHMcYz
         ulSKXA2J7u2kjfKfi8Rn01zxUEPGxQthQ0xJ04jcUjvZdslvD8dAEjr7myILKA53+LhI
         OjwZKWLceGe8GNRUrTAvwWKtuA9BAPqtfy0YLXFpHq5nm/MoquG1Qh/CzkjRHXg6CGHN
         Ay/3WPd+EsDX9WYppRfJ7bwqLYQ0D4wA8fim4f4ImPdhfPxca8lWUykARODaN6cm8lQL
         MMPebWEvE2PRFd/Y5RB2knzZvKrG4070ToG5KWVJI7kqzo76RSrNamBvnOKqYrWLW2bT
         w9xw==
X-Gm-Message-State: AOJu0Yw5ejLiVmug2S0wzQyCGBXXLUbt9dsYVr8cEuyTMrZeM9mb7y3v
        ZZ65KE7aPJrumSxU5AfvantUeDQi/zxsiQ==
X-Google-Smtp-Source: AGHT+IEftJIWv2xy/HN2RA9SVRF5hUk6vRO0pWpf8fpAzta6q5Z+w4fXdaPctPYCcZ7AS+b98vLE2Q==
X-Received: by 2002:a2e:7a17:0:b0:2c2:a337:5ea with SMTP id v23-20020a2e7a17000000b002c2a33705eamr19126456ljc.27.1699090860201;
        Sat, 04 Nov 2023 02:41:00 -0700 (PDT)
Received: from smtpclient.apple ([77.137.74.70])
        by smtp.gmail.com with ESMTPSA id fb14-20020a05600c520e00b0040841e79715sm5050983wmb.27.2023.11.04.02.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:40:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
Date:   Sat, 4 Nov 2023 11:40:48 +0200
Cc:     Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
To:     Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2023, at 11:34 AM, Anton Ivanov =
<anton.ivanov@kot-begemot.co.uk> wrote:
>=20
> On 04/11/2023 09:25, Nadav Amit wrote:
>>=20
>> I was reading (again) the x86 C macro of =E2=80=9Calternative()=E2=80=9D=
 and I was a bit
>> surprised it does clobber the flags (=E2=80=9Ccc=E2=80=9D) as a =
precaution.
>>=20
>>  #define alternative(oldinstr, newinstr, ft_flags) \
>> 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags) : =
: : "memory")
>>=20
>> Actually there seems to be only one instance of problematic cases - =
in um/32-bit:
>>=20
>>  #define mb() alternative("lock; addl $0,0(%%esp)", "mfence", =
X86_FEATURE_XMM2)
>>  #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", =
X86_FEATURE_XMM2)
>>  #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", =
X86_FEATURE_XMM)
>>=20
>> Presumably, if XMM or XMM2 are not supported, there would be =
instances where addl
>> would be able to change eflags arithmetic flags without the compiler =
being aware
>> of it.
>>=20
>> As it only affects 32-bit Linux UM - I don=E2=80=99t easily have an =
environment to test
>> the fix. An alternative (word-pun unintended) is to add =E2=80=9Ccc=E2=80=
=9D as a precaution
>> to the alternative macro.
>>=20
> Application alternatives in um is presently a NOP. It always uses the =
"blunt and heavy instrument" - the most conservative option.
>=20
> It is on the TODO list.

Thanks for the quick response. But I don=E2=80=99t see how it prevents =
the problem
(it actually makes it worse - affecting XMM/XMM2 CPUs as well) since you
keep the =E2=80=9Clock; addl $0,0(%%esp)=E2=80=9D in the running code, =
affecting eflags
without telling the compiler that you do so through a =E2=80=9Ccc=E2=80=9D=
 clobber.

