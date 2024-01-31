Return-Path: <linux-kernel+bounces-46877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968058445B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE22946B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0DF1339B4;
	Wed, 31 Jan 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="eISNC/Lz"
Received: from sender4-of-o50.zoho.com (sender4-of-o50.zoho.com [136.143.188.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91112CDAB;
	Wed, 31 Jan 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720949; cv=pass; b=T0O8fjpK/9w6CYh2+leekEdr+lFNg0HI3jjgPw0wgCCTAUaIZN9/emNqKd31fiMEzwPj6DUsrK6nojWtSwRRSCQhhUL9b3Z3nGmsz/AeXZ5LbJllmDZGRasg1maWKKrHFwW6GvFEsEvjU4h6NWcEp71vcrXSOcQ9HU8J0/RwY7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720949; c=relaxed/simple;
	bh=trM7msgFSArPjPrDsbJnOiFND6qGuUZ3YFCmeWhK78U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xw1XzEUtJqlWGefjRadPw8SQTFihQY1IMzpP7+RUhHLPs15uyVzffBqb1adwaYQW5vxaVGqgar2WnHn1RMsomeZWIq5wdV8k2L/OIvU8Zb8HqIshtXtraIDEYD/3VsuKADsdq8qIbcMKV5wgI9Cckz6V054LH7JeKRCDnP/XSHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=eISNC/Lz; arc=pass smtp.client-ip=136.143.188.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
Delivered-To: dpsmith@apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1706720920; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PNN1/Biy48y5Kta70ks1MYvS51v2IjkqawXWdzI++/D9OtAgn/Ni3UrU4XXUpSYL5EgaDpwGI+G6ASISPtunVQXy2RE8z2jYD44qoPU10QsL8GmVsyiqvtvY94Js8qXOgcRr9MZ2fPwNxC7uTHjgwi0eW9fQ31ci2vK+JWkPrJs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1706720920; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oisGpTWFjqHAtfqypalRiEg2UzjE5idBdPhb3LBh9zU=; 
	b=m8r5EFVqBaR9jLnuARSgDyHu3exFMmVu40uPCctDAO5NgzFJUqPLOMN6Mr+52hjIJP/3a5lA79N88l8Enkop9RV+SIvXWJP5CH8OEbqoGhvHMYxevHwpfICzOYbNj3Eoa0YFNHppQR/AwBeEddxZeY6vFX2f42ksmvYf7c3hzwE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1706720920;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=oisGpTWFjqHAtfqypalRiEg2UzjE5idBdPhb3LBh9zU=;
	b=eISNC/LzWk1CAU88clvqoeCIBlQfQmDJpqjp39np/pyvPIV10RakmWMjssapiZhe
	mN0j9grEHlVjZo9s+1LsyemfPet8SnkP+pjVlww43PxseUbqbFnFjpb6cTA5BeWeTVt
	km6K82n3tniVMj1cMWadWx7JZ1dy8tjsmIjbughk=
Received: from sisyou.hme. (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
	with SMTPS id 1706720919703416.7846206921556; Wed, 31 Jan 2024 09:08:39 -0800 (PST)
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Ross Philipson <ross.philipson@oracle.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 3/3] tpm: make locality request return value consistent
Date: Wed, 31 Jan 2024 12:08:23 -0500
Message-Id: <20240131170824.6183-4-dpsmith@apertussolutions.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240131170824.6183-1-dpsmith@apertussolutions.com>
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The function tpm_tis_request_locality() is expected to return the locality
value that was requested, or a negative error code upon failure. If it is called
while locality_count of struct tis_data is non-zero, no actual locality request
will be sent. Because the ret variable is initially set to 0, the
locality_count will still get increased, and the function will return 0. For a
caller, this would indicate that locality 0 was successfully requested and not
the state changes just mentioned.

Additionally, the function __tpm_tis_request_locality() provides inconsistent
error codes. It will provide either a failed IO write or a -1 should it have
timed out waiting for locality request to succeed.

This commit changes __tpm_tis_request_locality() to return valid negative error
codes to reflect the reason it fails. It then adjusts the return value check in
tpm_tis_request_locality() to check for a non-negative return value before
incrementing locality_cout. In addition, the initial value of the ret value is
set to a negative error to ensure the check does not pass if
__tpm_tis_request_locality() is not called.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm_tis_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 5709f87991d9..352fefc07823 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -208,7 +208,7 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 again:
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
-			return -1;
+			return -EBUSY;
 		rc = wait_event_interruptible_timeout(priv->int_queue,
 						      (check_locality
 						       (chip, l)),
@@ -227,18 +227,21 @@ static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
 			tpm_msleep(TPM_TIMEOUT);
 		} while (time_before(jiffies, stop));
 	}
-	return -1;
+	return -EBUSY;
 }
 
 static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	int ret = 0;
+	int ret = -EBUSY;
+
+	if (l < 0 || l > TPM_MAX_LOCALITY)
+		return -EINVAL;
 
 	mutex_lock(&priv->locality_count_mutex);
 	if (priv->locality_count == 0)
 		ret = __tpm_tis_request_locality(chip, l);
-	if (!ret)
+	if (ret >= 0)
 		priv->locality_count++;
 	mutex_unlock(&priv->locality_count_mutex);
 	return ret;
-- 
2.30.2


