Return-Path: <linux-kernel+bounces-87175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F986D0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92E71C225E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15470ADD;
	Thu, 29 Feb 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diJHgxM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AF6CBF3;
	Thu, 29 Feb 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227889; cv=none; b=Cl+v/51rsuggxU4+S9gTsELMo83kiSXlKW10Qpt8MvasV82eHcubaNhQFRPo3ihWFf9NK0KIKJB8QLM6W11ELLwER7c1biMnbxK71Pksnq6nPKkWZNxFVcy3n0HgpSbapV1Qu/b5kjOUgbGlFNDDySih5Kiqu8bhwDrV2/3ppQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227889; c=relaxed/simple;
	bh=9DzNczRfLQHZQ7xM/5Rsf1G4ssLJqqDQeagj+2HQ7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXk0pu9DLg2AWM8bkoOpqJ65PW2OIItWLqo3hPH9ztBlRBJAPuDrgfqQRr7ZGoWc/mWXDFFkZkMlyj+fP3EniDE/uoStDp+PQov66EjervP1dH6U11tgnCPxUXLzlwUzEpsYcMF2Ok/HABcXQmHQPF+GCdnhJVR6mn3X7LytO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diJHgxM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D1C433F1;
	Thu, 29 Feb 2024 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709227889;
	bh=9DzNczRfLQHZQ7xM/5Rsf1G4ssLJqqDQeagj+2HQ7og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diJHgxM014XnHKWcaxVwTBkW3gX57RmZxYWS+sJS+A7HG35g3mzRWzGi6YrIHriPn
	 QgUZzvQlv4DAI1wWyZ+KYWohVL6+qvRqKOBAKh1Eg5afeYkADvoypyDL7wSSngpC9e
	 gptRCTe8jpqiSosxVs/SQ/fTdvQu0bKclizFrICODQB/No3OTJkAMW8KxPl8K2qofN
	 m3Sr8deGN0pYmVf2ay7keF8TOqQmkl3/tOgN+rS6S939MLrazA2ETU7a+bTmTSuvaX
	 4tS8lqpbf3gxEcBRMFT2oG9c0M0T0FcQqIE7YxH2I2hK2idblOSQSfCKdGnWtET+pJ
	 QvuC8j/TNBaQg==
Date: Thu, 29 Feb 2024 09:31:27 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] f2fs: Fix two spelling mistakes in
 f2fs_zone_status array
Message-ID: <ZeC_b8JipJyjycW3@google.com>
References: <20240229091449.105032-1-colin.i.king@gmail.com>
 <ZeC64dDr-nBGlsli@google.com>
 <5e705d83-871e-4403-a77f-ec197eefb7c4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e705d83-871e-4403-a77f-ec197eefb7c4@gmail.com>

On 02/29, Colin King (gmail) wrote:
> On 29/02/2024 17:12, Jaegeuk Kim wrote:
> > Hi Colin,
> > 
> > Thank you for the fix. If you don't mind, can I integrate this fix
> > into the original patch?
> 
> Sure. No problem.

Thank you so much!

> 
> Colin
> > 
> > Thanks,
> > 
> > On 02/29, Colin Ian King wrote:
> > > The array f2fs_zone_status contains two spelling mistakes in
> > > literal strings. Fix them.
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   fs/f2fs/segment.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index bdb27e4a604b..072c4355d3d3 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -4921,8 +4921,8 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
> > >   const char *f2fs_zone_status[BLK_ZONE_COND_OFFLINE + 1] = {
> > >   	[BLK_ZONE_COND_NOT_WP]		= "NOT_WP",
> > >   	[BLK_ZONE_COND_EMPTY]		= "EMPTY",
> > > -	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICITE_OPEN",
> > > -	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICITE_OPEN",
> > > +	[BLK_ZONE_COND_IMP_OPEN]	= "IMPLICIT_OPEN",
> > > +	[BLK_ZONE_COND_EXP_OPEN]	= "EXPLICIT_OPEN",
> > >   	[BLK_ZONE_COND_CLOSED]		= "CLOSED",
> > >   	[BLK_ZONE_COND_READONLY]	= "READONLY",
> > >   	[BLK_ZONE_COND_FULL]		= "FULL",
> > > -- 
> > > 2.39.2

