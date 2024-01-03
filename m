Return-Path: <linux-kernel+bounces-15996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684478236CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C2228765F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0461D544;
	Wed,  3 Jan 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSUSl8M1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FA1D52F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3b84173feso21262965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315186; x=1704919986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ4JRJKWL48DRyWBuB3XtSbsG9RcvdWoDCSZAtP4TfI=;
        b=OSUSl8M1edinN7+i3gLRTvveDUI57Gtz+cS05iw4yhnds9o2odNeQzws/3NWE18PrB
         JuGpJhp8K4ZCgJHLjA8OyZTgGkIMA8+4aifW/MMAi+3VEniKWw2l8I/WBg1hxxKYXz9k
         ZBoAIvJK0FnRSmDGoSxghYAJPQZikT9Wtsl7+Gbhixm2Y5ml5Ub0XmjxflytA1GT+lm2
         3T1CqaE6YAWNi57H3KW/G5CSLnpXvFrm2wpIKwjI8xJyutsgZl7GxnT2L6iV6VuCW0nr
         xCoSttE9EaKQuA10uZwAvm5634PrkZ1Y39fVhdeS0EFd2wolvDIRUyej/LEWSE+/OLl5
         SHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315186; x=1704919986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZ4JRJKWL48DRyWBuB3XtSbsG9RcvdWoDCSZAtP4TfI=;
        b=Fnq4yBu2MldQe0fmhaD+YcABmhQgYqDXww0O7M8nstQCQ+j2TegU4w3gQE8uCzOKTI
         d2U7lot6l7p5j+UXUAdjS+R+9m75kUFOFFn8NK9BuScRfGd4SjngebnoBDr6o2y4gfox
         PO3OWZHKny0cnNk4d5g4PnmrQdfQsGoXpyPo9AQB1YAkkTNguIUY2wd6n8zKU3MOLdhg
         0bOtDHxXZJIh6jm/m7oltML7V11VUy4FquLb+r/S984mG0+2CqdOSCc96HTPOrGjWp+t
         /nsGCQ+mttqoMRzhckrmbnTqmWPcte3LRTBDK7u3ESBrgWYp30iBp+dXzVk7GgiDcfFG
         +WuQ==
X-Gm-Message-State: AOJu0YzRfK3sGvRBDH9kK9+UnyrP8xbB/BSJlcXvA+8PUKJ0i0r351o4
	v+c2bMRT3qyeVt8C0G2Bl4Y=
X-Google-Smtp-Source: AGHT+IGG7Dd7tKUSXxPAtDoTJg2TkO8vOL+0vxy0n9Utce+hO2vC7j6i4xsQWyZf1idb4UYBv93X0g==
X-Received: by 2002:a17:902:bb81:b0:1d4:abcc:ee05 with SMTP id m1-20020a170902bb8100b001d4abccee05mr14907231pls.3.1704315185541;
        Wed, 03 Jan 2024 12:53:05 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001d47d37d361sm13900434plr.154.2024.01.03.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:53:05 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] lib min_heap: Min heap optimizations
Date: Thu,  4 Jan 2024 04:52:57 +0800
Message-Id: <20240103205259.2108410-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The purpose of this patch series is to enhance the existing min heap
implementation. The optimization focuses on both the heap construction
process and the number of comparisons made during the heapify
operation.

Thanks,
Kuan-Wei Chiu

---
Changes in v2:
- Use a more consistent title: "min_heap:" -> "lib min_heap:"
- Refine commit messages

v1: https://lkml.kernel.org/20231220083224.3712113-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  lib min_heap: Optimize number of calls to min_heapify()
  lib min_heap: Optimize number of comparisons in min_heapify()

 include/linux/min_heap.h | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.25.1


