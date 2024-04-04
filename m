Return-Path: <linux-kernel+bounces-130811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2819897D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A091F28C14
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67CC8CE;
	Thu,  4 Apr 2024 01:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="C7w/5INM"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD498C06;
	Thu,  4 Apr 2024 01:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712193474; cv=none; b=bQi183i3wmzSbyhIiPzDfa45K37RDUkDk6MpJKinXENaTjXs5tFH6OV1KrF0Fkcr3WI78M6pWQVEzdxTWOyTj2UK7STd49Z9wH4tKRgbodZY8bLUiSf+0ZRhlwzOZp8TAJ4IojNwnsdbf0lkB+wfmS2w0kCNsHJAnUfvsZhroIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712193474; c=relaxed/simple;
	bh=Dt5497XqBT8wkrfVHptycgzBoditRUn2tucDSvLDxv8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upyBmZ+KJ9xy5t3nInWu5tUGcc661gC9QpSPbCr8o+lrbvmykywvFIz92oLX3Js2UgUn0M8NiZm5cvWzPxpGdhswpPb+KQ+PC+t3W7z2691u8iwoW8Lgy+5tgOePKCnDM6fkf3IZxU4qduWAkwckaGUyrHJBRon0ormSeM3P7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C7w/5INM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CB38C20172;
	Thu,  4 Apr 2024 09:17:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712193470;
	bh=AnZy1ul9z22wLV53sWsuV/QLH4baWunjG6AMLZ7wkaE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=C7w/5INMzf9doVl0bXoxlonTUfuLxaoa0qEhYhcoJ7nRVWjtwpusMfDVmGMFfl+sZ
	 Gn2mVUSGFpGWgHBi/s8l0kMXpL0k+aFdGA25ZQ0K4HrvwaFqlUj5dhIO6f4+l24LQi
	 mdQkJ18moNCE/X6VGdnL2UgMSMS/J1hPM8Vhg1ofpiRLjnxxbjUmmZpzexQbdn4zm2
	 rg3LUl2DyrcFfBg+pmVamLUY44RgJuxvCvGZ3TKUQm9fsqTNLPOmWbGSZXHN40jwDc
	 2rE6kcULCi3NSPh6vAajadYiY73FuQI+vyAk0mhb1ij16iOes/VtcCcLZyE/k8APSI
	 AF07bWtSMGCsw==
Message-ID: <77829355a18f2afd64343e7e19498473d9263ef6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U
 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Renze Nicolai <renze@rnplus.nl>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org,  robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 joel@jms.id.au,  andrew@aj.id.au
Date: Thu, 04 Apr 2024 11:47:38 +1030
In-Reply-To: <20240403133037.37782-2-renze@rnplus.nl>
References: <20240403133037.37782-1-renze@rnplus.nl>
	 <20240403133037.37782-2-renze@rnplus.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Renze,

In the future, the start of the subject should also include 'aspeed: ',
so:

    ARM: dts: aspeed: Modify GPIO table for Asrock X570D4U BMC

On Wed, 2024-04-03 at 15:28 +0200, Renze Nicolai wrote:
> Restructure GPIO table to fit maximum line length.
>=20
> Fix mistakes found while working on OpenBMC
> userland configuration and based on probing
> the board.
>=20
> Schematic for this board is not available.
> Because of this the choice was made to
> use a descriptive method for naming the
> GPIOs.
>=20
>  - Push-pull outputs start with output-*
>  - Open-drain outputs start with control-*
>  - LED outputs start with led-*
>  - Inputs start with input-*
>  - Button inputs start with button-*
>  - Active low signals end with *-n

This seems to be a bit of a mix of following conventions in [1] and
not. It might be helpful to weigh in on that document with your ideas.

[1]: https://github.com/openbmc/docs/blob/master/designs/device-tree-gpio-n=
aming.md

I'll put this series in a tree for Joel for now though, with the
subject fix mentioned above.

I've also re-wrapped the commit messages as it seems you stopped a bit
short of the allowable line length.

Andrew

