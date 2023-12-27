Return-Path: <linux-kernel+bounces-12060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD281EF8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16D22822A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A704594B;
	Wed, 27 Dec 2023 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR2I1hg+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6614502C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4093476a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703688581; x=1704293381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkGPszZg+bkMDC2+6bc9aA8zr9G0a3W4ZkTQIcxWRD8=;
        b=fR2I1hg+ik2Ni0ap0u9BYkdWh8qlshHVFn+VhK+44EGh7r0oxNY5lIhZb86kECnq3b
         oxafnpnKLgeb/kQjqPMayV08k5/OGhYiilcIJ2y9j6i3+QzvKL2V38FiMpY0AjI8e2JA
         /qPYzyn1c8EVjgM6TANE2ZAOa5ggoO7vkO+jh0PCiJDsR2QlXbe3toOgwWlf/7/RmpcI
         6ytRZqp94+tx6jaYghgNE5AE4+MNIPZaTsvjLzd4g692ptzcKhri7cuOBEphp4C+u6kx
         rCSteg+zn68C5HcUwrl+PWz7NR8/MSNIpH4tU+S+6ZMRFx/LNHTEWKUZ/oblUEW4GTyA
         MB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703688581; x=1704293381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkGPszZg+bkMDC2+6bc9aA8zr9G0a3W4ZkTQIcxWRD8=;
        b=G8V/wrtRT45kIKBIe5B1HAXh99SWU3+b85ezpJq7HQVKpV1ppwHrDnDyDJe5ng4OEf
         7QHcsxmIBH5om56LMVxARqmIWzoJnSMbG5NJA5O/awBGDr4ByINb1+Zs0JSJyHqU7oQf
         tAfPT34tYJAEpVDGwYQergc0LvM3V7daDY3vcOti4zgOP03VsI/q6oTCiSI7MFMaYxnZ
         T3UF43m0mc6Q3652OfywqdPF5OGvqUd/aHx38xvlXQMW62STpNaO7LFGSrpGbd+A3Cf7
         LzRY/J9+wCM4/w1DBqvTxBPx1Ta1B033GXteW8iZ24XF4gjjtnsi1xZti/8XGfgu1q61
         yfAw==
X-Gm-Message-State: AOJu0Yxo+SShPueNRcgEPVc2QK8JiRu+6zDkbQ0/RSGdQev4PvnX4MRS
	WBt7y3/cjHKbi/jB1ygI6EOllMz6VKs=
X-Google-Smtp-Source: AGHT+IGVKWxwPiIXp9SaVE84AZ1aUth+X0aU9aMpOKmbiWYclq9e38oJRohPhY0RkgrW3aUR4T/CmQ==
X-Received: by 2002:a17:90a:51a6:b0:28c:c31:244e with SMTP id u35-20020a17090a51a600b0028c0c31244emr3775116pjh.59.1703688580844;
        Wed, 27 Dec 2023 06:49:40 -0800 (PST)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a6b8500b0028bd0a43bc9sm13810502pjj.2.2023.12.27.06.49.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Dec 2023 06:49:40 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Naohiro.Aota@wdc.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/7] workqueue: Share the same PWQ for the CPUs of a pod and distribute max_active across pods
Date: Wed, 27 Dec 2023 22:51:36 +0800
Message-Id: <20231227145143.2399-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

A different approach to fix the misbehavior can easily be exposed as reported in
http://lkml.kernel.org/r/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3.

Lai Jiangshan (6):
  workqueue: Reuse the default PWQ as much as possible
  workqueue: Share the same PWQ for the CPUs of a pod
  workqueue: Add pwq_calculate_max_active()
  workqueue: Wrap common code into wq_adjust_pwqs_max_active()
  workqueue: Addjust pwq's max_active when CPU online/offine
  workqueue: Rename wq->saved_max_active to wq->max_active

Tejun Heo (1):
  workqueue: Implement system-wide max_active enforcement for unbound
    workqueues

 include/linux/workqueue.h |  34 +++++-
 kernel/workqueue.c        | 217 ++++++++++++++++++++++----------------
 2 files changed, 157 insertions(+), 94 deletions(-)

-- 
2.19.1.6.gb485710b


