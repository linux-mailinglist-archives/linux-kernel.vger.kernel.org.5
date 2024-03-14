Return-Path: <linux-kernel+bounces-103669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F61687C2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DB3286F07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE47757E0;
	Thu, 14 Mar 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p85zQ2tO"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFF74C0A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441004; cv=none; b=ASBeNjiQNiTsXj0mYYadjKCybnk7PIKkRziuhJkReW9ufoN89lWZW+mscTNHWzmMhOUwEIazRYcsRl296d049AmmYJvNYe9AkGbrV7zcm2R53M9q87RHJFh8qJhbRUVdn1l1n4PehOc5SCaCVHaM57k63GLxS6eyu04ZBIvIBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441004; c=relaxed/simple;
	bh=Qg3lZr57XOc9PYkGmtrFR+udr3x8N2PgaMiFJbTRC1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEWiAbaHMPM7VMfC7lEF8Oj8qEBGQVNACHxHLQwiCZDxXzh9FbZPWhFHTwlm5t9dYoCj4uE+fa3kUlZRnFE6KhiWekTMTEqwntbqt0FMIIDtPW6nSfB7pX4rn0FCusTGG1RRcMAJoJwya6ruHfK13GOgmXnfxlI4aNSmSthafx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p85zQ2tO; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7dad8437347so440778241.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710441001; x=1711045801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3OBrI9E8HmCM4btqjmW2AbQrUzPGhoC1ZSw62p7ejE=;
        b=p85zQ2tOMcfYmnCoJkyZwCVHvZvZoSgX0XFr25VV/BOE3MMS1shVsqA2t5W+N9iOEt
         XrRg7XttYWCvXLVy+QfzRrrucjtuYh0C3ejui0JBE0XrCy8muvuZm3D6BBA5E5Yb2Yhq
         DGZkrhsVFHQTo0jp+AIliEhh3dPm6hU9dYZXfAnyrwKw6eH3G+7HeRtqIZnzhZ0ZqNZ8
         eWPn3lNXLIa559iMIO3r//7nDAYajWx83ZyD7qewhff3HOGZlI/9a/rPnMBcRz8uctII
         GV2gLs3vEW4xWbv+YviS4KjCuevFjav0dJQ2oGKVycqjgSLTrf7iGiV3bIN64B5CEL4Q
         5/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441001; x=1711045801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3OBrI9E8HmCM4btqjmW2AbQrUzPGhoC1ZSw62p7ejE=;
        b=NbHauYh/pqwzi4hAIiB92vXmO8IhlZ34iXLEKzNLN685ovCF92lOH+PB5HKSZiu+FL
         j7SmnppcvwUuH86r5N+Af39DSHkMh0qUTONPhb2+7kIH6kaOcQ1J9V8UlbZ4JFxP58tb
         GAIT4M4uNcVKxe+r9Jw7FCJrzdS9MyGHbI6WuhqnBgYxF9szcmKG7D1hC80apv1d2iLj
         Ry/BK+IVSlw8AFoVcGdY+1xSRMYTlgRfm2Cbe0gPa9/aWVOZcibhyQYAjUpnFJ4lq4RW
         N5ci0U0U2ehOmBYSaNqldNtJ4Qr6FBxHgr2zaDVX2kIaYS5TvJlq83WcFAubS5FYxnVO
         PlGg==
X-Gm-Message-State: AOJu0YwSslpRYUuv74Mr4cy7vldmWH83MB+6rg115QPd+CJT0BYPWQIq
	yLvmJ22xABrW4i6yIIWdOwzjS8emcmaIO7nGBTRdG5yZ5Jlkry+195lMEzlDCsLeOgrAoJh7Qei
	npfXK+7xAarIpHMnQAGB//teQ6FkBancNujEDzw==
X-Google-Smtp-Source: AGHT+IEF02amHlSPmHG8afhK+fHkEabTfEDNfkdO0mSBJm8uDjunPEmV09ZXEXZqZutL4KN/magMZv+NLERJ/KgmOLQ=
X-Received: by 2002:a05:6102:818:b0:473:885:bd97 with SMTP id
 g24-20020a056102081800b004730885bd97mr2423021vsb.12.1710441001289; Thu, 14
 Mar 2024 11:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313170212.616443-1-sashal@kernel.org>
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 14 Mar 2024 23:59:49 +0530
Message-ID: <CA+G9fYvA1dyE8jWc30=0YS1sC5kRZ0=ufT7FKgdbDGtFgk-ZzA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/51] 5.4.272-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 at 22:32, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.4.272 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 05:02:10 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-5.4.y&id2=3Dv5.4.271
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.272-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.4.y
* git commit: 55bc6060a8ad866b104285704e98264d921095b4
* git describe: v5.4.271-51-g55bc6060a8ad
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
71-51-g55bc6060a8ad

## Test Regressions (compared to v5.4.271)

## Metric Regressions (compared to v5.4.271)

## Test Fixes (compared to v5.4.271)

## Metric Fixes (compared to v5.4.271)

## Test result summary
total: 81697, pass: 66254, fail: 1491, skip: 13902, xfail: 50

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 37 total, 35 passed, 2 failed
* i386: 25 total, 19 passed, 6 failed
* mips: 27 total, 27 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 8 total, 8 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 8 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kselftest-zram
* kunit
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

