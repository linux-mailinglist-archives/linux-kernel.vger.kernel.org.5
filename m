Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AEB761812
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjGYMPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjGYMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:15:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82439E47
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:15:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id ED1245C01FA;
        Tue, 25 Jul 2023 08:15:38 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 25 Jul 2023 08:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690287338; x=1690373738; bh=x7
        RdA6HkHk9XBkKwdbWXosbMRCX7flB76C3ELguQTWE=; b=a99vJQgQu58AY9xeH8
        /KMQwZ056KkvG+FiIoaaAAXjf1d4QEvxBW/hv1BJlnpa1bkEWyVK+ugCLjMrf6Lv
        bmGj2hfvaoPadFPstdg2T5OsrH+/b18Zk5Inc7BYSidHMdsIrQloIkFuVR/nwHBr
        l4+hlTYZd1HeN+LnVt4G2etOytfFO7UDIVE+EggRXijIrDrLCCDGVTPHnpBaX/Pr
        1AeWgUiketUVuq1Qom/bAJhiZHe+6nMUNGdGOz6jcOvfHBzB1kwCWan+vgfWjis3
        m3AWWBo84thPCpPyB28/t8Lc6Y/3lOp6e1N4izj1MtG+bJCipaHbQftVjYDK9Upt
        oW/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690287338; x=1690373738; bh=x7RdA6HkHk9XB
        kKwdbWXosbMRCX7flB76C3ELguQTWE=; b=BRBch4Cjhh2ZBXU0Xkez1VZujaKMu
        nj+CctUgfHwnNKDiDvkRz0TreXSHj1M8UhzRb+4nafV7dt5MRiz/aMruKINhRz3d
        qNdv2fUeyp+DLcb7GnqiNCEF2o/LsnuLTmnVfEr2rGx5AdQHMYDvABXOHaada1My
        YcgriJhz9gpqDhntMJ3WGupHUM2r5L0SKbsXaFy/uniO1sQbmvv4rmKJlfPbpAGm
        pO0CdZRMpekVBZZAKiNX8P5hwnk0Qxe3K3RBJu8bcfoeCO8RD6Ih6aSMdaquhcyV
        AgTRKHk/3P7uv9ViXWiNP17OlG4jDw8Ca80K6PV78A6yiYX3wXylSsMmA==
X-ME-Sender: <xms:6by_ZIIosGTOSfn0C_a-DWZAG5YwPzIw2mW-2fuiy02svcb267HK_Q>
    <xme:6by_ZIInNH-G5KmCTLIJpm4j5fPAeTw80sMKOAbQPiPz4ia_94Gpwt8Xy0tjA0bZx
    iH49W2SgJSL7RU-ITY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6ry_ZIv26yOl29wWRnMYXUnS5nFCrGN8E1q67b52ba-Md57va4x_Bw>
    <xmx:6ry_ZFZHAGIQCee1kSBBOMPZN5E129DL5v23qTBHZ0H23G76t1oDmA>
    <xmx:6ry_ZPZnwY0TsBWAJNnoLybG0PkUIrgyH2ZoMIX6mbKQaXnW80g26A>
    <xmx:6ry_ZNOXgQUgS6GPZGbeC3JlLgAnDKhh0bAHR1f3y0F51Wo9LKvCBg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D3B11B60089; Tue, 25 Jul 2023 08:15:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-590-ga55e740577-fm-defalarms-20230718.001-ga55e7405
Mime-Version: 1.0
Message-Id: <eef33234-40f1-41da-a9ac-73b24a764123@app.fastmail.com>
In-Reply-To: <20230725092046.GAZL+T7ln/TKBOuihi@fat_crate.local>
References: <20230725082638.956675-1-arnd@kernel.org>
 <20230725092046.GAZL+T7ln/TKBOuihi@fat_crate.local>
Date:   Tue, 25 Jul 2023 14:15:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Kim Phillips" <kim.phillips@amd.com>,
        "Alexey Kardashevskiy" <aik@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Fix amd_check_microcode() declaration
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023, at 11:20, Borislav Petkov wrote:
> On Tue, Jul 25, 2023 at 10:26:13AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The newly added amd_check_microcode() function has two conflicting definitions
>> if CONFIG_CPU_SUP_AMD is enabled and CONFIG_MICROCODE_AMD is disabled. Since
>> the header with the stub definition is not included in cpu/amd.c, this only
>> causes a -Wmissing-prototype warning with W=1
>
> Can we please promote -Wmissing-prototype to default or is it too noisy
> yet?

I'm working on it, currently missing just 15 patches (down from 70 in 6.3)
before all randconfigs on x86 and arm are clean.

>> diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
>> index 9675c621c1ca4..6a860d40b0411 100644
>> --- a/arch/x86/include/asm/microcode_amd.h
>> +++ b/arch/x86/include/asm/microcode_amd.h

>> +#ifdef CONFIG_CPU_SUP_AMD
>> +extern void amd_check_microcode(void);
>> +#else
>>  static inline void amd_check_microcode(void) {}
>>  #endif
>> +
>>  #endif /* _ASM_X86_MICROCODE_AMD_H */
>
> Considering how cpu/amd.c provides the function implementation, that
> header gunk should not be in microcode_amd.h but in ...asm/processor.h,
> I'd say.

Ok, I'll send a v2 with that changed.

     Arnd
