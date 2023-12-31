Return-Path: <linux-kernel+bounces-13705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E2820B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B56B21291
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB9539A;
	Sun, 31 Dec 2023 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCF92qqm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291A4422;
	Sun, 31 Dec 2023 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d427518d52so41462145ad.0;
        Sun, 31 Dec 2023 05:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704027959; x=1704632759; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ODXawsHJR4eKKT5RiYXWxhMa6vsUAfbFsXJZGtRm/w=;
        b=KCF92qqmrZ4d96IW4hOdh6PBvEVF5keOcSsR7tPe88SqRELM/tkH272m27yUfTtoID
         vogyqGKDnIKwNHhoNBRVozb+sW8U5gwOHw5zUqDYWajoThTILi8FzQTGyY1uuag8G0h1
         eFPMWBbgHEI0YItFqjIZQapna41icoo7A4YSTqry0cUMAmQ5VW7f74ZYPjyvWPXEgVsx
         9RcZKnINWKj8naXUsk7y2drsm/LEDa3SfLXmiYulyjP3xdDSPEPAtycNAQDNLC8JhFz8
         sk5UO+gw2PP5EQLES6Qdp0Y7UvBBE0liJMg4YWTNP7aJPvmbsNoPFW3wnA8I8NqNQJr2
         EZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704027959; x=1704632759;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ODXawsHJR4eKKT5RiYXWxhMa6vsUAfbFsXJZGtRm/w=;
        b=ctrJEgJ78OTJGK14LtQx0KuBrE7Df2TU/etEVxTPlGYl0pky0f0F+3GvvN+XBjo5yM
         HuMLf4NdPwNp+OeSBwzF2The3OJrvZaX/mluTEJttm9LE/vFyKneBjwxWAEHx+yu3285
         0TTfghZEMW/+G8zMiu99acxuUMUMKZxLyhh4tFvf+nPdFQU8X9LnkWdNVaUO+kGCyiK9
         Y7X5hMoq81kjh7D9ryVpg8sNpUJJejnS7RFfD7cHZgsS+FL1iyT2Dub/BEZ2T9H7C6C3
         oUA7INSg7HWSiSERtu5aBOAv1UP96GBdMHi7baG7eGnU1c479sOTUGEDbcDHtkLUcE7d
         Baiw==
X-Gm-Message-State: AOJu0YygoWmalnVND+0sYjontswJUYY0zxnKyaoWyY+jeP3++Tx+XC5e
	djG9n2TeLF7FjzF6G1ZphF8=
X-Google-Smtp-Source: AGHT+IHtcVSsqpn2OhDdtONPYrd3CID5q3FzehUaHcETIpeA1Eu0aToGbx41tsGa1BUMaoa7kxCnVw==
X-Received: by 2002:a17:902:e293:b0:1d4:381c:a3e5 with SMTP id o19-20020a170902e29300b001d4381ca3e5mr12389414plc.66.1704027959481;
        Sun, 31 Dec 2023 05:05:59 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-43-201-67-36.ap-northeast-2.compute.amazonaws.com. [43.201.67.36])
        by smtp.gmail.com with ESMTPSA id b12-20020a655ccc000000b005cdf7923113sm13137144pgt.68.2023.12.31.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 05:05:59 -0800 (PST)
From: yongsuyoo0215@gmail.com
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yongsu.yoo@lge.com,
	v4bel@theori.io,
	0215yys@hanmail.net
Cc: Yongsu yoo <yongsuyoo0215@gmail.com>
Subject: [PATCH] [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic into CA_RESET
Date: Sun, 31 Dec 2023 13:05:55 +0000
Message-Id: <20231231130555.1415-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Yongsu yoo <yongsuyoo0215@gmail.com>

Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>

In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET ioctl
is called, in a normal case, the state of the thread of the
dvb_ca_en50221_thread_state_machine will transit like below order.
DVB_CA_SLOTSTATE_NONE -> DVB_CA_SLOTSTATE_UNINITIALISED ->
DVB_CA_SLOTSTATE_WAITREADY -> DVB_CA_SLOTSTATE_VALIDATE ->
DVB_CA_SLOTSTATE_WAITFR -> DVB_CA_SLOTSTATE_LINKINIT ->
DVB_CA_SLOTSTATE_RUNNING
But in some problem cases, the state will become DVB_CA_SLOTSTATE_INVALID.
Among the above mentioned states, the DVB_CA_SLOTSTATE_NONE and
the DVB_CA_SLOTSTATE_INVALID are "already stablized" states,
whereas other states are "transiting" states.
The "already stablized" states mean no matter how long time we wait,
the state will not be changed.
The "transiting" states mean the states whose final state is not yet
determined. The state keeps to be changed. Only after some time passes,
we get to know whether the final state will be DVB_CA_SLOTSTATE_RUNNING
or DVB_CA_SLOTSTATE_INVALID.
During the "transiting" states, we do not yet know whether the
CA_RESET operation, which triggered the "transiting" states, will
succeed or fail. For this reason, during the "transiting" states, if
another CA_RESET ioctl is called and if this new CA_RESET ioctl
operation begins again, it will be meaningless and waste time.
For preventing this problem from happening, we make CA_RESET ioctl do
nothing and only return EBUSY if the ioctl is called during the
"transiting" states.
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..506a46844ad8 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1362,7 +1362,8 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 			struct dvb_ca_slot *sl = &ca->slot_info[slot];
 
 			mutex_lock(&sl->slot_lock);
-			if (sl->slot_state != DVB_CA_SLOTSTATE_NONE) {
+			if ((sl->slot_state == DVB_CA_SLOTSTATE_RUNNING) ||      
+			    (sl->slot_state == DVB_CA_SLOTSTATE_INVALID)) { 
 				dvb_ca_en50221_slot_shutdown(ca, slot);
 				if (ca->flags & DVB_CA_EN50221_FLAG_IRQ_CAMCHANGE)
 					dvb_ca_en50221_camchange_irq(ca->pub,
-- 
2.17.1


