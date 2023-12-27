Return-Path: <linux-kernel+bounces-11914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6281ED7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A70D1C216F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED886101D2;
	Wed, 27 Dec 2023 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjet2F3p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD3F4F3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbb650ad59so3176857a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703667773; x=1704272573; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62EGL1QvBkU3z3zaiHwmHMdg6GkLmVh2kc3PbxBdNDI=;
        b=Pjet2F3pwjGVRoXm8OlbgS8kx/DBw1ofPlJC9BnkkiBUiMnblkUiPCUUprvKitY9uX
         GsyTf77zJf0UiuunpootwQ/pl9KTQ8g1mbXs+GgnOZ7uZUNrcDnL1v+hub32Ni93s6yP
         siKwEYvcFZEt+1DITWarUFG6VStL6z3ZgLjTyY5QAFkCPACGussr/bSeYthOHsD7IwLi
         Nj3NxUCUq75jTuEJsAqwjwk5Gqc30rJT2+ePNYYROkYbzxt9rg/acSXmJBl60DzxANiz
         WgtpelSirmdcpBL5evxuY1kYwQ9djpmcZGL991fBgg2zXxDbcCAhPTBH52tfTymVk39C
         q8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703667773; x=1704272573;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62EGL1QvBkU3z3zaiHwmHMdg6GkLmVh2kc3PbxBdNDI=;
        b=u2Fcawl0Id+RIoC594rxX+tYkm6C3fiPI22R+qKBIK2MpZ8LoF8fc+QX8pV14fPzUR
         c2iWcuMj3lBhTYQAiW57V1Y2p1Kx6fyqv6F2IXHIk81nhrrrdpZL4lGXQ8KIPn5T+14g
         KGJspkWPpZDtZOPPf5lEh1VVdzWWS3Q226AHaeMXUg5187gCB71jGEr/7YV/hSb7UWqY
         koEbq8aEMg3VIj4ccn96tiZJ23XcEWZ7frtmSjgXpvTEDQYT/NkZ5JZ4qjtUo1jf8xXo
         yQ8T612xa6Fonkeqx/iShaQIVRe7Bxihx9SBDvAMaM7GjUuITBLXZ3Od8/YbOokQNxhh
         kTzA==
X-Gm-Message-State: AOJu0YyfBOte6MTWYq/7z5+DOx6+/N8sZGg+YZPIp7gVg4eoFqVG2RKt
	hjvZJqaNkk0kTYG7F4sThU0olY5cSrRLXvG/Y5/sZD8hpQ19PuHNr0g=
X-Google-Smtp-Source: AGHT+IGBoCA0pq5mKruv+7MymaPk+7QWuEARqDwNctU7hLR4p2vurtc9iFIAovqe0bZoGcIrzN+5S3jAdBj7Avd9zAQ=
X-Received: by 2002:a05:6830:22ce:b0:6dc:36:2f91 with SMTP id
 q14-20020a05683022ce00b006dc00362f91mr927458otc.33.1703667772756; Wed, 27 Dec
 2023 01:02:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhang Zhiyu <zhiyuzhang999@gmail.com>
Date: Wed, 27 Dec 2023 17:02:41 +0800
Message-ID: <CALf2hKsJjDY3OhtMCxhHh7rS=2S4Oq9Ns=t-NFq1MPD=f0K02Q@mail.gmail.com>
Subject: A bug was found in Linux Kernel 6.6+: KASAN: slab-use-after-free in
 iommufd_test (with POC)
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca, 
	kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi upstream community,

I am fuzzing a LTS version of Linux kernel 6.6 with my modified
syzkaller and I find a bug named "KASAN: slab-use-after-free in
iommufd_test". By analyzing the call trace in bug report, I address
the root cause of this bug at drivers/iommu/iommufd. An iommufd_object
is allocated in one task through
iommufd_fops_ioctl->iommufd_ioas_alloc_ioctl->iommufd_ioas_alloc and
freed in another task through iommufd_fops_ioctl->iommufd_destroy.
Then when the kernel invokes the calls
iommufd_fops_ioctl->iommufd_test->iommufd_test_add_reserved->iommufd_put_object,
an use-after-free read will occur. Detailed report, log, repro, config
can be found in this google drive link:
https://drive.usercontent.google.com/download?id=1nDJWUstYJNcC1zJ6q1rhB5zB0uV2yGvg&export=download&authuser=0&confirm=t

The steps to reproduce the bug:
1. compile the kernel 6.6 with provided Linux-6.6.config
2. boot a qemu vm that runs the compiled kernel
3. scp the repro.c (repro.prog is not recommended) to the vm and
compile it with gcc -pthread repro.c -o repro
4. execute ./repro and you will see the output stucks for a while and
then KASAN is triggered and kernel panic.
5. you can speed up the crash by setting up another ssh shell to
execute ./repro again.

I have reproduced it on 6.6 and 6.6.1 (but haven't verified on the
latest ver 6.6.8 yet). I didn't find any related reports on the
internet, which indicates that it may be a 0day. Hope the upstream can
help check and fix it. And I'll be happy to assist if needed.

Best,
Zhiyu Zhang

