Return-Path: <linux-kernel+bounces-31796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED4833435
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50C41C2110A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1EEFC05;
	Sat, 20 Jan 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMMmubTt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA9F9EF;
	Sat, 20 Jan 2024 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705754204; cv=none; b=srPf9BeY9ya2afBtnYRL30kyJz+7qXZ2+vlV9DJI7yl2syaasNNJes/ZrpaFpvQfTGmqROqI0vuWtrlg40Qi5l5TGA8QIf4lyThST/ndN0Lul6SFjWDTFHuVtnrfPGhK//0urQE6p4FNmMZNxUCZeFo0tuQjhj17a2kjxJnDVa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705754204; c=relaxed/simple;
	bh=JFbVPLeUaarFANAzkBXxTbnXOQe+ZHxPUPx/xfP7S5I=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=htme6p0CW+ae0rEeNHPhfejAAmItsnY4IAXRUUzmXMboZv9bGFdhYhyL/vUQP9uk5mnFoOLjpal4lfP0uJYoIavrJSUqq9AelH+waWClcmORl6cfytCVkiERIMgM92VUE4+sG3U0cUIeDloqffcaC75Q8Ssp7s4xiMVL85f39jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMMmubTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB694C433C7;
	Sat, 20 Jan 2024 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705754204;
	bh=JFbVPLeUaarFANAzkBXxTbnXOQe+ZHxPUPx/xfP7S5I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rMMmubTtDKjosznI3CYfdzztJU8fXp7j5zqwk7yCn5iBIMgCOhKJwqa1ksezETdbI
	 vHYwGbDQXYM2eBTYQxjqy5g2bO6OK1aewUzlM7ikkPpFZV99mGEUXQJUhFqgYyHrqH
	 rDLGFFqurUb9mjsXu9hzAY/WPgTmRrxkKhJA668OMtHzivEp3dxpQt6R1QNp160s0B
	 cjpZNNI2Stf9XwFJhB4b/sraetaC+lSKdKbP+xMsKdnXA8tVMHkEjfKM23E6T4kjKZ
	 pUb8ZIRQwdlcQXuZW/OcU+L0vho4epX3/DNY6clGB+gZDcKokcYJqg7jEh71BzFuLp
	 YByRxX1pxWWBA==
Date: Sat, 20 Jan 2024 06:36:42 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Amrit Anand <quic_amrianan@quicinc.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@quicinc.com, devicetree@vger.kernel.org, konrad.dybcio@linaro.org, 
 andersson@kernel.org, robh+dt@kernel.org, 
 Elliot Berman <quic_eberman@quicinc.com>, agross@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
In-Reply-To: <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com>
Message-Id: <170575419908.2509092.7007610150543615061.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: hwinfo: Add Qualcomm's board-id types


On Sat, 20 Jan 2024 16:50:49 +0530, Amrit Anand wrote:
> Qualcomm based DT uses two or three different identifiers. The SoC
> based idenfier which signifies chipset and the revision for those
> chipsets. The board based identifier is used to distinguish different
> boards (e.g. IDP, MTP) along with the different types of same boards.
> The PMIC attached to the board can also be used as a identifier for
> device tree.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  .../devicetree/bindings/hwinfo/qcom,board-id.yaml  | 86 ++++++++++++++++++++++
>  include/dt-bindings/arm/qcom,ids.h                 | 68 +++++++++++++++--
>  2 files changed, 146 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/hwinfo/qcom,board-id.yaml:70:4: [warning] wrong indentation: expected 2 but found 3 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1705749649-4708-3-git-send-email-quic_amrianan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


