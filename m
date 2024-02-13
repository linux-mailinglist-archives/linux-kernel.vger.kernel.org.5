Return-Path: <linux-kernel+bounces-64230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980E853C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61116B24BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF17612F0;
	Tue, 13 Feb 2024 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mdsrOfIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APCMk9yc"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F010A2D;
	Tue, 13 Feb 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857031; cv=none; b=dZN5d7c4GgWt0R2uMrv1uLDXjhpYehmR7gWrgJNbd6bTRIRqA+UTlx34+/uS9wObmIZNo1WIkSbUTnVotFn3468n0c8O4ky77jg/Y0ldEcpLGKBmn2aNYBrou6D2iTquSUzUmz3/m9F26raapgtzW/3izeqwQAK3Oz/4sITWHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857031; c=relaxed/simple;
	bh=wYHGaLKWU6FctAX/6W2B9gjyrBVbuoHS3Rm6X0DCXXg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IDI081rC5W818EISgrlG6zgFOF+/QDXVfgO1OH/iXbV5jHAIqCpLytTQubvIK09VyccUok1uie7G1ZBeKTqpOC2gLclFjzSnJhoj0bopgfUAa7H3Sgktdir0dvQPvqDcYiqkwGkoEmd6e2AdRtGjC21bUvzZ3w6/CMbVmqjOt+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mdsrOfIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APCMk9yc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1EE0011400A4;
	Tue, 13 Feb 2024 15:43:48 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 13 Feb 2024 15:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707857028; x=1707943428; bh=9OOmF4pYqt
	XuBz4zzoo2PViV8gq+6G2Gr1SyfFs2L0o=; b=mdsrOfIRMTLE+KzlAHK4gRcDAW
	DERHhF46I23MjK+hG7uAvS9kBxkxqsQW+ybT+1QwFRo7Nt1l5oJsiSFgZ1GkEQJI
	zt3u2qjAsupJj8fS8LP3AIme9xLqc79DSq4A6yPZfWzJrWcADgGo+/3ZPoKary88
	Hief6PxQ/Wz48ERA+nVIZ0nHXhGGc1A2wtCEcM6wwHE1HM60EJIHsgK9A+oscq9W
	l4BqiYperxvrqsCceqcW/GgWHz2PDU8J431bheSXt+HXC38/Yh63YKI4TI6theF5
	QGGEoXC1JFWdeUWcOe7Jz7BFEEShOZwY472QIAucBKB5Bx5xGC99r/FyxO8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707857028; x=1707943428; bh=9OOmF4pYqtXuBz4zzoo2PViV8gq+
	6G2Gr1SyfFs2L0o=; b=APCMk9yc7zbXzM+mSQRegQucVXB3ItPq96JphwRCM6DQ
	IAmLoCZsbRT1zeSsAZthcd7HR2OgVRit7h9wjIUSNG+CkQnLaSccZzktm4wNh0np
	kfsg8c3d6VjujXb9XnxY9nRxbvoeBfyWoeip+3gNLi/+iNTSxBWforUCLO7ywgHv
	XPhp+S/V7/E4rIXdFDb41Qi9Xk8uZRDwkkT7lM6QzTLsByrJmJm5UyFSJMtAeJJN
	zAlNi4DKwx6mMluuh59MonfODUlPYHKIv/LwRrFVFZ+D5H59vT74Uy8AJD0otUZT
	f4+NBuiRaBZpAPxbck9CJKDI4s6dYbzyfQpa/FgdqQ==
X-ME-Sender: <xms:g9TLZbZaN4dNmeYvZVw6SL4XrPC968Hi5G5bVxeUGH40tE-DZGJ1aQ>
    <xme:g9TLZaY_zwmTbrf7_1tZbK11TulF9fsX8_EIlcBj6Exsq0jgLzYCAx759hcmujcx0
    Mq91e9HByz55TGhQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuheegtdeuteeghfehjeejiefghfeifeejheduvdeugedt
    hfehvefggefgkedtnecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehf
    rghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:g9TLZd-V1fjkmckVB6yKD6pJbYk_LjpO08dXakmC0jMYkmNWHVDfyA>
    <xmx:g9TLZRqWDqgTZySOKSC3Dnz8F7JaG6evcF9_phBpZ8R2xhsGPK2JWQ>
    <xmx:g9TLZWoJTdG-wSWZfZp9r-NwQ6Hj1VpAsUVWPHsrt_JkyyBYu0EPiw>
    <xmx:hNTLZXfZqMnphaUmd_ftQtNVomJB2ZanR4-2cLKGmI9xAJn4uY-wlQ>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D2AE41700093; Tue, 13 Feb 2024 15:43:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b7ad2bd4-a19e-486e-8be2-3b56f288d5d0@app.fastmail.com>
In-Reply-To: <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
References: <20240213033744.4069020-1-samuel.holland@sifive.com>
 <20240213033744.4069020-4-samuel.holland@sifive.com>
 <20240213-dangle-taco-2742f6087a3e@spud>
 <ff3bd436-12f8-4cde-881d-89a005ad85c0@sifive.com>
Date: Tue, 13 Feb 2024 15:43:27 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Samuel Holland" <samuel.holland@sifive.com>,
 "Conor Dooley" <conor@kernel.org>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Andrew Jones" <ajones@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v2 3/4] riscv: Add ISA extension parsing for Sm and Ss
Content-Type: text/plain

On Tue, Feb 13, 2024, at 3:22 PM, Samuel Holland wrote:
> On 2024-02-13 12:07 PM, Conor Dooley wrote:
>> On Mon, Feb 12, 2024 at 07:37:34PM -0800, Samuel Holland wrote:
>>> Previously, all extension version numbers were ignored. However, the
>>> version number is important for these two extensions. The simplest way
>>> to implement this is to use a separate bitmap bit for each supported
>>> version, with each successive version implying all of the previous ones.
>>> This allows alternatives and riscv_has_extension_[un]likely() to work
>>> naturally.
>>>
>>> To avoid duplicate extensions in /proc/cpuinfo, the new successor_id
>>> field allows hiding all but the newest implemented version of an
>>> extension.
>>>
>>> Cc: <stable@vger.kernel.org> # v6.7+
>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>> ---
>>>
>>> Changes in v2:
>>>  - New patch for v2
>>>
>>>  arch/riscv/include/asm/cpufeature.h |  1 +
>>>  arch/riscv/include/asm/hwcap.h      |  8 ++++++
>>>  arch/riscv/kernel/cpu.c             |  5 ++++
>>>  arch/riscv/kernel/cpufeature.c      | 42 +++++++++++++++++++++++++----
>>>  4 files changed, 51 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
>>> index 0bd11862b760..ac71384e7bc4 100644
>>> --- a/arch/riscv/include/asm/cpufeature.h
>>> +++ b/arch/riscv/include/asm/cpufeature.h
>>> @@ -61,6 +61,7 @@ struct riscv_isa_ext_data {
>>>  	const char *property;
>>>  	const unsigned int *subset_ext_ids;
>>>  	const unsigned int subset_ext_size;
>>> +	const unsigned int successor_id;
>>>  };
>>>  
>>>  extern const struct riscv_isa_ext_data riscv_isa_ext[];
>>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>>> index 5340f818746b..5b51aa1db15b 100644
>>> --- a/arch/riscv/include/asm/hwcap.h
>>> +++ b/arch/riscv/include/asm/hwcap.h
>>> @@ -80,13 +80,21 @@
>>>  #define RISCV_ISA_EXT_ZFA		71
>>>  #define RISCV_ISA_EXT_ZTSO		72
>>>  #define RISCV_ISA_EXT_ZACAS		73
>>> +#define RISCV_ISA_EXT_SM1p11		74
>>> +#define RISCV_ISA_EXT_SM1p12		75
>>> +#define RISCV_ISA_EXT_SS1p11		76
>>> +#define RISCV_ISA_EXT_SS1p12		77
>>>  
>>>  #define RISCV_ISA_EXT_MAX		128
>>>  #define RISCV_ISA_EXT_INVALID		U32_MAX
>>>  
>>>  #ifdef CONFIG_RISCV_M_MODE
>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SM1p11
>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SM1p12
>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
>>>  #else
>>> +#define RISCV_ISA_EXT_Sx1p11		RISCV_ISA_EXT_SS1p11
>>> +#define RISCV_ISA_EXT_Sx1p12		RISCV_ISA_EXT_SS1p12
>>>  #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
>>>  #endif
>>>  
>>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>>> index d11d6320fb0d..2e6b90ed0d51 100644
>>> --- a/arch/riscv/kernel/cpu.c
>>> +++ b/arch/riscv/kernel/cpu.c
>>> @@ -215,6 +215,11 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>>>  		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>>>  			continue;
>>>  
>>> +		/* Only show the newest implemented version of an extension */
>>> +		if (riscv_isa_ext[i].successor_id != RISCV_ISA_EXT_INVALID &&
>>> +		    __riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].successor_id))
>>> +			continue;
>>> +
>>>  		/* Only multi-letter extensions are split by underscores */
>>>  		if (strnlen(riscv_isa_ext[i].name, 2) != 1)
>>>  			seq_puts(f, "_");
>>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>>> index c5b13f7dd482..8e10b50120e9 100644
>>> --- a/arch/riscv/kernel/cpufeature.c
>>> +++ b/arch/riscv/kernel/cpufeature.c
>>> @@ -113,23 +113,29 @@ static bool riscv_isa_extension_check(int id)
>>>  	return true;
>>>  }
>>>  
>>> -#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size) {	\
>>> +#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _successor) {	\
>>>  	.name = #_name,								\
>>>  	.property = #_name,							\
>>>  	.id = _id,								\
>>>  	.subset_ext_ids = _subset_exts,						\
>>> -	.subset_ext_size = _subset_exts_size					\
>>> +	.subset_ext_size = _subset_exts_size,					\
>>> +	.successor_id = _successor,						\
>>>  }
>>>  
>>> -#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0)
>>> +#define __RISCV_ISA_EXT_DATA(_name, _id) \
>>> +	_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, RISCV_ISA_EXT_INVALID)
>>>  
>>>  /* Used to declare pure "lasso" extension (Zk for instance) */
>>>  #define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
>>> -	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, ARRAY_SIZE(_bundled_exts))
>>> +	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, \
>>> +			    _bundled_exts, ARRAY_SIZE(_bundled_exts), RISCV_ISA_EXT_INVALID)
>>>  
>>>  /* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
>>>  #define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
>>> -	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts))
>>> +	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), RISCV_ISA_EXT_INVALID)
>>> +
>>> +#define __RISCV_ISA_EXT_VERSION(_name, _id, _preds, _preds_size, _successor) \
>>> +	_RISCV_ISA_EXT_DATA(_name, _id, _preds, _preds_size, _successor)
>>>  
>>>  static const unsigned int riscv_zk_bundled_exts[] = {
>>>  	RISCV_ISA_EXT_ZBKB,
>>> @@ -201,6 +207,16 @@ static const unsigned int riscv_zvbb_exts[] = {
>>>  	RISCV_ISA_EXT_ZVKB
>>>  };
>>>  
>>> +static const unsigned int riscv_sm_ext_versions[] = {
>>> +	RISCV_ISA_EXT_SM1p11,
>>> +	RISCV_ISA_EXT_SM1p12,
>>> +};
>>> +
>>> +static const unsigned int riscv_ss_ext_versions[] = {
>>> +	RISCV_ISA_EXT_SS1p11,
>>> +	RISCV_ISA_EXT_SS1p12,
>>> +};
>>> +
>>>  /*
>>>   * The canonical order of ISA extension names in the ISA string is defined in
>>>   * chapter 27 of the unprivileged specification.
>>> @@ -299,8 +315,16 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>>  	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>>>  	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
>>>  	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
>>> +	__RISCV_ISA_EXT_VERSION(sm1p11, RISCV_ISA_EXT_SM1p11, riscv_sm_ext_versions, 0,
>>> +				RISCV_ISA_EXT_SM1p12),
>>> +	__RISCV_ISA_EXT_VERSION(sm1p12, RISCV_ISA_EXT_SM1p12, riscv_sm_ext_versions, 1,
>>> +				RISCV_ISA_EXT_INVALID),
>>>  	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>>>  	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
>>> +	__RISCV_ISA_EXT_VERSION(ss1p11, RISCV_ISA_EXT_SS1p11, riscv_ss_ext_versions, 0,
>>> +				RISCV_ISA_EXT_SS1p12),
>>> +	__RISCV_ISA_EXT_VERSION(ss1p12, RISCV_ISA_EXT_SS1p12, riscv_ss_ext_versions, 1,
>>> +				RISCV_ISA_EXT_INVALID),
>>>  	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>>>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>>>  	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>>> @@ -414,6 +438,14 @@ static void __init riscv_parse_isa_string(unsigned long *this_hwcap, struct risc
>>>  				;
>>>  
>>>  			++ext_end;
>>> +
>>> +			/*
>>> +			 * As a special case for the Sm and Ss extensions, where the version
>>> +			 * number is important, include it in the extension name.
>>> +			 */
>>> +			if (ext_end - ext == 2 && tolower(ext[0]) == 's' &&
>>> +			    (tolower(ext[1]) == 'm' || tolower(ext[1]) == 's'))
>>> +				ext_end = isa;
>>>  			break;
>>>  		default:
>>>  			/*
>> 
>> 
>> Hmm, looking at all of this (especially this hack to the "old" parser),
>> I feel more like these should be promoted to a property of their own.
>> The "old" parser was designed to handle numbers, and here when you're
>> interested in the values behind the numbers (which is a first iirc), you
>> don't make any use of that. I don't really want to see a world where
>
> I had a version of this code that parsed the numbers and stored them as integers
> in `struct riscv_isainfo`. It didn't work with of_property_match_string() as
> used for riscv,isa-extensions, since that function expects the extension name to
> be the full string. Either we would need to change the code to parse a version
> number out of each string in the riscv,isa-extensions list (and make the binding
> a bunch of regexes), or we need a separate "extension" entry (and DT binding
> entry) for each supported version.

Version numbers aren't real, there's no compatibility promise that we can
consistently rely on so we treat riscv,isa-extensions as simply containing
alphanumeric extensions.  This was an intentional part of simplifying riscv,isa
into riscv,isa-extensions.

> I chose the second option, and as a consequence I didn't actually need to parse
> the integer value in the ISA string code path either.
>
>> we have every single iteration of smNpM under the sun in the property,
>> because there's a fair bit of churn in the isa. Granted, this applies to
>> all the various, the difference for me is the level of churn.
>
> Indeed. In fact, one thought I had while looking at this code is that we should
> be ignoring any extension in the ISA string with a version < 1.0 or >= 2.0,
> since those won't be compatible with what we expect.

I might go further and say that we should only accept specific exact versions of
extensions other than Ss/Sm.  This could be revisited after the recent "semver
for ISA extensions" policy is tested at least once under real-world conditions.

Right now we have two ratified versions of Ss/Sm, soon to be three, and one
ratified version of all other extensions.  I hardly think this is an excessive
amount of churn.

>> Or maybe we can still with the properties you have, but instead of
>> treating them like any other extension, handle these separately,
>> focusing on the numbering, so that only having the exact version
>> supported by a cpu is possible.
>
> Maybe I'm misunderstanding what you're saying here, but it is already the case
> that the DT for a CPU would only contain the exact version of the privileged ISA
> supported by that CPU.

If privileged spec versions are boolean extensions, then you would say "ss1p11",
"ss1p12", "ss1p13" as separate/simultaneous extensions.  This is needed in order
to allow simple support checks as described in the riscv,isa-extensions cover
letter.

> With this implementation, the fact that the integer version gets expanded to a
> series of flags is supposed to be invisible in the DT and to userspace. I
> realize I don't quite succeed there: putting "ss1p13" in the ISA string should
> work, but does not.
>
>> I'm still pretty undecided, I'd like to think about this a little bit,
>> but I think we can do better here.
>
> Sure, no problem. I'm happy to implement whatever we agree on. Though one
> consideration I had is that this is all in support of fixing a bug in v6.7, so I
> wanted the changes to be backportable.
>
> I suppose the easy way out for backporting is to check for RISCV_ISA_EXT_ZICBOZ
> for now, and then solve the larger problem once there is some other user of the
> envcfg CSR (or another Ss1p12 feature).

I support that course of action.

-s

> Regards,
> Samuel
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

