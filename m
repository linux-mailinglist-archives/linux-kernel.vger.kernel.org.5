Return-Path: <linux-kernel+bounces-108851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C098810E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B621F243EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F193D964;
	Wed, 20 Mar 2024 11:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiJz9UdB"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D52BB0A;
	Wed, 20 Mar 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933963; cv=none; b=Ex5ih/zuKdQ/QyLdGfowrKc5eVTjdBhhUE1btX+B/o46fbksL9h2sbxsUVVebVUWF0TQP2IySueOxMqe/OXxQyUu8DyRKxL8ysGihQCXX4eAYezWmDJh0/DfS7ThYejRvl5sjRm9kLUgbZ+RV1VCzuOVkJKLJz+4hIylLdBrewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933963; c=relaxed/simple;
	bh=iXfTvVYD/74RU3fz9WyKXv9rogFeN8hhDiMvXWTzzL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQXUTWPusP8MO3Ijn+LKFCCqvGExJ8n6wnLkfN5Zt8/3OwgYGQ4Z268anH421UuenPNLXTybVgLQkeyjvJGGaTXHchmFa0ZEQZkrfa5zJ+2zU2GoPBU2JNRtIcOHMnWt9bAlyrRFtGr885pinTz4ZXsLsnaZR24PnLLgBe4AiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiJz9UdB; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so88575041fa.3;
        Wed, 20 Mar 2024 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710933960; x=1711538760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMloB9RfRbEnZWDpgulTh3z5yIYHXDXn4Rg20jknDtg=;
        b=jiJz9UdBsThiM+JVRtUIx+fd6XnLf9gSylO50eQU3Um1vo8oNgpstbulg/SCr5rBCh
         6HkymlcoEM0Qfl+H4/O/XM3xKVxH+gpH0ksZyvFsNa7AQoNe3urL+iKhFIvE0t0zpznr
         tQ8FiLfPogm7eS7YeOaa5PTe3zfXDKLF0eApbH0pinZzSCCR6Y6yaodsyO6b/H6pmxzV
         eg6KxK0Dp4IL/qzNcvEpxEcVQk8+qYrkZzyXqM4U54j5T+r85UGGbUVTCnciOWxQ0L8s
         Lm0TCb3o/5ms4f9UBLoLSyBXhYRsZBr+FbHVVHrAlxcSocZ6D793jRrDCc59CsKRHw1D
         dnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710933960; x=1711538760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMloB9RfRbEnZWDpgulTh3z5yIYHXDXn4Rg20jknDtg=;
        b=FPDLqt35ZmV/F5C0ipV/pnQfe+xUAns94HRGuzZcFaQwUwbTpH2CPrNfT58Jn5YG3O
         RiFf9he4XQfue4DIc5ojTxQP764H0d1vgDNIFk5XFeRXD0QBZqIqqNCc5WSv5xIw0Jrf
         +wc1FPf42hDY9kgF5dg1J1y0BYkipzW84wSnXuutxeDkMEZH3MSFy4Tpkq9G/o52hS+D
         IqdjqDYjJv9SHLUzUrATjtdf7hTz6vSygdGWJwV3N9BgW3Z1C9m/8oaovSnkCjpjFdZI
         +BPY3KMLnPLdwTuWmz5YQpNEaxvxv5ilBb7o+ElLsmv4xt2TaDCLOKCrgaXbxGM4fu0r
         YNMg==
X-Forwarded-Encrypted: i=1; AJvYcCWUT4xFxrdTmAb1pNfL3qtTfZqXhEUi60J4z5QD4otkAnwRpEMzb90XXbI/CTo+C5NbdCKI4rxX7n2DA4mcubf/AaBRP5YyWQM4Kmve50xwheG4JVpIS1Q8WS6DKYw30NcJl1gRtfb4BI4y5N0vH+PauLywri2AwfAK
X-Gm-Message-State: AOJu0YyMYX5Oz1KtpGB6e15h3GdLL+NrD52N3ug/UT0LoEDBpoOM2i9B
	YCpI8fM9/hTbqnEI/CelImgf/tJ56qH42Bl6gkYNJwtuuEMvPZzX
X-Google-Smtp-Source: AGHT+IGadU+b0/+WDY0GhAtI/Nq447ky8ONTSH4gONcBUvaBDixDV3c0Twf26waZnPAkvHChZOIn5A==
X-Received: by 2002:a05:651c:22f:b0:2d4:78ba:fa45 with SMTP id z15-20020a05651c022f00b002d478bafa45mr1313118ljn.2.1710933959515;
        Wed, 20 Mar 2024 04:25:59 -0700 (PDT)
Received: from pc-de-david.. ([2a04:cec0:1033:b0aa:f477:524f:4101:14c3])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b0041409db0349sm1901170wmp.48.2024.03.20.04.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:25:58 -0700 (PDT)
From: David Gouarin <dgouarin@gmail.com>
To: 
Cc: david.gouarin@thalesgroup.com,
	David Gouarin <dgouarin@gmail.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Camelia Groza <camelia.groza@nxp.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] dpaa_eth: fix XDP queue index
Date: Wed, 20 Mar 2024 12:25:19 +0100
Message-Id: <20240320112519.5311-1-dgouarin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZenidKFF/gQefijz@boxer>
References: <ZenidKFF/gQefijz@boxer>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to bind a XDP socket to a queue id.
The DPAA FQ Id was passed to the XDP program in the
xdp_rxq_info->queue_index instead of the Ethernet device queue number,
which made it unusable with bpf_map_redirect.
Instead of the DPAA FQ Id, initialise the XDP rx queue with the queue number.

Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")

Signed-off-by: David Gouarin <dgouarin@gmail.com>
---
v3: reword commit message
v2: add Fixes: in description
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index dcbc598b11c6..988dc9237368 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
 	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
 		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
-				       dpaa_fq->fqid, 0);
+				       dpaa_fq->channel, 0);
 		if (err) {
 			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
 			return err;
-- 
2.34.1


