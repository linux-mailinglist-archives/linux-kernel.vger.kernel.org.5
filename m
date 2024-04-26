Return-Path: <linux-kernel+bounces-160312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF858B3BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08F31F251EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659941494A9;
	Fri, 26 Apr 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbukzY6p"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93C84E0E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145945; cv=none; b=ZMnE4OXQ0Oqqe+6pjcGyF579UEJd1zQtIXqRPV1Mx1XYs9yc5WKy23aCriSDufiKP1QuH0yGZKjTw4da4EiuHtuCAVAUNEzxzTMcVyWCtIHMfOWhGiHh8GvvUyei8l4DNWoNKNOfnDUPAiNWhHjViEYVWbXfsxmPH9lWpYcE8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145945; c=relaxed/simple;
	bh=oOicBQb26P2us2WSgoCUD13BKZ0dUYvLTrgu60wl+bk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HcZjzAluM4hw/miJHtjPG5P3oGX/MRKJ/SthlGNJlmr4YJwiGAaKc3HmOGxJy+WDoTdGXZdy8lS9IVWlHF1abSEAliPKnAkloikjwBfLVAcsGzvIq1ag4lfqoBRIQtP1ABmdMClc+n3B4AKvLw3GN5Ys22KE0bFGOa78csRrXl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZbukzY6p; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4dac4791267so699159e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714145943; x=1714750743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0fHzKICB2TUzI9lFroSAOrJgYaGtzTHDOl9oxitpToo=;
        b=ZbukzY6pw/8KirabdfK3VSteRcqk1MsJiFByuuL3kvCKCe3YhKD4jbVVLsjStmeEpz
         rK9TIXB/HcDAeozRqpqDA0QQWs5boNP6rhFF1rUBIZfsHXtKr4t5fQ0cmNf0aBMDgSMN
         Yh8aTlclWEf+ub69DUSUYZZj3RkGdhJTUuMvpripjBT53bq0gBiM13Z+r1vACHYIjaPs
         3wABHiryOy3QyOaDRjM5WZ4KjFI7eFguBkCNUpBnK3jcxvhCWks1m/vuoZwGDWKAz2Uj
         x1hFdocIZ62LNL51GGmb6kUzalEZF+E2rQGgIWam6Sb80VjsEgd7od/GQrJjwBqM3E/m
         s0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145943; x=1714750743;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fHzKICB2TUzI9lFroSAOrJgYaGtzTHDOl9oxitpToo=;
        b=sWGOlxYW9qP0h1L29SZcyxIDobI0IouVWDmjGZxPtNZ7otaoT2ByzRcpXdVk53wpgX
         ummP6a46w7c7awDs916Kc3Vvo3G+VzTy7hZsN4ZpcpF0YKNplLzIfQPMaotonzTHUgFz
         AyJs5h0LOsZnT1snQV+ShFZdmmfIsAfCrgUw5VuAuip84Ut4XsvODf850c/LBmyAXguD
         bhmespLH5ziPyLU03MKWWivkYMqYNPhrkL/9+ZO40n09zIaXqk5gvFaTrfSOXdWIgFj2
         kvsc9Bw+RjK4FinxxCjBEYROzbEB14UsFbD1ItWZEm3MCoupJztWLHilSAqDhLX4SjUU
         VHHg==
X-Gm-Message-State: AOJu0Yw7Q+8SeXaJojuRWFD4POCq1XD+T8m8XC3KFodpAArVuX+ZpRCT
	rTTrbaek9tbhE4oSlbaHsRovWrkymdiuffyH5DPztUr07vNyYbgpThcIi0+pHkJbDG3IdyoTlcb
	sI0BHdllC88o9bsN+cItXVMeVhTKxZ064S98SEzi6NSdRXrNpzp4=
X-Google-Smtp-Source: AGHT+IE+NCvzne4CcGECeY3GkA4OfEGj5ghhDPxk17Ojz7pXDSDSW3HmPLxFYaVkAQVlixFuEx8/Y06XrCSoUji5M7g=
X-Received: by 2002:a05:6122:4697:b0:4d3:45a2:ae53 with SMTP id
 di23-20020a056122469700b004d345a2ae53mr3142735vkb.16.1714145942808; Fri, 26
 Apr 2024 08:39:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Apr 2024 21:08:51 +0530
Message-ID: <CA+G9fYvy+3XKDu+U-V3dXLsUPm1ybR_vn5djNvxXnXr85U9UhQ@mail.gmail.com>
Subject: riscv32: mm/init.c:1495:11: error: use of undeclared identifier 'MODULES_VADDR'
To: open list <linux-kernel@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	lkft-triage@lists.linaro.org, linux-riscv <linux-riscv@lists.infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The Linux next today's tag next-20240426 riscv32 builds failed due to following
build warnings / errors.

riscv32:
 - rv32-clang-18-defconfig
 - rv32-clang-18-allnoconfig
 - rv32-clang-18-tinyconfig

Build log:
----
arch/riscv/mm/init.c:1495:11: error: use of undeclared identifier
'MODULES_VADDR'
 1495 |                 start = MODULES_VADDR;
      |                         ^
arch/riscv/mm/init.c:1496:9: error: use of undeclared identifier 'MODULES_END'
 1496 |                 end = MODULES_END;
      |                       ^
2 errors generated.

metadata:
 git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
 git_sha: bb7a2467e6beef44a80a17d45ebf2931e7631083
 git_short_log: bb7a2467e6be ("Add linux-next specific files for 20240426")
 git_describe: next-20240426

steps to reproduce:
 # tuxmake --runtime podman --target-arch riscv --toolchain clang-18
--kconfig defconfig --kconfig-add rv32_defconfig LLVM=1

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fdCURo2mABucb6hDzrLnPoTWMx/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240426/testrun/23674184/suite/build/test/rv32-clang-18-defconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

