Return-Path: <linux-kernel+bounces-90153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E2E86FB1A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E44E0B20E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82C016429;
	Mon,  4 Mar 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="gRGHhpMn"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D353A6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538590; cv=none; b=Tbh9+HZFJffP6fwIpoG3sMGzHx0tIpicN/+7SPq/5PRoU7flaMQ6f901DWj4OPzx9s1QKHG7gYQAIJkXSkg7Se0G/6Ad7VLOpOCGbgzjlM9lhxc9JvH7SkoT7IPQ19hnVRY0cnDr3lkflWhQu3csFzTlp+Vifa1bkOQzLFEh95s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538590; c=relaxed/simple;
	bh=9QaEAudaCAaeY1zxPULS8+iVrKHghlw+/PmiL+Ujdm4=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=glEvLpbw6nkbawxN6DDZO2B/3Z/w67xwlC6blroxcN1RWgs3UV/5E8IqFjvCWcUhNI9G9pCThOfzjAtsrmuLaNNO5zVvmrlsKaP+o8fbg6YF3H6CZ84Ju0n3d/UwFjIpcSiULjx3iDGozuN7Fh+JEv1QIwRrvVi8KMteLyXFQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in; spf=pass smtp.mailfrom=iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=gRGHhpMn; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id EE9A2104D0DB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:19:38 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in EE9A2104D0DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1709538578; bh=9QaEAudaCAaeY1zxPULS8+iVrKHghlw+/PmiL+Ujdm4=;
	h=Date:From:To:Cc:Subject:From;
	b=gRGHhpMnTGWD8radH2caNvLjdh7VNEYzeyXWgs5ImISZkJVO2neDx9yy1XI9Si2VA
	 NhVwzD87oKkBYwKxC9YSowsII7rOCLpAq6tok6ai85KUltviYYyjNN2fjAHw+nCO44
	 6J7G/7zdtOFEd4oW1hZY6BbYA73qXPlLjHJZd2rQ=
Received: (qmail 9127 invoked by uid 510); 4 Mar 2024 13:19:38 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <210100011@iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.273739 secs; 04 Mar 2024 13:19:38 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: 210100011@iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 4 Mar 2024 13:19:36 +0530
Received: from wm1.iitb.ac.in (wm1.iitb.ac.in [10.200.17.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 730BC360035;
	Mon,  4 Mar 2024 13:19:36 +0530 (IST)
Received: from webmail-sso.iitb.ac.in (localhost [IPv6:::1])
	by wm1.iitb.ac.in (Postfix) with ESMTP id 709C8608E11;
	Mon,  4 Mar 2024 13:19:36 +0530 (IST)
Received: from [10.9.9.42]
 by webmail.iitb.ac.in
 with HTTP (HTTP/1.1 POST); Mon, 04 Mar 2024 13:19:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Mar 2024 13:19:36 +0530
From: Aman Sharma <210100011@iitb.ac.in>
To: Gregkh <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <0eaf24f26b1f7e89350b54a65c7f47a6@iitb.ac.in>
X-Sender: 210100011@iitb.ac.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Updated bitrate range for FSK and OOK modulation from the RFM69 
Datasheet.
The values are mentioned in Section 2.3.2 of the datasheet.

Signed-off-by: Aman Sharma<amansharma6122002@gmail.com>
---
  V1->V2: Added explanation about values in commit msg
  V2->V3: Added version comments after changelog

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

