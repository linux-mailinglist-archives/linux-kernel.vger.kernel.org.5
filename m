Return-Path: <linux-kernel+bounces-42006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C603383FAE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 00:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F12CB21EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 23:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9C7446DC;
	Sun, 28 Jan 2024 23:12:34 +0000 (UTC)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F664438C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706483553; cv=none; b=MuAs/WHp94hT8/E3sqizF672GHiFefPpyTDyLQ4Bd1ms70c8K51PFunQ9QZ+U15WUvaSrwT7B/bcEPJB2NOsqU4K75Qlhv+zqdWcEz1GpooBGn6BYj5rPt+TidYOyswrXXPXuUNOhdnT8jJqMdgU94PLvFquXxxnEp08KHgznT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706483553; c=relaxed/simple;
	bh=WJAAKVyPTm7H7EAi0thvSIUBdndkaUmmG3b/Vu5ZgHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX4PLrVEix92FpGAZZ/5+K7gAYXGZjAX8cNKFWGrhI8a4xwjzQhKlqH0XpEdp4mfIOY/GVYP+9Vb8xoe1o0Ff0stVVWW3G4trg0R9K5SH9z3YRW6HQaYjEsrFT6D1ly7pthCSTRfasiULFntHCgvK+U51h9MrRQRE5+3uJaHK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6869e87c8d8so11971466d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706483551; x=1707088351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD5NdHDnfxOWQObF5uD/hMjS9qKRT60jFamS6md7FkU=;
        b=Icb88R+mPYDT2lrporwyQIxDKgPAiy8OSmhxR51Bbl/Oi2nYJ4+NuSJ1FJUcP62vcR
         G5hXEQkbbSj/ufu5qku00xJipYJm9Q997Bp7csE5WxMMjMzUJKdNMxxdPNgLPHfj4IS1
         GimGTxbG/rxVG/iB94iInchKqC4FfMQAu8oRaMc/nIgFLF4yk8ebJt0Dkp0mPyZo+rri
         XvIQdtpGYP+wHlNxpavFYZqPPIgtvKRVYKMkqdx1/f4nzHOP0VmgoHi9cixppmuIx5bg
         6gZfk/jyNzr1mP/WKjRQ6BpxX4AC7hMt2WjCaAw8Hu+9b5LSrsnCHnKi62ES3pUAXsrM
         LNOA==
X-Gm-Message-State: AOJu0YwY9LgHUxFcIpPqfb0ML8FinBE8/4A07KNLBo88vZmyEzDpIddj
	vCiZxgXetfNuvg8dkrI3IcCJeEKWxgj7vZIKlN4ZwrNDNO13klbYBJ7mlPa3XA==
X-Google-Smtp-Source: AGHT+IHK0/nUNToH8edwxVlWmvEyvZIHDEpHgPaEgJjUzz7rMirW/s8is9RvU2aReauLMczsnC32Uw==
X-Received: by 2002:ad4:5aa2:0:b0:686:9f2e:d984 with SMTP id u2-20020ad45aa2000000b006869f2ed984mr5509530qvg.22.1706483550841;
        Sun, 28 Jan 2024 15:12:30 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id pg10-20020a0562144a0a00b0068690c3a04asm2816450qvb.20.2024.01.28.15.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 15:12:30 -0800 (PST)
Date: Sun, 28 Jan 2024 18:12:29 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Don Dutile <ddutile@redhat.com>,
	Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm/readahead: readahead aggressively if read drops
 in willneed range
Message-ID: <ZbbfXVg9FpWRUVDn@redhat.com>
References: <20240128142522.1524741-1-ming.lei@redhat.com>
 <ZbbPCQZdazF7s0_b@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbbPCQZdazF7s0_b@casper.infradead.org>

On Sun, Jan 28 2024 at  5:02P -0500,
Matthew Wilcox <willy@infradead.org> wrote:

> On Sun, Jan 28, 2024 at 10:25:22PM +0800, Ming Lei wrote:
> > Since commit 6d2be915e589 ("mm/readahead.c: fix readahead failure for
> > memoryless NUMA nodes and limit readahead max_pages"), ADV_WILLNEED
> > only tries to readahead 512 pages, and the remained part in the advised
> > range fallback on normal readahead.
> 
> Does the MAINTAINERS file mean nothing any more?

"Ming, please use scripts/get_maintainer.pl when submitting patches."

(I've cc'd accordingly with this email).

> > If bdi->ra_pages is set as small, readahead will perform not efficient
> > enough. Increasing read ahead may not be an option since workload may
> > have mixed random and sequential I/O.
> 
> I thik there needs to be a lot more explanation than this about what's
> going on before we jump to "And therefore this patch is the right
> answer".

The patch is "RFC". Ming didn't declare his RFC is "the right answer".
All ideas for how best to fix this issue are welcome.

I agree this patch's header could've worked harder to establish the
problem that it fixes.  But I'll now take a crack at backfilling the
regression report that motivated this patch be developed:

Linux 3.14 was the last kernel to allow madvise (MADV_WILLNEED)
allowed mmap'ing a file more optimally if read_ahead_kb < max_sectors_kb.

Ths regressed with commit 6d2be915e589 (so Linux 3.15) such that
mounting XFS on a device with read_ahead_kb=64 and max_sectors_kb=1024
and running this reproducer against a 2G file will take ~5x longer
(depending on the system's capabilities), mmap_load_test.java follows:

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.io.RandomAccessFile;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;

public class mmap_load_test {

        public static void main(String[] args) throws FileNotFoundException, IOException, InterruptedException {
		if (args.length == 0) {
			System.out.println("Please provide a file");
			System.exit(0);
		}
		FileChannel fc = new RandomAccessFile(new File(args[0]), "rw").getChannel();
		MappedByteBuffer mem = fc.map(FileChannel.MapMode.READ_ONLY, 0, fc.size());

		System.out.println("Loading the file");

		long startTime = System.currentTimeMillis();
		mem.load();
		long endTime = System.currentTimeMillis();
		System.out.println("Done! Loading took " + (endTime-startTime) + " ms");
		
	}
}

reproduce with:

javac mmap_load_test.java
echo 64 > /sys/block/sda/queue/read_ahead_kb
echo 1024 > /sys/block/sda/queue/max_sectors_kb
mkfs.xfs /dev/sda
mount /dev/sda /mnt/test
dd if=/dev/zero of=/mnt/test/2G_file bs=1024k count=2000

echo 3 > /proc/sys/vm/drop_caches
java mmap_load_test /mnt/test/2G_file

Without a fix, like the patch Ming provided, iostat will show rareq-sz
is 64 rather than ~1024.

> > @@ -972,6 +974,7 @@ struct file_ra_state {
> >  	unsigned int ra_pages;
> >  	unsigned int mmap_miss;
> >  	loff_t prev_pos;
> > +	struct maple_tree *need_mt;
> 
> No.  Embed the struct maple tree.  Don't allocate it.

Constructive feedback, thanks.

> What made you think this was the right approach?

But then you closed with an attack, rather than inform Ming and/or
others why you feel so strongly, e.g.: Best to keep memory used for
file_ra_state contiguous.

