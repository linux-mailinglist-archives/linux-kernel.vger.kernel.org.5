Return-Path: <linux-kernel+bounces-147871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3C8A7ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F401C20C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716A749C;
	Wed, 17 Apr 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixY8b4Op"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38336AAD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713322783; cv=none; b=sNna1paatx40oRTpoZ7mDBrCCju/YrE1hAHtVqaCZGJvryyndx2YAuDMA4cPyGK4Oo72FBpS9cYNvbtM6E6b5/D1CwAH1x+2BUF5Bh5zqZYbgFogxePM03al3d5vw7HeoEgB4g6TjVWAKwbxPaMJ+pWNChm18jWiAT0p7gNG0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713322783; c=relaxed/simple;
	bh=1Sz8qWQGGkRx+TmU1xHfA1jN9CMtaXGFfIdA3CGeDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRYuSsTQkzCuzAWs3Z3dUW4lOb0J8XHPUuG2XcsSgb1k5kNFa0EnTcHVlcv+UXqZ13XisM4yQzE8t3qhxAVWUsmHiHpU9llTjbH6gME76ZcGQOqNOCO6dKXiFlHvXYuZK435e6AoSDXBwrd2K1t5la1cQ/gx6Uc+zYYWmIcIxmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixY8b4Op; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 16 Apr 2024 22:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713322778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9m+kCUmrYL1S2pLAT21wcG4kuuMpS6hSz6ardhvzbY=;
	b=ixY8b4Opw9WyD1h2lNYAiERCaVGskVVsmeaO9hkcBttGfo0yPbEQVYr5yLShoR5evJvr/0
	QFECLyuouQsJioGN39kbGWYnytraf5dyIYmefG6ZnCYZNL1IenK1sphcobb5b+kQS/20HK
	LT4XlZPrD9qUp02RDz5tTkFd225yN10=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
Message-ID: <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
 <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 17, 2024 at 10:50:10AM +0800, Youling Tang wrote:
> Hi, Kent
> On 17/04/2024 10:20, Kent Overstreet wrote:
> > On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
> > > From: Youling Tang <tangyouling@kylinos.cn>
> > > 
> > > Before patch:
> > > ```
> > >   #cat btrees/inodes/keys
> > >   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
> > >     flags= (16300000)
> > > ```
> > > 
> > > After patch:
> > > ```
> > >   #cat btrees/inodes/keys
> > >   u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
> > >     mode=40755
> > >     flags= (16300000)
> > This would print a newline for keys that don't have a value...
> The original intention was to make the display of the printed content in
> '__bch2_inode_unpacked_to_text ()' consistent, without considering other
> callbacks.
> 
> Or just modify it in the following way?

Yeah, that's better

Do it off my master branch though, there's some printbuf imprevements in
there.

https://evilpiepirate.org/git/bcachefs.git

> --- a/fs/bcachefs/inode.c
> +++ b/fs/bcachefs/inode.c
> @@ -534,6 +534,8 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct
> bkey_s_c k,
>  static void __bch2_inode_unpacked_to_text(struct printbuf *out,
> struct bch_inode_unpacked *inode)
>  {
> +       prt_newline(out);
> +
>         printbuf_indent_add(out, 2);
>         prt_printf(out, "mode=%o", inode->bi_mode);
>         prt_newline(out);
> 
> 
> Thanks,
> Youling.

