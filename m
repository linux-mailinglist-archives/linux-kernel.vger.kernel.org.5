Return-Path: <linux-kernel+bounces-77206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8113860202
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1C71C22BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A56814B802;
	Thu, 22 Feb 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+c3YJCb"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBEE14B804;
	Thu, 22 Feb 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708628057; cv=none; b=Ibn7VSaFkesswjiaLvW9hOuyTVqYSTPNe3BhoWwnrbdls40iOjJWCghH9w44sJBplXpg7TLoQF6ldDgF0+ZZ6hQRQsC/Wd55V0Sjql+g2Z+uzolrAHbIh1OORnJdDbw/MJ8rfs2CQGQLFVNuEnh97cPfim+wM/BzMGJFKwyaBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708628057; c=relaxed/simple;
	bh=3zj4OeqfC9Vz0LSSduV4z3l+Q1B/BDb5ITpcdgmvoGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olf/zudvw1gZSKZZRqfP4XZUooFuatJSe08eAOqwy6Dc3+0J+fxV6n3O2R4tNlcFN6w2JNQqTnpRAz148CD+BsrOmCrwIOnSoqMou+0EJy/FGzRE6IlgplkwgcHgHfc9i5mMrwz1cSlQqayP7elkX7T7918OC5f7npgDfxBkxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+c3YJCb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d6bd39470so21382f8f.3;
        Thu, 22 Feb 2024 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708628054; x=1709232854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUveRwg7p1Ajr3BNGaCAfvh6euWerQ4mOYsRYfUynZc=;
        b=l+c3YJCbx0Um0mxitmBJuH09LlNz7CAbU9I/LHbs0hcnSEIQfJxOdSwjQuA+OEuGd7
         zwCoErJlrZlp6tMU3pF+nbm/LE4335y6POPsWoJsfIxaKpJIa3KroYne80GPo0BpXnWP
         b60XBdd4fj78XRICxXAeayhUsiQiApRFRvndY9yzqLagFVEYASatFTSItnVRB20e9gFH
         cThKl/TK56ihmQQt0GN7iOeHdDBKx5XmLXSl9E+G/3RQt5uLU+UJ2u91fHKDXxiaLJ60
         vosKzYyAG6Y1DXI+NKo6LXnz6VLpN2XXnTfKHtRYc8TlDTANsH7E5TVbCC99u3NfOyVv
         F1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708628054; x=1709232854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUveRwg7p1Ajr3BNGaCAfvh6euWerQ4mOYsRYfUynZc=;
        b=TFy/UshQAU2Svn9d//eAZpfQCUs/DOCMOcMXKbk2J9Lcv3nl8DUs9KZcSCWi/02Vs8
         bnNJGIJhJWaLYJe+BDukUXfcNDChBwyhKAKsx/Cz8I23XZ1ruRzYxKvfdrB8wWSuZNG4
         2m7adUHNEPv5zzoe2nXvheE9EqreiAAlZTHY/Ly6nwhO++O8fW7/H2+NtaellLoMYD54
         uEI2GN0K/gWJJWosBX0fmKd9/ePqWZO6uv5Lqrd8PXszutzfMT+OembMn4rUnbv5/dhC
         JdHHUkVawKXmuRkU0go2Gxv91HBhwqQaDQXdpmIvtGpjOLMVtztMMLGShrRFwQJ2odLn
         9ZqA==
X-Forwarded-Encrypted: i=1; AJvYcCW9oPqESzR/H89QVXSvwH+GW5zUnR8eRyY0gUjRPMAxKmf4P4mTP9ebA41znQC5uxdTBJ3wz7QjQod4E53lg16dPSLUvw6HhZd4+R1zffmQMjj5bzZcv8p86CxZpHlrx5BGTuZi
X-Gm-Message-State: AOJu0YycGMKAwJqOAiVvrrcto8FCJ58A/mSZAlH5I1QWdATCe5F5sRgq
	LNqP/YHSkVFVQgYHjQN5JiqBnvqQGraW3uFDEGXYpl5p9x04PX/p
X-Google-Smtp-Source: AGHT+IE9WmNFgdG/1L1kexwdly0Wru10Q7ftPEjrThRsR3vLWcN21sNvlNn+IdKJATom/w3SZKD9Xg==
X-Received: by 2002:a05:6000:809:b0:33d:1656:2204 with SMTP id bt9-20020a056000080900b0033d16562204mr19886534wrb.53.1708628053705;
        Thu, 22 Feb 2024 10:54:13 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600003c100b0033d81d9c44esm5995447wrg.70.2024.02.22.10.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 10:54:12 -0800 (PST)
Date: Thu, 22 Feb 2024 18:51:58 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Message-ID: <f6910deb-9903-4a3b-bcf8-401fd9b04bf8@lucifer.local>
References: <20240222165549.32753-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222165549.32753-2-vbabka@suse.cz>

On Thu, Feb 22, 2024 at 05:55:50PM +0100, Vlastimil Babka wrote:
> When debugging issues with a workload using SysV shmem, Michal Hocko has
> come up with a reproducer that shows how a series of mprotect()
> operations can result in an elevated shm_nattch and thus leak of the
> resource.
>
> The problem is caused by wrong assumptions in vma_merge() commit
> 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
> mergeability test"). The shmem vmas have a vma_ops->close callback
> that decrements shm_nattch, and we remove the vma without calling it.
>
> vma_merge() has thus historically avoided merging vma's with
> vma_ops->close and commit 714965ca8252 was supposed to keep it that way.
> It relaxed the checks for vma_ops->close in can_vma_merge_after()
> assuming that it is never called on a vma that would be a candidate for
> removal. However, the vma_merge() code does also use the result of this
> check in the decision to remove a different vma in the merge case 7.
>
> A robust solution would be to refactor vma_merge() code in a way that
> the vma_ops->close check is only done for vma's that are actually going
> to be removed, and not as part of the preliminary checks. That would
> both solve the existing bug, and also allow additional merges that the
> checks currently prevent unnecessarily in some cases.

Let's do that pretty soon :) this is a bit of an ugly fix but
understandable to do it in this form to make it easier to backport (+
perhaps generate some CVEs? :)

>
> However to fix the existing bug first with a minimized risk, and for
> easier stable backports, this patch only adds a vma_ops->close check to
> the buggy case 7 specifically. All other cases of vma removal are
> covered by the can_vma_merge_before() check that includes the test for
> vma_ops->close.

I concur, all the other cases require merge_next which would have invoked
can_vma_merge_before() that calls is_mergeable_vma() with may_remove_vma
set to true hence performs the close check.

>
> The reproducer code, adapted from Michal Hocko's code:
>
> int main(int argc, char *argv[]) {
>   int segment_id;
>   size_t segment_size = 20 * PAGE_SIZE;
>   char * sh_mem;
>   struct shmid_ds shmid_ds;
>
>   key_t key = 0x1234;
>   segment_id = shmget(key, segment_size,
>                       IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
>   sh_mem = (char *)shmat(segment_id, NULL, 0);
>
>   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);
>
>   mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
>
>   mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);
>
>   shmdt(sh_mem);
>
>   shmctl(segment_id, IPC_STAT, &shmid_ds);
>   printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);
>
>   if (shmctl(segment_id, IPC_RMID, 0))
>           printf("IPCRM failed %d\n", errno);
>   return (shmid_ds.shm_nattch) ? 1 : 0;
> }
>
> Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in mergeability test")
> Reported-by: Michal Hocko <mhocko@suse.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/mmap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d89770eaab6b..a4238373ee9b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -954,10 +954,19 @@ static struct vm_area_struct
>  	} else if (merge_prev) {			/* case 2 */
>  		if (curr) {
>  			vma_start_write(curr);
> -			err = dup_anon_vma(prev, curr, &anon_dup);
>  			if (end == curr->vm_end) {	/* case 7 */
> +				/*
> +				 * can_vma_merge_after() assumed we would not be
> +				 * removing prev vma, so it skipped the check
> +				 * for vm_ops->close, but we are removing curr
> +				 */
> +				if (curr->vm_ops && curr->vm_ops->close)
> +					err = -EINVAL;
> +				else
> +					err = dup_anon_vma(prev, curr, &anon_dup);
>  				remove = curr;
>  			} else {			/* case 5 */
> +				err = dup_anon_vma(prev, curr, &anon_dup);

This (ironically) duplicates code, could we pull this out of the if/else
and put it afterwards like:

	if (!err)
		err = dup_anon_vma(prev, curr, &anon_dup);

>  				adjust = curr;
>  				adj_start = (end - curr->vm_start);
>  			}
> --
> 2.43.1
>

