Return-Path: <linux-kernel+bounces-66604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1A7855EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AEC1F24046
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C6167E72;
	Thu, 15 Feb 2024 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOPJA24N"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FFC69D31
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991892; cv=none; b=rccZjtGipcpreJmwk6zqp7brYndtfPhaU1oM3/tSYTRw/bGrVfSx7NcIrLZZCKdgujxGnfvWSDPlBuGfTJN2nWzvC8/LP02vlGnoNqU0VepYW0+bDhC2+Ca1zj/p9emxwGqq4f3gb2i2rOxfTHjuskXIgX4UOTnvEgU3EgJ0j50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991892; c=relaxed/simple;
	bh=a79toeYJmYUPXuCP+VQUzup7jbk+ihceTcg7eZEHkY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OKlzoRVsxAlDd5kWMGuNWh5k4QFZrzzKyjDLP8/aFdkK5tAS083no5PmZkc4dVWX76y2SZnotoIsLXfn2xbOCejZW1HImv0CWWXsB5/I/RCjerzMsWNvFEwDZck43pwODkYKKYL3AEA9E+eXWx4zLl9mUyOM+s5qOWI2M5b6xZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOPJA24N; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e1832d4dso311561241.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707991889; x=1708596689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a79toeYJmYUPXuCP+VQUzup7jbk+ihceTcg7eZEHkY4=;
        b=IOPJA24Nd9FuF+4+4+96AaYqxrsu+ef0BOletZk5/Y3Z96jQox6aFvhT5fq8FMcTqz
         cal0Rb05ty51ngJtaZlcbey/fyFayklu3DMb/fDs3CeeLIqYc3zC6zaJOF1oQHDlrP0m
         x3LvaMK5yWF1X0ySMRY3LRzdn7DVLRKRAkbd5i2wsNjiqis6KfhJP4omgtVuRnBRK3CH
         1wbsgeBjHgPxxmbIMVyC17NrS8YOOmRhpxfssfzfNMTKmqd3giP5LDYRdWmBh85HMEUF
         otzUf2y2owmfJoqntpebNku7hT06chswiBGVYoqPkLSBiFPB0d3G5m0E8mxmwFbjr1re
         ppcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707991889; x=1708596689;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a79toeYJmYUPXuCP+VQUzup7jbk+ihceTcg7eZEHkY4=;
        b=l6lwJ9qYUPixm4SiWUBUvUmeOXUxwh6vjYx9OJT/0BFxRlmjyn3Uw4Vm0bN0TyY44O
         audrLct+Slq0zdr0pQMyipCWf/rNUTxLvImI0G9bVUlyy1Qch8MhSZZNCfbbjTD+tqji
         FUgJWRtcoXUp2tdGE33v/Pn0r9NWldM11bsieyReLuqHdXks3IjsOA8pI3OBD9TXiwdf
         3x35u5fLc8XXhwwS1HWhMTE1rL/h+VfYf7bq1FHi1DABXJsRW0LF8kBXi1aFEKXvd7E7
         4dU16PM3345Gu2hgHO+lp28r8/6H3lR8yNo7Uto0Yj5kFFjoec9ScmdO1VOSyAShmIyk
         kNXw==
X-Gm-Message-State: AOJu0YxZ76gc26uqvswVA/LWJJ/Jvap242aZ8PU2Jivb/353J/M4iXKI
	NAv6y9yVwm829FXDigw8RdMLJxaOlV1Vj1EfP8sj2cMuMkSRwhPOwfaDbPe7xZJ26Jha8CCXqhx
	BCRIR84/rFpob8/JdI5M2M8RFmp9ptSk5Y8Zntf6B9aZ7UYKwda4=
X-Google-Smtp-Source: AGHT+IE4dAp0+3pjqzG/5JaQHmc+LoQBsUmyYeVIoxgjylBum1+YCV1FOUa5yOT/OCSjTws5nQmPvSW4yQBgfosYdig=
X-Received: by 2002:a67:ce1a:0:b0:46e:cf01:95fd with SMTP id
 s26-20020a67ce1a000000b0046ecf0195fdmr1108822vsl.32.1707991888925; Thu, 15
 Feb 2024 02:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 Feb 2024 15:41:17 +0530
Message-ID: <CA+G9fYuHF34bSbN9ktKuMAv1eOFVrf+Gw1MC_rG5trUQv9A_Pw@mail.gmail.com>
Subject: next-20240215: workqueue.c: undefined reference to `irq_work_queue_on'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On today's Linux next-20240215 tinyconfig builds failed on arm, arm64, powerpc,
s390 and riscv with gcc-13 and clang.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build error:
-------
aarch64-linux-gnu-ld: kernel/workqueue.o: in function `kick_pool':
workqueue.c:(.text+0x9e4): undefined reference to `irq_work_queue_on'
workqueue.c:(.text+0x9e4): relocation truncated to fit:
R_AARCH64_CALL26 against undefined symbol `irq_work_queue_on'

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cO8iztCdxtnbSeW3ekjN25sY6G/

--
Linaro LKFT
https://lkft.linaro.org

