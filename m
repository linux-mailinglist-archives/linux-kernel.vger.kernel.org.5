Return-Path: <linux-kernel+bounces-161918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF88B5346
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CBC1F207C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3FC179A8;
	Mon, 29 Apr 2024 08:38:42 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7E1171B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379921; cv=none; b=O+UhXHprBw3vVTaFFeXSvEV6CgaWHpzn3ByqSE4vE2SOxTgZgXJwKB7XQR1PidDPGH9YkJS+uGXzVsRCGQs3uIZTtip7FhrSiLXYQ3SDg6CasO2zy5T6tQhY6mG9vl6rJFI+5uSnq1tnUoYNXY6I5cpn2JKX2/zoJdv6fVxcKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379921; c=relaxed/simple;
	bh=coe19udBXGrIB7KgXPN9V74azBX0djzDVAarFrgFyFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Tqc6AzVQJydD798D/SWEe86n3TOma8cGU8Nf2Wzk4+Rd5aRbDw+P2HuVQihC0CCwpx6GLNCvs1nq0ZEHKlmtmVVw3/XlBQhmjwRK/ZKiJ+AU2LeBi3GvFYmJ+wIImAlQVr+C2sd7pMOpsEllkSh0PVFJl7/yilNb4PMWdm1xtlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e0b2ddc5d1so1828321fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714379918; x=1714984718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LE72eHQelOwK5Y7fjbeK2rbBwk+1TC+HkqJkcUHiJ6Q=;
        b=Y+mNAF7WnYshFw2LS30SXndmRDT7zNACCivPFjXMOgPsPPz9Z7kKk7lH41MG9Lif/o
         6gMe4q/04uubxNIUgB0PSJCcV0LTMgwHxE/x0SNK2sz9FylAuTvtxpQpTKT+AiCNKKf5
         5HS/jbm2tjSf4SdHo/9Zpg462E9GMDLJuIj70bqLvHQohstlizmAX1xX4xSNJyUSgIYl
         Huap/xpjSwVa6s5fq6SSx2PLeuhO2aHX86AYbvk3IuYeu52+5UqbHGcCllfswjcuuqL8
         XaDX1WmSOW3mvCsjOhT3i6FKevounh+RprXEmkGz1RWo4/iIAofaAm1LoVbTShO33PlO
         Xo1g==
X-Gm-Message-State: AOJu0YxHaSrXGpwX1PcYayNMQ8paTaZbbohHZqL4oHwuLw40+ROvVndV
	+mE25k7ONroOvn6XlUvsXiHHj1sQ+lup3DgqFeapR8qBbH1i7jQ1
X-Google-Smtp-Source: AGHT+IERUWyQZZwsZW0QTBN7cnmNhiXQYCwxZRezVe/9I/2nFhNjfWABEa9htJowzQB27tBVqdxy0Q==
X-Received: by 2002:a2e:b94e:0:b0:2df:6cb8:c92f with SMTP id 14-20020a2eb94e000000b002df6cb8c92fmr4513697ljs.23.1714379917967;
        Mon, 29 Apr 2024 01:38:37 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f745a800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f745:a800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c138500b0041c5151dc1csm2113152wmf.29.2024.04.29.01.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 01:38:37 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] mcb: patches for v6.10
Date: Mon, 29 Apr 2024 10:38:24 +0200
Message-Id: <cover.1714379722.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Greg,

Here's a patch for mcb from Uwe I've collected for the 6.10 cycle.

Uwe Kleine-König (1):
  mcb: lpc: Convert to platform remove callback returning void

 drivers/mcb/mcb-lpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.35.3


