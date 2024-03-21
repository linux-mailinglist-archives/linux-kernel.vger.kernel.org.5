Return-Path: <linux-kernel+bounces-110758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6C886346
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F70A1F23148
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8008136995;
	Thu, 21 Mar 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhRjKsFj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B513791A;
	Thu, 21 Mar 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059931; cv=none; b=oqqzY2nAD7FYUA+Pl3U/q9Rhw6QBM2Gqyx/6HtcxFz7t6jlFM84UhQ3xpT/ZZUs3Kb3M7YF092138/VfqraMDbu1i8h44r0f0y003FOwGONmrT7rNrcnIoy7Fe/XSSkwlg6Jy5MoWEnlFJY9u4tp4bydH0Jlsnsk9cPj31H90c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059931; c=relaxed/simple;
	bh=KV1cqdEWouuF9AZNPJszbFGwtds7bB206s9mEHm38IY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=k8YkGFUKBCC0BeIxwy9Du6cbpVAawpB0ADU4w5LYcDupoY0BkBQ9feOx6GuDXiyooC1iQOL066R329RaF4voZUSPQXnSP12w0S2M37HR7etZKMW47KHXb4fLV4fbolvVFLVpybMd0BMZblZDLREC/ZEr9bhej25z93gzOC01P6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhRjKsFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB606C433C7;
	Thu, 21 Mar 2024 22:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711059931;
	bh=KV1cqdEWouuF9AZNPJszbFGwtds7bB206s9mEHm38IY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lhRjKsFjoMXVNpayNroILS0ygmnonPsjJ3uvr2+RVILA/g48y/YGCQrtQiMiMMj6e
	 kF/UT1WFAZUL41Jt3DvwiDMM7Vc37F5y04cBhGYI7DUoLJH5aeFdFmDYcp+DgQzZXQ
	 +jbySrQHsxnpT+M5T3jGxKjtWh/ouwD6lb0B09ZbiPm+bsRxZUprOq/Fe+PaKEeq6G
	 usSTwEn0klpCUepXRR8YvBDEXGEtQXGKMinN3GEdgrzho7UevbflmAviDtQZCKxREe
	 FfPPrrXcoT3+WiNxJnbbmSh45+FQGTl/Cq6jDy4vBMFe76rnAGuIyioJwiy3xG5qGq
	 whLWO4I6Tw29A==
Date: Thu, 21 Mar 2024 17:25:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-kernel@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Robert Foss <rfoss@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh+dt@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 linux-media@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>, 
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20240321-dp-live-fmt-v3-8-d5090d796b7e@amd.com>
References: <20240321-dp-live-fmt-v3-0-d5090d796b7e@amd.com>
 <20240321-dp-live-fmt-v3-8-d5090d796b7e@amd.com>
Message-Id: <171105992875.3043233.18321806946234735413.robh@kernel.org>
Subject: Re: [PATCH v3 8/9] dt-bindings: xlnx: Add VTC and TPG bindings


On Thu, 21 Mar 2024 13:43:46 -0700, Anatoliy Klymenko wrote:
> DO NOT MERGE. REFERENCE ONLY.
> 
> Add binding for AMD/Xilinx Video Timing Controller and Test Pattern
> Generator.
> 
> Copy media-bus-formats.h into dt-bindings/media to suplement TPG DT node.
> 
> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
> ---
>  .../bindings/display/xlnx/xlnx,v-tpg.yaml          |  87 ++++++++++
>  .../devicetree/bindings/display/xlnx/xlnx,vtc.yaml |  65 ++++++++
>  include/dt-bindings/media/media-bus-format.h       | 177 +++++++++++++++++++++
>  3 files changed, 329 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml:35:4: [warning] wrong indentation: expected 4 but found 3 (indentation)
/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml:45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml:49:8: [warning] wrong indentation: expected 8 but found 7 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml: bus-format: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml: xlnx,bridge: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.yaml: xlnx,pixels-per-clock: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240321-dp-live-fmt-v3-8-d5090d796b7e@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


