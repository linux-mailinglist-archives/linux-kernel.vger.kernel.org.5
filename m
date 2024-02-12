Return-Path: <linux-kernel+bounces-61907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A3B851834
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CC01C2085A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D83C68A;
	Mon, 12 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/dWWajb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7412B12E52;
	Mon, 12 Feb 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752162; cv=none; b=briSRRigTR+upQ0gxfs4kDRd84wjGCi12aNOmu45VuUOopV1dt5dHNMdqVIgbVqxje0bQWhXJZYloaeKsVBRWvw5hl0UEDwVTBBJKg5CvRdG4dUWHBDB4W4qI4nISPViP4po2Q1A07/PcgsJd/YRI/V+ekntbbW9ebkJeX7KC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752162; c=relaxed/simple;
	bh=OsnsW5WMX5bnFUSUa6rJ6/poLxq4vFG7wdQg2ic2Pu0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=W2XeTpBtiLI29EYUs674STltuOOjCkJUx49+KrcGC7SbEPzeehDfuyvkW+V31Vtkqj9jFPxvIRy55yMmxVYkL/KES9l1urb9VGTmW3okmeI6axgcC9CiHi0e07I16MtxSS6SbXmUSyEr3kBFHJPnLNQc01aYlLTSe9NphIA7n58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/dWWajb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C17C433F1;
	Mon, 12 Feb 2024 15:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752162;
	bh=OsnsW5WMX5bnFUSUa6rJ6/poLxq4vFG7wdQg2ic2Pu0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=N/dWWajbDJ9QTuLpoEYTptaUAKUENXuJaUe3gpaNVcA6bsOGfLV/U22ZYa0f88SWj
	 dYd2HHaE26EA2GfcfvV/0CSTnPsLrketIfchZ79AhNqvnGbTtkUR2fzcwalVW4J3AV
	 /3FD0vn9/ArjW0o2rwzLgUMgViFTTSPPgj2j3YI69uVX/yXppOE81gI87WFUXz0TKH
	 k90XarTGrdTq8VhQXB8dbyF3VpIo/yRrGbqUl4L7O7ryEONyLdUQmFbrqocjsyagsF
	 Db3KRK/E8C782V5a/ByQD7efy4w3Y0YTfcSoLeOewM+VYURaZQ2VYSjonVWR0RixSF
	 V6UGS5M7CX0wA==
Date: Mon, 12 Feb 2024 09:36:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: arnd@arndb.de, krzysztof.kozlowski@linaro.org, andre.draszik@linaro.org, 
 willmcvicker@google.com, andi.shyti@kernel.org, alim.akhtar@samsung.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org, 
 semen.protsenko@linaro.org, devicetree@vger.kernel.org, 
 peter.griffin@linaro.org, broonie@kernel.org
In-Reply-To: <20240212140331.915498-2-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
 <20240212140331.915498-2-tudor.ambarus@linaro.org>
Message-Id: <170775215967.605422.1424850912641172864.robh@kernel.org>
Subject: Re: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth
 properties


On Mon, 12 Feb 2024 14:03:20 +0000, Tudor Ambarus wrote:
> There are SPI IPs that can be configured by the integrator with a
> specific FIFO depth depending on the system's capabilities. For example,
> the samsung USI SPI IP can be configured by the integrator with a TX/RX
> FIFO from 8 byte to 256 bytes.
> 
> Introduce the ``fifo-depth`` property for such instances of IPs where the
> same FIFO depth is used for both RX and TX. Introduce ``rx-fifo-depth``
> and ``tx-fifo-depth`` properties for cases where the RX FIFO depth is
> different from the TX FIFO depth.
> 
> Make the dedicated RX/TX properties dependent on each other and mutual
> exclusive with the other.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/spi/spi-controller.yaml:152:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
/Documentation/devicetree/bindings/spi/spi-controller.yaml:156:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240212140331.915498-2-tudor.ambarus@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


