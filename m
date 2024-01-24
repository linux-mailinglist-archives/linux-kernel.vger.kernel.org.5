Return-Path: <linux-kernel+bounces-37214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE7883ACA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBF01F241BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277D7A721;
	Wed, 24 Jan 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOWospek"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049277656;
	Wed, 24 Jan 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108405; cv=none; b=Xk49b7nbQo7IY21+3af2vpxaxAj7VDRGTosgjefv0C23Xd2OWKXVzv3Yvy9IvD4FqFrWe2PVCxhslCVaM5SmRx+2lIcrigyJVIrql42q206/IvrM2JCrQneQ/uQBFDkjHI2M56gf7fyJ2JT3TDKtKoZ7anm2Q73UClmXmG6i40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108405; c=relaxed/simple;
	bh=j7Z+thFdgKlzSUoT0A5oBFaBMSTllWxRg8wQ7PRW+KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDS5rssGyMJ2W/EpfB2ICL3YqV4Qv0/mLDbtqMQUxs5px49JSaOws8G0cxMlN1kTSmWeZhIdF6CUbxLrnKQNTsAPD3kzdS4i41rOdEVwZlJsIiMzk/jxu4HPlk5LfSeuQY/YUgWFrRU2RaBA+4EH+AqNspOrJexX5MI4iBRKjR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOWospek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6833C43390;
	Wed, 24 Jan 2024 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706108405;
	bh=j7Z+thFdgKlzSUoT0A5oBFaBMSTllWxRg8wQ7PRW+KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOWospekqSSumxyb1P3s64yCAwOwrh32ACqwg34CyiHXL1AEojGnxZPEL1y52mvwT
	 npom/UlygVuHu9teT8NJs/0asAz550dH3fCDbWAACFTVMrYVQtG4dhyoXijVVPNPpV
	 jvfRlWjOsjsqJrASoO2GH8aB0NTluLL1tVAtx7q7wbxLCm5NM6NUebR1X03Y1P825d
	 0pSyHsDN6NAInf7/hENqQaUr88xQk+uuEfPUnAV+IvJbB8/v37XeDFlWimze56ntAQ
	 fhJmyqyj6pSg4eRMC5z7fZWkYfJTCH1R2mjleuTFILOHxO+Y+p1cY5+I4QI1jlkHEy
	 5wX6byjpYxRog==
Date: Wed, 24 Jan 2024 09:00:02 -0600
From: Rob Herring <robh@kernel.org>
To: Amrit Anand <quic_amrianan@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com,
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Message-ID: <20240124150002.GB873781-robh@kernel.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>

On Sat, Jan 20, 2024 at 04:50:48PM +0530, Amrit Anand wrote:
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
> diff --git a/Documentation/devicetree/bindings/hwinfo/board-id.yaml b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
> new file mode 100644
> index 0000000..82d5ff7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwinfo/board-id.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Board Identifier for Devicetree Selection
> +
> +maintainers:
> +  - Amrit Anand <quic_amrianan@quicinc.com>
> +  - Elliot Berman <quic_eberman@quicinc.com>
> +
> +description: |
> +  Device manufacturers frequently ship multiple boards under a single
> +  software package. These software packages will ship multiple devicetree
> +  blobs and require some mechanism to pick the correct DTB for the board
> +  the software package was deployed. board-id provides a mechanism for
> +  bootloaders to select the appropriate DTB which is vendor/OEM-agnostic.
> +
> +select:
> +  anyOf:
> +    - required:
> +        - 'board-id'
> +    - required:
> +        - 'board-id-types'
> +    - required:
> +        - '#board-id-cells'
> +
> +properties:
> +  $nodename:
> +    const: "/"
> +  board-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: |
> +      A list of identifiers that can be used to match with this devicetree.
> +      The interpretatation of each cell can be matched with the
> +      board-id-type at the same index.
> +
> +  board-id-types:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      Defines the type of each cell, indicating to the DeviceTree selection
> +      mechanism how to parse the board-id.
> +
> +  '#board-id-cells':
> +    minimum: 1

This is not how #foo-cells works. It is for provider/consumer style 
bindings.

Rob

