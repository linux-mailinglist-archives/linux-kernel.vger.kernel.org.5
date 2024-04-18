Return-Path: <linux-kernel+bounces-150485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD4A8AA00D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F889B236E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E5172790;
	Thu, 18 Apr 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iXjnS7tI"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39A171E5E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457912; cv=none; b=GbOtCOfqbJNYPLxp/qPzhQkRGxV1QlWsWsL09m6roBu4IIv0Mf2r8cePngH2bhxoFuLRyK+pLQg9Q14353Dg81ClunUuLUAa0nPI5EkKmWRlrZUQgCEk5pacrnMWJjOqrQOgLH2+Z/yLDZ1Y1oWiMbX4jEasTi+K8SlWADY0dPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457912; c=relaxed/simple;
	bh=reTusRmlKdivguaCRBJs9NeNASz4hK8OyNTz/hTvqXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tSylFOGxzSMAUEMJdujUcgVYz6HoTWaNSHzasjEWlqprhbHZJVA8bYwEHaCxAsyS0KWzZl7D8Nfm+7XAUabMMzE79C0SCNULVwdq+dw9iIeqnWny3RAGqQdEiKdkyr/0i7jRkOZcOlzXx4fKdGp7ItgetpIwV0ToitoW0POQ658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iXjnS7tI; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ab7fc5651so19327477b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713457909; x=1714062709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYz/Mm7XL97gcC37XQSh6FT+KtzHg82q93nX3l947mY=;
        b=iXjnS7tIyrM3FrBP7okFcGucQozESAuGdo+bfSadeiOxemf9xX8GCXlgIQcouQO1Ir
         3tVVyTioNzKpKkyN6CU0m9Jsbg7nANNN1RqhEFEUhqhiTo0FiB4cpsHf0ic0f8ddgard
         dvo8zU1dISQIW5wQdo1m+86UTCJeZ+I8JKHRYo2asd+388ODfem9+ycbx3eVSOoMKQeg
         0TB+baJ2TbR1hi5CM8mMvMwjVc/MFqWP+CTOQPvIG1pws32e6rzovQGcfQ2qAnidhqMM
         PyKkc4M84euSg1cOEGuqPGzjtnZG9JHEZKBZ9y6CIFG7qKAiblhRBbZZUIpJtrhOoeAZ
         rXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457909; x=1714062709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYz/Mm7XL97gcC37XQSh6FT+KtzHg82q93nX3l947mY=;
        b=h4dYFcBZZK4w7w44ZNe0gLO2DwfCbpfOagKel0ZeD6f8DbJkvxHpwbju6SFDjg2RmA
         BjHGpJUIiiUWTfH/1AhuWpVW62kvo/BDgbwXOFkzd4+hzFa3R8m5boYuPfL7Akt/DWgL
         7tRjfOvNpA0LshSNlWbh+2eIeDM7YMpmPRBOvf3O956AZ4AhqhnWSdtmgER+eRbcB7wY
         tvuF8ZwYMhOnm+l89ZyTvPHe9aQltK1Id+gn7D/NJDUC7MXEG5XV7XQiMLZJfVqPiV/d
         me4R6ZqHTTvDdDc8tJrTsEOaVYCeUew6VuR0cNfar9yAjnV0MvlNkzr08tbldqb7uTZl
         9mFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV60UhaKp8uetp+P01suskPVpPOO2+84HZbdFU+2S5JJjm46Js0+wYZV+01TfL1+l8rSmxPu5yowa7PWPz3qyMcAiLK5dkeHryxrG5E
X-Gm-Message-State: AOJu0YxeCliBZtSPC4bHtLE/5/RFtALyKfcTH8gYkhrC28lKEWqaa1SA
	XMzueVLSe0tiS3TC9WDi/Hk6ka6jZE7JqfTq2quGK8c/G/VC4AubfM3rnQjpeDAO4OfziykyO6x
	5Kx2RXuV89wiN0ukUL+MUxOcrNw==
X-Google-Smtp-Source: AGHT+IGRr7uB8dyL1qZY2tNdLCo6bCgG9f2Ylok0Sq5MdDUUM2WXBpExMqrkM6rHCoVTKgjGEzcyP05psJEyfeFP8OM=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:2b08:b0:dda:c59c:3953 with
 SMTP id fi8-20020a0569022b0800b00ddac59c3953mr882660ybb.0.1713457909290; Thu,
 18 Apr 2024 09:31:49 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:30:25 +0000
In-Reply-To: <20240418163025.1193763-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418163025.1193763-2-sebastianene@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418163025.1193763-5-sebastianene@google.com>
Subject: [PATCH 3/4] KVM: arm64: Fix the identification range for the FF-A smcs
From: Sebastian Ene <sebastianene@google.com>
To: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org, 
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com, 
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com, 
	lpieralisi@kernel.org
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The FF-A spec 1.2 reserves the following ranges for identifying FF-A
calls:
0x84000060-0x840000FF: FF-A 32-bit calls
0xC4000060-0xC40000FF: FF-A 64-bit calls.

Use the range identification according to the spec and allow calls that
are currently out of the range(eg. FFA_MSG_SEND_DIRECT_REQ2) to be
identified correctly.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/ffa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index d9fd5e6c7d3c..146e0aebfa1c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -9,7 +9,7 @@
 #include <asm/kvm_host.h>
 
 #define FFA_MIN_FUNC_NUM 0x60
-#define FFA_MAX_FUNC_NUM 0x7F
+#define FFA_MAX_FUNC_NUM 0xFF
 
 int hyp_ffa_init(void *pages);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id);
-- 
2.44.0.769.g3c40516874-goog


