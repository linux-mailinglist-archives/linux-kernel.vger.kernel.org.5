Return-Path: <linux-kernel+bounces-111888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8353887237
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6377E286354
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16C60884;
	Fri, 22 Mar 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYDitwiE"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BDD60870;
	Fri, 22 Mar 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130008; cv=none; b=Y40dH+Zov3OlX+DmGtmTYiK7T1tkXZseEhyVUXUG1LBwwoFzEb1rIri88+ecvFRtItMpwxk21uiPR8XFXctT0PHbPvNRMhtb97oMgjSnB+0hqt4KNBSr2/fR9608q55jdHFCDBfvLdJF/dctzZS6DMV5874Hsewm0GHMI1Uf3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130008; c=relaxed/simple;
	bh=3okg2nCtpcHovwhd9a5YOgqHuxf374h/daEvN1hzJwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e+vqbx2jR73so0oWSjz1fUx6A2s9hNQf0VX4i1Rzy+XDAwL5pWL7Co2kjlT4E8oTYK6RWwP+3tlyBNDffazYwZHOcDTC3ZLmkNc9TPlYXsvFchM3Ci9kG+YLR/HE0Ig+t9+G+xNHjbSQbvH6c4nWmsCYE4wpHa6iSdbvOXYU8fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYDitwiE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41412411622so17460365e9.2;
        Fri, 22 Mar 2024 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711130005; x=1711734805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvXjyZRIsX3lCQckyZs7+3J5BKrWLMCYkqrtzm7pV+U=;
        b=HYDitwiESpmKjW3FZIf/fq6/4nkzWoX1hNByR70UW7dvdaAHwnF6GEU/gql4XGT/5h
         lZfNs3vKlDpp51rA7+m66KNnvqm1nU8IZQeYKTZXAQuve4dKDeJRzutN7JWwuQfI0hms
         +y3V1pltump+XefgAVyIEJIDq0bKAy1r9+RGC65ov14p8BVu0WULWOo38u6ur1iQa8L9
         MJKwT7Fplc32pKIm42r585fLDV+Y635vo4AYRngCV0OonRv16eCVB16T4OBdHQtbRxtt
         pjv7vJOmcD6syNgckwEmFwzLw4lBh205GI3AWRN61IASjcKlgJo5/G5Axu5tj42+VKFB
         pUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711130005; x=1711734805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvXjyZRIsX3lCQckyZs7+3J5BKrWLMCYkqrtzm7pV+U=;
        b=v26AiM8eR3V1DX/GcYZtQmI4aynMbGyES3Hc6q72Aeb+/3rfw0Zb9xPXjD61jWuLHb
         Rjdnguf43ERmjOzdrIRXTQm8DJPzoDhifLqS//85V7GT+kxQ8THN5/BO6ESpybPc/lou
         4UDkOPSP2wh1dsPK0nPRyrNxWFvf7zAnSVExhkC1oSyuOCzTb6EiwrVsp3PN/ZskzCNY
         e7Kx90EPcbl3i6tP7FJ0cewMKu9AutaATX2d4gvDgb9wmtv9IMulMz3JOBQ9XD5NJKor
         BXZyyp+XmKOYUrgl5ZGv3UmC+PMMGINQH6v/vk/bQo4uuzgBnilYWsdsz6AFBaEP53Kf
         2Wwg==
X-Forwarded-Encrypted: i=1; AJvYcCVGglLm1RSm52mpJa8R6J5Ty0xOsKLKdwqsIuoQF/4DcuQbB6RPhfHLZfDXK0aGrOfdbU9jd7iqpDV5UhvDVmxJtlPa4Zk8Oym6Kcys
X-Gm-Message-State: AOJu0YyB+33fzSmUlhqGqWFsvEYTGKRzPf/qIGWqlxa6HEnyBhWLTgWC
	Jzncrr+Rozp7GIE7ski8zykbe3uwZ6OQ5zYJto1rERCYZjOR6ReK
X-Google-Smtp-Source: AGHT+IHxjHPv/v+DpHWehxUnaB5GtSMqzhtlwIDZzBh0n67GjHG9uFAGtqczAvCRNa6q2nNvmOdnWw==
X-Received: by 2002:a05:600c:5843:b0:414:63c2:71bf with SMTP id ka3-20020a05600c584300b0041463c271bfmr32880wmb.41.1711130005267;
        Fri, 22 Mar 2024 10:53:25 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0a4d00b0041461a922c2sm169508wmq.5.2024.03.22.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:53:24 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.9-rc1
Date: Fri, 22 Mar 2024 18:53:07 +0100
Message-ID: <20240322175308.2289495-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.9-rc1

for you to fetch changes up to 825b82f6b82aa38dbb771d24e135152012500e51:

  ceph: set correct cap mask for getattr request for read (2024-03-19 14:35:55 +0100)

----------------------------------------------------------------
A patch to minimize blockage when processing very large batches of
dirty caps and two fixes to better handle EOF in the face of multiple
clients performing reads and size-extending writes at the same time.

----------------------------------------------------------------
Chengming Zhou (1):
      ceph: remove SLAB_MEM_SPREAD flag usage

Xiubo Li (3):
      ceph: break the check delayed cap loop every 5s
      ceph: stop copying to iter at EOF on sync reads
      ceph: set correct cap mask for getattr request for read

 fs/ceph/caps.c  |  8 ++++++++
 fs/ceph/file.c  | 31 ++++++++++++++++++-------------
 fs/ceph/super.c | 18 +++++++++---------
 3 files changed, 35 insertions(+), 22 deletions(-)

