Return-Path: <linux-kernel+bounces-82421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A98683FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E2928E119
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FF13541B;
	Mon, 26 Feb 2024 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p00DO6yd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD9130AEE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987657; cv=none; b=sDiLYkU93KZDgHqJI6yTrExguBBnNGfi3VE3G0aPGxeMlepJOoSQyI6hhV5zv5K4JkvFhUn3rW+GWB9xQspXVQ36tKh35ewUitgvYkMCDKWM4dvagvQYj1A67xuR2HVd5Hmv9cbDXoxINiBzLkJULr7d4LuiCYYNnQIfiJhz5kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987657; c=relaxed/simple;
	bh=SIF6l2OHEXEE3BAbQV6qsonqNnLgzP8DvqtGYEaQfO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ+4twaqO+QAgMVyWBYtFFhGz9BTW6PxD12grjxicam7vzBGiWGN+jCmZkFP4xREFcw6+8xZ76L3ecRUZ0OrZhE8p5DU/C4R5iZouB45WHIYHTQbPaFEloRWTTbkmaDAihLbUj7k1STOnVoRyIQdcYntvbbgGyCWIC2uDFMkZp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p00DO6yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C472C433C7;
	Mon, 26 Feb 2024 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708987656;
	bh=SIF6l2OHEXEE3BAbQV6qsonqNnLgzP8DvqtGYEaQfO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p00DO6ydaneDwhDZD87n2MMe5t7m6vJWietj9ki3VDSivg0mFNftdWa+kwiBfnfZY
	 uUTWl2aw3awaqTWx6rU1iWJXAP0Urgz0r2xkvwbXAbfTPqcEHRDDjT4qpc5RrQt1O1
	 pl7KzGBS0BGdDvNQcx7U961icohJeNW3AzOE0NbaUE63ZF/gM/eeulShaEZmPzVxcr
	 8xd1UKweq57OMo57Sm4Vj6SDhXOMrtVUr2clqZgtK34L7cgZSWBn+yTfBG8EGO9Ku1
	 fntyYzlhzyi1YIo9QPm1xGaSdV/tst2hNuclApwV4HFpjqKKXhcdMvgGeNN0xlfL9b
	 WEoqzCPEXU0vw==
Date: Mon, 26 Feb 2024 14:47:34 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: allow to mount if cap is 100
Message-ID: <Zd0VBo3ilwRq4BJy@google.com>
References: <20240223205535.307307-1-jaegeuk@kernel.org>
 <20240223205535.307307-5-jaegeuk@kernel.org>
 <CACOAw_xdBY5Rg1J4jUTaH0UxVrdZ+CCVQj72q_cMxyCHuCTy_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_xdBY5Rg1J4jUTaH0UxVrdZ+CCVQj72q_cMxyCHuCTy_Q@mail.gmail.com>

On 02/26, Daeho Jeong wrote:
> On Fri, Feb 23, 2024 at 12:56 PM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Don't block mounting the partition, if cap is 100%.
> >
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/segment.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 6d586ae8b55f..f11361152d2a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -904,6 +904,9 @@ int f2fs_disable_cp_again(struct f2fs_sb_info *sbi, block_t unusable)
> >  {
> >         int ovp_hole_segs =
> >                 (overprovision_segments(sbi) - reserved_segments(sbi));
> > +
> > +       if (F2FS_OPTION(sbi).unusable_cap_perc == 100)
> > +               return 0;
> 
> With this, f2fs will not execute GC. What is this 100
> unusable_cap_perc used for?

Theoritically, it won't, but I was hitting a GC loop, and I suspected a wrong
section/segment layout. So, I posted the below, and guess we need this patch
as workaround.

https://patchwork.kernel.org/project/f2fs/patch/20240224011411.3820719-1-jaegeuk@kernel.org/

> 
> >         if (unusable > F2FS_OPTION(sbi).unusable_cap)
> >                 return -EAGAIN;
> >         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED_QUICK) &&
> > --
> > 2.44.0.rc0.258.g7320e95886-goog
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

