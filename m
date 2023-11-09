Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1A7E6B12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKINNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjKINM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:12:59 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3FB2D7D;
        Thu,  9 Nov 2023 05:12:57 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C5C203200B38;
        Thu,  9 Nov 2023 08:12:56 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Thu, 09 Nov 2023 08:12:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699535576; x=1699621976; bh=VUoLuTRFhMmnckn2Yaf8HbYIFSNgbAvysFC
        peIQOBok=; b=qlGUE0ss2rp3PU81gzKbAgP69MRSWgKCN8AR879kv+fz8Gj5GoB
        bHe/CKcuqFjFPtvDThE52F3pfPx7D/tOt+K2DV7WAA+4N668AULlpYN79rW/7yDM
        aj8L3iwdMJdSOxxaKTzRMTpHtixwCKLJvoZo5SkFgNaolxc3C6PbSzpWi1xQYCZ7
        Ty5zAcLMFw/RsIpL0UKP5+lE7irnADt6GbyPHOGyhHBFchicYKP68c/kpBYZy+tw
        zaOco3/5uAM0ftc70e2NPqRTly3TU9RMyRHBfCbgkySs7GZ4G/xQVOOKvxg9O+JA
        fc+w++zBVpPkUXWdsJQOx04fCxhryHnZFiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699535576; x=1699621976; bh=VUoLuTRFhMmnckn2Yaf8HbYIFSNgbAvysFC
        peIQOBok=; b=LFXWh8lUOAQnM8234AXyKozL2bqOducTR0rsIY/YpElF5a2X2p2
        aU8SO+OtgK58gxrGE7dzQFxo+uFrjrq3hF3Wcag/0NqY6f82HHFnSYmg8T0LI1Ir
        qJjpI5ZqXYKJUoU2MroyAN9wY6B7Hw4Jr3XzKrg9Jhm1Y4dE7j9et7HzQDu+/2Oy
        nqtspg+vti8fp/pnelB6CNV6mzX91yCRo7z8M4exbv3rhim3d44ndN2NM5AsaZ8t
        7honL4MQjzrXQZiUQhPfUoLDVMw5iWAk9m5ybpdh3RM60kItWjR6JliYGN2pEwPk
        IU+2mCpE09ADaMTD+mNFX1AYu5nXnZBzr7Q==
X-ME-Sender: <xms:19pMZaQQkLgqOYjzfbYDzN88I5G7omhUK4wEf_3cTndemLTppqxEcg>
    <xme:19pMZfyJcNvThvyZX1aJlayiID4LI4gZL7yGMiCO_lxEgNUPjWV24THXPqPBJdfEg
    SxucOwfPySX59Knvhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:19pMZX2Akz5ojDYmyYjBfbN2JJUx_3rtJXofWOr6etd3sWD2FW0oJg>
    <xmx:19pMZWBvXUhv6oT7LGbnzG4BQPf3rO-5v93vPGWwx58i5n3eWJhiWw>
    <xmx:19pMZThwnOoMrVRLqgyuJi-dWSxjrjbQPBqYDyD0Lo2TLARjgUjbXw>
    <xmx:2NpMZWtMwCTu01rFVR7pzE7d9vDpjKTa9NNNBzIT-UrliGWI1x7YJg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B44E536A0075; Thu,  9 Nov 2023 08:12:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <1c17f4da-4f40-408a-80d9-f534d8bddb6a@app.fastmail.com>
In-Reply-To: <87o7g46wcp.fsf@BL-laptop>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
 <20231027221106.405666-6-jiaxun.yang@flygoat.com> <87o7g46wcp.fsf@BL-laptop>
Date:   Thu, 09 Nov 2023 13:12:29 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        vladimir.kondratiev@intel.com
Subject: Re: [PATCH v2 05/10] MIPS: Refactor mips_cps_core_entry implementation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=888=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =E4=
=B8=8B=E5=8D=884:30=EF=BC=8CGregory CLEMENT=E5=86=99=E9=81=93=EF=BC=9A
> Hello Jiaxun,
>
>> Now the exception vector for CPS systems are allocated on-fly
>> with memblock as well.
>>
>> It will try to allocate from KSEG1 first, and then try to allocate
>> in low 4G if possible.
>>
>> The main reset vector is now generated by uasm, to avoid tons
>> of patches to the code. Other vectors are copied to the location
>> later.
>>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>
>> +
>> +static int __init setup_cps_vecs(void)
>> +{
> [...]
>> +
>> +	/* We want to ensure cache is clean before writing uncached mem */
>> +	blast_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) +
>> BEV_VEC_SIZE);
>
> In my case this call failed because when setup_cps_vecs is called, the
> cache information are not initialized yet!
>
> As a workaround I moved the cpu_cache_init() call before
> plat_smp_setup() in the /arch/mips/kernel/setup.c file.
>
> Obviously it is not the right thing to do, but it shows that the cache
> related function are called too early. For example, in
> blast_dcache_range, the value returned by cpu_dcache_line_size was 0
> instead of 64, because the value cpu_data[0].dcache.linesz was not set
> yet.

Oops, that's a problem!

>
> So I wonder who it managed to work in your setup. What is the machine
> running in QEMU .

I'm using QEMU boston with vmlinux only.

QEMU does not emulate Cache at all so that won't be a problem on QEMU
but it may be a problem for actual hardware.

The proper solution might be leave allocation here but move uasm generat=
ion
to a later point.

>
> Does it use someting like the following line ?
> #define cpu_dcache_line_size()       32
>
>
>> +	bc_wback_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
>> +	__sync();
>> +
>> +	cps_vec =3D (void *)TO_UNCAC(cps_vec_pa);
>> +	mips_cps_build_core_entry(cps_vec);
>> +
>> +	memcpy(cps_vec + 0x200, &excep_tlbfill, 0x80);
>> +	memcpy(cps_vec + 0x280, &excep_xtlbfill, 0x80);
>> +	memcpy(cps_vec + 0x300, &excep_cache, 0x80);
>> +	memcpy(cps_vec + 0x380, &excep_genex, 0x80);
>> +	memcpy(cps_vec + 0x400, &excep_intex, 0x80);
>> +	memcpy(cps_vec + 0x480, &excep_ejtag, 0x80);
>> +
>> +	/* Make sure no prefetched data in cache */
>> +	blast_inv_dcache_range(TO_CAC(cps_vec_pa), TO_CAC(cps_vec_pa) + BEV=
_VEC_SIZE);
>> +	bc_inv(TO_CAC(cps_vec_pa), BEV_VEC_SIZE);
>> +	__sync();
>> +
>> +	return 0;
>> +}
>
> [...]
>
>>  	/* If we have an FPU, enroll ourselves in the FPU-full mask */
>> @@ -110,10 +241,14 @@ static void __init cps_prepare_cpus(unsigned in=
t max_cpus)
>>  {
>>  	unsigned ncores, core_vpes, c, cca;
>>  	bool cca_unsuitable, cores_limited;
>> -	u32 *entry_code;
>> =20
>>  	mips_mt_set_cpuoptions();
>> =20
>> +	if (!core_entry_reg) {
>> +		pr_err("core_entry address unsuitable, disabling smp-cps\n");
>> +		goto err_out;
>> +	}
>> +
>>  	/* Detect whether the CCA is unsuited to multi-core SMP */
>>  	cca =3D read_c0_config() & CONF_CM_CMASK;
>>  	switch (cca) {
>> @@ -145,20 +280,6 @@ static void __init cps_prepare_cpus(unsigned int=
 max_cpus)
>>  			(cca_unsuitable && cpu_has_dc_aliases) ? " & " : "",
>>  			cpu_has_dc_aliases ? "dcache aliasing" : "");
>> =20
>> -	/*
>> -	 * Patch the start of mips_cps_core_entry to provide:
>> -	 *
>> -	 * s0 =3D kseg0 CCA
>> -	 */
>> -	entry_code =3D (u32 *)&mips_cps_core_entry;
>> -	uasm_i_addiu(&entry_code, 16, 0, cca);
>> -	UASM_i_LA(&entry_code, 17, (long)mips_gcr_base);
>> -	BUG_ON((void *)entry_code > (void *)&mips_cps_core_entry_patch_end);
>> -	blast_dcache_range((unsigned long)&mips_cps_core_entry,
>> -			   (unsigned long)entry_code);
>> -	bc_wback_inv((unsigned long)&mips_cps_core_entry,
>> -		     (void *)entry_code - (void *)&mips_cps_core_entry);
>> -	__sync();
>
> The original code here was called later during boot from
> kernel_init_freeable() which is called by kernel_init() after all the
> calls in start_kernel. That's why there were no issue before the move.

I guess move uasm generation code here will be helpful :-)

>
> Gregory
>
>> =20


--=20
- Jiaxun
