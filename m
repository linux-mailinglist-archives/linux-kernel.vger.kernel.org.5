Return-Path: <linux-kernel+bounces-99325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EA87869E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8018B1C211EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A553E35;
	Mon, 11 Mar 2024 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpOPiEWq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1F53E1E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179288; cv=none; b=hUKKyQ6VT5eWh/w817h/zvvclEtk3ABECacXlFVJn5b7p4A0FQhjTF9bIQzzvrDx6JzWoowyMK9ySXmUqBG6e4GV07gLmz/3t1KcKEHAwPoSD9w/R9yYF6bMU25iNGHGGIZsTbtIuo45TuHASbUVu1LQJDKt3/fZ2UYeadUgNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179288; c=relaxed/simple;
	bh=m1rpnhn7JXdX2s3qbHdS/TBv1+G69uvfgda3bYdyRrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qw4x3AXh3hNCdt4Mkpg4VB+NHxJ05t3sJTvIaI/qK6ihwZaW7GrSkJF2rjcbsAOJTrmnS+9NXgRHBsM69v6J1LBg8posUAKo3LhH/GZ5lBfCW4XpqLTGzrKJRwBvMDDAzGm1lIbGhl2u8k5F/v/x91e6J1AFJsaZ4cFRnGFGcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpOPiEWq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d3fae963a8so44080571fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179284; x=1710784084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHhg0x14DE0Rwy9JhV3TBpucCCZa771jy1R7PKNjpko=;
        b=dpOPiEWqDmHGN+U7RQ7QAZyTPJwTZuvmPJoa12VlTk9aLu7j7ifGCxK2wMOO7vIJgp
         E5BToOsxzvrNKt+pGiODUlxTHfQAkC7/tnm5JrWHtnmZxtsp0CZd7PgSlHNW7VoqrPW+
         LT+BpSb3Ex9NC8rIiHasgMlBU2TLnk8+7lFMqKFfqvYBr987ozqEmRsglqxTE8vImTTg
         yjHe6lJvzHasr7EaVR2CwqrI3Vzg7/IlQHEZV2GgS2w28IO36Q/Sg8wF8jTT6fpOeZbJ
         fWcn2TRK2OlKr/D82HEIdkxFjw5eproa/PMbW2UYY+lG+3AtgR0bLSh9H9psQdM1jyCA
         r3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179284; x=1710784084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHhg0x14DE0Rwy9JhV3TBpucCCZa771jy1R7PKNjpko=;
        b=r5HY8HVP9uRUUFytgE2LUv08QG9MmsXTR5U7uDvRTA5AXHQO8KeFmjSmmFnxGfcIXd
         AWMdguhv4JRF/dOUzBT7PIjrzXs7uoWYLPW9HmHTxo2+F1LktXE5xp4AgW5+iQpw7ML7
         BRvugr6XdBcoS8ClFLHGSFFW9qT6Z0CqNeer5gSWkQQtNCPQkEx+zSzzQMXME9RHU9r6
         9x5qxh7EsARTlc4m9FMogwS8L7awbsif9XlnXUHTxEge6wXuoY/kc9xncEZQQRypnPdA
         Xp/pJoXJfOldyQqXq3vcjYCI905IqfNoywp6G/hEgT4Wzi07Ioqg0FW4PUIOYOs0md68
         qVpw==
X-Forwarded-Encrypted: i=1; AJvYcCWi5yLMO6jtA2zXZepyRS+SoIfim6KZH159S3H0VILuTzTofVsohDWAz8j5KQqKx1NToPYL1Nku8oQlYXv1BhRr5JLRmlQN8/yzu80V
X-Gm-Message-State: AOJu0YyMIBTG5PfihgkBagelYtOG+YgJnkBn0lz2sex+CHxqQnT7X6EU
	YjkO5pbNKN3YTllcfZbhs1xro4NpfEfBfYceXPXRZx4r4lyL3QCe
X-Google-Smtp-Source: AGHT+IHxVvhvjS3M8eG/o7PEamztQ8mvtrYSePm/EMkHuSX2sVBdrwhmMH1xUUxWYLieFwdlMMDlgQ==
X-Received: by 2002:a2e:87cc:0:b0:2d3:f68e:ab51 with SMTP id v12-20020a2e87cc000000b002d3f68eab51mr3988347ljj.48.1710179284566;
        Mon, 11 Mar 2024 10:48:04 -0700 (PDT)
Received: from localhost.localdomain (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1757060edo.55.2024.03.11.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:48:04 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
To: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: sunxi: add t95 compatible string to list of known boards
Date: Mon, 11 Mar 2024 18:47:49 +0100
Message-Id: <20240311174750.6428-3-ressetkk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311174750.6428-1-ressetkk@gmail.com>
References: <20240311174750.6428-1-ressetkk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T95 is a series of cheap TV boxes with unknown vendor.
Add compatible string for this board/SoC to the list of known boards.

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..1a2cef741d05 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -860,6 +860,11 @@ properties:
           - const: allwinner,sl631
           - const: allwinner,sun8i-v3
 
+      - description: T95 5G (AXP313) TV Box
+        items:
+          - const: t95,t95-axp313
+          - const: allwinner,sun50i-h616
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6
-- 
2.34.1


