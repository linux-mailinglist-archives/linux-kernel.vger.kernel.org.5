Return-Path: <linux-kernel+bounces-1655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6AE8151A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C09286719
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFAE47792;
	Fri, 15 Dec 2023 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="qRat0JjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bTJSsJXY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE44778B;
	Fri, 15 Dec 2023 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sholland.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 08D615C01B4;
	Fri, 15 Dec 2023 16:09:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Dec 2023 16:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702674589;
	 x=1702760989; bh=+9pLPYjGFzgfQNqnSkxnhSaHWO67M+0iAl8v+uqZUn0=; b=
	qRat0JjUuSP+CfpfIN2pUKpArcFwNph/k3XRmvINBOoHN7pB4D8n7pkE8iBHA0Qk
	odXJPgXteR0Xm5RtvWlDCYGtYMAyFMhF7pXJlrFvsJEgzuJBUmrxnIQ/h9GGJkjN
	AGllPtoiPQ1HfYI38BcYwoCaVwaXYsYM3Tm/3Ue9M8yhshedBOFofOzWZuP0zTRH
	yoSAxvbBB0bEnEMgotajZaiTr/OvB019lYMFqK70HQXJR10SlhyMmmObJ9am4Y2W
	GBrwGsxQuhzD4ndPWNnD0ftTtGDpoIydMftL78GEid9ydKYWP0b2TrvbhSwoSP1q
	BT/On1G6mHYrRMvC06NsDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702674589; x=
	1702760989; bh=+9pLPYjGFzgfQNqnSkxnhSaHWO67M+0iAl8v+uqZUn0=; b=b
	TJSsJXYOMfo+ayDWdjBB5rX0z+IaPLykp8Ix+V7WgrTdZYVwjG8gfMG4b9OTbfjq
	BvN1l2in5uzVkegf4KRXbfwPKmH6xOjdHfMTZFBX+geQfbINDI09rw2YAk4rVOYm
	pAy/TrpjkteeXFBBWnpA3dEZ4gA0UF3LIFDizumOqDWUkto/fUg9ac7PNcWu5m1U
	nv9UKqi4YQgf+evBIuqDQ3gj/HfUupEs8dyeH47PUMFPs7lroHF3jKdhPKns5PWu
	f80ah+Ujds+y5aFrz+912p6PJU4tnF8p+er+N4rj+IgENkr/OsfyyCIVPfZSFDxg
	+HyD5PD9PgXUGHZeZ++qA==
X-ME-Sender: <xms:nMB8ZZEuYE7BXDpGFfbOk_4c1rdExyb3dPRpgkHivUzKCxO6A-QLYA>
    <xme:nMB8ZeU1bLyUJmYrQJ60LyUUDXmr1R6AUGGdS2N5QOvPi48nCTejAqM8UEQZe0TfF
    FGZu0hOzSA4KQ1wLQ>
X-ME-Received: <xmr:nMB8ZbII-66LC2gnpfa7Wn4D_icvvn3BPx7bVDbylIuSFNwX0_2BAFdLU-pXqiH_1k2yFEk_fBlzsJ3clBLKt_56v6nHM76vKNe1tLxog3LYC1o76O_g8zktoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepteevhffhteegfeehteehhfevgfejtdehudehvdejveetgedt
    ffejjefhffehudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:nMB8ZfELrq8xAznZrAp53-LvFGhKOEdj4xfr1b1x7PB9_8EzoQwECQ>
    <xmx:nMB8ZfVfRWgzryaISqCJQAgWBuk81px9I4pWUvrfQJcsVQhdVwG_yw>
    <xmx:nMB8ZaOVgiaKi2SjWVQBwKssdcB0_9tRhb0QlVXnGAX-fa1Sqk7f2g>
    <xmx:ncB8ZTmp8MMBx-462eITdqMgyHG8rDd6oz_R_LOFOWw2517D1T7oEA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Dec 2023 16:09:47 -0500 (EST)
Message-ID: <11b5aea1-7c6e-4be5-ae01-9c4c869dc98c@sholland.org>
Date: Fri, 15 Dec 2023 15:09:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency scaling
 drivers
To: Brandon Cheo Fusi <fusibrandon13@gmail.com>, viresh.kumar@linaro.org
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, palmer@dabbelt.com, paul.walmsley@sifive.com,
 rafael@kernel.org, robh+dt@kernel.org, tiny.windzz@gmail.com, wens@csie.org
References: <20231214111702.xdd7qlcrpqh74i3j@vireshk-i7>
 <20231215151723.46409-1-fusibrandon13@gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel@sholland.org>
In-Reply-To: <20231215151723.46409-1-fusibrandon13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Brandon,

On 12/15/23 09:17, Brandon Cheo Fusi wrote:
> On Thu, Dec 14, 2023 at 12:17 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>
>> On 14-12-23, 11:33, Brandon Cheo Fusi wrote:
>>> Add Kconfig file for cpufreq scaling drivers that can handle RISC-V
>>> CPUs. An entry is included for the Allwinner H6 cpufreq driver that
>>> works with D1.
>>>
>>> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
>>> ---
>>>  drivers/cpufreq/Kconfig       |  4 ++++
>>>  drivers/cpufreq/Kconfig.riscv | 16 ++++++++++++++++
>>>  2 files changed, 20 insertions(+)
>>>  create mode 100644 drivers/cpufreq/Kconfig.riscv
>>
>> We don't have a separate kconfig file for each architecture. Only if
>> there are too many entries for an architecture, we add a new file.
>>
>> --
>> viresh
> 
> The sun50i cpufreq driver is currently only available when CONFIG_ARM or
> CONFIG_ARM64 is selected, so this was the only decent way I could think
> of making it accessible on either one of CONFIG_(ARM | ARM64 | RISC-V).
> Any suggestions for a better workaround ?

Move the option to the main drivers/cpufreq/Kconfig, like QORIQ_CPUFREQ,
which is also used with multiple architectures (PowerPC and ARM, in that
case). We don't want two options for the same driver.

Regards,
Samuel


