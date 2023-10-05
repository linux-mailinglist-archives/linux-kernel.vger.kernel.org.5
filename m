Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18C7BA701
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjJEQpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjJEQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:44:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA4624CD5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:39:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 845B2C15;
        Thu,  5 Oct 2023 09:39:43 -0700 (PDT)
Received: from [10.57.2.226] (unknown [10.57.2.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 267713F5A1;
        Thu,  5 Oct 2023 09:39:02 -0700 (PDT)
Message-ID: <46de1eb3-c237-2433-0ca7-ebeff47abc1a@arm.com>
Date:   Thu, 5 Oct 2023 17:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/6] arm64/sysreg: Move TRFCR definitions to sysreg
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        broonie@kernel.org, maz@kernel.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231005125757.649345-1-james.clark@arm.com>
 <20231005125757.649345-2-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231005125757.649345-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 13:57, James Clark wrote:
> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
> This also mirrors the previous definition so no code change is required.
> 
> Also add TRFCR_EL12 which will start to be used in a later commit.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


> ---
>   arch/arm64/include/asm/sysreg.h | 12 ----------
>   arch/arm64/tools/sysreg         | 41 +++++++++++++++++++++++++++++++++
>   2 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 38296579a4fd..068dd6abe273 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -278,8 +278,6 @@
>   #define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
>   #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
>   
> -#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
> -
>   #define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
>   
>   #define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
> @@ -496,7 +494,6 @@
>   #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
>   #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
>   
> -#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
>   #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
>   #define SYS_SPSR_EL2			sys_reg(3, 4, 4, 0, 0)
>   #define SYS_ELR_EL2			sys_reg(3, 4, 4, 0, 1)
> @@ -904,15 +901,6 @@
>   /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
>   #define SYS_MPIDR_SAFE_VAL	(BIT(31))
>   
> -#define TRFCR_ELx_TS_SHIFT		5
> -#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
> -#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
> -#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
> -#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
> -#define TRFCR_EL2_CX			BIT(3)
> -#define TRFCR_ELx_ExTRE			BIT(1)
> -#define TRFCR_ELx_E0TRE			BIT(0)
> -
>   /* GIC Hypervisor interface registers */
>   /* ICH_MISR_EL2 bit definitions */
>   #define ICH_MISR_EOI		(1 << 0)
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 2517ef7c21cf..2104152db18e 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -2624,3 +2624,44 @@ Field	5	F
>   Field	4	P
>   Field	3:0	Align
>   EndSysreg
> +
> +SysregFields TRFCR_EL2
> +Res0	63:7
> +UnsignedEnum	6:5	TS
> +	0b0000	USE_TRFCR_EL1_TS
> +	0b0001	VIRTUAL
> +	0b0010	GUEST_PHYSICAL
> +	0b0011	PHYSICAL
> +EndEnum
> +Res0	4
> +Field	3	CX
> +Res0	2
> +Field	1	E2TRE
> +Field	0	E0HTRE
> +EndSysregFields
> +
> +# TRFCR_EL1 doesn't have the CX bit so redefine it without CX instead of
> +# using a shared definition between TRFCR_EL2 and TRFCR_EL1
> +SysregFields TRFCR_ELx
> +Res0	63:7
> +UnsignedEnum	6:5	TS
> +	0b0001	VIRTUAL
> +	0b0010	GUEST_PHYSICAL
> +	0b0011	PHYSICAL
> +EndEnum
> +Res0	4:2
> +Field	1	ExTRE
> +Field	0	E0TRE
> +EndSysregFields
> +
> +Sysreg	TRFCR_EL1	3	0	1	2	1
> +Fields	TRFCR_ELx
> +EndSysreg
> +
> +Sysreg	TRFCR_EL2	3	4	1	2	1
> +Fields	TRFCR_EL2
> +EndSysreg
> +
> +Sysreg	TRFCR_EL12	3	5	1	2	1
> +Fields	TRFCR_ELx
> +EndSysreg

