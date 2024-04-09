Return-Path: <linux-kernel+bounces-137190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6989DE78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A370A1F289A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31E12FB3E;
	Tue,  9 Apr 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTTAoRT8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BE130E2A;
	Tue,  9 Apr 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675444; cv=none; b=JoB+cI70xlD1Unilhr1fPBiXt9Zxj7/Xy1Vkt5W1fYKqKSaGXj4dWVmKsXGYAFYdp0/DuFKcLj+vYMrgh+SvRGjVRXmf66xBqc/+FqSrlF/VFP7cYraatz85o81Gp5Ha6/8rUrisH+Rh7x79pNBbwsO+sGdCZOstkT0K9IHbCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675444; c=relaxed/simple;
	bh=ekT0sGSo3AMhRcIQz//3SzF8DW+WDol7YcBnxFf/pyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZixKs45pttdz8MR/gONRleyFNbJ94NjQxndxLnZeKKrTW2LrKfn4ejMdZlmhMhJtKGGbWZp9eRrMpc6FbKMieFrAp3JO8eofEtzWEhtsxywbw1lFIxgUFykP7h5jc1lMJtxNEd7+/YYSY+ZQCvIjX5mlRuD+SJm82eq/1obrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTTAoRT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF39C433F1;
	Tue,  9 Apr 2024 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675443;
	bh=ekT0sGSo3AMhRcIQz//3SzF8DW+WDol7YcBnxFf/pyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTTAoRT8ckbyRuB/D0RFBxU90uJcw1DMXxt/9IhiBNPPMktexx0h677k+lTha1VrB
	 I6rDY7fDKpiZ5tyu2jX9HWONXvOXfRPyWc87nxGrBjBR/XyavKJlEZrIB/23c9PZWL
	 NmGoJ8I8GpyN5oteLMBIFvz7LjV1v01NVeDYBYbJz/3+Mhpu2qwOuJx1mlaLRyH5ZN
	 1XaWKHlXCx8g9CMZ6H84ZPTc1/YQVpqKXtoYhzfyipDyCaPiOwAYiqy+fqzRz1GOFz
	 HlqiJ23+wJm61+Yb/oXZmIUZwvefPoxv4zUGr8FK4GB92yC7+Cxd1aDnhQL72u5Yqr
	 pK0GAkPtqfN9A==
Date: Tue, 9 Apr 2024 10:10:41 -0500
From: Rob Herring <robh@kernel.org>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix up qcom,halt-regs definition in various schemas
Message-ID: <20240409151041.GA1141635-robh@kernel.org>
References: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407-qcom-halt-regs-fixup-v1-0-a0ea4e2c178e@z3ntu.xyz>

On Sun, Apr 07, 2024 at 11:58:29AM +0200, Luca Weiss wrote:
> The original motivation is that a bunch of other schemas fail to
> validate qcom,halt-regs, for example like in the following examples:
> 
> arch/arm64/boot/dts/qcom/apq8016-sbc.dtb: remoteproc@4080000: qcom,halt-regs:0: [20] is too short
>         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#
> arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb: remoteproc@2080000: qcom,halt-regs:0: [82] is too short
>         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8996-mss-pil.yaml#
> arch/arm64/boot/dts/qcom/apq8039-t2.dtb: remoteproc@4080000: qcom,halt-regs:0: [32] is too short
>         from schema $id: http://devicetree.org/schemas/remoteproc/qcom,msm8916-mss-pil.yaml#
> 
> While I'm actually not quite sure why these patches fix this in
> the other schemas - feels like a bug/limitation in dt-schema maybe? -

Was this with v2024.02? It should be a bit better there. Though it 
may just have different errors. The limitation is that property 
types and in the case of matrix's (which phandle-array actually is) 
range for dimensions are global. So if there's not correct dimensions 
for a property, the tools aren't going to decode it properly.

Rob

