Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157D802AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjLDEED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:04:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 388A9D5;
        Sun,  3 Dec 2023 20:04:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE4F165C;
        Sun,  3 Dec 2023 20:04:51 -0800 (PST)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACAC43F762;
        Sun,  3 Dec 2023 20:03:59 -0800 (PST)
Message-ID: <86f91d68-207d-40a5-9d76-1cbb80e4f210@arm.com>
Date:   Mon, 4 Dec 2023 09:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V15 1/8] arm64/sysreg: Add BRBE registers and fields
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
 <20231201053906.1261704-2-anshuman.khandual@arm.com>
 <fd278f4e-0632-4474-8609-7711ad725f85@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <fd278f4e-0632-4474-8609-7711ad725f85@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/23 22:28, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 11:08:59AM +0530, Anshuman Khandual wrote:
> 
> This looks good apart from a few small omissions:
> 
>> +SysregFields BRBINFx_EL1
> 
>> +Enum	13:8		TYPE
>> +	0b000000	UNCOND_DIRECT
>> +	0b000001	INDIRECT
>> +	0b000010	DIRECT_LINK
>> +	0b000011	INDIRECT_LINK
>> +	0b000101	RET
>> +	0b000111	ERET
>> +	0b001000	COND_DIRECT
>> +	0b100001	DEBUG_HALT
>> +	0b100010	CALL
>> +	0b100011	TRAP
>> +	0b100100	SERROR
>> +	0b100110	INSN_DEBUG
>> +	0b100111	DATA_DEBUG
>> +	0b101010	ALIGN_FAULT
>> +	0b101011	INSN_FAULT
>> +	0b101100	DATA_FAULT
>> +	0b101110	IRQ
>> +	0b101111	FIQ
>> +	0b111001	DEBUG_EXIT
>> +EndEnum
> 
> DDI0601 2023-09 also defines 0b110000 as an IMPLEMENTATION DEFINED
> exception to EL3.

Should this field be just IMPDEF or IMPDEF_TRAP_EL3 sounds better ?

> 
>> +SysregFields	BRBCR_ELx
>> +Res0	63:24
>> +Field	23 	EXCEPTION
>> +Field	22 	ERTN
>> +Res0	21:9
> 
> DDI0601 2023-09 defines bit 9 as FZPSS.

Sure, will update.

> 
>> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0
> 
>> +Enum	13:8		TYPE
>> +	0b000000	UNCOND_DIRECT
>> +	0b000001	INDIRECT
>> +	0b000010	DIRECT_LINK
>> +	0b000011	INDIRECT_LINK
>> +	0b000101	RET
>> +	0b000111	ERET
>> +	0b001000	COND_DIRECT
>> +	0b100001	DEBUG_HALT
>> +	0b100010	CALL
>> +	0b100011	TRAP
>> +	0b100100	SERROR
>> +	0b100110	INSN_DEBUG
>> +	0b100111	DATA_DEBUG
>> +	0b101010	ALIGN_FAULT
>> +	0b101011	INSN_FAULT
>> +	0b101100	DATA_FAULT
>> +	0b101110	IRQ
>> +	0b101111	FIQ
>> +	0b111001	DEBUG_EXIT
>> +EndEnum
> 
> DDI0601 2023-09 also defines 0b11000 as IMPLEMENTATION DEFINED exception
> to EL3.

Should this field be just IMPDEF or IMPDEF_TRAP_EL3 sounds better ?

Seems like BRBINFx_EL1 could be used for defining BRBINFINJ_EL1 as well.
