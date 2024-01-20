Return-Path: <linux-kernel+bounces-31795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF60F833430
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663861F221A2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E6EED7;
	Sat, 20 Jan 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MReup81g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14963EADD;
	Sat, 20 Jan 2024 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705754202; cv=none; b=rmNmBb6/DbXgjYQPnJNudRIU2GxkjX+amuEIvyeVG5F01JE3sXLNcou8fd5Iy+MKSxWPjB3pHbXL61mDripxlGcYPhle8zwbMrHmRWIWyv63bf1fwuk7/lR0IBavidDZA/2zwCIT5IO0K/Di7wgmYFib7K95D54IBg1ZtGBos6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705754202; c=relaxed/simple;
	bh=HFmDm3/WdciK/vzSbErWl4yY40pQaHc9P/M9SAN2U9k=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Zirjrbno9Hagk/5Cn52XPE1jlyPPbKfiw2OP6rriJp4ZHvggmH9b5+7j5W8iS7dGNggQGHuUb3Tk5yZWY7Mg9JE98FC/KKyK7PLlmbnKkUBwoLkobq9L8vMwAPWUVbT7c2av4n57ecjfJJ4vCHr9IN79GGPsQGJcMxJrJhG9y+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MReup81g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CE0C433C7;
	Sat, 20 Jan 2024 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705754201;
	bh=HFmDm3/WdciK/vzSbErWl4yY40pQaHc9P/M9SAN2U9k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MReup81g44Emsopj1C5whJ1cSADmuwQz4tGoaowgBulU3oEkFLZikUWhZ5/kXOJHt
	 iLBDXbxQ5IHzKsCNVCbELixvr4bdliui3arn06ZYa9YXPWqbMajwJHG6CaXxrmr/h/
	 2zgY9RBCXmO5kflcvJarlO+ZiPENgh9qmeGa5jq6pfxAuho+tiGSKI8QDL5JQfPA7X
	 VCnc7L2GQek3d7jCzgtXzU6+mPU875oKNxj3DcwgJGfXR7aYkA3boLwWHR9tGdf8mW
	 K8MRT7VtYjDMeSthVIP+hwszPy6DjNV3us9viyAdjg3fJvt/MYK123MlQuTRSQof5x
	 vtkzaLEWEzZoQ==
Date: Sat, 20 Jan 2024 06:36:40 -0600
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
Cc: linux-arm-msm@vger.kernel.org, conor+dt@kernel.org, robh+dt@kernel.org, 
 andersson@kernel.org, linux-kernel@vger.kernel.org, agross@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, 
 kernel@quicinc.com, konrad.dybcio@linaro.org, 
 Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
Message-Id: <170575419855.2509064.6657399665407807261.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id


On Sat, 20 Jan 2024 16:50:48 +0530, Amrit Anand wrote:
> From: Elliot Berman <quic_eberman@quicinc.com>
> 
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.
> 
> Isn't that what the compatible property is for?
> -----------------------------------------------
> The compatible property can be used for board matching, but requires
> bootloaders and/or firmware to maintain a database of possible strings
> to match against or have complex compatible string matching. Compatible
> string matching becomes complicated when there are multiple versions of
> board: the device tree selector should recognize a DTB that cares to
> distinguish between v1/v2 and a DTB that doesn't make the distinction.
> An eeprom either needs to store the compatible strings that could match
> against the board or the bootloader needs to have vendor-specific
> decoding logic for the compatible string. Neither increasing eeprom
> storage nor adding vendor-specific decoding logic is desirable.
> 
> The solution proposed here is simpler to implement and doesn't require
> updating firmware or bootloader for every new board.
> 
> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
> -------------------------------------------------------------
> The selection process for devicetrees was Qualcomm-specific and not
> useful for other devices and bootloaders that were not developed by
> Qualcomm because a complex algorithm was used to implement. Board-ids
> provide a matching solution that can be implemented by bootloaders
> without introducing vendor-specific code. Qualcomm uses three
> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
> pmic-id.  This does not scale well for use casese which use identifiers,
> for example, to distinguish between a display panel. For a display
> panel, an approach could be to add a new property: display-id,
> but now	bootloaders need to be updated to also read this property. We
> want to	avoid requiring to update bootloaders with new hardware
> identifiers: a bootloader need only recognize the identifiers it can
> handle.
> 
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
> ---
>  .../devicetree/bindings/hwinfo/board-id.yaml       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwinfo/board-id.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/hwinfo/board-id.yaml:23:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/hwinfo/board-id.yaml:25:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


