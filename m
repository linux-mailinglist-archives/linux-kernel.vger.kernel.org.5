Return-Path: <linux-kernel+bounces-37923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EAC83B7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B4285D42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6F79F9;
	Thu, 25 Jan 2024 03:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwLr52Te"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146EF13ADB;
	Thu, 25 Jan 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153321; cv=none; b=brjceQhoP6jd3pvqDKbGs+xWr5Kw1QJOeKQImBL9iq54CKR3AWBOslWj7pm5x0rhrHY3bT8Iv8Ra6Mgx144fyYar4hKx5McpVehVC1pF6mGjPE1VP4l8VDsowKu1eFQc4FBFotYHw7YxUQNqeNC+LSXIR1YZYQoMm+F5yU0buN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153321; c=relaxed/simple;
	bh=Kva1tWKcJg0zE0DdlczPPJaX/KuNJrJhl8rwMtTZf6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwNqWKKdIoigfEsZmY8TZBWv3MNGWjl/5HRqURVDBuGFGE2rGaIP9A8kdeQivQvcaY03/gW+tjUxDGRZbhOnrcKj5xanDkDXpJq5kDToNQE4/0yXtWuvgBHzXqPs6K69WBVYEt2s9kTDz76N5GNTECs7VrpFBBfA3+2ElWngJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwLr52Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA71C43394;
	Thu, 25 Jan 2024 03:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706153320;
	bh=Kva1tWKcJg0zE0DdlczPPJaX/KuNJrJhl8rwMtTZf6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwLr52Te7onrCNJ1fodf7MW1UXYraK3+uLgekbbdPCs3S8KeYrMpwIeX4vWpEEYV/
	 9Zhn/zYI/ugu4Ga+hgDWZgadoL1K5JEyk38doOnuJdEt3N9bwcVZWr/Ig7xQByl8Lz
	 U/qDAQJ9SsnOgJRpLW4ZqyjjnpzgGjIkk3j2WEZyo7qY2AeJS6zVfcSstVx/H6E6eF
	 5SMIOaAKCHHbq68QMrpT+a6v94LSBF6FXIV/yM3iAxurD5sNN8wzXhhCsImFL14APn
	 vutOhJdBcZA8hJ/jccKhg1b3GmaXJ9+vfoPLdssG21ssOTmf9aBrJbS5MauNpj0ogZ
	 bP2kg8/Mxz8Lg==
Date: Wed, 24 Jan 2024 21:28:38 -0600
From: Rob Herring <robh@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: linus.walleij@linaro.org, devicetree@vger.kernel.org, cassel@kernel.org,
	git@amd.com, dlemoal@kernel.org, linux-ide@vger.kernel.org,
	gregkh@linuxfoundation.org, p.zabel@pengutronix.de,
	conor+dt@kernel.org, linux-usb@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, mubin.sayyed@amd.com,
	robh+dt@kernel.org, linux-gpio@vger.kernel.org,
	piyush.mehta@amd.com, michal.simek@amd.com, brgl@bgdev.pl
Subject: Re: [PATCH] dt-bindings: xilinx: replace Piyush Mehta maintainership
Message-ID: <170615331135.2510736.7512178529599197491.robh@kernel.org>
References: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705664181-722937-1-git-send-email-radhey.shyam.pandey@amd.com>


On Fri, 19 Jan 2024 17:06:21 +0530, Radhey Shyam Pandey wrote:
> As Piyush is leaving AMD, he handed over ahci-ceva, ZynqMP Mode Pin GPIO
> controller, Zynq UltraScale+ MPSoC and Versal reset, Xilinx SuperSpeed
> DWC3 USB SoC controller, Microchip USB5744 4-port Hub Controller and
> Xilinx udc controller maintainership duties to Mubin and Radhey.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml      | 3 ++-
>  .../devicetree/bindings/gpio/xlnx,zynqmp-gpio-modepin.yaml     | 3 ++-
>  Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.yaml | 3 ++-
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml         | 3 ++-
>  Documentation/devicetree/bindings/usb/microchip,usb5744.yaml   | 3 ++-
>  Documentation/devicetree/bindings/usb/xlnx,usb2.yaml           | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 

Applied, thanks!


