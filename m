Return-Path: <linux-kernel+bounces-24590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD482BE93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF1D1F23A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010215EE96;
	Fri, 12 Jan 2024 10:26:33 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51225EE89;
	Fri, 12 Jan 2024 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TBHf22fFpz1FJBC;
	Fri, 12 Jan 2024 18:22:18 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id E86F31400DA;
	Fri, 12 Jan 2024 18:26:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 18:26:26 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/2] crypto: hisilicon/qm - add debugfs qm_state for hisilicon driver
Date: Fri, 12 Jan 2024 18:25:44 +0800
Message-ID: <20240112102546.2213-1-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Read some device register values for error analysis.
Patch #1, the debug file 'qm_state' is added to obtain
the current device state.
Patch #2, read device register value before resetting
to help analyze the cause of the device exception.

Weili Qian (2):
  crypto: hisilicon/qm - support get device state
  crypto: hisilicon/qm - dump important registers values before
    resetting

 Documentation/ABI/testing/debugfs-hisi-hpre |  7 +++
 Documentation/ABI/testing/debugfs-hisi-sec  |  7 +++
 Documentation/ABI/testing/debugfs-hisi-zip  |  7 +++
 drivers/crypto/hisilicon/debugfs.c          | 53 +++++++++++++++++++++
 4 files changed, 74 insertions(+)

-- 
2.33.0


