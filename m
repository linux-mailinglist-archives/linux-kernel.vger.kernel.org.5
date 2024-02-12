Return-Path: <linux-kernel+bounces-62337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1D851EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE761C224D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477661EB3F;
	Mon, 12 Feb 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbTxPzGp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE22AA48;
	Mon, 12 Feb 2024 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769992; cv=none; b=C7qa7LgHhTEOvSSmNJVFJHXOWjMYWBZFpJxdkRr4yZDRRiHMtNNY+ozxindsTD/A1d+m7rnBi4jN4+LiaaCiLdsczFM2yveAgi7ZYoG56VcKADn5XADDrQYPCi7l1nIXBfYsqLBtJSv+O06GskyCUkTTPBF+QRHz/NG9nWg8664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769992; c=relaxed/simple;
	bh=nJUt4pHJ8BpD1u4EJKsxi9gTeO8e+eSF+KEnrBvsl7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDbJ8ApbmC75cnIfLBkkhHat1GHKUNkUM6ZwG6UZTh9rifMsjEtwz+yTX2tjxBYRdmeUw7JWiIRXi7Z9JvZWOlnURhyXByvCcs9ycRcrKyJRFMzQXgzOjp6GyLpxmtNkcOwSbVE8MTwY8br2oeItEpCym4cjxo+BJVWNAlTBSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tbTxPzGp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cB5uI6Uc3sHMEabW/GpnBNsAvTUG2EhVDqN17ZdYZDk=; b=tbTxPzGpCT6Xm4uWLt66esQI+h
	mFce4aLnEh2/erOnvVwfiyz28Tt5b8YTC9hta3yy3mpw+VlZX7SeOtCnjtQGqbt21zyOYI3d6eM1g
	TqGC7/P0Vb7wlEx92mv6xOWHIvJcvUfxdMZ9agb+gAXj5sKS1RAZF6z6kDCnjlnmapjPNIEuM2MVK
	m1tG/nk2OhaXrY1wDOyvWt5C1yA2zmVsBG12NNF8mxA+C0P65GVL4JZVaxpPQByQ4HBL+y6E4CgMZ
	cfR28tIH/X+8JnzCm4Pglev3Fl1GhAkjI7Mr5OYxjufZ64N3LohcZfrB1aw9stQ3lPxURYNR+Uhdi
	9+Zaziew==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZczF-00000006sNd-18m4;
	Mon, 12 Feb 2024 20:33:09 +0000
Message-ID: <ea0554f6-e0f6-44eb-b98a-d25772273f6e@infradead.org>
Date: Mon, 12 Feb 2024 12:33:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 12 (drivers/md/dm-vdo/thread-registry.c
 on arch/loongarch/)
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:LOONGARCH" <loongarch@lists.linux.dev>,
 Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 dm-devel@lists.linux.dev, Matthew Sakai <msakai@redhat.com>
References: <20240212153137.2c37f7e6@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240212153137.2c37f7e6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/24 20:31, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20240209:
> 
> The mm tree lost its boot failure.

on loongarch:

./drivers/md/dm-vdo/thread-registry.c: In function 'vdo_register_thread':
./drivers/md/dm-vdo/thread-registry.c:32:28: error: 'current' undeclared (first use in this function)
   32 |         new_thread->task = current;
      |                            ^~~~~~~
./drivers/md/dm-vdo/thread-registry.c:32:28: note: each undeclared identifier is reported only once for each function it appears in
./drivers/md/dm-vdo/thread-registry.c: In function 'vdo_unregister_thread':
./drivers/md/dm-vdo/thread-registry.c:61:37: error: 'current' undeclared (first use in this function)
   61 |                 if (thread->task == current) {
      |                                     ^~~~~~~
./drivers/md/dm-vdo/thread-registry.c: In function 'vdo_lookup_thread':
./drivers/md/dm-vdo/thread-registry.c:84:37: error: 'current' undeclared (first use in this function)
   84 |                 if (thread->task == current) {
      |                                     ^~~~~~~


-- 
#Randy

