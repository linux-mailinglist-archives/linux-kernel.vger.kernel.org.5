Return-Path: <linux-kernel+bounces-24073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645BD82B666
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F203288BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A47858120;
	Thu, 11 Jan 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhJyctOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266258116;
	Thu, 11 Jan 2024 21:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E17C433F1;
	Thu, 11 Jan 2024 21:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705007364;
	bh=/YTqlvcyML3mAIoYuEWaXt41CKva42gwP/sH160ai9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhJyctOInXL5zhfs/KMGnr5F41LDMIwpiOi0CBMZhhcJqoX6cdY8uwGULSKXRoDSo
	 ekgFlCeSHllcJKUah8fRulSmwM/67IqBtFgNtww0Ou7MrwTHsE9EtqI7rsU/QYM/Rz
	 39lmaXtsrlkJsbpmClF9tZYFyqU8R6W1DOAnD9/toZoYVa4ROldzDXYW2WU3EoPaRk
	 WtadXs/FkW/a8rFnyedRB2oPUdreXXePsRxphIJLhYQJ5X8Kf1YOzOXMnkwt7EMurM
	 yqjHNfS3x/3IvPmdnEok9e3HZg8r4cJGkgqPyJrMLXz+T5vabV10rDbzsoqfVKKjk1
	 iIFojgRAJfOVg==
Date: Thu, 11 Jan 2024 15:09:21 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: michal.simek@xilinx.com,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	git@xilinx.com, Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>, Conor Dooley <conor+dt@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	monstr@monstr.eu,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: fpga: altera: Convert bridge
 bindings to yaml
Message-ID: <170500735998.1126493.1003630532806306052.robh@kernel.org>
References: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>
 <07d646a6d82cc21b100e45ced7cae3ef05faa2cc.1704807147.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07d646a6d82cc21b100e45ced7cae3ef05faa2cc.1704807147.git.michal.simek@amd.com>


On Tue, 09 Jan 2024 14:32:39 +0100, Michal Simek wrote:
> Convert Altera's bridges to yaml with using fpga-bridge.yaml.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Add Yilun tag
> - Add missing license to altera-hps2fpga-bridge.yaml
> - Drop reg as required property from altera-fpga2sdram-bridge.yaml
> - Align file names with compatible string
> - Drop | from description entry because no need to preserve formatting
> - Keep only one example in altr,socfpga-hps2fpga-bridge.yaml
> 
>  .../fpga/altera-fpga2sdram-bridge.txt         | 13 -----
>  .../bindings/fpga/altera-freeze-bridge.txt    | 20 --------
>  .../bindings/fpga/altera-hps2fpga-bridge.txt  | 36 --------------
>  .../fpga/altr,freeze-bridge-controller.yaml   | 41 ++++++++++++++++
>  .../fpga/altr,socfpga-fpga2sdram-bridge.yaml  | 33 +++++++++++++
>  .../fpga/altr,socfpga-hps2fpga-bridge.yaml    | 49 +++++++++++++++++++
>  6 files changed, 123 insertions(+), 69 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-freeze-bridge.txt
>  delete mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/altr,freeze-bridge-controller.yaml
>  create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-fpga2sdram-bridge.yaml
>  create mode 100644 Documentation/devicetree/bindings/fpga/altr,socfpga-hps2fpga-bridge.yaml
> 

Applied, thanks!


