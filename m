Return-Path: <linux-kernel+bounces-89906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA2086F720
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD36B2112E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770C7A151;
	Sun,  3 Mar 2024 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="iKpm+6L0"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B5C1CA8F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709500079; cv=none; b=bVZAddS+YloTHOtGPCpqGAlSwkKzZFnc3JOzLo6B40cfpJ+9LN6cvY8D/3LszmcEj+LVYpAlAiI0gBSLJ/PpvBw/6/VV0HzkhHznJfmkYysFjDIlsUtejoM+somEFeFMfataJhQjxm6R5Z+ucno+JmwnSijhGay0cnyucHzHrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709500079; c=relaxed/simple;
	bh=cKZF4odXE/it1RO6myqlNO63lhy9YJ56gjTn3CJcxsg=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=ZIZ+SUi3E+METMieIX7CKme/MxeJhy6RTtKT8wHdB5od/NsfWlHgl8Hsqqo4svWHJ3Y7R2IN9t6XFhx9cdBCsm83xcvQmjoD2GETsxFVk/FsSkqflzC2xVmJJrv4HgI3PnIz9OLRnSfrBS3Q2xUGaZz+gyY3fozoTMZnQ++qs5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in; spf=pass smtp.mailfrom=iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=iKpm+6L0; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 7EFB8101CA97
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:28:05 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 7EFB8101CA97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1709499485; bh=cKZF4odXE/it1RO6myqlNO63lhy9YJ56gjTn3CJcxsg=;
	h=Date:From:To:Cc:Subject:From;
	b=iKpm+6L0Pc/00Or8X8OssRsxjQMhwYDrKz9bODytEVcXCnbzyt9G3u0q6xNDhdgW2
	 W6LzUUdcHPyOQMck9zdE13H8weaVvST9hM7LbwX0LuMeDfa4Vqqo59Ej4X1ujyTL59
	 io9vXgCXQN0aGdHnnIUb3qQ8udXfX27VCEIvzsi4=
Received: (qmail 10329 invoked by uid 510); 4 Mar 2024 02:28:05 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <210100011@iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.173844 secs; 04 Mar 2024 02:28:05 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: 210100011@iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 4 Mar 2024 02:28:03 +0530
Received: from wm1.iitb.ac.in (wm1.iitb.ac.in [10.200.17.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 0F460360072;
	Mon,  4 Mar 2024 02:28:03 +0530 (IST)
Received: from webmail-sso.iitb.ac.in (localhost [IPv6:::1])
	by wm1.iitb.ac.in (Postfix) with ESMTP id 0B2DC608E11;
	Mon,  4 Mar 2024 02:28:03 +0530 (IST)
Received: from [10.9.9.42]
 by webmail.iitb.ac.in
 with HTTP (HTTP/1.1 POST); Mon, 04 Mar 2024 02:28:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Mar 2024 02:28:02 +0530
From: Aman Sharma <210100011@iitb.ac.in>
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <ddbd681a7504ae8b8fd4dc69270e804d@iitb.ac.in>
X-Sender: 210100011@iitb.ac.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

 From a0528708b209739f0d566401bdd428e215abf366 Mon Sep 17 00:00:00 2001
 From: Aman Sharma <amansharma612002@gmail.com>
Date: Mon, 4 Mar 2024 00:44:06 +0530
Subject: [PATCH] Staging: pi433: Updated bitrate range from datasheet

Updated bitrate range for FSK and OOK modulation from datasheet.

Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
---
  drivers/staging/pi433/Documentation/pi433.txt | 6 ++++--
  drivers/staging/pi433/TODO                    | 1 -
  2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/Documentation/pi433.txt 
b/drivers/staging/pi433/Documentation/pi433.txt
index 4a0d34b4ad37..9ce7282ef6f8 100644
--- a/drivers/staging/pi433/Documentation/pi433.txt
+++ b/drivers/staging/pi433/Documentation/pi433.txt
@@ -78,7 +78,8 @@ rf params:
  		Allowed values: 433050000...434790000
  	bit_rate
  		bit rate used for transmission.
-		Allowed values: #####
+		Allowed values (For FSK): 1200...320000
+		Allowed values (For OOK): 1200...32768
  	dev_frequency
  		frequency deviation in case of FSK.
  		Allowed values: 600...500000
@@ -169,7 +170,8 @@ rf params:
  		Allowed values: 433050000...434790000
  	bit_rate
  		bit rate used for transmission.
-		Allowed values: #####
+		Allowed values (For FSK): 1200...320000
+		Allowed values (For OOK): 1200...32768
  	dev_frequency
  		frequency deviation in case of FSK.
  		Allowed values: 600...500000
diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index 63a40bfcc67e..61ed3a1578bc 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -2,4 +2,3 @@
  * still TODOs, annotated in the code
  * currently the code introduces new IOCTLs. I'm afraid this is a bad 
idea.
    -> Replace this with another interface, hints are welcome!
-* Some missing data (marked with ###) needs to be added in the 
documentation
-- 
2.34.1

