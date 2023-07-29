Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBD6767DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjG2JbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG2JbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 05:31:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C5E3A99
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 02:31:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0109602F9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 09:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB6C433C8;
        Sat, 29 Jul 2023 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690623073;
        bh=uNJWn51j3Ncr8UkODDwXEEnnPenUL38moEnw/4FUaOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rEHh+Jtlpp4vE7JIgCOvj+0MOKJCHFgElJnKHi6+mj95Nx/4/w+2u0I4sQlCJR+1+
         FP7vgFGaFMIVD1ZyL1Hyw/hD44RGVAx9Ek3BXW+zaoKmYBaQHwOCcQOOll0gOGIWMR
         SqXurqWPGu8lmyxbD6F9gSCM2louSE/gnCBwOlUUfDcPltz507s8VqNhV+rQ3VS08w
         W1w1aboUjIX6tXB20n9nHcmnvAIkhWuxTlCJE2yq9702uvkGLZCthoY8NsyDObbMj4
         DH6RGc0gKA87sxrmnJy1gZzsUuDEIkBiMzrY751K9uduJhAHaSDZMYdgSuJSxNmov6
         Wn4RmhFv/wP1A==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qPgI2-000KSf-Vm;
        Sat, 29 Jul 2023 10:31:11 +0100
MIME-Version: 1.0
Date:   Sat, 29 Jul 2023 10:31:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     wangwudi <wangwudi@hisilicon.com>
Cc:     "liaochang (A)" <liaochang1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] irqchip: gic-v3: Extend collection table
In-Reply-To: <efe58183-5e40-0ff8-e59b-50bf25b7f4c6@hisilicon.com>
References: <4e62022e-aa57-d1a5-6f01-89a36a682e00@hisilicon.com>
 <efe58183-5e40-0ff8-e59b-50bf25b7f4c6@hisilicon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <426a9a4042f6ea925d71d2f83f25f888@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: wangwudi@hisilicon.com, liaochang1@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-29 07:54, wangwudi wrote:
> Hi Marc,
> 
> A gentle ping.

Look, you keep pinging me for a patch that you haven't tested.

What do you think happens? This patch goes to the back of the queue
until I find enough time to test it on a GIC500 platform.

It is even of a lower priority given that this doesn't fix any
*real* issue, and is only for the purpose of your simulation with
non-sensical parameters (16 bytes for collection entries? let's
get real -- this only needs to be at most an affinity, for which
4 bytes are enough).

         M.

> 
> Thanks,
> Wudi
> 
> 
> 在 2023/7/7 17:04, wangwudi 写道:
>> 
>> 
>> -----邮件原件-----
>> 发件人: wangwudi
>> 发送时间: 2023年6月21日 18:02
>> 收件人: linux-kernel@vger.kernel.org
>> 抄送: liaochang (A) <liaochang1@huawei.com>; wangwudi 
>> <wangwudi@hisilicon.com>; Thomas Gleixner <tglx@linutronix.de>; Marc 
>> Zyngier <maz@kernel.org>
>> 主题: [PATCH v3] irqchip: gic-v3: Extend collection table
>> 
>> Only single level table is supported to the collection table, and only 
>> one page is allocated.
>> 
>> Extend collection table to support more CPUs:
>> 1. Recalculate the page number of collection table based on the number 
>> of CPUs.
>> 2. Add 2 level tables to collection table when HCC field is zero.
>> 3. Add GITS_TYPER_CIDBITS macros.
>> 
>> It is noticed in an internal simulation research:
>> - the page_size of collection table is 4 KB
>> - the entry_size of collection table is 16 Byte
>> - with 512 CPUs
>> 
>> And I don't find a have a GIC500 platform to test this path.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: wangwudi <wangwudi@hisilicon.com>
>> ---
>> 
>> ChangeLog:
>> v1-->v2:
>> 1. Support 2 level table.
>> 2. Rewrite the commit log.
>> v2-->v3
>> 1. Fixed the error when HCC is field is not zero.
>> 2. Modifiy the commit log.
>> 
>>  drivers/irqchip/irq-gic-v3-its.c   | 67 
>> +++++++++++++++++++++++++++++++-------
>>  include/linux/irqchip/arm-gic-v3.h |  3 ++
>>  2 files changed, 58 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 0ec2b1e1df75..c37e010fd50c 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -126,6 +126,7 @@ struct its_node {
>>  #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
>>  #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
>>  #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) 
>> + 1)
>> +#define collection_ids(its)	(FIELD_GET(GITS_TYPER_CIDBITS, 
>> (its)->typer) + 1)
>> 
>>  #define ITS_ITT_ALIGN		SZ_256
>> 
>> @@ -2626,6 +2627,10 @@ static int its_alloc_tables(struct its_node 
>> *its)
>>  			indirect = its_parse_indirect_baser(its, baser, &order,
>>  							    ITS_MAX_VPEID_BITS);
>>  			break;
>> +		case GITS_BASER_TYPE_COLLECTION:
>> +			indirect = its_parse_indirect_baser(its, baser, &order,
>> +							    order_base_2(num_possible_cpus()));
>> +			break;
>>  		}
>> 
>>  		err = its_setup_baser(its, baser, cache, shr, order, indirect); @@ 
>> -3230,18 +3235,6 @@ static void its_cpu_init_collection(struct 
>> its_node *its)
>>  	its_send_invall(its, &its->collections[cpu]);  }
>> 
>> -static void its_cpu_init_collections(void) -{
>> -	struct its_node *its;
>> -
>> -	raw_spin_lock(&its_lock);
>> -
>> -	list_for_each_entry(its, &its_nodes, entry)
>> -		its_cpu_init_collection(its);
>> -
>> -	raw_spin_unlock(&its_lock);
>> -}
>> -
>>  static struct its_device *its_find_device(struct its_node *its, u32 
>> dev_id)  {
>>  	struct its_device *its_dev = NULL, *tmp; @@ -3316,6 +3309,56 @@ 
>> static bool its_alloc_table_entry(struct its_node *its,
>>  	return true;
>>  }
>> 
>> +static bool its_alloc_collection_table(struct its_node *its, struct
>> +its_baser *baser) {
>> +	int cpu = smp_processor_id();
>> +	int cpu_ids = 16;
>> +
>> +	if (its->typer & GITS_TYPER_CIL)
>> +		cpu_ids = collection_ids(its);
>> +
>> +	if (!(ilog2(cpu) < cpu_ids)) {
>> +		pr_warn("ITS: CPU%d out of Collection ID range for %dbits", cpu, 
>> cpu_ids);
>> +		return false;
>> +	}
>> +
>> +	if (!its_alloc_table_entry(its, baser, cpu)) {
>> +		pr_warn("ITS: CPU%d failed to allocate collection l2 table", cpu);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static bool its_cpu_init_collections(void) {
>> +	struct its_node *its;
>> +	struct its_baser *baser;
>> +	void __iomem *base;
>> +
>> +	raw_spin_lock(&its_lock);
>> +
>> +	list_for_each_entry(its, &its_nodes, entry) {
>> +		base = its->base;
>> +		if (!GITS_TYPER_HCC(gic_read_typer(base + GITS_TYPER))) {
>> +			baser = its_get_baser(its, GITS_BASER_TYPE_COLLECTION);
>> +			if (!baser) {
>> +				raw_spin_unlock(&its_lock);
>> +				return false;
>> +			}
>> +
>> +			if (!its_alloc_collection_table(its, baser)) {
>> +				raw_spin_unlock(&its_lock);
>> +				return false;
>> +			}
>> +		}
>> +
>> +		its_cpu_init_collection(its);
>> +	}
>> +	raw_spin_unlock(&its_lock);
>> +	return true;
>> +}
>> +
>>  static bool its_alloc_device_table(struct its_node *its, u32 dev_id)  
>> {
>>  	struct its_baser *baser;
>> diff --git a/include/linux/irqchip/arm-gic-v3.h 
>> b/include/linux/irqchip/arm-gic-v3.h
>> index 728691365464..35e83da8961f 100644
>> --- a/include/linux/irqchip/arm-gic-v3.h
>> +++ b/include/linux/irqchip/arm-gic-v3.h
>> @@ -400,6 +400,9 @@
>>  #define GITS_TYPER_PTA			(1UL << 19)
>>  #define GITS_TYPER_HCC_SHIFT		24
>>  #define GITS_TYPER_HCC(r)		(((r) >> GITS_TYPER_HCC_SHIFT) & 0xff)
>> +#define GITS_TYPER_CIDBITS_SHIFT	32
>> +#define GITS_TYPER_CIDBITS		GENMASK_ULL(35, 32)
>> +#define GITS_TYPER_CIL			(1ULL << 36)
>>  #define GITS_TYPER_VMOVP		(1ULL << 37)
>>  #define GITS_TYPER_VMAPP		(1ULL << 40)
>>  #define GITS_TYPER_SVPET		GENMASK_ULL(42, 41)
>> --
>> 2.7.4
>> 

-- 
Jazz is not dead. It just smells funny...
