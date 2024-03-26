Return-Path: <linux-kernel+bounces-118401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF5688BA54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC871F2CF63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6A12DDA4;
	Tue, 26 Mar 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OulhAaXF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E412B17A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433921; cv=none; b=QWsfRQ0bSqr3teIJyAun3E287EtaQgSsmQgeU3svL8uAGRbttAtNbS3hzB4UpbEOi8VJef+OyCQqyx+6FVeAdT8QvRQAwtEWN4+bw8R2QvGF2TSemFu12ZyTI9Q6GvEk0FKBPuvBvHqKzcmSq7EVjRJIBnlrlL5ylvLzVlj6eSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433921; c=relaxed/simple;
	bh=20SMIDLNszlVzxVf+DUT9GZu3oMP/FksgjEbZSI1CIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbEvcs19nLlUN42Ou687xB03Bh1DhdljjkbiFApbjTUjFEHCJhVVKd1V/l8yIKJvcZtWjdGEFM35hRFzObLFZBSNJn6up4P7pKPMbM0qLJ+LyUnuT49591J2CNMAZDvCh0wMu7qD7PMmSmWiHHiDR9vMCZJx05xOqCmJ/r7hY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OulhAaXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF18C433C7;
	Tue, 26 Mar 2024 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711433921;
	bh=20SMIDLNszlVzxVf+DUT9GZu3oMP/FksgjEbZSI1CIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OulhAaXFJkebcE/8sVZOC/PnYaxoIt62k9ndJICWXDKZiu5dRnr3Ql3YISGgMrQgf
	 7nnJsKXYnXaTiM1YdU13eG+s0NUwnQAWSDsme+8KoKP3DYq/uSBNyihN3l9qIqsz86
	 W1wu9fZF5ScOo20P9E/XUTFKmXugQ8KMelS6ZfFOgXQ9qJkB2pR+bwRUV1rN+2SrVe
	 j3O7B9M3bWWTqmf3PEuldAT2nV+LKV1eTzoLFq0Py2IdFOhD7migDkHNKco/ERsV8+
	 VC4OgsPqKhTn/H1NwbB1YqCqSnECxNv/D7iKjv3sb1OWpbyTrU99gK0hdqGm8pqrA5
	 zdIiDi+k8A/Vg==
Date: Tue, 26 Mar 2024 08:17:59 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v1 2/3] selftests/memfd_secret: add vmsplice() test
Message-ID: <ZgJol_hwpoTwaibB@kernel.org>
References: <20240325134114.257544-1-david@redhat.com>
 <20240325134114.257544-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325134114.257544-3-david@redhat.com>

Hi David,

On Mon, Mar 25, 2024 at 02:41:13PM +0100, David Hildenbrand wrote:
> Let's add a simple reproducer for a scneario where GUP-fast could succeed
> on secretmem folios, making vmsplice() succeed instead of failing. The
> reproducer is based on a reproducer [1] by Miklos Szeredi.
> 
> Perform the ftruncate() only once, and check the return value.
> 
> For some reason, vmsplice() reliably fails (making the test succeed) when
> we move the test_vmsplice() call after test_process_vm_read() /
> test_ptrace().

That's because ftruncate() call was in test_remote_access() and you need it
to mmap secretmem.

> Properly cleaning up in test_remote_access(), which is not
> part of this change, won't change that behavior. Therefore, run the
> vmsplice() test for now first -- something is a bit off once we involve
> fork().
> 
> [1] https://lkml.kernel.org/r/CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tools/testing/selftests/mm/memfd_secret.c | 44 +++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> index 9b298f6a04b3..0acbdcf8230e 100644
> --- a/tools/testing/selftests/mm/memfd_secret.c
> +++ b/tools/testing/selftests/mm/memfd_secret.c
> @@ -20,6 +20,7 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <stdio.h>
> +#include <fcntl.h>
>  
>  #include "../kselftest.h"
>  
> @@ -83,6 +84,43 @@ static void test_mlock_limit(int fd)
>  	pass("mlock limit is respected\n");
>  }
>  
> +static void test_vmsplice(int fd)
> +{
> +	ssize_t transferred;
> +	struct iovec iov;
> +	int pipefd[2];
> +	char *mem;
> +
> +	if (pipe(pipefd)) {
> +		fail("pipe failed: %s\n", strerror(errno));
> +		return;
> +	}
> +
> +	mem = mmap(NULL, page_size, prot, mode, fd, 0);
> +	if (mem == MAP_FAILED) {
> +		fail("Unable to mmap secret memory\n");
> +		goto close_pipe;
> +	}
> +
> +	/*
> +	 * vmsplice() may use GUP-fast, which must also fail. Prefault the
> +	 * page table, so GUP-fast could find it.
> +	 */
> +	memset(mem, PATTERN, page_size);
> +
> +	iov.iov_base = mem;
> +	iov.iov_len = page_size;
> +	transferred = vmsplice(pipefd[1], &iov, 1, 0);
> +
> +	ksft_test_result(transferred < 0 && errno == EFAULT,
> +			 "vmsplice is blocked as expected\n");

The same message will be printed on success and on failure.

I think 

	if (transferred < 0 && errno == EFAULT)
		pass("vmsplice is blocked as expected");
	else
		fail("vmsplice: unexpected memory acccess");

is clearer than feeding different strings to ksft_test_result().

Other than that

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> +
> +	munmap(mem, page_size);
> +close_pipe:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +}

-- 
Sincerely yours,
Mike.

