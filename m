Return-Path: <linux-kernel+bounces-61828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E75851721
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA0DB2366C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7B3C067;
	Mon, 12 Feb 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSWM1AHS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2EA3B79E;
	Mon, 12 Feb 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748551; cv=none; b=AEUBS0MfuXmBEsTfuv4PIk2ULZq5IuaGpgDtvcEt/90SBmsVhVdG/YeFFjRT58Bu6rive21YF+uBzH2VGbx0IcfU5ZBpOMQ3r9YdVnTSN6Dho121YUEKfNsKHV8VvGoT5KuBuwBpnyTm71z7zLxpV1T4+YTBmbIoAxB+9+hM2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748551; c=relaxed/simple;
	bh=QYf+5/QTHe/pR5frJUhbCNA1+D/FWdDxUAFsDka0kaI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=XY3l2ocfexmQtk6tdv/pSxC68cQu0hVTMu47xpJ2LuzyjrL5xOvFRQK8EYKPrS+SZZ6pIhq1ESVaMcjo96tArsCBhDI3T/Rm09i2KVZusKok7Ce1tOlXZ+LecMOSsRij1pypnBzXiBgeF6ef9WXQuSmiOCqmfGwoKvdMCr5GCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSWM1AHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40729C43394;
	Mon, 12 Feb 2024 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707748550;
	bh=QYf+5/QTHe/pR5frJUhbCNA1+D/FWdDxUAFsDka0kaI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QSWM1AHSP/9zAdL55MyTxzban42kr7Xhzbkh2+x1k9Ln+dAhovPnd9YJMx17NZ9fh
	 8Yye1aQu9uG458Z4cet443NCQl6Jb0GHVfXEJEyyzYi3vEcFs9aPESpURnOuU9jmGn
	 H9fokutBg2itYfACFL2vXLRBBR6v3g1w3pg2+OCU3zSF/IUThK1WzdaZBVHPxsG39V
	 UW8lu7GPmHWVPalnxxY6Rpi64YT2yGShdBdMDxnHuQhTAyIEv+WCsUACULJlkIGpux
	 SP9AguvNNQwLuPszJF+mlgjRPBOLJQdd+d/xyVK6ZUn2002RGhqjk2+ie3dYpa2key
	 I/Epe7TIhZICw==
Date: Mon, 12 Feb 2024 08:35:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: =?utf-8?q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 conor+dt@kernel.org, airlied@gmail.com, mripard@kernel.org, 
 dinguyen@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 robh+dt@kernel.org, hverkuil-cisco@xs4all.nl, devicetree@vger.kernel.org, 
 ribalda@chromium.org, daniel@ffwll.ch, chromeos-krk-upstreaming@google.com, 
 mchehab@kernel.org, akpm@linux-foundation.org, 
 dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20240212131323.2162161-9-panikiel@google.com>
References: <20240212131323.2162161-1-panikiel@google.com>
 <20240212131323.2162161-9-panikiel@google.com>
Message-Id: <170774854550.294485.3708612918527188826.robh@kernel.org>
Subject: Re: [PATCH 8/9] media: dt-bindings: Add Intel Displayport RX IP


On Mon, 12 Feb 2024 13:13:22 +0000, Paweł Anikiel wrote:
> The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> capture and Multi-Stream Transport. The user guide can be found here:
> 
> https://www.intel.com/programmable/technical-pdfs/683273.pdf
> 
> Signed-off-by: Paweł Anikiel <panikiel@google.com>
> ---
>  .../devicetree/bindings/media/intel,dprx.yaml | 125 ++++++++++++++++++
>  1 file changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/media/intel,dprx.example.dts:28.27-28 syntax error
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/media/intel,dprx.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240212131323.2162161-9-panikiel@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


