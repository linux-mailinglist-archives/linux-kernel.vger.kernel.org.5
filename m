Return-Path: <linux-kernel+bounces-84118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ACF86A24E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34691F248BD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5A153509;
	Tue, 27 Feb 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS8VmaMB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EBA14F961;
	Tue, 27 Feb 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072363; cv=none; b=SsWeVMYvPfPecbkyey+gyeKsla2Jcm696BuotiN/MLx+OOWXefXwc0DsboNJsqHG3ymfgq+XAXK+8LYovWNj9d34h4/NMCwVulqe9EaPExMaKhC0ShGckDgv5WarG7hKxa7vR3Nw8zz591PYn5Ve1W8mHeYgPsEHxFYD2EuKRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072363; c=relaxed/simple;
	bh=o9svJsP9nzZVOUnXBU3iRQDLYitUEw+4EwfW5E0njzo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=P1B6P+39UhsTCV9suG5fm38HmlkOo5fE8/XNb6mZGCXOX6j3/wZl0VzsnRycYQ+hC6cdTYlWrHIfrMGWC+JupLe2chgN+hlzCwYhWc1m0aUFuE0aj4oAqbXIB42K2ARppzIJUcqW4plVVP+ERs/w7yWluCNYww9MWlQa+ZmD6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS8VmaMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C97C433C7;
	Tue, 27 Feb 2024 22:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072362;
	bh=o9svJsP9nzZVOUnXBU3iRQDLYitUEw+4EwfW5E0njzo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KS8VmaMBkpXv9qmsgAQsQ5t6hh1qpU7R7Hl6HsLUvFVI5Qi8zQvw+shX26X6EzRhY
	 5M8oeuGQBQ31mzlfrPnQY9yCmXylxGyA6cg4ofniswej5i2KkwVF21bfLLlkWJNw1y
	 IeibV7Y5A3vcDOAa0JuXoLPCLVg99HB9dWUrFQbmfOxHRBVTqlfvegK60GDSlEyn4n
	 2Uu2cf1K1QFSImx88D2lNPVw7W8LXeJRLUunB7TqWPHszC6kYZxemtj+a63egyuBGn
	 af2kzpJhzS9wYKCswKu1r9kHFx++IQkGlU5EA1dXRc7U1OfacFHXfOe3gSXdkCCmFf
	 bDwH4CLyOKCfQ==
Date: Tue, 27 Feb 2024 16:19:21 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, lee@kernel.org, 
 robh+dt@kernel.org, gregory.clement@bootlin.com, conor+dt@kernel.org, 
 ojeda@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org, 
 javierm@redhat.com, krzysztof.kozlowski+dt@linaro.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 geert@linux-m68k.org, andrew@lunn.ch, andy@kernel.org, 
 sebastian.hesselbarth@gmail.com, robin@protonic.nl
In-Reply-To: <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
Message-Id: <170907236007.645402.4701945428447873129.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for
 generic 7 segment LED


On Wed, 28 Feb 2024 10:22:42 +1300, Chris Packham wrote:
> Add bindings for a generic 7 segment LED display using GPIOs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v2:
>     - Use compatible = "generic-gpio-7seg" to keep checkpatch.pl happy
> 
>  .../auxdisplay/generic-gpio-7seg.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/auxdisplay/generic,gpio-7seg.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/auxdisplay/generic-gpio-7seg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240227212244.262710-3-chris.packham@alliedtelesis.co.nz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


