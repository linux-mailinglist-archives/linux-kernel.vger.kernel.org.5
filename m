Return-Path: <linux-kernel+bounces-110107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD16885A19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C81C2136E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4924384A57;
	Thu, 21 Mar 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfSH0sCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9205810B;
	Thu, 21 Mar 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028960; cv=none; b=iWrund1msg2JuiSRQ2V9/D2MsBCgMCzv1faUiNrs/sgSZeTsVtMrRDaE/PB7x7lUeQPQSmQr5AxlzUEhJ4r1zYqX5xXg1jp16Hj5yar4IoPiSVTi6ngu2ZSLQDVCkr/Ah3x9Wxh/bBlqPMigJOC8lwK9QR9SwVKUX+iyRqbON8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028960; c=relaxed/simple;
	bh=KXx1OqLAULwK6itNYdQKESUqdlN3IelvAK9/XCk+0Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPrps3KRK0GjGySczf9fdfVp4PutdxjYiDSE9huWUGPSEWULaSddIgim2/Hs6zKzjdFBRPg4OADE8bRQMV8EpfV0UwSSyk0UpsqPK2kRJQ1hFVxLOL9p8bIg8mM6WVerN3JFIvh4Imue/98Z5p4IR2Uc7KPjsFt2URwrBomh8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfSH0sCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0F8C433C7;
	Thu, 21 Mar 2024 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028960;
	bh=KXx1OqLAULwK6itNYdQKESUqdlN3IelvAK9/XCk+0Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfSH0sCHJWrC0Zm7gIFMlUG/67wXwcMg287W1NWjx4xIRms/VFGt2JNm4zsUSMcPh
	 7G8ynAWHQYnZOBXA+dMX8X4BcoDhTtjpjCry7WRKeQlW1lhGVcckn8v15LQOumwBB3
	 90CFXSsIkQKwINN5td+GYaGEGfJbimpmYYKsDyao9gbMcaLix8fnk6Oq7uVukKm+0a
	 HvMDRdz1NTJnw0Izki2/BYV2UCmnxzZIBd3YQkpDqcVO42zeHtCs2IG1NwygXU0dZZ
	 51/feqlB/xRW9Xkg+YKqgOVYm+rEq8/UbSh1jBtcOf8gQ35G7K9SioxkuuWMU35rO1
	 bHI6wwh90eG1g==
Date: Thu, 21 Mar 2024 08:49:17 -0500
From: Rob Herring <robh@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] dt-bindings: mtd: fixed-partition: Add binman
 compatibles
Message-ID: <20240321134917.GA1625959-robh@kernel.org>
References: <20240320052449.175786-1-sjg@chromium.org>
 <20240320052449.175786-2-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320052449.175786-2-sjg@chromium.org>

On Wed, Mar 20, 2024 at 06:24:49PM +1300, Simon Glass wrote:
> Add two compatibles for binman entries, as a starting point for the
> schema.
> 
> Note that, after discussion on v2, we decided to keep the existing
> meaning of label so as not to require changes to existing userspace
> software when moving to use binman nodes to specify the firmware
> layout.
> 
> Note also that, after discussion on v6, we decided to use the same
> 'fixed-partition' schema for the binman features, so this version
> adds a new 'binman.yaml' file providing the new compatibles to the
> existing partition.yaml binding.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v8)
> 
> Changes in v8:
> - Switch the patch ordering so the partition change comes first
> 
> Changes in v7:
> - Adjust MAINTAINERS entry
> - Put compatible strings into the 'fixed-partition' binding
> 
> Changes in v5:
> - Add mention of why 'binman' is the vendor
> - Drop  'select: false'
> - Tidy up the compatible setings
> - Use 'tfa-bl31' instead of 'atf-bl31'
> 
> Changes in v4:
> - Correct selection of multiple compatible strings
> 
> Changes in v3:
> - Drop fixed-partitions from the example
> - Use compatible instead of label
> 
> Changes in v2:
> - Use plain partition@xxx for the node name
> 
>  .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
>  .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
>  MAINTAINERS                                   |  5 ++
>  3 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 000000000000..83417ad5cee9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman entries
> +
> +description: |
> +  TBD

?

> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/partition.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - binman,entry # generic binman entry

As-is, 'binman' would need to be added to vendor-prefixes.yaml. 

However, I think just 'binman' would provide just as much information. 
But really, does it provide anything? What would be the difference 
between this and no compatible?

Rob

