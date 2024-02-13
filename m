Return-Path: <linux-kernel+bounces-64154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A36853ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADE228BE30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216825FF0A;
	Tue, 13 Feb 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbd0fqH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A15812E;
	Tue, 13 Feb 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852054; cv=none; b=W/fa5R1yVK7pungNQgaFhX6pvvuVv/qF7iAQ31ifm1QWW0Dwlr2l+MYNw+DowaboZJqJP57R/vVZ9c/Ucv30O/AAsoMvejlcPnVRJ8lBoZ0zWfjmrb3pc1HGvM4iK3/VzjIEXokc15+yqfTGOh917qKBGPU62hkBI4tQpcIlHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852054; c=relaxed/simple;
	bh=62+TMzhu0tgv3ZB2azIQJRCmQ4u6vlGyJMQahNrc4uk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ofCL8ariIGf07bjbu+6hORcn6HuaQKileR8574bdXxQS6zVIsgT3IlGL3RiUCKlFwlvbyfjJsLNdmF1GsOtmJONphhdV+iYNV4iBx0d9ra36puOKMu/arY3Xr5ofdUWvvkIT12wfW1H7cYjRv4Qbkj8WSPw2b62CrYYmTq+EO9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbd0fqH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA009C43390;
	Tue, 13 Feb 2024 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707852054;
	bh=62+TMzhu0tgv3ZB2azIQJRCmQ4u6vlGyJMQahNrc4uk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sbd0fqH+8fvVZaS1HuE3/gKHgknB/hO//wWuduGJaEFz/hazFvc04ACkBmNqNtx8n
	 H7mDZmu6KSOn/t5P4Msus8XXa3SnUz6qf55F1iS7YTgf1Zyrm3TPA+gr8bQjxrF7Pa
	 E42YrmQ6GXCnMHkxl3xqCXtD9+mq+dOKgZvN8HsLGiBTtTDcUTyOZF/JBOnXi2i7Np
	 hfKv02rU9a4xvwksbgoxZUExV3ZCoLIi9dg09ID5eb2L9nZMsOdPWCKx1LRTldneai
	 OA0oYU1Hz6GbJiT7vCCbaG9dNXpQ92iO82K4wIHVTHRzL3Vm0oePYTO3CwsG0dcKlp
	 6YbKhq522Lj6w==
Date: Tue, 13 Feb 2024 13:20:52 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, linux-remoteproc@vger.kernel.org, 
 michal.simek@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 ben.levinsky@amd.com, linux-kernel@vger.kernel.org, 
 mathieu.poirier@linaro.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240213175450.3097308-3-tanmay.shah@amd.com>
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-3-tanmay.shah@amd.com>
Message-Id: <170785205177.2155555.1311787541370066483.robh@kernel.org>
Subject: Re: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings


On Tue, 13 Feb 2024 09:54:48 -0800, Tanmay Shah wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> UltraScale+ platform. It will help in defining TCM in device-tree
> and make it's access platform agnostic and data-driven.
> 
> Tightly-coupled memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> 
> The TCM resources(reg, reg-names and power-domain) are documented for
> each TCM in the R5 node. The reg and reg-names are made as required
> properties as we don't want to hardcode TCM addresses for future
> platforms and for zu+ legacy implementation will ensure that the
> old dts w/o reg/reg-names works and stable ABI is maintained.
> 
> It also extends the examples for TCM split and lockstep modes.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v10:
>   - modify number of "reg", "reg-names" and "power-domains" entries
>     based on cluster mode
>   - Add extra optional atcm and btcm in "reg" property for lockstep mode
>   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
>   - Drop previous Ack as bindings has new change
> 
> Changes in v9:
>   - None
> Changes in v8:
>   - None
> Changes in v7:
>   - None
> Changes in v6:
>   - None
> Changes in v5:
>   - None
> 
> Changes in v4:
>   - Use address-cells and size-cells value 2
>   - Modify ranges property as per new value of address-cells
>     and size-cells
>   - Modify child node "reg" property accordingly
>   - Remove previous ack for further review
> 
> v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
>  1 file changed, 170 insertions(+), 22 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml:118:13: [warning] wrong indentation: expected 10 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240213175450.3097308-3-tanmay.shah@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


