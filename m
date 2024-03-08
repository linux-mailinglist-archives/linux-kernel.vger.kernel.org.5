Return-Path: <linux-kernel+bounces-96987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A6187641C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860281F24A34
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B805787D;
	Fri,  8 Mar 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8aAkqSr"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04455E57;
	Fri,  8 Mar 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900024; cv=none; b=S4fGH//ksB4f39e/aFAT+jOB5wZfV3ztfwsIek15tlY5PVm/ni7xHgKfr5OMQfSrCBZzNSmS3XomqLTv6B3tRkjWNx8tBn9eazWmyI2WfkYTxdvIsYg2Z+t1RhBeWk9hCbhMXxaU5NqSiGu9KZVtM6xZBCEdZHkNcKx1TQMZiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900024; c=relaxed/simple;
	bh=xRQYQNukZYRtKTnk/JrS0VuezsXQVEgHR6HcqlV1dQg=;
	h=From:To:Subject:Date:Message-Id; b=MtBccxGz81/witF9oaU87U5CUYiPo94qBWB4RMTevCq7TJijexu2BU46RADu7ExacS0Qlt7+BVbWTne9cs2CgPsRD2/+SBtWT/LgjBMfvheBHPB/6lK0/l0V3cwgyYbEbOsknhlUIR0jACpVz5t8QEaPvEiau6p+DxQARr54Nl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8aAkqSr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6277f72d8so1548886b3a.1;
        Fri, 08 Mar 2024 04:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709900022; x=1710504822; darn=vger.kernel.org;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHu3cl6dyYT2DX3fZ/mA0MeLZ4iLVn+iFMGJOWHCrvs=;
        b=G8aAkqSrx62rmRhUWck7zfzv1bFZptoKsDyAEs8VH51620k/mQ0U0gKCR7/Tnz+Wch
         6so0tUyY9LkG/QZgH2qBlt9LaLe9dT6YN64wfGDCZUaAWwYrb9QJfzGojwB7bWpqn9KP
         jwzvOuxQnYdSCa2Cy1IWLCS4fHL3uV+ht3aEY7QQ5fSOr8JfuNAaxppcVxWMsnWaDHqD
         XKTnpT9wV1Ahy+nyKScnGwrIqCktN2wgmojVypu59gU25+j05k+IRKFSDVL7rYsw99bo
         5bFJnOuG41IbXH+RLRSHkOvu9oqFtFcrOOFEwPyC8jCL47xFrN8go14DZlGkLMyuQ0cc
         q4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709900022; x=1710504822;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHu3cl6dyYT2DX3fZ/mA0MeLZ4iLVn+iFMGJOWHCrvs=;
        b=RB+selI4JEEero2jMxNKJ36hA9EpPiA41JhSc7/bhgD7E1tlb8Lwx2pM2YWDJQuzt4
         n9h8JD0AF5xw0nMgk/cIjLj1QBMjieqU7yY04anD1fxhCsJkISq+hFYrItOvD1Gpp9Z4
         uoS/LfqzrOxxHMJuPgFqQ4t2TZ4asVD3f4FRN/FJWmG6pseddDB6GgS7Q3ezRmajiNpi
         aRDE9G6vzp4VTRTw3pUGvju31QzgVrLRjI/YcKidBdoed9bIFgBPO2SV+Jy3ul+krRNx
         4eB+LK++dUpTfpiYtJYurJhP3PFhdMddnZ7SrNGhBHmMtvyWyBlXpnVXKVWnF//MA3a5
         R53w==
X-Forwarded-Encrypted: i=1; AJvYcCWlNVJb45pRXNivVowsXC3lms94OEADJXB4K2wEC2KXtZi+0Y0x8WyZJ678zDrHvfI8EbebZzzYt8m9d5tP7cv/6xjMDyclG0W9XcyK/R+937IIxuZN1jGiB9ejjPoVz0mgnlOCtc1HZmg=
X-Gm-Message-State: AOJu0YwfUrZ+PDG1eQZ0ScuB/KotRN1ayIqpYxNGDFUg8w5znddPbNAK
	xBbFsmfnbxy9igkSDaQ/iMiRL8g2hiP3Gj43yXbga9wr7cs132x07WU4zlZVcmo=
X-Google-Smtp-Source: AGHT+IElGT4rz74XXvDr719f0KTqYMEHe4oW9AzjSD5viBxTtCCHLMVLJhmnTj4Huxlx+5Ev8/f3Mg==
X-Received: by 2002:a05:6a20:da87:b0:1a1:484d:ef09 with SMTP id iy7-20020a056a20da8700b001a1484def09mr11655179pzb.4.1709900022014;
        Fri, 08 Mar 2024 04:13:42 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-52-78-100-77.ap-northeast-2.compute.amazonaws.com. [52.78.100.77])
        by smtp.gmail.com with ESMTPSA id o16-20020a056a001b5000b006e555d40951sm13980843pfv.188.2024.03.08.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:13:41 -0800 (PST)
From: yongsuyoo0215@gmail.com
To: mchehab@kernel.org,
	yongsuyoo0215@gmail.com,
	v4bel@theori.io,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb_ca_en50221: Add a returing EBUSY logic into CA_RESET
Date: Fri,  8 Mar 2024 12:13:38 +0000
Message-Id: <20240308121338.1983-1-yongsuyoo0215@gmail.com>
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


