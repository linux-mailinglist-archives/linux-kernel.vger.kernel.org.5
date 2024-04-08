Return-Path: <linux-kernel+bounces-134697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278489B5B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61826B211BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A217C2;
	Mon,  8 Apr 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMPJHXqW"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FE5ECC;
	Mon,  8 Apr 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540736; cv=none; b=qpj11xcRoHPmPzFyqJmBsNox57z49XMDmpmLtnE5RydW0Up1+c5Uy7HdsriQ4oKK0O6tkIttZEziuZe1Q6fzZYAaLI++101MQlB+OKUjE1XF9VFxU/T57t3Lic6Th/MbOCxXuXdC19X4sOvICfoHnQQIgJ9wWtE0HzzkO1CRFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540736; c=relaxed/simple;
	bh=80wXVU0FA/hD/9r7mzlnXEqv64o5EpXL8VLxORVz7rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kmRep/cJ7+SjNSQTclSSrFbZyq57CNu5ZhEqhLqWu9qZDQmNjvqWJvEynsJaTOGyLhdTEXRFzaM2sTp5Bjv5d5Eoho5cGk7Son089pXYTxAymxgi0GYMRYk2jXsY0L2ORAqnxPIRvU8W5fxdhMveaZXc6f5gWP85L0iDeCJkW9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMPJHXqW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso3483064b3a.0;
        Sun, 07 Apr 2024 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712540735; x=1713145535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6INmpdVq8nDJLvhHumZAqhjqX5sMDuMbtFJqhO6oNA=;
        b=QMPJHXqWBAbsabn1nLwRYN0etmUy8vXqf7b/EtG/8Nsyxw6YuMz7dLPVqhMev0P1OS
         mPG9oP337hpA1pn6eeQNTadKkKWQs2BdoyFxAhZFxXAE26p9kiBN6ltefHXZyeZAMtuo
         PabrLZ64njhXVvoxyuPTaYf5XLFU28GGLUTCdww46JQnDcFr0EyLqcizonkyV0uJAywE
         ov+xMH/nTVX05dLcMnRxrRj7XuLVrfvuBL/5LUThI/4rojLKk8ZrG6fCrpNIs2KF8L0I
         uQZ9fdHXC+WhYnn9+n4tqyI7YWddZ6FaxpBrk0E55KXbLoghVsvveGaZG5cAqPQJ5f2l
         DClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712540735; x=1713145535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6INmpdVq8nDJLvhHumZAqhjqX5sMDuMbtFJqhO6oNA=;
        b=OS46Mowkgw0h2ik6m8d/Su6rxaHh+B3dXEp485xj1p6TaTjvPj5K8BIaEO3oQMRyPS
         Od6SwupAl9iwoAYpdny+bFVOpxOLXGP+vRnZcRAyYqD0CjT72z8WhtssjmhbNLAx3tq7
         qw2U9KtOSYPnMfH6dqYTmoCvf1b79sTv9f/GEKH9Mdp8NIO4VlQrj1l5VFLa6sP6hiLK
         fE+MEfLWdrNuhTgmlfhYKWvSQgxN8q7eAXOt4HLXc4Ux5w3PW5MsAwhqOaT5X4SxfPkx
         D5RhDzlXajIgiJ2bNvCNxKPuIM7ZRT1C+5SDCZvsSj5Xwb7Ri0pNZTudtlS2q3uAp04/
         uaNA==
X-Forwarded-Encrypted: i=1; AJvYcCUFd5r9OMiA90OKuAwOxVL46el3S4R3pAelUoGxESESnh0gK6ACuabR66lkfV8on8gP9L4W0y5GlRi5zzBYQxw/6cP2OUjG7vBcBUbmrZZGj/xnrAtTSFLWX2PN4XB8G93oc1Qm59NvsA==
X-Gm-Message-State: AOJu0YxDQkMKv0RKJ8A9YwPUM6LkdcoV0rtY/fPPjIyheeN/pcn01Hcz
	OEECEeIqbMbVBcJAjAT2ayKRx8dq2RGmge1yiR35oDhubJuDMlz78b6xBKoInik=
X-Google-Smtp-Source: AGHT+IFob2zPqsKtH9MJSel/+k776HL7F/dl5GAA9EHC4jlsbow8xHj50rgsNTUB3Nbux3fuVMh0Ng==
X-Received: by 2002:a05:6a00:cd4:b0:6ed:4222:c8eb with SMTP id b20-20020a056a000cd400b006ed4222c8ebmr756169pfv.22.1712540734662;
        Sun, 07 Apr 2024 18:45:34 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id fx8-20020a056a00820800b006ed4c430acesm81391pfb.40.2024.04.07.18.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 18:45:34 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: sfr@canb.auug.org.au
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	v-songbaohua@oppo.com
Subject: Re: linux-next: build failure after merge of the mm tree
Date: Mon,  8 Apr 2024 13:44:58 +1200
Message-Id: <20240408014458.5084-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408091526.562c30e1@canb.auug.org.au>
References: <20240408091526.562c30e1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> In file included from include/linux/mm.h:1115,
>                  from include/linux/mman.h:5,
>                  from arch/powerpc/kernel/asm-offsets.c:19:
> include/linux/huge_mm.h:276:23: error: variably modified 'stats' at file scope
>   276 |         unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
>       |                       ^~~~~
> 
> Caused by commit
> 
>   d4358ee0a075 ("mm: add per-order mTHP anon_alloc and anon_alloc_fallback counters")
> 
> from the mm-unstable branch of the mm tree.
> 
> PMD_ORDER is not necessarily constant on PowerPC (since it depends on
> PTE_INDEX_SIZE).

Thanks!

There is a fix and tested by LTP, Yujie [1].

https://lore.kernel.org/all/20240407042247.201412-1-21cnbao@gmail.com/

> 
> I have reverted that commit (and the following one) for today.

Thanks
Barry



