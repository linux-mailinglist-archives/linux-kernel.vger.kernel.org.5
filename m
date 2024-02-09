Return-Path: <linux-kernel+bounces-59856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFF84FC97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0230285516
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132A82866;
	Fri,  9 Feb 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n2SyNqDX"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB26BB22;
	Fri,  9 Feb 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505530; cv=none; b=q4R7nAR5OQLHQE9epsT8wO7tyYUti8PoQCXNKwsBhDxhIcJ1kHKMsRWEdF+aFz6pf6hGuyPDw58UDoMckqjxv3J+xyBJW1LXs87qyyty7V5jRd0J/yGrh5ZTqdrn7UbcpnoneN/R+9ibUZQ2z+Yj9SX1JRKuGWveZGfdx0VetyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505530; c=relaxed/simple;
	bh=gtanvazOXfKpj3BBmgPOI/S0uf7b9dENbOxl62Yp3I8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=DMaUY4bhGVNYb181khvomxu2MDXoW+xuf0cy1YkFvdREJOJREpd5l9PLgDed5MBJ+NgCgTtI7EdRaTjsVOqgc5NXUMYwO3tRLTLgCFP2g+Mjld17/n1hTMZhlJSvH8no4MgzNq/AIbq3uQwYfWiwgQBrjxo4dHNYskuguYNSDRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=n2SyNqDX; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707505522;
	bh=gtanvazOXfKpj3BBmgPOI/S0uf7b9dENbOxl62Yp3I8=;
	h=Date:From:To:Cc:Subject:From;
	b=n2SyNqDXxuu47KZyUbQ7p91xeI8YLt7VpFFF0iA8OdQzgi0qdbw2cxz7u0ksYvTUU
	 ws5A3f5Vwxm5Fkedr9xszP8W2kqYDH/H4HuHln2f1Cr/ONKYwBbtmPN7y8aYvLDONJ
	 OQygtkht344QrXCLqsS3MUXra4wqwuWHSRL45mYMr6+uZaXQhjEROaCv/GsIGft8bl
	 JrRBIEG4Te+PhUzJJQKp8FFsO2kviupQv1D6ZYmUIn2zMtg5WSxXqnYt4ewyrMzAWC
	 SfcqPvg94fDY/y0Oo9uoHaW/tA/GicfbBSntHevwu6apvO0fYZYkGwjgA7mqyBvSRR
	 HoNi83hkwlG6A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWjwf1tpxzY0y;
	Fri,  9 Feb 2024 14:05:22 -0500 (EST)
Message-ID: <bc925b57-4814-4788-b369-cd2d135a7381@efficios.com>
Date: Fri, 9 Feb 2024 14:05:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-cxl@vger.kernel.org,
 nvdimm@lists.linux.dev, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: CPU data cache across reboot/kexec for pmem/dax devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dan,

In the context of extracting user-space trace data when the kernel crashes,
the LTTng user-space tracer recommends using nvdimm/pmem to reserve an area
of physical (volatile) RAM at boot (memmap=nn[KMG]!ss[KMG]), and use the
resulting device to create/mount a dax-enabled fs (e.g. ext4).

We then use this filesystem to mmap() the shared memory files for the tracer.

I want to make sure that the very last events from the userspace tracer written
to the memory mapped buffers (mmap()) by userspace are present after a
warm-reboot (or kexec/kdump).

Note that the LTTng user-space tracer (LTTng-UST) does *not* issue any clflush
(or equivalent pmem_persist() from libpmem) for performance reasons: ring buffer
data is usually overwritten many times before the system actually crashes, and
the only thing we really need to make sure is that the cache lines are not
invalidated without write back.

So I understand that the main use-case for pmem is nvdimm, and that in order to
guarantee persistence of the data on power off an explicit pmem_persist() is
needed after each "transaction", but for the needs of tracing, is there some
kind of architectural guarantee that the data present in the cpu data cache
is not invalidated prior to write back in each of those scenarios ?

- reboot with bios explicitly not clearing memory,
- kexec/kdump.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

