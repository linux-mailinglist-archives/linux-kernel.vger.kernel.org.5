Return-Path: <linux-kernel+bounces-100507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF228798DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388C41F218CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46E7D41F;
	Tue, 12 Mar 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW4iOzSu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFA7CF29;
	Tue, 12 Mar 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260561; cv=none; b=eiwxrV9/yNVlS7VbIjghlDBHzI4tCHSMDqso6r9V5LB+yPij/EH8nF7/Rdz/5/k0p2PPuwsLUE9Cru5BfU085cWlBY90GQiydICaN60+9yhzIndPCAkp9agiGvOr4vXclBtV01yHvnyRl+3ya+TceBieJvlU8PByTpptLlWllgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260561; c=relaxed/simple;
	bh=Ipf9zvhfvGw0qCLSPFs+Ov5pJgxtwIC4HDz+MvRXcl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIPiE18UNR9zTzV2zfWi0o6vUba0qTyfiqgqZC4akdjwKI1XmjPaYosvQzu0UtHlsf63qbuuOVDBMrU/v4GMbO9QnibSxcQoomojJg4Sw2f4XKjR5UMjk+dTiutOp2LzeVsR4+lRxUyUAf+uwDnhD5u8r5XpDyDlmcBehpNuaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW4iOzSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97175C433F1;
	Tue, 12 Mar 2024 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710260560;
	bh=Ipf9zvhfvGw0qCLSPFs+Ov5pJgxtwIC4HDz+MvRXcl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OW4iOzSuv4zzNFrLCz3VFKXt6F0ivI5jn4vCa1mqs2H6hgz2795jLI6HYxlb64Fwp
	 nkbwtAtOuyivEwR1x8+/ZzmhqijkPRkUFUQeov6NPZy1axHDC8QpnbQEBsvpq95PWD
	 beuftpHwgPAQ+PXkbHtiPZcRr5HxAhqF8xwJzJEEENED2oo+oooatgb8CrRr6+Njnu
	 luU0iIyj6rtK/80WTEqIicYC4BdtDnpsGaySgtRRRVtawTW0siGOAEnBGEWCwlxMjX
	 lFaFzgKirwKjAKcR46cYWc7zxjB6hRfIseNIVtwtdVDBNdZ3GzCS7VnrBea0SZU9zL
	 C9OvBJqVWR7wA==
Date: Tue, 12 Mar 2024 10:22:38 -0600
From: Rob Herring <robh@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
	viparash@in.ibm.com
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
Message-ID: <20240312162238.GA2308643-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
 <87jzmenx2c.fsf@mail.lhotse>
 <20240307215214.GB3110385-robh@kernel.org>
 <851536a5-ad8f-4d65-8c33-707e2fe762df@linux.ibm.com>
 <20240308205751.GA1249866-robh@kernel.org>
 <87a5n34u5p.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5n34u5p.fsf@mail.lhotse>

On Tue, Mar 12, 2024 at 09:32:50PM +1100, Michael Ellerman wrote:
> Rob Herring <robh@kernel.org> writes:
> > On Fri, Mar 08, 2024 at 07:23:35AM -0500, Stefan Berger wrote:
> >> On 3/7/24 16:52, Rob Herring wrote:
> >> > On Thu, Mar 07, 2024 at 09:41:31PM +1100, Michael Ellerman wrote:
> >> > > Stefan Berger <stefanb@linux.ibm.com> writes:
> >> > > > linux,sml-base holds the address of a buffer with the TPM log. This
> >> > > > buffer may become invalid after a kexec and therefore embed the whole TPM
> >> > > > log in linux,sml-log. This helps to protect the log since it is properly
> >> > > > carried across a kexec with both of the kexec syscalls.
> >> > > > 
> >> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> > > > ---
> >> > > >   arch/powerpc/kernel/prom_init.c | 8 ++------
> >> > > >   1 file changed, 2 insertions(+), 6 deletions(-)
> >> > > > 
> >> 
> >> > 
> >> > 
> >> > > Also adding the new linux,sml-log property should be accompanied by a
> >> > > change to the device tree binding.
> >> > > 
> >> > > The syntax is not very obvious to me, but possibly something like?
> >> > > 
> >> > > diff --git a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> >> > > index 50a3fd31241c..cd75037948bc 100644
> >> > > --- a/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> >> > > +++ b/Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
> >> > > @@ -74,8 +74,6 @@ required:
> >> > >     - ibm,my-dma-window
> >> > >     - ibm,my-drc-index
> >> > >     - ibm,loc-code
> >> > > -  - linux,sml-base
> >> > > -  - linux,sml-size
> >> > 
> >> > Dropping required properties is an ABI break. If you drop them, an older
> >> > OS version won't work.
> >> 
> >> 1) On PowerVM and KVM on Power these two properties were added in the Linux
> >> code. I replaced the creation of these properties with creation of
> >> linux,sml-log (1/2 in this series). I also replaced the handling of
> >> these two (2/2 in this series) for these two platforms but leaving it for
> >> powernv systems where the firmware creates these.
> >
> > Okay, I guess your case is not a ABI break if the kernel is populating 
> > it and the same kernel consumes it. 
> >
> > You failed to answer my question on using /reserved-memory. Again, why 
> > can't that be used? That is the standard way we prevent chunks of memory 
> > from being clobbered.
> 
> Yes I think that would mostly work. I don't see support for
> /reserved-memory in kexec-tools, so that would need fixing I think.
> 
> My logic was that the memory is not special. It's just a buffer we
> allocated during early boot to store the log. There isn't anything else
> in the system that relies on that memory remaining untouched. So it
> seemed cleaner to just put the log in the device tree, rather than a
> pointer to it.

My issue is we already have 2 ways to describe the log to the OS. I 
don't see a good reason to add a 3rd way. (Though it might actually be a 
4th way, because the chosen property for the last attempt was accepted 
to dtschema yet the code has been abandoned.)

If you put the log into the DT, then the memory for the log remains 
untouched too because the FDT remains untouched. For reserved-memory 
regions, the OS is free to free them if it knows what the region is and 
that it is no longer needed. IOW, if freeing the log memory is desired, 
then the suggested approach doesn't work.

> 
> Having the log external to the device tree creates several problems,
> like the crash kernel region colliding with it, it being clobbered by
> kexec, etc.

We have multiple regions to pass/maintain thru kexec, so how does having 
one less really matter?

Rob

