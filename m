Return-Path: <linux-kernel+bounces-137622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B289E4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6333B1C21212
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE955158867;
	Tue,  9 Apr 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCQobwuH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D19153BDD;
	Tue,  9 Apr 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695753; cv=none; b=UsNRsZssfCAnrc3xE3mCDiL+dAluK7hGypWETrJp1eSKRI5UxtjyEJQNmNpxPm6QTuz/um3ZzPp05M8o9D1k8TPA0KCcyet87d36ReZOFc6hHYUlv5iF+oT9zxLEMNgFyq1g0LcF9vTe00hpPdvSUvHvfBZtweN5yaINS47QaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695753; c=relaxed/simple;
	bh=pCdcsQUmCnc6COisoFP/0WhirgGUlE6yNK7he9qeYd8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SrqUD8LgHOacDBOhnNVNZQ65nJ39gE4atfZ9gjJfHTjeGgUSODSfqE/FXMWJZOxKvRiHKYXS5V3LYpuPgUjtPcOOTvrE9yEDxKlkSRqaUNfL3Bz3dBygffUT0Cvn+Q1qutkmuHNQPCrfk8rpAfWShw50tfaALBxHHVI9ez8YsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCQobwuH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FABCC433F1;
	Tue,  9 Apr 2024 20:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712695752;
	bh=pCdcsQUmCnc6COisoFP/0WhirgGUlE6yNK7he9qeYd8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YCQobwuHqqXxEosscmDYkKbigWayEoJkp3jcBbVGjj7vC7+mfI7VPVXNj/nQoI/Q+
	 GKA5HxgVLlLWmpQzWguWxbakVwzyJ3ZwqB2fqXo1xWcOcvmrtYfRehWAqS3fwqU/32
	 aiCl4nsBBSkp769fBxlucQlze2lN4georAHEL20O1P/bhlpYS39Yhh9I0uJyLVeBwa
	 355jDfoTGZvVdAHzXRRbG96qLFRGGaQpK5/fybciti1mkKfVekmWpRxKGlyLmVkcfN
	 KqGDyuQnZ7C75SRK9VZ6A66jIjCQInNt5YIDpFZ7nArT7sPv0vggXeiHNyXoYdKS23
	 gYf/CN5wT3tZg==
Date: Tue, 09 Apr 2024 15:49:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-phy@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20240409190833.3485824-6-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
Message-Id: <171269575025.2154927.5085638397784185466.robh@kernel.org>
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY


On Tue, 09 Apr 2024 14:08:31 -0500, Alexandru Gagniuc wrote:
> The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
> extra clocks named "anoc" and "snoc". Document this, and add a
> new compatible string for this PHY.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 31 ++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.example.dtb: phy@84000: clock-names: ['aux', 'cfg_ahb', 'pipe'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,ipq8074-qmp-pcie-phy.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240409190833.3485824-6-mr.nuke.me@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


