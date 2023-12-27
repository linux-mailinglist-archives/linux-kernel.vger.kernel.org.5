Return-Path: <linux-kernel+bounces-11927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F48481EDAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F681C2183F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298B286AC;
	Wed, 27 Dec 2023 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiFqZdtq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D074241EC;
	Wed, 27 Dec 2023 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3369339f638so3862394f8f.0;
        Wed, 27 Dec 2023 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703668799; x=1704273599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUn3evj2CX6x7w8VSZe+55waTYsBslnFQ566nixxom4=;
        b=NiFqZdtq3/LSO0+Cv+yP8NbJhS05ZmfqRUHszwSUuUkwaVHLXIaLlGtWEv4g1RWahz
         NGj4aOj58itgEA1/+GaMLuSCYq6CL4oN3ggo/WrxturrAfHIuB0F7MHahoxTHXZm9OUW
         dZm75z4Kj91L2gpB3wjD8tKpz8oR+zW0WxY4CX/QYwQDDrNehtaP8K/O38dzET8b61dU
         vWsTsuE3ePfp4vYStWslaQnSkbFrRC8arSsglUvGHW8hFq4tzhYs6s2akgDmSUBFl5nN
         WszSfNFtQ3p2Ebuz2Ho3DNJKPIAH9Uq8Fcz7iUAJBe5LBuHlkPOyXwTHiU0kIBOfReN/
         cN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668799; x=1704273599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUn3evj2CX6x7w8VSZe+55waTYsBslnFQ566nixxom4=;
        b=vNotsc6PltGvdMQUm5LR78OIvL/K/ZLJnrjy4DFP/wCkXAfBUo61WqDEVmmWWvMRMM
         a+uqXp0tS9/aHwWQG2/CJFITTZuwA+zm9RSHrNQ/MSh8fJgihAOZfzLE6UU4n33zGPF7
         GeGzZI4nED1LHTuN4ienrS0nXHc1b/wqKcl7YOTepeTUxlPidNIqTZzDhB8yVSXKivIF
         CWLLmP1zRHcrcvFMld/boDz/nEkRRLl5AKasKx3vwXxcJi+B2EZKYz2xEwc+3XUd0N8h
         lB8soRaVvXSo733TxEqlfsG6tUKgBAQ0lN/qWWLUOboooIkzv2TIvFxBq+xC4UvSdK6R
         NrZg==
X-Gm-Message-State: AOJu0Yyoy9RmkFaFUCQ4G3ndnAegevyF+VmXzpE7GnfI6bbcf4e4kGsM
	y+5kSIDtbxVUd2ojGDaJqMM=
X-Google-Smtp-Source: AGHT+IENKU/qHdPK4D3hMR9q3fDv5GBpZ61LPrKTNntKcxHCFGYQN0QfI+50jQV0aalQXMjkCZlGWw==
X-Received: by 2002:a05:600c:4ed4:b0:40d:4156:b142 with SMTP id g20-20020a05600c4ed400b0040d4156b142mr3362411wmq.219.1703668799354;
        Wed, 27 Dec 2023 01:19:59 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b0040d5ac00dc6sm4539749wmq.8.2023.12.27.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 01:19:58 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/3] net: phy: at803x: even more generalization
Date: Wed, 27 Dec 2023 10:19:43 +0100
Message-Id: <20231227091946.12937-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is part 3 of at803x required patches to split the PHY driver
in more specific PHY Family driver.

While adding support for a new PHY Family qca807x it was notice lots
of similarities with the qca808x cdt function. Hence this series
is done to make things easier in the future when qca807x PHY will be
submitted.

Christian Marangi (3):
  net: phy: at803x: generalize cdt fault length function
  net: phy: at803x: add support for cdt cross short test for qca808x
  net: phy: at803x: make read_status more generic

 drivers/net/phy/at803x.c | 118 +++++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 28 deletions(-)

-- 
2.40.1


