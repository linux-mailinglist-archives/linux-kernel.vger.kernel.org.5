Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79C7F5601
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjKWBnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjKWBnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:43:12 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E221B3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:43:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 8AF5B3200A7A;
        Wed, 22 Nov 2023 20:43:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Nov 2023 20:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700703795; x=1700790195; bh=kpJ7rIIPVcAc8EF2r6PrWszTIVA9ySDoeaX
        MPqEdzug=; b=ZzsC+3OGyidfsO/VHJkNN2FTEhdzOA9eTqIDB55G4UkiL9Y74KI
        jYGrIWY+DaaOKg+Hb94tFvrmbOGNoIhsCmf2aNPNsKjhCCghs0Le6aOU9vy8x0Cs
        xURZU2iJ0Hs/kMcSmxBFFID/fValyshTyAjuUgZ/+8yEZNM9YGAZIqWEp8AFuYdT
        jXWfA+aOlfHWKcBJ2jDJHIVOP0tDi36FQ7IGyjrdlnpFnrtTNMCVUS7HpFz2Pd6C
        AeXVs1Jm2ibVM+mQF8i+2qxvFxtpQavFzJYVOWTPzVV1t92KqFAonlXuanT1pR+4
        RKrKwPCGEywEoiuMivfx2Z0SIAedTUCENVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700703795; x=1700790195; bh=kpJ7rIIPVcAc8EF2r6PrWszTIVA9ySDoeaX
        MPqEdzug=; b=n27HfOH34aTHyuth9K0vSvjJvmr7LwpZprEIzwi8YpeW/dolen3
        Tjr8kYJBHFPqScz2957PE0LpnfJ8b7RRAJYRvdybfJySYNPKeIFU76+Ur3HFgmiS
        lTqpC2PQbDCqyXZblc0fFuUAXGRtUjZYTc5K/2QpbUsYIDX5NkRA/3FC9FdHNhx6
        JPvtt8rnotVq02S6TrREBXzqWsJ0hdtvbhbDVd0geGej2RaxOlWREbWwpTBgJGoy
        vl8EC2Ucn0KcFMgl7gC0PuGubh0zZLp5A9ClH0QwGeWsc3ZI8fcJGfz6xfXhXKXZ
        P2NyFYtZ1hJqJ+gwOwSoaxTGut8Dd20Xkcg==
X-ME-Sender: <xms:Ma5eZbT5sqpOezfB-uelhbDpjIB6SGtLymUucWDfwsWiVPV9uds8Bg>
    <xme:Ma5eZcwlcgzXMpbYtxqX7cqQ4NtfsQcjiCgCEGIBpI58UJcdlqy7SlaOiCdNlAhjc
    FlMaiYdALJpATIuCQ>
X-ME-Received: <xmr:Ma5eZQ24_5HHAnFfyhIcMvNQ6abLB_r1uHARSsKWW1W0uKNK6CsaEfi5xRHpMOaQI8M3bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehvddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeetieekgeeilefgtdfgteejhfevtdfgieekvdffjedvvedvveei
    veelfeeuhffhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Ma5eZbB3HCApg14CsXql6FtcVxvPq552AmHZnE3oSv0q4EzKKK5N2g>
    <xmx:Ma5eZUjaKnI94jUJ2nBk5kDhe6xauQNOSArZYkUuU29r86h2fz3yrA>
    <xmx:Ma5eZfo8okfbgTchIox45vxrk7QaYGmpWqvNvqVJic11ufcLsYmNjA>
    <xmx:M65eZcTrGSuzkog0fb29drsK42958bQvo__qx-RQVreNtW2SPbLs4Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 20:43:11 -0500 (EST)
Message-ID: <a0a95390-ac9e-4d82-9727-d4880e5e48ae@sholland.org>
Date:   Wed, 22 Nov 2023 19:43:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/10] perf: RISC-V: Move T-Head PMU to CPU feature
 alternative framework
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Yu-Chien Peter Lin <peterlin@andestech.com>
Cc:     mark.rutland@arm.com, heiko@sntech.de, atishp@atishpatra.org,
        conor.dooley@microchip.com, guoren@kernel.org, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, will@kernel.org,
        anup@brainfault.org, dminus@andestech.com, dylan@andestech.com,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        prabhakar.mahadev-lad.rj@bp.renesas.com, locus84@andestech.com,
        tim609@andestech.com, paul.walmsley@sifive.com,
        linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, evan@rivosinc.com,
        palmer@dabbelt.com, Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20231019140119.3659651-1-peterlin@andestech.com>
 <20231019-predator-quartet-e56f43d5aa8d@spud> <ZTJAYqk_DnrR9-Sc@APC323>
 <20231020-snippet-diffusive-1a6052d52aae@spud> <ZTTmtVnZrioRWpJx@APC323>
 <20231023-impulse-quickness-4c7076e6eb58@spud>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20231023-impulse-quickness-4c7076e6eb58@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/23/23 03:26, Conor Dooley wrote:
> On Sun, Oct 22, 2023 at 05:09:09PM +0800, Yu-Chien Peter Lin wrote:
>> On Fri, Oct 20, 2023 at 10:05:20AM +0100, Conor Dooley wrote:
>>> On Fri, Oct 20, 2023 at 04:54:58PM +0800, Yu-Chien Peter Lin wrote:
>>>> On Thu, Oct 19, 2023 at 05:13:00PM +0100, Conor Dooley wrote:
>>>>> On Thu, Oct 19, 2023 at 10:01:19PM +0800, Yu Chien Peter Lin wrote:
>>>>>
>>>>> $subject: perf: RISC-V: Move T-Head PMU to CPU feature alternative framework
>>>>>
>>>>> IMO, this should be "RISC-V, perf:" or just "RISC-V" as the changes
>>>>> being made to the arch code are far more meaningful than those
>>>>> elsewhere.
>>>>
>>>> OK will update the subject to "RISC-V:"
>>>>
>>>>>> The custom PMU extension was developed to support perf event sampling
>>>>>> prior to the ratification of Sscofpmf. Instead of utilizing the standard
>>>>>> bits and CSR of Sscofpmf, a set of custom CSRs is added. So we may
>>>>>> consider it as a CPU feature rather than an erratum.
>>>>>>
>>>>>> T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
>>>>>> for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
>>>>>> for proper functioning as of this commit.
>>>>>
>>>>> And in doing so, you regress break perf for existing DTs :(
>>>>> You didn't add the property to existing DTS in-kernel either, so if this
>>>>> series was applied, perf would just entirely stop working, no?
>>>>
>>>> Only `perf record/top` stop working I think.
>>>>
>>>> There are too many users out there, and don't have the boards to
>>>> test, so leave those DTS unchanged, it would be great if T-Head
>>>> community could help to check/update their DTS.
>>>
>>> So, there are too many users to add xtheadpmu to the devicetrees, but
>>> not too many users to make changes that will cause a regression?
>>> I'm not following the logic here, sorry.
>>
>> humm, I'll try. I assume that the sun20i-d1s.dtsi is all I need
>> to update for T-Head PMU.
> 
> I think you can actually add it to all users of T-Head CPUs currently in
> mainline since all those cpus report the 0 mimpid and 0 marchid that is
> being used as the detection method in the current code.
> 
> That said, changing the in-kernel devicetrees doesn't solve the
> regression problem. Not every dts lives in the linux codebase, for
> example, and just because they don't, doesn't mean we can just not
> care about them!
> 
> As a result, I don't think that we can just do a conversion here from
> one method to another like this, since it's likely to break things for
> people. Certainly interested in hearing from those that support the
> T-Head IP based SoCs about whether they'd be okay with something like
> this.

PMU support is not required to boot, and it didn't really work correctly anyway
until OpenSBI commit c9a296d0edc9 ("platform: generic: allwinner: fix OF process
for T-HEAD c9xx pmu"), which is still not in any released OpenSBI version.

So I am fine with requiring a devicetree update for continued PMU support.

Regards,
Samuel

