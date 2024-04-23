Return-Path: <linux-kernel+bounces-155698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC5E8AF5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC1A286E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9B13E020;
	Tue, 23 Apr 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IEpNmJdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F413CA8A;
	Tue, 23 Apr 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894165; cv=none; b=Z7tRFDeNrHQ7GBCS3bikIpZAmZiTO4xIK/DYuzr53fYlAQpFffRJb+9+ngIgP/oKpuTz9S8xC0SmW1Rl1RyLYQyNS4JM44oyG/6N5G4IGmZi3hnm8UQiF7xGM6i3cKdNkVv2nMg4K5VPdJAdW4DVRVq2pOEo2/+O26SwRRlA2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894165; c=relaxed/simple;
	bh=jr0FL/sdQ5DqkDL9pdfWp5P13hNiyF7VcuK+S9HzQ4E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NzmsJi5YtjbHRp3QU6n9KoJHe+dE0Z0ntdjq3y5VgaZTT1PqXB0MDCsusEraHnfh5ZVWSZBNnhkZBHunXcrVlEFXjGmox2wCE89YJWxDLmlzHNv9iqU0DcklMII/Jh8xLwSo3Yj63fts3cPeCfKDy6UPhFMYB9gTTxFhgA1HcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IEpNmJdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E3EC116B1;
	Tue, 23 Apr 2024 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713894165;
	bh=jr0FL/sdQ5DqkDL9pdfWp5P13hNiyF7VcuK+S9HzQ4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IEpNmJdzUHxHHBiS/0YhvZZ8Fk+7y/RJ/mmOhtuRZd+Vgf4KX8CuUJ4NqcqPN4fQ9
	 WoxXv/IfSBxMbgBj0caJgRJYt1Hxl5DsRP/p074MWKoUHoEPBHxFUqeBOuNWW+cred
	 T2KWkH/lxDshwWyRxrkilogbeFgbXbLXw8xaPBnE=
Date: Tue, 23 Apr 2024 10:42:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kent Overstreet <kent.overstreet@linux.dev>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the vhost tree with the mm tree
Message-Id: <20240423104244.d0108d71eee622b2f9371cfa@linux-foundation.org>
In-Reply-To: <20240423220317.01d65416@canb.auug.org.au>
References: <20240423145947.142171f6@canb.auug.org.au>
	<e07add5b-e772-4a8c-b71f-79f1fe74580a@redhat.com>
	<20240423220317.01d65416@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 22:03:17 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Tue, 23 Apr 2024 10:21:55 +0200 David Hildenbrand <david@redhat.com> wrote:
> >
> > Easy header conflict. @MST, @Andrew, do we simply want to take that
> > virtio-mem patch via the MM tree to get rid of the conflict
> > completely?
> 
> And because it is so trivial a conflict, you should just mention it to
> Linus when you send the merge requests.

Yes, let's leave things as they are.  We have to give Linus *something*
to do ;)

