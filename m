Return-Path: <linux-kernel+bounces-90202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FEF86FBDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D211C20FD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A98A175AB;
	Mon,  4 Mar 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NepbIKKQ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59B17555
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540995; cv=none; b=IXrEBwcUGZLyN9MnqzaW4CQwe9qzFROD+JanKbdZU71y2bwR8xbvnjpCGIinHLN3s+b4u3JDj4U/0ia9Kg1+Rt1iwFucfpgChzo8A6ZfJrshx13ahxH8ND+2P4rEzgyzgilKDs6CSHTBA//pcNJbALNq0oKO24F/NuVBpLMqwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540995; c=relaxed/simple;
	bh=855HXyumfO4lGoRTJldMzwX52GXeoZJbsylC1zXFQTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BnZlovhQGWLZcl1+GltUhlJh6Cs7tzTXQGzL9DHzj8Y9syidf486FpOMQnCQM9xbQrLVInOqwQATtRrH3zua/puLSnbJQgQvT9/lGLsuQAy73CyxJXIYEUM0sCVmaYBr6qo/w4+y4gbQC8nOlzrM0S9TBbEQTr8GfzA4JN+WRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NepbIKKQ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7da6e831977so936929241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709540993; x=1710145793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3GGlCV181E94WRidZ0LVeyv3WpChZrfj0kDrJP16hM=;
        b=NepbIKKQkiT2k3aHrM6dwLDoKiNhF9FAKEDSNZqv3MKqymfNg8q/Zn9PCg75/CZDq2
         b7rBauO0tt0HzO54Nwn4iKBfYb8NJxdtAMUgYkPMWEPIo9epJXIFcsecRvTUXc5ZmbI/
         cr8gUJFK71UonSOccGMQvN9As7vMCsXeinmwalULISHOaZ70C4huPe2qrbi1wak/PVRH
         sS00rp4NFHyAoyW86tVVWavDUmadrC8jFnnLPuX2VG+qDE5OtlwNjrIgwOw7sXz+wq4z
         UhJoM4I3uuIhnOwCfJ75kdACHEeTt92OVjbzuqihRLOiKew8MfXAhwhDWZEdvFB3tR8b
         iMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540993; x=1710145793;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o3GGlCV181E94WRidZ0LVeyv3WpChZrfj0kDrJP16hM=;
        b=AuIssipL8Ns7XvDDHNUYhkYaWW6z2/s5oE1jdqR/sKhdRX2pvq72Sy/8C30oHZ4VxJ
         9fzTB3U1AI7TMi+R47mRjCWwnVdtxurWousekPi86vLHPIJVDpy/Y8T6BlqLOaseocvt
         aZbWFRA6fkp7+kmw5XgWNKrEtCDbUnctoAX88GBeFqeLxnvIYf9eEf2DTOlKWpcnrB7u
         4zCertUNrKW9rZyPTkAU/bWiAUQHUaeL5WGA1PGltPxfawGTMEohrgRjLAdleXNaRF8s
         T9UDhzEjgC+X/BlYOsnIb8oBgT+3BWm95HT2miv0XHR1hUTD6dW+wATvTA5ksSa/ekTv
         xV2w==
X-Forwarded-Encrypted: i=1; AJvYcCWkJGL30Uf18v7YcJ37/s4OA7DEtDzWT4eQn8dpEs2y3HKG5tc4QprVl1V35tPxrATN9LxuSZJQj6bNNyQ4OYuAxSMEvtcBdGd2luhO
X-Gm-Message-State: AOJu0YwcNu60QuwMfibKpyP7uBdSb57JbAVGZiX1lBJ3PHmnPAnwsi/5
	ZavJWNX2vARAAqrOw1cFs2ccWfQ6cAZg7MTsfezZew5cwuPMIhyF8lWKKgZyfJhADBDU7tLlJge
	dQrqf9P4OYWp2DWQW+czhgSUDtTUv0WVXjUf2wA==
X-Google-Smtp-Source: AGHT+IHMSOeh5GY6I6DXd64OZ9n7Vyuo30pfgw0GakfsMx5QkuNzPAp++atjVb8SFBMEn59buE99Z2AdIPWEWcDK/iQ=
X-Received: by 2002:a05:6122:80f:b0:4d3:4ac2:29f4 with SMTP id
 15-20020a056122080f00b004d34ac229f4mr4865194vkj.2.1709540991914; Mon, 04 Mar
 2024 00:29:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 4 Mar 2024 13:59:40 +0530
Message-ID: <CA+G9fYuxkL=naKEvQtGtgLq9aemoO5i4q=D3snaDtnQMnbFj8w@mail.gmail.com>
Subject: include/linux/vmstat.h:508:43: error: arithmetic between different
 enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
To: clang-built-linux <llvm@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The x86 clang nightly defconfig builds failed on today's Linux next
tag next-20240304.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
In file included from include/linux/mm.h:2208:
include/linux/vmstat.h:508:43: error: arithmetic between different
enumeration types ('enum zone_stat_item' and 'enum numa_stat_item')
[-Werror,-Wenum-enum-conversion]
  508 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
      |                            ~~~~~~~~~~~~~~~~~~~~~ ^
  509 |                            item];
      |                            ~~~~                    ^~

Steps to reproduce:
 # tuxmake --runtime podman --target-arch x86_64 --toolchain
clang-nightly --kconfig x86_64_defconfig LLVM=1 LLVM_IAS=1
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dDE2PIbgOKyvV21FDe74HgYh8l/tuxmake_reproducer.sh


Links:
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22918589/suite/build/test/clang-nightly-x86_64_defconfig/details/
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22918589/suite/build/test/clang-nightly-x86_64_defconfig/log
- https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240304/testrun/22918589/suite/build/test/clang-nightly-x86_64_defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org

