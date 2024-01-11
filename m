Return-Path: <linux-kernel+bounces-23424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BFA82AC92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB23B23B90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024216407;
	Thu, 11 Jan 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hqo3GP2l"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD614ABF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4b71e8790efso1179600e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704970400; x=1705575200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2BxDnRoz+tciUL07Ky2uFARoSUgYzDQPvPnOjHTato0=;
        b=Hqo3GP2lJCMKqLmYn2+9q484HUZWZtzf4WfqHBTv3jtDgavmGh5V4ZTDzf+zF3b09Y
         9HwqlCE4aeGeuT61qxsG+6e2mX7IGSXgO/VRlPIY2Ml1E8R09oQ48Daj9hSNI+lHQC0D
         +SNvC5VUfrz9LYD8R7/bVw4XGmZxUhpYZN0jwaO5XmYlnVxfzXDjh/WaAsE1esmeR0WA
         3fuxDERF/StbK9mU/+4oxlPcAkN6PfGyYxJT2ZamMhfrasnupQns338wKUljxEBqf4tN
         QUarxmOQHbi2yrBxe0lI7y/v2LH2fMmx/IW/F1phr/zyN8boO+zGSKnlj/JDzVCOWVGe
         du9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704970400; x=1705575200;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BxDnRoz+tciUL07Ky2uFARoSUgYzDQPvPnOjHTato0=;
        b=fstv6sqABzjgxg6gkPap3RRRy65ICS6j318zZ6Jv3D38nYS6A5CIYO8e4T12tIHmVV
         S0BDIODcu7eGQZEA/m/N/j4VeX6s9SKz30RR5VuwK5Hi+znOh3qGe3EkGYAEe6G2+Ymn
         Now3xnnQXgGzVlmB8+yi3jozYjtgLcd54fHozjv9FE0xFTWAc8G/Ma/zB2oNVVdlWmBi
         7IgLFSkkLIHJyYtL+FsmxE1906fU8bHvImn8z7CuoXX8Asmvfyf5J9cyKYkVhZo4c0bV
         g4zLWLYsM/Xjdr4bK/Km5f3tSu2DtXUptBzPc0G9ewV9GvVU+mOYE00LD1NyR4wT8WBr
         189g==
X-Gm-Message-State: AOJu0Yw+pny1Cs/9ahInSHYQXkhswGAl3PdioiKFfBaVN2lJEiolsyR7
	4UycZHuwvz/NmINlXfyy0IO36Zt97Of4m/TvXBrjk6RatSG6VQ==
X-Google-Smtp-Source: AGHT+IGgSmqv9Y1WJTe266dMtLWoOwKf822h2X6Qyg98fN6FvdHnX82UlDzXJD8BpoL+3lFdSku871Xabj7RMWn9Q/Q=
X-Received: by 2002:a05:6122:1499:b0:4b7:8d7c:3483 with SMTP id
 z25-20020a056122149900b004b78d7c3483mr254720vkp.19.1704970400539; Thu, 11 Jan
 2024 02:53:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Jan 2024 16:23:09 +0530
Message-ID: <CA+G9fYvDNksfKNvtfERaBa9t2MJNucfD_s3LgKGw_z2otW+nyw@mail.gmail.com>
Subject: mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
 used here [-Werror,-Wuninitialized]
To: Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>, 
	lkft-triage@lists.linaro.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Following build failures noticed on i386 and x86 with clang builds on the
Linux next-20240111 tag.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
----------
mm/vmalloc.c:4691:25: error: variable 'addr' is uninitialized when
used here [-Werror,-Wuninitialized]
 4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
      |                                       ^~~~
mm/vmalloc.c:4684:20: note: initialize the variable 'addr' to silence
this warning
 4684 |         unsigned long addr;
      |                           ^
      |                            = 0
1 error generated.

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240111/testrun/22036090/suite/build/test/clang-lkftconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

