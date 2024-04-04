Return-Path: <linux-kernel+bounces-131337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09C589866F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F5E288245
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54585280;
	Thu,  4 Apr 2024 11:49:52 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B8286B;
	Thu,  4 Apr 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231392; cv=none; b=gAP5/rvzDj5AA9srmplkrKpS2niN/TZLbmUzckufIYrA7w+NDo+zLQQiB2E8gVjNd0lY1h2F7nBx3F6pzu7RZ9ry/otLco6swSWX12MpE5nwltbYpQLbTgUeaqWk9b4C6aRSP8YA/42RiaXrvf6Lu/8yh9gm8CoMOKL9E1f/umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231392; c=relaxed/simple;
	bh=rWbrqNP2jyNIuW4GC9x5L1VtJAk70ZYdmbHoBKNEOUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJjR1tn3kLTiCXpJ2lXmBhbszfDGvMGajE3Q47GrC+aaUMEWZvWer4UiBtXXiFrJlQwOLcVx8D5kpJ69D0Aqy7z/oycGZpJKQ54sueTmZmxS/aOw7pISBWm6h6jWKzyZNvtUgJap286yOTf4F5hK6rGpbh32bocxRckDWQ+47ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a450bedffdfso119451166b.3;
        Thu, 04 Apr 2024 04:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712231389; x=1712836189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mM0VRkY4R/s+2RZMIGBjXivRb+LhyFR0UNjBp7WG/2w=;
        b=KOQTvE+ndRr4+2qUIpAQeB4QGHK5iS3nsuQQVnWQOnVLYgw+/1EottMxa/aAWv9lW9
         Dwk91soPBJ/tBwN342jpxAoOWFPtXgzhTW5QaSTFbdlhC2/uE0dIQ7dgDjZ7LaJAPjih
         NxjA7WYSNko6LjBuEm2TfJ8QgK7znhcps+2u6+ouDphH3GpWPS6504KJXDaNVYVB+BoS
         vDW4p69EMY4+6q6a12JHNxK68wark7PM2WNbB6MBoJXZenIen/tjHSuVO3Fit3EMOPK/
         fNIrBCkTvE9+n8n6pTrv7gb3ZfI+bb+pE+69YZfo4XX1US2vq3KPkM3BpSRvc5Y46jug
         GOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXwaKVOJno07lPaA/VMC6e0VZ/0wejsPLGrp42R8Vk1niDCJjCkBBpzar3h5L1HdtBBjWRdwiijjrsDbHIc0MmB6zBXmODiskMzmi2h/5aXCvzGVguB6Z9Wm/GgvvurlsL/zP+XN2cg9EOkoFf2fUn9Mk+2+AvP+P9G
X-Gm-Message-State: AOJu0YzWJ8v5lj8sXhM0aWbxyb2An/omlQjRp5VyzdAvrJxp240nE/M/
	xPxS+R8SS08nA6AaH5BLczLY82j8LZ1/nhTANAuXJECDkhgG8B8j
X-Google-Smtp-Source: AGHT+IFDNnBaWKjKBUScMyD1XxsRGzjVdkpYifMEFEBvLKEwHf4ElIsvpdnvFDl4eaA7HXmhAU+ciQ==
X-Received: by 2002:a17:907:9807:b0:a4e:539d:2183 with SMTP id ji7-20020a170907980700b00a4e539d2183mr1768927ejc.73.1712231388672;
        Thu, 04 Apr 2024 04:49:48 -0700 (PDT)
Received: from localhost (fwdproxy-lla-118.fbsv.net. [2a03:2880:30ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id xj7-20020a170906db0700b00a4e379ac57fsm7640946ejb.30.2024.04.04.04.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:49:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	elder@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	taras.chornyi@plvision.eu,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/5] allocate dummy device dynamically
Date: Thu,  4 Apr 2024 04:48:40 -0700
Message-ID: <20240404114854.2498663-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct net_device shouldn't be embedded into any structure, instead,
the owner should use the private space to embed their state into
net_device.

But, in some cases the net_device is embedded inside the private
structure, which blocks the usage of zero-length arrays inside
net_device.

Create a helper to allocate a dummy device at dynamically runtime, and
move the Ethernet devices to use it, instead of embedding the dummy
device inside the private structure.

This fixes all the network cases except for wireless drivers.

PS: Due to lack of hardware, unfortunately all these patches are
compiled tested only.

---
Changelog:

v1:
	* https://lore.kernel.org/all/20240327200809.512867-1-leitao@debian.org/

v2:
	* Patch 1: Use a pre-defined name ("dummy#") for the dummy
	  net_devices.
	* Patch 2-5: Added users for the new helper.
v3:
	* Use free_netdev() instead of kfree() as suggested by Jakub.
	* Change the free_netdev() place in ipa driver, as suggested by
	  Alex Elder.
	* Set err in the error path in the Marvell driver, as suggested
	  by Simon Horman.

Breno Leitao (5):
  net: create a dummy net_device allocator
  net: marvell: prestera: allocate dummy net_device dynamically
  net: mediatek: mtk_eth_sock: allocate dummy net_device dynamically
  net: ipa: allocate dummy net_device dynamically
  net: ibm/emac: allocate dummy net_device dynamically

 drivers/net/ethernet/ibm/emac/mal.c           | 13 +++--
 drivers/net/ethernet/ibm/emac/mal.h           |  2 +-
 .../ethernet/marvell/prestera/prestera_rxtx.c | 15 ++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 17 ++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   |  2 +-
 drivers/net/ipa/gsi.c                         | 12 +++--
 drivers/net/ipa/gsi.h                         |  2 +-
 include/linux/netdevice.h                     |  3 ++
 net/core/dev.c                                | 54 ++++++++++++-------
 9 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.43.0


