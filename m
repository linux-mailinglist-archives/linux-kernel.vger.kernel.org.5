Return-Path: <linux-kernel+bounces-96291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D398759C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB94281F30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA113B2BD;
	Thu,  7 Mar 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQINbUxQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCF131E3C;
	Thu,  7 Mar 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848339; cv=none; b=Lb1pe21DrfHlO2k4sEz4MrQ/YKOx09iroZlrobcjTfjaF8X/QicaG+eQGxN4HR9eXVSl6W+iIDo0by7aQXN2aoxGN+HfbwjtEXR52EPrl8l8DXh3FybTVbZdu7DxgcmxIZ8GZfwtaIKTjWNf7OpnbvfhbcZyRxtHflxnPMO2aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848339; c=relaxed/simple;
	bh=c7A0XMkbXZAFW7+3KxHmXP0sKvgNAhuc223K2RQHkmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQPODJ3EywbRWDdrSVLZ6mShcNOh1Nu7ssDlJu6a4zCwhF43E9QqRolyMX3ce5gfC9agJ2XjBa9rDB3dwklxVK+007Z98LFR6g7nZhAAJcnY5a2JEL5m4ivb+cLMVrMKyKhBVtAclBI/vbU6lX35GsJ9zo9ocVWL9UwExJCHTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQINbUxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F779C433C7;
	Thu,  7 Mar 2024 21:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848339;
	bh=c7A0XMkbXZAFW7+3KxHmXP0sKvgNAhuc223K2RQHkmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQINbUxQhR3TSRNApvgE1q8yLZipCir5NX4vAyKZrEeuPk/hrrrc/89iu5eVOKPY0
	 vPHFtxqu2SrCjp81LcYDB76Jqz49DHQmieHjpbXzLhgNU+0gMJuU6vOd0UaEBSkBzX
	 ec3nb59LmoL9zYCW57MPAf0kXPbFEI8Ct8CoFpF/jWurfroFwtqhLicm7mKr4U3OLa
	 pYQ+XGQh0h6Ijfhj6B1kXkMN9s3sTt8JXyufrtuwwBudAm3JxN+bXeOo+n/b31utCY
	 /Mx+nk/XR7uxXDu/DE2ArbKN+JWuuz6AlJWsf7i6NV96Pf/2DmSHruuXhu4C9FbufS
	 ycJiWPGzinKIQ==
Date: Thu, 7 Mar 2024 15:52:14 -0600
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
	viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Message-ID: <20240307215214.GB3110385-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzmenx2c.fsf@mail.lhotse>

On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
> > linux,sml-base holds the address of a buffer with the TPM log. This
> > buffer may become invalid after a kexec and therefore embed the whole TPM
> > log in linux,sml-log. This helps to protect the log since it is properly
> > carried across a kexec with both of the kexec syscalls.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  arch/powerpc/kernel/prom_init.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index e67effdba85c..41268c30de4c 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1956,12 +1956,8 @@ static void __init prom_instantiate_sml(void)
> >  
> >  	reserve_mem(base, size);
> >  
> > -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
> > -		     &base, sizeof(base));
> > -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
> > -		     &size, sizeof(size));
> > -
> > -	prom_debug("sml base     = 0x%llx\n", base);
> > +	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
> > +		     (void *)base, size);
> 
> As we discussed via chat, doing it this way sucks the full content of
> the log back into Open Firmware. 
> 
> That relies on OF handling such big properties, and also means more
> memory will be consumed, which can cause problems early in boot.
> 
> A better solution is to explicitly add the log to the FDT in the
> flattening phase.
> 

Why can't you just use /reserved-memory here? That should be preserved 
from one kernel entry to the next.


> Also adding the new linux,sml-log property should be accompanied by a
> change to the device tree binding.
> 
> The syntax is not very obvious to me, but possibly something like?
> 
> diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> index 50a3fd31241c..cd75037948bc 100644
> --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> @@ -74,8 +74,6 @@ required:
>    - ibm,my-dma-window
>    - ibm,my-drc-index
>    - ibm,loc-code
> -  - linux,sml-base
> -  - linux,sml-size

Dropping required properties is an ABI break. If you drop them, an older 
OS version won't work.

>  
>  allOf:
>    - $ref: tpm-common.yaml#
> diff --git a/Documentation/devicetree/bindings/tpm/tpm-common.yaml b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> index 3c1241b2a43f..616604707c95 100644
> --- a/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> +++ b/Documentation/devicetree/bindings/tpm/tpm-common.yaml
> @@ -25,6 +25,11 @@ properties:
>        base address of reserved memory allocated for firmware event log
>      $ref: /schemas/types.yaml#/definitions/uint64
>  
> +  linux,sml-log:

Why is this Linux specific?

> +    description:
> +      Content of firmware event log
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +
>    linux,sml-size:
>      description:
>        size of reserved memory allocated for firmware event log
> @@ -53,15 +58,22 @@ dependentRequired:
>    linux,sml-base: ['linux,sml-size']
>    linux,sml-size: ['linux,sml-base']
>  
> -# must only have either memory-region or linux,sml-base
> +# must only have either memory-region or linux,sml-base/size or linux,sml-log
>  # as well as either resets or reset-gpios
>  dependentSchemas:
>    memory-region:
>      properties:
>        linux,sml-base: false
> +      linux,sml-log: false
>    linux,sml-base:
>      properties:
>        memory-region: false
> +      linux,sml-log: false
> +  linux,sml-log:
> +    properties:
> +      memory-region: false
> +      linux,sml-base: false
> +      linux,sml-size: false
>    resets:
>      properties:
>        reset-gpios: false
> 
> 
> cheers

