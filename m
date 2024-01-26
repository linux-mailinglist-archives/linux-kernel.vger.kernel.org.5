Return-Path: <linux-kernel+bounces-40759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E583E573
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F9E1C23358
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD12557A;
	Fri, 26 Jan 2024 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="JBm2bPnR"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4E41BDD6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308298; cv=none; b=XFhJDVkaPFLtDu15yRj0b0OVS/1xcR+4QOnKfcrmWiDNbaJUnMnD5ctf0zNYlyLnDmHt1dvYJPANS/5IQlF6gNEL94wsP0p2Sng2cQthY8/DDola7F/GT7Phj6BTKIJkehvp/oYm58cTevLVyQKAHX2GkeqT+pgmh5QRydapgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308298; c=relaxed/simple;
	bh=5Htmkefxszs9S1elm636bmCy6zXLYX6OrmtB6icqdiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pkc/rFIJHV0T+DqW7HzjaV8w0CbF1EVoKUuORxKDGLnXEW4bvoU+wQwqsdfA71VKTLzV8fnQ4b+66YBuvNheVNwloBsgcZQ0g8AcLIoZDktmZZl7WXCt0n6A3ddxVMRa7+RtxF+MfbV+js9xdehZiGSd/P/V7lS9eEBn/OvW7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=JBm2bPnR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29041136f73so735056a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308296; x=1706913096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3n0LpUSFJ5lo4205sO6CjYx3DDIcvcU0+vDAsWWwIMI=;
        b=JBm2bPnRD5JHzc10lH/Q3jIRoMhj2Zj5vsfvTjdNDZ95/i7668+StMG0w3BHyZXzRX
         4+bpoSrD6AMOMWM/qq1E25UnxHZ+OLWUasBGfwTJR5EQ2s8+FAWF5azttKib/pWm6bfu
         TvP+k8ko37W07+nIVA5HGyvMgg1VkPT/786/kTzAhgi2xvf7KlEfCrkNzVbyxAnkWB9W
         ganXpBNPcHcivvrW/KdT41DwAEGBiRJqz2vTOsXBkvbEe+Yo74Hh/BpooBqfol3T4Mlv
         maRnXQ0zkLb+hRROWiHuuTUqGD/+Wef9GQSIrcDAQrW+SuVfC8tPSHyUlGr5eW8cUjYg
         sYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308296; x=1706913096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3n0LpUSFJ5lo4205sO6CjYx3DDIcvcU0+vDAsWWwIMI=;
        b=SxXcRaeYFK2NU+6WANOjhdct1PDTpKlZPNbXp7Pg9fVg0TaWDAfuka9GaNPSVHvF7E
         EXuNH23UCRHYBiJ9NPlb6VvxPISbspsDVp6E5FzpCVDPDMHAc8yQ/yx1/FwhAm18vl+F
         XdK87GuPf4t0xs3WPSarnt2FR1kfZOqpwTkDNmAfDe3qis9QvJhnLcQFL9QU7MpBQ9nN
         jyOO6vakVCuX1a7dizvCPlbRrpM/OL4K5n64vs31zC2PY9sXdXfOhY1DUCxJBrmECF7w
         3UR9XQZ+oYx7uDln2mTGETp7Vayd0hOHVpLgOqzQ61pBT++xhAc6N9bRikltaH3kDORj
         ZjbQ==
X-Gm-Message-State: AOJu0YzZJ5ZFKZeatUcftLMsf1YHIoPPq5remyqfQDVfrLgy6i6dUHc8
	G/6BbPkaDI5rPj5tLwij42eK6RR9twTcu9gf0Htpz7HIkOSjMkwUNzMTKDY8jiA=
X-Google-Smtp-Source: AGHT+IHCsOMgyPUvEkLCbOFsI4A6F5kXRbMkMPZNZexE2B7YNB+V3LEbyxfrM9tX0VuhhH8SNt8p3g==
X-Received: by 2002:a17:90a:bf13:b0:290:6b49:e686 with SMTP id c19-20020a17090abf1300b002906b49e686mr522859pjs.88.1706308296160;
        Fri, 26 Jan 2024 14:31:36 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:35 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 00/18] Staging: rtl8192e: 18 Additional checkpatch fixes for rtllib_softmac.c  
Date: Fri, 26 Jan 2024 14:30:48 -0800
Message-Id: <20240126223106.986093-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Version 2 

Another checkpatch fix series to be applied after the series titled:
'checkpatch fixes for rtllib_softmac.c' submitted by me, to the list, 
on 1/5/2024

Thank you in advance to all reviewers
regards,
Tree

Changes since v1:                                                               
- On Patches 2, 5, 6, 17                                                        
Update commit message, to fix max chars per line.                               
                                                                                
- On Patch 13                                                                   
Fixed spelling mistake in Subject line

Tree Davies (18):
  Staging: rtl8192e: Rename variable FirstIe_InScan
  Staging: rtl8192e: Rename function rtllib_rx_ADDBARsp()
  Staging: rtl8192e: Rename variable LPSAwakeIntvl_tmp
  Staging: rtl8192e: Rename variable LPSDelayCnt
  Staging: rtl8192e: Rename function pointer SetHwRegHandler()
  Staging: rtl8192e: Rename function MgntQuery_TxRateExcludeCCKRates()
  Staging: rtl8192e: Rename variable PeerHTCapBuf
  Staging: rtl8192e: Rename variable PeerHTInfoBuf
  Staging: rtl8192e: Rename variable LPSAwakeIntvl
  Staging: rtl8192e: Rename variable SelfHTCap
  Staging: rtl8192e: Fix paren alignment for
    rtllib_disable_net_monitor_mode()
  Staging: rtl8192e: Fixup if statement broken across multiple lines.
  Staging: rtl8192e: Remove unecessary blank line
  Staging: rtl8192e: Fix if statement alignment with open parenthesis
  Staging: rtl8192e: Rename variable Octet
  Staging: rtl8192e: Rename variable LpsIdleCount
  Staging: rtl8192e: Rename variable NumRecvBcnInPeriod
  Staging: rtl8192e: Rename variable bForcedBgMode

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 18 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  6 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  4 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |  2 +-
 drivers/staging/rtl8192e/rtl819x_HT.h         |  6 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 32 +++----
 drivers/staging/rtl8192e/rtl819x_Qos.h        |  2 +-
 drivers/staging/rtl8192e/rtllib.h             | 18 ++--
 drivers/staging/rtl8192e/rtllib_rx.c          |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 96 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |  8 +-
 14 files changed, 100 insertions(+), 104 deletions(-)

-- 
2.39.2


