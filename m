Return-Path: <linux-kernel+bounces-58600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99984E8BC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F061F2FD6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86536114;
	Thu,  8 Feb 2024 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="YN+LF18Z"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA733CCF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419513; cv=none; b=fsQdUuIzQWRFqcOaZaRQT2kPiCB5xK0MFfiYqNQ2e/DicvJ/m+eRnZjzNyHQNXe1iGJ9oxD+oJTqxMy6uAcVEqQUwTOCCAcpBJeAHmnh6u8L73/f6odlMNaLitQQ4SrBANA4QAmOygmit3ZsIC4FH1OyMFShs/7MG81WAabCq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419513; c=relaxed/simple;
	bh=blCSza5TQ+iFiMNQqLUeTbweD6hh0a+7uJXycqjiFEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TbKZW5N1EDkBDHLrolhWNSAb19uzC9Vm/L0xsBzjlqW8gYyyAnS6BDanVdxTmndDGM7TSVI3CwpPBZQxneIKQsgeXjGE+IBbRdR+2uk9WaltSHvzpKcKA4oZ70ft4XN5/AO0LHahNjLUYe1DhYpxe72cIwajbwjNG4S80/Y8168=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=YN+LF18Z; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-295c8b795e2so150848a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419511; x=1708024311;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vITTCQqApfqjUncYWpsTg5mOxYlUOY7+4BnAfOQ/uHo=;
        b=pLAMkyQHJgCiz1WZTMAc2fo2Vab/VwE/96UihdLyqTfzpmyeDeK19CrzL5DmeH98pg
         nMEy7V0I+dxJtMtXoDJ2oArl0UWwTAyX5UZ/t+HsUnOS6OQlM9GwBAFXKDiCZaiVi76j
         ARsJTNzoGhmH1rcaAXjxGF8XmGufmpUk//lZjSMTLzJBuiVooehgBJt/3n0GGRBvNjzT
         BjPBlUUd2UuLvLHYZC28Uh7ONeY+KjAspJXOUOyNS+K7F9d1ru5CEzjcMieaWwzpYozl
         LYreiYLMM3qruYWDKcXmynRELddtAg6J3eXSZf1W5RZJGCVek1w+3Pg5R9fuvvr/Y6Gx
         D6bQ==
X-Gm-Message-State: AOJu0YxesA2AVFb7s4xClsDdlmvzu/cI5ccsXlLluzkNxgSwlq1dqjIg
	OVxp9Z36WMPc/LlfbSSfYOx3riz4AGZ0QubjQFl51iMDmG+AVUXo
X-Google-Smtp-Source: AGHT+IFhXj2F4FBpzHtVsotxqIVbnXL/PpzrBW1Ump4XU6GNW2ecnGoDhT/7Hx0qMHs2Z4XzFmfKtg==
X-Received: by 2002:a17:90b:1bd2:b0:296:ee58:646a with SMTP id oa18-20020a17090b1bd200b00296ee58646amr200982pjb.25.1707419511349;
        Thu, 08 Feb 2024 11:11:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY4S0sLUZjN2ovwW7PLWe3UO8nP0LEwoLuUEXHTO20z0JBxoat9cWr349Vtg4Rh1niL0Z2sVyPCr2JagSfW47ae4aQ46wcHBdbKzPEmNsTv2fIDeMWe6/IuIPpCRo6WQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id gd13-20020a17090b0fcd00b00296dd7eff41sm132586pjb.9.2024.02.08.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:11:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707419508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vITTCQqApfqjUncYWpsTg5mOxYlUOY7+4BnAfOQ/uHo=;
	b=YN+LF18ZU5JEJ2YJPkrdhV5nLL8tK5b7OA+HDEgyfcrvbQ3f+utGpnfHQ4kosRFFgkq2HC
	STcK+M88+9g9DUTPr5AcuvIF/ZCZG7S76IJNN+M87ww+GwS/LKdDPjVNUsckMblrTITfQI
	Ffymj35G9pEz1aVSH1S9aeyR33MDJ94oC1ANZliF8AeVWUkzjrFAwNmewcddBFYr3+PnDJ
	/+QjeglPe8SGAO+5qQOfS3aQtA45O4w32UhnAdO3jrJ3cgBox7aeKC1ojkQjK+JNODsguB
	YRBdaybSjZBrugWSi2u0vMGz5jCBRFVe97UOHmpIu6hOpqrBBhjG+A5EN0/nvg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:12:21 -0300
Subject: [PATCH] rapidio: make rio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-rapidio-v1-1-c69040ab0151@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJQnxWUC/x3MQQqAIBBA0avIrBPMCqqrRITmVAOh4mAE0d2Tl
 m/x/wOMiZBhFA8kvIgp+IK6ErAexu8oyRWDVrpVWvXSZl7WE43PUSYTyVGQQ2ObXjlr0XRQyph
 wo/u/TvP7fjaax7ZlAAAA
To: Matt Porter <mporter@kernel.crashing.org>, 
 Alexandre Bounine <alex.bou9@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=blCSza5TQ+iFiMNQqLUeTbweD6hh0a+7uJXycqjiFEA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxSeVXQp/RxgRS56sAed4O3A59pqAUVLSBeCiR
 AdLM/KgJh6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUnlQAKCRDJC4p8Y4ZY
 pnpZD/wO02U2hQnGoQr8Oez5m4Fq0b4U1RWQxorc4KUQuNxbX5P903j6zGCQ/ti4czpG7Qkn6bQ
 O2tV6LhU3AP3uL5rFniJZQ1HvvDoPHfBJjjkCGnX3c9y9o+/+rngl/qn3DmL5ytT9pru7dw0iGw
 afWmzgbIwlopOpt+rV4rjbCV7w2nT9OfrT+UZJiXt5TKoFaUj6kGA7lkMuafVaSqYWuigUicCKo
 v+VjZiwnvM/JbXmkjRJN36LfnNAiRu0HEUcx4qDVaIy/RNti/tnFVAV6O/gRWvSH9fh3eibzqEE
 4MJGysNmhc7rJUPBEFUfJ1+CcnZ5uLcG3vQNwLZqiQqO+ChXwlya4dtZX21PgGxBIptE5dkz0N6
 KrMMnQfoFXIEdaGsBYWxveQMaOBUdEXgS+CCr0H3P/jF+3y34ly/6fKkr1mAaEs6HsjbUgRF79V
 3JvZJTTYuWEe1dEdcH6QktZqlqzMWvitC7+seUjViLq3Ug6TdNbs/c6p91ePoEUuyqLO+07g9NP
 shGD9b6Aoah1fKCX3r0MNoBdysR/jTHTEB06fT2JF8EWkk06PiAmiGSFyCQNavusghnW/vptOPt
 32g0U4TC08qGpvGUmQsK1p5Rn13rYbg31jt1wL1avW2AFgEu9BD0I+WCMvZzosBxJERzEXFVGrn
 VZqrjnTd2c+HFSw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the rio_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/rapidio/rio-driver.c | 2 +-
 include/linux/rio.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index 1b3b4c2e015d..2baef45ee5ff 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -227,7 +227,7 @@ struct class rio_mport_class = {
 };
 EXPORT_SYMBOL_GPL(rio_mport_class);
 
-struct bus_type rio_bus_type = {
+const struct bus_type rio_bus_type = {
 	.name = "rapidio",
 	.match = rio_match_bus,
 	.dev_groups = rio_dev_groups,
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 2cd637268b4f..e9ca2fb7133f 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -78,7 +78,7 @@
 #define RIO_CTAG_RESRVD	0xfffe0000 /* Reserved */
 #define RIO_CTAG_UDEVID	0x0001ffff /* Unique device identifier */
 
-extern struct bus_type rio_bus_type;
+extern const struct bus_type rio_bus_type;
 extern struct class rio_mport_class;
 
 struct rio_mport;

---
base-commit: 547ab8fc4cb04a1a6b34377dd8fad34cd2c8a8e3
change-id: 20240208-bus_cleanup-rapidio-93b380dbbea5

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


