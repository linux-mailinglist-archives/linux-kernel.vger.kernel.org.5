Return-Path: <linux-kernel+bounces-40487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493ED83E18D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32561F27BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675D720DC7;
	Fri, 26 Jan 2024 18:29:46 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98690208B4;
	Fri, 26 Jan 2024 18:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293786; cv=none; b=lgd75tW+2Qk7yhodx5cm6QMAWP55mT6hpp3S9DsTETqPBSTIzGB3MCwqjjNL3oakx4JZLrHIwkrFdPuPI8zXkVTcAOnmYJxvdmLVwgEokE2ko1KhKF2lFMRZ4N/4hMizY2yTZWmz0BNY6NSPep7dB7LL48fDdLgbiurDP6WI0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293786; c=relaxed/simple;
	bh=0IpWNU1MIudpmuKWbGyYaz6Jus1Rape1tUquqhM14RM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qh2B0s/6bTZ1w1+21o+NYR6NfOcf+j9FAaGz3Y4gXU8FkaiJfMDoLmb680uGCcuV4PC6yRue8Q5r+3BJU9qfH4E6eRZl+xgA3TkCgHh7oZFgPNLGXtKH8rxop1eDfEeOcoIxUHQEoGsDb44q/1jd2N6R+5/+9zLJlnxUSK4dpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bddceb0540so219545b6e.0;
        Fri, 26 Jan 2024 10:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706293783; x=1706898583;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHi5U3YMogl4iHy5GsTuj+x0agWS8uDT6CKM5jqaWoU=;
        b=bHVxK5ThMh4JF73x9fZdORxwb3WOc3NSklhdyjAwkdY42QD5FLovgx9pbhfUyPehRo
         lLFEkv/lFse3z9pdXYBX/ClwAyxQEAPBU0j2hpZYS1/tR0vsZ+9+vX471k5IYdPk4HPl
         lVmYWd5m4B2IyHJy5ttwjFDEsM98C7ZZZxMyZkGOhk4AjfLuAN/W/kCefmpO8NG2lb/J
         IlVj9AUkOQL5PuxyZrsZ/OGUGM79oItPfBg/IUuIFZe6GpLE+kDdCMLfx2YNEHhMvGAi
         78Oc/NsiHINcuFs0prDXCmoh6rTNvIgc2QcjSAPzYCOlG1YsOH8BNPgZKf0A6vHcIPwj
         +G8Q==
X-Gm-Message-State: AOJu0YxBQO2PAThzUnkbTBlDNdlnHTTNSvf/Hc592aC70dG29Ok7w66n
	tpIOqYZzclWDq6ldmR8YSELuPiDDl9OPuk3Gw9RZgMn0u8TAP5Rrg1K0JAKSEO9RIeNchhNfU3/
	8pTgksRJgNWF0Fy5BYgePxaDfAAeQ2JwCdW8=
X-Google-Smtp-Source: AGHT+IGtgItKl22be03Ted0ywcze+yBpNAzfx15LIu+5Nh7XwiJJvMRwQu9bfVdoOir2ygxef3BruexSmUBQxfibX/c=
X-Received: by 2002:a05:6871:54f:b0:214:2544:bf26 with SMTP id
 t15-20020a056871054f00b002142544bf26mr176888oal.3.1706293783589; Fri, 26 Jan
 2024 10:29:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Jan 2024 19:29:32 +0100
Message-ID: <CAJZ5v0icsP3F31gR2crrA4TrJRiYWFUJSdU36o7nnhpVSGzLRA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.8-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.8-rc2

with top-most commit f3bdd82c5834219a5b272c2310c83aef68667486

 Merge branch 'pm-cpufreq'

on top of commit 6613476e225e090cc9aad49be7fa504e290dd33d

 Linux 6.8-rc1

to receive power management fixes for 6.8-rc2.

These fix two cpufreq drivers and the cpupower utility.

Specifics:

 - Fix the handling of scaling_max/min_freq sysfs attributes in the AMD
   P-state cpufreq driver (Mario Limonciello).

 - Make the intel_pstate cpufreq driver avoid unnecessary computation of
   the HWP performance level corresponding to a given frequency in the
   cases when it is known already, which also helps to avoid reducing
   the maximum CPU capacity artificially on some systems (Rafael J.
   Wysocki).

 - Fix compilation of the cpupower utility when CFLAGS is passed as a
   make argument for cpupower, but it does not take effect as expected
   due to mishandling (Stanley Chan).

Thanks!


---------------

Mario Limonciello (1):
      cpufreq/amd-pstate: Fix setting scaling max/min freq values

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Refine computation of P-state for given frequency

Stanley Chan (1):
      tools cpupower bench: Override CFLAGS assignments

---------------

 drivers/cpufreq/amd-pstate.c        |  7 ++---
 drivers/cpufreq/intel_pstate.c      | 55 +++++++++++++++++++++++--------------
 tools/power/cpupower/bench/Makefile |  2 +-
 3 files changed, 38 insertions(+), 26 deletions(-)

