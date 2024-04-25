Return-Path: <linux-kernel+bounces-159319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EE08B2D13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176581F22202
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0AB156226;
	Thu, 25 Apr 2024 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjwsugsJ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428DF5A0EA;
	Thu, 25 Apr 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084063; cv=none; b=gJ38dBDjA605wDvySVKXiUL1OxJljKW+MQsKwsFb8M+Rofm2fXLVVmTB8WsUuFbNG9IH5xArN39QDK4CNs+0wa6h6oCRZAA/Nb+9HWLSeb52ZdTDirH6rQnz7UOMaQo9fKLqJHppNvZNHsV+VjLEMQP0vAfw1oQevgRTcW8EHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084063; c=relaxed/simple;
	bh=IwFKVp51y+TUpMLfYya9PDJapUI3cFUgd4bBC2RsKiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LrnWWWvZIGNfhMwMPlTS6ItSDvY5Fr7jQLSrpZ+o5ussUyudXXhnrRZNM+FFS+YaYm9IofFwi6jfWGbi9AYQu2uAdDeMaDx2TvHfDLsttCMgAHoEL1vWXRUCp2pF4/q08uAxR02zafOzGTpkvlqxay48O6xFwIeVq7/jZVWALFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjwsugsJ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-437274f3bd4so14855661cf.1;
        Thu, 25 Apr 2024 15:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714084060; x=1714688860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJLpOCnrsDKmQiDQ+KZC+Bl55R3cUdGM2Qtj2bCOu1g=;
        b=OjwsugsJJO2eM3SdNcVF8GZNeR13d+PcxfHX84zUwiqrX4emji1DNmlDrklVTHeiqe
         aAH8sAk18JdaVChPMgvREgLkzfu+OdHE9x2t2Is55VV5laV1xLUgy/QzJAUVe6lBRLXw
         oznDu7w2fxeGcfM4y7R4Uck5yLR7Pb69TQ5+V0ZDuJxJwDEPT/4u/PBj2MuXpRXO1CHX
         myB8S6PC+KyyruCFREueQF0oOn/wXDHEhM148tTcHWaKTiq+H7rL8iONtAB4I5/5p+bJ
         x7LLaXqYCTpSQEhqLOaHqFYekxY5I1ZRRj8yodHlG8XPAIGlh+DhyfeF0uoVJ6bkn84t
         Q1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084060; x=1714688860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJLpOCnrsDKmQiDQ+KZC+Bl55R3cUdGM2Qtj2bCOu1g=;
        b=uYEoJIvjzw83phuFafnoVyQ31EkuzboXi1WWvtwGlHPOq1ZsFZKO/bUN6kYi1J7SBZ
         5vX3BNhXJ+XBu9PVeL14IsJoa3PTfQuLAOtfgHSln+krCZedmbqnC9LiD9OQKaZsc6rS
         hZZE4mP8yV+N4LJYuIhwkKc4hlZ0ROH9WqZdQ2693Pam5I+TBGAm6gNAryFyVAYzl+Zr
         hNi7zF1v9Bx7QlXNUNJ1r959lPnkQMgK+1awQGDRPdqed2XfHp4z+Au/vOlfpQhFZnv3
         2gBniygIZ/yuGfDomSEVZocGXgcHv+cE2jmEmbkxX0Ab5jN041SN8GmHybOMyl78+xVw
         Rfzg==
X-Forwarded-Encrypted: i=1; AJvYcCUSb1zGunh30qUCp1wh+oVtLfw1oIGjXjBBFPjYcEcgYFlwI7p7VtuLatb4tEXwQPX7OCuheHCLTWum+SMiqT2UN9pXIWYswz41p7qarenWSuekDvDFnUZ1IX3EK8uzZ21k4D/A
X-Gm-Message-State: AOJu0YzwO9d1BYHrsBxYmR4ckDRXj32s5Fu+KgQGG2IdD8oOdWqgLkfi
	Z40dyid8T44XF74fW1U044GXabzEc4oTpp50IWvvqkwCPW7nSlSc
X-Google-Smtp-Source: AGHT+IHQOVaTHMiWQtqLO7NE3lwjkM+c7BD3+5SX0hyWw0XkVeSxYlxE3HpHjxmaPtk0uCMbRcw/XQ==
X-Received: by 2002:ac8:5acb:0:b0:43a:712f:315 with SMTP id d11-20020ac85acb000000b0043a712f0315mr765172qtd.33.1714084060084;
        Thu, 25 Apr 2024 15:27:40 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t4-20020a05622a180400b004371724f711sm7341928qtc.80.2024.04.25.15.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:27:39 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net v2 0/3] net: bcmgenet: protect contended accesses
Date: Thu, 25 Apr 2024 15:27:18 -0700
Message-Id: <20240425222721.2148899-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some registers may be modified by parallel execution contexts and
require protections to prevent corruption.

A review of the driver revealed the need for these additional
protections.

Doug Berger (3):
  net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
  net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
  net: bcmgenet: synchronize UMAC_CMD access

 drivers/net/ethernet/broadcom/genet/bcmgenet.c   | 16 ++++++++++++++--
 drivers/net/ethernet/broadcom/genet/bcmgenet.h   |  4 +++-
 .../net/ethernet/broadcom/genet/bcmgenet_wol.c   |  8 +++++++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c     |  6 +++++-
 4 files changed, 29 insertions(+), 5 deletions(-)

-- 
Changes in v2:
  Corrected [PATCH] to [PATCH net] and email address of
  netdev@vger.kernel.org

2.34.1


