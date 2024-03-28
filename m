Return-Path: <linux-kernel+bounces-123838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D5890EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732C228AF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BE1386B2;
	Thu, 28 Mar 2024 23:52:31 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91C31A89;
	Thu, 28 Mar 2024 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669951; cv=none; b=Lx7HU+199YwKqUK0stDjrHdtqRVNNQJ/ASYOUJ5Se1AGFOurXub7mi7e9k8xGIZCky3PnOx/K8eeGZ23V3/upbo163ce7x0wkruvxwpu3KQ480ScGNqIBGUA9SAbVzfeUTnExc3tmYx1tHKhXZu2cSo5noNOeqWRVpfsFqUJIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669951; c=relaxed/simple;
	bh=etDRwKheHq95MKBzVfJh5fym5y4GzVa/9DYqO8PheyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqPeKdsu2AicGIKmmHKKsvvx9xILKd613rvFWYegCi212BPDnJoivHiSgzhmvqQ5es92e9MdfwYpO6QaVxyCByiIQ0BT8En/eeqqdm/nnoM+BNko2yax4Nun3yrZf/tGIPQTplflf7AcXtz+UTnvsiWsQ9U0FOD2oruJWCJZwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e89d0816so1713825e87.0;
        Thu, 28 Mar 2024 16:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711669948; x=1712274748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHFTjzwMlLxYTV/uWUOWTAxMr5DnJvs9Xihd1iUFzOo=;
        b=Wk6JqD9u07dDNpp+4KHIasriPhIevOclLYcKs7SM6lZye7k/nR/EC55J2/FScC/RpT
         Rb4CjGImJzfYc5W2gBqz7xAy8RSkOsFUwOJuIptislXplWqUzBtiz/h/wHAOJIaDMB0H
         acp6EC/R1jdsX4KgADdP3jC1XEb/HrOAwIZ5kEBue39tbKr1ZU1x8nLHxYRYuO931EF0
         jD6/zlmSG/CfFgFbJ0Q2n9u29GMp3og/JiGviPQCNtrNhlfQUYvRuaOcvngmDKYC/siV
         AZ53kBfxX9K5NZD609CFmFyMTOFyvJSyuiaCPQdcljmwgPOi3YFFtyHPoB3bTawob1+u
         W5JA==
X-Forwarded-Encrypted: i=1; AJvYcCWCB9hkT079VyLNCHHU9znEPO5DawNHYNV8+NJLQAULE9TdsVof0xnRj1y2l0cSvQx+ZSGEnrUwVQiV/WwxC5s470rPJIhotjuK5djQPHeBTyhJZfeWeYyShjW4X+yNm1rApGYK
X-Gm-Message-State: AOJu0YwM+6fCWyQ6ARkQVJuQc6zHn1N6L5tVKjIg/5Wzem6vBwRvQZnA
	AcEyN6J3RXEMM/fX9qL5sLRzS0LD5p6LwinPdyfTFkw2dn5mgU8wwQzlx2WT
X-Google-Smtp-Source: AGHT+IHea/mcKEQJBsf8M8lvi9cuVZSl0/vHdWVNfuVQJNDNJYOeBBlVBsaa33wxKnH58C+HDbRR6w==
X-Received: by 2002:a19:a408:0:b0:515:ad80:566e with SMTP id q8-20020a19a408000000b00515ad80566emr545396lfc.27.1711669947652;
        Thu, 28 Mar 2024 16:52:27 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id qa31-20020a170907869f00b00a466fccbe96sm1263865ejc.122.2024.03.28.16.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:52:27 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: aleksander.lobakin@intel.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: quic_jjohnson@quicinc.com,
	kvalo@kernel.org,
	leon@kernel.org,
	dennis.dalessandro@cornelisnetworks.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support:Keyword:mediatek)
Subject: [PATCH net-next v2 0/5] allocate dummy device dynamically
Date: Thu, 28 Mar 2024 16:52:00 -0700
Message-ID: <20240328235214.4079063-1-leitao@debian.org>
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


