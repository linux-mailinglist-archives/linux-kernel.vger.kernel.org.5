Return-Path: <linux-kernel+bounces-148999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016C8A8A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A701F21DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DB172BA9;
	Wed, 17 Apr 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRiKEA7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C117278D;
	Wed, 17 Apr 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375288; cv=none; b=XTLC/d9hS4Otsr3mEW/Zkpbzuf/qSphXhh7PSYvWFdi3Csg84r7VIkoe2484pyjWPdBXkg6YWS9qdTOTdhm3NfUMcVDhTd+ekdf4F8c/lrWNGqwIR8bdaIrKhHYV61hHZVy0Gs5cdTdP8WW1/RSXCbh0H/ZYZxwDBaQQWdfCS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375288; c=relaxed/simple;
	bh=0mamoAWMRqdNOuzh3qJgUZiw7KIeI9yNypr5Bt7zRJw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=O4vcYJWqf4a5bnGquheC3HcOrY4QfdONLUpefK01PBb7qa+qOL6z/KG1H6GWs10F6vZqRnIHsp066EeENF5f/XhlZXUgwUCR1UgCR+ipfhlQ/i3PqJJ8w91tfqOWB5yL9mrcps2qKTn8eP/2kcmUA4Z2Ii0J/p/+L1l64qwMxSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRiKEA7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323A5C072AA;
	Wed, 17 Apr 2024 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713375288;
	bh=0mamoAWMRqdNOuzh3qJgUZiw7KIeI9yNypr5Bt7zRJw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YRiKEA7FxGNzBKrpLe07tbJCxjnSb+L7rxhU7fequhEwf/+DHaD7nIzEfURunA6i2
	 Vt/scLW+dd9kC3iEhJn0TsfXX+b4gzGT+d1yQnJwjX56EJymhlxnZmD3o9ycS9Pjhk
	 fuE4IYK3AbPL9g7aNSQ3oCzIWWg9L7sBIe7GxZsmd3j5N9fQQE7MLA0vwjVfgv7MWb
	 J0K1Lo7uV+mOIIRMSjqj+b8Di77Hu/tUbkVcP5G9F/MhLVazKQFq6Se7uzDyLIlfdX
	 SIz3b/Rspm3QNFoo8uDT+6gNSEEgQlAnZrO+59kHFbQLEocmQx9iDhQn2YeezAZeqE
	 JNzDg5TU17KxA==
Date: Wed, 17 Apr 2024 12:34:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: David Wronek <david@mainlining.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, devicetree@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
In-Reply-To: <20240417-raydium-rm69380-driver-v4-1-e9c2337d0049@mainlining.org>
References: <20240417-raydium-rm69380-driver-v4-0-e9c2337d0049@mainlining.org>
 <20240417-raydium-rm69380-driver-v4-1-e9c2337d0049@mainlining.org>
Message-Id: <171337528609.2818677.10969972561314017105.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: Add Raydium
 RM69380


On Wed, 17 Apr 2024 18:29:33 +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
> Note:
> Depends on commit 48a516363e29 ("dt-bindings: display: panel: add common dual-link schema")
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.example.dtb: panel@0: False schema does not allow {'compatible': ['lenovo,j716f-edo-rm69380', 'raydium,rm69380'], 'reg': [[0]], 'avdd-supply': [[4294967295]], 'vddio-supply': [[4294967295]], 'reset-gpios': [[4294967295, 75, 1]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['panel@0']}
	from schema $id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.example.dtb: panel@0: Unevaluated properties are not allowed ('ports' was unexpected)
	from schema $id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240417-raydium-rm69380-driver-v4-1-e9c2337d0049@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


