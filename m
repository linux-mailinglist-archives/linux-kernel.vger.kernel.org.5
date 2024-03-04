Return-Path: <linux-kernel+bounces-90067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B4686F9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01761F211E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C7BE5A;
	Mon,  4 Mar 2024 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="ssBB4zbd"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C5BA27
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531633; cv=none; b=jSkPj3al+JQNijyhwPDkv8mP6Ku2prpOZYbC41CTocxIucpGm32RzI0fnZuklZn2Qij5WQhMvuW9iwOnINqBkwxb3mnuM0AZxnrLrgh/uU5Bzte2CfdnhGuZSR8ab/ckPAGT23awoF227EZ8qV+MzjOnV/HjrTt9tP/QpDMvY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531633; c=relaxed/simple;
	bh=h+kBNKpg6K7RtepCFQNzRMfkyN2SbsIJc7s8qriTZoc=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=u1ukch0kvNzNLIpQH0uaEut0pxe67A8mSh/hM8ekLq6KhugFCtyjdgr16ybT7MM+Lpk5xMVGdzMEzZp34pOIDgt2Cuxwk0fj7zUl8xdgk55cKJ+oEvix2aRi3Jeki5wsUzIGARh4jmyl/1yxBj3TYviSuOqxdGT1+hseqXLpe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in; spf=pass smtp.mailfrom=iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=ssBB4zbd; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 11845104D0DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:23:44 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 11845104D0DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1709531624; bh=h+kBNKpg6K7RtepCFQNzRMfkyN2SbsIJc7s8qriTZoc=;
	h=Date:From:To:Cc:Subject:From;
	b=ssBB4zbd4AbkulS5HsblTByt9Meyp/UyNfLpBQ9qZea/1sxd39M4RLv5fVK8NaD+A
	 xEuHk2QQabRwJxWp+G2Jp++N3wyvzXPyYggNwv9VJQIFALjc9TRdnkOr78UY7cDBJH
	 rqrJ5N2SjBmNzugKPveH78RxgX17n+ru3iSsmgNU=
Received: (qmail 18002 invoked by uid 510); 4 Mar 2024 11:23:44 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <210100011@iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.489452 secs; 04 Mar 2024 11:23:44 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: 210100011@iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 4 Mar 2024 11:23:40 +0530
Received: from wm1.iitb.ac.in (wm1.iitb.ac.in [10.200.17.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id 53C91341636;
	Mon,  4 Mar 2024 11:23:40 +0530 (IST)
Received: from webmail-sso.iitb.ac.in (localhost [IPv6:::1])
	by wm1.iitb.ac.in (Postfix) with ESMTP id 5115C608E11;
	Mon,  4 Mar 2024 11:23:40 +0530 (IST)
Received: from [10.9.9.42]
 by webmail.iitb.ac.in
 with HTTP (HTTP/1.1 POST); Mon, 04 Mar 2024 11:23:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Mar 2024 11:23:40 +0530
From: Aman Sharma <210100011@iitb.ac.in>
To: Gregkh <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: pi433: Updated bitrate range from datasheet
Message-ID: <91454ef9b4a12f01e13d69b675d81aff@iitb.ac.in>
X-Sender: 210100011@iitb.ac.in
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Updated bitrate range for FSK and OOK modulation from the RFM69 
Datasheet.
The values are mentioned in Section 2.3.2 of the datasheet.

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

