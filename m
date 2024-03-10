Return-Path: <linux-kernel+bounces-98371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3005B877938
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670951C20C51
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAE43BBF7;
	Sun, 10 Mar 2024 23:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="MmcIyc1+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD0339B1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114958; cv=none; b=dwq7lcEJtSP5AeapgNNZLdgosWgDAqcBfD8kBXzsKhmgh4/j166ZgQP2O6DpEgHVd2xqQqEK1xJSJCuXlR8Sg1FFRK4WjZx089lxj5MfI5wfkaEb8YaDwMWiwubXnOpv12g6PCKkWbLmxtq4rJcPJrOiorCGkDQCTnTcUwdipco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114958; c=relaxed/simple;
	bh=Lx8R7Ns/zJeNrBeSkWcZhjE2NiQwGZT+uegyvL7H6c4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJbl0XrVwJDQG2UjDbY9rxuHKaXGtdNGSoxuIjNUdqAc48kHVP09eBCQFY1jprYSdtGgphDdSXV8seoB+w7ePJktFchbiifQ4DL1wt2xo+G13u3xsXV2tgLhVKSKOGeO4eMgStfxMX0mGo33IZ4kgC4EPg6XMtKntfCkm/F9368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=MmcIyc1+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29b70bf6c58so1938759a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114956; x=1710719756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6H0JVyCwyLSV4/m6odG6yGR8O8dG3rICgQm+UVRa8uo=;
        b=MmcIyc1+SnpPJj7r6DvbatiW/ApmzBrFuJ+eQ66ulhEsgjCnpfH3KBvede5/GinqPm
         eXwNmcwIr+jqtcRXWhuif4us45AVa7/YfN7xh/piV66uUePQET3AlB4Tu7L8i5bokQta
         5Ek5uJP0maUaHdu0XkwLDkJruh5sqibth0KE5gwcBSC6nVxFatssLFei+m/aMHMs+ux0
         qp/jOR+mk0D1md3UY/g18w5RVjNFgtsUQVPdhljHljDZYIGLR/9p5YqDYffKXy9YEAkG
         xlC4ar/twbFFFBk5QgtMkUjWLu3olTQu8SBA/9+XI/VbXyfXVSLtHJR3ZvWjBydviTZM
         3Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114956; x=1710719756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6H0JVyCwyLSV4/m6odG6yGR8O8dG3rICgQm+UVRa8uo=;
        b=oGDbvz3R5VIBwIBheGptBgkl77oinDF7PiFoZD7iWTCwDJ0F3dRT6mFT+928x7dzTW
         iN7s2K7QRN320lDde/tCJWN9W/y4ivXUO3hQ8TsjPyMj+arIJjgDRVgYQm/bcXyYq62H
         vhSldyc3FKtOutOVqimKalYAsMKUYtZjWP/cV5Hj852evjMOfOxgZSfO0zH/g9RpN2Bp
         LH1yn2Bk2bbgLCTjvstFlNqCaZ3yeqrAxigeVOGtwUTxOTiALRYubMy2RFnXn8qoFdVR
         0mY/nV+mqy7CfpRtBQoQelUekiKNlXOTXZjqsnddDDu7W53nNKqqFJ5T6ILwAxD9lqAj
         WGHg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/7ddQay8OdD8w14vd4zAW+y9v8FnDs2/NbQGF8GASJAsRQpK/i8No2IU8Wz8vIygt1nbeP5kvuCrqHtCM/JvJ9xetiIoE/jotjGw
X-Gm-Message-State: AOJu0Yyc5D8Ml54/z+u9Z/aZJwjIJsWcc1Gg20dOcS9CnVePMgot+lB7
	qxIoYgif5Qn3eRLXXU+UKLb9qYtMV5UhMF2+tPYK5ivjlp1pAHKD5Ok8DrHzXeA=
X-Google-Smtp-Source: AGHT+IG9e52qcnmm+dmxxYGEwKPes1qWkmDYqztLxPAQvILCEoFwj9dibTYJzUwaBRY+y2zFxWsezg==
X-Received: by 2002:a17:90a:df92:b0:29b:b1cd:4ea5 with SMTP id p18-20020a17090adf9200b0029bb1cd4ea5mr3700742pjv.11.1710114956209;
        Sun, 10 Mar 2024 16:55:56 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:55 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/11] Staging: rtl8192e: Style guide Renames and Macros
Date: Sun, 10 Mar 2024 16:55:41 -0700
Message-Id: <20240310235552.4217-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

10/11 patches in this series rename variables to fix camelCase style
guide violations. The 11th patch implements the use of the BIT macro
instead of regular bit shift operations.

MOTE: Because patch #11 changes DEFINEs the compiler issues 
redefinition warnings. I don't know how to address these as part
of this submission. 

All changes Tested on Hardware

Thank you in advance to reviewers.
Tree

Tree Davies (11):
  Staging: rtl8192e: Rename variable ReturnPoint
  Staging: rtl8192e: Rename variable TimeStampLow
  Staging: rtl8192e: Rename variable TimeStampHigh
  Staging: rtl8192e: Rename variable Frame_Order
  Staging: rtl8192e: Rename variable aSifsTime
  Staging: rtl8192e: Rename variable posHTCap
  Staging: rtl8192e: Rename variable bRTSUseShortPreamble
  Staging: rtl8192e: Rename variable pBssHT
  Staging: rtl8192e: Rename variable bAllowAllDA
  Staging: rtl8192e: Rename variable WriteIntoReg
  Staging: rtl8192e: Implement BIT macro for bit shift ops

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 16 ++--
 .../staging/rtl8192e/rtl8192e/r8192E_dev.h    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 24 +++---
 drivers/staging/rtl8192e/rtllib.h             | 80 +++++++++----------
 5 files changed, 63 insertions(+), 63 deletions(-)

-- 
2.30.2


