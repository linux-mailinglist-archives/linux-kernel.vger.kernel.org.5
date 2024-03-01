Return-Path: <linux-kernel+bounces-88027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B55886DC55
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EFD28C414
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB76996D;
	Fri,  1 Mar 2024 07:48:58 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A3224C9;
	Fri,  1 Mar 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279338; cv=none; b=ItdkEkWbAY6XwG7/ge1MvvNwjrYii1cBpHQgyi+yZd/Zn2oHJEplbTuEHKwm/0yP6H7XMdgVCkbkIJMQ6xxJfD8vHj7Yng06YYT2MOKdPbGXXdap01PNrhbMKgx4DmLim11nf7nS4s09nRxI9JRQ5Iiz9H4WdedXiirsXKI/K3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279338; c=relaxed/simple;
	bh=E/ihWaWaF4K9BLjfH+VCqKUQ3nWg1zKktoSPxclj7M0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Whzk8r4usykXguk9Hnq5bCG+M14Xre4Le7IeC4mgUBMfrm36LCHrWdM8TQ5M7HGgj+0vT7Z95ZHKVszi44EJ289H7BQusCynFDrhZzEJGvUsSZsaibXG5fuJ+iRKP++zoqMxzfJl4kkyQrynvRoG+L/EMd34THqkfbe6mb7zids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 1 Mar
 2024 10:48:41 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Sergey Shtylyov
	<s.shtylyov@omp.ru>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 0/2] Bluetooth: mgmt: remove useless NULL checks
Date: Fri, 1 Mar 2024 07:48:22 +0000
Message-ID: <20240301074824.1259409-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 03/01/2024 07:24:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183879 [Mar 01 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;r.smirnovsmtp.omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/01/2024 07:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 3/1/2024 3:59:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Svace reports NULL check after dereference in
mgmt_set_connectable_complete() and add_ext_adv_params_complete().
The following patches remove these checks.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Roman Smirnov (2):
  Bluetooth: mgmt: remove useless NULL checks in
    mgmt_set_connectable_complete()
  Bluetooth: mgmt: remove useless NULL checks in
    add_ext_adv_params_complete()

 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.34.1

