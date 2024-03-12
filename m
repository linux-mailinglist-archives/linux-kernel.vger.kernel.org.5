Return-Path: <linux-kernel+bounces-100395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4792F8796DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BBB1F21E98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAC7BAEB;
	Tue, 12 Mar 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3t2sPGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C01E48C;
	Tue, 12 Mar 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255093; cv=none; b=XpfwwOEtvBEoVohNFkr0zlasxZzYt2isPOQcquvWrqCWg/tXB3Ybqw6tsO9F9UpYuFhPZD40cAC3oLg8rT3E4NqOGz08k/QRTAP9KmDSHPFak44YuC1fgHxkLXvquO7AifYwLnobwMySosu6Hwa8a0pV+DWRY7oWYoVCZHkdtDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255093; c=relaxed/simple;
	bh=BWTCpnq6eTNAqYsko5Xoo6aB1s+ms4VZ+vaK7SZNMt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2rHK9Da5tVKclPuOzYOrHoLzcobxvYBeg7mVtxY57ayTYcAd+j71+/HfPahRfqRjTcVnwqHgLHLINvilh3lheqQ/eI0Kts0JQePpfTHVl/TOQlOo4h5NJ5PSe0fT5VyqGEiWYOKaNXObwiy7KTCF7JMBm+UshE8pd/Jja+dBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3t2sPGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCCBC433F1;
	Tue, 12 Mar 2024 14:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710255093;
	bh=BWTCpnq6eTNAqYsko5Xoo6aB1s+ms4VZ+vaK7SZNMt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3t2sPGZxWUxd2G1PgpUbUpbwk5R/f03znlekRU3Ld/HErV5y/jMxPfqSmFs1hwcR
	 HDL17jobLyCjdte+b3Hbr50z7/Av1s/C42I2sZIIxDJq013Sy9y4vrJs7iAocKQVaH
	 hWT+gO1duPS6azBigvQvJEd7lMb0fzQro4jd2frZ2Z3n4Vb+xP32ZTNpsPhnpZ+c/G
	 A+kKyREGhUo0gldvlDeQVcLrNFpi0+lvwey77oCvP8nJJk8pRzny5aEzx4/Lhu6fCX
	 IISAixjFiE5lLgJsl95sANcp/ArslpLmjFnHYp3rMWvdPIl2tNTqjVukOsfHaAgHjy
	 n3VU5MB/ZI/HQ==
Date: Tue, 12 Mar 2024 08:51:30 -0600
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: linux-kernel@vger.kernel.org, festevam@gmail.com, conor+dt@kernel.org,
	gregkh@linuxfoundation.org, s.hauer@pengutronix.de,
	peter.chen@kernel.org, linux-usb@vger.kernel.org,
	kernel@pengutronix.de, shawnguo@kernel.org, linux-imx@nxp.com,
	devicetree@vger.kernel.org, jun.li@nxp.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 04/10] dt-bindings: usb: chipidea,usb2-imx: move imx
 parts to dedicated schema
Message-ID: <171025508777.2218558.15957052770925895416.robh@kernel.org>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
 <20240312091703.1220649-4-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312091703.1220649-4-xu.yang_2@nxp.com>


On Tue, 12 Mar 2024 17:16:57 +0800, Xu Yang wrote:
> As more and more NXP i.MX chips come out, it becomes harder to maintain
> ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
> this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
> a new schema for NXP ChipIdea USB2 Controller, also add a common schema.
> 
> 1. Copy common ci-hdrc-usb2.yaml properties to a new shared
>    chipidea,usb2-common.yaml schema.
> 2. Move fsl,* compatible devices and imx spefific properties
>    to dedicated binding file chipidea,usb2-imx.yaml.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> Changes in v7:
>  - not remove ci-hdrc-usb2.yaml and move imx parts to ci-hdrc-usb2-imx.yaml
> Changes in v8:
>  - rename yaml name to chipidea,usb2-common.yaml and chipidea,usb2-imx.yaml
>  - remove common properties from ci-hdrc-usb2.yaml
>  - add new end line to chipidea,usb2-common.yaml
>  - remove fsl,anatop since it's not needed by controller
>  - fix pinctrl-names formats
> ---
>  .../bindings/usb/chipidea,usb2-common.yaml    | 200 ++++++++++
>  .../bindings/usb/chipidea,usb2-imx.yaml       | 193 ++++++++++
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 360 +-----------------
>  3 files changed, 396 insertions(+), 357 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/usb/chipidea,usb2-imx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


