Return-Path: <linux-kernel+bounces-107545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A10C87FDEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D141F2280E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFC38FA6;
	Tue, 19 Mar 2024 12:58:47 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D53C08E;
	Tue, 19 Mar 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853126; cv=none; b=kEdoQOrwHPhjPw8Jfg9nYXCMm/SSx+pWeguduR52ilw54cYYbhXKgB3cK0aazAIszMs01ZYfh4k/6TTwYSg38g3c729uJ4GN47VnTMm1OdGB3JQKMWbobR0826gahrKVdGDimeYNROGBhXaGjOuL47qUG/sUtCpjaplME+jcXlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853126; c=relaxed/simple;
	bh=bDGVu2ht54DNJY9D61w97Glx7t+GS1mjdPbvuhX2RKU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=p27TdvpHt6IHt+Ql+jBf9WrExB5BLyV0UIcc4BMxl7+c90YBT6JhtrQcOoJVqzO6kWH5MF2b659FrLkJ2XQq7PibEU9qPYZ6DIFPcIab0NdtVSv8PEKNautCo6gG/KpAIz8imYObKA2Etmsj2B3zJHXnbSZUiw9OoyTggoo2zdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a4e0859b65so11494eaf.0;
        Tue, 19 Mar 2024 05:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710853124; x=1711457924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVedSuy1YaJHE6kqXfvwlKhYz6NEiCNUxLQc9igH1PY=;
        b=Bu+U2HQ+YJXGlSOG0w94ed3+OMs31Z8DyzMinPDk2OJpwxItR3yI+yHqrZrzk9LZwv
         q6eIXdprLeW8v195s1naIzxuhPtO2DmL8i2cpU6Js5vhNRAQuvir21e9DJUjHugjwuJA
         +IKmY6WUcppxxXz5Z8ADbB4PDGNKgmSkCFoIBzjt0SAxWO2h+up7x7qRFX7esJPAh9U2
         ySlFsVPAVRweCRvyMHag2oYyRRC3vSZTOY5OM3IOgfcEpxqhikA5cPvfXeNC19XpOm6F
         7y16djEvJ7iC0uFC/q/prMQ8ePW1WmkUWKQLeHk52ao5bhPDAEcGJEDL8f+jegZLg+Th
         mGoA==
X-Forwarded-Encrypted: i=1; AJvYcCUAK/EEKS5qAL9Af1gkUqTnJnCzXkgimgtPwxRzSWNxPVPhFaxq86J1kLLFr0TLn02L0dOwM0h2dydF9czbe3JpHfquLslYJ4VOBg6P
X-Gm-Message-State: AOJu0YxqwenieNYrafrrlf7bbRBadRDMOti/e7SqE8WS+jgj6Fr3WYtZ
	LiGYN19HBQZKFxFHW/SMk/z+TqI9GIciTwIj92bqpvKPxQdSY5Kd2zNozoATqUutyRfqq+fvG5H
	hdQdoenGtd2Ocr6uXfOFaT2y2W3U=
X-Google-Smtp-Source: AGHT+IHUaNKZWYRgiZaX9fAuFEFaoobcM3pxAzz8lLMeRycqVfpgjD+vzJ9MAn8uUJNY3yQv1dX8DHno4IbptehmE+c=
X-Received: by 2002:a05:6820:b95:b0:5a4:7790:61b4 with SMTP id
 eg21-20020a0568200b9500b005a4779061b4mr2110542oob.0.1710853124158; Tue, 19
 Mar 2024 05:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Mar 2024 13:58:32 +0100
Message-ID: <CAJZ5v0jjQ90P=+oQKdA2VY-8r0QAXjXfq50UMRDs6=XbcJ7R_A@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.9-rc1-2

with top-most commit a6d6590917ec352270bd3e3c040240aab31f2e90

 Merge branches 'pm-em', 'pm-powercap' and 'pm-sleep'

on top of commit 07abb19a9b201c11e4367e8a428be7235b6dbd0d

 Merge tag 'pm-6.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 6.9-rc1.

These update the Energy Model to make it prevent errors due to power
unit mismatches, fix a typo in power management documentation,
convert one driver to using a platform remove callback returning void,
address two cpufreq issues (one in the core and one in the DT driver),
and enable boost support in the SCMI cpufreq driver.

Specifics:

 - Modify the Energy Model code to bail out and complain if the unit of
   power is not uW to prevent errors due to unit mismatches (Lukasz Luba).

 - Make the intel_rapl platform driver use a remove callback returning
   void (Uwe Kleine-K=C3=B6nig).

 - Fix typo in the suspend and interrupts document (Saravana Kannan).

 - Make per-policy boost flags actually take effect on platforms using
   cpufreq_boost_set_sw() (Sibi Sankar).

 - Enable boost support in the SCMI cpufreq driver (Sibi Sankar).

 - Make the DT cpufreq driver use zalloc_cpumask_var() for allocating
   cpumasks to avoid using uninitialized memory (Marek Szyprowski).

Thanks!


---------------

Lukasz Luba (1):
      PM: EM: Force device drivers to provide power in uW

Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Saravana Kannan (1):
      Documentation: power: Fix typo in suspend and interrupts doc

Sibi Sankar (3):
      cpufreq: Fix per-policy boost behavior on SoCs using
cpufreq_boost_set_sw()
      firmware: arm_scmi: Add support for marking certain frequencies as tu=
rbo
      cpufreq: scmi: Enable boost support

Uwe Kleine-K=C3=B6nig (1):
      powercap: intel_rapl: Convert to platform remove callback returning v=
oid

---------------

 Documentation/power/suspend-and-interrupts.rst |  2 +-
 drivers/cpufreq/cpufreq-dt.c                   |  2 +-
 drivers/cpufreq/cpufreq.c                      | 18 ++++++++++++------
 drivers/cpufreq/freq_table.c                   |  2 +-
 drivers/cpufreq/scmi-cpufreq.c                 | 20 +++++++++++++++++++-
 drivers/firmware/arm_scmi/perf.c               |  3 +++
 drivers/powercap/intel_rapl_msr.c              |  5 ++---
 kernel/power/energy_model.c                    | 11 +++++++++++
 8 files changed, 50 insertions(+), 13 deletions(-)

