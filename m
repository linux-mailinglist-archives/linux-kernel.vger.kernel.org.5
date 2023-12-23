Return-Path: <linux-kernel+bounces-10191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3F981D11D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE61E1F219AC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA5CD293;
	Sat, 23 Dec 2023 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="fTgDcRgT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B430CAD56
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35fb96f3404so9866715ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296793; x=1703901593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6A4WH918DJkDqEr8VqraseoVAWIPoVy06brxqeKAWQ=;
        b=fTgDcRgTOnHAZoQK+5SNAlKvj5ZB2kkw7OK60QjpVoVun+wB9bYqj+p5G/EW79O0bJ
         B/VUHkKRelLrg5BbuYyV2Ajeltf75KxYt8HypbUdESfmaS4NzTUNPwxTM/kAVUo7QLN0
         9H9TSfc45hYUm2bvNunZYK/aD7BgPAf9vXwupKP/mgjFGrbSY9KZmpD0bD6NuQR3z670
         KJUQ2gIlVIIBE8yMnM+36872vPNkCUDpGI3nugI2/yRMKHa6ZvLgZ2DrUABSbrnuIAe0
         AuaVjBFul2fottCUQ0SJk6wx/gd5SRpe+gdZHgkbUfRszhmbsEFOwgZGU1YKZ7tWNsjQ
         xMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296793; x=1703901593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6A4WH918DJkDqEr8VqraseoVAWIPoVy06brxqeKAWQ=;
        b=tG3+Mv7uFvMXDnLswFfPKqVN3hA4+3TvgzQzVpywcuTiFZ04kn85tsG0Ua61s08qxs
         TwEkouvl16DaQo/ohNKxpLL0tvQGYVfiv1LjsVCYis9aqYp12e220a6exAngfWuODVBo
         Ji4dhmesj4uD4S3paCOJrbV2kGCUcZTuE4tfqz0oesvbb8Nd98RwEp4+LQ31s3omkKa8
         fMa5hdfeV3j6kFWVCACVvA9G9YDPyGOkwe3lItmOwUYDEvWB1A6aNmOKAtOCuhCDiAna
         oIt6qqkKLMP91MpsTnBnASzrpL3IrNZigydmYd1oqROtmUHZ/qWZVf43gG7Bnov3zYkp
         yRcw==
X-Gm-Message-State: AOJu0YwlkH/Zi6exs8ot/URGQIihce9pRr2ZmqE0MI2JUFK++hwOvQ49
	7NXq1+bhPSg9kwqGGY3lO4h7PFVzbAehYw==
X-Google-Smtp-Source: AGHT+IHrE/8q3oeOpjUdpd161EwN8rwZJtDvnI/EMLi+5wMkDkKbmR1xi4j+9teob/hyveDAUbOT8g==
X-Received: by 2002:a05:6e02:12eb:b0:35f:ceb8:70b0 with SMTP id l11-20020a056e0212eb00b0035fceb870b0mr2767620iln.0.1703296792986;
        Fri, 22 Dec 2023 17:59:52 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:52 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/20] Staging: rtl8192e: Fix statement broken across 2 lines in rtllib_rx_assoc_resp()
Date: Fri, 22 Dec 2023 17:59:30 -0800
Message-Id: <20231223015942.418263-9-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231223015942.418263-1-tdavies@darkphysics.net>
References: <20231223015942.418263-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Join 2 lines, so that statment resides on one line, to fix Warning: Lines
should not end with a '('

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b55e5759ebef..3788e9fb0ac0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1636,8 +1636,7 @@ rtllib_rx_assoc_resp(struct rtllib_device *ieee, struct sk_buff *skb,
 				    "Association response status code 0x%x\n",
 				    errcode);
 			if (ieee->AsocRetryCount < RT_ASOC_RETRY_LIMIT)
-				schedule_delayed_work(
-					 &ieee->associate_procedure_wq, 0);
+				schedule_delayed_work(&ieee->associate_procedure_wq, 0);
 			else
 				rtllib_associate_abort(ieee);
 		}
-- 
2.39.2


