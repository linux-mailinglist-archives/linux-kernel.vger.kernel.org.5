Return-Path: <linux-kernel+bounces-153469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D88ACE79
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389421F21329
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2895D150997;
	Mon, 22 Apr 2024 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mLcLmNSC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460914F10E;
	Mon, 22 Apr 2024 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793116; cv=none; b=fNL5X6snxNS8+uIS9GbtcLg7ngteRdEiJkAAOPjKbMJzVuPTU5BDYLG5BBgq4wBh6q/FBtCh4yV/AVnhFZgNAtNVDp6Q4mzpqiDDQSmGcv06TbrssrNjr3b0t1tU9aueeSWhCjP479dYkuV3zoApHbGzECO7+qHl/kxexlxVqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793116; c=relaxed/simple;
	bh=6F+LT2q3yqToeF5QNOLF1VqWjh6jSnDMZ0wnh3Nc+Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApWqcoZacuN5b77WuwxyAu1gzqc9EQByWjrfl1GoCoTCQQwZyTaVfw1Rl6P8sED7pFlNrM+2hJCJGa0Cu6FaCSeDmedLYcUQbfoIpwVesbSq9zc7Q0j1PWek/JyejluhEoGFeRIL1noQQbPCCuwKgNcC1QJC1qKi0v8DIN3EG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mLcLmNSC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i/z/ljxJCkCbXFoPaHHHNc0jJSxMgEuJU2NmFrG20xw=; b=mLcLmNSCdrh0Fz850zbJXom4Iw
	K9BFaWBG6Mu8rmWJ9OUDJecizh3SPiaSGkWUzUp5BHb3hHgAJMOZ9BLS0cay6cCSeqbOg+kZIcEYt
	TKsqsZZEEJA/9mhJTGQNThMLo9VtqMtowJxDEzIJJMTltkeMT0xvR6q7lU4STfl75lsc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytsJ-00Dcas-VI; Mon, 22 Apr 2024 15:38:27 +0200
Date: Mon, 22 Apr 2024 15:38:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: add description for solidrun cn9130
 som and clearfog boards
Message-ID: <0c43e182-ac86-4a70-88a9-d064bfa74d6c@lunn.ch>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-3-350a67d44e0a@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-cn9130-som-v3-3-350a67d44e0a@solid-run.com>

On Sun, Apr 14, 2024 at 02:58:34PM +0200, Josua Mayer wrote:
> Add description for the SolidRun CN9130 SoM, and Clearfog Base / Pro
> reference boards.
> 
> The SoM has been designed as a pin-compatible replacement for the older
> Armada 388 based SoM. Therefore it supports the same boards and a
> similar feature set.
> 
> Most notable upgrades:
> - 4x Cortex-A72
> - 10Gbps SFP
> - Both eMMC and SD supported at the same time
> 
> The developer first supporting this product at SolidRun decided to use
> different filenames for the DTBs: Armada 388 uses the full
> "clearfog" string while cn9130 uses the abbreviation "cf".
> This name is already hard-coded in pre-installed vendor u-boot and can
> not be changed easily.
> 
> NOTICE IN CASE ANYBODY WANTS TO SELF-UPGRADE:
> CN9130 SoM has a different footprint from Armada 388 SoM.
> Components on the carrier board below the SoM may collide causing
> damage, such as on Clearfog Base.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

