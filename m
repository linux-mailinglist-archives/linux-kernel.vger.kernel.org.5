Return-Path: <linux-kernel+bounces-74994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A248C85E10D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D296285EC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB1580616;
	Wed, 21 Feb 2024 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc/s94Xx"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A37FBC8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529198; cv=none; b=pyER7dYxisFIkc0fHJbYpdkDoe5uptU86FDJPIeG5YmobLnhaklgqry8co87F1czlappLnUasqE8ODq2nuTCDrt/Pcelkj38eLWSvLRTErHP74xJiW34I5J0RcEhgyGVq2U90mzd/+DjDHJAAqoMUZZX7A+NN3x72XvZkQymchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529198; c=relaxed/simple;
	bh=1vQ0qVKigz+/kTXg+CH8iBbZfUJZzhzN16scoXvXRQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exSi4ksntJTmMpXDO6jl+pDRl/9S9MvRwqcm4qumZg5cslxqpk8F7BbL2H3MA2AKlw6M17UvQadTfbjBFidFdoM4h1t+PxvbejdOWGJlk7+06+RQ6Td0c/+NxdzCbHHI5kIHu4nD7flJhUdcNt2WVx7DlS1UC+W6BE3hkjW+/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc/s94Xx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so557389b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708529197; x=1709133997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW/wH8Bxvy6vIw9lSkZQNzRLcUxp6rWTmo8sEe8KFwU=;
        b=Cc/s94XxcZJclHTxY84zkWD7inHG8xawhhF/WCMtevACS6jQAMiC3RDx6flv6ulYTf
         6Oj99bIYb+E4ZRf8WAi1EQP9M9cWJ2YCisY0sjAvSLB08wmtoyp/pS4cEuWna60zZGak
         ZoqLF6YlDy/gm7q+dYomReRN036L2ZnG4Z9EqFqpQTrQ9Bovo1jOpo1t8byjAr/2+CUo
         PeuM/gk3GYwseKMK/rhNAjb0gVS9sXEdAvDL64vYOkD6cSxcagd65K464rLg33cdze6q
         uhvXEXWxPAENeBbG2DZbQpbt9zP+snjv/TtVJydLU80a+QI+tJC9UwWsgwNd0ay7Js3h
         IxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529197; x=1709133997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW/wH8Bxvy6vIw9lSkZQNzRLcUxp6rWTmo8sEe8KFwU=;
        b=rJp7K/CB/S4gIsZFdvlTEOEPOPyJHDR5fbl/S0iij/LuOrpjTywOzh/0Nj/NOug43o
         Ub2DPVNNP9o2vcWX7Qjh4dVWGHRC2NCtj3GF2nvSytkZs/DRnO02RvieqV7nk4hTHCnS
         eiCLyuJX6ATFosBGQGE38WRQR5/YXUCJct7Syy7mSv4SNV5eEIrZFJumn+4o1/7bHX0J
         qars8VOSpClab8X85C6pvg16Ltl/O+G3DMscZUIHMaooBXzcxpYsJnrbm9nw1HOoM8p8
         pgTbt8AjTdS/4BAWQGZKvaFC1gPUH57rfxZrPVhAy8rHv5Md92K6hCw70veUpAX2lvQd
         YMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXz4e+u837aOo/WtHzRGNHP4Rc7gm3CTOpIunHyXsWRHrw9X1TYuUeCC+CVVysmAJRpgEYtFGO5WK8jK+6sMHT2yzBmwhQO9ocVIAsL
X-Gm-Message-State: AOJu0YzS2QaO9mbPJXKMHAknoMLplUDWoI0d8E8olVmiXw78hXCMcCWP
	JY3XRs4vu6u4JNRfVDFMe29zqW1DOjzvECYD9/J2w7BzkawWoi0A
X-Google-Smtp-Source: AGHT+IEt3BD9AeWE2Q2VZ6pJE2NucbpYuT5K2Ta/OzpXuZ/4vRBzk1AoIfF/xKdkIbIGN436T6HTyQ==
X-Received: by 2002:aa7:8652:0:b0:6e4:6163:7e05 with SMTP id a18-20020aa78652000000b006e461637e05mr7953591pfo.6.1708529196847;
        Wed, 21 Feb 2024 07:26:36 -0800 (PST)
Received: from nilq-virtual-machine.localdomain ([60.24.211.11])
        by smtp.gmail.com with ESMTPSA id ka36-20020a056a0093a400b006e48e0499dfsm1619085pfb.39.2024.02.21.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:26:36 -0800 (PST)
From: "ni.liqiang" <niliqiang.io@gmail.com>
To: will@kernel.org,
	danielmentz@google.com
Cc: iommu@lists.linux.dev,
	jin.qi@zte.com.cn,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	ni.liqiang@zte.com.cn
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is successfully written during SMMU initialization.
Date: Wed, 21 Feb 2024 23:26:29 +0800
Message-Id: <20240221152629.3656-1-niliqiang.io@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219091709.GA4105@willie-the-truck>
References: <20240219091709.GA4105@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>  The SMMU registers are accessed using Device-nGnRE attributes. It is
>> my understanding that, for Device-nGnRE, the Arm architecture requires
>> that writes to the same peripheral arrive at the endpoint in program
>> order.
>
> Yup, that's correct. The "nR" part means "non-Reordering", so something
> else is going on here.

Yes, the SMMU registers are accessed using Device-nGnRE attributes. 

One additional point to note is: in cases where there is a failure writing to the CMDQ base address register, the testing environment was a multi-die, multi-socket server. This issue has not been observed on a single-die server. I apologize for omitting this information in my initial patch submission. 

Over the past few days, I have referenced the kernel source code and ported the SMMU register initialization process. Through multiple stress tests, I have attempted to reproduce the CMDQ base address register write failure issue. The summarized results of my experiments are as follows:
1. When testing with one CPU core bound using taskset, the initialization process was executed 300,000 times without encountering the CMDQ base address register write failure issue. However, when not binding CPU using taskset, the issue was reproduced around 1,000 iterations into the test.
2. Without CPU binding, I inserted a memory barrier between accesses to the CMDQ_BASE register and CMDQEN register, similar to the modification made in the patch. After executing the initialization process 300,000 times, the CMDQ base address register write failure issue did not occur.

Based on these observations and joint analysis with CMN colleagues, we speculate that in the SMMU register initialization process, if the CPU core changes, and these CPUs are located on different dies, the underlying 4 CCG ports are utilized to perform die-to-die accesses. However, in our current strategy, these 4 CCG ports cannot guarantee ordering, resulting in the completion of CMDQEN writing before the completion of CMDQ base address writing.

From the analysis above, it seems that modifying the die-to-die access strategy to achieve ordering of Device-nGnRE memory might be a better solution compared to adding a memory barrier?

