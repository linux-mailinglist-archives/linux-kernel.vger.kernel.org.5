Return-Path: <linux-kernel+bounces-71117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42885A0E1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABEE2821BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A92C28E0F;
	Mon, 19 Feb 2024 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOHrTtsZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812F28DD5;
	Mon, 19 Feb 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338201; cv=none; b=CP/wJKTZVgnjfvCrR4q+y3LxP7aBf4UWk2qZdNO023LG29fkWyVgWOqTjG5DPiqBE+FEtLFrLpt7d2Iu4pMhWMMQgM8Q9trAriUbzUD7zLCq9U5CQ4H0mlN0/1TF66EmGQxQHlJXEnOVgiSJk3Y4K0nv7JaJs+2qjfLLod8L8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338201; c=relaxed/simple;
	bh=dKJLsTHvNevwcvhcDeaXvz7IVccXObxg2f+AAqsJdY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9dP1R1SpUS+jfzwFcRSFztcoz64T2P5/W3f0bnMaDlAfdfxhG0RNAifCQbr27a55F33KosaMDFXwHbxDajcgDCPgsi1zMDL0+tsQO4Zb44W1wikAWXZQ9qa4RjhkEV77oLWY47uNI+/iDToSgdUkytClkXOqCAnkatGZX52Brw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOHrTtsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49292C433A6;
	Mon, 19 Feb 2024 10:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708338200;
	bh=dKJLsTHvNevwcvhcDeaXvz7IVccXObxg2f+AAqsJdY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOHrTtsZRDJFlYS2TF/KtO3C+utLQAvQG0V8QTeNVMmn5vaBWkl9tORwHW31s9441
	 2A2s/rKkqm6libyRc1Axf0Ota85WGg70bsnC5HliD8c5cYPBvzxJa1G44V3fyskWDt
	 svMOPRGTpIY5Q6mDmfyuWjfeEIKikxHnW57xBQHbhJP+1iuIvYsIy2WR9k0SpplnWQ
	 LP1aETY/g8udTWzf0SvsNt05iQtYCPaddm0fxsXn/rlVHVVQ09IwdXWgFj/P+wcnRr
	 JceaxsrzkrEyrcJczephzSPq1d5eYD7eXQLASOuhrDSnYAbhdlZ3Su2hvD2YrYitOk
	 9vKRVmMRp+Aqw==
Date: Mon, 19 Feb 2024 11:23:13 +0100
From: Niklas Cassel <cassel@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: ata: convert MediaTek controller to the
 json-schema
Message-ID: <ZdMsEW2AnYVAB7Qf@x1-carbon>
References: <20240213074747.26151-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213074747.26151-1-zajec5@gmail.com>

On Tue, Feb 13, 2024 at 08:47:47AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/ata/ahci-mtk.txt      | 51 ----------
>  .../bindings/ata/mediatek,mtk-ahci.yaml       | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/mediatek,mtk-ahci.yaml
> 

Applied:
https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-6.9

