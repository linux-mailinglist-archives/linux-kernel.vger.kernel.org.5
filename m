Return-Path: <linux-kernel+bounces-83137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB34A868F55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4464EB27C7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD713A86F;
	Tue, 27 Feb 2024 11:40:41 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B87713A24A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034041; cv=none; b=b0r7yTgGluyd4OAFDHgpsjYLGHvsCjBrqpBO3JG0EffHBvv8FnC7UONHaYaxXHx0DMfMZf9C2Mpx2PxoHXId0B6kkg5y14hUZ0qhlj2+ubaE+IKrWVoIi0QqcsREEx6gkaN8ulffo623uzpr6sguHdlnjNPEtudx+rJguP21WGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034041; c=relaxed/simple;
	bh=GSTjww8EOqtlnmykG/aRs3o6dzSqAVdzqhB8s160ri4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptO4iR7e70Aa8pkNbuySfgStbuoK/21DSK8FdJ6wZJ8wZA/PGBH95Wf9dSP8Zd5trtfcZ6R62bPetzpTl5eW8KeKIGTW+zCi6yY6Oxza/t7yYLDV0/TxCOc4s7sLH+NgzQliJKSnIZ6LtBYmbgfYQaCttikQstYpgl0B+H2nAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so2551979a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034038; x=1709638838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tThuCtBRUd5ftlkLlRFaictZB1fGzwDG/lSpeV46+ms=;
        b=jeIQJbW54UuNNyZtgrwazj6IH60PlSt5DF5fxYbtjIJmqmDJovPQmaA4Oe4kZzhafu
         CvALwKmWZWwvdJzRWZsQymJtRSUeLbewjoi0URkOktGmgaRKcoCiycuVu+Osi0n6Jdk2
         fvfdleFvzmkeYU5AwuNek0IqRNscc5uLDCMpWMy6t4JaHl3gIjoiUYRDXodfFKY0ZNb8
         Hp4jr26FS/H8rGoETeLtxcx3WVzw/FQgA++FISy9dJZXKc6pAh4BTRD3eW2QqIvc7UEH
         +HmghnajGXr0O8lmV9ZzWnOv2v59tht3kUsRNIeLbH79lYb4BX+nPnd2MtYnJhqW0G9O
         EBIg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8pS+AZU3accnpiZR+3paG1S5TQA5udoUpMvIMpRrhnDlpozdI5VGjGkeM0KPzY798ifitTVTDVf2LzO8VyXI7wpfFV8ootjCECJm
X-Gm-Message-State: AOJu0YzjBDvX7elU1hB0ROvBLK0WM+atW9JVxwoSzVp9vcfzP6GCyGJr
	gUCefzTFze9ehfRdIUiq47yfFbsVhZr7YGMJ3LkUgoOqvl73Sm+t
X-Google-Smtp-Source: AGHT+IGcivbZM9cJXfBVzOp0gtHc12cPnRp6bmM1hDTAMIL14gNTbeVipmKVuxjQol7JVc2H1/TKtQ==
X-Received: by 2002:aa7:c908:0:b0:565:edd9:1acb with SMTP id b8-20020aa7c908000000b00565edd91acbmr3979166edt.23.1709034037646;
        Tue, 27 Feb 2024 03:40:37 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id h24-20020aa7c958000000b00563ec73bbafsm675287edt.46.2024.02.27.03.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:40:37 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B . Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/1] mcb: make mcb_bus_type const
Date: Tue, 27 Feb 2024 12:40:29 +0100
Message-Id: <20240227114029.22319-2-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240227114029.22319-1-jth@kernel.org>
References: <20240227114029.22319-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Now that the driver core can properly handle constant struct bus_type,
move the mcb_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Johannes Thumshirn <jth@kernel.org>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-core.c b/drivers/mcb/mcb-core.c
index 61994da7bad0..0c939f867f0d 100644
--- a/drivers/mcb/mcb-core.c
+++ b/drivers/mcb/mcb-core.c
@@ -156,7 +156,7 @@ static const struct attribute_group *mcb_carrier_groups[] = {
 };
 
 
-static struct bus_type mcb_bus_type = {
+static const struct bus_type mcb_bus_type = {
 	.name = "mcb",
 	.match = mcb_match,
 	.uevent = mcb_uevent,
-- 
2.35.3


