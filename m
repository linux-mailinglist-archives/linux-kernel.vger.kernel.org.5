Return-Path: <linux-kernel+bounces-123641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A7890C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE89B214DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114713A875;
	Thu, 28 Mar 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTCRzxxi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C3380;
	Thu, 28 Mar 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659666; cv=none; b=YbMMpkgXXHLPEW6TLANo65Kn0fUk2FlhLl1j7+aGh+SSi6QjUkTKDkkMVUohOKhCorXoryDUw2dAuxoD+ab89Okd8k1TLnfaE2KLd5Y+f3n9TFctbbyqkF/0CheG1xu3BuYrPT9iEtrcQ22aPReJEqziA5o3M9JXMl2FkrAFyBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659666; c=relaxed/simple;
	bh=gv7eh1jsoxw/Jco25MILAZOk0GfG/Bj+t92VgU+wtcA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=eGvEisOOj77Ca+DWpOAXThsIT1ex0MT7t5xADjf1pEtJASD0kLHRbKMWntcZNfYQ/GPwB5AqtRljiNuGOyH9lU1VDqJpoIekka4Rch9tPeofvvp+AEuD7W1dANWq0r3mczuddNEyEsICFZw2iOPwSJ9QiGlaOuZj5WNFivLzQ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTCRzxxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E51C433C7;
	Thu, 28 Mar 2024 21:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711659666;
	bh=gv7eh1jsoxw/Jco25MILAZOk0GfG/Bj+t92VgU+wtcA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CTCRzxxiGSjqnPTo3dwmkDphATEUj8SsJj4JPl9ANLHFwSFcdntpGD9GkFg65E8H1
	 SDUtkWI3AUpyZ88uhTSLaTXv7teADDRua6UTFl/Oi/OqwOds39vB1XjUb8O4hHe0de
	 M9bIvJ3zRCoc8D1ZhwZgdtKD5tR8nN67y+nP46Uynj++Ogc5/FH1cbPjCbnFJg5yya
	 pRBAAO8PisV6yCW3ENL4cJr5FP707ReYUGdiSDilAc+aSMPSGf2VcV00Hsnx3TJr8W
	 JaULCMZw2/o8LpScKRL+KbEHkuFm5r420tpY7abnfzPf4xcud1v5xPSEmJgI5B4NbF
	 eodxW7DbA/IHA==
Date: Thu, 28 Mar 2024 16:01:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Jared McArthur <j-mcarthur@ti.com>, 
 Jason Kridner <jkridner@beagleboard.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Nishanth Menon <nm@ti.com>, Deepak Khatri <lorforlinux@beagleboard.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240328191205.82295-1-robertcnelson@gmail.com>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
Message-Id: <171165955921.338133.1794503768806521684.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI


On Thu, 28 Mar 2024 14:12:04 -0500, Robert Nelson wrote:
> This board is based on ti,j722s
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y ti/k3-j722s-beagley-ai.dtb' for 20240328191205.82295-1-robertcnelson@gmail.com:

arch/arm64/boot/dts/ti/k3-j722s-beagley-ai.dtb: pinctrl@f4000: 'vdd-3v3-sd-pins-default' does not match any of the regexes: '-pins(-[0-9]+)?$|-pin$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-single.yaml#






