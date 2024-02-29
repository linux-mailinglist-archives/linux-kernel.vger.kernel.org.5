Return-Path: <linux-kernel+bounces-86038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AD86BED5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C75F288B19
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D9374C4;
	Thu, 29 Feb 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="24ZP7AFU"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899B36AF2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172929; cv=none; b=CpiE43b0TADGz1CjVF9YYK/pE198YTSFkYBuW7/o09FYL0cAfweuaiOCjMW1EKJNDAFS5qta2l9uUK11+BVTzevBQxyEMxvJURF0EEwiO6S7jzmqV1AppDU+EC5EoKLIh01orDk2JWfbZOWM+6CDnJEy39LnzjttV9l3ORmaIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172929; c=relaxed/simple;
	bh=gbK/8SPPoX50lcAPF/cWQzwwqAl+Hw5BLMUVJqzZZxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQNlADhtHaeT4Gk0d2IpcEioCq9BLwaUzVVmzxTAhABlxICb0T64cZy3c99Gib7iSJ1UxvOxLUy5xg9qW7++ZQPVP23LZAwcR9L9UHssBOV7q8ErKMPmkBn9plIKPEsV2JGEyAJ/vfG26In9ARTI5mOLuZg42hisMsjuahSFf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=24ZP7AFU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso310301a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709172927; x=1709777727; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k82qC/YmHMBHWFt7RMlbhQ42CGo9M2erm3qHEzqFqxc=;
        b=24ZP7AFUsGm90iTvAeh7kX7tO9QmyfmmTxt3PdS+tZHHmbYyw/Y6Z7BkmbALwmCggO
         WGjhZSqDSGUp8QMU1Utfowr5wZayAnFwJNDPV1tW/BRGLs360ohFMR17/ixmjdljd174
         nqAdGrdT66S/tlM8Dbk5UNRr7igAzRd/tzzJ7k/CKK7SLP43Uz5fNkLM4FzU6ZiA1EMJ
         mGdegBAlG7fnOqRFDIRItIVgI+BkH4hGUeXKHNbPS8cF9zw+X/bm3hiSYIQZVNdOSogp
         dmNxaHrQ6iQHm9kssQF+RRuC6hg4VG4ysZdx8IuP4lOeWnCnCu8apDtEfHnHSbAVb44u
         5rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709172927; x=1709777727;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k82qC/YmHMBHWFt7RMlbhQ42CGo9M2erm3qHEzqFqxc=;
        b=J4PxSnqL/RKmwU5KGwbm04XKnqJUT14VT6cI6/qc1PBPuK0qY6LRSVZZyzK+Opc1+9
         7Sz1di2DgJfS3bUggh4S3/HoZXLqzHbGbVyPcZfpuLSXZFVKgs67xWZpO+cu4RkyxUFB
         xmLjfrGtOjo10qbDnY9IY6SThCBPomx2GCgf9rva643obvEkiZ7cKqVI896jSGkv4gxV
         CI4sBApBPR1IY+Zr8j0QPhXGHgOVIcnvGzlub6r0cDZI1yCfK/5LmClT44GlVF66NDqo
         g1i6t7BogH9C65R5q86lmT+fYw/lLpEp+xbAeqW1LCbCJQzrTgNh10p3EfDqnYm+khKJ
         /E1w==
X-Forwarded-Encrypted: i=1; AJvYcCV2P7knsrbvgaQS2RO/rB38n3N8BR1052WJmT5s5hh7frgYDuGtXrGBFNHKWO0Ya1afxiOnzFCICW0mKGldeNbIaz6a2SaoaKAwoBz8
X-Gm-Message-State: AOJu0Yyy3NU338q1HKZrKdsHkmAawv1R3CA5SJGjwCEmNIL0fuNG0Lvf
	fb0MchpY6mV+K6YgTK5sOHsexVjzWwJtdVnWlQYH/plCJG1V1v40wLygvTY2e/0=
X-Google-Smtp-Source: AGHT+IHlcUbGYgKkh9AJe9B6cyxTd0bn96C+Tels4WsobRn2K0DWuGc5NbJJ2I2uCc8hPOOH897Pnw==
X-Received: by 2002:a05:6a21:1789:b0:1a1:2094:960b with SMTP id nx9-20020a056a21178900b001a12094960bmr1024668pzb.43.1709172927291;
        Wed, 28 Feb 2024 18:15:27 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709026f1000b001dc90b62393sm141163plk.216.2024.02.28.18.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:15:26 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rfVxE-00Cupu-1S;
	Thu, 29 Feb 2024 13:15:24 +1100
Date: Thu, 29 Feb 2024 13:15:24 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Groves <John@groves.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	john@jagalactic.com, Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <Zd/ovHqO/16PsUsp@dread.disaster.area>
References: <cover.1708709155.git.john@groves.net>
 <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
 <cc2pabb3szzpm5jxxeku276csqu5vwqgzitkwevfluagx7akiv@h45faer5zpru>
 <Zdy0CGL6e0ri8LiC@bombadil.infradead.org>
 <w5cqtmdgqtjvbnrg5okdgmxe45vjg5evaxh6gg3gs6kwfqmn5p@wgakpqcumrbt>
 <CAB=NE6UvHSvTJJCq-YuBEZNo8F5Kg25aK+2im=V7DgEsTJ8wPg@mail.gmail.com>
 <mw4yhbmza4idassgbqeiti4ue7jq377ezxfrqrcbsbzsrmfiln@kn7qmqljvswl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mw4yhbmza4idassgbqeiti4ue7jq377ezxfrqrcbsbzsrmfiln@kn7qmqljvswl>

On Mon, Feb 26, 2024 at 08:05:58PM -0600, John Groves wrote:
> On 24/02/26 04:58PM, Luis Chamberlain wrote:
> > On Mon, Feb 26, 2024 at 1:16 PM John Groves <John@groves.net> wrote:
> > >
> > > On 24/02/26 07:53AM, Luis Chamberlain wrote:
> > > > On Mon, Feb 26, 2024 at 07:27:18AM -0600, John Groves wrote:
> > > > > Run status group 0 (all jobs):
> > > > >   WRITE: bw=29.6GiB/s (31.8GB/s), 29.6GiB/s-29.6GiB/s (31.8GB/s-31.8GB/s), io=44.7GiB (48.0GB), run=1511-1511msec
> > > >
> > > > > This is run on an xfs file system on a SATA ssd.
> > > >
> > > > To compare more closer apples to apples, wouldn't it make more sense
> > > > to try this with XFS on pmem (with fio -direct=1)?
> > > >
> > > >   Luis
> > >
> > > Makes sense. Here is the same command line I used with xfs before, but
> > > now it's on /dev/pmem0 (the same 128G, but converted from devdax to pmem
> > > because xfs requires that.
> > >
> > > fio -name=ten-256m-per-thread --nrfiles=10 -bs=2M --group_reporting=1 --alloc-size=1048576 --filesize=256MiB --readwrite=write --fallocate=none --numjobs=48 --create_on_open=0 --ioengine=io_uring --direct=1 --directory=/mnt/xfs
> > 
> > Could you try with mkfs.xfs -d agcount=1024

Won't change anything for the better, may make things worse.

>    bw (  MiB/s): min= 5085, max=27367, per=100.00%, avg=14361.95, stdev=165.61, samples=719
>    iops        : min= 2516, max=13670, avg=7160.17, stdev=82.88, samples=719
>   lat (usec)   : 4=0.05%, 10=0.72%, 20=2.23%, 50=2.48%, 100=3.02%
>   lat (usec)   : 250=1.54%, 500=2.37%, 750=1.34%, 1000=0.75%
>   lat (msec)   : 2=3.20%, 4=43.10%, 10=23.05%, 20=14.81%, 50=1.25%

Most of the IO latencies are up round the 4-20ms marks. That seems
kinda high for a 2MB IO. With a memcpy speed of 10GB/s, the 2MB
should only take a couple of hundred microseconds. For Famfs, the
latencies appear to be around 1-4ms.

So where's all that extra time coming from?


>   lat (msec)   : 100=0.08%
>   cpu          : usr=10.18%, sys=0.79%, ctx=67227, majf=0, minf=38511

And why is system time reporting at almost zero instead of almost
all the remaining cpu time (i.e. up at 80-90%)?

Can you run call-graph kernel profiles for XFS and famfs whilst
running this workload so we have some insight into what is behaving
differently here?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

