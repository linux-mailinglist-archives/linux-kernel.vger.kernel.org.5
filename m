Return-Path: <linux-kernel+bounces-28748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D983028C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1D1B21044
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4E414017;
	Wed, 17 Jan 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="Zs/Wx1v0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LILT3mFl"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8614004;
	Wed, 17 Jan 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484573; cv=none; b=f9K+tdmeEfCTjVIDcKJeh2rsJANzCSwqJULV40o0TWDGWPCDQxDBuRCBDpwtuO8njZCew3iW3BSXUccAaQI38XTRW2j0d2EmMIwuSkYi1MsMoqClIbsq8G4V/NnDJ39EK7iVyv+9u99SToZNEzp6JzLLFRB/y8h9F6z1Zfxy3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484573; c=relaxed/simple;
	bh=Eb75W8dJ2rW8+fspUYKekijnVMwybRgRp4z8F5SnPAM=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=oWsvNQ/ZE0k54hv5RP0AfBSbw5mEUdtIWgfIPQYWgCP1EULX29Hx1b17SVIr3KLg5aGYwoorbYMpd/KAPgYyubK0/ovKaU0EVAZU36dEKO4CS2qqPKRg8Bj2uMS30YM0834PAso878N1aGozfH4obkzO6JnlYokDspavKZpcD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=Zs/Wx1v0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LILT3mFl; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C25115C0129;
	Wed, 17 Jan 2024 04:42:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 17 Jan 2024 04:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705484571; x=1705570971; bh=yA6uNuuiweBkY5mRLJUzBnsYGOl08z4i
	FjYHtsbmNT8=; b=Zs/Wx1v0xHGI8TFKOWr9hihmS7/BjYyt8er8PT17jd66P8Yt
	Mi6dC4B7JemNdZZK1moO1LtYHlgnV3zrXjbdDXeimPR1ke0be9JIFgPsCyq2m8tA
	sTEaGexrFTx0h1zy/OwuRlaO/tif8P2AnNtnFZpYnclMq9amMzgvJINcklW4uyxR
	lCoRLHy0enaAcXKNJKW/WPSkLmrHd2attjS/zK55v2I/GMIBF+/30ihZrRuG+gc+
	0/NLcfKHcBVwFybYMkPVQVWuSJaupO/mv1rzLvtYHZJBG6AKEjnZpk7jpZ/gBhuD
	SNXzE8kwfe56CXTOKxLTjA83PkFDxyRa/i1eqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705484571; x=
	1705570971; bh=yA6uNuuiweBkY5mRLJUzBnsYGOl08z4iFjYHtsbmNT8=; b=L
	ILT3mFlhRevOz8yHndp9B8RJgbpSyQH7eQdxmrwanUeYIFOlQ5iaDVE6wUz2qYka
	BgWhyuiJOn2rJfM0AAf7IrytLS02hBSURW022wgFezgtsq+/beoaH/k5aC3nOhgR
	i7w9qFvEeqG7f3HQKJMZcr3Wlf69FRDIcjuut9kyiNTTiu8dX15TEowySbsPyh7u
	eoNe6Jh5rrviTs8qM/luRMlKJmd6UMyOela4xWXVU7gZJuUpF7EUVFMb1ZmDmX20
	h8R4kNfgqjDOdiRpUc60P09au3b3D/C5SB9ULwiCcT5vRKMxEzJjZ1LgozBiNJdV
	YkF/pb0qezO6NLHpAw4xw==
X-ME-Sender: <xms:G6GnZRLzbCZztcR577k881FGkkVjiyLHtrvcXCjU77ULZzFemB5rGQ>
    <xme:G6GnZdLGUzeyasjo17f5hZWXms2pBk4v3SQ-rip9k9LU_94RHbAOrU7HNB8RPYsSq
    Onqi24y5A>
X-ME-Received: <xmr:G6GnZZurRDC2jrNIUfsD80lKlckr4pJLpnzSFCB_-IcgICQu94-hk_BGqXYZ7N4e5dudSSAcqYJDRAYSfseIiwxrfhmjfJwkDTXwbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:G6GnZSa_MSHU8yHzdXTd0md3lkRXwSE_7E3Bm5MIrAMWdFhIT8rL8A>
    <xmx:G6GnZYZLNjvAEOchyJcJ9lC5OLuOo0u7s34npFb84AC-Oqgle-eImg>
    <xmx:G6GnZWAoZ1KBE6HNQiNigBVktM1UsR2ZbwhH-nbx6hqW0krnosimpg>
    <xmx:G6GnZWn1bMtEdEee9wQUIqK9aRp9MyVlvKTOJZdvu_XFSzA73StjgA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 04:42:47 -0500 (EST)
Message-ID: <79565cd6-4874-447a-b51f-774c312a02fc@feathertop.org>
Date: Wed, 17 Jan 2024 20:42:45 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: rockchip: Add support for rk809 audio
 codec
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240116132102.3272682-1-tim@feathertop.org>
 <20240116195246.GA306579-robh@kernel.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240116195246.GA306579-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/24 06:52, Rob Herring wrote:
> On Wed, Jan 17, 2024 at 12:20:59AM +1100, Tim Lunn wrote:
>> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
>> using the same rk817_codec driver. However it is missing from the
>> bindings.
>>
>> This series documents the audio codec properties in rockchip,rk809.yaml
>> bindings and updates example.
>>
>> Changes in v2:
>> - Fix vcc-supply warning detected by dt_binding bot
>> - Fix missing include and pinctrl for codec example
> I just reviewed v1. Please apply those comments. And wait a bit between
> sending new versions.
>
Sorry about that, first series was broken as per bot response, but will 
wait longer in future.

Regards
    Tim
>
> Rob

