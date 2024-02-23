Return-Path: <linux-kernel+bounces-79292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF0862027
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D461C2188D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861A914D43B;
	Fri, 23 Feb 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+rE1DEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBB2208E;
	Fri, 23 Feb 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729179; cv=none; b=aL8s4PIHeCLmALWs9b9nx3K5sQ9xM+PaJbtrdH6oNGCFdPjaJX65i/ZbYHrolodnwVaXLqpLmw/R7zH999FsdLsu5TvxPByCEf+G10HHloCUMPXDNswmIMEDLKnPd/fi6V426oNCUeSOsHEmjApB/NKb5Z9+/enE8PMSL/JVytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729179; c=relaxed/simple;
	bh=ABNxFgpazlkmbRu59cIx6k/+C9n5WoumwUscE+x+nWA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=I/KFaoolF6TZXFzvqedssSL7KA4YVlP3pkv5NRjmWob9OSkO3xrDpUZvINPmY8mhJuRgBNM1DG8s4cr4/f2WPFJDv3/EnDmvpxZaDbpNBBCKZ1wVg2aYxvX8pySvu6NeJ7mzFSb2FSsiEQl6NYM+1Xpa9l7oACyI7gaW6KIte2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+rE1DEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F69C433F1;
	Fri, 23 Feb 2024 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708729179;
	bh=ABNxFgpazlkmbRu59cIx6k/+C9n5WoumwUscE+x+nWA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=X+rE1DELraXQncx8Rs4qZ7vS29+oLUV4cCZpA3Jiah+JveniKtnjYIodYB5nGI9FM
	 b4xaMM5Vqtc7R54h5C325uj1U/5gwY6QuPv1yJRa6xDootqjmKVQjZ4g0krHiGGkeX
	 VYyS/3aklZ0lWeemzioOIDlKy7fCn+vqHWb72QUjP+/Io0F7OIUDPT2yloY3tE0Cd4
	 XIurpmx2Sn7ZA1JGB0jG/I2RnJUF+Ggu5crVNpjR3GM/onVbsV+45Pt0Uy/jpoW8SV
	 Uv9OZ+pTStyxrjXRiiixeZGndgdq7UgELAhDGBe7NwFhRrpYnIQqPY50sTakEkBBHT
	 hFYjZ8aLawaCQ==
Date: Fri, 23 Feb 2024 15:59:38 -0700
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: martijn@brixit.nl, phone-devel@vger.kernel.org, megi@xff.cz, 
 devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com, 
 krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org, 
 kernel list <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, 
 fiona.klute@gmx.de, robh+dt@kernel.org, samuel@sholland.org
In-Reply-To: <ZdkOCqPKqa/u9Ftb@duo.ucw.cz>
References: <ZcaCXYOf6o4VNneu@duo.ucw.cz> <ZdkOCqPKqa/u9Ftb@duo.ucw.cz>
Message-Id: <170872917769.3727020.1891053113007354566.robh@kernel.org>
Subject: Re: [PATCHv2 1/2] dt-bindings: usb: typec: anx7688: start a
 binding document


On Fri, 23 Feb 2024 22:28:42 +0100, Pavel Machek wrote:
> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> but I did best I could.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> 
> v2: implement review feedback
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/analogix,anx7688.example.dtb: typec@2c: 'hdmi_vt-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/analogix,anx7688.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZdkOCqPKqa/u9Ftb@duo.ucw.cz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


