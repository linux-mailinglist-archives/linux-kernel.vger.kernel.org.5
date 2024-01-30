Return-Path: <linux-kernel+bounces-45301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E56842E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03C4B26310
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CC762C6;
	Tue, 30 Jan 2024 20:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD8Ogbd/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DC433A7;
	Tue, 30 Jan 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647865; cv=none; b=tkucTpnmH2IFDs+V9wewSKs1hhykyZqM7LQdsgo3qmlWck40Wb6FW1E6Lh6TKjH4+hyobV+NrDAo6sVFDRD9sO39DP5mEWcuhEMYiNAC2iTDaknMbWZtwc5RJ21/gtbxA1AF3OiO9juw6D3Ezxx3kCQsEPtLlyNorpCK4xQ/oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647865; c=relaxed/simple;
	bh=C9rvW6LWitgM8gmxa7tcJla7N5UoHPV75P76TDTeC44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7ZtGNRMure8llOwIe+vhU2A0ICLZve5ixq/beUSJXmThmgOkUA3/STChtDo0A0UiLx3BEGH8x3zdB4U7tJqvgt/0iHe4KWReXJ5Ku9R3XKjs86L6mmfmzPxhF4IpMG2YKXYOrdY+8ejWkqGhB80sKgHh2vvjDMHKs81OVNd61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD8Ogbd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74A9C433C7;
	Tue, 30 Jan 2024 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647865;
	bh=C9rvW6LWitgM8gmxa7tcJla7N5UoHPV75P76TDTeC44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD8Ogbd/w3TT8xMUfOvbZ5gQKDBD+9ZbaS8tqn7N75GVnBs/OaiwhmjrfdByCotn5
	 /pjKv5VIbzyQjIAZXYT9XbrK8AGIyz1q9BQeB4Vp2+DRuenSYo4A3TSFZHdHm/lN3U
	 TEmbaxPASHj7Bwprbd4KP7SN/JGCWChBylsnfk1WkRZ2r8pfI/2yhDCtdhkIExjVGp
	 wP8getl5js0a3f8ID8OFGf3Ms5dRDGkEm92UDXjC9qQrZMDQRctU9l9GWhlAsw4lHB
	 CslI/MNvwAmU7uOpD9kU0oe7qgqR07zGC3afefyjZsfyOlDugtbqE09tVmud7O6Ctc
	 EyLQZWBjOzvog==
Date: Tue, 30 Jan 2024 14:51:02 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: michal.simek@xilinx.com,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, git@xilinx.com,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>, monstr@monstr.eu,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: xilinx: Add support for KV260 CC
Message-ID: <170664786216.2319402.12093555371732757149.robh@kernel.org>
References: <14c184225cc4f0a61da5f8c98bc0767f8deba0df.1706019781.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c184225cc4f0a61da5f8c98bc0767f8deba0df.1706019781.git.michal.simek@amd.com>


On Tue, 23 Jan 2024 15:23:08 +0100, Michal Simek wrote:
> When DT overlay is applied at run time compatible string or model AFAIK is
> not updated. But when fdtoverlay tool is used it actually creates full
> description for used SOM and carrier card(CC). That's why there is no
> reason to use generic SOM name and its compatible strings because they are
> not properly reflected in newly created DT.
> Composing dt overlays together was introduced by commit 7a4c31ee877a
> ("arm64: zynqmp: Add support for Xilinx Kria SOM board") and later renamed
> by commit 45fe0dc4ea2e ("arm64: xilinx: Use zynqmp prefix for SOM dt
> overlays").
> DTB selection is done prior booting OS that's why there is no need to do
> run time composition for SOM and CC combination. And user space can use
> compatible string and all listed revisions to figured it out which SOM and
> CC combinations OS is running at.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> We are using U-Boot DTB reselection feature to identify SOM + CC
> combination.
> 
> This patch depends on
> https://lore.kernel.org/r/90e1a393154c3d87e8ee7dc9eef07fc937c1eaf7.1706019397.git.michal.simek@amd.com
> 
> ---
>  .../bindings/soc/xilinx/xilinx.yaml           | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


