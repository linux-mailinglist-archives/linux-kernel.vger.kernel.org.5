Return-Path: <linux-kernel+bounces-148288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397C08A8061
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F941C20CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD1A13A3F3;
	Wed, 17 Apr 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VEQWUe/I"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA613AA5C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713348346; cv=none; b=OX7q1T8Dkgw6Lp6PV9G5+uf8QfJ4FuzgWkkdRxIbcgkHW5BWVwNb850WLoRQQkxQU44dqq0ZsP+yH0i43CPEYm9Two0nsoEgly2hJciLC9/FY7L03InNBggATAsMnby6ECzcMscyAwdnlSfD1bJLfCaOxdsHrBhCeJM+Uva9s/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713348346; c=relaxed/simple;
	bh=2J4oEguT5Jp7IrCrer3FeX1tYAAKExuR0SZ9wlgH+eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK7lmQzgeaDTaxzGnR+1QecbEtM52IkqZmaA9qCp6abAFZ/e883F3p6JktKMJ/4a4mi7+k9WUpwJfN+YQ1LCN27ORv3JEThwr61uSP1hjNDKTeuqMgoLnHce3P+PmULnb5WY0lMwYu8bwtHsgYySFqCzZ/OpDH5J30/KXsPuhH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VEQWUe/I; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 17 Apr 2024 06:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713348340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxiQp7PwJBkZp7GSN1QH3PHHroZhXEzJ0WM1QJzWHWk=;
	b=VEQWUe/IhCeMVuzfNoeWo0t3loNIRhf0yoya40gkpgYebza4bn7Mr75WWDqa+1szl9MmyH
	gmBEmk13flIY98Zd/p4TvFt6offxQkLWv7R07iJk69Z8lbs1DipEqLM5PykWSKC8X46mKU
	0Y+DOusV/FpljzL9GjpW6imW6K+kZmg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: Youling Tang <youling.tang@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
Message-ID: <fihmieyqam3ubckmmjlcrsjucahc3yb6m24sjt34cpsw6zii6i@n4atsknjqmkv>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
 <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
 <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
 <d17de3df-a3f2-4317-92cc-1fd02641328b@huawei.com>
 <29d5ea19-21b5-4076-9acc-8286a050c33f@huawei.com>
 <63d9540f-61bc-4eba-819c-c05d2e486bdb@linux.dev>
 <72e1b795-7219-41dd-83f2-10a3be2680b2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e1b795-7219-41dd-83f2-10a3be2680b2@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 17, 2024 at 05:49:41PM +0800, Hongbo Li wrote:
> 
> 
> On 2024/4/17 13:51, Youling Tang wrote:
> > Hi, Kent & Hongbo
> > On 17/04/2024 11:21, Hongbo Li wrote:
> > > 
> > > 
> > > On 2024/4/17 11:16, Hongbo Li wrote:
> > > > 
> > > > 
> > > > On 2024/4/17 10:59, Kent Overstreet wrote:
> > > > > On Wed, Apr 17, 2024 at 10:50:10AM +0800, Youling Tang wrote:
> > > > > > Hi, Kent
> > > > > > On 17/04/2024 10:20, Kent Overstreet wrote:
> > > > > > > On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
> > > > > > > > From: Youling Tang <tangyouling@kylinos.cn>
> > > > > > > > 
> > > > > > > > Before patch:
> > > > > > > > ```
> > > > > > > >    #cat btrees/inodes/keys
> > > > > > > >    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0: mode=40755
> > > > > > > >      flags= (16300000)
> > > > > > > > ```
> > > > > > > > 
> > > > > > > > After patch:
> > > > > > > > ```
> > > > > > > >    #cat btrees/inodes/keys
> > > > > > > >    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
> > > > > > > >      mode=40755
> > > > > > > >      flags= (16300000)
> > > > The flags also with the space after "=". Is it reseonable?
> > > Sorry, I misspell. I mean whether it is reasonable.
> > > > > > > This would print a newline for keys that don't have a value...
> > > > > > The original intention was to make the display of the
> > > > > > printed content in
> > > > > > '__bch2_inode_unpacked_to_text ()' consistent, without
> > > > > > considering other
> > > > > > callbacks.
> > > > > > 
> > > > > > Or just modify it in the following way?
> > > > > 
> > > > > Yeah, that's better
> > > > > 
> > > > > Do it off my master branch though, there's some printbuf
> > > > > imprevements in
> > > > > there.
> > > > > 
> > > > > https://evilpiepirate.org/git/bcachefs.git
> > I will make the following changes based on the master branch,
> > 
> > --- a/fs/bcachefs/inode.c
> > 
> > +++ b/fs/bcachefs/inode.c
> > @@ -534,12 +534,13 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct
> > bkey_s_c k,
> >   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
> >                                            struct bch_inode_unpacked
> > *inode)
> >   {
> > +       prt_printf(out, "\n");
> >          printbuf_indent_add(out, 2);
> >          prt_printf(out, "mode=%o\n", inode->bi_mode);
> > 
> >          prt_str(out, "flags=");
> >          prt_bitflags(out, bch2_inode_flag_strs, inode->bi_flags & ((1U
> > << 20) - 1));
> > -       prt_printf(out, " (%x)\n", inode->bi_flags);
> > +       prt_printf(out, "(%x)\n", inode->bi_flags);
> I think it's ok. Maybe use prt_newline(out) is better than prt_printf(out,
> "\n");

prt_printf("\n") is the same as prt_newline() now

