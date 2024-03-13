Return-Path: <linux-kernel+bounces-101051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F70887A1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917671C21C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C46CA4A;
	Wed, 13 Mar 2024 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgBJX0cS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D638B;
	Wed, 13 Mar 2024 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710297045; cv=none; b=hx2ciwWFrKajSTTQusdFObiwfMlp0aTxtmuYBCghFzDFHyejYjYlGdVHyIqOpScTRJ29d0vWgUQXlaKwiMcBs5iVBqZqUx96EdD3yVvJ1SOUAlhJloBwdmEYqjzDo8DEir5v8BSguumyzVzRXvKCy8fSBQgygeqehaP7AfA0Pjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710297045; c=relaxed/simple;
	bh=6epCFR+TeeVisNrBltVtOxZRUBOkKoRbe0+eZ0ebHGM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QlnkRJqVGSU5j/fTxJBjxBdwaG6fuTWSW6zgXxAdmGRFzT8dzIfnI/FDi/DbvBkNhGjCyV5X72GJ1xi57O9C1++vGx8XGZINeZ4NhSlPSY55X4m3mRNAWbndyREQAxu17/qbrdOtN/XYOsEqpmq2k9VcX7nEX2BT1FknC8nzzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgBJX0cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608ABC433C7;
	Wed, 13 Mar 2024 02:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710297044;
	bh=6epCFR+TeeVisNrBltVtOxZRUBOkKoRbe0+eZ0ebHGM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bgBJX0cS4c75xtuhF2avvRAWfGeIS+DdV9OofdYqXwKLsvGUd5FxhhtQqF0mLN4dN
	 /0zkpqzGk89wpr1NMFTIK1F09qLuKqVRWGN1AEMMo8y869BZWQpgbq02ZoWvzirGgH
	 THVKVcTueHcJgN4l7N6LFujds6IA3UTv4MpUn8piGXRjtyy/043Xpku/hccu4QijI3
	 6XlS/SxMGolxlTZT7Z5sQGHZUGSCI/ZDbMrnfFiY59kOGX3Gy8aMXXZf4F9nAaQGmY
	 vLPYqL/t1jcl39selk774Xbsnx6JUYWkn2Ok/z3U449vArJT3GIT4RYGhZFpsCNg3F
	 uaCPkK9BvACLg==
Date: Tue, 12 Mar 2024 20:30:43 -0600
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
 Michal Simek <michal.simek@amd.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Daniel Vetter <daniel@ffwll.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-arm-kernel@lists.infradead.org, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
In-Reply-To: <20240312-dp-live-fmt-v2-7-a9c35dc5c50d@amd.com>
References: <20240312-dp-live-fmt-v2-0-a9c35dc5c50d@amd.com>
 <20240312-dp-live-fmt-v2-7-a9c35dc5c50d@amd.com>
Message-Id: <171029704194.3354722.2132570272705371334.robh@kernel.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: xlnx: Add VTC and TPG bindings


On Tue, 12 Mar 2024 17:55:04 -0700, Anatoliy Klymenko wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.yaml: xlnx,pixels-per-clock: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml: bus-format: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/xlnx/xlnx,v-tpg.yaml: xlnx,bridge: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240312-dp-live-fmt-v2-7-a9c35dc5c50d@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


