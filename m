Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DB277C207
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjHNVCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHNVCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:02:10 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918CD19BE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:01:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 77B855C0052;
        Mon, 14 Aug 2023 17:01:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 14 Aug 2023 17:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1692046872; x=1692133272; bh=PaaaRJ88pAh6QvTF6BgB0yJWtocqWOgZDpE
        HWj3YHpo=; b=Vk1XMBMmLgIplOz5+pHFOaOmA7bV6WXtSXTVJNGQbpLhODD3128
        wLiuRY1D+L4ar9Bae3vvYZPuV2x/ofRzBa3stBJ45EFw4JWlJVSzrLCSDYw35lhp
        6KMcOhdYErZmM/QwOYE+lJ8+Vm/TFnjDcTmaXpKim5CJ5hsgdKIU2ylNlvbRK4BS
        H5kqgB/IKD8o1YFSDMpFtxXXGNGCgcfcjXnmlJJCT8yLy0e0i2N78BAZCH2DPxOH
        lxq8jirX87vvdLaUTSpiBcoOkRTBoUC5fVEiHjsypLxr68yYw1lZvr3ol6kaqJRU
        LVKomyWUDP0F83dprj+mxdg3lemM130+C6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692046872; x=1692133272; bh=PaaaRJ88pAh6Q
        vTF6BgB0yJWtocqWOgZDpEHWj3YHpo=; b=ZLaIsJnqzXhgs83O4IMjnqtrEX/pz
        NkzXVqCbQxGitK4Jhj6VSCQszAGHNrrmCybD6mDvVFuRb3t4j2F/3jQ9dErcbmHE
        leb/exVO8//ePqRP7pjEejdvz34wm3isK6VI/737N+EzT8PPSAgD6kHn0Ri3Z7Mu
        dWzAQTJZCjOBGmWLHjnfFLmQ92w9r7bCJX6mpmg8JxJNjdOsQ032tDZq38u1KlEe
        2DoAiyUXpiKUKxcXejySez7WRf9sNgTzdDY+K+Go3VH4c5DQHJNfewk4HRJ61v4T
        mpeRYvQ3GrNfuU2uY/daHmlG1h6IOlYpTU6aUxBPt229F3ksorxu7m4BA==
X-ME-Sender: <xms:FpbaZCdOMlA6IZs42xwcQ9r1O4FHjrveQeaFlQV6VVh71UKLaucyLg>
    <xme:FpbaZMNsjH3IKM6KD6hQ-pK1r59U-EKrB79I19kVmnka5Sw5Pcwb1vO7gtXNPDDN6
    C9zFeAGpRfQf3cN5SU>
X-ME-Received: <xmr:FpbaZDjZpfOPjfRACFVSngOCaxODBzrNjXL_niEjXtNglheFIBu4HLcGYITe6p-C7oqlq1hOTtSi8bemLU2rvztZY0hMu5Ju>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddthedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheplfhoshhh
    ucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduieegheeijeeuvdetudefvedtjeefgeeufefghfekgfelfeet
    teelvddtffetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:FpbaZP84SdN71yXiR8YTIf-ukFItEEfygYuOuY9Cxi2R7uEo_j2zxg>
    <xmx:FpbaZOsiuqhR_OE_ZIZiOmNxk9l0D2UhI7yYptS2_b0JJfv8xrXVfg>
    <xmx:FpbaZGGcKo7CxdhRagYf2H6ano60zQcBJh0DyonkoOolPpxqKbPWww>
    <xmx:GJbaZAWKsig8Htwl_TRmXpOMAtBa_9ss6EBs_zH0_BVvg4O7OJofXg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Aug 2023 17:01:07 -0400 (EDT)
Date:   Mon, 14 Aug 2023 14:01:03 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 02/37] x86/microcode: Hide the config knob
Message-ID: <ZNqWD2CKFfa0nSqS@localhost>
References: <20230812194003.682298127@linutronix.de>
 <20230812195727.660453052@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812195727.660453052@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:58:39PM +0200, Thomas Gleixner wrote:
> In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
> Intel or AMD support is enabled. Accomodate to reality.

> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
>  	  Say N otherwise.
>  
>  config MICROCODE
> -	bool "CPU microcode loading support"
> -	default y
> +	def_bool y

There is one completely reasonable configuration that does not need or
want CONFIG_MICROCODE: a kernel configured to run *exclusively* in a
virtual machine, with no support for booting on physical hardware.

Would it retain an excessive amount of complexity to support omitting
this code in that use case? (Doesn't have to eliminate *every last bit*
of support code; just hoping to eliminate as much as easily possible
without adding non-trivial complexity.)

I'd be happy to help keep this case building. Would you consider
accepting a patch atop this series re-introducing minimal support for
disabling this?

(I am all for eliminating the added complexity of the separately
configurable knobs for CONFIG_MICROCODE_INTEL and CONFIG_MICROCODE_AMD,
and just having those be unconditionally enabled if CONFIG_MICROCODE
is.)
