Return-Path: <linux-kernel+bounces-53259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A425784A2CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A48B24EDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4A482E1;
	Mon,  5 Feb 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftT2BpKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A9482CC;
	Mon,  5 Feb 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159233; cv=none; b=a5Vgz0PGgpfruvghmwMBByPHVcQbCRJ4OHnQA18DwxzhOOVgx7oaqLDcv31B/4p7TGJbabBfLQXpSZkEi2PJnaY1FpZxvhWnT51EhZNNNHIAF6aof5tKEv5RE5/4ShbQRJYuzni5q7fwL/wtxjD3V0LnUIHBjx19nu6UuhcPwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159233; c=relaxed/simple;
	bh=Qbx4RfwsaRZewR7VF0LKKdglBS5+QqF1mISUf3SCQug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCMJKLNtWT7dvidWvLGep+V4xQSMBW9+6zzu1KloC496Yuo+ykE7gbfFeQ3xsyDIoz+Xplsdggt25XtectZmJ8WLZfjwXBuD64fI1RYItNG00xDODxS43hrdOs5Xzy3ZRg98NRgGxjb2PCI6dbjerSm5vGNrFo1plb8Fl7kYp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftT2BpKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDE2C433C7;
	Mon,  5 Feb 2024 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159233;
	bh=Qbx4RfwsaRZewR7VF0LKKdglBS5+QqF1mISUf3SCQug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftT2BpKqjqUHMeAYjo4IpSNQqGKP0HbPsNaNR1Va8KtG5qA5Y4uT3i+OO8ulu9lgS
	 2yYkX4xjOXMSdWdJTj85sfOP34hp1quElDtsSEVDRmXwPUg5MdVVY4Cko5ioJJNL92
	 8TefZuModxElW4R2bofhx08Jsc3DaC7PNuT8LJhcwV1B4Lo2gvZ/Qg7xXT6IaGaYQ4
	 eK+SZI8zSwji8RFhKZ52zuH7sXmLEjK0LHuxkVP79QlyCwgzcxdknnkqX5Uv+uPY8O
	 GhILRGN7/Tut0SKYA6oUZb9btKe3mKOZhvgS7wLEO5s7q6Bhe2w3ZxhTtBexEQQz9Z
	 QJ8cnBxJh15cA==
Date: Mon, 5 Feb 2024 18:53:49 +0000
From: Rob Herring <robh@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	f.fainelli@gmail.com, kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
	kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, David Regan <dregan@broadcom.com>,
	devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v4 01/12] dt-bindings: mtd: brcmnand: Updates for bcmbca
 SoCs
Message-ID: <20240205185349.GA4084919-robh@kernel.org>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-2-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203002834.171462-2-william.zhang@broadcom.com>

On Fri, Feb 02, 2024 at 04:28:22PM -0800, William Zhang wrote:
> Update the descriptions to reflect different families of broadband SoC and
> use the general name bcmbca for ARM based SoC.
> 
> Remove the requirement of interrupts property to reflect the driver
> code and only require interrupt-names when interrupts property present.
> 
> Also add myself to the list of maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> 
> ---
> 
> Changes in v4:
> - Split the yaml changes into three patches. This is the first one.
> 
> Changes in v3:
> - Update brcm,nand-use-wp description
> - Revert the description change to BCM63168 SoC-specific NAND controller
> 
> Changes in v2:
> - Revert the new compatible string nand-bcmbca
> - Drop the BCM63168 compatible fix to avoid any potential ABI
> incompatibility issue
> - Simplify the explanation for brcm,nand-use-wp
> - Keep the interrupt name requirement when interrupt number is specified
> 
>  .../devicetree/bindings/mtd/brcm,brcmnand.yaml      | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

