Return-Path: <linux-kernel+bounces-162551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411D88B5D38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722881C2131E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6C8626E;
	Mon, 29 Apr 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSBJCj33"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519E85620
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403227; cv=none; b=uxEZt6Bg7j0nBmhkpWgLSrCiwMoTOUegRMnRTJpj4RBZxSic7rTxrZ7p/E6tYrcqMI7YvQSuUuSWMtzzaxt+prID6JivlhzFAFTSpeUaakMU10HVeBX4tknDaOiNM8GHNtAgKetqA1V5beaKJBiOZcwgIIfGZ5DUGU9goh3nMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403227; c=relaxed/simple;
	bh=/3w9Zil+4uYrNOmcYMZkGVooAinr9yG2hncXQUB9lek=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DQdQmBC5XyhAOMgRvwOiQSWN4gdD/m7Ct9ZaziwyJIpCrOb9laYhkTd+63rSf+J8OvHnFzPXepomFvNiqaL+sRmDdwV3+RerDQUgWRExKoAINRGgy4+r2qVheJ7OL6myAHrcec2bT+5RwBI/bX+k14fM+/niYZillkteXAHhK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSBJCj33; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5afbd1c3ffeso169931eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714403225; x=1715008025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kq/mDhjDx0haJOXMYO5ieP1vWAdfCIwGNjDIS1vV1ns=;
        b=SSBJCj33wTOkplIYXXTrBH1dfnmej++IA3IfLzKSr1OamipqtOtg7teRlYWm89buCn
         vTrudaHhHdNk6UJhLMcmZAQHMRGCYcfvfLxMQX7F9ud5yYfDlkxSMSOQCjiHCJHFaeWZ
         KR/seCPbtu7kkH8EbwJ5rvZE7Hc7Ca/huQaPKEKeRecQV5NJ1kzUADoRgchDIVExbWiY
         u27kaT0NocbEgG5m8U0mZKqcZ7tf/I+3yoOsC4d7+sEegRNBoq0bZeYeDRR29fjbYxmw
         pszBjUQMleOBE352RJ8iBOpefWSN87IkwwIF5K54IMLZdyIQZNvoRID9uYR5FaIMCISZ
         DCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714403225; x=1715008025;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kq/mDhjDx0haJOXMYO5ieP1vWAdfCIwGNjDIS1vV1ns=;
        b=Yda7Da1YpVevL4G4H6KwbqBJt98jDFgqW0q20tT/XeX6TDHwtuErWsU5qu6aXLsOVW
         htbAcGoVRDfImxCvRtLyJ9vf0mc7zQzd9HDoxAKtff2u/BFENy/kSE/UoGnGDmFhC6uj
         FfSzQRA/zudsGbZglPf56wYrLUZQIG/WT5m3pMFEDQSppLeM+d867o30QdlxTwlXvi/2
         eCwix8KzGYasDYklcLlRXB1Vz95YcFXaMbk+g53bECs0qonkwYkys7sGC2qyTlGx3X82
         SMDW129sIxb5UzzOxb4xZS0gUpfxdesT1L+T8uL559bKkpX0FdpA3jefo//lsKUQ2ygk
         MHlg==
X-Gm-Message-State: AOJu0YzmQESvgJrxADhR8/0cMytpnTBWuvjaPlaaby4AY0JCpQ2f7NDl
	yM6ov0jnjfsHaCc+rVrVnGBh0xX/LpS0MieQpSAzX9qNdGIRySVZZ+iM0BJXy/lwdV96c5B7/r3
	DN6xqZNtXcIO+QRSyQ8VlghHle7wlQ7jtaYiQ3V0g6UvTw4zBwf0=
X-Google-Smtp-Source: AGHT+IGi7klXrfkLGYDk0bH46vsiOhdwy/HLQn/JmrZKyHF7xJC4yozyKeAYx8uVrhCWOCacbYNZwg87iwhAtb2HZSs=
X-Received: by 2002:a05:6358:5d91:b0:186:3fcb:8da9 with SMTP id
 s17-20020a0563585d9100b001863fcb8da9mr11016997rwm.21.1714403224770; Mon, 29
 Apr 2024 08:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 29 Apr 2024 20:36:53 +0530
Message-ID: <CA+G9fYu7Ug0K8h9QJT0WbtWh_LL9Juc+VC0WMU_Z_vSSPDNymg@mail.gmail.com>
Subject: nouveau: r535.c:1266:3: error: label at end of compound statement
 default: with gcc-8
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: Timur Tabi <ttabi@nvidia.com>, Danilo Krummrich <dakr@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Following build warnings / errors noticed on Linux next-20240429 tag on the
arm64, arm and riscv with gcc-8 and gcc-13 builds pass.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Commit id:
 b58a0bc904ff nouveau: add command-line GSP-RM registry support

Buids:
--
  gcc-8-arm64-defconfig - Fail
  gcc-8-arm-defconfig - Fail
  gcc-8-riscv-defconfig - Fail

Build log:
----
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c: In function 'build_registry':
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1266:3: error: label at
end of compound statement
   default:
   ^~~~~~~
make[7]: *** [scripts/Makefile.build:244:
drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.o] Error 1

metadata:
  git_describe: next-20240429
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: b0a2c79c6f35 ("Add linux-next specific files for 20240429")
  arch: arm64, arm, riscv
  toolchain: gcc-8

Steps to reproduce:
----
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2flcoOuqVJfhTvX4AOYsWMd5hqe/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23704376/suite/build/test/gcc-8-defconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23705756/suite/build/test/gcc-8-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

