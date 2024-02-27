Return-Path: <linux-kernel+bounces-83927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B7586A02B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48132883F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4C1487DC;
	Tue, 27 Feb 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDQ5mKyR"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A550A68;
	Tue, 27 Feb 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062049; cv=none; b=fqaz4cEnDwvR/Z6saQb/gqlVI386QQEGIk0XowBdGYmX6Ys2TvXTrtdvUZr8RsUg96MqSzI9sxrOvErz94lT77c9qrp7V8hNzWiwlIczgcu3frno5qVQ/00R4RV5sKnwayORZriSID/1CzU2bKCGxV8VrJDdgIm4d2O8EUooIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062049; c=relaxed/simple;
	bh=EqsLvIImce7QGWkPVEQZAZcNWfJbExoKdrSW+vror8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2DYb0To+T/+xdctYkj5vZa1Ppn2edKhGXvQ11px2OF9I8/0q7fmifgqgGya6g54EdfSM2MkciUJwpgI/tZjZA9ZRioEA0ok28EwJArFB+rTlrQOrR+YkGuhZdisHOdt+fROdSxb0G5ywaaWHLFp+S7YkhUULqEPF/Q5nmFhLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDQ5mKyR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so65338721fa.0;
        Tue, 27 Feb 2024 11:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062046; x=1709666846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtO7eARrOzPr4vplwQY3fP3qCNMybXHa66yqZyCEb6A=;
        b=dDQ5mKyRHvcyuxVTS8EFyP0R4e7CBDNndQY6vylahFARkJ5BNG8TrV1AufUD+JOg0w
         3Lk02g84xvq+Q3wREeKIdpL/nzYAeYKItNpvtvSCdObpQBy7q1Aq6WNL/BBVQbfhRSWu
         0DyxiwsDKvm5vlpmkcnFBPuHtqFxEikA+nsWISDpaSWC9odYaRaTyzMI+/LW0yojZ6AJ
         X+YXS2ugsVDlIu0hinZZ5hWotMq2WOMmD3o0jQ+hW0hURxIiPH2A5GKz0rYZ7lD+xPh2
         tdP7hl4PgS24L8MOhVAPHg7AfD6evTprkuKBxYgl5DQg7UppnurAJAo8Of5sBEUeH4OC
         ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062046; x=1709666846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtO7eARrOzPr4vplwQY3fP3qCNMybXHa66yqZyCEb6A=;
        b=ll3Ctk14q0MPDBPLxPbnpbErHn4COBsggNUSLOkIGCpCHpKHEkHciRaDPLbKjS2pgb
         F59b09Q2dz+O8llPMinPC7OVXUhVt/UNZuTC9qi9movt0GA/3KOMVp9u7M7F/JeGLV9K
         JzdQD01tq8xTHe/U3/EXS23PyoU1STwdaOBZ1abxLDmIt+f/KLBb+NWsjg07MCl9Ne8g
         n/wL81f/4XZFdIC6FdHk2UeDbL2V0gOPovlketYZI9OvoG2Kc1I2uZGRq1XXXj9RFtop
         DsJlQh1CRIJpf5vdMEQ4wmKR9K4oYRPsTnZpQpYVUfwkFyI53YfK75pW2ygyxVQFsTVx
         1Maw==
X-Forwarded-Encrypted: i=1; AJvYcCX2b0AyPoQe60LBnxAzT+XhH34XMv0LTLDGZRqQDoDZXJOKU0M6RLEpksG46CWgXCWFpeOGdbZ7Z1hj4xOPMIFGpXSpM3XIfrx9F6Q16ntT7TmdeiewkSaCp/UJ2HV3e1FbrX/u
X-Gm-Message-State: AOJu0YxkT76gVq1EqCV3HLQmI3U/em1IlYeXP5USxHwYb+aiY6CRWiCR
	XvGWIp+falbboM4xYRl0RJvLNCbmRrMDC/OMqYZQJDTjoDIK2FhC2XKE4qKAxqM=
X-Google-Smtp-Source: AGHT+IEERH23YsBcEq4wE6ogzVQxQFB1kkosdw4mF04em+goPWGBrBhI6JGtQmbxRvqegX3FYr3UhQ==
X-Received: by 2002:a2e:7315:0:b0:2d2:2eb7:9ab3 with SMTP id o21-20020a2e7315000000b002d22eb79ab3mr6912091ljc.32.1709062045563;
        Tue, 27 Feb 2024 11:27:25 -0800 (PST)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id 18-20020a05600c025200b00412abfb0ed0sm2915784wmj.0.2024.02.27.11.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:27:24 -0800 (PST)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: erwanaliasr1@gmail.com,
	Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i40e: Prevent setting MTU if greater than MFS
Date: Tue, 27 Feb 2024 20:27:03 +0100
Message-ID: <20240227192704.376176-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6871a7de705b6f6a4046f0d19da9bcd689c3bc8e from iPXE project is
setting the MFS to 0x600 = 1536.

At boot time the i40e driver complains about it with
the following message but continues.

	MFS for port 1 has been set below the default: 600

If the MTU size is increased, the driver accept it but large packets will not
be processed by the firmware generating tx_errors. The issue is pretty
silent for users. i.e doing TCP in such context will generates lots of
retransmissions until the proper window size (below 1500) will be used.

To fix this case, it would have been ideal to increase the MFS,
via i40e_aqc_opc_set_mac_config, but I didn't found a reliable way to do it.

At least, this commit prevents setting up an MTU greater than the current MFS.
It will avoid being in the position of having an MTU set to 9000 on the
netdev with a firmware refusing packets larger than 1536.

A typical trace looks like the following :
[  377.548696] i40e 0000:5d:00.0 eno5: Error changing mtu to 9000 which is greater than the current mfs: 1536

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 54eb55464e31..14fc70d854d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2950,7 +2950,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	int frame_size;
+	int frame_size, mfs;
 
 	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
 	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
@@ -2959,6 +2959,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
+	mfs = pf->hw.phy.link_info.max_frame_size;
+	if (new_mtu > mfs) {
+		netdev_err(netdev, "Error changing mtu to %d which is greater than the current mfs: %d\n",
+			   new_mtu, mfs);
+		return -EINVAL;
+	}
+
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
 	netdev->mtu = new_mtu;
-- 
2.43.2


