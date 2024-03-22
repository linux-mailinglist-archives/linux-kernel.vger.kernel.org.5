Return-Path: <linux-kernel+bounces-111207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94688692C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16B8B243EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7D200A9;
	Fri, 22 Mar 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3/mnXy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F755208D6;
	Fri, 22 Mar 2024 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099619; cv=none; b=aF7uEZews+CnU8khpZI0RRDSWPKr4MLlgnsne8lGIDpNK3s+99mg9bbngAohR+osaWSZVJsJxaQuH/Fq5wLPJxm7EV/6XwRzBBTuHYOHnSMD5XBuR2IJ4zGS8SSY66t2ls3nsDvPrAK8Mqa0buMO9c3dcohYTjisowGovrzAbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099619; c=relaxed/simple;
	bh=Cm+91d8Ptgu0+GJYYynZrF7rW9pWZCvIsLct+865r5Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Sx4w20LAsCQGfKz3fiDzdJsxHPjEt2UNafxPqeUQBYNPcHV+l2LGa+lzHS1EbzFjWGzTPwkq+VGWeRmfaO20FUcW5Mcj6ZdTHSQbvONvlP4UP97bJGkOq5dDoqRlAvGyNlgxp1gc5BHXJoXUkn1eJNjB4Q/0V+4INF62uCIxoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3/mnXy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2CAC433F1;
	Fri, 22 Mar 2024 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711099618;
	bh=Cm+91d8Ptgu0+GJYYynZrF7rW9pWZCvIsLct+865r5Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=R3/mnXy7nVsWaYfz5SB558XK4JcwbyRuE7QS9LUh1jq2UeMD3xyDUJwSfOujrhOK0
	 DmXVRvyW0xFvMCSdNOmZAJCMPSS7ttw4aN6njF1zhSJrhsfNjExIlepvAdRNpkCLIh
	 R5psas0Y0jbbmwXrDidOz61umSluAW15F80wfiRnw0/iqGRdp7k0xLS7pc7K4CMyge
	 ypoo4WSWcQri9VUca57kZllvfUwUDCfFzjEDEtUNAwMFcJ8awRND3RX74vET+WNzWd
	 pfdjVwG0KkSghwaBu2VRXpJfJ+qtBVZIAnc4Omnz7Iqnts3i9Pwu9gnLT4eILQyK3G
	 pPPVy+4JZ2PcA==
Date: Fri, 22 Mar 2024 04:26:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: baneric926@gmail.com
Cc: linux-hwmon@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 robh+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, linux@roeck-us.net, 
 jdelvare@suse.com, kwliu@nuvoton.com, kcfeng0@nuvoton.com, 
 Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bonnie_Lo@wiwynn.com, linux-doc@vger.kernel.org, 
 DELPHINE_CHIU@wiwynn.com, openbmc@lists.ozlabs.org
In-Reply-To: <20240322081158.4106326-2-kcfeng0@nuvoton.com>
References: <20240322081158.4106326-1-kcfeng0@nuvoton.com>
 <20240322081158.4106326-2-kcfeng0@nuvoton.com>
Message-Id: <171109961635.307786.7810067768607811171.robh@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add NCT7363Y documentation


On Fri, 22 Mar 2024 16:11:57 +0800, baneric926@gmail.com wrote:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> Add bindings for the Nuvoton NCT7363Y Fan Controller
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>  .../bindings/hwmon/nuvoton,nct7363.yaml       | 66 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/hwmon/fan-common.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: False schema does not allow {'pwms': [[1, 0, 50000]], 'tach-ch': ['']}
	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-0: Unevaluated properties are not allowed ('pwms', 'tach-ch' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: False schema does not allow {'pwms': [[1, 1, 50000]], 'tach-ch': b'\x01'}
	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: hwmon@22: fan-1: Unevaluated properties are not allowed ('pwms', 'tach-ch' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.example.dtb: fan-1: tach-ch: b'\x01' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240322081158.4106326-2-kcfeng0@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


