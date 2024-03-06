Return-Path: <linux-kernel+bounces-93833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A994C873556
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11941C2272D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D340F763FC;
	Wed,  6 Mar 2024 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="zaRBYVkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBCOsQLP"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D1F6CDCD;
	Wed,  6 Mar 2024 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723285; cv=none; b=E/E9yFXey7zxBni6cE58Rg8YceAlVAl/Y27xRKcDqkpookV1Y1rryp2z9AeS2bpm3eddgZYrPX+AGU42jvpJdkUOyDLQeqKcBq/Gw5d+GLiDgIG1qW1wpmg3H2UzzZj5ObpssSkseTw4KDE45V9aHoRdO3xJF/b/b/tRhb6cLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723285; c=relaxed/simple;
	bh=OqMO2VZ9+NkraavKMpj7YCo7wGGKSX6RdZNwg85E+u0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=hFX/ftImLIO7CI0zNDbheBzsFMfgVGgQlMYnidQPGwTwVvMvcbBW2aIxOEimVt/b/Ii5cCkUWBTx5E3MCLdzAwQltRmoHqLJT5+HTImT4t2GR/CBiB4JPwspPArmfTDb75pEOKzcDH1rSs0eM2/LJrdLhXricZAGfojiYOTzKd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zaRBYVkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBCOsQLP; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 0E68C5C0066;
	Wed,  6 Mar 2024 06:08:02 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 06 Mar 2024 06:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709723282; x=1709809682; bh=fUsUAJrOiD
	qHwZ9WYNhbZNn8z+ZSepwpmCgyLjJuqOQ=; b=zaRBYVkCb+RwVGFLLyZu8DYOGJ
	X4qGta3SKPTWLz6JRLLrZHJaJEN0z/XYF3S1/GTSzw/5XXPa/uJqhaN3SAfbH4mK
	NzZIu6Bb0E+6p+dFvkI5+fCYJ8I4DtAV8E7Bw0baZbX74V09Uu5pyRNJk2UHtrZW
	C+7+nLardTjCissS5DYOy7jcCbbkX0nn7l7Mr2Sa3a4up6OenqwyU2/XphcilYUY
	NsBpdBEcS+pyMMIRssrHQ0U39iBD4W7/ek3mq6k2nyrGs1k9u5Opp/ILPIoc+q92
	8Dga0BzqwqXOTOPTn9dE276l/zrO2bQMCO9v8G1DS+x/SJxv3JrnQF9We48w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709723282; x=1709809682; bh=fUsUAJrOiDqHwZ9WYNhbZNn8z+ZS
	epwpmCgyLjJuqOQ=; b=bBCOsQLPIf3w+a6UR5ZM0l+OjhoSM+8NKYUVrjH+oTcO
	wZxLQU4fkzopoPPk8uNckoXUEmAeP5XoUDDcaqemSU25adTpNdVq3SYTa2PJvIXw
	M8GCfDwUQhrer5chpUEcYzVvLxLlWfThgWGfIIHcj5C54w1KFqxow4lhKboZLKSh
	2VKClzql0uFpvW30O1OVbRMqTN+mUunR7QhwT2lhACm2Mnk360OcY7kfMGm8ezKo
	0uZtsAhXfEAOu3189ym3HbiEghG2DSDcdgKj9S2LA/tm9cmFhYdK4qFmQU5ZKumW
	ca1QSRQAad14WUELVHAIuG0tfk1n0t/+ExNcMSreog==
X-ME-Sender: <xms:kU7oZcw-tfOCkjiogNFdzwXY_MnI-1BuEaUEhKmBlG74efDScbbFuw>
    <xme:kU7oZQQhna506tKK05OmEXQxRBS3Ulf4puq4zO3XPs0KCnzfOXR7aq3rOC19ZSfTk
    FDwjQc_nejarWgyXAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:kU7oZeX-oGMGuz6jZTS_r_NMpIjUX06xk4kRVLLPintXXwunQb_u6w>
    <xmx:kU7oZaixjebDSSqiochYKLWJ48dblQY8k4WzvqrEtn9QtBEEaIfd6g>
    <xmx:kU7oZeBYFStfr4IpRofLNolW1KgDEDYHf78AoV6tcnemr3Uxg5P8ig>
    <xmx:kk7oZa1qUSVNXlLRMZbPrW5a2C1cGadbLruumz0CvpdWIPt8GUyXpA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7032AB60093; Wed,  6 Mar 2024 06:08:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-208-g3f1d79aedb-fm-20240301.002-g3f1d79ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3d433b58-384f-452e-904d-62e23b3b5a0b@app.fastmail.com>
In-Reply-To: <87h6hjhbqy.fsf@kernel.org>
References: <20240301135134.29577-1-duoming@zju.edu.cn>
 <fdaefac9-1d02-4424-b893-4306b97028ca@broadcom.com>
 <87h6hjhbqy.fsf@kernel.org>
Date: Wed, 06 Mar 2024 12:07:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>
Cc: "Duoming Zhou" <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org,
 "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Hans de Goede" <hdegoede@redhat.com>, minipli@grsecurity.net,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] wifi: brcmfmac: pcie: handle randbuf allocation failure
Content-Type: text/plain

On Wed, Mar 6, 2024, at 11:53, Kalle Valo wrote:
> Arend van Spriel <arend.vanspriel@broadcom.com> writes:
>
>> On 3/1/2024 2:51 PM, Duoming Zhou wrote:
>>> The kzalloc() in brcmf_pcie_download_fw_nvram() will return
>>> null if the physical memory has run out. As a result, if we
>>> use get_random_bytes() to generate random bytes in the randbuf,
>>> the null pointer dereference bug will happen.
>>> Return -ENOMEM from brcmf_pcie_download_fw_nvram() if kzalloc()
>>> fails for randbuf.
>>> Fixes: 91918ce88d9f ("wifi: brcmfmac: pcie: Provide a buffer of
>>> random bytes to the device")
>>
>> Looks good to me. Looking for kernel guideline about stack usage to
>> determine whether it would be ok to just use buffer on stack. Does
>> anyone know. This one is 256 bytes so I guess the allocation is
>> warranted here.
>
> Arnd, what do you suggest? Do we have any documentation or guidelines
> anywhere?

I don't think we have anything document about this. I usually
consider anything more than half a kilobyte as excessive,
even though the warning limit is higher.

256 bytes is usually fine, but in this case I would split out
the basic block that does this into a separate function
so it does not share the stack frame with other leaf functions
below brcmf_pcie_download_fw_nvram(). It might also be justified
to then mark it as noinline_for_stack.

      Arnd

