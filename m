Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C876BE72
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjHAU1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjHAU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:26:58 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F1268C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:26:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 434025C018C;
        Tue,  1 Aug 2023 16:26:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 16:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690921617; x=1691008017; bh=UY
        atibP40K4I2B9IENly3nEtY126fQ2AXlmH0dKm10Q=; b=Xp+GIn40oDnDFpaLvp
        19QuHjcHwLGtp5p67HqAy7vMqhoXIEaMxFfdmaT9COFVz7o7w+of5HY4KJMqQ8C0
        GgNN0gRsE8JcklZs2bcHESNAtbbQwZmG/O7imHnjD4jLJcwGzv9Lv1ZyzBpGxN3H
        XEpAqpU4fJCus4/VjpdgcqPqTadBw0a24TuyEO5xBtOCybbMyJ32sbIv0xl3ZP1S
        vzjHrRIGQf8QyM0VOJIrVVFxYDkTp4rF0ckjI9K15ZszJjl29o800j2cSukjgBRJ
        w5B/3/oRzpHGVonB90uo1Fyamx56nUtUGk3BQyR47JzJFPPBTPaP+Mjps+5XaRSm
        tuCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690921617; x=1691008017; bh=UYatibP40K4I2
        B9IENly3nEtY126fQ2AXlmH0dKm10Q=; b=CnMDC/jyzCnOa2st6mA269KKtKXZg
        2CcVSp2xQfGMwa47YVu5FByTSknAhHUCR9ptD2x32E1BOYWvHSS4t8xzx7rhtRhX
        P+pqrPclo7vgmRwKTuwQx/kYlTdkHofn/OuG4vlpnSmLgC3yInjoymHVVwTcjWuO
        v/ycPMGjuU0YStChJh0iA06JGvC6osn9HJY1mGqyoPKoeOIp7ZQi6/tipo0ZU56h
        E5Gtfy+IOcbhGa3tcW3z1pp/FS5hSvnQdl7xQnqvr+JkhKOvyojGAmdl21lqVsTD
        geqGtF+KEA8vlqgMddgIr7Rwmv+rhNzqpzNjE6vVly1ndq6Osjm8g8tyQ==
X-ME-Sender: <xms:kGrJZKsmXAWqX44hTIvClcH7SGWfBtYZpfbk_zw-brFFrhYolBHrxw>
    <xme:kGrJZPc0lEr8NC8xoF641EwH8WUs-RHwwV5_FFxrMoagyse7ZOHCtmB_jdkF55CDw
    n4NLeJUJHh0cptnRQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigddugeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kGrJZFzPxOXjvLZjKvvCErUFWSpuxbWJq3L6om8ZwOj8jlSRlV1XQg>
    <xmx:kGrJZFNezNyS-yPOBU_i40nvAhBJtRYGwZvgcAy39n6wX0zdBXMD7A>
    <xmx:kGrJZK9_isrcW7kvvkikmNZwjV6_FdGA7pEhcNZcFFGgGwnRgXxXjA>
    <xmx:kWrJZBnvgBPPvh0Je65j-_229gr6pvxFRCsZ_aK0pc0AWMwm6lJIgg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 908BBB60089; Tue,  1 Aug 2023 16:26:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <21188533-a56b-484b-8cb7-053f38a4155c@app.fastmail.com>
In-Reply-To: <20230801192217.GHZMlbaVMBavu909lb@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-4-arnd@kernel.org>
 <20230801192217.GHZMlbaVMBavu909lb@fat_crate.local>
Date:   Tue, 01 Aug 2023 22:26:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/5] [RESEND] x86: qspinlock-paravirt: fix mising-prototype
 warnings
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 21:22, Borislav Petkov wrote:
> On Tue, Jul 25, 2023 at 03:48:35PM +0200, Arnd Bergmann wrote:
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index 89842bb7ec9cc..64a6bba70d183 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -73,11 +73,13 @@ DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
>>  
>>  DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
>>  
>> +#ifdef CONFIG_SMP
>>  void __init native_pv_lock_init(void)
>>  {
>>  	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>  		static_branch_disable(&virt_spin_lock_key);
>>  }
>> +#endif
>
> Can you add an empty UP stub instead?
>
> We all have a great aversion against ifdeffery...

There is already a stub for !CONFIG_PARAVIRT in asm/qspinlock.h,
but the problem is that this header does not get included
anywhere in UP configurations. 

The variant below would avoid adding more #ifdefs, by moving
the declaration into asm/paravirt.h to ensure that it's
declared even if there is no caller.

Does this look better to you?

     Arnd

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b49778664d2be..fc3a377bb9b79 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -739,6 +739,7 @@ static __always_inline unsigned long arch_local_irq_save(void)
 	     ".popsection")
 
 extern void default_banner(void);
+void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLY__ */
 
@@ -776,8 +777,13 @@ extern void default_banner(void);
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
+
+static inline void native_pv_lock_init(void)
+{
+}
 #endif /* !CONFIG_PARAVIRT */
 
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index d87451df480bd..cde8357bb226d 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -74,8 +74,6 @@ static inline bool vcpu_is_preempted(long cpu)
  */
 DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
-void native_pv_lock_init(void) __init;
-
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
  * virt to hijack it.
@@ -103,10 +101,7 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 
 	return true;
 }
-#else
-static inline void native_pv_lock_init(void)
-{
-}
+
 #endif /* CONFIG_PARAVIRT */
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 89842bb7ec9cc..066fc19d2568e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -75,7 +75,8 @@ DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
+	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
