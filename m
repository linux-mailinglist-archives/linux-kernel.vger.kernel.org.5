Return-Path: <linux-kernel+bounces-100032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B09879115
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23792B21C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F837827A;
	Tue, 12 Mar 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQDHc8T6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C980E77F2F;
	Tue, 12 Mar 2024 09:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710236442; cv=none; b=FmbseeIJ7a0ZrpX3u7Nd9mhdhPbxpeS4fRjz2ro+1D0nVwIU/0iIaQ9uSv3EnwGKnibgjTrQpvQFo+zv7sI34dBHjA9OmfbxhnEFbnquU96BY1mn49wTYS8c3CslC8/XIPYU6b3SPSF2nneBEDVDUPC1nSQqpmQbypi+VamDOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710236442; c=relaxed/simple;
	bh=tmePU1iEUeptB/usXESyaF9rgBcN4g4YCoYahzxHmIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlryOA4jbPj9A2hYSsFZzVKIhLz5fMKoSApC6QbkflbMImZYQbhILu9ChnYc5/Xd10F9C91vpiThyS5wKgtFOlKzrYgM3Qusj+eSku/1jNLQWaM+CoKxn6LCeDxd+QLTi+COm4HAmGiAi2WeD6C/X5fQuPkFI2hokLCOb98m6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQDHc8T6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d26227d508so80419541fa.2;
        Tue, 12 Mar 2024 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710236439; x=1710841239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9fbTW88c5dd+uJ3t+O23Zk0Rd2E0M+rmOigqz72HeI=;
        b=hQDHc8T6GrHQKyaE43cFy+nXwSzBAoterJVXXC8d4XzrC1TtI9tGhn4g0NUD9spuQC
         MdsChiCwSEK6cCd4N+uBV5ewqfrF0GMoTS6qTUoQHOmuXNWv5MiStHesIFWlUM+jBEZH
         5yJKB00qM7QU1O1+NQLcNXwrMQ7n9o9HRxCiRCIZThTCbbnte+MTMhD6X5IwjU/CqMLf
         sSAsypw7lV+KsnAHsuDQk+xmVIqffWJJmrFMQO9rAE0D2BPtDbbMKy3ctn8PKBxNPUDI
         vTuSjvRxaCxr/NVnwJTiOEqibaNPD/lMkVZQnSJY+lt8VCqb4DmRZuXHezn2+6ETg81o
         KfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710236439; x=1710841239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9fbTW88c5dd+uJ3t+O23Zk0Rd2E0M+rmOigqz72HeI=;
        b=FuaJchLJlQS3QBAsSrHb9R3r8eJjKizE7b/UqUHUZNRaoFQoGAdCO+zBRCi9hOkF3R
         USMqyb82fHM4POI3Yz3vtNU10oNyBgISu0CYhzthLxFBLFZaeQF0ZZ4MOAOZAsR6E6Mi
         t8iI7TkmQCZNMZqssA/GcwGZrqY0tN8RsyZMfo9Z10MuWnlUznzrgAhtt4Li3Tb4g3b3
         SCESEeHzJ8LdHai5oi/zI/2lKTe62GrJXhnISRa8hfDdAF47FWA8fg8DMSeReeDG4DzY
         v+t5J7wLDRTEWzknDKmgS9+hafonEgckSD7cwnkz64tj0h4AxvRww97J4rp9VkG6Nxrd
         CYzA==
X-Forwarded-Encrypted: i=1; AJvYcCVdbTb5Hxw0NDYNyVlukyQFlfUy+uvIT+NbElwvTB78iQWV2OzxjUmA2GnLRFdzEJIEdaeoMcLIbxuaISMjXCNjEdxAuLQXri0R0elDq3W5GqSTEaWOTp+f0Zneg749AWTi8JnV
X-Gm-Message-State: AOJu0YzN3pqR9UkiK/uKfp99qnUb48T6mxpKlLLVUd+biKwXTLQPTRty
	cenWRcvUHNg2uY2OgoDPpe6QKLSJVhTs2uUR4j5MgwCSGhMgNtk9
X-Google-Smtp-Source: AGHT+IFuSl2KQf9S7ZnfmhVEsHDRf9lt5h2kPj4tW55Giijk7aCci9Cl7tyOz1BXGzJ4nqu7VKAttg==
X-Received: by 2002:ac2:5042:0:b0:513:9d46:5fec with SMTP id a2-20020ac25042000000b005139d465fecmr6006986lfm.15.1710236438599;
        Tue, 12 Mar 2024 02:40:38 -0700 (PDT)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id jt23-20020a05600c569700b00412f4afab4csm515346wmb.1.2024.03.12.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:40:37 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] i40e: Prevent setting MTU if greater than MFS
Date: Tue, 12 Mar 2024 10:37:55 +0100
Message-ID: <20240312093757.770283-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.44.0
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
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 89a3401d20ab..225b2fd0449e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2950,7 +2950,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	int frame_size;
+	int frame_size, mfs, max_mtu;
 
 	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
 	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
@@ -2959,6 +2959,14 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
+	mfs = pf->hw.phy.link_info.max_frame_size;
+	max_mtu = mfs - I40E_PACKET_HDR_PAD;
+	if (new_mtu > max_mtu) {
+		netdev_err(netdev, "Error changing mtu to %d, Max is %d. MFS is too small.\n",
+			   new_mtu, max_mtu);
+		return -EINVAL;
+	}
+
 	netdev_dbg(netdev, "changing MTU from %d to %d\n",
 		   netdev->mtu, new_mtu);
 	netdev->mtu = new_mtu;
-- 
2.44.0


