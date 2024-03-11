Return-Path: <linux-kernel+bounces-98446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19E877A43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7227D1F21C85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC123C9;
	Mon, 11 Mar 2024 04:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9LN/afG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839D1851;
	Mon, 11 Mar 2024 04:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710130168; cv=none; b=k4l267lkTS9gXp2ZcuwbsSyLTbupjjUuJdawiv6JEohJw+9UNfzvhb2oGmyqbTg5aVBmiwMR5GzvFDP4fMlStlTJlywRJbvh0I/NW3CjIs39imd4PFhA0b5tMmmIiSrMMHnmpRPxZ1MfFGnUe0rnvd4dhFYsyDEOtwT2TJ+tV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710130168; c=relaxed/simple;
	bh=0oVqkU4uw8JXurUzvosBD1vk3gODieTM3tIL8355CJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6Pz6qJ0JH+byA/G0vwyx0dyGbZjCnqEukRi/LndFFWJfhIWiDXO574fCblzCJig0fuqW5pBJGgjkqllyTn/M/VCyRpFtnmhBGqRKncNnx/SkVFRv/kQMyxFny/VEfgyJFNgFJR4TC9Gi+i4yB2vrtGWFV4tehRKLYuMSVHr0uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9LN/afG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E09C433C7;
	Mon, 11 Mar 2024 04:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710130168;
	bh=0oVqkU4uw8JXurUzvosBD1vk3gODieTM3tIL8355CJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p9LN/afGcUFpO+AGz1wrjwtaMZrXzr9T6JWQpq4aoxGKNjyEEVNmfaHG6C8nRJ3NN
	 jQRU7izB8NNwOd/9RhtTCkssnXECWwd0sdyq7cPkj9gkxQ6OFrBofrahnchdoYB1ew
	 ecTrL7z26xKYitx7kRoyynJyQpQo+P+lopgwjGayJn9xt/bMhq1LhOzfJkEp1I7m2h
	 GVPWyLYDN0BBm8WkU8/dzoaxix3n3ldlEFwdflqoUvvjMClvocsSNz0UP30zkhy3ms
	 hb6LbbYZQdR8eXWBuHM26Wx86KJTMHNHQSR1jcbNanprlXu978JuRGT1snRfo5fEDT
	 40kTXMN4bJA8Q==
Message-ID: <087db56b-13c3-4624-b3a3-f02989aa5409@kernel.org>
Date: Mon, 11 Mar 2024 13:09:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: imx-pata: Convert to dtschema
To: Animesh Agarwal <animeshagarwal28@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240310175217.20981-1-animeshagarwal28@gmail.com>
 <448f9d20-8b45-4794-9440-89d6a6888aee@linaro.org>
 <011b7c4c-ae44-41eb-b7eb-1a71da669f26@linaro.org>
 <CAE3Oz82ZC5Vz125iLzjsdvZd1YLd4YgQsrGPgTRJ=ugEc=e=Ow@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAE3Oz82ZC5Vz125iLzjsdvZd1YLd4YgQsrGPgTRJ=ugEc=e=Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/24 12:33, Animesh Agarwal wrote:
> On Mon, Mar 11, 2024 at 2:03 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> BTW, If this was not clear, I am quite fed up with these patches, so
>> keep the rule of one version per day. You made quite a lot of changes
>> which were not necessary and I have impression that you should just
>> double check your code *before* sending next version.
> This was my first attempt at a contribution to the linux kernel. I
> have learned a lot, I feel like I have wasted a ton of your time.
> I always try to not make any mistakes before posting but it was
> clearly not a good try.
> Moving forward I'll be a lot more cautious and write better code and
> add proper explanation for the changes I made.

It is simple: the commit message should always explain *WHAT* you did and
*WHY*. This is to give some context to reviewers and to help with checking that
your code actually does what you explained. This also helps with potential
future issues with a change as the commit message remains in the git log history.

Regardless of the version of your patch, always have the what & why explained
in your commit message. This implies that the commit message must change if the
patch content changes between versions. Keep in mind that the changelog added
to a patch is lost when the patch is applied, but the commit message remains.

> 
> Thanks & Regards
> Animesh

-- 
Damien Le Moal
Western Digital Research


