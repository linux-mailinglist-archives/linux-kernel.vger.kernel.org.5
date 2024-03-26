Return-Path: <linux-kernel+bounces-119245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278D88C616
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6479305FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01C13C680;
	Tue, 26 Mar 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSwP/DAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003E1E484
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465224; cv=none; b=C+TVWwUk/DjOrgOap936twiZImbybamCHqZUv3flSIe6YLU4LIxrF/YqeZYfOaojQ2SB9uc9KsMItNK2r3cL2kdmcY1kEybFROISuP/cuQ4b9gV3oze1O5I07Gdli2D+pwr74OuJJvkwaGt/Pa9pxaplc+M3KD41Qk0sDfwVUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465224; c=relaxed/simple;
	bh=NWbxOEw32c7m5KBW5C04/sGYmqDjmEadCfWD+rXLsWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svsfI8XzHYOYRA2CqZq6xV7bk0T+kWGug921DzzVIVFNuRkEue2AVFAjYXD7cfW3QWw04sH6vNaKsD0Ial8DmWt1+9Vz5O6p1Z360YvRbGDOLUx0CuVCZxkkGuW/nBVcmxARYS7s+R9BeVYKaqEVj5CZmxb68PLjuxndBHSeuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSwP/DAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E4C433F1;
	Tue, 26 Mar 2024 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465223;
	bh=NWbxOEw32c7m5KBW5C04/sGYmqDjmEadCfWD+rXLsWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSwP/DAXV65DXTPyu4DbSIjzfFmKFpOQ0ooVrMNJi02COJmchgWbkoRqO1hQJ803e
	 QrnnsdUpuSkja32LkDerY8/sLzLZ493JVtC0tBeQu6zQAnVNlf8Hx9ykRk0yIR5qAJ
	 WIdRAsB1/Qy663eah3ER78mIx5trYRcqPku/s3bMM6DnlDrP6FuTJzu2mrlUWByVrp
	 fMGk/+EsXqyS/GoIVZzkrRk+9LI2bhhp5YF/vjwmIw2WRPgGGUMzIc1FDdxJ52NJbT
	 C9NVQpnpQ8cdjnc0B6kh2mKR8pQUtUaagv2sfM+FZh0KH6LRGGGug36xtvMUWA8L+M
	 KZeXT9xvKSBSw==
Date: Tue, 26 Mar 2024 16:59:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCH v2 2/3] selftests/memfd_secret: add vmsplice() test
Message-ID: <ZgLi3aFcpH8Q-ZPr@kernel.org>
References: <20240326143210.291116-1-david@redhat.com>
 <20240326143210.291116-3-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326143210.291116-3-david@redhat.com>

On Tue, Mar 26, 2024 at 03:32:09PM +0100, David Hildenbrand wrote:
> Let's add a simple reproducer for a scenario where GUP-fast could succeed
> on secretmem folios, making vmsplice() succeed instead of failing. The
> reproducer is based on a reproducer [1] by Miklos Szeredi.
> 
> We want to perform two tests: vmsplice() when a fresh page was just
> faulted in, and vmsplice() on an existing page after munmap() that
> would drain certain LRU caches/batches in the kernel.
> 
> In an ideal world, we could use fallocate(FALLOC_FL_PUNCH_HOLE) /
> MADV_REMOVE to remove any existing page. As that is currently not
> possible, run the test before any other tests that would allocate memory
> in the secretmem fd.
> 
> Perform the ftruncate() only once, and check the return value.
> 
> [1] https://lkml.kernel.org/r/CAJfpegt3UCsMmxd0taOY11Uaw5U=eS1fE5dn0wZX3HF0oy8-oQ@mail.gmail.com
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/memfd_secret.c | 51 ++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
> index 9b298f6a04b3..9a0597310a76 100644
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
> @@ -83,6 +84,45 @@ static void test_mlock_limit(int fd)
>  	pass("mlock limit is respected\n");
>  }
>  
> +static void test_vmsplice(int fd, const char *desc)
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
> +	if (transferred < 0 && errno == EFAULT)
> +		pass("vmsplice is blocked as expected with %s\n", desc);
> +	else
> +		fail("vmsplice: unexpected memory access with %s\n", desc);
> +
> +	munmap(mem, page_size);
> +close_pipe:
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +}
> +
>  static void try_process_vm_read(int fd, int pipefd[2])
>  {
>  	struct iovec liov, riov;
> @@ -187,7 +227,6 @@ static void test_remote_access(int fd, const char *name,
>  		return;
>  	}
>  
> -	ftruncate(fd, page_size);
>  	memset(mem, PATTERN, page_size);
>  
>  	if (write(pipefd[1], &mem, sizeof(mem)) < 0) {
> @@ -258,7 +297,7 @@ static void prepare(void)
>  				   strerror(errno));
>  }
>  
> -#define NUM_TESTS 4
> +#define NUM_TESTS 6
>  
>  int main(int argc, char *argv[])
>  {
> @@ -277,9 +316,17 @@ int main(int argc, char *argv[])
>  			ksft_exit_fail_msg("memfd_secret failed: %s\n",
>  					   strerror(errno));
>  	}
> +	if (ftruncate(fd, page_size))
> +		ksft_exit_fail_msg("ftruncate failed: %s\n", strerror(errno));
>  
>  	test_mlock_limit(fd);
>  	test_file_apis(fd);
> +	/*
> +	 * We have to run the first vmsplice test before any secretmem page was
> +	 * allocated for this fd.
> +	 */
> +	test_vmsplice(fd, "fresh page");
> +	test_vmsplice(fd, "existing page");
>  	test_process_vm_read(fd);
>  	test_ptrace(fd);
>  
> -- 
> 2.43.2
> 

-- 
Sincerely yours,
Mike.

