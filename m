Return-Path: <linux-kernel+bounces-147736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C408E8A785C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD561C2160E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F0A13A415;
	Tue, 16 Apr 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3MA+NyM"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C092375B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309032; cv=none; b=tiBElIvAaHjeSpl/TW5/A8/ei3DFEGvODUopGZIOq6G2/FIbMjaP4wKJs08fIbEDDXAT9hWyzxFLOtCv+/1WXXHmuc2dllBzaqtBr9tPvWnU0N/NiX7GbQ6+R4rxNOSyh8BQq+SdE5xGAG0TDc1CKfg8k1ri7j0jeI1F6iVsfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309032; c=relaxed/simple;
	bh=ymDm8FNebz/mOiDajTJYRMBuXxCLleV3KCeiOkFjjXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/U1LOHgT2SEetdvUWHVDjE5i+nF3l/V0tFV5+DuwBpBk5MwxTTDruZ5MHvF/J4GIzknl8zVy9iu4bKdFCp59d48/UHTa9wgIDMWkKFhWbG9QpwiI++uNhqquxL5sk32ejjc7cme3Duej6LK5yx+hz/emgVdoUfVyfNzrCzxFRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g3MA+NyM; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c8b95f7f73so7542139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713309029; x=1713913829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wWdyAt9+nQw8Qr1h0NChEuvDVEscavXKBcKHv+jkRUk=;
        b=g3MA+NyM9vaq6gZ+GOxivubJFGeSvSpSVoTnUuZ82MWgHrZAXlrHC4WbozBQG0CPfQ
         vOwRxAbqwAArJQS2sNxr8/vCSDLRPa3G0UfmxnETP2H2oip8LRykhxzPdv38pwGxTp+U
         E9xO46rF1+l4Tgxy4BSjC08+yFDMHhyc5YcUd7sdPd3pGBj8xkoOAG9B0wIbrf2KWft8
         caHPieC0cretTVJ1mcpHpv6je/ILIKT8AIUU9k9+PyPHkhuhyOhGPKQgWjbx/W6XeOri
         SxTrXfLH/GFrKtws6vq7EuvpMlgtjqoRC6/qAvxOFJ2SIhYO++3xU+7yRA0Vs/hHh2Mo
         W3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713309029; x=1713913829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWdyAt9+nQw8Qr1h0NChEuvDVEscavXKBcKHv+jkRUk=;
        b=qFvTjnh3T0+vVUU7Mi9DoWlKUq6Lu1jU0d8Ggk2uh04Am7IF4SnxovsLbY3hW3V13+
         /pPJMlj4bV2ZvlQWX/9NKztLLT+g2mW10w78nFmgaYTBDD5LNrufVvjv0kMK64FnsOuB
         fgMSV/khWafKw0vI0S6NuM/V3vuKRH9bMfJqshx++yAWRNufEsQFz1ZMqlsboRnSPrz2
         kBsLrJiFhMcjsJbka7uY21whNTJatvJaYln79UphYQ6G/UGFaFnh/irtY/QnYiOFRup5
         Po8Eo9h+FvceJDfpOnhVKAnG3+V4u2DCIgmOgM6wMO7h8Giy07R9sW4jxBWnfUkYDOnl
         Xyaw==
X-Forwarded-Encrypted: i=1; AJvYcCWgm18zNQC6TPvajRhBwvoeJFTyo44Q4fVcTSTlFp3uMlFMHYOlz7ua5fx1cf618zvvEVg+ONefealo5oF1foO5AhuxZQ7ze/sgwqje
X-Gm-Message-State: AOJu0YxJA1dzFyV0HR10iKAz+gCqmNc8HLsouW0HU6YWY+Pc0xsDDZon
	+sBfc2Ua1CsFDKnLIU7U5DmbpREpL0EeiVszUpKB4MCsMpy9wRGZ8KHiYMEULz4=
X-Google-Smtp-Source: AGHT+IFBzqHKauKE431Ap7rruqxL8m+evB+FBiojGzEmkAMuz2sLkBpLbgNVXueReWbxd96Fq/JIug==
X-Received: by 2002:a05:6602:1206:b0:7d6:12d1:5879 with SMTP id y6-20020a056602120600b007d612d15879mr3165187iot.1.1713309029684;
        Tue, 16 Apr 2024 16:10:29 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id le9-20020a056638960900b004846ed9fcb1sm372170jab.101.2024.04.16.16.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 16:10:21 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ipa: header hygiene
Date: Tue, 16 Apr 2024 18:10:11 -0500
Message-Id: <20240416231018.389520-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end result of this series is that the list of files included in
every IPA source file will be maintained in sorted order.  This
imposes some consistency that was previously not possible.

If an IPA header file requires a symbol or type declared in another
header, that other header must be included.  E.g., if bool or u32
type is used in a function declaration in an IPA header file, the
IPA header must include <linux/types.h>.

If a type used is just a struct or union *pointer* or enum type (and
no members within these types are needed), then these types only need
to be *declared* within the header that uses it.

This is sufficient, but in addition, this series removes includes of
files that aren't necessary, as well as unneeded type declarations.

					-Alex

Alex Elder (7):
  net: ipa: include some standard header files
  net: ipa: remove unneeded standard includes
  net: ipa: include "ipa_interrupt.h" where needed
  net: ipa: add some needed struct declarations
  net: ipa: eliminate unneeded struct declarations
  net: ipa: more include file cleanup
  net: ipa: sort all includes

 drivers/net/ipa/data/ipa_data-v3.1.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v3.5.1.c |  5 +++--
 drivers/net/ipa/data/ipa_data-v4.11.c  |  5 +++--
 drivers/net/ipa/data/ipa_data-v4.2.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v4.5.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v4.7.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v4.9.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v5.0.c   |  5 +++--
 drivers/net/ipa/data/ipa_data-v5.5.c   |  5 +++--
 drivers/net/ipa/gsi.c                  | 18 ++++++++---------
 drivers/net/ipa/gsi.h                  | 10 +++-------
 drivers/net/ipa/gsi_private.h          |  7 ++++---
 drivers/net/ipa/gsi_reg.c              |  6 +++---
 drivers/net/ipa/gsi_trans.c            | 12 ++++++------
 drivers/net/ipa/gsi_trans.h            |  9 ++++-----
 drivers/net/ipa/ipa.h                  | 15 +++++---------
 drivers/net/ipa/ipa_cmd.c              | 13 +++++++------
 drivers/net/ipa/ipa_cmd.h              | 10 +++-------
 drivers/net/ipa/ipa_data.h             |  4 ++--
 drivers/net/ipa/ipa_endpoint.c         | 19 ++++++++++--------
 drivers/net/ipa/ipa_endpoint.h         |  4 ++--
 drivers/net/ipa/ipa_gsi.c              |  7 ++++---
 drivers/net/ipa/ipa_interrupt.c        | 10 +++++-----
 drivers/net/ipa/ipa_interrupt.h        |  6 ++++--
 drivers/net/ipa/ipa_main.c             | 27 +++++++++++++-------------
 drivers/net/ipa/ipa_mem.c              | 15 +++++++-------
 drivers/net/ipa/ipa_mem.h              |  4 +++-
 drivers/net/ipa/ipa_modem.c            | 14 ++++++-------
 drivers/net/ipa/ipa_modem.h            |  5 +++--
 drivers/net/ipa/ipa_power.c            |  8 ++++----
 drivers/net/ipa/ipa_power.h            |  5 +++--
 drivers/net/ipa/ipa_qmi.c              | 10 +++-------
 drivers/net/ipa/ipa_qmi.h              |  4 +++-
 drivers/net/ipa/ipa_qmi_msg.c          |  3 ++-
 drivers/net/ipa/ipa_qmi_msg.h          |  3 ++-
 drivers/net/ipa/ipa_reg.c              |  4 ++--
 drivers/net/ipa/ipa_reg.h              |  6 +-----
 drivers/net/ipa/ipa_resource.c         |  3 +--
 drivers/net/ipa/ipa_smp2p.c            | 10 +++++-----
 drivers/net/ipa/ipa_sysfs.c            |  7 +++----
 drivers/net/ipa/ipa_sysfs.h            |  4 +---
 drivers/net/ipa/ipa_table.c            | 19 ++++++++----------
 drivers/net/ipa/ipa_uc.c               | 10 ++++++----
 drivers/net/ipa/ipa_uc.h               |  3 +--
 drivers/net/ipa/ipa_version.h          |  4 +++-
 drivers/net/ipa/reg.h                  |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v3.1.c     |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v3.5.1.c   |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v4.0.c     |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v4.11.c    |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v4.5.c     |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v4.9.c     |  8 +++++---
 drivers/net/ipa/reg/gsi_reg-v5.0.c     |  8 +++++---
 drivers/net/ipa/reg/ipa_reg-v3.1.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v3.5.1.c   |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v4.11.c    |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v4.2.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v4.5.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v4.7.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v4.9.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v5.0.c     |  6 ++++--
 drivers/net/ipa/reg/ipa_reg-v5.5.c     |  6 +++---
 62 files changed, 253 insertions(+), 228 deletions(-)

-- 
2.40.1


