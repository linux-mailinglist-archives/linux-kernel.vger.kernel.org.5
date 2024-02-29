Return-Path: <linux-kernel+bounces-86056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36E86BF11
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5381F224FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31737141;
	Thu, 29 Feb 2024 02:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="KTPrSuAB"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61DA26AEA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174615; cv=none; b=Uis/TBRnfKv7Ka4HFV21heR0RjLnONgcyC2mrxU7hCIBufFZeqzKLk1RQL089TtYzdn3mmHK25GNspQ5FR/AIBr9kQhtZ8WYRIG3it0rv5Nxd5HrSV+Q3pJa8iV64TvU3kKDICbCUyCqb7fkLzgy5I7/iKrPxGnROvoTqJO55Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174615; c=relaxed/simple;
	bh=7/cR9VrrZ75MJ0y1I9vqnz7EMFlDVEgY9zQSNI9n5xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mM4UF9umsNbb8x7T25kwEF+V/KvZOXZOO3RgXXklOv8kBdcruLhKXaI2t2aGm8ELAUN9JoKz7LvkrgyxLasw9LrPXp/GGMstiFbe+oKrWgmt3I1xQovCcRTc6ZjZ7qGcak5rwmd09xHrhN58xfCCL8SO+nHo2x9VGuvHAU/iMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=KTPrSuAB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3652762edcfso2306365ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1709174612; x=1709779412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHu2J18/kfwLvYeLsu+wqPWa0ETUgopQTH+/Wz4pq6M=;
        b=KTPrSuABAvvRUBF/qepu+9W+cAKBomJcRDtvUIHjyNa917fT3SweYL2R71OJS7NBtO
         KAnjXhczqDT1sxmx5baz22piDUM0qa/5OsjuX0wQ/K26js0fOOld/yi2wu8O+khNDSsD
         aqK6raD4MmMYoIPZBRNkOET+PNUO+BhBuIz30T7tIhMuIJseRKHsjfhJfWnG/tzKmzbw
         aO0yzVRM6pgzvPR70BAZGS3dWSlVgeruNPmEALrWwJAndMarkBCsDZr97ieksRNkqLHT
         yStxMcC6+udeuFkluDYWbWMfOkqjVqGH8Oggq1/3RwDfI7wLEAWg7vwzdeqK3Q8stEd1
         i2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709174612; x=1709779412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHu2J18/kfwLvYeLsu+wqPWa0ETUgopQTH+/Wz4pq6M=;
        b=Ut3l5PC0Db0LzykrLP+p8dsrx1ZtsKV2eAHkF/QF7lBGATBFhnDvsuXEJs+VQppTrw
         +/h96hKK6T81LcRFuoeio3GnDbk7pDw7L7CalJZYtl+anKzx/usjDAWoQd7WlJiY23ne
         4KcjXY0UStKcspEXWDWkP4DWI1ttJXYi7PD3xsol9JFu6D/6H3M/qOUjdfRo+FtvOYX1
         k6Jlq51TX4ttr06JXf2F/PRvpz5GeCfnmz0PSg+FvInZ1CyNFjBuajC+2E/JHtQOwhkS
         zDw//4bUbaDbnnalooXyUpTW4vOEsIF8JZZ2HRK7wwTXL1okGYH7e4STjuyh4ObE7J8U
         GXAg==
X-Forwarded-Encrypted: i=1; AJvYcCXOacc9bjWxor5UBFcVqRPYSkyt4zOH0SELd1l/sIbxMyOLgkOn11LYEM5g0SPDwHqzrpMMxHeLLevxyfHunjijbHV0QP+8gT6xcaXT
X-Gm-Message-State: AOJu0YzoJtXOX7XvPT0nCvclpYH5+BDCD2Why4iB5mFpBP9TaWJJAVBR
	K08rQ1AcCT/45/04Dcr/W57ZMGYm1rH07be7ibJEdeJLaRufCXtBUBlm67OT/Z1neznvB8xf0e9
	3
X-Google-Smtp-Source: AGHT+IHxml76LrK1ytaduUzOOE9pLYz+ECrfmVRkOs8zfvnVPPu5R2gcYriLGEe24YnSsVViTRt25Q==
X-Received: by 2002:a05:6e02:2148:b0:365:25c0:c82d with SMTP id d8-20020a056e02214800b0036525c0c82dmr1272926ilv.28.1709174611731;
        Wed, 28 Feb 2024 18:43:31 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id u23-20020aa78497000000b006e5092fb3efsm141504pfn.159.2024.02.28.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 18:43:31 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 0/8] Staging: rtl8192e: Fix Checkpatch warnings in rtl819x_BAProc.c
Date: Wed, 28 Feb 2024 18:43:17 -0800
Message-Id: <20240229024325.453374-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the remaining checkpatch issues in rtl819x_BAProc.c
These patches are to be applied after patch-series: '[PATCH v2 00/20]
Staging: rtl8192e: Fix checkpatch warning for rtllib_softmac.c ''
Thank you to all reviewers                                                      
~ Tree Davies  

v2: Change commit message in patches 7 and 8

Tree Davies (8):
  Staging: rtl8192e: Fix 5 chckpatch alignment warnings in
    rtl819x_BAProc.c
  Staging: rtl8192e: Rename variable TxRxSelect
  Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
  Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
  Staging: rtl8192e: Rename goto OnADDBAReq_Fail
  Staging: rtl8192e: Rename goto OnADDBARsp_Reject
  Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 66 ++++++++++----------
 drivers/staging/rtl8192e/rtl819x_HTProc.c    |  8 +--
 drivers/staging/rtl8192e/rtl819x_TSProc.c    | 24 +++----
 drivers/staging/rtl8192e/rtllib.h            | 10 +--
 drivers/staging/rtl8192e/rtllib_rx.c         |  4 +-
 7 files changed, 58 insertions(+), 58 deletions(-)

-- 
2.39.2


