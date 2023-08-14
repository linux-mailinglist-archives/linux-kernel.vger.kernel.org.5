Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC21A77C419
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjHNX56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjHNX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 19:57:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51091738
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 16:57:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F74F5C0091;
        Mon, 14 Aug 2023 19:57:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 14 Aug 2023 19:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692057458; x=1692143858; bh=RkOWZYvREjVZVSchqVarX+O9HxVq93B/IRy
        UEDOrIG0=; b=nA6FhDu90vR4Kz4+mCApwVtm/g2R0FYrbPaYKfJ1iXLwAJQ/aBF
        BYvKTlFJOxCjkuLt/Z4jK0TzPffib5MYc5FdgQcHXFk0fXEUEfhoYb+gL/93Eqsb
        Y3yjum6dEV9BM37SzGZ+7/VODnZdsRFzGsVCLq/FHqdybOMjP2wP1KmsCkIDTmMs
        nmcwNMAfFqB5Mvo3FKUjYqLYDImHF4aJIMeIBabWL75Q5oCIfJWJcDFH/mPEyW3W
        VnTqBKS5BV6GTFCf0nU1lkHislnRxpFvlbzT3H2bC+f1CXu1/Udqn6a8iGkkBv3a
        TZv0sVsC30oOpMvW60aMmtVAnvmZEYduLNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692057458; x=1692143858; bh=RkOWZYvREjVZV
        SchqVarX+O9HxVq93B/IRyUEDOrIG0=; b=E0T7d+FtjQzJf3fJOrPgxTbunDc5j
        DwmbRTOGw8bXXVxYvRftqUHS2msi+pfs7GAmUgfsnQ41mhC93Ct876ypmxp0guHX
        R53OEoLLp0bJrtTCm9tNhN7fSPthaK9cjZbtiKmD36wbDNNkahjthrHarhu4o19t
        As1pjkTWgyIBDXXb0KdbyOcrvti7yFy+BnLHAuGAQvO7R+GdRvd7HlELmCci7Rgo
        wqzXLFA2E8JbVxXatYW3bncGpdaHaEGS8t/M/7Y6XiK/5pIcfAJw0d9J0bsBfOd/
        rBkks25mUw8LthGqceUCInmYXGlIWBNkWOqTYadXRUWKQXz3Lql6y6VZw==
X-ME-Sender: <xms:cb_aZCk0QcwQEGzq0cLYpsPnWWCF_rMSgBEew7VbowNL-PNyO7cGJQ>
    <xme:cb_aZJ0nYnghHmXTQkPTH-e_vvhPEyBDCnAuEVoXtys_z5H8hxczvTyxA1Ql5wbHd
    fi8A9bYlKGSOxaa2TU>
X-ME-Received: <xmr:cb_aZApEfhM4Au5b9AI5ESakml-TjWqjqpyiEodY7tpGNS2vk3H_sYskvM5_47L_OIKZdDQCWO_bToTWjvvIEY3qnLgscl6z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:cb_aZGlg_2eF_mPaKj9F-Ogyr9OMZZwUagjrcCRUzUxfUjv5oWKxzw>
    <xmx:cb_aZA0nauP7hmVgCyJE9pxD8FTIjltiNRlvP1pZd3Rwr-Kd5QAXpQ>
    <xmx:cb_aZNvqKvoPOj5WX9E41Y9PfrO97C0CIXo5s6sypHttCt-yLKEcMA>
    <xmx:cr_aZE81xm7Pl-qPPBUXbvyRZyRHPMFlP_t-jy7Qm9_vn4_BvzcuVw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 19:57:32 -0400 (EDT)
Date:   Mon, 14 Aug 2023 16:57:30 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 02/37] x86/microcode: Hide the config knob
Message-ID: <ZNq/agLqraP0IYwR@localhost>
References: <20230812194003.682298127@linutronix.de>
 <20230812195727.660453052@linutronix.de>
 <ZNqWD2CKFfa0nSqS@localhost>
 <20230814211912.GMZNqaUD6FriYo1wOo@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814211912.GMZNqaUD6FriYo1wOo@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:19:12PM +0200, Borislav Petkov wrote:
> On Mon, Aug 14, 2023 at 02:01:03PM -0700, Josh Triplett wrote:
> > I'd be happy to help keep this case building. Would you consider
> > accepting a patch atop this series re-introducing minimal support for
> > disabling this?
> 
> And a couple more KBs of builtin code is a problem because?

Multiple reasons. First, because "a couple more KBs" (concretely, 4637
bytes in this case) add up across the kernel. Second, because disabling
something is the easiest way to guarantee spending *zero* boot time on
it. And third, because I just confirmed that this requires a *trivial*
patch to support (apart from re-enabling the config option):

--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -68,11 +68,12 @@ static inline u32 intel_get_microcode_revision(void)
 
         return rev;
 }
+#endif /* CONFIG_CPU_SUP_INTEL */
 
+#if defined(CONFIG_MICROCODE) && defined(CONFIG_CPU_SUP_INTEL)
 void show_ucode_info_early(void);
-
-#else /* CONFIG_CPU_SUP_INTEL */
+#else
 static inline void show_ucode_info_early(void) { }
-#endif /* !CONFIG_CPU_SUP_INTEL */
+#endif
 
 #endif /* _ASM_X86_MICROCODE_H */

