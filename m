Return-Path: <linux-kernel+bounces-28524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598982FFA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4813CB24147
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E5079EE;
	Wed, 17 Jan 2024 05:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frjh4xST"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92C7491
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705467756; cv=none; b=XIxfUQhUVVTvb7wRCWuo7TiigyjnmY2N2V7RLfl7aVn2RzmC690kMc7B8xySjZaO/CzBD4ESQltlsDs6eK1RER1sV6Yvm/WuxkW/rR+dqTYDsqtrsJvi8H3tThP+RqNXdomjeT/dXIsFDX4eve9Dtk6aRcMwNZqEtg3MI298jxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705467756; c=relaxed/simple;
	bh=5AVdz/BJhQBWH0mrfFYBr6vP5kZPZ9iVFAsj82OfSRM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=SS6CrC1aYGH4F/rB9JIWx7Zf82zhXu981OIjHBYjpkHEQlen/wu5iLTTiaXTU5v6BHzMAo+SAPkPU0VsenFTe6KH5apeVdyT4S8ZLW/Mc3NbABK7DVYUqKGE/2IfUWNk2tJ+VBYTSKmznjaR9OjQMy3jBEI+cYH28jKhDaseZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frjh4xST; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bc8939d0so6797251b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705467754; x=1706072554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkO7UIM6BwzTLhaOLWQg0KJZPLEn63+FO+nanLWTbIA=;
        b=Frjh4xSTNLXwvA763FRDcXUBlGUgUqbdgRHQzlRluvV3lARAWHIomgq7RnTjjV3GnK
         wviWzbVa+93V/mMzvy4TzpADkiRX9qb934P9+P0Yb7FAKxVMz2ZA1gbu8i1VR1sTvcHM
         OhT2yZlHBOG34lmCSzuFUmZqM2IFRg5h2y4rNiS4MaSA52qOISy0Y+K47+0t7OSS6JIw
         RdlUdhZiOTxsxB1zmM2wRyEsvpW6Doncg6cELc/CTWGRDHqBfvxWgzT9U6ku1Yg4eH/q
         GnbWEFW5tkm7AGh95yAT5NiOfUPr3wee07DLgK+ypyFRRiN4bH/rGjbPHkQFiGCgRFv3
         Izkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705467754; x=1706072554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkO7UIM6BwzTLhaOLWQg0KJZPLEn63+FO+nanLWTbIA=;
        b=A98o8UQJ1h/a98wqZeSCGIdhu6KM0nxjwV/Qxl6BWFlylpvFnzvpoMqjrpCslwncmM
         P5haoLHBHUQRwzndVqGNosa7cdomqJEAj2iEHKtAmOOZFKWvIFVPQCOPVsQaIErCB+UW
         vYQTB57jEX5L1K+9fUovwoXzuncWAF+5kWybCGeC3dZLptgI74EWDvT/HZoe5Ri7fWvk
         xH5GQw9WPSrBAEuDGxL7nrjrGP5xZvveGop+cKjey0e4Z56hwk4PHjKz/uAjUe2aUn8v
         79VT9pvAmq16AY23mj/nOiD4krq4P1b/Zy5wjOttsFKbnbTgG3Uuqf7eCMJrMd7O9XN6
         7o+Q==
X-Gm-Message-State: AOJu0YxTOdROc4HTs3ayKwvb7KBg/z6SVKEL+xRBbKvI83LIhMgrzLRh
	vyh7SJCM1s8jCV0RX4Gd7z4=
X-Google-Smtp-Source: AGHT+IH0boM7IhNW40qZf/Rb+K47VXs6VSQUUllz/bSWZdV2ac0CvZYxko6MRyvcJWDrxzlT+BMwyg==
X-Received: by 2002:a05:6a00:2443:b0:6da:7eb5:eed3 with SMTP id d3-20020a056a00244300b006da7eb5eed3mr5030041pfj.5.1705467754190;
        Tue, 16 Jan 2024 21:02:34 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.24])
        by smtp.gmail.com with ESMTPSA id i63-20020a638742000000b005b458aa0541sm10751495pge.15.2024.01.16.21.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 21:02:33 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	songmuchun@bytedance.com,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v1 2/2] mm/madvise: add MADV_TRY_COLLAPSE to process_madvise()
Date: Wed, 17 Jan 2024 13:02:17 +0800
Message-Id: <20240117050217.43610-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240117050217.43610-1-ioworker0@gmail.com>
References: <20240117050217.43610-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow MADV_TRY_COLLAPSE behavior for process_madvise(2) if the caller has
CAP_SYS_ADMIN or is requesting the collapse of its own memory.

The semantics of MADV_TRY_COLLAPSE are similar to MADV_COLLAPSE, but it
avoids direct reclaim and/or compaction, quickly failing on allocation errors.

This change enables a more flexible and efficient usage of memory collapse
operations, providing additional control to userspace applications for
system-wide THP optimization.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 5a359bcd286c..1f1bbaf2ffa1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1205,6 +1205,7 @@ static bool process_madvise_behavior_valid(int behavior)
 	case MADV_PAGEOUT:
 	case MADV_WILLNEED:
 	case MADV_COLLAPSE:
+	case MADV_TRY_COLLAPSE:
 		return true;
 	default:
 		return false;
-- 
2.33.1


