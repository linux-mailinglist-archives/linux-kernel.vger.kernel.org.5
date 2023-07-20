Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695775B7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGTTYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjGTTYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:24:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC13171E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:24:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-666ecb21f86so1014166b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881071; x=1690485871;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Sg8ZUof4litkbVkI93lEgkMdRKQns2dkKRJ6nxytjc=;
        b=GXAmdxeabjwJMPspdMR69ghzU9reliykQR+pO/kFRAHXyaOq2QQWLw2SMbQucFHQV9
         /fVbvWAQ41BINMQURi6E8uv7Nk0OOdnJwRKbmoqdMqtNPWrwXoHgNahv4Sudfu2g967V
         xeSxU0X9vGL+q/Ku+GHYhzRbpjvOi33+dJfyPh6uaTDs1OVKMzpqJ4avBt+prjKpSR/a
         GUUlgRt5y+zwXBi96MzfUvC0HL0GiNAVooaRoJN2FivNvRc29hkgPlOvufo5a1FLju84
         HxxNHZEmaz67C9GqWsm7Y/F+qpZpIRxYDpKT2dJZ9ctLUlh1l+p5Sw6EcGOtVyg99YMW
         R8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881071; x=1690485871;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:date:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Sg8ZUof4litkbVkI93lEgkMdRKQns2dkKRJ6nxytjc=;
        b=V5Ai22VQmYXk8fcdF5jpqorH3AexFnHVXSPDBHTLRbnEiAYv0bPwJXZModAR2Y32q3
         jOY2sDYHGtLBNlrGwQ6mRCgpudESThlAyQ20qmsiVQk7hqc4faoUSby80LzwjccSL3ed
         lOuISSyxJEnkMcz7nFWBA3j7A6ow6ZENlWOdrlMSbDGkhtFqF9Fda3buDgrQGDhawAwa
         B5QlCasY6q0XQHBA1e1n4GnzpbBsdV33OLDMWdjoRrHLI8IHXu4VFieKvLFuzLQ+TcLZ
         3dWp67X1s3K46IrjuLEBc+oT1SQJnD40fcpbGqlU5ZiPt30wluqdRBFGyR99f/LJVBX7
         ZWNA==
X-Gm-Message-State: ABy/qLbvbVixYgMtwxQByVGXoHeTrX0qcae3cnpQx69WFyDZ4nshBri/
        2rcpILjKb/ozQ6hcGC0scxA=
X-Google-Smtp-Source: APBJJlEXxRdTylJlQuY2HOrK3xarVRbbRI+Vezer9FdTfn9onk2HS5knqaCRsMlHJGB+DcxtGFiX6A==
X-Received: by 2002:a05:6a20:7288:b0:131:a21:9f96 with SMTP id o8-20020a056a20728800b001310a219f96mr510744pzk.6.1689881071203;
        Thu, 20 Jul 2023 12:24:31 -0700 (PDT)
Received: from [127.0.0.1] ([212.107.28.55])
        by smtp.gmail.com with ESMTPSA id q18-20020a639812000000b00563709c8647sm1642656pgd.7.2023.07.20.12.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 12:24:30 -0700 (PDT)
From:   Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Date:   Fri, 21 Jul 2023 03:24:08 +0800
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Andreas Schwab <schwab@suse.de>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Subject: Re: [PATCH v3] riscv: entry: set a0 = -ENOSYS only when syscall != -1
User-Agent: K-9 Mail for Android
In-Reply-To: <87wmyvq7ai.fsf@all.your.base.are.belong.to.us>
References: <20230718210037.250665-1-CoelacanthusHex@gmail.com> <mvmo7k8cqns.fsf@suse.de> <878rbbkgqo.fsf@all.your.base.are.belong.to.us> <54D8BFF7-C4D2-417E-B18C-62B5DB17B51B@gmail.com> <87wmyvq7ai.fsf@all.your.base.are.belong.to.us>
Message-ID: <A6169D45-D291-40DF-BC78-42AE4F7A5924@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 20, 2023 5:08:37 PM GMT+08:00, "Bj=C3=B6rn T=C3=B6pel" <bjorn@kerne=
l=2Eorg> wrote:
>Celeste Liu <coelacanthushex@gmail=2Ecom> writes:
>
>> On July 20, 2023 12:28:47 AM GMT+08:00, "Bj=C3=B6rn T=C3=B6pel" <bjorn@=
kernel=2Eorg> wrote:
>>>Andreas Schwab <schwab@suse=2Ede> writes:
>>>
>>>> On Jul 19 2023, Celeste Liu wrote:
>>>>
>>>>> @@ -308,7 +312,7 @@ asmlinkage __visible __trap_section void do_trap=
_ecall_u(struct pt_regs *regs)
>>>>> =20
>>>>>  		if (syscall < NR_syscalls)
>>>>>  			syscall_handler(regs, syscall);
>>>>> -		else
>>>>> +		else if ((long)syscall !=3D -1L)
>>>>
>>>> You can also use syscall !=3D -1UL or even syscall !=3D -1=2E
>>>
>>>The former is indeed better for the eyes! :-) The latter will get a
>>>-Wsign-compare warning, no?
>>>
>>>
>>>Bj=C3=B6rn
>>
>> Well, that's true=2E And I just found out that by C standards, converti=
ng
>> ulong to long is implementation-defined behavior, unlike long to ulong
>> which is well-defined=2E So it is really better than (long)syscall !=3D=
 -1L=2E
>
>If you're respinning, I suggest you use David's suggestion:
> * Remove the comment I suggest you to add
> * Use (signed) long
> * Add syscall >=3D 0 &&
> * else if (syscall !=3D -1)
>
>Which is the least amount of surprises IMO=2E

v4 has sent
