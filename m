Return-Path: <linux-kernel+bounces-110664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A13886207
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE01A1F213A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8969136662;
	Thu, 21 Mar 2024 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlEKUQWY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D3135418;
	Thu, 21 Mar 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711053914; cv=none; b=HLGU6IkiU99nfHYFrLIHg91c2F4lgvRxi5d9+FxybJ/hu/CpkoC/Kx80RUzdIwT9vRY/TBlPybC6wZNz+KA2hrvpsYwyIIrUfE9JHg+2ofq5z9JLbx7OVeg5uyeWQlnrciY/K2UkP8t0KLuo+S5K1L2wr65a71zUyDSbMLjWlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711053914; c=relaxed/simple;
	bh=j69LrWLPK7+FI47ieW2R0Co2V7muGW+LM0PXHRHgHzo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=LzP2beU83A2xzp/xBytfCX+raYGjrb+L9bq/yigBwGNdAbd9hcNwM/I1mHev6PsnT3TPgPztaZbd9fVU3m6QNnaQ+IJQBXaN2IT7M1oB9Up5ZBQ+LIB3TuUS9UCGaE6OC2T0C05cDK13MU2i6MLWeT0shDjl+Y0myKyYy/ELm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlEKUQWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA75C433A6;
	Thu, 21 Mar 2024 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711053913;
	bh=j69LrWLPK7+FI47ieW2R0Co2V7muGW+LM0PXHRHgHzo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DlEKUQWYrhpLLJCa9DQNqOMm3U42KVXe/T+CwQgNvooVH3Omm4vGbBsh/F2bCJtR9
	 yyrke1GoluXMVedAY+7lyvNj+NxGZEEz0WYxbx4qYjvigxF4n38KTxsUQ3UOimOYkZ
	 Ee/KUDyfGq9QR6eHaYVZkpTlTyJ0SBFfW5r036BihcjJ1dkiRWTJ3uMdy80ud/4Irh
	 4GJFnoWBPNeJvQ28t7DAA62pbeWGPoVdFQAEwKnztbN8n5H4qlJ5ywa0zXNlIZae+l
	 Eq0ptYyy98MfIVOTT+jklZpMx3AqArkDtbxfUj/F4G+ou/kJySxWPZgTE69GpIlEk6
	 xSI848qvqjwzA==
Date: Thu, 21 Mar 2024 15:45:12 -0500
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
Cc: Guenter Roeck <linux@roeck-us.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 linux-hwmon@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
 Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
 devicetree@vger.kernel.org, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com>
Message-Id: <171105391076.2619280.17497439995032037227.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: hwmon: ibmpowernv: convert to
 dtschema


On Thu, 21 Mar 2024 19:43:43 +0100, Javier Carrasco wrote:
> Convert existing binding to support validation.
> 
> This is a straightforward conversion with now new properties.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 ++++++++++++++++++++++
>  .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 --------------
>  2 files changed, 37 insertions(+), 23 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/ibm,powernv.example.dtb: /example-0/sensor: failed to match any schema with compatible: ['st,stts751']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240321-hwmon_dtschema-v1-2-96c3810c3930@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


