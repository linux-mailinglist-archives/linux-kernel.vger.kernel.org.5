Return-Path: <linux-kernel+bounces-48284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44015845998
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0149C290B4A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA655D498;
	Thu,  1 Feb 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g02T4Lg6"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB8F5F481
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796308; cv=none; b=PEKaNlIVgfg3g4xxLlG8hOfivaHw+epOi+zs+bu43QnsMW+pIErWvDmi9qCepNgDi87/F/fK5M3/ovk4tFhW/mWwEyybFcoHWDTfSaaDdG9DsoL2ymdM1NHVLobsZlL07rXgFGZ6wnm5ZhvlOwFbCYi0hLMYg7frwRJlFQvdFWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796308; c=relaxed/simple;
	bh=v42P2k72Woz6J76qKMysoIc0sUzF3aS1VgyWO5VKJ0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoC5UC0YfhagrLggNDWk/AZ/LHZkLwGT/o41aMINFgsofTug/H6LGRho84WkDCh6xfQjS4LvF0LERjVWnztcvyaQ9pF+ibF5Dh4GnogcJ0ZyaSt/jvrBUNW6vs/fhVHH0JE9vo7eq8kquScn//ILDEHXGY3NxH3PPXAH7SQhTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g02T4Lg6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb804e330so8878825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 06:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706796304; x=1707401104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/n/G7y1xsFEdDjXEUwUFzAE/EZFxG1nYhtSYneXxk4=;
        b=g02T4Lg6gcOukHuO6jdKe1OFe2LDG9bQz+n/9s0YKePkxxs0sWCjSiU4J5Fa0aPz4K
         2HCJoesbUF3jmBkjtsbAkFwdPqkpWAzGDK7BXFv98TLFltssE9zBmGRKS5WIOjTe1L8L
         XQeZTdn6B/xIhpM86DKvAQwSFtTxikzmP5gLwv+Gv5AZUTyNWPE7QJv2J0i6UGgMRK3b
         QXIStiGbLy3unBUAvY41sJhxQN4KTdsroGd7lwEKe4S33VWg7vNs7O35qTepBN7Wl1m7
         rwR7G7kkQnBy5QLiYWpqYJT9mj7GFIE1hoVvGUzcm6ql5TSJLlZSG0uqdyMK46LrsLU+
         CyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796304; x=1707401104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/n/G7y1xsFEdDjXEUwUFzAE/EZFxG1nYhtSYneXxk4=;
        b=ISd+VMr8seEEY2bQMvcHOeeAVPN/MA+AHcU/Ybz6BL2YPqfqYi0+alDdp+t+Nzt5z6
         eTegJy3Sy1VpPVkKoR0dsMQBDgxY90Sqinc40ooD3SG7LsGZgq5MsWquktmog8pKIcnq
         qZEzYPE+kbNQBUPIbUOzmGJn6SAWtoShkaLREU0wXSD62BjXXjjzMS2ocZeBllHRfnlu
         O+9dozd/ZSExUIxhhPAlAbVzsQ2PSf+0sSOo2XXUelrqxSrzK6pI6acheePxSAtPHWpZ
         WsiOzue4+GnzyfGcqEIKR0umtszgvqyAnQtpGgEqp003o9GligqXQBMIeH6SvAECPAIa
         1pDw==
X-Gm-Message-State: AOJu0Yw1Q5XBg8t+DnBF4qW+QzW1oTMcaW9EHbzQxdGeSzAZ4Foe6Wo/
	Yw5luLqjcBfLewyMltEEDF2zuCWA4RWGdmv07N2UpVvlApKUMIsM
X-Google-Smtp-Source: AGHT+IHYNFWalKfTf5szVjprOobJA9ePlGwlDSQKiI3RYDX51/H+K1FrLeUMSS+koI/5TievCiSTzA==
X-Received: by 2002:adf:fe12:0:b0:337:b6f7:e7ea with SMTP id n18-20020adffe12000000b00337b6f7e7eamr3615866wrr.66.1706796304407;
        Thu, 01 Feb 2024 06:05:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVptKwX+H7vJ98HXgd7uIUir0ZVDzaRJPs5pd7hqg0+UWEFVto4EtP9eTEV7AhfBbm07z4rwlW3nnx853w+yvC/7Lm5A57KzRxjGich5hVYn6HoXvG1ox+SUoB4Fq5qpZqZRTzyI8hEm/aobmb/xWgAnY3+MJT7THa9ycmfWSTWHb/TRs6fQnUWeCTNsw2KJW3SMt5ltbpIaevgXRVcxoyHlV2mivhw
Received: from Ubuntu22.myguest.virtualbox.org ([46.121.140.152])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d54d2000000b0033b14e447d1sm1697345wrv.1.2024.02.01.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:05:04 -0800 (PST)
From: Meir Elisha <meir6264@gmail.com>
X-Google-Original-From: Meir Elisha <meir6264@Gmail.com>
Received: by Ubuntu22.myguest.virtualbox.org (sSMTP sendmail emulation); Thu, 01 Feb 2024 16:05:01 +0200
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Meir Elisha <meir6264@Gmail.com>
Subject: [PATCH v2 0/4] Staging: rtl8723bs: checkpatch fixes for rtw_mlme.c
Date: Thu,  1 Feb 2024 16:04:55 +0200
Message-Id: <20240201140459.438479-1-meir6264@Gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch fix series for rtw_mlme.c

---
Changes in v2:
 - Remove dead code
 - Fix comment in _rtw_join_timeout_handler()

Meir Elisha (4):
  Staging: rtl8723bs: Remove unnecessary braces
  Staging: rtl8723bs: Remove extra spaces
  Staging: rtl8723bs: Fix block comments warning
  Staging: rtl8723bs: fix else after break warning

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 227 ++++++++--------------
 1 file changed, 81 insertions(+), 146 deletions(-)

-- 
2.34.1


