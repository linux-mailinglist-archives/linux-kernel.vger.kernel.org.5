Return-Path: <linux-kernel+bounces-163023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEE18B63CA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12B01C21D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9E717995E;
	Mon, 29 Apr 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVB7+WEP"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7A1779BA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423440; cv=none; b=J/7qF24Zb9RmCa9fQlh3EwCANn1FJq7ad2qXYIe0+PtXyEOzAW8rFF1AFML4AE+gIv24Zt1i9ICqHgIUzplZp89Vw/3+OhNVhaxCuap6dd/NdklTd+awLBpn7I3/hSmdYW4NoUWUqcYw52IjST6jMISFFNyOgqn73HPkNgUxELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423440; c=relaxed/simple;
	bh=DlJMFV/5TBkqj5Xgp0aq/ty+b2/P8lMPnJnVQ5Jw5rY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=O9apKE0w/vs2tnXdo74ImQeu4YE2KS5EytgO0nd9jD9ephGxfSXO4Xuyzw+hLcwZlr7tIGDbeSJxnVf3jqo+/Rye1Mtsg6FkVIc5U86IkuoUzFb9Muc+ZbBP3+UC4f2Rt0aXXaZ1ij5vV187m5R0YNF6njtT6QJs5l+1ThpLQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVB7+WEP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4dcf9659603so1223825e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714423437; x=1715028237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFLm7dyUtqCFeQ1Y3Oad/n2nmA3y2+DD3YB2hxxWLCM=;
        b=HVB7+WEPg71CIsMaiqAiANEz0jgJkmKVNob0zzxNdQK2+t1nZF+dCLrmBL2rsTfBHK
         W19GVRcmslOLu7TAkFz7YwlNzGohk4Sa+1aPHuI826V0yXsI5cTC0mAGOQAjmr0Ab/HH
         QcvfvWpsbIvEzWAUrltlIREHslThEjAuDDtyOjo3i9rwjq2IFmLpR2RbocYMyxvycE5t
         Dvc2EmmPzC0zmC9JHj4Eb5yWqIl0iQO7BCz3FEnp/s3Ri7m9b3YnrhM39UujdSNWhxCa
         enN3uo33/LmHMQaFdMt+jkMvaLl1fdqv//lE1uBoSKG1STiuuHBhNDWdQC9YYk0ubRg6
         wGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423437; x=1715028237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFLm7dyUtqCFeQ1Y3Oad/n2nmA3y2+DD3YB2hxxWLCM=;
        b=Ehfiel6NesZAyFsDtzfzPItVPvris0ct52bJ70OnN9c6CRtAVVLjW5Yozppi6Zf549
         25WuQdlM6HohyLqXAkViAjjnR1NPe+bI1QG/in1480X8+AVze6jCdnujjY2yJ/PRJYPj
         T1hYM2LD1gZa1hjaCPI+soMGl9GB5KDzpNErPo55R5R6DmHd+91oFXi+IzxIKq3DO2o6
         2TWTjhiv2phPksptsKLVhOu1S/VjHf7Gqu61wosolm+Pxc6k2vApgCg9Uz7PyQJ+nWt+
         O1Wdnpc0tYt69DzidY5SV9SOBEQoL1jGIhU0yS+vVaW9XhW2GtB0IdGI7Qzc2u3veJtm
         qjpA==
X-Forwarded-Encrypted: i=1; AJvYcCUK9hqXRmDVwGckdBIEhg3YWsRHeqvA686Gpb9pB6NwA1GtQWIcGKdO19SnBxw7OgLA0hW+TpETzresrdR4oZx7VUsHv9CfUV9h2YCW
X-Gm-Message-State: AOJu0YznpyUNks3At9wAkksRRmDVaYRccVstZl7iMPR+FX/u4X17kLKo
	8KxYzSLlW8Cjkhk9AWQKqQPWlXijV5i1WUwBgUseOBgYMAlv28/pAwO8owdO1hjXnJHqbdQ+I6H
	ABtAxoIfN1LJF1C4ejchWv+4979FGyN42mD7v4A==
X-Google-Smtp-Source: AGHT+IELY2zwLnQIzK1qbE3Sp9Z06BUgG4WlkmnHrcqV/8QmexyPMqSjZnChm2MVfRJ3gQJpaKv37A2s5enuif64LHI=
X-Received: by 2002:a05:6122:725:b0:4de:daa8:b8e2 with SMTP id
 37-20020a056122072500b004dedaa8b8e2mr9482653vki.3.1714423436022; Mon, 29 Apr
 2024 13:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 30 Apr 2024 02:13:44 +0530
Message-ID: <CA+G9fYuP7S+a89Ep5g5_Ad69EMwRkJ8nM+MMTzbEcP+6H2oMXQ@mail.gmail.com>
Subject: s390: clk-imx8mp-audiomix.c:363:12: error: 'clk_imx8mp_audiomix_runtime_resume'
 defined but not used
To: linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, imx@lists.linux.dev
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Abel Vesa <abelvesa@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, peng.fan@nxp.com, 
	Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The s390 allmodconfig builds failed on Linux next master branch with gcc-13.

s390:
 allmodconfig - gcc-13 - fail

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
drivers/clk/imx/clk-imx8mp-audiomix.c:363:12: error:
'clk_imx8mp_audiomix_runtime_resume' defined but not used
[-Werror=unused-function]
  363 | static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/clk/imx/clk-imx8mp-audiomix.c:356:12: error:
'clk_imx8mp_audiomix_runtime_suspend' defined but not used
[-Werror=unused-function]
  356 | static int clk_imx8mp_audiomix_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

metadata:
----
  git_describe: next-20240429
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: b0a2c79c6f35 ("Add linux-next specific files for 20240429")
  arch: s390
  toolchain: gcc-13

Steps to reproduce:
---
 # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig allmodconfig


Links:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fmJ3qzFbmI2ACNTo81vzzgQaLS/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23715243/suite/build/test/gcc-13-allmodconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

