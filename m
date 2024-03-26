Return-Path: <linux-kernel+bounces-118241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E588B6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D643B2484B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154271CAAF;
	Tue, 26 Mar 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsL9gQ9W"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBC1CA81;
	Tue, 26 Mar 2024 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711415688; cv=none; b=VUq+mmZHrCoCYtZ5NIxjrsgD9e/Gkzm/sHzizNqaBa8oxX8EDBqhWl+4aYuHrw5wYOq9h/s/qBwyGq5BXUm6tJpRi2jQvpwF07OnuIEflNtNXzAGTC4to36udThk/XtQsP0IT08ocyjz4/vXjy8awcgZuyNPXzdIjP3fgpXMetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711415688; c=relaxed/simple;
	bh=LLQxCz98l1HU/C5oc6qGP8SS9cYXAQ4/0d3AcJ3xSNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzAXhFxrcEKIoAOE3hKfjJh7Nx5hvjvIRSglEEAHi+O0NQHbPQFUodpiHXs4wFAR/F38Q7V11My6/zSaPQ4+gorrWh/R6tO+uuhYz69gsMQK3UeDYHg348GNxHwJ8/5hTWL3DBKx/rPs8o2/+3gFRBqPIrN6S9X/Rfzf8gQ8BX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsL9gQ9W; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd045349d42so4371607276.2;
        Mon, 25 Mar 2024 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711415686; x=1712020486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfZ+cFkGGCKMx3euXyT4Jc1q9tHjn2niWtHTG/CydvY=;
        b=jsL9gQ9WiKA5l3/WMwLuVw2GwCdeuOe0sn5QUTbeSjQChLqXRLiX8k97s/f2wUnkjn
         G44xJ743QtM7t3ubiZq2KM8x0JyxlLhgPt00yCVI9GZ3EzeiKqZl5lUDuQxgH7hB2bp7
         nbOLxAh0Y2EunGTMy5hbYWjsVyz2m+/H5D0KxI+sC7/d5wyYXJlPt2vhT59GGqFSaX7s
         9DXoqvU29l1XWZ9yW6KrnOa0qpq00j4NoeteEnc8cxKCFEhrN4u5iNiviAPzHrUA9MaI
         Y6A5nFtbfKypcKFdywMHaAuemTr+WskmvFynSpyeCF1m5x8Bq5E3ZM4/fpCzTh4K9Qww
         qixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711415686; x=1712020486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfZ+cFkGGCKMx3euXyT4Jc1q9tHjn2niWtHTG/CydvY=;
        b=tQ1Bk2ZWTJgYYSZepK3fMaaZF7wh+r+Ai18Tm326lvj9/6u3ci6/iDbitSZgDzrQiU
         qNG28U9NqEAyZq0eq9L7e5tWbqnAfXHXC2mjq8sxW6xZYzP54gE6nU64MfoCAoLUoXRo
         ZCXSgGnI2DDUlNq56jKAbigE6vwMiMDQNVzxr0YxQbU3cZFlYsvHkWtJHQyAG21r9LRE
         AUpx8KgQjr/WhRh+qre2QGhoslrzp+KPUVki5nodfLv2nqxUG4jxdii6C0sNIlo900lO
         s8j+hePBzBq6ZtBupIO7U8HdMYG4QL+bTjhfuK8zb3jgt2Sb99bJrVABzEBw4r2dVVUu
         rdlA==
X-Forwarded-Encrypted: i=1; AJvYcCVTITrWEYbWRlLQOi3fGCIWyAdlRuyLrEEaKwzq9OE6UKXu6HflzpLUDhlwH+1foLpWgJJFkPexSbRAJk8ej3+hvixZN/zZMG3ORuO4HzpLd6imW7OquYoytDRqo1qbZmeZ/YWkvDqOCLyXngFOWC79JEA0mf6ugZqtflrdgQ==
X-Gm-Message-State: AOJu0YwMPDbuoLj7srVRiM7LZQLe6Qspbn9WXMqOM4V7iho3umXM/r2O
	LpYw4PdEXmA/5ZwIN3sQuy5elI9KtheSpMALOr58vpU3UdgHkeTh
X-Google-Smtp-Source: AGHT+IH82aTqIQFxcCRU5qkkrUKNlOFqXtLXkvAZSnYXUskFSa/RL43K1QGW0T1mKy82fq8UH0DSIA==
X-Received: by 2002:a5b:c45:0:b0:dcc:84ae:9469 with SMTP id d5-20020a5b0c45000000b00dcc84ae9469mr6483905ybr.64.1711415685933;
        Mon, 25 Mar 2024 18:14:45 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id c5-20020a056214224500b006968d8f1c05sm1697208qvc.26.2024.03.25.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 18:14:45 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: hodges.daniel.scott@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: [PATCH v2 0/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf trigger
Date: Mon, 25 Mar 2024 21:14:44 -0400
Message-ID: <cover.1711415233.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
References: <ac8e77881212e18d117059a698affd6afc2607af.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set adds a led trigger that interfaces with the bpf
subsystem. It allows for BPF programs to control LED activity using bpf
kfuncs. This functionality is useful in giving users a physical
indication that a BPF program has performed an operation such as
handling a packet or probe point.

V1: https://lore.kernel.org/bpf/cover.1711113657.git.hodges.daniel.scott@gmail.com/
Changes in V2:
- Change kfunc to trigger based on LED name.
- Fix kfunc registration of BPF_PROG_TYPE_UNSPEC.
- Use new kfunc helpers off bpf-next branch.

Daniel Hodges (3):
  leds: trigger: legtrig-bpf: Add ledtrig-bpf trigger
  selftests/bpf: Add selftests for bpf led programs
  leds: trigger: Add documentation for ledtrig-bpf

 Documentation/leds/index.rst                  |  1 +
 Documentation/leds/ledtrig-bpf.rst            | 13 ++++
 drivers/leds/trigger/Kconfig                  | 10 +++
 drivers/leds/trigger/Makefile                 |  1 +
 drivers/leds/trigger/ledtrig-bpf.c            | 73 +++++++++++++++++++
 tools/testing/selftests/bpf/config            |  1 +
 .../testing/selftests/bpf/progs/ledtrig_bpf.c | 32 ++++++++
 7 files changed, 131 insertions(+)
 create mode 100644 Documentation/leds/ledtrig-bpf.rst
 create mode 100644 drivers/leds/trigger/ledtrig-bpf.c
 create mode 100644 tools/testing/selftests/bpf/progs/ledtrig_bpf.c

-- 
2.43.2


