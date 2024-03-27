Return-Path: <linux-kernel+bounces-121765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A988ED59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EB31F29D33
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9B514D6FE;
	Wed, 27 Mar 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQAUYVkk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAFB14EC52
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561902; cv=none; b=H0FX4Xhkxnz5tgG/6yfiwAWLFUb7mSVcDdVBGtko4Fs94Vv5Q9u41BkI3nXO75RtFJAjdIrfIS94YifAkkzwz/ngiO8nDF536jT0GVBsiZ5cxoLx4rwt0LtPFuJDWyNMRmtkerqShbfp7k3b/qx6MmT3gKXl25cXb+rP/m9QAzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561902; c=relaxed/simple;
	bh=Ifq8bc4sS7mIA42uoZVgKLdhrUE9yKJJvvvC0SusJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqiKFiFO+m4yWhbpM3BJyBSVL8iLmsswBDZwbeth2xGEjonAofoiHmL8F2kGxSV7tM5Sp43gI5V9Q0tJT4gT/5a/eNBZ0FFAyQxPFxmuP/C9As6VxpfcmEpjxy2QX1GzpsWFPvGKj1ySu+aX9eMpHEwNBXKxBv3QivYLnMNovmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQAUYVkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18642C433C7;
	Wed, 27 Mar 2024 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711561901;
	bh=Ifq8bc4sS7mIA42uoZVgKLdhrUE9yKJJvvvC0SusJHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQAUYVkkowBA1kzf4iR4zJrIX2VW9K2SbPhSgbsK8NrT/Psjovj0G5NHt+4sLWpH+
	 GXzVSBzGod2oR3ziGZbYGRbZDiTZzf+/QDTTA/LUp8zP+gfXvI33VvXUVcMLmjE/fm
	 h0s8pdNHa6MVg3DoQanRAKnrJMrUkJ4q0/feZF6I=
Date: Wed, 27 Mar 2024 18:51:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
Message-ID: <2024032709-grunt-eskimo-55a2@gregkh>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
 <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjHZBziH+5tXcTJ1aGZN2tC5S5gKhkNjhiaFFO93vNqcA@mail.gmail.com>

On Wed, Mar 27, 2024 at 09:56:43AM -0700, Linus Torvalds wrote:
> On Thu, 21 Mar 2024 at 06:02, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Char/Misc and other driver subsystem updates for 6.9-rc1
> [...]
> > Chris Leech (4):
> >       uio: introduce UIO_MEM_DMA_COHERENT type
> >       cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
> >       uio_pruss: UIO_MEM_DMA_COHERENT conversion
> >       uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
> 
> So this was all broken, and doesn't even build on 32-bit architectures
> with 64-bit physical addresses as reported by at least Guenter.
> Notably that includes i386 allmodconfig.
> 
> I fixed up the build, but I did it the mindless way. I noted in the
> commit message that I think the correct fix is likely to make
> 'uio_mem.mem' be a union of 'physaddr_t' and 'void *' and just always
> use the right member. UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL should
> probably use the pointer thing too.
> 
> I also *suspect* that using 'physaddr_t' is in itself pointless,
> because I *think* the physical addresses are always page-aligned
> anyway, and it would be better if the uio_mem thing just contained the
> pfn instead. Which could just be 'unsigned long pfn'.
> 
> So there are proper cleanups that could be done in that area.
> 
> That's not what I did, though. I just fixed up the bad casts.
> 
> There may be other fixes pending out there, but I didn't want to delay
> the 32-bit build fixes any more.
> 
> It turns out that the cnic,bnx2,bnx2x conversion avoided the problems,
> almost by accident. That driver had used UIO_MEM_LOGICAL before and
> had existing casts. That doesn't make it good, but at least it made it
> not fail to build.
> 
> See commit 498e47cd1d1f ("Fix build errors due to new
> UIO_MEM_DMA_COHERENT mess")

Ick, ok, those casts work :)

I was waiting to hear back from Chris before applying the patches from
Guenter, but yours work for me for now, thanks!

greg k-h

