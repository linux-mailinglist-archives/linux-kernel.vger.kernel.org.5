Return-Path: <linux-kernel+bounces-35422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC5A8390D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8A21C23A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4D5F856;
	Tue, 23 Jan 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ET9XcHdf"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69625FB97;
	Tue, 23 Jan 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018838; cv=none; b=bdeTpxT3cxCw1UbDMGxBR+nR5CBbVXmtFuuVNaNACFJI/Gddwu8sYcE1Cr1DYZHm0QVFqVw9TJNcicD/CPeb6ZdqV8bTZEPlnpb2ihZAgpACVg4Ac5z6lzMEJBcKJoUsq3ARHeeoBuploRXVvOEoENttjeYxYGWdg8HeosmW6Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018838; c=relaxed/simple;
	bh=6RJoNNyyNkOZGBK9XUj0BK5pdBgjQNyX67P0q7z7D0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKNifmeFthOFZ44KHeLOUSB7grk99k3jQZTziCfIGz339Bn/tdBrtGaiVQ1FGi851kICuaGnIsCsdxZ7CX2XF6QhTDKqFO0oQClFnej2nifjWmmUxiOMQFirESCH9qNi42A2EZ6e8WsDCKQmlPG+rK1+cj232GkUcOW7onp+5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ET9XcHdf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CNNfETQWdYH1nOOpOop9fz3v3BOTscmNNMvGgqeFLC0=; b=ET9XcHdffx3U2Yp1bOjQ4Xbx7/
	4hmkAr7wPKSuALyhH+0ZfYEFb1H+vMHJl6CothLlY4esAZmUyBDyoWSbH9IOqtTLqqbKoWr/IidQK
	JSfIN6U9Fz8Dd5dB3kZKBLxLIORtvPMjdkewBBsOkCjWlobpTJDdCxVVmgrrGrrcjSv11y62/alyV
	E2qR10Ea2vAFog7kECfa5SXbShXt7a78SvIx4+u8DCjEidQ/Yls/BNKXq/85yGSE1qfFJjAC9mqK+
	l448zcWtsSTFp9ciI7OnQH63pB6V0OITbFLpkiKCjjhqRQryPmtvjrrnODJFvvjgysnhelXIjRtUw
	/KTRn7BA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSHQf-00000003N9t-37mP;
	Tue, 23 Jan 2024 14:07:05 +0000
Date: Tue, 23 Jan 2024 14:07:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hcochran@kernelspring.com,
	mszeredi@redhat.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: remove stale comment __folio_mark_dirty
Message-ID: <Za_ICQtVMZornKvj@casper.infradead.org>
References: <20240123183332.876854-1-shikemeng@huaweicloud.com>
 <20240123183332.876854-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123183332.876854-6-shikemeng@huaweicloud.com>

On Wed, Jan 24, 2024 at 02:33:32AM +0800, Kemeng Shi wrote:
> The __folio_mark_dirty will not mark inode dirty any longer. Remove the
> stale comment of it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

