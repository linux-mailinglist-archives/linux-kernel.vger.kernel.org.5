Return-Path: <linux-kernel+bounces-19916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0F8276A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB9F1C21513
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E9755E59;
	Mon,  8 Jan 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="qCceLeGd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840D55C02;
	Mon,  8 Jan 2024 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4T81jG5dJHz9scW;
	Mon,  8 Jan 2024 18:47:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1704736034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvM31lHrbY0IYTP66VwCdFD5764FawK2e4zToIrza1E=;
	b=qCceLeGdiZhgaizFv5Xsp1MaepPiryhwzoz+gwItMof9jkuiDwXJ02ggjwpSy+hTDSXhiL
	HpRG/Iig99jjZQLa/xdK+Dz1Ikz/0SG72FBry6lWBnnyacNxLRZsObkmOWVZRVpdj4dii9
	kbS7v1sRPZEZjgojfnH46yY5kya/jNLKn7cTrgDlze3/DwcpKO9xoIthHoFLL/eTkJpR2b
	zYyHGVJPSE4Yf0FzHeEhZ5DPxfOO78Xc8jNf3u6M9D6LTBzzYJj5gHPGWgKZ/M5VMyOReG
	hnn6rTwyR0+xfGL9AaC/yBpbabgpd6w/SL2sTm50Sd1Emt9bLLQlZocpvPQh2g==
Date: Mon, 8 Jan 2024 18:47:11 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <20240108174711.3woihy7ho47bckng@localhost>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
 <20240108133117.xtkbzeiqq6dtesm5@localhost>
 <ZZv6Dgsmjnr48BMQ@casper.infradead.org>
 <ZZwjlYY+LxuWINHm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZwjlYY+LxuWINHm@casper.infradead.org>
X-Rspamd-Queue-Id: 4T81jG5dJHz9scW

> Actually, how about:
> 
>  * If the folio has buffers, the uptodate buffers are set dirty, to
>  * preserve dirty-state coherency between the folio and the buffers.
>  * Buffers added to a dirty folio are created dirty.

This looks good to me :)

> 
> I considered deleting the sentence entirely as it's not actually related
> to what the function does; it's just a note about how the buffer cache
> behaves.  That said, information about how buffer heds work is scant
> enough that I don't want to delete it.

