Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A778FCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbjIAMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjIAMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:15:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3748E7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLnlwcZsnxhjC6AnCT9kreITdQaQwLIa6fGEv8q49JlwkMWoaWlbXElWQcGIVEoS87Jn3LSljFMo9BiOTG9/Iv4+38QHCAfGrzso+LBSFDWZLIKkXb6fnDj0htWpkJDV0bQiQ5ahi8e5DBMDM608BST8KSDa+RsEb1HK4UMb4MP6am0G+7DrRNNsQiL3+nP9TIRX9qXo0BK6WAhSvMsUrcy7ZZdVQ0FK5NtDUj/NPGCBvWar/Gx6xZ0SDQPopv9Bjm5uoOSlNLyUqPEBtyjtJMK/Gi7pk5x2nIvaS4H2CHqCgxCgoJd3JNYw/oe5bZOIFPQIU9dWO07yk6eZ+YqKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN1AzpmiMnUQznyYQrK7B3foTcavRU8nEisZP5G6s1A=;
 b=SCe3w8VMw/uUhbFNXITWr/XwXxzw7axIYsC+V24F5X3Nso9gW7IxAUygv5LpbAkGczm8ps1baKboWfjcCI4ucQTva+GS5F8kDD/LRW6asjuBzUcwYgrsle69s5t7rNJ2lurDjNPeZcbCZxq4E1TWQXhODR4WfL7bmsf0AHWhqSTM31OCMGeAWNQdJrEdZtj9ks/ujcSO1NolwWCdSdOAr+FS+sEkHxK9WmogaiqVMsFI5X0njqUYRx7+j7vfd58hlhWctDBL2+/q0I89UC8tMpUHWUrvqwwL7RmAZn9SdezOLy6EiJXVvz9IWY4I7XB310b6Dd7i2x88d/mdiqsnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN1AzpmiMnUQznyYQrK7B3foTcavRU8nEisZP5G6s1A=;
 b=PZHcuIwWtdkhkl4/JwR/zldvyeFPYc7i6iTJed0eFI3vunG0tGAYYolFbxAsAqVpwRzmw0v1V3y5Xahfaf3nnZIj+z6oCYtZSifyRepirITunVl6r7RrBbgR9PHHTk/QRepUNdfuDp0daMSfxBLR7qpyKihN58RjrceruktXzWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB7001.prod.exchangelabs.com (2603:10b6:610:106::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Fri, 1 Sep 2023 12:15:31 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254%7]) with mapi id 15.20.6745.022; Fri, 1 Sep 2023
 12:15:30 +0000
Message-ID: <a4dac5af-44e2-0485-446f-fae09fa66a3c@os.amperecomputing.com>
Date:   Fri, 1 Sep 2023 17:45:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] KVM: arm64: timers: Adjust CVAL of a ptimer across
 guest entry and exits
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com,
        Christoffer Dall <Christoffer.Dall@arm.com>
References: <20230817060314.535987-1-gankulkarni@os.amperecomputing.com>
 <20230817060314.535987-3-gankulkarni@os.amperecomputing.com>
 <87bkf6oyyt.wl-maz@kernel.org>
 <0c5fb304-8c69-80c3-6f1e-487828554244@os.amperecomputing.com>
 <86il97ff17.wl-maz@kernel.org>
 <946b0fc2-3264-d7ab-f5e1-7c9e76db6ebf@os.amperecomputing.com>
 <80bce164-4fb9-0126-0ba0-02581be1a0a5@os.amperecomputing.com>
 <864jkjfp40.wl-maz@kernel.org>
Content-Language: en-US
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <864jkjfp40.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::16) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf16ba9-eaa7-4f05-a6d6-08dbaae521d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbkS8YsENUzHGUdFgYXXhVsRAC0xKOLGfqjQ1mNig979xnT+gHXGR7lfUJ5g++Q7fqQTzLvXTsk4DaIonN7bmi1nZ/uaUftlKrsdbNn2Yy0glvNvCcSkEHFlbVn5nVQLbg85rjbTvBwyVYkJ9IT/KmX+kZ8hKnpvCeAgsxEn2OJi4Crps5aGZFFzY9bzn3PSdDn69Kx31eiwSgef+GxDmWgA2BHf/Z7C2dNxk1S+1lP1wLFEXS1hR5dxCJyAgS0bRKpbacMnKE5rCjUxtj+m7FzpLgt7CWut8k0JigalZrSaR2I1g8aexaeklZ6SbhaKJEJdSe++BD65+i1YCQU8Kc8UCU+wLq3zutpq9jEt3w6IeqppdEJ5uh4HAmWeHDvekt9xPwk8x9S3xb3n08nrIVriwp0Kklgoibu43EEEBOZRdywuOXogMWt0gVbnsUqQIbs/B19ROCxbXrgSS4Sn3Hxym++pgYlela0/DiN3Ww1W17q4jzo9/gg6N1p/DzB+I+pykFT+ZHgEV4Lm2m5N2lDU6ZXF6GtymU2aJN/dJXWd6DBiXiQ9S3gZoaHuMfT18lwMtFeKOIgAazx2pekYic17L1ITtn6L5AF9Jpktu+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(376002)(346002)(136003)(1800799009)(186009)(451199024)(2906002)(6916009)(316002)(41300700001)(5660300002)(8676002)(4326008)(8936002)(31696002)(86362001)(31686004)(6666004)(478600001)(2616005)(83380400001)(26005)(53546011)(6506007)(6486002)(6512007)(66946007)(38100700002)(66556008)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1wZTU0dGhsZllpdzNpMUJJSUFCSEJDeTRYZWFGZXovNGhuK1FaeW1XYThK?=
 =?utf-8?B?Q0U3TTd4T0Z2VTBLK0ozWjB1VTN1YXppbVIvVTNwYy92MFNLbXNyTXpteHV4?=
 =?utf-8?B?M1QwUit2anFLekUyQVZZMHJEaUpkc0Q0OUF1U2ZZY01rUjVNRU5HaTY4TUIv?=
 =?utf-8?B?QVIzU29GcnR1WlZuakQyQUlWV1dyQnZNM2xzRWJqbWFlWUdBaWFXTkFORXpr?=
 =?utf-8?B?QkNIeVNKYXZDL1FXWTRRK28wZmIzVWxuQ1NWL3g5OWpWWUxtSllQOEh6VXlG?=
 =?utf-8?B?Z0hNV053aFJYeGJHRThjM09ldENMb1ByNFRJUUdOZ240RVBJaGFJSXVFNG5p?=
 =?utf-8?B?UHlWTTlLSGZWbnNLRUgwckFKY0pFOTVaa3ZxaXVwY1ljK2FpQjlvZ0UvV2tl?=
 =?utf-8?B?Y3NCY1hjMUVDdnRjUEZXNldTSEdiMjZSWE1VWDFwUm82a0lBNC9IVzUxT1I2?=
 =?utf-8?B?VExEQmxrdnVyWW1XZVk3dXRxVEx1eWo3eXo5N01ieHpGMWthZnJHWWF6blNS?=
 =?utf-8?B?MURTR2tvSlhSazZHSy94c0I5YVcrL1RjNmlNcFpCQkZHUWJoeWpUZ3gvODNh?=
 =?utf-8?B?TGwwTTZkZXdtcmJQWTB3UXNpMWh1Y3FPUUYwVUZneXpUY0lkTTRvM0F3bitz?=
 =?utf-8?B?aDlBaTgzOFlEL0FNdm1nOUM2SnFveGU5UmNkbFdXb09ydytKZlZJTE5md1Qz?=
 =?utf-8?B?Si9IVm02bHlzUjVLeWhNcnFoN1p4RlZyQ1dqMnZqMllLMkhXL3BhV1A0c1gy?=
 =?utf-8?B?SDk3YjNFVEFSSkVKSXlRbU42TGlJLzlPa2FjUHdEeXAwZ1pQQnBsRVdhZWF3?=
 =?utf-8?B?aHViZEpYUnp0QlNMRFN3YzJ3cVpBcXhnQ2ZOak1qZVhybW9WcDF5bWNrWm9a?=
 =?utf-8?B?eG5Dc1NhZmd1S1MrRTRRMktMRXc4MGxZMlVCWkZMWFpOSytxdVVueHFTOXlW?=
 =?utf-8?B?RC9Xc2oxUmZ3aTI0U2FqcVpON1pHeXRJaEZUWWlwM25Ic3dBQTRCOHc4d2xx?=
 =?utf-8?B?cldKUk5VNDMzV254UzNYZ2lraVNzbHZKZnVabXlPQTA2TC9OWlFobnVvVUNt?=
 =?utf-8?B?QmtVRHI5cDJlRmFONEVXeEFjMCs1eTIrc24vREdHNXlQUG9pby9tbXVRdElv?=
 =?utf-8?B?WncrcGQzWTA3czhDWU1BMm1FZWFKRmtONkMrMk5IS3liNi9MSjg3M042VktG?=
 =?utf-8?B?d3RNRXlTQ3lSTHU3TmtKK0s3UFNxZkI3dUo1dHE0OHJHL2kzWkNsaWxBckZr?=
 =?utf-8?B?ZkVZY2UzUjdwTmo5bzRQY3BSTVozQmpLMTZCSTNYVDJnQ0xkeHU0ejQ3d0xx?=
 =?utf-8?B?V2p4ekM0ZDlidDRWSGFHTXR3MEo2SlAyZkFFVEhyYmVuMldyTUFORDE0a1Er?=
 =?utf-8?B?MkIyYmZUQVJkZitYandtSDBXT0F6TEZPOGFWWENoRTI3WjFSQ1lIRTZMc2kx?=
 =?utf-8?B?UU5KMVJOQ1EzSDJvbFYvUWRickxNQkw1NmVZWFBMcGZHMUx6QVEyV0VSb3BN?=
 =?utf-8?B?V1Z2bTF6eG10YjFRV0F2cDF2djdXTSsyMm1Vc3U1VnIxOWxmSXc3ZHJqeDF2?=
 =?utf-8?B?VDlldGc5NkZxWWloMnhnNW5mOURHU0ExYjVnejRxRGRVc05yWDhueHZXdUF5?=
 =?utf-8?B?ZUZ4cWRabkxhN1FJKzBuejJOZXlmdUorRDVNeXdvTkJTYllINEc5aGlNdm9F?=
 =?utf-8?B?dkw4VkRoTVNSSk91M3NueGxVWGxUK3A2eG1XN01lUDltTExaMVpuQlFMRVdw?=
 =?utf-8?B?UFRFclgyVmZ2SzB1RDBROWM3dVpYdXVxZnpLM2JwdEpaTDhxS1dXbkZKc0Zr?=
 =?utf-8?B?dzE4KzA2RzlwZWpFTVh0VEJLdlFTaWJZV3VCRm5qQ0FpL211ZjcxZUY5VGti?=
 =?utf-8?B?YzdCcTBQSGZiN1R5WlpJcURSaWNHNlJMa0dNVnQwVnZTclVvVmJ5MTR4bzd1?=
 =?utf-8?B?WmFRUkRYcHJYQXB0a2kvcStVT0VESEh5SjAwTEx5aHJUSVZEdTU0a0o1ZVU4?=
 =?utf-8?B?N1ExRmRlcnBuRUl0c2NRaDBnL1NRbktWeU9QT04vd2FGdk9WOEhtVW10Sll4?=
 =?utf-8?B?bGtGWXlHc1NQLzBEUTAzZUdJMFJpQXl4elpabGF1Rk40QTdmbklCUHdrdS9V?=
 =?utf-8?B?OCtsVCtUaFN5eS9UN3ZIV2tucHdUUlMvdFBzb1dvYmw2YW82cHh0UFIrMFdI?=
 =?utf-8?Q?cSNVOmjlf56B84lofkPBCMyDiu1IkSW6CSxSHNH+9Y5r?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf16ba9-eaa7-4f05-a6d6-08dbaae521d9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 12:15:30.0234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbUrA7mW4mb0Zt32C7L65eaq+/20sVZG6KePrTU1ZmPlWPq6nD+coST92jVct4U6ICZ9f/DsD/pkpC5Hf6+4pqc/jR5YdD+FpQF6W5BG6EPmaR0udtos5MhAuJupDBeZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7001
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-08-2023 03:47 pm, Marc Zyngier wrote:
> On Thu, 24 Aug 2023 07:37:42 +0100,
> Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com> wrote:
>>
>>>> Now, to the actual patch: I think the way you offset CVAL isn't
>>>> great. You should never have to change it on entry, and you should
>>>> instead read the correct value from memory. Then, save/restore of CVAL
>>>> must be amended to always apply the offset. Can you give the hack
>>>> below a go on your HW?
>>
>> I tried this and seems not working, this is due to timer save/restore
>> are not called for some of the kvm_exit and entry paths(lighter
>> switches).
> 
> Can you point me to such paths? Are you referring to the ECV handling
> of the physical timer registers?
> 
>>
>> I tried changing this patch like, Removed cval adjust from the
>> kvm_entry and still cval is adjusted on kvm_exit and in
>> timer_restore_state function, reduced cval by offset.
>>
>> Please let me know, if this is not you intended to try?
>> If possible, please share the steps or pseudo code.
> 
> What I want to get to is that:
> 
> - on entry (TGE having been flipped to 0), the guest's CVAL is always
>    reload from memory, because that's the absolute reference. We should
>    never load anything else on the CPU.
> 
> - on exit (TGE having been flipped to 1), the guest's CVAL is stored
>    as the one true value to memory, and the CPU's view is offset by the
>    offset.
> 
> - the high-level save/restore helpers apply the offsets back and forth
>    as if CNTPOFF didn't exist (because that's exactly the case if
>    TGE=1).
> 
> Now, I'm pretty sure I'm still missing something, but the above is
> roughly the scheme I'm trying to follow?
> 

Sorry for the confusion. It was my bad, I did some mistake while trying 
your hack patch. Based on your patch and above explanation I have 
created below diff which is working and clean.

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 4eb601e7de50..f22cc733efb1 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -132,6 +132,11 @@ static __always_inline bool has_vhe(void)
  		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
  }

+static __always_inline bool has_cntpoff(void)
+{
+	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
+}
+
  static __always_inline bool is_protected_kvm_enabled(void)
  {
  	if (is_vhe_hyp_code())
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 75bddab3224f..de625bc7c25c 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -55,11 +55,6 @@ static struct irq_ops arch_timer_irq_ops = {
  	.get_input_level = kvm_arch_timer_get_input_level,
  };

-static bool has_cntpoff(void)
-{
-	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
-}
-
  static int nr_timers(struct kvm_vcpu *vcpu)
  {
  	if (!vcpu_has_nv(vcpu))
@@ -566,10 +561,7 @@ static void timer_save_state(struct 
arch_timer_context *ctx)
  	case TIMER_HPTIMER:
  		timer_set_ctl(ctx, read_sysreg_el0(SYS_CNTP_CTL));
  		cval = read_sysreg_el0(SYS_CNTP_CVAL);
-
-		if (!has_cntpoff())
-			cval -= timer_get_offset(ctx);
-
+		cval -= timer_get_offset(ctx);
  		timer_set_cval(ctx, cval);

  		/* Disable the timer */
@@ -655,8 +647,7 @@ static void timer_restore_state(struct 
arch_timer_context *ctx)
  		cval = timer_get_cval(ctx);
  		offset = timer_get_offset(ctx);
  		set_cntpoff(offset);
-		if (!has_cntpoff())
-			cval += offset;
+		cval += offset;
  		write_sysreg_el0(cval, SYS_CNTP_CVAL);
  		isb();
  		write_sysreg_el0(timer_get_ctl(ctx), SYS_CNTP_CTL);
@@ -960,6 +951,59 @@ void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu)
  		kvm_timer_blocking(vcpu);
  }

+static void ptimer_cval_save(struct arch_timer_context *ctx, u64 offset)
+{
+	unsigned long flags;
+	u64 cval;
+
+	local_irq_save(flags);
+	cval = read_sysreg_el0(SYS_CNTP_CVAL);
+	timer_set_cval(ctx, cval);
+	cval += offset;
+	write_sysreg_el0(cval, SYS_CNTP_CVAL);
+	isb();
+	local_irq_restore(flags);
+}
+
+static void ptimer_cval_restore(struct arch_timer_context *ctx, u64 offset)
+{
+	unsigned long flags;
+	u64 cval;
+
+	local_irq_save(flags);
+	cval = timer_get_cval(ctx);
+	write_sysreg_el0(cval, SYS_CNTP_CVAL);
+	isb();
+	local_irq_restore(flags);
+}
+
+void kvm_ptimer_cval_save_restore(struct kvm_vcpu *vcpu, bool save)
+{
+	struct timer_map map;
+	struct arch_timer_cpu *timer;
+	struct arch_timer_context *ctxp;
+	u64 offset;
+
+	get_timer_map(vcpu, &map);
+	ctxp = map.direct_ptimer;
+
+	if (unlikely(ctxp == NULL))
+		return;
+	
+	offset = timer_get_offset(ctxp);
+	if (!offset)
+		return;
+
+	timer = vcpu_timer(ctxp->vcpu);
+	if (!timer->enabled || !ctxp->loaded)
+		return;
+
+	if (save)
+		ptimer_cval_save(ctxp, offset);
+	else
+		ptimer_cval_restore(ctxp, offset);
+}
+
  void kvm_timer_sync_nested(struct kvm_vcpu *vcpu)
  {
  	/*
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c 
b/arch/arm64/kvm/hyp/vhe/switch.c
index 561cb53e19ce..097fcaf7b208 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -100,6 +100,10 @@ static void __activate_traps(struct kvm_vcpu *vcpu)
  		hcr |= vhcr_el2;
  	}

+	/* Restore CVAL */
+	if (has_cntpoff())
+		kvm_ptimer_cval_save_restore(vcpu, false);
+
  	___activate_traps(vcpu, hcr);

  	val = read_sysreg(cpacr_el1);
@@ -141,6 +145,15 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)

  	___deactivate_traps(vcpu);

+	/*
+	 * For VHE Host, HCR_EL2.{E2H, TGE} is {1, 1}, FEAT_ECV
+	 * is disabled and CNTPOFF_EL2 value is treated as zero.
+	 * Hence, need to save guest written CVAL in memory and
+	 * increment PTIMER's CVAL by CNTPOFF to avoid false interrupt.
+	 */
+	if (has_cntpoff())
+		kvm_ptimer_cval_save_restore(vcpu, true);
+
  	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);

  	/*
diff --git a/include/kvm/arm_arch_timer.h b/include/kvm/arm_arch_timer.h
index ea77a569a907..ce3f4d9e7dd4 100644
--- a/include/kvm/arm_arch_timer.h
+++ b/include/kvm/arm_arch_timer.h
@@ -117,6 +117,7 @@ void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu);
  void kvm_timer_vcpu_put(struct kvm_vcpu *vcpu);

  void kvm_timer_init_vhe(void);
+void kvm_ptimer_cval_save_restore(struct kvm_vcpu *vcpu, bool save);

  #define vcpu_timer(v)	(&(v)->arch.timer_cpu)
  #define vcpu_get_timer(v,t)	(&vcpu_timer(v)->timers[(t)])


Thanks,
Ganapat

> Thanks,
> 
> 	M.
> 
