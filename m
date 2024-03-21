Return-Path: <linux-kernel+bounces-110665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1606D88620A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38CA28178E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B07013698D;
	Thu, 21 Mar 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6gjbxZ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374E136671;
	Thu, 21 Mar 2024 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053916; cv=none; b=sJ+w9LPEkV9ClQFGZ2LfEfdwbJe0T5CA/Q7DeGiWmLM5WOKSawjDzJnmcZdabsrrcdh5ZFxliWcHLi65F8fwmExatG+bWnMLAK8s9oMW6n32Lkxzbjb4TKCj9rrHeo7fOvldz29FfhiNv+DdzUvG/gBGBr9+XGVNfMtN5IMMFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053916; c=relaxed/simple;
	bh=3eBlFz/sSUhvmfV25P1DwPyaqJaTiVHOe13+ZmRKUjA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=diZ7lPCfTamQ0Bz/iI9kWUFXgKNHlH/5d5DxzCD3VuBW45NrLeQfelMoniME1X9Zutsa+zQzFAETY5Wl1g4dAU/6WKZzi8gXFQ7ZnufqDBgqyUrlwrQT4j7uB9rG2bPmL7V7yeIeEfxET+/lCsqR7RSAW8Lql01Pbk5zV3UsFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6gjbxZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C59C43601;
	Thu, 21 Mar 2024 20:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711053916;
	bh=3eBlFz/sSUhvmfV25P1DwPyaqJaTiVHOe13+ZmRKUjA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=M6gjbxZ9gYE+LSqJvo023XRtkB7GKSCpXa8rTXyD1BiAV4PT7pstU5c0tEAHbdQTg
	 1IpZYbTOqsvw4kG9VG9f0PP1cEutR/OhvvELS0gveBJRvlqVfvo/8FHESCLEwSfrRp
	 P+XLJbKmWoIAgBgZSqyGXqfQ/yPrn4E3cXFz/xq76UuooA7DfAYhfr22fGSOSJcc3w
	 BSB1MwOi+aOYZK6PyKK9ilmddjYtVEAufXxz20OevNHy1OmijNBs4+RvveaYLIsmQX
	 M9ILy5xHkUkT9z0DaVOBTZy80SfaatKEdcC6xZjIvSkSMKc9PyIieVQMAu3M4668Gz
	 NuppTwNHuPnNQ==
Date: Thu, 21 Mar 2024 15:45:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, devicetree@vger.kernel.org, 
 Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20240321-hwmon_dtschema-v1-4-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-4-96c3810c3930@gmail.com>
Message-Id: <171105391136.2619321.2269174648422625974.robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: hwmon: stts751: convert to dtschema


On Thu, 21 Mar 2024 19:43:45 +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> This is a straightforward conversion with no new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
>  .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
>  2 files changed, 41 insertions(+), 15 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ibm,powernv.example.dtb: sensor: 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/hwmon/st,stts751.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/ibm,powernv.example.dtb: sensor: 'sensor-id' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/hwmon/st,stts751.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240321-hwmon_dtschema-v1-4-96c3810c3930@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


