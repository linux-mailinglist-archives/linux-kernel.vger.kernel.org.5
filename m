Return-Path: <linux-kernel+bounces-24307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825482BAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3932F1C2085A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C25B5BE;
	Fri, 12 Jan 2024 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGC/Nqe5"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002AF5B5BD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b7e4a2808bso1860420e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705036519; x=1705641319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgIz5Jw3xaCiRypp9t/7nFofZKzAWe2AVuDOEAahvJw=;
        b=vGC/Nqe5b8zoxuNTMT11BGceNiK9EAD5XFiS/mTY0E1eMw59b+LhSBeef1jUAfErXI
         1SQ4BQqFIUi6DeC7geoI6u/PBiredB38f7PMOnAtkEaU5MphhQ2gubUsVyduWHQ0y6D/
         3XnvZsgZc/DDZq+LCr2pLvamFrG4ZyCB5K/9tiNGWWR7cg7JVnWMhcEcVC3hvYb9nsBw
         6J934nTWv516j2WiWias9tp6pye+rmpOWy3mneQwC9c4YV8RxBYFIUOLHYBhVFIPE2V1
         X0G3woKW6RSoZzpPIPjWHXftdBob+L2YCkrT2izX1yW1WLO8WdZYD8TjR0Rn6jMXeMpX
         DaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705036519; x=1705641319;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgIz5Jw3xaCiRypp9t/7nFofZKzAWe2AVuDOEAahvJw=;
        b=aQD1Hv2vGfAj/8hO/KQfOqXhthvWVo8GZNq0ueE95pVn1vZFfVEXLE4JNv9iom0lXe
         MkCifyD+3OLjiDKdG38+UCFo2J1GOaY4nu8Po3YKyWnX44c2Ah3svF8fftBxioMs+OXE
         wtfYdj7EfOeY0P1o7d9OHQ4VPhVNnE+QOC2d3aZW7nX05YHDxxTMU6J5oCSeRdB2rDUN
         fJ8uU3P6E953OzvWAh68RCQlpZA54WYZj5WnCpEsc8dcyZXQzwZ+W9ePmwDC2AqTHTeJ
         jt5tpFFGP1Ik6QF4MobB0Oko/eRBAkHvcGI5WExZ4QY5F/QVUmPai4cAoq6NlOiODV2d
         YO7g==
X-Gm-Message-State: AOJu0YwvtGpWGEGxQbFIKP8+udOsXT/QqxJg6KOQo3T3bR+0uCCGCkLF
	yZ/trKjkqg+r7eOZlwJHLG8/zW2tC7ckETExMCppZNxqLtUUyA==
X-Google-Smtp-Source: AGHT+IHPLvPAb+MT+s200UzDgvlLJVHSQjmJYTb0cHfWBa5Vn8ew9C7G9AwMneG0HO+in1yTFy80+h7ZYa1cXDFsG/w=
X-Received: by 2002:a05:6122:4d0e:b0:4b7:a95b:7b3 with SMTP id
 fi14-20020a0561224d0e00b004b7a95b07b3mr706190vkb.26.1705036518758; Thu, 11
 Jan 2024 21:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Jan 2024 10:45:08 +0530
Message-ID: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
Subject: Re: scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
To: linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Niklas Cassel <niklas.cassel@wdc.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

The LTP test 'iopri_set03' fails on all the devices.
It fails on linux kernel >= v6.5. ( on Debian rootfs ).
Test fail confirmed on LTP release 20230929 and 20230516.

Test failed log:
------------
tst_test.c:1690: TINFO: LTP version: 20230929
tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)

Investigation:
----------
Bisecting this test between kernel v6.4 and v6.5 shows patch
eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
as the first faulty commit.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240109/testrun/22021120/suite/ltp-syscalls/test/ioprio_set03/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240110/testrun/22034175/suite/ltp-syscalls/test/ioprio_set03/history/

Steps to reproduce:
---------------
This is how you can reproduce it easily:
Install podman or docker, tuxmake and tuxrun, if docker please change
the --runtime below to docker.
cd into the kernel you want to build:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig --results-hook 'tuxrun --runtime podman --device
qemu-arm64 --boot-args rw --tuxmake ./ --rootfs
https://storage.tuxboot.com/debian/bookworm/arm64/rootfs.ext4.xz
--parameters SKIPFILE=skipfile-lkft.yaml --timeouts boot=30 --overlay
https://storage.tuxboot.com/overlays/debian/bookworm/arm64/ltp/20230929/ltp.tar.xz
/ --save-outputs --log-file - -- "cd /opt/ltp && ./runltp -s
ioprio_set03"'


Bisection log:
------------
# bad: [2dde18cd1d8fac735875f2e4987f11817cc0bc2c] Linux 6.5
# good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
git bisect start 'v6.5' 'v6.4'
# good: [b775d6c5859affe00527cbe74263de05cfe6b9f9] Merge tag
'mips_6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good b775d6c5859affe00527cbe74263de05cfe6b9f9
# bad: [56cbceab928d7ac3702de172ff8dcc1da2a6aaeb] Merge tag
'usb-6.5-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect bad 56cbceab928d7ac3702de172ff8dcc1da2a6aaeb
# good: [b30d7a77c53ec04a6d94683d7680ec406b7f3ac8] Merge tag
'perf-tools-for-v6.5-1-2023-06-28' of
git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next
git bisect good b30d7a77c53ec04a6d94683d7680ec406b7f3ac8
# bad: [dfab92f27c600fea3cadc6e2cb39f092024e1fef] Merge tag
'nfs-for-6.5-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect bad dfab92f27c600fea3cadc6e2cb39f092024e1fef
# bad: [28968f384be3c064d66954aac4c534a5e76bf973] Merge tag
'pinctrl-v6.5-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl
git bisect bad 28968f384be3c064d66954aac4c534a5e76bf973
# bad: [af92c02fb2090692f4920ea4b74870940260cf49] Merge patch series
"scsi: fixes for targets with many LUNs, and scsi_target_block rework"
git bisect bad af92c02fb2090692f4920ea4b74870940260cf49
# bad: [2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d] scsi: 3w-xxxx: Add
error handling for initialization failure in tw_probe()
git bisect bad 2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d
# good: [8759924ddb93498bd5777f0b05b6bc9cacf4ffe3] Merge patch series
"scsi: hisi_sas: Some misc changes"
git bisect good 8759924ddb93498bd5777f0b05b6bc9cacf4ffe3
# good: [7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24] Merge patch series
"Use block pr_ops in LIO"
git bisect good 7907ad748bdba8ac9ca47f0a650cc2e5d2ad6e24
# bad: [390e2d1a587405a522dc6b433d45648f895a352c] scsi: sd: Handle
read/write CDL timeout failures
git bisect bad 390e2d1a587405a522dc6b433d45648f895a352c
# bad: [734326937b65cec7ffd00bfbbce0f791ac4aac84] scsi: core: Rename
and move get_scsi_ml_byte()
git bisect bad 734326937b65cec7ffd00bfbbce0f791ac4aac84
# bad: [6c913257226a25879bfd6226e0ee265e98904ce6] scsi: block:
Introduce ioprio hints
git bisect bad 6c913257226a25879bfd6226e0ee265e98904ce6
# bad: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi: block: ioprio:
Clean up interface definition
git bisect bad eca2040972b411ec27483bf75dc8b84e730e88ff
# first bad commit: [eca2040972b411ec27483bf75dc8b84e730e88ff] scsi:
block: ioprio: Clean up interface definition


--
Linaro LKFT
https://lkft.linaro.org

