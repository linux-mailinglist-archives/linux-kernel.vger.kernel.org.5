Return-Path: <linux-kernel+bounces-64017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E2A853907
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4596CB28972
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3C4605C4;
	Tue, 13 Feb 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="0Y7ohKHl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1eVfOT8"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53052605A6;
	Tue, 13 Feb 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846819; cv=none; b=Y3ZRSjmGxKhG9LV9jDM6tRPvGXgnw0qgndM0iRtjmZPer9NoSr5KPi6XveIGu79c2Ngu0mKMV8YaUa/db8p25PPkIFjTi0/ot2r+VbepLvaPxkvcwAXh8bW5h0OGS8qXxS3aM8avnxPLg6OidqiLZ66yEwB5PgcZ4gBVkU/pvuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846819; c=relaxed/simple;
	bh=bIx87ZWq9KbmlT/JzqFTsMtpo1cfuGEVBiegMksFiPg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=QhnXJkydkXkUDdl+l8gTHrQ6wbaH6SLF2CR6J1GWhlbsMqXX4VJheKTRS8B0msCiJQsn52pSL1ioTxc9WIYos5VbN5/4RorHSdWjbK2lMTuPtghDcf1nqg4c8sJsnHo5RYjhbUJiS6ePfQTJAkmgf06sibBRpUdEZKSMSFNik6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=0Y7ohKHl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1eVfOT8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3EDDB1380117;
	Tue, 13 Feb 2024 12:53:36 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 13 Feb 2024 12:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707846816; x=1707933216; bh=8mleJuj679
	ygYILvbygRdHtWVUTucGcTJaSJeTlmfSc=; b=0Y7ohKHlcN0B2CiZQYA9AC5ENc
	Zv/8+O8gMIzzih9c+jerfLp5GbyaTjP8s1mZ7qfRnYtEWhsJ2mRLplEd8Dnt9zJd
	G6Y6zRK/e7u5hIzQ2P37ptDWM51obLZ9ipfY+VSSf5sYdwY5pccTAFhGfhWQS6JA
	iqp/KdeuECcXeIVKyR7KrMMOAVIZADFrsMG/tg8F1APG5g4uycEHXAwU9utt+TUJ
	3NwaLPY6CYuRtkmxDu9oFFe3DxTBIvftD0K55zl0L8DGuhzleWqkO+yOMJw8IiLq
	SO4+IDUsC2zEecFEdbg7CmZQfmX4bOAk6d1shiMs+gRZT9kDWTEvn7pr+3/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707846816; x=1707933216; bh=8mleJuj679ygYILvbygRdHtWVUTu
	cGcTJaSJeTlmfSc=; b=H1eVfOT89hwGomwg92IfjH45ZXEHrY7WWx3vPo4QQ+9a
	e7ibPHKThKuzxp/ouyDdMN7zjowHIIH/96bFRvqGqPXKWW0HbXc4jyynVufsEjxs
	dRUMN31OUnMkWhqDCNjWs/Cx+ZwkMdGjHIju2hmenKe25L3zk3pkv3aG+xpQvNXQ
	yYEL2dzpHrxQZtufAB4KMnOlKBamDeHrDzgjH7VwWFNPqecQt4MxzTzAkj9LPG6w
	MYnwswea+qYSy9GMGKCKbH7IwMzRkCgraMhmA41oqG6Gt5NqiIOGWd5UiSgPTQuI
	dgXevKTg9HMPnhHR2jp2WP11dHU6ez9/vO3+XyNaFA==
X-ME-Sender: <xms:oKzLZUzV_Nv5_w1roqANU7J0xXueW_kEGm4joO7_l-vJvMJa0G9hBg>
    <xme:oKzLZYQ1T6SHmZe49RarxmLZohwHf5_nCPc050pMP0BhlAajoeICJY5zY5wqjwWUQ
    0-YkakFJtcjiFcwcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:oKzLZWW53uSyE72lD3GcDr0irq3sqpib_7aEMTC7mEoHgpbXLusyUA>
    <xmx:oKzLZSgaZVEzBLyWABNm9R29_pT1MMP0uq8Z_KqohshrgzFU1xRoRg>
    <xmx:oKzLZWDXr4b8Bm0AiVifXcpDBYmdOPB1f_9TZ01Gj6t1ptAHGZsxTA>
    <xmx:oKzLZd7y8Ss2SnFThD2JCwQq7cXmXZV35dgdpadlt4ZYy8cofgVBMA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id F154A1700096; Tue, 13 Feb 2024 12:53:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <937f0593-0bc8-4df3-aa0e-9059acfd7636@app.fastmail.com>
In-Reply-To: <20240213-86af3b49821630b5bdd76c0a@orel>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-5-samuel.holland@sifive.com>
 <20240213-86af3b49821630b5bdd76c0a@orel>
Date: Tue, 13 Feb 2024 12:53:15 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Andrew Jones" <ajones@ventanamicro.com>,
 "Samuel Holland" <samuel.holland@sifive.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 4/4] riscv: Save/restore envcfg CSR during CPU suspend
Content-Type: text/plain



On Tue, Feb 13, 2024, at 9:49 AM, Andrew Jones wrote:
> On Mon, Feb 12, 2024 at 07:37:35PM -0800, Samuel Holland wrote:
>> The value of the [ms]envcfg CSR is lost when entering a nonretentive
>> idle state, so the CSR must be rewritten when resuming the CPU.
>> 
>> Cc: <stable@vger.kernel.org> # v6.7+
>> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>> 
>> Changes in v2:
>>  - Check for privileged ISA v1.12 instead of the specific CSR
>>  - Use riscv_has_extension_likely() instead of new ALTERNATIVE()s
>> 
>>  arch/riscv/include/asm/suspend.h | 1 +
>>  arch/riscv/kernel/suspend.c      | 4 ++++
>>  2 files changed, 5 insertions(+)
>> 
>> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
>> index 02f87867389a..491296a335d0 100644
>> --- a/arch/riscv/include/asm/suspend.h
>> +++ b/arch/riscv/include/asm/suspend.h
>> @@ -14,6 +14,7 @@ struct suspend_context {
>>  	struct pt_regs regs;
>>  	/* Saved and restored by high-level functions */
>>  	unsigned long scratch;
>> +	unsigned long envcfg;
>>  	unsigned long tvec;
>>  	unsigned long ie;
>>  #ifdef CONFIG_MMU
>> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
>> index 239509367e42..be03615486ed 100644
>> --- a/arch/riscv/kernel/suspend.c
>> +++ b/arch/riscv/kernel/suspend.c
>> @@ -15,6 +15,8 @@
>>  void suspend_save_csrs(struct suspend_context *context)
>>  {
>>  	context->scratch = csr_read(CSR_SCRATCH);
>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
>> +		context->envcfg = csr_read(CSR_ENVCFG);
>>  	context->tvec = csr_read(CSR_TVEC);
>>  	context->ie = csr_read(CSR_IE);
>>  
>> @@ -36,6 +38,8 @@ void suspend_save_csrs(struct suspend_context *context)
>>  void suspend_restore_csrs(struct suspend_context *context)
>>  {
>>  	csr_write(CSR_SCRATCH, context->scratch);
>> +	if (riscv_has_extension_likely(RISCV_ISA_EXT_Sx1p12))
>> +		csr_write(CSR_ENVCFG, context->envcfg);
>>  	csr_write(CSR_TVEC, context->tvec);
>>  	csr_write(CSR_IE, context->ie);
>>  
>> -- 
>> 2.43.0
>>
>
> We're still exposing Zicboz to userspace in hwprobe when only
> RISCV_ISA_EXT_ZICBOZ is present, which will be the case for anything that
> either doesn't implement 1.12, but does implement Zicboz, or maybe does
> implement 1.12, but hasn't started putting Ss1p12 in its ISA string yet
> (e.g. QEMU). We should either stop exposing Zicboz to userspace in those
> cases (since it won't work) or rethink how we want to determine whether
> or not we have envcfg CSRs.

opensbi treats the existence of menvcfg as sufficient evidence to prove that
the hart supports 1.12.  I wouldn't object to having Zicboz imply Ss1p12/Sm1p12.

-s

> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

