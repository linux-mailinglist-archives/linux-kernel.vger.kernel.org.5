Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4C786E96
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbjHXL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjHXL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:58:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092451993;
        Thu, 24 Aug 2023 04:58:50 -0700 (PDT)
X-UUID: 94517502427511ee9cb5633481061a41-20230824
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=ZJ1epCQtpUseqRg6zMsAGTaN70pgrRpLcCkz5DZ6kpI=;
        b=kOcNN7ELoZpgtk75j1kyHbpA3o8lNLxBaEQBWsN3YOZklLMSfVrCsGZvd22c+/VZkSGXmMh02TWFSlbLLcbZVx5u2KzUuhjp30KyQtyr6WZQQJ/AptMNmpK40gPqOoirg/i8qH0HxPQ8NxnT0K/POwVz1Ow4nVK1eu59A7n5VS8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:1e8db344-40cf-4075-b466-c07344fd3662,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.31,REQID:1e8db344-40cf-4075-b466-c07344fd3662,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:0ad78a4,CLOUDID:af2db51f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:23082419584866JJ91HP,BulkQuantity:0,Recheck:0,SF:28|17|19|48|64|38|2
        9|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 94517502427511ee9cb5633481061a41-20230824
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1524636553; Thu, 24 Aug 2023 19:58:46 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Aug 2023 19:58:44 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 24 Aug 2023 19:58:44 +0800
Message-ID: <6ea443cf-868b-bbbb-fe42-bbe5bf026cb3@mediatek.com>
Date:   Thu, 24 Aug 2023 19:58:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <kernel@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, <macpaul.lin@mediatek.com>,
        Mark Brown <broonie@kernel.org>
References: <20230720200753.322133-1-nfraprado@collabora.com>
 <e053e9fe-5d88-44f1-bb24-280113665185@notapiano>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <e053e9fe-5d88-44f1-bb24-280113665185@notapiano>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 06:12, Nícolas F. R. A. Prado wrote:
> On Thu, Jul 20, 2023 at 04:07:51PM -0400, Nícolas F. R. A. Prado wrote:
>> The DSU PMU allows monitoring performance events in the DSU cluster,
>> which is done by configuring and reading back values from the DSU PMU
>> system registers. However, for write-access to be allowed by ELs lower
>> than EL3, the EL3 firmware needs to update the setting on the ACTLR3_EL3
>> register, as it is disallowed by default.
>>
>> That configuration is not done on the firmware used by the MT8195 SoC,
>> as a consequence, booting a MT8195-based machine like
>> mt8195-cherry-tomato-r2 with CONFIG_ARM_DSU_PMU enabled hangs the kernel
>> just as it writes to the CLUSTERPMOVSCLR_EL1 register, since the
>> instruction faults to EL3, and BL31 apparently just re-runs the
>> instruction over and over.
>>
>> Mark the DSU PMU node in the Devicetree with status "fail", as the
>> machine doesn't have a suitable firmware to make use of it from the
>> kernel, and allowing its driver to probe would hang the kernel.
>>
>> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Hi Matthias,
> 
> gentle ping on this patch, as it's not possible to boot MT8195 Chromebooks with
> the mainline defconfig without this fix.

I've encountered this issue for a long time since CONFIG_ARM_DSU_PMU has 
been enabled by this patch.
075ed7b9e408 arm64: configs: Enable all PMUs provided by Arm

I'm working on mt8195-demo board, I guess this board has the same issue 
as mt8195-cherry-tomato-r2. Here's the log.

[   22.996825] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   22.997609] rcu:     (detected by 1, t=5254 jiffies, g=-603, q=3023 
ncpus=8)
[   22.998468] rcu: All QSes seen, last rcu_preempt kthread activity 
5252 (4294898045-4294892793), jiffies_till_next_fqs=1, root ->qsmask 0x0
[   23.000036] rcu: rcu_preempt kthread timer wakeup didn't happen for 
5251 jiffies! g-603 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200
[   23.001462] rcu:     Possible timer handling issue on cpu=2 
timer-softirq=47
[   23.002319] rcu: rcu_preempt kthread starved for 5252 jiffies! g-603 
f0x2 RCU_GP_WAIT_FQS(5) ->state=0x200 ->cpu=2
[   23.003625] rcu:     Unless rcu_preempt kthread gets sufficient CPU 
time, OOM is now expected behavior.
[   23.004776] rcu: RCU grace-period kthread stack dump:
[   23.005414] task:rcu_preempt     state:R stack:0     pid:15    ppid:2 
      flags:0x00000008
[   23.006474] Call trace:
[   23.006788]  __switch_to+0xe4/0x15c
[   23.007240]  __schedule+0x2bc/0xaa0
[   23.007685]  schedule+0x5c/0xc4
[   23.008087]  schedule_timeout+0x80/0xf4
[   23.008578]  rcu_gp_fqs_loop+0x124/0x3d4
[   23.009081]  rcu_gp_kthread+0x124/0x160
[   23.009571]  kthread+0x118/0x11c
[   23.009985]  ret_from_fork+0x10/0x20

I have a work around to enable DSU PMU in firmware (trusted-firmware-a) 
to solve this hang problem.
However, I think this is not the correct place to put these codes to 
enable DSU PMU in trusted-firmware-a.

--- a/include/arch/aarch64/el3_common_macros.S
+++ b/include/arch/aarch64/el3_common_macros.S
@@ -39,6 +39,19 @@
         msr     sctlr_el3, x0
         isb

+       /* enable DSU PMU */
+       mov     x1, #(1 << 12)
+       mrs     x0, actlr_el3
+       orr     x0, x0, x1
+       msr     actlr_el3, x0
+       isb
+
+       mov     x1, #(1 << 12)
+       mrs     x0, actlr_el2
+       orr     x0, x0, x1
+       msr     actlr_el2, x0
+       isb
+
  #ifdef IMAGE_BL31
         /* 
---------------------------------------------------------------------
          * Initialise the per-cpu cache pointer to the CPU.

If I put these codes in other platform dependent files to enable DSU PMU 
instead of the common code beginning of the EL3, it just not work.

It should be able to fixed in firmware in platform dependent files, but 
I'm not familiar with how actlr_el3 and actlr_el2 should be accessed. 
Otherwise, the DSU PMU node in dts should be disabled. Any idea is welcome.

Thanks
Macpaul Lin
