Return-Path: <linux-kernel+bounces-77992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99600860DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EEEB222C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D404C626;
	Fri, 23 Feb 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfzFc9n9"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010A381B8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679906; cv=none; b=ICNT1M4hqoErUVJ2FdFQvwW+A7Stzj01qU0hXoewOMtaDtLiZZQPmZcSDSlVNNF6IL+RMpliTy9nAEBx1XshqAo7mqYUCmS1s95oDS1vQlXNkQ2RPoDmJcLXOpzd71k7Kf5QRvGKFAKZ1mS3qC5rRkajmGRVap3+ddFaAv27Ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679906; c=relaxed/simple;
	bh=VLflfRKkDJ+7BDY7WT+u8LUGZ3InZLFCOGUiiAPmnbc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qF6JKMzvVY91O+PEOsYhC68mz9QfhtgiFgZycJMq5LPmhyJSTVpKfrRmMSWLQ49pAtL0VM8BZ8KsYv7l9H8XSHzK9oIwcKgN0TEV4UzUYL/i5K4yEQIGjIj26bS1tQXtQN6PkE97e6ib5+pVUwXkhH4r9q8k5J5LRFBaYo5p+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XfzFc9n9; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4706beefb70so388489137.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708679904; x=1709284704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RruxHW4G1EnZrK3ihdNCvQ/hDet1LybFAeFV3BVBTfQ=;
        b=XfzFc9n9Pdkw47NECEsQ1mHBIazoQE+ziQ463aCeLLI+Ni970toi4l5e0rJfN2pNF4
         6umaeYZ8/OLDZD7Vmyf29Rqe2zVnXPxj5TzziwNO/g1GSmbBFkuigCIsgETQz9KeDL/z
         +aEy++x4vtERogrfoEu+Q4F6vHHlJ2zkYtl2tbdUAO3YQzXw02hMdor/LoNrlk0MWOd0
         1OCwjMTc7W5Zs10wH0c8qVoUPZGyH3ZKn8Kr4JljA4lYZXoHdvEfkcaFfsnqNVrUpT+I
         7NzdY3h02QXtcR+H5zKl5Pty9FZcjX94ZjvR53rCXnM2F8LmL/5LSChAGQfSKmvT4z3h
         jG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679904; x=1709284704;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RruxHW4G1EnZrK3ihdNCvQ/hDet1LybFAeFV3BVBTfQ=;
        b=nr1MkCYI0byOyUzdR6u4xlcm7eaWNNcXZQdWSfKaFU1cGc9DN2+9x9+W5R9N88Bf9U
         OvoVT+9c+KOihMlWbmkcKj6ptXmos+2jF02c5S4/f+o1S9yi7n4+kZvURUcRmt8lKnyC
         wmO4Hjd6xjRxGa4NG8nkW1kkm/7awMsmDtGEbVAyjrdM71MN6ezBK17OTTbNkdlFMLQQ
         ZFGsYiSFBAPBTmORCNMAIEZarj7Pl0rsE+dyDsYZDknOJJmYK8uIwo+ivIkWkxk4/mJ3
         /EhYW4q5aLVmBvdAPC0nRrwoKjXP7aX8kkMJC3uz+tbT05pQ+xDTE7tkP1w9xF6eA9lE
         pH2A==
X-Gm-Message-State: AOJu0Yw3dEzrs3TK64ZdjlY2nfh6JbLcFC8jxQXB/s6aWwcoMqSlIYfd
	6k3JKdszU0kbcOp6lQIOgsch4kGxvyv8xvBVaUdFaciMhMaLsJ8MMk9HaOBo4LhsJfbyuhp0jv4
	BbfAYh+6kjk0hZR/3aMLNqSMRULXieYxVgI0wPsFCpARDw6vSNZM=
X-Google-Smtp-Source: AGHT+IFMHDNbfbgyGSBvk4Zi1HLVzztlSau/RqKEU5jcH41l/IuC6jdzEZcyo3wOB/uucvf2iTSOsWbu/HgMRkUGaL8=
X-Received: by 2002:a67:ed99:0:b0:470:5b88:1c7c with SMTP id
 d25-20020a67ed99000000b004705b881c7cmr746857vsp.8.1708679903688; Fri, 23 Feb
 2024 01:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Feb 2024 14:48:12 +0530
Message-ID: <CA+G9fYvSsq8tALGihWXOvJ-0qJ0iiDARmE4q28g0w9gOh5ZeOA@mail.gmail.com>
Subject: parisc: kernel/cpu.c:3110:9: error: expected identifier or '(' before
 '=' token
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	linux-parisc <linux-parisc@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"

[ Please ignore this email if it is already reported ]

The parisc builds failed on Linux next tag next-20240220..next-20240223.
First build failures noticed on tag next-20240220.

parisc:
    defconfig: gcc-11 - Failed
    allnoconfig: gcc-11 - Failed
    tinyconfig: gcc-11 - Failed

kernel/cpu.c:3110:9: error: expected identifier or '(' before '=' token
 3110 |         = {CPU_BITS_ALL};
      |         ^
make[4]: *** [scripts/Makefile.build:244: kernel/cpu.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
 $ tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22811934/suite/build/test/gcc-11-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22811934/suite/build/test/gcc-11-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8psPmccoERtfX4SrhL0yxD0F/

--
Linaro LKFT
https://lkft.linaro.org

