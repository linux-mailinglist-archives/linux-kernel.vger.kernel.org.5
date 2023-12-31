Return-Path: <linux-kernel+bounces-13649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5C820A57
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 08:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94712833BE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274220FB;
	Sun, 31 Dec 2023 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7hBKGci"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145E1844;
	Sun, 31 Dec 2023 07:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7b7d65d4eecso407871639f.0;
        Sat, 30 Dec 2023 23:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704008036; x=1704612836; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT4YKhx1arQKM4uZFE6CXUn3u3YsdPfEE6W1XkpDDy0=;
        b=T7hBKGcifCaTIG8Qvw70/ot4lg9RObFfMz6/BzqCbQvvhkAy9t4csl5ThhXOBwvwDD
         wlsrw33T+ybIC8f1Cwwh350PHJKwGI+NVXiyNhfTF8mQqeb+K2EBdA3p9Pa9kNK2n7wt
         riCUlL0TIlGbiq+h/Womko5rQulcsW69Ba4XOTuNbxblw/GWyTpcr3R5dTGKTCMNR1S2
         0yfz6u8PiRgfapiNW886e9WusXHhEe17sd1/Hy01zxtNwyUT4PYDM10ubOsBW42rfpFI
         nwgZ+CwLrWQam+XuIPmfxLF5Oz1D6OhRtE7dOuBEo51wydqkCtL5ms9TD7n4WcOzIhKs
         GkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704008036; x=1704612836;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT4YKhx1arQKM4uZFE6CXUn3u3YsdPfEE6W1XkpDDy0=;
        b=iBf3YE2qp/p4HA0QgoN+vlniYGmAP6D8OLq6CnXKziyc8QNgcmCV+gDkZmAzyDSYG7
         wSyV6KhqdZVFtN+JPahVGTHfkeJdy/RYG8hSecOQ0HIcEeC4+ZlWFFSvg8KZESMS6k1D
         AmwWtgL7JnEr/KMfBQAp69JOL85cwIPMX6+m1ABOlfssDCK4d0ih4+hdF2UKxT41Tcfj
         TlnZ4JHEui3faT8FgCuZg5P0/wfDS8DgdfBNuSoxeOi0pAJCuxOP3DFiVOS7e7YCxKfm
         zGXU62ELdkuN6wYar4p/hwW6LCSqepiKlhDOhxMk6ubfcYpg4DpuFDmWfInKFhUlyh4G
         x0xQ==
X-Gm-Message-State: AOJu0YyiuPUdjEds6BTbRl3ti7FB/tTToiZ9KBrCdUaWSi08FjbNcaH8
	8JOk5rECfRWlZxhhb3Cbdp2mRO6mvRdzAg==
X-Google-Smtp-Source: AGHT+IE1pM6K605ozyzhYXLrB3XJM1l6npyq5tKa9uP+Fm/Krjwxk9xQ/SBD8NRX49F4oBgvK3F87g==
X-Received: by 2002:a05:6e02:198b:b0:35f:dea6:55c with SMTP id g11-20020a056e02198b00b0035fdea6055cmr23465268ilf.3.1704008036010;
        Sat, 30 Dec 2023 23:33:56 -0800 (PST)
Received: from goorm.ap-northeast-2.compute.internal (ec2-52-78-220-127.ap-northeast-2.compute.amazonaws.com. [52.78.220.127])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902789400b001d47868c31fsm8496519pll.194.2023.12.30.23.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:33:55 -0800 (PST)
From: yongsuyoo0215@gmail.com
To: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yongsu.yoo@lge.com,
	v4bel@theori.io,
	0215yys@hanmail.net
Cc: Yongsu yoo <yongsuyoo0215@gmail.com>
Subject: [PATCH] [PATCH] media: dvb_ca_en50221: Fix a bug for detecting CI MODULE
Date: Sun, 31 Dec 2023 07:33:52 +0000
Message-Id: <20231231073352.1929-1-yongsuyoo0215@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Yongsu yoo <yongsuyoo0215@gmail.com>

Signed-off-by:Yongsu Yoo <yongsuyoo0215@gmail.com>

In source/drivers/media/dvb-core/dvb_ca_en50221.c, if the CA_RESET
ioctl is called, the dvb_ca_en50221_slot_shutdown will also be called.
Inside of the dvb_ca_en50221_slot_shutdown,
the ca->slot_info[slot].slot_state will become DVB_CA_SLOTSTATE_NONE.
In the most of cases, the ca->slot_info[slot].slot_state will quickly
becomes restored to other states by the subsequent operations of the
thread dvb_ca_en50221_thread_state_machine.
But in some rare cases, when the CA_GET_SLOT_INFO ioctl is immediately
called after the CA_RESET ioctl is called, the
the ca->slot_info[slot].slot_state can still remains at
DVB_CA_SLOTSTATE_NONE, and this causes CA_GET_SLOT_INFO ioctl not to
return CA_CI_MODULE_PRESENT as info->flags even if CA_CI_MODULE is
really connected on TV. This means that the CA_GET_SLOT_INFO ioctl
does not return right informtion. This is a Bug. We fix this bug.
---
 drivers/media/dvb-core/dvb_ca_en50221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..8d37c3c13227 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -1403,6 +1403,10 @@ static int dvb_ca_en50221_io_do_ioctl(struct file *file,
 		    (sl->slot_state != DVB_CA_SLOTSTATE_INVALID)) {
 			info->flags = CA_CI_MODULE_PRESENT;
 		}
+		if ((sl->slot_state == DVB_CA_SLOTSTATE_NONE) &&
+		    (sl->camchange_type == DVB_CA_EN50221_CAMCHANGE_INSERTED)) {
+			info->flags = CA_CI_MODULE_PRESENT;
+	     	}
 		if (sl->slot_state == DVB_CA_SLOTSTATE_RUNNING)
 			info->flags |= CA_CI_MODULE_READY;
 		break;
-- 
2.17.1


