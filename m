Return-Path: <linux-kernel+bounces-66534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49909855E05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39791F215C3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39271B81C;
	Thu, 15 Feb 2024 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXcCXpZ1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58731B27D;
	Thu, 15 Feb 2024 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989217; cv=none; b=IsfWyy9iKfT0vNoVojGOLRb00dsmc1bXIjXbpouXgOwwISj5aGL2LESHCDQFbYvjY59gFIRA7Z2IIy5pp+fpVzDO9K/mYcA6ZwUlaS2VCNbVqdccq5L2jrzdzN7TLxV6reKVA92ADBCAAwsSLkKOg8jNt7F0dzb/uJCN2EqOXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989217; c=relaxed/simple;
	bh=E2v6VkpFCx1HDTq9sKiAbC9tdSDEbT2SS+fM9nv71m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5J7I5KOapwCveRNmeqly12ALi7K6Hhjckbhb0zw/OIvnade5KXc1mTsuxmkd2wGVFmcT/7/FiUNEcp34gEEAhMfS/Qj572xdHE/05EqYX51aVImPR6Jjyxi4qvKrbKLE6bP2hnLQCGtZ7zcVZXU9NT3HoUCQTaY7VwkQ4o8/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXcCXpZ1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d953fa3286so5296995ad.2;
        Thu, 15 Feb 2024 01:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707989215; x=1708594015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWfMmIfGsKwjYTHONZVgXvpgh2ggyJHKL+IgNdm0LAY=;
        b=RXcCXpZ1wpypDGIOdOK/Mjt2m6wvWvaDU00+Ha010rY5hutwK528Hun96aEtBkvN/3
         Zia585ezsifeNNcqXSu4ateRmllSXJTv2utuPG+mvMr4Ankao1INUvjEazBYKqw0PvUB
         nAPTdEmsRDhXGMsbGB/Kpvv6A/NdXgPAX7+D/oIz4LIGlLMGgYkNPm8cdM4huVjKEPj+
         /Pk/pgJTYqdTqRmGqTqSTXQbgu1Q2MR6Hd5d9Tb8S5i+NvOPm9xiW6m6ghuJfISAhusq
         liQKwEOW/4smKDUDMU84VRb6l7gc7HtlH9uLvtG56nnjV7qfqWt7xvpQnjUCgwTcIGOr
         tL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989215; x=1708594015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWfMmIfGsKwjYTHONZVgXvpgh2ggyJHKL+IgNdm0LAY=;
        b=RHtCJitcMm0W/M5ghWe2G/+z0/w5xjltGLmOUg0NEPh+ogmwBc044wTIU5RcDggmsi
         SAQxYpcN8oE8wyqXoGwocDc44nxi+lssg5tcvy0sF73YXIOgYahPwQzomfzfg3Gz/DYR
         HDYwJDu+4P2EGS/bYxPtn4bMee4A6tVlYMzYTm1a1etArJpyTJXARbZdL+8RjqdIamqX
         SoMJ5txScWsER8vZ+qhnenhszutdPGOGamKLUdiGkKCI4OMtya0h2XW9pI+M1o/YrR3c
         gtenZUCrnw7XImyA7s+tuVt/pGJwzOgshxnLW443Q22ezNnlqODPXUvB7p1STtkKiz2z
         2qnw==
X-Forwarded-Encrypted: i=1; AJvYcCWDlg8oeWOuPwr4tf/uLilZehwqmA8boDfHoeCRGkAltyq3CkMqhlMQpluw30znyAjo+sCVCNpb94jzCFCUEo2rzp0KoFcNsKirhAri
X-Gm-Message-State: AOJu0Ywhh3wICPrY9jQe83CUrIc+9zz6rUkWPt7ltKqYJ74KxcChznKv
	Iec+MPa34YFqrKTfoNfy++X/wzXQvBt99YlilP16PpQatx+0dPg2
X-Google-Smtp-Source: AGHT+IGA7VG87vWnvTRdUejlRRl0NjQJAvdQO98FlbNM1in/gDmV3+bRwGIDKxfp9PsHi92cu9VEZQ==
X-Received: by 2002:a17:903:2601:b0:1d9:aa5d:a50 with SMTP id jd1-20020a170903260100b001d9aa5d0a50mr1017745plb.25.1707989214966;
        Thu, 15 Feb 2024 01:26:54 -0800 (PST)
Received: from pairface.. ([111.18.198.117])
        by smtp.gmail.com with ESMTPSA id ko4-20020a17090307c400b001d7137acad9sm838088plb.57.2024.02.15.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:26:54 -0800 (PST)
From: Pairman Guo <pairmanxlr@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pairman Guo <pairmanxlr@gmail.com>
Subject: [PATCH] USBIP: Use fallthrough pseudo-keyword
Date: Thu, 15 Feb 2024 17:26:30 +0800
Message-ID: <20240215092630.148917-1-pairmanxlr@gmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers,

There is a usage of ``/* FALLTHRU */`` in a switch statement in main()
that have long been untouched. This patch replaced it with the
better and proper pseudo-keyword ``fallthrough;``.

Please merge if it is the case. Thank you in advance.

Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
---
 tools/usb/usbip/src/usbip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/usb/usbip/src/usbip.c b/tools/usb/usbip/src/usbip.c
index f7c7220d9..ddcafb5c7 100644
--- a/tools/usb/usbip/src/usbip.c
+++ b/tools/usb/usbip/src/usbip.c
@@ -165,7 +165,7 @@ int main(int argc, char *argv[])
 		case '?':
 			printf("usbip: invalid option\n");
 			/* Terminate after printing error */
-			/* FALLTHRU */
+			fallthrough;
 		default:
 			usbip_usage();
 			goto out;
-- 
2.43.1


