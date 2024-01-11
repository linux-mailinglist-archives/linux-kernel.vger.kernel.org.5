Return-Path: <linux-kernel+bounces-24072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C682B663
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D6C1F265C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0A58128;
	Thu, 11 Jan 2024 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+lHXGXi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6C58116;
	Thu, 11 Jan 2024 21:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D58C433C7;
	Thu, 11 Jan 2024 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705007356;
	bh=+KzTILx7kXZyjh5eU7PaENUbBCcP673i64WFILoe7qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+lHXGXi7pbL53BwsXmNiOUMLsRn2/7FCqiwcuXqsQTt2MIo6S3lhxwWEaf3PzX28
	 OOGI4wXtERUCMb1WC8xxW10WQ9IqYOPfRAHCu0FMdLcnZzMz0aaFRMKN51ePD2CGPw
	 SBk7/zJrIUAlG2juFn220NWKxQhRi5TcvMiSgbKsItAiItXBcE8uL+C57fo/4MiD9d
	 mZVHr37tvdQ1T8lwcH3DtAoZ1h7dsTv/R+rVJCdedhfy0/7iZ5uHDGezV/eX7pbSE9
	 2CG1l9XTeXpcSdvmIQQ/cKQd0ZiHV2L0iaB0hev3RyfnV+nzEyOmjSZ9nhgyqxSmQZ
	 bSuI+lVicMvKw==
Date: Thu, 11 Jan 2024 15:09:14 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	kishore Manne <nava.kishore.manne@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Tom Rix <trix@redhat.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
	monstr@monstr.eu, git@xilinx.com,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: fpga: Convert bridge binding to yaml
Message-ID: <170500735096.1126044.11641247061906726408.robh@kernel.org>
References: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14558a4dcfab5255c1683015287e9c7f48b1afc2.1704807147.git.michal.simek@amd.com>


On Tue, 09 Jan 2024 14:32:38 +0100, Michal Simek wrote:
> Convert the generic fpga bridge DT binding to json-schema.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v3:
> - Improve regex to cover also nodes out of bus
> 
> Keeping Krzysztof's tag which I got in v1. Feel free to reject if you
> see any issue there.
> 
> ---
>  .../devicetree/bindings/fpga/fpga-bridge.txt  | 13 --------
>  .../devicetree/bindings/fpga/fpga-bridge.yaml | 30 +++++++++++++++++++
>  .../bindings/fpga/xlnx,pr-decoupler.yaml      |  5 +++-
>  3 files changed, 34 insertions(+), 14 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.yaml
> 

Applied, thanks!


