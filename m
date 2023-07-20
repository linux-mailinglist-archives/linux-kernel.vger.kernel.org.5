Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC775AEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjGTMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGTMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:44:04 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894882135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:44:02 -0700 (PDT)
Received: from [IPV6:2a02:8428:2a4:1a01:13c1:e7e5:8148:776d] (unknown [IPv6:2a02:8428:2a4:1a01:13c1:e7e5:8148:776d])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0846E2003DC;
        Thu, 20 Jul 2023 14:43:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1689857039;
        bh=AlcwNTJRG93OMRcFvpt4yL26C/7yWe+V9VE4KTS19tk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oX7lG0Uw7wJvpGI8Wr5XAaUvZeCq4w3vApTZConWiQY7c56LAZZgpLqCs8pEgO6iH
         +EVcM6TNew2eoatJ5pYqtC0BVyldRiOcWMYBXcfRcs8V/IoPGqoFH0lJqcUAo5CQKA
         e9MK4jY1Ni2riTrKaU8R0GsBXl6rCJiiTQaPvXMR78c9OKHiIaZqN+hjPu1DcnxtmR
         AGQd+OkCGqU2+i57alo+33IRpEtgy1QEzrKCK551Np916z8NlshjKwqyo1v1lUM6q/
         C8YuhqwvMf5d49lRDjdo3Z4e2JPD87NRdMC9a/h1HLM0WQhvRyid9LOqPIWk4LUP5Y
         ovqnN13BTh8ag==
Message-ID: <502aa1d5-97a0-7787-1d9c-486f351fe9c5@free.fr>
Date:   Thu, 20 Jul 2023 14:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 00/58] x86/apic: Decrapification and static calls
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20230717223049.327865981@linutronix.de>
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <20230717223049.327865981@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 01:14, Thomas Gleixner wrote:

> Talking about those museums pieces and the related historic maze, I really
> have to bring up the question again, whether we should finally kill support
> for the museum CPUs and move on.
> 
> Ideally we remove 32bit support altogether. I know the answer... :(

Hello Thomas,

For what it's worth, there are a few millions of these in the field:

# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU CE4150   @ 1.20GHz
stepping	: 10
microcode	: 0x106
cpu MHz		: 1199.885
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts cpuid aperfmperf pni dtes64 monitor ds_cpl vmx tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm tpr_shadow vnmi flexpriority vpid dtherm
vmx flags	: vnmi flexpriority tsc_offset vtpr vapic
bugs		:
bogomips	: 2400.76
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 28
model name	: Intel(R) Atom(TM) CPU CE4150   @ 1.20GHz
stepping	: 10
microcode	: 0x106
cpu MHz		: 1200.188
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
apicid		: 1
initial apicid	: 1
fdiv_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm constant_tsc arch_perfmon pebs bts cpuid aperfmperf pni dtes64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dtherm
bugs		:
bogomips	: 2400.76
clflush size	: 64
cache_alignment	: 64
address sizes	: 32 bits physical, 48 bits virtual
power management:


# uname -a
Linux foo 5.15.42+ #182 SMP PREEMPT Mon Jul 17 09:41:27 UTC 2023 i686 GNU/Linux

They will probably be running 6.1 in a few months.

Regards

