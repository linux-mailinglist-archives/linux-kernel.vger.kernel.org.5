Return-Path: <linux-kernel+bounces-97578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A5876C16
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F95EB212C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED875F572;
	Fri,  8 Mar 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFgAlLmb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165665E08E;
	Fri,  8 Mar 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931474; cv=none; b=IJ558UYofLGcyigU6wQnBSqmjCRwNvzw3gunwSIPVyN6PM1R5854/f8iSywk0HWZpz9XKMEefHAn+oirXN71z/mm9ZhSkJwBLTpJCbJYW2hXX+u1S6oa1rTQnXetJoeKT3Jj+z+rfViHr/kkIMLFOv/Ajm8yJ23ZZPh8fwK27IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931474; c=relaxed/simple;
	bh=soccycv4nLOig6ojnBJutZjg8TXzD0ylPNIS8YDUg8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwsZAUkXFUFOJWzIWfPzapiiAysQ3J0XcmYirqTIVuyOzXiwPjRgxsBojx6Xm/PuhMGCGgyUVGydO//NNiXDHG0NmcGWnAhozfeMcOsdlIFUdBa4jdtITwVmHy2qcbDsJ9WUanZrDvP3bUELijCo6b0ekbyxlCW8Tptxbhv/R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFgAlLmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70676C433C7;
	Fri,  8 Mar 2024 20:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709931473;
	bh=soccycv4nLOig6ojnBJutZjg8TXzD0ylPNIS8YDUg8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFgAlLmbkGzlO7Eiscu5ySX+Mzfw8MhP+ePPoduF2tExLlaGxE+mdwxke1Hd0CUAg
	 pPCN6ejVjo9ymHHVEdCHscbs9L1UxNWlD1Lq2Et7UP215IOcgG7qC2ZfPKFp33ry9a
	 xTZ1tP/kjLFbZxBEq6UVk2z8hGQf2W01lVR/gJ41Knr7ZpEyvHHIyHSaDZ0yBbWIqm
	 LZZEEFFIcusCCIH+E9DTWbxfw0fTeplNtbVn2FraC0lJKp8OUmL+9D2xCmaRsGUYFn
	 mRAy/ahjRnJMYzJ+wvOAIQmyfNGng78uV2u+RtBa99q6DQawtiF2R2YTb4tu+BmaDf
	 Usg3hv5re5k2Q==
Date: Fri, 8 Mar 2024 14:57:51 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
	viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Message-ID: <20240308205751.GA1249866-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse>
 <20240307215214.GB3110385-robh@kernel.org>
 <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>

On Fri, Mar 08, 2024 at 07:23:35AM -0500, Stefan Berger wrote:
> 
> 
> On 3/7/24 16:52, Rob Herring wrote:
> > On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
> > > Stefan Berger <stefanb@linux.ibm.com> writes:
> > > > linux,sml-base holds the address of a buffer with the TPM log. This
> > > > buffer may become invalid after a kexec and therefore embed the whole TPM
> > > > log in linux,sml-log. This helps to protect the log since it is properly
> > > > carried across a kexec with both of the kexec syscalls.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > ---
> > > >   arch/powerpc/kernel/prom_init.c | 8 ++------
> > > >   1 file changed, 2 insertions(+), 6 deletions(-)
> > > > 
> 
> > 
> > 
> > > Also adding the new linux,sml-log property should be accompanied by a
> > > change to the device tree binding.
> > > 
> > > The syntax is not very obvious to me, but possibly something like?
> > > 
> > > diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > > index 50a3fd31241c..cd75037948bc 100644
> > > --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > > +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> > > @@ -74,8 +74,6 @@ required:
> > >     - ibm,my-dma-window
> > >     - ibm,my-drc-index
> > >     - ibm,loc-code
> > > -  - linux,sml-base
> > > -  - linux,sml-size
> > 
> > Dropping required properties is an ABI break. If you drop them, an older
> > OS version won't work.
> 
> 1) On PowerVM and KVM on Power these two properties were added in the Linux
> code. I replaced the creation of these properties with creation of
> linux,sml-log (1/2 in this series). I also replaced the handling of
> these two (2/2 in this series) for these two platforms but leaving it for
> powernv systems where the firmware creates these.

Okay, I guess your case is not a ABI break if the kernel is populating 
it and the same kernel consumes it. 

You failed to answer my question on using /reserved-memory. Again, why 
can't that be used? That is the standard way we prevent chunks of memory 
from being clobbered. There's already support for describing the TPM log 
that way anyways. The only reasoning I can see writing out a node for 
that is harder than just adding a property, but that's not a great 
argument IMO.


> 2) There is an example in the ibm,vtpm.yaml file that has both of these
> and the test case still passes the check when the two entries above are
> removed. I will post v2 with the changes to the DT bindings for
> linux,sml-log including an example for linux,sml-log. [The test cases fail,
> as expected, when an additional property is added, such as when
> linux,sml-base is added when linux,sml-log is there or linux,sml-log is
> added when linux,sml-base is there.]

Sure, removing a required property is never going to break the DT 
checks. What would break is a client (OS) version that only understands 
linux,sml-base and can no longer get the log assuming getting the log 
itself was required. 

Rob

