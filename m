Return-Path: <linux-kernel+bounces-77958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E1860D52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD51C24BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE351B59B;
	Fri, 23 Feb 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxRmhw63"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A71A29F;
	Fri, 23 Feb 2024 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678516; cv=none; b=WXr/LjVqMSsP7VeyR49GCaVKvZx2pGuqfz81dUX9zxR2pzlYaPn7nOHeXu38FBSizcavHgYKKziewkc7u0P5X1whdudO2QBHUwaH8mQcUKoX+l9fNENYPG2N3w4ZmZnVFdbBzpugu1obQdb6K723rLK70juULBM4wTa63Iwazds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678516; c=relaxed/simple;
	bh=Ij/b+MpsNlBt3MrTw0ewA1TFe0zMkrFqiI2QnREsP+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbHwJtGI3Tp4wnQdhsGWvPnALWOlB03OjKN1QneCfkjhXEdpfmOXlAxpHylAtwUB1G7hdvxNnsN7S8e8pURk5nj0C+9o0cT0MhtX9PCHOSRnnuFLb208IKppv35YqlY6UwGRBCEpG560qm3bQoHzKbggWl2TMGeYT8pUbMzOMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxRmhw63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936CDC433C7;
	Fri, 23 Feb 2024 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708678515;
	bh=Ij/b+MpsNlBt3MrTw0ewA1TFe0zMkrFqiI2QnREsP+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IxRmhw63NoxrE/Fl8mYO5N2oqy/0friHJP6E+fgOUecQRVAmjgggow15j4GD7emli
	 QqGPSOh6v9FR7LaeTxbt6p7XTtmGeegLQiTV8Qt7yZ5bgFHIrJWwDWU3PTqGfQa/KP
	 xuDu2SwGZixd5sx4xnGTjO2aQJKBoIo6oZ2sjjAsvEbpVcNdM3gHYNXKtDUeSY5MO4
	 1o7rBOzu3g9txiUuO1sALSiFlvKogJjnvHEzYmFoF9RqKzF76P1o54Su4GXyRMdTih
	 ewCGbbiOztChMq2Ifd+Jk9fsqRTNpU09kVbvFLFCWQOCMRGU3nzJogRnd2PM+icjoX
	 PRuSdfrLpvbfQ==
Date: Fri, 23 Feb 2024 09:55:09 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Darrick J. Wong"
 <djwong@kernel.org>, David Chinner <david@fromorbit.com>,
 linux-xfs@vger.kernel.org, Chandan Babu R <chandanbabu@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: linux-next: build warning after merge of the xfs tree
Message-ID: <20240223095509.29024d9d@coco.lan>
In-Reply-To: <20240223063554.GA10956@lst.de>
References: <20240223153636.41358be5@canb.auug.org.au>
	<20240223063554.GA10956@lst.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 23 Feb 2024 07:35:54 +0100
Christoph Hellwig <hch@lst.de> escreveu:

> On Fri, Feb 23, 2024 at 03:36:36PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the xfs tree, today's linux-next build (htmldocs) produced
> > this warning:
> > 
> > Documentation/core-api/mm-api:130: mm/shmem.c:2155: WARNING: Inline emphasis start-string without end-string.
> > Documentation/core-api/mm-api:130: mm/shmem.c:2156: WARNING: Inline emphasis start-string without end-string.  
> 
> Thanks for the headsup.  Looks like kernel-doc doesn't like the
> pointer dereferene * operator.  Any good idea how to write this instead?

Asterisks there are used to do *italic* or **bold**. To have an
asterisk as-is, it needs to be escaped. This would work:

	\*foo

but it is very weird for the ones reading the text file. So, what
we do instead for pointers is to escape the entire declaration, like:

	``*inode``
	``struct inode *inode``

I hope that helps.

Thanks,
Mauro

