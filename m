Return-Path: <linux-kernel+bounces-147470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295818A7499
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F131F2326D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABD2139587;
	Tue, 16 Apr 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/uVauMK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0B139566;
	Tue, 16 Apr 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295245; cv=none; b=MUYbA87XYXH3ichnxCKwGka2x88fxj8l6NUymOdbuc9fcuWHgKtwEG2M1rEskEmQd8RgCGg2ZT41SJeUqK3cm1Y1UVRH1z1/QhREimssC/W/vAy1HeCeTUQsRgqRDa4iG7omokpe6POrF1zyuDfy5FWFVVvEGyKN5rRPGMAYcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295245; c=relaxed/simple;
	bh=JPCYyaNQ5aLMEvbd/QgJU8hMpf/HQ03GExzcJL2Qv/A=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IYTrzTMgs+Xi0R75r8DsTUfkx2pCV2Ht8PYXmIoNP5uLMZH6Lih6F2L0TkyMenBK/NCkmQlZGujLlr9/KP4F9cPr2ZcaxSc3q6XmjiBIq+X3rAmTcZUE6TI+ShdO4cCjGtObtkucPiBOFVBKCAqpm5gZw2+UnJeloJDHwMOBMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/uVauMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B805C4AF07;
	Tue, 16 Apr 2024 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713295244;
	bh=JPCYyaNQ5aLMEvbd/QgJU8hMpf/HQ03GExzcJL2Qv/A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=X/uVauMKTrEJKeHSuimCQFH2qffGX5UJUXLGp1Lqc3Xd/2hDX3v0OBwGBl6m8PBmJ
	 DJt3NYegAPxEIlk1Rbuzi190amVwRoVXW2W2DEdgFMHpGFbxq9ZgTBTtaWA2aX7QSq
	 GU3xbx6+Ikyif5ExRKSpHxFKJ2wfDOGRkN4WtL/Gisu/3IY3+dDHj8gB+1v4gjoIUW
	 KEfNA9D7tcxIyd1DtV2IHHCf2VeG50atxHUUxmYDW1XFQneVMwhCtYBmJ1GabzGVss
	 XahY/K3DuAfbXRy7wT1+oBKfFxas8aEMBMAjK90vg7hvZqfssYTAN77R5i9m57VEfl
	 stiZpF3I8DUyw==
Date: Tue, 16 Apr 2024 14:20:43 -0500
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, phone-devel@vger.kernel.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org>
References: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
 <20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org>
Message-Id: <171329524217.3866491.17133323798824607275.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add Raydium
 RM69380


On Tue, 16 Apr 2024 20:30:48 +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
> Note:
> Depends on commit 48a516363e29 ("dt-bindings: display: panel: add common dual-link schema")
> ---
>  .../bindings/display/panel/raydium,rm69380.yaml    | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/display/panel/panel-common-dual.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/panel/raydium,rm69380.example.dtb: panel@0: False schema does not allow {'compatible': ['lenovo,j716f-edo-rm69380', 'raydium,rm69380'], 'reg': [[0]], 'avdd-supply': [[4294967295]], 'vddio-supply': [[4294967295]], 'reset-gpios': [[4294967295, 75, 1]], 'ports': {'#address-cells': [[1]], '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpoint': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpoint': [[4294967295]]}}}, '$nodename': ['panel@0']}
	from schema $id: http://devicetree.org/schemas/display/panel/raydium,rm69380.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240416-raydium-rm69380-driver-v3-1-21600ac4ce5f@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


