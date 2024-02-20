Return-Path: <linux-kernel+bounces-72997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00685BBC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9301284E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86D667E7B;
	Tue, 20 Feb 2024 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/fpWjMc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCD467C71;
	Tue, 20 Feb 2024 12:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431561; cv=none; b=iw1zxPu+qruvKLeN8607FnLz225YL4pirFVerttWx+fsI5POPpk4EecgqNjYPEQHSV513CfASi4z+2a492A5LLs0ALwXZfPdSXK3S2VdFzyrZLoVmlsRLWbAdBn7sNGOHDlKlSP5UyL1EzRVb8RcGHJ6ez1OGoGeG4l6u7Z4Nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431561; c=relaxed/simple;
	bh=GAbLAdPRT9LXNVUR3e7hM4AhNauwKmwqN8rBcjMWsOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcwil7GFbmHF3N9/YoCVfZhwJyqDs3fGAMzU/2PINHMAUqSVGxlyP2SlbxKWNoDfZLBJvmTYzEDdt0ShEcZT2Eh1nhUFq0HzscnLaLhUp8YJjOOt+j6eupKAuVzxh633910/zvQcanQKJbgI+0bEI8BCTsYWOOCxNQORkRvCTdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/fpWjMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54431C433F1;
	Tue, 20 Feb 2024 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708431560;
	bh=GAbLAdPRT9LXNVUR3e7hM4AhNauwKmwqN8rBcjMWsOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y/fpWjMcMtcird10UlSs/QVsPZkPL/zZXCdgHDOVf1kjtFtboB/VDaV7Q8mi0qLav
	 bfNn9vBvF0NQNbC5VDgpr8l6bNuKXyCCE/Fh62SHuFOli0JUo9DWSy0cmynJDJV65Y
	 SHo0yF38FR7+jjnpnU3Bus1SaNKae03y7Mwet3JcPc4YXVm6fj8uD9Nrt2pM8Oaixu
	 zUD/2RAP24BBP2T1ON1Eo423LO2YqThAhPwLK5SUlNeDJmwuziFTaUX1QA4OZhG35w
	 KniVBrj45mSevj6hWh+5MvVNWJe7mKMk7/RwN4Wbq80w6FWjF10JNY1sv+8XTTWEts
	 yWqzNK4E7Azgw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  linux-mtd@lists.infradead.org,  Yazan Shhady
 <yazan.shhady@solid-run.com>,  Rob Herring <robh@kernel.org>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
In-Reply-To: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
	(Josua Mayer's message of "Mon, 19 Feb 2024 15:41:19 +0100")
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
Date: Tue, 20 Feb 2024 13:19:17 +0100
Message-ID: <mafs08r3f8h16.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 19 2024, Josua Mayer wrote:

> Some spi flash memories have an interrupt signal which can be used for
> signalling on-chip events such as busy status or ecc errors to the host.
>
> Add binding for "interrupts" property so that boards wiring this signal
> may describe the connection.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

BTW, I don't see any support in SPI NOR for handling these interrupts.
Do you plan to add them in a later patchset? If not, what do you get by
describing them?

> ---
> Changes in v7:
> - split out of original patchset because it should go via mtd tree
> - collected acked-by Rob Herring from v6
> - Link to v6: https://lore.kernel.org/r/20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 58f0cea160ef..6e3afb42926e 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -52,6 +52,9 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  interrupts:
> +    maxItems: 1
> +
>    m25p,fast-read:
>      type: boolean
>      description:
>

-- 
Regards,
Pratyush Yadav

