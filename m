Return-Path: <linux-kernel+bounces-101258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B82C87A4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9AE1C21C19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B681CAA6;
	Wed, 13 Mar 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyvQnFev"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E356199D9;
	Wed, 13 Mar 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320879; cv=none; b=FeDYDhfgmQ6UlqgJRFaVMgniCQBZR55hIEX3/Y7gNFxt3eJ/K9mFLB33iaycRCP73g/uMrm/KMMfIPnFft8sVtdnvSqQ1R/rcS0mmwfsQqTGD05zuyomMvfBSJIVTTKnZEpm94KCpF0HfXdos54Xvugmx19ehLgvGpgotIxlmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320879; c=relaxed/simple;
	bh=XZNlIFgmzShsfg9UcQ9/lW6wWH908ZSqZdC/i19FpbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pgza6r8RKWP7qexEK7e03IT6g63F16NlyvSjGonK0K2tK/GOOmHItYwI08Psyf8EckOoIOI/Gw3XQlez7vD6P1DmyQweC4wcH46M04yKF0HMbs/XlfqEtwafhxaLssnpS8hJl2yJwD7Br5ODQrItYB7eQkCs8TlnOF7FFRd6CXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyvQnFev; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e8f906f3dso3678328f8f.3;
        Wed, 13 Mar 2024 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320876; x=1710925676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qeyRcTWGmV3/k4pJx5f4EP1VJdXvmC5lkMw80S3xkUw=;
        b=lyvQnFev4WZO52dLPIt17ujvRSFMc6NgC5KyESUysnVJ9bzt40TeWf0dZmT6Renltg
         pnOIcBXgC/4ep0vko8syKXNcUKBQdX7dAlx1qaZ/K8z7ZpyZK0GHP3JkGj67brziYCLM
         vAMdd5FmcRh5pbE5nH3ZHUYMsh+LfsvTNgKMLsmtRQAyCTwhdpIJug1qLoZi2M0F9xKG
         xI42ZQwxe5hyQOhmDBUpkXaViSjSgeO+DCPXS+DQdEwc4hfNtVpaulz9PSlH2ay2j4V3
         kC6mJPrDCet5OeiolMyVmLkorMCF0tHlSZpsh39olDIOfMPYd0S+Tq4S9Qdgbg+jQnq2
         B73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320876; x=1710925676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeyRcTWGmV3/k4pJx5f4EP1VJdXvmC5lkMw80S3xkUw=;
        b=AWElkcrFS2ybux2jhUVkZJON0S9NbAFUnVh16cMYBybNorM8xVBAcNpebWKe7tFsVP
         vQeKtEOVHYYUKSYSUsnufto2aJDR9YYie1UCR4SqIhPiDz1zyoDJB/u68sWjWmuNoi5y
         0cPDEkG9/b7JR2a8x1AU/TKXIkJ6BfJjhCYvcXBE31ujBt0DWqwYc+BGO8FR42XXUB6f
         cWsn9Zka7fjVSCByc3cVEU1u1B3nvUbc0UipS+5ZdR4NHCMhGPseOtAPQqW8zofzuipn
         q0ubeY/E99bOPoo+F0x7zJ2GKBWiEau5Vp1rA12185WWaDFKU3J7rnoF7Lsa71pdhYwS
         wD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/WNj7iyGkDFqGurmtaHeTJVPe0u2yzzcsd+m/gTwP2pwCNcb9w8eaafTAv7ikeXPmBl4NCJjg3zirfC5XGSsbagnXjU37dih2fa8f8yDQ2CHPBzkTXiHfY8Bc0pCIk1waypn5
X-Gm-Message-State: AOJu0YyRvIBthPc0f7Horgh2bZrz9sJKM3Ax9SOAYcE3H22jdWRW9lrf
	z3hPawWkgJd/heEJheilFvEYHG2Q9hi5GiwqDj6c3QqnpNEU5KcE
X-Google-Smtp-Source: AGHT+IGQtxdwxe8pKAZExDB4/7R09XkTOzJiihwXGrw5ONx4PGCG032jr3RFNQifqzfamZvvJyvPeQ==
X-Received: by 2002:a05:6000:400d:b0:33d:2d2c:f404 with SMTP id cp13-20020a056000400d00b0033d2d2cf404mr1749690wrb.15.1710320875703;
        Wed, 13 Mar 2024 02:07:55 -0700 (PDT)
Received: from macminim1.retailmedia.com ([2a01:e0a:b14:c1f0:617b:c61e:d65f:861e])
        by smtp.googlemail.com with ESMTPSA id y9-20020a056000108900b0033e206a0a7asm11200676wrw.26.2024.03.13.02.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:07:55 -0700 (PDT)
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
Subject: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Date: Wed, 13 Mar 2024 10:07:16 +0100
Message-ID: <20240313090719.33627-2-e.velu@criteo.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6871a7de705 ("[intelxl] Use admin queue to set port MAC address
and maximum frame size") from iPXE project set the MFS to 0x600 = 1536.
See https://github.com/ipxe/ipxe/commit/6871a7de705

At boot time the i40e driver complains about it with
the following message but continues.

	MFS for port 1 has been set below the default: 600

If the MTU size is increased, the driver accepts it but large packets will
not be processed by the firmware generating tx_errors. The issue is pretty
silent for users. i.e doing TCP in such context will generates lots of
retransmissions until the proper window size (below 1500) will be used.

To fix this case, it would have been ideal to increase the MFS,
via i40e_aqc_opc_set_mac_config, incoming patch will take care of it.

At least, commit prevents setting up an MTU greater than the current MFS.
It will avoid being in the position of having an MTU set to 9000 on the
netdev with a firmware refusing packets larger than 1536.

A typical trace looks like:
[  377.548696] i40e 0000:5d:00.0 eno5: Error changing mtu to 9000, Max is 1500. MFS is too small.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f86578857e8a..85ecf2f3de18 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2946,7 +2946,7 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	int frame_size;
+	int frame_size, mfs, max_mtu;
 
 	frame_size = i40e_max_vsi_frame_size(vsi, vsi->xdp_prog);
 	if (new_mtu > frame_size - I40E_PACKET_HDR_PAD) {
@@ -2955,6 +2955,14 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
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


