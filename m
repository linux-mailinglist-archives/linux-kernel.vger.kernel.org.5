Return-Path: <linux-kernel+bounces-161607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F78B4EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A19C1C2042E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8286125CD;
	Sun, 28 Apr 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="UBXkEF1V"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0EC8E0
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345273; cv=none; b=DazWYdQ3OX2JBGLZtkCb+baMAOodwov6SdoQVCyoZuI4vw5BF5CxZ5+TXovNObrK8W7JCw7WyFi/R8M4MvhgeEYQR/pzWDv9CcSYHsvUaqmyFlIdA2p5zrNqk2ey7dwu37s/nah0k9XfonWBIdOERLiOFuQhjCBxNpJftHxNmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345273; c=relaxed/simple;
	bh=zFLLDXev3+4EQMdTEsmOQ4pu98STBZZQq72+GXCKkUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fi+u4Wg6wbEtZXSyHHkjGW78P1vB02xb1uZp/9iKm2sGS6AOP9dpka3BXrrxwNBnfL1BuxriRFPiGfIKqKVOhC7rO5O1WBVy/Kg9uuP2DGRw9yfohdViRhQ5Tz+yxONJo73l6tS1eBi5WYv3Ju097OQE352OVnbxDLYa9AvVhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=UBXkEF1V; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ab791bce6fso2655964a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1714345270; x=1714950070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=resl27Nx3Ke/QTsIv17VspqiZQnAqsVTHg2kuu+h1f8=;
        b=UBXkEF1VXAkakypIrg4GcLqrdwEFjqioHa2BW6JUEuoS6GrQxZ6ZK74QHe+CufG0jn
         4/SdwZmtNKKoiQdwGed8gVVglozCqR6dBsLj1hIr+GtjrzDxZuHrL/BaXIXddtmkgHWs
         a/HOHFNE2kLoVCTR84aDcr0i8iIol7YaOFki9TWf5HwYJy64MgEW0uanfkeJYZjMelxx
         py/8Fr2w1JmiB288pcIOM27yu2RLi2oOIwNupPZKTb8ZA5p6zmOje0nlFJsruMrnOiyO
         NkW9/tgMEZvX7yr6D6s91FWXrEq+qH4wEhlW67P/KZ6sivqnudj1O82p2gdQSSmECk6X
         gvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714345270; x=1714950070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=resl27Nx3Ke/QTsIv17VspqiZQnAqsVTHg2kuu+h1f8=;
        b=MN9toQ4XOZDRyV5ie2hroBoQP9uyl3kpI6si2mT+y8NW7hz7AP46I3ISPLYf6zTNp1
         czHJNk1YESZ4UaBgxO+4SDk4Mq/Ts6k4O26E/hIhx0ozf9j1N0s/wnKskCj8zymBE0Yi
         T+o5uSr3DhAYcGx4uvqaQITS3RFJiy6NcaztTIjnZeS0slHE0UwO3CPF3lu28uSBq3J2
         NnAR9/zCroq/b+Iqd/IlxigeEKOFak3VoWpOpTuu6V0jraNF6gPZK5wzewPNRCaIr3nt
         wq8Hzij/xBxnvoWeVmI1selP9eXnuCFuCyz0QtLdHGIR9VnQMC7ATZhdC0IrW/U9kTLJ
         azXg==
X-Forwarded-Encrypted: i=1; AJvYcCVBYX3OeGN4Gt7eLJB4pC/Kw+B2WZSPjuZ4cB/K6dzz/2aGMXZ6+IvUMUpUkpY6MwvoWODHh44w7FTLEm+WZdankceDCe+b7nBhNKbX
X-Gm-Message-State: AOJu0YyMMM1vgK404rvLR7LdfZOB9rnpXXqhlpeme+bZXwBJpLRFFU8x
	aIARhLIEcKma6Q/hNQg/AnecGYvJ/Ob4uCNLO+WzvnHkwaGmEvdq+v4A/0+QXUU=
X-Google-Smtp-Source: AGHT+IFf0qQFHXWSQfrLGkHRc3x6u/r8d4OHeAGrYhIL/oHokRuNz3VnwyX+JGL+WSN4wJsGDB5TaQ==
X-Received: by 2002:a17:90a:b8f:b0:2a2:e56a:ca8f with SMTP id 15-20020a17090a0b8f00b002a2e56aca8fmr8784233pjr.42.1714345269654;
        Sun, 28 Apr 2024 16:01:09 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm17860864pjq.2.2024.04.28.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 16:01:09 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/18] Staging: rtl8192e: Rename variables in rtl819x_HTProc.c 
Date: Sun, 28 Apr 2024 16:00:48 -0700
Message-Id: <20240428230106.6548-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series renames 18 variables found in rtl819x_HTProc.c
Thank you in advance to reviewers.
~Tree

Tree Davies (18):
  Staging: rtl8192e: Rename variable CurSTAExtChnlOffset
  Staging: rtl8192e: Rename variable CurrentAMPDUFactor
  Staging: rtl8192e: Rename variable OptMode
  Staging: rtl8192e: Rename variable LSigTxopProtect
  Staging: rtl8192e: Rename variable ChlWidth
  Staging: rtl8192e: Rename variable AdvCoding
  Staging: rtl8192e: Rename variable MimoPwrSave
  Staging: rtl8192e: Rename variable ShortGI40Mhz
  Staging: rtl8192e: Rename variable ShortGI20Mhz
  Staging: rtl8192e: Rename variable GreenField
  Staging: rtl8192e: Rename variable TxSTBC
  Staging: rtl8192e: Rename variable RxSTBC
  Staging: rtl8192e: Rename variable DelayBA
  Staging: rtl8192e: Rename variable MaxAMSDUSize
  Staging: rtl8192e: Rename variable MaxRxAMPDUFactor
  Staging: rtl8192e: Rename variable MPDUDensity
  Staging: rtl8192e: Rename variable ExtHTCapInfo
  Staging: rtl8192e: Rename variable DssCCk

 drivers/staging/rtl8192e/rtl819x_HT.h        | 36 ++++-----
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 84 ++++++++++----------
 drivers/staging/rtl8192e/rtllib_rx.c         |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         |  2 +-
 drivers/staging/rtl8192e/rtllib_wx.c         |  8 +-
 6 files changed, 67 insertions(+), 67 deletions(-)

-- 
2.30.2


