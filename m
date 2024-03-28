Return-Path: <linux-kernel+bounces-122239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8252188F3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14D11C2DB55
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51118B1A;
	Thu, 28 Mar 2024 00:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0b3NUmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692CEEB3;
	Thu, 28 Mar 2024 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586650; cv=none; b=rL9m9vaW33ZEhNJRHg4ZIxD+mx6K/Q+iFOxZ6JrtnJ4KFS6zKk8CYwzqCZJgJTXNvpL7AI6mk8urHXrcBPCjlYiv7nXTWxk0O4SwG8rjJn/SUJkQDa5s2xGGMgitpFQ5D4gPev4UI65Cfe/eBnPCYxQ/5f1ileQarbskxyDjg1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586650; c=relaxed/simple;
	bh=9yBedKDcPA/JWXoQD3zRnrUUup+kGC60mJSL3m/qRBk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=maywRB2hHy8yKa1HI+iVYH15CJ6KKoFWL3nK1ii8dfSP6utGvZtmeShLUODjkvWtaTjZAh5XLDjulTqLHLwHCWUjv8oLbuE6p8Ny8MOlrUNW7k/T84xflTC6JiSUpa6W+E8sZ/EcVI1OVPSsDV6IJUR2bTEAnyLhLviy1ITPnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0b3NUmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CFC433C7;
	Thu, 28 Mar 2024 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586649;
	bh=9yBedKDcPA/JWXoQD3zRnrUUup+kGC60mJSL3m/qRBk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k0b3NUmwq+BnFLFWIWucjZhg1KprqU86RePM+BsI/9FyN+FBiUsZuK6HehUrkbIhv
	 XohkKQOGoXrHYLuepDj1R0vTMDtLU677RDtPsknUc7SxRraqNgE1EXR167ZH6RwBEv
	 A84LVABMYGlRr+CNhffxt+QOswxv+vM/9tPMiUMD5Q4pXbzIScv+HaWNABkHKUeNuz
	 BDUZOo0Qx+8KnEwdhwAMu3hMOR+rUWig3hQPa23fOh/OA1qVYFFd4wexX1Vb2kJAnM
	 VxMFsxOXWMiypFy/VCSVVMI3afEsrhHzDChA0TagPRMlBsu0AKORQqBnZWl5lrD6bd
	 reGtYhI+NZnIQ==
Date: Wed, 27 Mar 2024 19:44:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org, 
 Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org, 
 Lee Jones <lee@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Pavel Machek <pavel@ucw.cz>, linux-hardening@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>
In-Reply-To: <20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu>
References: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
 <20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu>
Message-Id: <171158664689.823785.11147473547097630411.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add Silergy SY7802 flash LED


On Wed, 27 Mar 2024 23:51:33 +0100, André Apitzsch wrote:
> Document Silergy SY7802 flash LED driver devicetree bindings.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../devicetree/bindings/leds/silergy,sy7802.yaml   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dts:23.13-26: Warning (reg_format): /example-0/flash-led-controller@53:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/leds/silergy,sy7802.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


