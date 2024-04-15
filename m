Return-Path: <linux-kernel+bounces-145660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9868A591E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AC328402D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF883CA0;
	Mon, 15 Apr 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGIwbl9h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235B79945;
	Mon, 15 Apr 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202131; cv=none; b=bnDozMz8xsq/v4/wGomE3IZTYwTdBQ1aGf/X/JiefZWEYQy90fzL5QFrFOexW/oOKiAiZ3gv5sgJUm0GchN2tzrK8wEpLWyxfBAqQNPKSRtPqztN3Wfj4W0lsb1gzpbLJhC6tKhw82u+NxUqvgbK17m4NXrbZLSeCPcXd1Ij/lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202131; c=relaxed/simple;
	bh=a0HibWUnzie92ICHAhBye5rj+VFjkkx03juTDWDh/Ec=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=iYq/g/joDNQ+BrAhXOBbWAYRs6dQ1h/dsLZ0IKKNyPWw9wlYAVDb6CxOkYfMgT3j8Wl3tievF1601gXF2B7tUjCU2s6OAV8KbxK0NcurOFcjAY21mp6rh2IgBtcXrLYhWbLXayDKqKn/lj1nBt1Wu1J8+YQAamKrC1MejofWL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGIwbl9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A77C113CC;
	Mon, 15 Apr 2024 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202130;
	bh=a0HibWUnzie92ICHAhBye5rj+VFjkkx03juTDWDh/Ec=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sGIwbl9hpyaYtBQKxvJwQVyMA8NHskJJz4jxoakHv+SX3/ieldj+E3nJMETdR35Gu
	 wKHloHIUuK06kFzSYekj1QctMLCGJ5DPuam0tWdsGXnGGva8OEUD6SZ6sewvvuOOca
	 otFy0M/cu4zhxUDUgy1d24JXH3zmurfFkD5kjcG8ZXucCwSrJbhwotvSKkbhGbs4z5
	 lh61ZKtVNkVKKePxpGjvxxVQbaw66TJkWYTqP4LJnTZjcUEct8gfdbevh/OhZsCOxN
	 GpBWbjiBpNku2djAmLRaotKGb3Knq3ntCsFTD3NeoNk42nwpVvcMB/mPNAhVP72D2B
	 iasWcXKynd/FQ==
Date: Mon, 15 Apr 2024 12:28:49 -0500
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
Cc: Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sam Ravnborg <sam@ravnborg.org>, phone-devel@vger.kernel.org, 
 Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong <neil.armstrong@linaro.org>, 
 David Airlie <airlied@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org>
References: <20240415-raydium-rm69380-driver-v2-0-524216461306@mainlining.org>
 <20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org>
Message-Id: <171320212822.3814448.5491461859724968091.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add Raydium
 RM69380


On Mon, 15 Apr 2024 18:10:41 +0200, David Wronek wrote:
> Raydium RM69380 is a display driver IC used to drive OLED DSI panels.
> Add a dt-binding for it.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240415-raydium-rm69380-driver-v2-1-524216461306@mainlining.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


