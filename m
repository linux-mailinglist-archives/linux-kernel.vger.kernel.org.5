Return-Path: <linux-kernel+bounces-119780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EC88CCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8110F2E39E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFC13CFB3;
	Tue, 26 Mar 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNhP5meo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255C13CF99;
	Tue, 26 Mar 2024 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480687; cv=none; b=W8hNfZ2fLTRvRXJGMVAuHPYHwK6I2u8Il+j+sACCvlsRqoz2QBWWa5qyXl+GqdM+mYUNeDy6VfnG5BREUJLY99omjhLgVQFvl5oar0c3X0TvCl0yCbcDSIbR+NjAzba58ymaiOVO1f4kFzG4OWeRlDewWY5leuwMg3wzXQdcW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480687; c=relaxed/simple;
	bh=caum5ikmGmMrSudEwnCODZzZi5FPeNKnz2KEgERO/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQDoq2J264nHCmgtG0E9Tfc4AXRH0BzjeLrnPbTvUIeqQU6C2UsJomC+ZPBwjiDTyzHK+fZZzaluKburfjl3tZGnNKV3tQxk0BFQi/qy/kYO7OT9JfhHnQLPnBoUM4WM2azKadMk5jMdftA2CR3ODFLzmVKm3bBlMeBPJp8MMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNhP5meo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FAAC433C7;
	Tue, 26 Mar 2024 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711480686;
	bh=caum5ikmGmMrSudEwnCODZzZi5FPeNKnz2KEgERO/8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GNhP5meokQBbvjP9Xop5L4yRPsGaeMiRej1bm7wkDeQYdua6/6wUMHCXbBvBDuYg0
	 SKKbu2GoOn5lLpVzExQaFARNBr5/pcbPYKo1pwt0LnCrBrXpt9w1jz50BxKtlDabUI
	 cLP+dowJ0V5zbYdlnyAWGvciN16ILkkhk4uFaRVX59Oy21YS1Yy5FetwlbeQ09Wylp
	 shy39f/rAhNz0WBeudKdkwQs02u07wHOdgJBSVcTfnN8HjQGT2HBjMzA7CBkcafG2U
	 TlwYDnD+gsOIjUNcC9IMUIRwY5bAHUeer+Ks4AtU9n+ue3kv1O1Y8IYZT7HtLGN/lD
	 JPwxwv/Np03Mg==
Date: Tue, 26 Mar 2024 15:18:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 5.15 110/317] arm64: dts: renesas: r8a779a0: Update to
 R-Car Gen4 compatible values
Message-ID: <ZgMfbenM7Kav2BTJ@sashalap>
References: <20240324233458.1352854-1-sashal@kernel.org>
 <20240324233458.1352854-111-sashal@kernel.org>
 <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUK0YYELTN=JQDtGuYg03Em6c7kskpqUR0Y6NbNuR7hfQ@mail.gmail.com>

On Mon, Mar 25, 2024 at 09:43:31AM +0100, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Mon, Mar 25, 2024 at 12:36 AM Sasha Levin <sashal@kernel.org> wrote:
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> [ Upstream commit a1721bbbdb5c6687d157f8b8714bba837f6028ac ]
>>
>> Despite the name, R-Car V3U is the first member of the R-Car Gen4
>> family.  Hence update the compatible properties in various device nodes
>> to include family-specific compatible values for R-Car Gen4 instead of
>> R-Car Gen3:
>>   - DMAC,
>>   - (H)SCIF,
>>   - I2C,
>>   - IPMMU,
>>   - WDT.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Link: https://lore.kernel.org/r/73cea9d5e1a6639422c67e4df4285042e31c9fd5.1651497071.git.geert+renesas@glider.be
>> Stable-dep-of: 0c51912331f8 ("arm64: dts: renesas: r8a779a0: Correct avb[01] reg sizes")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a779a0.dtsi | 24 +++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
>> index 26899fb768a73..c7d1b79692c11 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a779a0.dtsi
>> @@ -583,7 +583,7 @@ hscif3: serial@e66a0000 {
>>
>>                 avb0: ethernet@e6800000 {
>>                         compatible = "renesas,etheravb-r8a779a0",
>> -                                    "renesas,etheravb-rcar-gen3";
>> +                                    "renesas,etheravb-rcar-gen4";
>
>This change will break Ethernet, as the Renesas EtherAVB driver in
>v5.15.x does not handle "renesas,etheravb-rcar-gen4" yet.
>
>That can be fixed by also backporting commit 949f252a8594a860
>("net: ravb: Add R-Car Gen4 support") in v6.1.

I'll just drop this patch instead, thanks!

-- 
Thanks,
Sasha

