Return-Path: <linux-kernel+bounces-138369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904889F037
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC041F22CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B66159571;
	Wed, 10 Apr 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyu4rfUA"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36F158D99
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712746587; cv=none; b=TKdPwjaZTfzpNmZbaQtMv2IzYaIU5g6smWdFn/JlOCk0Wn+yTdfd2hvObPnMn6+iTsJa+Fgim6ms5/kFum3lNLGoLd3O2oZ7AyjvxqaP/JsH3BRMdnnydm8nJ1T2P92S8715gG98sePTdIBmryMkVfVWSidaE51r2dXkVM1tL5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712746587; c=relaxed/simple;
	bh=PkLomg3XZoAJg3TSd9x2y2XkV+U9wN5WgCjvRqpTvr4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jjubR5sc5oz/YuvS7KISSbaHzy2edA/Fvmyv6H5qFn7DXvOL725s16vcfHBX3B2/F7/euG3eYxMS5zOtnRRDwnLQn3aYYWXjgwi9qhSyABuHwbAiQu9PEi0P9nqlXcM1502TAcNse41P7B3FeZqJO+xGUZFDOodxsXSNI/0sz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyu4rfUA; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dad331b828so1151693e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 03:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712746584; x=1713351384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4P1zHA79cNSOqe5dhAPt9YiRo8Ig2ZEUFz6PytxSbs=;
        b=dyu4rfUAF+ZM5C9oe+bUPaWJBhYlk3LtXvVEWZF2n5zcG9Zrx0nH/pkaeAMNXfzoyh
         NXZ3A2dAQh0tvtasYGGI9oDuNws9lWh8Mi3bGRyzvwqdIIclTljKPQ9DxLSng8zRy8BY
         fwELXU5JtHnTY8YW3O8tfZCoJeOeL4yG5XtZfhHpFHfB8/GZlgR3Kfvnf1sXOMeOll3G
         I26uLx8BuP7Iww0m7Sd6ccB3vLtSDsOqMmmccyWeRiB5Ol9le7Pa2X0x96Z0aRJV0QNi
         FmccazTQDlhaUeWg2VxgmyEgkTJSBFHfDKJ/93dhr6IlgphQC1dGbQhsT8hToP5wNatR
         i+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712746584; x=1713351384;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4P1zHA79cNSOqe5dhAPt9YiRo8Ig2ZEUFz6PytxSbs=;
        b=VX2a1Sm9Rwyv9TrEEg7uXJWH0C9YO7ftD9/A6VIdEdO/vz0kK1TvknAvJkKKnyEssY
         tCAMRUA5cTnNvE4VrV5s8H2z4MFB/oaXwXdrYOUGO8wHwfDioTpBg8lfmHj6i4nP24Y1
         jx1U7YakjlqSkTjOPNU4gd6kJGm7WxI8QKc5/Pby/S23ZoNIkEknRXJ00p1YRftS77DT
         ye8PpU5T3AXTW2rsg1+P4JODnBSY+dqG27CeL5MsYyLjwqzTAUx3wPV9G3m7xYYRsnKw
         tHJ4Xsr428UnLQzXntbnRqwioGQsxdDoP5Z3wwfbqIm2Vd91YA3nmMOWZfYkaSPM70I/
         ZbqA==
X-Gm-Message-State: AOJu0Ywkb0tmYkoGvP/qWSH662rfRWWhG4mJhmr/L2ZyInfGch6hbOf/
	LKn2xvwuItVR4Ql9mNmlXplhYO670BCDAgDYAIqNFWWGIeH/jRDRuwZQqxN20dQiFhqGOB8OAb0
	ALnN5fVeE06S7muGgnzpg1/LXm4XmQapATvvSrVcQLcZle4TZY4A=
X-Google-Smtp-Source: AGHT+IGvDtSipGLN4V+a5OK8F15/LzzDmS0siND2Ax9vMFlFPnR/b9TAjNiJAXVFQnE88ZlIPrSPfifC/IbqQFAdzjw=
X-Received: by 2002:a05:6122:a22:b0:4cd:20ea:35aa with SMTP id
 34-20020a0561220a2200b004cd20ea35aamr2414982vkn.8.1712746584230; Wed, 10 Apr
 2024 03:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 16:26:12 +0530
Message-ID: <CA+G9fYvjdZCW=7ZGxS6A_3bysjQ56YF7S-+PNLQ_8a4DKh1Bhg@mail.gmail.com>
Subject: tinyconfig: kernel/time/timekeeping.c:286:1: error: no return
 statement in function returning non-void [-Werror=return-type]
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Adrian Hunter <adrian.hunter@intel.com>, 
	Stephen Boyd <sboyd@kernel.org>, John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The powerpc,s390, superSh and sparc tinyconfig builds failed due to
following build
warnings / errors on the Linux next-20240410 with gcc-13 and gcc-11.

List build failures:
---
* s390, build
  - gcc-13-tinyconfig - failed
  - gcc-8-tinyconfig - failed

* sh, build
  - gcc-11-tinyconfig - failed

* sparc, build
  - gcc-11-tinyconfig - failed

* mips, build
  - gcc-12-tinyconfig - failed
  - gcc-8-tinyconfig - failed

* powerpc, build
  - gcc-13-tinyconfig - failed
  - gcc-8-tinyconfig - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
kernel/time/timekeeping.c:286:1: error: no return statement in
function returning non-void [-Werror=return-type]
  286 | }
      | ^
cc1: some warnings being treated as errors

steps to reproduce:
---
# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig tinyconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240410/testrun/23380322/suite/build/test/gcc-13-tinyconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240410/testrun/23380301/suite/build/test/gcc-11-tinyconfig/history/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240410/testrun/23380301/suite/build/tests/

--
Linaro LKFT
https://lkft.linaro.org

