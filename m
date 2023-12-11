Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418FC80D2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjLKQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344268AbjLKQyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:54:08 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EBFD6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702313652;
        bh=xhDt1LTdfHDjHW1Muu0/YN9bTbj2yFZaSNDC1TGeEyQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e108ZViUr2Y2sQwcd+A/U+rTCgun1E82LMA2NBvw7zePyivjM9OW8DAoF3LqZRYvO
         MUeDNT7FMaGGix4faMoLxFP6B5KQ15tVgqft5fpPnmtFNlNBhlLvY2BD/ykg1g14CW
         Uf9UCql9G2/ajWCnX2KNzDANhi8wj8YehaEheQgZ2YTeHXFSfYu7kT61TpNmliGwVc
         2FGeoJdgvRR9W3O3onI+3IDf+dowSGu3A+WupZOogOVrXc977NQmLuU89jeTcdvj2s
         TzMcL1PH4+N5lUfsh8U7msqeGU6lnLAxqEf0Vx7PYc50c2HYKyo+PwZCDxE6Ob/I5o
         mFp+CGuGdwbiQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Spns0065Xz1hZM;
        Mon, 11 Dec 2023 11:54:11 -0500 (EST)
Message-ID: <49366b42-7921-484a-af5e-578b41fac1c3@efficios.com>
Date:   Mon, 11 Dec 2023 11:54:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] membarrier: Introduce Kconfig ARCH_HAS_MEMBARRIER
Content-Language: en-US
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231211094414.8078-1-parri.andrea@gmail.com>
 <20231211094414.8078-5-parri.andrea@gmail.com>
 <8132d732-b9e8-4a52-be5d-74db7a159136@efficios.com> <ZXc+gpayQTUT22t+@andrea>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZXc+gpayQTUT22t+@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-11 11:53, Andrea Parri wrote:
> On Mon, Dec 11, 2023 at 08:34:21AM -0500, Mathieu Desnoyers wrote:
>> On 2023-12-11 04:44, Andrea Parri wrote:
>>> Architectures supporting the "private expedited" membarrier command must
>>> select the Kconfig to use the command.  Document status and requirements
>>> for each architecture in a single file under Documentation/features.
>>
>> Sorry for being vague in my suggestion: I did not intend to make it
>> optional (not ARCH_HAS_MEMBARRIER), but rather just to have a central
>> place where this would be documented.
> 
> I see.
> 
> 
>> I'm not sure where in Documentation this should land though ?
> 
> Not sure, perhaps a section in (a new) Documentation/scheduler/membarrier.rst?

Yes, it makes sense.

Thanks!

Mathieu

> 
>    Andrea

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

