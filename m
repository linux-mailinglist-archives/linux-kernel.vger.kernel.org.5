Return-Path: <linux-kernel+bounces-95214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C783A874AC3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798CA1F272F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC03839F6;
	Thu,  7 Mar 2024 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eEcZYZ3o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRvFEZ0x"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB23C4204B;
	Thu,  7 Mar 2024 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803394; cv=none; b=V4ketO0TNxymwSEtb0tsDUrpzQdeWMNoSKNapwjAv4a59NFnTV/8K58qnXvWg/TIbONMHVlcgh3WwQ3Vdz4A+JqWjKoozqJTDZ/ab/qHyNc3+hENhlTF9UlC1ZwGxKQtHc9UvvBh2zq8KRPQnyxbO7tpqa5I+6HxgQ3fe/6eCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803394; c=relaxed/simple;
	bh=wbtXFlCNpMvP3nSLj5aY02vHTuzuc8d2i19u+4GlouU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Ct/dWE6XmQtyd8jau7pPt1lCRBdG6/ftSxcAG3awuqkmZTkyohwqvX9hsjzssP7+dCn1jFMKlxleaCRDSWapfGUBkdYooT2EY6isqaYyz/+3btfuLIXp4fVyYrQlVg7xDuSKZF+pH/qi8jy/Uh1vGWvRHKKybxLbuKfuknVpBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eEcZYZ3o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRvFEZ0x; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id BBC131800074;
	Thu,  7 Mar 2024 04:23:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 04:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709803388;
	 x=1709889788; bh=b8dqhcTxKZ9VbDJ6yCA8cOVtdng1Ns/2TjCpfA+5TMA=; b=
	eEcZYZ3oQRvDwwFDQzbCXrNyw3JXGZlhgCXdOB0znCNsJKasmf2Ok0narPXtnvxa
	VBxxLIFOtjiPP5/i5vSp7IyNA1AQdyzD8eLqQ1Ff9SvA4WC94Z4vrieeW/3D/b5b
	59Log8gln+y557JIDFz4RmHgEEp/HTlJZtQOd+uca01XmgjZ2TYU+xZLDTkP+LAC
	PN7dwRyWZIfhQVT6X75LvphDyniIdw0+LJtHzRkpSUkhfinyN/iZmWevEW+gMNjv
	g8WbTxwli1Wk6tKfGWminNfa7Tsvy9MuQ9X+fgL3KJDA06F02x8r0Wbb3BkhSYp0
	lcNYdn1EyvEHKeR6S7cyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709803388; x=
	1709889788; bh=b8dqhcTxKZ9VbDJ6yCA8cOVtdng1Ns/2TjCpfA+5TMA=; b=F
	RvFEZ0xF59wCqKc+3rY/C1wQub3zs5gS9qGyW0X8O0y8SEowD5h7zYBNUeATNvHS
	yOu1mJg1cIJor2v/mYi700DuRz3y6bBUOD/8Hdyhb3MA+cS71GZGDc+gmSVGAxIm
	6Ipy8ddG2KwMVFuvx7g52I9Fx99bPojfIskustnnKHtDeu3UWe7pWINc49MwE3xk
	lol9nUmVpOm6UTtbDKL1jW9vhLXiAIXgnehFi8pe/DabFhPxImmmS3byLO2Fr0H0
	hqemK0o4EAJwEM37sZzFih6DWJkM9DAmJbVmQe4OsYlVwy/EfE3TMRnb8LwtlLCO
	QrSZJRl5wru1BhtgDKckg==
X-ME-Sender: <xms:e4fpZXcvNxkKTJenlqbtXXyXS-rJosiAa_nj0Nh7fvnlgGhVXVcHCw>
    <xme:e4fpZdM7zoxOOx6z37xZflQsqFmIMhovCFfc34UIiz9rEJLw5AM8o6jqAFbbPp_Pc
    JnKWI002GpD-Ps32mE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:e4fpZQhjc1WoowlWg9_Ml5V5esr4KWpAhIqrigyKu81UuMf0qNJfYA>
    <xmx:e4fpZY_GXY35KwaoPB8nXvxbq0tPI4tM6gqGj5uKehRUMdZHtJAeOw>
    <xmx:e4fpZTvJabv0y2jewleUSMJMY9hTydj4p2n2hBuwtTd_wnO7B3KoRA>
    <xmx:fIfpZWj-p7ESsHu5dwSilyZkE19s0tcj4dR2q5CcAMHb1JeEdS7f73WcdYY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7637FB6008D; Thu,  7 Mar 2024 04:23:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <460338ee-c8d5-4f43-9bab-4c35e417e4ad@app.fastmail.com>
In-Reply-To: 
 <CAJve8o=BsR1SG0k_7mb61Jj1fb+9rc4V9Y=MMX004fpAWE4vjg@mail.gmail.com>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <f23da383a8fdbee15acd41fdcd38ef3a89045a43.1709780590.git.haibo1.xu@intel.com>
 <c9e9da9f-ff81-48eb-beec-4f54921cd268@app.fastmail.com>
 <CAJve8o=BsR1SG0k_7mb61Jj1fb+9rc4V9Y=MMX004fpAWE4vjg@mail.gmail.com>
Date: Thu, 07 Mar 2024 10:22:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Haibo Xu" <xiaobo55x@gmail.com>
Cc: "Haibo Xu" <haibo1.xu@intel.com>,
 "Alison Schofield" <alison.schofield@intel.com>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Conor.Dooley" <conor.dooley@microchip.com>, guoren <guoren@kernel.org>,
 "Zong Li" <zong.li@sifive.com>, "James Morse" <james.morse@arm.com>,
 linux-riscv@lists.infradead.org, "Ard Biesheuvel" <ardb@kernel.org>,
 "Baoquan He" <bhe@redhat.com>, acpica-devel@lists.linux.dev,
 "Robert Moore" <robert.moore@intel.com>, linux-acpi@vger.kernel.org,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Greentime Hu" <greentime.hu@sifive.com>,
 "Dan Williams" <dan.j.williams@intel.com>, "Len Brown" <lenb@kernel.org>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Chen Jiahao" <chenjiahao16@huawei.com>,
 "Yuntao Wang" <ytcoode@gmail.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>,
 "Tony Luck" <tony.luck@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Evan Green" <evan@rivosinc.com>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Jones" <ajones@ventanamicro.com>
Subject: Re: [PATCH v2 5/6] ACPI: NUMA: Remove ARCH depends option in ACPI_NUMA Kconfig
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024, at 10:19, Haibo Xu wrote:
> On Thu, Mar 7, 2024 at 4:44=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>> On Thu, Mar 7, 2024, at 09:47, Haibo Xu wrote:

>> If we make it
>>
>>       def_bool NUMA && !X86
>>
>> then the select statements except for the X86_64_ACPI_NUMA
>> can also go away.
>>
>
> Good idea!
> Shall we include the ACPI in the def_bool definition?
>

No need, because this is inside of an 'if ACPI' block.

       Arnd

