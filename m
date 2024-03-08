Return-Path: <linux-kernel+bounces-96594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853C3875EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2E71F238A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7004F5FE;
	Fri,  8 Mar 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="O4qArRQV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A123C2C1A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883710; cv=none; b=YDZuMYq/Dbi5MWVF6W6FqL5Ko5zMxs/XQP4376XyssagSC4q2DAzi5WLlMsEQrlg61GwNPBLkGrrjiGH7rqRzNk3yS3NonFbzmIA1Hka3Ndj7nH/2r56G5TMjrVK2aHNJPQv8ESqRttLvWYe5J7GDDw0+FDEGu1A2YqbGmb2sdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883710; c=relaxed/simple;
	bh=+R4zqfvDXz1j1mAPPXaLdyah10qZozdlVhXba9egWSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JMOY/TBdM2Esaq6Z2JSrOBNDXrf+S906w6FA/xoHohCW65/ICHyzOtCuEs1AVqKmrhp8/kME/joeLNr5tjDJUhdOV1OHYERhzAKTpEDa5tPKu5IRQ/l1ooUhStATeMRFJq+4teE/XwTSGdxHA9jXC1KtV2IId5oCAnphuLMpxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=O4qArRQV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so14821505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1709883707; x=1710488507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejo1DP06QndXFhb2tUzQ47YbSnlncVEgbITYqnJDttA=;
        b=O4qArRQVKXOXDoBcxsEER5AcHI42yfUAV/7kSP86danE/4IpxAwvqzX9IgElbNCyBy
         M3ZnSCnEAJBWCIyhHTvHaVGVbOApJNlPt2l7DIJLan3zwoyQE4BaipdR1aHrzCmPkJU+
         SkJTM7Pi5qdYxZzHEOtuQuCkVAj47dAcxG5M+SR0qBesZ+sVBib4yLbkLpJI1VU5tdPt
         2s2Eqp9Q3tiKbQXZNoIm8lMlB5WyTE+ctnqJceoTrkC2GZnuzxbbSDsXLksBmEE5PosZ
         +455u7QUwhzVKJlAGK5OmIoKlnOernfED8YWH+zTTs4myNsdy6sH7DArHclF4FUvc1YU
         tQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883707; x=1710488507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejo1DP06QndXFhb2tUzQ47YbSnlncVEgbITYqnJDttA=;
        b=PSJyNO1TPBfUJLopNoX6Gzw7Fs47LewnH4gAxzPOsD/okMBFu5mcMj/i9NHTVCXbmL
         pm5Da7uq315MHZxCHO8kIVZd7Zenr7TfmEq/SJ7p7ZDpGf4Qt+ISMVzSTksuyWSDNOdv
         CopANK3PaOKOBK4kt5oM7rXT/X5BxMsvf3revCoRfYGNNDmniZZ0bEeMQsH7n0QqcKds
         HVezgbLcIwYk0pzZdX1mK6z1VHDvgW5t/f52z186H4sDCkf3ImrsZqQxxinmpkVQz2++
         rLsvuqKV7+92pBKv3C/KseLJBTmi3ZBYqK6VYc+KI3Yqdrb6nceGLAYqVGfcNFQIIPOn
         udbg==
X-Forwarded-Encrypted: i=1; AJvYcCWG8iKwnJEt0RFhWF2pxHM1CP4MsdtvsbmHbmNkWJ9TLqDnB9RqVR3iPQzxINc/mENM5ZxhWtwy8mW+2nOfHsB5Tk869Rc0Vw5ANCFA
X-Gm-Message-State: AOJu0Yw8/tsLIPCjFn3gJXpJ5vT35g6OYJKicN/5hABY7aWRGEBxwL4N
	C2UU7MFEtMwLGHZeOUxyqZJ8Sot/M0uAzbw+IilRUrHhliAwGOYLrjjaCb5o7GE=
X-Google-Smtp-Source: AGHT+IFQT8WkRLqLnhKN8/bn4t8FlGl1LA5A6ykRCASv6ih9Yemptcezn6U+0vguV6V45SIqSFkZdQ==
X-Received: by 2002:a17:902:900c:b0:1dc:a397:f7a5 with SMTP id a12-20020a170902900c00b001dca397f7a5mr9993344plp.52.1709883706955;
        Thu, 07 Mar 2024 23:41:46 -0800 (PST)
Received: from seacloud.vm ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001db45bae92dsm15769210plg.74.2024.03.07.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 23:41:46 -0800 (PST)
From: Haifeng Xu <haifeng.xu@shopee.com>
To: reinette.chatre@intel.com,
	james.morse@arm.com
Cc: fenghua.yu@intel.com,
	babu.moger@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peternewman@google.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v5 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo list
Date: Fri,  8 Mar 2024 15:41:30 +0800
Message-Id: <20240308074132.409107-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After removing a monitor group, its RMID may not be freed immediately
unless its llc_occupancy is less than the re-allocation threshold. If
turning up the threshold, the RMID can be reused. In order to know how
much the threshold should be, it's necessary to acquire the llc_occupancy.

The patch series provides a new tracepoint to track the llc_occupancy.

Changes since v1:
- Rename pseudo_lock_event.h instead of creating a new header file.
- Modify names used in the tracepoint.
- Update changelog.

Changes since v2:
- Fix typo and use the x86/resctrl subject prefix in the cover letter.
- Track both CLOSID and RMID in the tracepoint.
- Remove the details on how perf can be used in patch2's changelog.

Changes since v3:
- Put the tracepoint in the 'else' section of the if/else after
  resctrl_arch_rmid_read().
- Modify names used in the tracepoint.
- Document the properties of the tracepoint.

Changes since v4:
- Add Reviewed-by tags.
- Include more maintainers in the submission.

Haifeng Xu (2):
  x86/resctrl: Rename pseudo_lock_event.h to trace.h
  x86/resctrl: Add tracepoint for llc_occupancy tracking

 Documentation/arch/x86/resctrl.rst            |  8 +++++++
 arch/x86/kernel/cpu/resctrl/monitor.c         |  9 ++++++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  2 +-
 .../resctrl/{pseudo_lock_event.h => trace.h}  | 22 ++++++++++++++++---
 4 files changed, 37 insertions(+), 4 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (57%)

-- 
2.25.1


