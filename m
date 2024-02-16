Return-Path: <linux-kernel+bounces-69240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148C85861E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ECE1F23A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C331369A8;
	Fri, 16 Feb 2024 19:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="GTKZnY5P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GIc8yQ5D"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA31433B0;
	Fri, 16 Feb 2024 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111546; cv=none; b=fnYsYNAAfOqtFpezcoYbxV+t+cRaZ0fh7V5zYQkMMthA3nxFnXHqSlJNDiHhzHnkvRfEwaRuankSrDzVmM+Mqwc48hf04rKpU2jZsz8uVtO57tDS7yHOfcaE6sEuQTFsP89rqhgJNamR/X6UtlR1QgWQOUiSF/dRmX0zqUd3V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111546; c=relaxed/simple;
	bh=PmMj5xCY4cwM9ljvdLBlZgPPwEEBmcuk6hSXyOvVsOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uwpavod8swi1yDuwoOMZx40S/SAoDiFIETaAEM1Q4SMsSqLVEz3a6s+dhoJPDAwywQP03Hfmw0q4p3zywPDHJuxQqbg4NHVlOcy+p7OKHR1X64bUO00sG1tqRsWDLyGFO6VmhC5tHDFciUd3cRlcRVK/1GWpk3zoj1AnlD0GyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io; spf=pass smtp.mailfrom=ryhl.io; dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b=GTKZnY5P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GIc8yQ5D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ryhl.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryhl.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 985691140065;
	Fri, 16 Feb 2024 14:25:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 16 Feb 2024 14:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1708111543;
	 x=1708197943; bh=2bnvNAJdt+rJwZ46zg/Jhcps/my+VUB/liFYk+Y6iMc=; b=
	GTKZnY5PWSiQ0GWmcYBDOoyLVV1w9q85a7OnuXQrL0vrpL1qg+P3EnJSFmoedhtv
	pjUgnr0PJq2SfpxxwYV7AZJbzV+KGXOou5gQQ5CS0Syj4d3TndOhlLiA2JzECb94
	EpWYnWaK9hAkEfmpxGPwGNGcNERg46ok6d5g8rU9danfNwR/K3ymwqPuicFhdImz
	CVhCN7RntPdewE69U1wrVTXp4GM5mE7MtEJ9TdZdWr33T5ImDxAyV13fD4plX7sA
	qElhrrsvWBYOyRduCpE6F0JznCrufAL+xkrbYx+xyGopZkq99mke8waNyHTe566a
	pS8xOZGSh7uGPHd6auWXGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708111543; x=
	1708197943; bh=2bnvNAJdt+rJwZ46zg/Jhcps/my+VUB/liFYk+Y6iMc=; b=G
	Ic8yQ5Doksp5w6VzH6t9+pweQUhdgYYeeDXIWBNHKSk2KeHPUu2k7PvCmS65QIk/
	Ye0zhwWJitMwqhahiubty+POaqb7UyD3FQ97Qpp6+ZjFkVXKlGDCClDnJ+P7BjJU
	ILlMLOItxal+eXfu8eLR7baBvh3BNYrKT7OEQ3iHzdMA742gJFZ66INelbKc4g9a
	TJkC5jsfWeKiJfdhPTxg2NY5rFNdN3hRbHRxAiHYVpBECF5r1RVLmqxsxxyDjwuK
	I9C3StzICgjwMLi4NOs9zSKDQZcFpZIp91pammOGmgon1US3ZHYAY7272D6DF71S
	DrCtZQGv3e9eqQjLBNVvQ==
X-ME-Sender: <xms:trbPZVQkIOucwn1cSSC552g92k09RAslKFldvdTMv2zeR-OStkzVzw>
    <xme:trbPZewLuZpyxBz4kAO4N_QzmWLANpKei73imK6ASmWu5Vg3Yyeo1eRg3wSgvA5jO
    uK39tLADGcyZXFaEg>
X-ME-Received: <xmr:trbPZa1zcL7ORDFVgmzzY4gc8rIANsMhcZ0VpF_Ss9DZR24vLj_i-GrY1qcFqPOarxzRrwAP9JvvGctdTcT_HNjwH97CL6GKfS2v>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekgfeiieeghefgvdffledtveeugfdthfefhefggedttdejjeethfdvhfdtheekteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:trbPZdAaLgzX2Qzd8YTd7Y_suYD_I4XsIbRX4RX_U1meqjardapNag>
    <xmx:trbPZegOvO_SsqZjo8J0yKREW84OSEt1ts0misPVIIdUhH40pqlzZA>
    <xmx:trbPZRplPXcEU4pK6Nt2umMnKDYQE56242RJt6vJHIxIjgcyg7tZ4Q>
    <xmx:t7bPZfaPzCHNxKE15nRJtWeqcjbz_p8rLduSs4AGeFpr7lvFeYUIJg>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 14:25:40 -0500 (EST)
Message-ID: <75a5a4cc-af27-415a-87b8-9e231574a519@ryhl.io>
Date: Fri, 16 Feb 2024 20:25:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: str: add {make,to}_{upper,lower}case() to
 CString
Content-Language: en-US-large
To: Danilo Krummrich <dakr@redhat.com>, Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, benno.lossin@proton.me,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 linux-kernel@vger.kernel.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20240214172505.5044-1-dakr@redhat.com>
 <20240216165320.1820346-1-aliceryhl@google.com>
 <18a49662-3640-49c1-9587-db5cc9d62fbc@redhat.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <18a49662-3640-49c1-9587-db5cc9d62fbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/16/24 18:11, Danilo Krummrich wrote:
> On 2/16/24 17:53, Alice Ryhl wrote:
>>> +    /// Returns a copy of this [`CString`] where each character is 
>>> mapped to its
>>> +    /// ASCII upper case equivalent.
>>> +    ///
>>> +    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
>>> +    /// but non-ASCII letters are unchanged.
>>> +    ///
>>> +    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
>>> +    ///
>>> +    /// [`make_ascii_uppercase`]: str::make_ascii_uppercase
>>> +    pub fn to_ascii_uppercase(&self) -> Result<CString, AllocError> {
>>> +        let mut s = (*self).to_cstring()?;
>>> +
>>> +        s.make_ascii_uppercase();
>>> +
>>> +        return Ok(s);
>>> +    }
>>
>> Please move these to `CStr` as well.
> 
> That would result into two copies if I actually want a CString, wouldn't 
> it?
> 
> Also, what would be the use case? And even if someone wants to have a CStr
> again, couldn't we just deref the resulting CString?

To clarify, I want you to move it to the `impl CStr` block. That changes 
the type of the `self` argument. I don't want you to change the return 
type - that should still be `CString`.

Currently, if I have a `&CStr` and I want an uppercase `CString`, I 
can't do that with this method.

Alice

