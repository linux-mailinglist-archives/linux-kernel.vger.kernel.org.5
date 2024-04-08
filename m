Return-Path: <linux-kernel+bounces-134876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA289B821
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2C61C21951
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9D22EEB;
	Mon,  8 Apr 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="H6nbwhCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kp5S05NQ"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEFF23A8;
	Mon,  8 Apr 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560007; cv=none; b=HrVl4NGfOsTwo4OhzdQeZfp0zoVqgBPdUfN6y96VDiJAZ9rNX4pbcJGHXcgrZn4ixwKtNHCJpUrQbuDq9C6O3WsgyzExOSMK+6AtCR2OqipgYI0Eim6/lrlA6Cyddw+ng1ZqHhVlgDNQE8JmBmyD+xQsgI+uInGMNMPjPyKVXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560007; c=relaxed/simple;
	bh=TsTg0Em0hnQwG1kyroyG8fwVKnHzk4bQZW79kIttRXM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=g1TyqVFn0fXqKkU5TIYjyVt/yEaD0kEU5THjxTD/Aeo4pjwvs+wbXxq9EvfaYpqr5gcl3cxhMRqFGS8sZLpfCkp4NZu7boIIdmkbVRf/eYje1n8mhWx34UrL6xy6YekWEL1aFyQx2Sa/9KGR3FZ+fRY0U+TZrCP4vaY210FDcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=H6nbwhCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kp5S05NQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CFA0011400D1;
	Mon,  8 Apr 2024 03:06:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 03:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712560003; x=1712646403; bh=mnxNgod+mQ
	25GqKBWPAlL1brKBlWJhE7aWmS2Nl0Wm4=; b=H6nbwhCaMCIBbpeE3pA3TNVaAm
	JR4F/RzgmG3MGDor5L+WGbW/atMmwXVxSoglH+yQ2Mt70jAN7l7eCZxJ9Kalral1
	8UQc0xHNOpSetWaeDzlJRFE6Av/YIcS2JTBuOHNflIN8OCycse60bH5+9En7fU9w
	WRMyYYZcNDNUV3ao3ykySyp05bpFjZe61qMq9ErTbTjDvvlLAkpqnIxNAYq9UKyj
	f9ZlPGHdOSoCdldwdq2puNBxFOvBB0l3IOk5zizfUHvtN6CthyAMdCECHsS9qY6o
	JxDxMQEwRW1y+WinFVx1IEGXJNaYbN48MHCaV9rVGM6aQ5Didoc8EMbXKu8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712560003; x=1712646403; bh=mnxNgod+mQ25GqKBWPAlL1brKBlW
	JhE7aWmS2Nl0Wm4=; b=kp5S05NQS+3/yLNrmlzZUcU1zMoM94Bv3NFVHyIKkZ3I
	gZJyYgwg8Wh2ZtrhSIHXttMCu2F1ZJ68RT3jp4D8+I5zJ9U2wfOIM4YMP7dbEMG7
	XuMD7LIbjXMGeHN0L0G2WVYrV0wDN2ynwRaUzhZ7I3bPDoQrUfViba7hXmKQL1I3
	b42IvSRh0F+sO/jGk7NRc/lFxoG6bF4ugf8yqA8ciiIKAdPL0GByFbe+/VVnpNdc
	r33RL7m4+GWokvAzG2lLZXCurHDbyoG0fqmg6kND1gkXU3CwkKlFQmubIqloeqSd
	D9P4uSb80VU6cd4GmKOI2VBp71f7w0GPZ7H8aM64dw==
X-ME-Sender: <xms:gpcTZveQNBT4simoXhkgi6yX_7gMIvB9m2rakniQ_mcLtez_zE7YqA>
    <xme:gpcTZlO_SfKTANDeDIg5GlqyqbO7SdQc458048n87Hg0am6Q1-w9awCNYRS3TBSMy
    tJ3OniymnbVgJxe9IQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeejvddvvdduleduheejiedtheehiedvjefgleelffeigfevhffhueduhfeg
    feefheenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:gpcTZohgL73J6oIzKZ8vxRcTgx8PzAJrTRdnweZr-Mti9ommZ39RNg>
    <xmx:gpcTZg-2KVDmDEvjkAsvEU-TbgaLTuf5vYXcYoeN3_67GcrBN1ekJA>
    <xmx:gpcTZrvCa69j0jZ_PbbvliwfaRx_R5FAfsRRXpAjeSap6rE48mVvug>
    <xmx:gpcTZvGHILEgqIs5Uvv9Lr97c92V7vCQAVAtNR_ERymOtIHvGSKepA>
    <xmx:g5cTZgW8NwC8DDq3UfpoowyZ2lDW3uo7RZeYX0B8NK0NZtaVXpPUbsFa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 31EF3B6008D; Mon,  8 Apr 2024 03:06:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <763214eb-20eb-4627-8d4b-2e7f29db829a@app.fastmail.com>
In-Reply-To: <202402161301.BBFA14EE@keescook>
References: <20240216202657.2493685-1-arnd@kernel.org>
 <202402161301.BBFA14EE@keescook>
Date: Mon, 08 Apr 2024 09:06:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <keescook@chromium.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Leon Romanovsky" <leon@kernel.org>, "Lin Ma" <linma@zju.edu.cn>,
 "Simon Horman" <horms@kernel.org>, "Breno Leitao" <leitao@debian.org>,
 "Tobias Brunner" <tobias@strongswan.org>, "Raed Salem" <raeds@nvidia.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] [RFC] xfrm: work around a clang-19 fortifiy-string false-positive
Content-Type: text/plain

On Fri, Feb 16, 2024, at 22:19, Kees Cook wrote:
> On Fri, Feb 16, 2024 at 09:26:40PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> clang-19 recently got branched from clang-18 and is not yet released.
>> The current version introduces exactly one new warning that I came
>> across in randconfig testing, in the copy_to_user_tmpl() function:
>> 
>> include/linux/fortify-string.h:420:4: error: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>   420 |                         __write_overflow_field(p_size_field, size);
>> 
>> I have not yet produced a minimized test case for it, but I have a
>> local workaround, which avoids the memset() here by replacing it with
>> an initializer.
>> 
>> The memset is required to avoid leaking stack data to user space
>> and was added in commit 1f86840f8977 ("xfrm_user: fix info leak in
>> copy_to_user_tmpl()"). Simply changing the initializer to set all fields
>> still risks leaking data in the padding between them, which the compiler
>> is free to do here. To work around that problem, explicit padding fields
>> have to get added as well.
>
> Per C11, padding bits are zero initialized if there is an initializer,
> so "= { }" here should be sufficient -- no need to add the struct
> members.
>
>> Since this is a false positive, a better fix would likely be to
>> fix the compiler.
>
> As Nathan has found, this appears to be a loop unrolling bug in Clang.
> https://github.com/ClangBuiltLinux/linux/issues/1985
>
> The shorter fix (in the issue) is to explicitly range-check before
> the loop:
>
>        if (xp->xfrm_nr > XFRM_MAX_DEPTH)
>                return -ENOBUFS;

I ran into this issue again and I see that Nathan's fix has
made it into mainline and backports, but it's apparently
not sufficient.

I don't see the warning with my patch from this thread, but
there may still be a better fix.

      Arnd

