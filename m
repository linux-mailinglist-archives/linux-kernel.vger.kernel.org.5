Return-Path: <linux-kernel+bounces-127610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E973A894E5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757D21F224AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3C56766;
	Tue,  2 Apr 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydzVSgoO"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B31E525
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049012; cv=none; b=QoXdsB+TO1j1tBA6tEd6qpAfm7tWVpsNOT0htcPrLkvr5LxbN3odYYuzlfb9LcbuOaYdKnSLXkorr4ZK7NVXC17lA8aRVOt6R1BTsiLwh66TzHZ6UsCLgsFIJy8jmfQy8mKgm3h8Gb8elCRqbgEghvA05Fy1gnswy8dTGg7bHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049012; c=relaxed/simple;
	bh=yhpWW/IT8Uwo5I32LF3idDM8PUHV1qO06MNqoFv0P4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2UCibsAcIDWC2/9HkJkBhUGip8WoEsg2In8kcFEccVscDI36ou5JxaBv+cpg9I8JWXxr+kNd7iDQqW3CLlzyjXI3gKRYogqv470DYvwq5wBpOVYx9Z2+kQyxUFFhkk1/jkcRIgqfRt2jCbZqn4107MQeswpfFa7uPpOLMOe7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydzVSgoO; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-475ffc62cbaso1222382137.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049010; x=1712653810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7BMxshBQJ7ZHa0LY4aOPHFxmzLIewnqFyNl/JiJoJk=;
        b=ydzVSgoO6M3J9iYSxLARklWbzyR4HCFGuYKybCDpfT4XfySRuZhF6kSMdqH5A6vwf3
         MumI5aj9kxO/r18F+P8+OhoLdJipHXSfzjJy5MOzYEztPcAGfBdKfsy0PKJiHPOMZdDu
         AFfK21Y6CK3hs4+8n/1WxndgTwGKY5LfqWYxnIo5OD9hhg7/whEc4Hw3cpGYtWby7D7R
         Bj/EopSO/RuPXaBYGQAZomhqq+tvtL4VDyuvJeu/pRrphApgw3dEa2PgwEA4K3SoDMYp
         xqRELmPVa0iriTVehFlFOzpyqmsHK6w2bBEowe1IxvTxaFiOGp7UPkgZ7NqcZI6XVAyu
         04PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049010; x=1712653810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7BMxshBQJ7ZHa0LY4aOPHFxmzLIewnqFyNl/JiJoJk=;
        b=G7AIpWYD4lUEYNS5nQWlvsIXtMyT1Ta0ulBGqLrGdPQU5MP22wcB9EVgMQ6tYSJgzk
         h51KQXonJhLZ+Xr2LbCeAnzRokiZJaumrCSwctDWrHC3Tb0Q9GjDIrXewiIVUM8HzpSm
         O91auO1CIMsyiezcv1FeyDF+P+vWoFCaoS6yvEaOeSry2EFjAjd8HJDlayuXqqLlXa9T
         1E67LHOdLDVL2TS3tcIUVqAlX6Stcljn6q2HgmnDEwqkPZUSrqaK9l2m5dQhIkkIFiB5
         9635ptPyHhUkkfTOlMDAyJozIalw1xmlYxt1YB/Z1wfP6QQDV4bK7jic6xJGW42VDJI4
         3YxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI0UQwnIVlBzfz8bdHW/Sq/4n4AH23L/mgtZZPh7bgHWRKcX9+avt+4XbBnQCBKUAMBfcmBduFmlgPxN7pR/9cAbSBxtKjlHOqSVBt
X-Gm-Message-State: AOJu0Yyv5mYo6dMgGXlrxuTozGdKkfNbJbdUZntthRqKdOjI1XHcTSzf
	XvWHf7Fz06R6wchxoGg6l1Ob/ea08yKxVa3G3UezfjgQgHEsKLehuWiXaI0ldVTB1JTuqUJdqhO
	7zt3daQBGUn8kfbOfFLnqmeZYLFxfqwJVlHotXQ==
X-Google-Smtp-Source: AGHT+IHUhrMRqZBe61EWvS/5n4DW7KdCE5I4UvfMbfeSIQSs2UUIFQU50DQGojCXvjHaJP2OmbuZLI0CMjUH+BF/oaA=
X-Received: by 2002:a67:fe99:0:b0:478:7149:20dc with SMTP id
 b25-20020a67fe99000000b00478714920dcmr4020589vsr.8.1712049009942; Tue, 02 Apr
 2024 02:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org>
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 14:39:58 +0530
Message-ID: <CA+G9fYt+LiPtb3jP8QqgfrfBtQBNWawCqGUabg+GBqXZSVa5pg@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 21:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, and i386 with libgpiod tests.

libgpiod test regressions noticed on Linux stable-rc 6.8, 6.7 and 6.6
and Linux next and mainline master.

Anders bisected and found this first bad commit,
  gpio: cdev: sanitize the label before requesting the interrupt
  commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

LKFT is running libgpiod test suite version
  v2.0.1-0-gae275c3 ( and also tested v2.1 )

libgpiod
  - _gpiod_edge-event_edge_event_wait_timeout
  - _gpiod_edge-event_event_copy
  - _gpiod_edge-event_null_buffer
  - _gpiod_edge-event_read_both_events
  - _gpiod_edge-event_read_both_events_blocking
  - _gpiod_edge-event_read_falling_edge_event
  - _gpiod_edge-event_read_rising_edge_event
  - _gpiod_edge-event_read_rising_edge_event_polled
  - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_bl=
ock
  - _gpiod_edge-event_seqno
  - _gpiod_line-info_edge_detection_settings

Test log:
-------
ok 16 /gpiod/edge-event/edge_event_buffer_max_capacity
**
gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_tim=
eout:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_t=
imeout:
'_request' should not be NULL
not ok 17 /gpiod/edge-event/edge_event_wait_timeout
ok 18 /gpiod/edge-event/cannot_request_lines_in_output_mode_with_edge_detec=
tion
**
gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events=
:
'_request' should not be NULL
not ok 19 /gpiod/edge-event/read_both_events

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.=
8.2-400-gbffeaccf18b5/testrun/23252337/suite/libgpiod/tests/

## Build
* kernel: 6.8.3-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: bffeaccf18b5433577a5f823e5b98bee675d530c
* git describe: v6.8.2-400-gbffeaccf18b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.2=
-400-gbffeaccf18b5

## Test Regressions (compared to v6.8.2)
* libgpiod
  - _gpiod_edge-event_edge_event_wait_timeout
  - _gpiod_edge-event_event_copy
  - _gpiod_edge-event_null_buffer
  - _gpiod_edge-event_read_both_events
  - _gpiod_edge-event_read_both_events_blocking
  - _gpiod_edge-event_read_falling_edge_event
  - _gpiod_edge-event_read_rising_edge_event
  - _gpiod_edge-event_read_rising_edge_event_polled
  - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_bl=
ock
  - _gpiod_edge-event_seqno
  - _gpiod_line-info_edge_detection_settings


## Metric Regressions (compared to v6.8.2)

## Test Fixes (compared to v6.8.2)

## Metric Fixes (compared to v6.8.2)

## Test result summary
total: 256232, pass: 222485, fail: 2538, skip: 30869, xfail: 340

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 128 passed, 2 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 32 total, 32 passed, 0 failed
* mips: 26 total, 26 passed, 0 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 36 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 13 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 6 passed, 2 failed
* x86_64: 36 total, 35 passed, 1 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org

