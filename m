Return-Path: <linux-kernel+bounces-90499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA2870025
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C545B1F236C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144238FA9;
	Mon,  4 Mar 2024 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9d4goJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF87D38DEA;
	Mon,  4 Mar 2024 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551047; cv=none; b=IaQxb2CbNvrZQPj+iwqTH8Ww5sNRPz7sE/p9q/CfurhOdhXq8FASdOl/zNLieRgupM+SnfYcxtRrZRico411AQ1oCQVqpJG0/2n93u5xO0JnIFOoe7jAAUwUr1whOd3VK1k8PQW932dHgLQzSoF4aBnWttkC75ACL8SnSlAl5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551047; c=relaxed/simple;
	bh=7AE0bUAE0m/NrS5BRQlOmThRBlhp43jimuMtgWpxI3Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=qpwCY1vGTDB/SdaKVnrZKZYFFROVbOfWJUMfmIpJh/4wO5znDtxyoAVi7CLqwMB1flwhesJw+qaAYGYkjnvL1u80qpt296VtOG0+j7ntaL5VYadsi3xgGMwWxPlxD+kY7gL6SStqgjPx9AH57QPNbw6r8UHSuiIApsuBFjITqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9d4goJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36622C433C7;
	Mon,  4 Mar 2024 11:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709551045;
	bh=7AE0bUAE0m/NrS5BRQlOmThRBlhp43jimuMtgWpxI3Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=S9d4goJ0cwnQvBNhohbO4VXJsJMh3qlTmT3EFoNh20Rf9iLoGw9WIaFewKr57mR7M
	 +3Xajmhs/lxG1lw/7gW7sNMDoxIcBlj9EDk0g86Rzswp7Enza6Ydb0is9SY+IAhutP
	 RCDF+NlPSTYdwSeVpE500WU3Agll7n0AtEgpJffRnzclxDCyG6XTvznccDviJi1sD6
	 43zr8HFb54cCpNQNIP4SAQSP/B9Flf0H4t/TuERpf+dBEu2zATe+3JUK8CUZc+d3mD
	 k3hfpiL4BB6fGhLXTQPMTS6EtswzK7UoSNW6Zy3xJH9mSui+OhK9PloZZ0hgs+MSi1
	 4XQ5adjIyhw/g==
Date: Mon, 04 Mar 2024 05:17:24 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Seven Lee <wtli@nuvoton.com>
Cc: supercraig0719@gmail.com, KCHSU0@nuvoton.com, scott6986@gmail.com, 
 conor+dt@kernel.org, dardar923@gmail.com, robh+dt@kernel.org, 
 alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, YHCHuang@nuvoton.com, 
 linux-kernel@vger.kernel.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, SJLIN0@nuvoton.com, lgirdwood@gmail.com
In-Reply-To: <20240304101523.538989-2-wtli@nuvoton.com>
References: <20240304101523.538989-1-wtli@nuvoton.com>
 <20240304101523.538989-2-wtli@nuvoton.com>
Message-Id: <170955104307.4120754.16376940240530609048.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: Added schema for
 "nuvoton,nau8325"


On Mon, 04 Mar 2024 18:15:22 +0800, Seven Lee wrote:
> Added a DT schema for describing nau8325 audio amplifiers.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---
>  .../bindings/sound/nuvoton,nau8325.yaml       | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100755 Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:25:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:25:20: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:25:30: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:25:41: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:30:12: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:30:29: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:30:37: [error] string value is redundantly quoted with any quotes (quoted-strings)
/Documentation/devicetree/bindings/sound/nuvoton,nau8325.yaml:30:45: [error] string value is redundantly quoted with any quotes (quoted-strings)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240304101523.538989-2-wtli@nuvoton.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


