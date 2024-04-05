Return-Path: <linux-kernel+bounces-132853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ACE899B39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF6C1C21734
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31F16ABCB;
	Fri,  5 Apr 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvRX6z1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C341474DC;
	Fri,  5 Apr 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314325; cv=none; b=SYezc8WNIbBfjLhmaLPXth4xE+e/a/Nygln5rwBGYQSgWUhdMhhkvFQe8t200QOstuwPNDq3lveZia15xvpvDYWg3ubsA4u2uTYOh3RmjQUpV8w5nNcKpyXvXr25GO3J3ax5AFzwq23Hb7hlvqyCmqeZigfX4nJX+HO9cZzNH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314325; c=relaxed/simple;
	bh=6GlKa0PtLhQxqznFhdR0KXcsok5p35MLbSAayf4Juc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxV8quDJ4vGI1pNChhr6soS/QfJjFeYJdVohF0AcvpSQQm6s2qkKSSBH4Lr4jt03w0Ccz7pk3zSBz4JZQeZJSjlGsGd/3TtC1yZ/ilA467hts0JCFnIVPH8v1MG0NDlwNK73HDcOyWJcCg/ARMQ0xt+8nJfzkrKM3TT+eVjifRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvRX6z1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02186C433F1;
	Fri,  5 Apr 2024 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314324;
	bh=6GlKa0PtLhQxqznFhdR0KXcsok5p35MLbSAayf4Juc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvRX6z1SHwuNZbS9gXBSbpXbYObR87C40AVwcikDDdN3+bHg5D3wDTpWdDVXbR2l7
	 /uYnYH/zZRll3S3Czp8jQk2wMSP1jhfOV5igywFym8UFPBI78onmOXo4g/1Z7Rz8u3
	 ORgrQjGFAOnM+vicjXtL0JBKgPodWJwBTxpWYi2xnBmcjJrnCZCLQyP9/FKVJ5gNHI
	 pL9evIFBJg4KEHh0sFScc3OEwfmKByie6aPt3XQC/eWONMGdv2iMh3+UIt5X1Kn3/x
	 hw158spuTkIIU+arMnsJzLTrWAZl8V7rs5qCw6W4Fp1dR0Ra670lVSPDGvrAm/47Pr
	 bjA7F7YDy10oA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs, cachefiles: include linux/bio.h for BIO_MAX_VECS
Date: Fri,  5 Apr 2024 12:51:56 +0200
Message-ID: <20240405-gelaufen-biomedizin-3ff794466b8b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404123414.2675384-1-arnd@kernel.org>
References: <20240404123414.2675384-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=brauner@kernel.org; h=from:subject:message-id; bh=6GlKa0PtLhQxqznFhdR0KXcsok5p35MLbSAayf4Juc8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTxXz87QX7P/ALLuWtK06e+/efVFM+wVu/E7LCL/l5K/ eGnWDQTO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbieIyRYSL/erlEkb7X+SlP 14XNOv1/lbtB5oonS78Hp8/dN3s7gwcjw92CTTOcN58Nu77shIaJynlLJe0wpZ9xb8qyHu0xnFX IxQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 14:34:06 +0200, Arnd Bergmann wrote:
> The newly added code causes a build failure without this in some configurations:
> 
> fs/cachefiles/io.c: In function 'cachefiles_prepare_write_subreq':
> fs/cachefiles/io.c:633:31: error: 'BIO_MAX_VECS' undeclared (first use in this function); did you mean 'BIO_MAX_SECTORS'?
>   633 |         subreq->max_nr_segs = BIO_MAX_VECS;
>       |                               ^~~~~~~~~~~~
>       |                               BIO_MAX_SECTORS
> fs/cachefiles/io.c:633:31: note: each undeclared identifier is reported only once for each function it appears in
> 
> [...]

Applied to the vfs.netfs branch of the vfs/vfs.git tree.
Patches in the vfs.netfs branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.netfs

[1/1] netfs, cachefiles: include linux/bio.h for BIO_MAX_VECS
      https://git.kernel.org/vfs/vfs/c/d1e3ad45a29e

