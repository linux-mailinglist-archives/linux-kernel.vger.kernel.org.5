Return-Path: <linux-kernel+bounces-111577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B6886E03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA291F226C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B8146B9F;
	Fri, 22 Mar 2024 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSZWBTrB"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D746521;
	Fri, 22 Mar 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116522; cv=none; b=pJXxub+2WNA8SnSE/7ieR8lHkMD0x5znuxxRYsmd0qcZX7/WApOWvY5WM/vNbVqn2lksk5/wh28D5TZNUOYlr59xSZRSMtPzLiz/uFms2Fv8u3kYNWy7zq5vx1KBhlmgtGEMGwrFSys3B5GkmBRg44oPVDQZxTfXGM78R9+9+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116522; c=relaxed/simple;
	bh=3KafjWtibLc3D6ji/Ov/mDWNEAagGDYV6htJE964lvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVSg8kk+IyHY+qV9wt/Nd23NomhNDe6CxoPv/QUg90PeRBW0QSlr1wiqrISDuKk7kyoiJEaall+J07prCYoifpA6bg9N+Y9cHeuf5tiN0Iw6x60VqGTBoOK2ASN+/pkOaLceOkwiPONqWR5bC3Is2uif9a3b2Hk1aMfeBSEjrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSZWBTrB; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-69664c7f716so8318246d6.0;
        Fri, 22 Mar 2024 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116519; x=1711721319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sIa/GtogvqA0DYtww6Wk70bFxOMoH//TtEWfa7kprrI=;
        b=FSZWBTrBlAfjEN8SuLop9SApKGAkBHvdtFyd5fuKmriSifGO0wh5dyh5yKhonUM6Tm
         InY94BQt1mjnlK0qNtfHYTHZQ2AEFNUktXIrJ8+45cYf7D3mYcCj8N0mXk6eZTQcpXKJ
         rGyf5Gg5lIl6kC0K/c4ne8ORqe2MxqTC4llI/qfB3tBoor9oqNVooWmgIzLJkiPYhEII
         rVBweyYT21MwzT+63XSLJ9ZfEwps8QB2fk8Jye9QMfGMt/ULnkzHrHh0E2Ly3xgC9StM
         NM6brjkbsiARKKVslw9nOBqfE6243O9sXlADbUboy9tk184zUXeg7E61juO57iYmFDBl
         4sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116519; x=1711721319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIa/GtogvqA0DYtww6Wk70bFxOMoH//TtEWfa7kprrI=;
        b=C0Bir1QsowYEEjhcV9CQqrcj18sosLDss+OzvuW4xVXkiI6NJI3yhXp2/zWyGv1nEN
         MSCHIzdYZbn5Ywpw8kBpV5v3kqjcikh22K3JTxNtoSWqPuGuE4R7aS8H9atEMVZZzt9w
         VeEf0pUgQeBYUDeS7sNp85et4Jlxb/ORAqDkZJtzuzNB1YK7SymTfUloVGkJjqyRvS9T
         eVmla6HtTE7dVSG2o4uZd9kfMJnjs+z+85QEFcaIjpxZPjyWsIzkhx62U9EvX0GM8UuA
         suKUEDwzE9aOyY51ArbWRjXzP59wMnSXF2bHPAul9aiXA0iKBWDvc6sDRm06HKzC8I2w
         +DUg==
X-Forwarded-Encrypted: i=1; AJvYcCWcdCiG63fVsO5wILCznGVptP6aY3NJyke9zvf5DbM/fRyin3cJoOXTX3xMKTwDzBkKwSes+kHNknImbfJQCNAUymopWdf7bCDGpC50CZsniT7hNeuuAgMMr2JAe7zNII91SGg4NGEWEkuYg0kjKW56AOANLltowrAPOFJ0yQ==
X-Gm-Message-State: AOJu0YzcJz6R8HaiQcMeF1Gh2jphvhWipD7Yla5PQjXZed+r0w35Nm0d
	NXFUStf0IoJewzta/Z94M5OZDGrsSeds3WujhfPPHilCWYOJehno
X-Google-Smtp-Source: AGHT+IHXlyybG5SFFQUKWVXy3PNjEVOg2EmpACAo0xiAohjUBSVml7qpuRl1THA+QIj4TZc4MT91aA==
X-Received: by 2002:ad4:5aac:0:b0:696:755f:c0cb with SMTP id u12-20020ad45aac000000b00696755fc0cbmr226217qvg.8.1711116519287;
        Fri, 22 Mar 2024 07:08:39 -0700 (PDT)
Received: from l1441l.thefacebook.com ([2620:10d:c091:600::1:b4ee])
        by smtp.gmail.com with ESMTPSA id kc22-20020a056214411600b0069124fff14esm1099508qvb.138.2024.03.22.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:08:39 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: ast@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Subject: [PATCH 0/3] leds: trigger: Add led trigger for bpf
Date: Fri, 22 Mar 2024 10:08:13 -0400
Message-ID: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds a new led trigger that uses the bpf subsystem for
triggering leds. It is designed to be used in conjunction with a bpf
program(s) that can modify led state through the use of bpf kfuncs. This
is useful for providing a physical indication that a some event has
occurred. In the context of bpf this could range from handling a packet
to hitting a tracepoint.

Daniel Hodges (3):
  leds: trigger: legtrig-bpf: Add ledtrig-bpf module
  selftests/bpf: Add selftests for bpf led programs
  leds: trigger: Add documentation for ledtrig-bpf

 Documentation/leds/index.rst                  |  1 +
 Documentation/leds/ledtrig-bpf.rst            | 13 ++++
 drivers/leds/trigger/Kconfig                  | 10 +++
 drivers/leds/trigger/Makefile                 |  1 +
 drivers/leds/trigger/ledtrig-bpf.c            | 72 +++++++++++++++++++
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/progs/ledtrig_bpf.c | 28 ++++++++
 7 files changed, 126 insertions(+)
 create mode 100644 Documentation/leds/ledtrig-bpf.rst
 create mode 100644 drivers/leds/trigger/ledtrig-bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/ledtrig_bpf.c

-- 
2.43.0


