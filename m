Return-Path: <linux-kernel+bounces-77446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08205860569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D27E1F24869
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFC912D1FE;
	Thu, 22 Feb 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQrkE2pU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1A912D1EC;
	Thu, 22 Feb 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639630; cv=none; b=SjMqrw0qQTnsbc3nPK1vgGE20E/Y31ObNHUGPxrftlUHbiyTnyio+XomykfXPIvzJo1Avz1fwOZHI06zAilN0ysmYLo3qJdZIK+1UVWkQsZwDBIEmOHh1r0M5g8hBxoR5HL9CrrOJHZY6lwOvA4IqBQLLFMq3G2ID3OyNcdpUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639630; c=relaxed/simple;
	bh=Jj7+pmu+kgGbQkhHoVgKs05d4OY3Rsuej9zneaZfX9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SODfz4Hm6lZSiwemyU9LfG7M9eHnDls0b/w48Atp2wZmOzhEgxbyiVhDaQ4PPP55QovsZq67OWM32ZA7kdNpJqa3genGetDgjAMy2FzTzte7G1ttYRJ98B7T+MNLQtl4DQpOzfGWf3A/ne+LFVdCh4HsmTrafSkjS39Ify/kFRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQrkE2pU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33adec41b55so144060f8f.0;
        Thu, 22 Feb 2024 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708639627; x=1709244427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xO2+giGNpQMfCaj0W7NZUwdaHnujksHyJgZqAdjT78=;
        b=JQrkE2pUj11TZN/etK0eOmyLD3HQ7na/Cx2Fcz67t53zKpBSrn9nm+gjVK/xLqxOdU
         olcyjWHh3ER/iAPEFlJ4wvAdVfBG0owDPGbygoBZwoBZxgYxchqOcYc5Ce8s9ahQIBO3
         WIj4N8hveaHObBeVB7hLXKNixHE7CuJZs/RgYJMXrHD+tluc4f1Vjoxte5id3MjUPgM7
         wddkGSMiW/FkK1ws0Qi+6Jdym/YmX16kHkaPB9UxMbbB44SigGaBsOpt/X1X8bS3my/I
         QSc6q5r04xL/7UsVo4TjT4heuAuGG8bOVRAk3rktGYI3W4mG62wzI/RqhjNmrea6VtVk
         NXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708639627; x=1709244427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xO2+giGNpQMfCaj0W7NZUwdaHnujksHyJgZqAdjT78=;
        b=V3RWGGyk8E0bYmdfiAPscTKXMU6xEoRq/zD/w33oYm0X2AHGyWo27FO2K1R5Cvkuhm
         n1c4Uf0OY5vaGcgauohlYp/NNd53dMn7FZqYO6OnxX3GSdcGkGMGHlbOKiT4rs34kyWP
         VUmpT1Vxryken4ttc3kMOvx4vup/tm8lJEdNSqZ7ImqI4WMtI7OqYlmFQe0mio2iV0q0
         w5u8AXjVkbAolhMU4KYENpPQ0mzLpgB9HIRROyeeZxofFyu2aH2ZQ9ZXK1vT8Mn9uXZY
         boILNRSZsu12tUwrwAonuXfvMgFO42ZmMLGCjfiP9qt6CMIiFy93IRiXzmXXiysboGUT
         BqMg==
X-Forwarded-Encrypted: i=1; AJvYcCXIdDV/aVXefyrR7L0rsMqU7Xc4ib5qhkAdZ9mqpV0zMzPrfx1nAtW1TTJeJ6W9cUAmHvj1Iecjg12uKtRflTFLTurnrPJIc7744ZMHGaex5SQVO3GUVtPWBikcBzWN5BZyzmS7
X-Gm-Message-State: AOJu0YwJZ2fln49MAvhWNATLAfcz66l7NMzTilstYuPWraE5iC0zxiA2
	CBbys0eb7K4VmdUEwKIGRUYr071rcguKtHz7KsiMQBrJQ8eRiQii
X-Google-Smtp-Source: AGHT+IGT5fmok8cVA7Uk0NaxAKCJUmuvQkQ5FUjnauyj6OzPFKueFjkypLIrNylHVuxYqbopszOwOA==
X-Received: by 2002:adf:ec81:0:b0:33d:73e4:9c79 with SMTP id z1-20020adfec81000000b0033d73e49c79mr228529wrn.59.1708639626512;
        Thu, 22 Feb 2024 14:07:06 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id h14-20020adfa4ce000000b0033d56aa4f45sm317637wrb.112.2024.02.22.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:07:05 -0800 (PST)
Date: Thu, 22 Feb 2024 22:04:51 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Message-ID: <8dc5c86e-f74d-4547-99c9-3bd4a0d92cde@lucifer.local>
References: <20240222215930.14637-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222215930.14637-2-vbabka@suse.cz>

On Thu, Feb 22, 2024 at 10:59:31PM +0100, Vlastimil Babka wrote:
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
>
> However to fix the existing bug first with a minimized risk, and for
> easier stable backports, this patch only adds a vma_ops->close check to
> the buggy case 7 specifically. All other cases of vma removal are
> covered by the can_vma_merge_before() check that includes the test for
> vma_ops->close.
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
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
> v2: deduplicate code, per Lorenzo
>  mm/mmap.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d89770eaab6b..3281287771c9 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -954,13 +954,21 @@ static struct vm_area_struct
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
>  				remove = curr;
>  			} else {			/* case 5 */
>  				adjust = curr;
>  				adj_start = (end - curr->vm_start);
>  			}
> +			if (!err)
> +				err = dup_anon_vma(prev, curr, &anon_dup);
>  		}
>  	} else { /* merge_next */
>  		vma_start_write(next);
> --
> 2.43.1
>

Looks good to me, feel free to add:

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

