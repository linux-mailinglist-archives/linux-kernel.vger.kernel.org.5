Return-Path: <linux-kernel+bounces-13707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2CF820B70
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C84B281C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 13:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B275390;
	Sun, 31 Dec 2023 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCPqqcbl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4B4418;
	Sun, 31 Dec 2023 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28c7e30c83fso2138727a91.1;
        Sun, 31 Dec 2023 05:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704028629; x=1704633429; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHu3cl6dyYT2DX3fZ/mA0MeLZ4iLVn+iFMGJOWHCrvs=;
        b=mCPqqcbl1TEaj9SVaRHfEd8TfoAk6wqWJRJ+xNtBPkU9+3/92A+m9E173HaSY3Gz1G
         mCt3S5pgWNVKeHIdpJ/R7Cj/MHMpmw+ZaCOIxaCk9Z2N2Vbt6lOBmtQSx7HpmqLVA9Dw
         8X1b6iZrX3kR/8syfwIsQuEo3SuXZ1BWRl7OlpMaNTnklGg4u4feCKPi9u5rZ6sn41ft
         qJxXSFgYDizQWpR/3ZLVIEaH5s0i0v6aqebg12UbMYQX5Bl5QOjbOLo2v6ucFT/DuuG5
         Yd7UMvaEfDEUlzL/v8mVyOTzwLHHUb5gvT7a02+LIf5y3dlx7hTm8w2teVxU7CWBKpLf
         gZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704028629; x=1704633429;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHu3cl6dyYT2DX3fZ/mA0MeLZ4iLVn+iFMGJOWHCrvs=;
        b=BFJMr/f5SExegQ0+SDGR9vNVmYDexzU8T1kzO2wg4CZ1gWKv9eDkU0xyJWeHGYY1wl
         SmLRVSZGvK1hrUjgVZQXINct/aB2DdWIUYOULaJoZCRnfZr6fsQpYBPUnqVh7kgE0Lc0
         qcgDGo223V9l03ww9Z9Zyod9T5XheLW4Mq9gKnw5Rds1yD/6WPXBZDhboyTalGoIVJFF
         pmFDkWVX4hAr35YchmR/p+/G4TWUxHLF27RKrpYC7KSQuw7ifArDjQUUk0EgDG8jIFfQ
         KnqiX9A4ize7+7/j97fbWuGSzBnZUzc34sJFhx7bAABMA0aKobiURcP3E1VuodbO8aOa
         LDPg==
X-Gm-Message-State: AOJu0YzJxfpoS2lT8cNFBtRdwpSKQgRFGT/g4xDhx/eCty+M5J+0WE3H
	QGylCJKLxe8LuzcfP656YAQ=
X-Google-Smtp-Source: AGHT+IEOT0qWslOYTBT9RP4U96z3C3rbdX4/Wgvhdre5kbSDpFrA+gnekWdhdA4tAbQieESpdKavnw==
X-Received: by 2002:a05:6a21:a5a4:b0:196:50c0:e21 with SMTP id gd36-20020a056a21a5a400b0019650c00e21mr1930287pzc.45.1704028629004;
        Sun, 31 Dec 2023 05:17:09 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-43-201-67-36.ap-northeast-2.compute.amazonaws.com. [43.201.67.36])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006ce71af841bsm14459164pfb.4.2023.12.31.05.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 05:17:08 -0800 (PST)
From: yongsuyoo0215@gmail.com
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yongsu.yoo@lge.com,
	v4bel@theori.io,
	0215yys@hanmail.net
Cc: Yongsu yoo <yongsuyoo0215@gmail.com>
Subject: [PATCH] [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic into CA_RESET
Date: Sun, 31 Dec 2023 13:17:05 +0000
Message-Id: <20231231131705.2010-1-yongsuyoo0215@gmail.com>
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
 drivers/media/dvb-core/dvb_ca_en50221.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..2e8aec354b7c 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1362,13 +1362,19 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 			struct dvb_ca_slot *sl = &ca->slot_info[slot];
 
 			mutex_lock(&sl->slot_lock);
-			if (sl->slot_state != DVB_CA_SLOTSTATE_NONE) {
+			if ((sl->slot_state == DVB_CA_SLOTSTATE_RUNNING) ||      
+			    (sl->slot_state == DVB_CA_SLOTSTATE_INVALID)) { 
 				dvb_ca_en50221_slot_shutdown(ca, slot);
 				if (ca->flags & DVB_CA_EN50221_FLAG_IRQ_CAMCHANGE)
 					dvb_ca_en50221_camchange_irq(ca->pub,
 								     slot,
 								     DVB_CA_EN50221_CAMCHANGE_INSERTED);
 			}
+			else {
+				if (sl->slot_state != DVB_CA_SLOTSTATE_NONE) {
+					err = -EBUSY;
+				}
+			}
 			mutex_unlock(&sl->slot_lock);
 		}
 		ca->next_read_slot = 0;
-- 
2.17.1


