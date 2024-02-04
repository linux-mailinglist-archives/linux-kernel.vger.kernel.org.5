Return-Path: <linux-kernel+bounces-51899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6677849084
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4382833F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B606286B3;
	Sun,  4 Feb 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="EIIQZEwy"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45125564;
	Sun,  4 Feb 2024 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080216; cv=none; b=JTWV2V+Z+Rh6s/6fIgETnMOWh9O+00VVqP91WTpXsWp9jm2GUAvXIwTvGoJddq5ew36kjWjkpoYkReWqKaeyYLqo2nwKJDhndPw3ah7Gb6FOf/HZBctOTZ2hzivQYSuNoB+XjjyIXvDKGO56Bh0UnFmIeKM1/uY8DLCCOwpcBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080216; c=relaxed/simple;
	bh=eykJG+XRyfeeV3km0HoSrA0ecm2QNgYnBSMlBW8cESY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ftPd+LKxcnzyLSoXp01SBthL4ERoUNcJBb7StupUl18GQCuY2vBux8pBrcfJJLjeJrCQsmsO6GvdE1xQ9JotI8dgYa3cB4neOb/DdmORCH7MXDmsH83XHKftMHvAQY+Y9yR+oOTS3QCZ49p+UYAF7HsIHv9FAXEEwdpkpS6hl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=EIIQZEwy reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d72f71f222so29922335ad.1;
        Sun, 04 Feb 2024 12:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707080214; x=1707685014;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddJnk8EVePZ3AEE0XAWjIQZpwnQaaAdCogP2NTUpcJY=;
        b=drgtx1c0okFBFZBfn6tgN/Rm0RxD0R55De+3lBvAXu6SEuXqVw65YUCJZ2vx7aJ1dK
         yAnKB3Al2hjPxkFc5bfkjKy9W3hHXi67XNRnz3scdVgorZf6YHLK4Rkr99mbivFDqKsh
         KJ2/BOIezvg6yIinPb4Z/u5pGa9idGjUDdW58hTz7LA42+Q+4HczWAXZRL+R87OtDCmB
         vQFpbTdJxKiPilsKFCKouIBSLHZQdGT7dH5f99CxkyDs1fEKnWPnGaFTHn/mm/iBbtTQ
         q6+BinYTDwR7dB/2UIf5xdPmZMpYEJrNVgNxsJLV7JBrqGt9qtm8G6ckJBq/zne5HTPn
         rimw==
X-Gm-Message-State: AOJu0YwYEjgYVRUtCr/4ztpl27cl3XCdVP1foiPt5xYmT1vlbyKmDcp9
	a0fkcPSYWDseFr+GoihQJ218ZWU/kx+eb1WvhsghbbvW0Z+dMISsRurYB+S9mT9IgA==
X-Google-Smtp-Source: AGHT+IF8HzRjbqASZ86Q+igJTUcsBbCnR254HD6LL9XrXuKS9vHEVyYBiCyXcWjIcIdw1Xz9NT40iQ==
X-Received: by 2002:a17:902:6f0f:b0:1d9:e2b:dba7 with SMTP id w15-20020a1709026f0f00b001d90e2bdba7mr6467435plk.5.1707080214430;
        Sun, 04 Feb 2024 12:56:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW54DmTxkWsSYaA4mByNphDYiJP+ZrSjV/yZmbfqWNF6UNR0qMC6s7PIRX+tqqYaV2t3lq/H7x0272hyEDenhg+60OagB2rCetXrvk+q1xhbkKqWbd2SDAj/Qu6zpVFsARdwPPmkx/zxw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ki12-20020a170903068c00b001d71df54cdasm4854195plb.274.2024.02.04.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:56:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707080212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ddJnk8EVePZ3AEE0XAWjIQZpwnQaaAdCogP2NTUpcJY=;
	b=EIIQZEwyjajpnaSld1HyBJ+wh4j8RXe6UooYpOQHcf6f6dvEVlRRdyAoXSDYoR8McyGYh0
	m85HKh3Qey13jYFxP5ifeEQ+cgI/v30qiZ2fzY89b9dPIBYtMBCzeDdee23rf2X3FzcKEz
	6OsQAfc5+LrltXfp2gwt0oqFTUqqJf3lySeE3ZngMt2plKoa4tY7huy3wkhNZoUfC/0wsb
	qgeO4OOd7Nelg37Ouyxc8dX1Qz5ld4pp3WAxaIaHC2gn16zYrCmrF431mPWC1Nt65mPZXR
	M/3EGJ+uPk5s0YBX8z05q7SBAu+aIqD81PyuPgBeLAHBDH4JcOyJ2xG80GqAqA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:57:23 -0300
Subject: [PATCH] bcma: make bcma_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-bcma-v1-1-0d881c793190@marliere.net>
X-B4-Tracking: v=1; b=H4sIADL6v2UC/x3MQQqAIBBA0avErBNUrKirRMRkYw2UhWIE0d2Tl
 m/x/wORAlOErngg0MWRD5+hygLsin4hwXM2aKmN1NKIKcXRboQ+nWKyO4pKOWlwbrGmBnJ2BnJ
 8/8t+eN8PALMawGIAAAA=
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=eykJG+XRyfeeV3km0HoSrA0ecm2QNgYnBSMlBW8cESY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/ozM731dZUum9sTGr9Nm6NhqE2RxKJl5COWk
 ELkXvWj+paJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/6MwAKCRDJC4p8Y4ZY
 pjwTD/90SuKMOfyu2S+IA7SeFmUy9D5uTW/0JpcDODq0qdESSeT8EVzuvXLC0lYrnGdYDeHxUFQ
 X5TWf5VJ8fuP1sPvaAUJmqjmlYMOsTKm5/oiEh/2+n/FHubPLq/Rb1aDryjgx8E2ctHDZI7I+hh
 riVpVfyni3FlgXcgJJduJMLDeJLQLRwA8m85fxGGH10/dpyFIPwqa3nICIIZFe2FUWDHb6ocYaD
 QjH0pgk4omjeWDuNKVtZo4O3S+m/9rPWevFg3F1FHH5KII01FmzAqitxi/mXcLQquUCXmazbfEW
 320mGnrm6UNZcJd4gPqsNbgFAG2xeEbEHqJcWqstY3qUL/xrlrl4qcn1EB9mypO/AX3NCWtxc/X
 +hBBqNRtgsIt2cAEvec6uyEZ3bDal/ufvg4M/FWpuRFPlhMySoLaqmw7tHwSgH6f1IAIW6z6fv7
 W2F6HqJ64y+luKC/DvO8DGbNnoTAUpx3rr2WFEZ+jc1lvYjAAPBuZTe+kEjbQLsx0QbwlZa4T9o
 IvIVxTdJjVdS+Sz7EEvrghWB/c1Id6+kSkCUW5qGiaLrEyKfF2WeallOT2CYZaItrBqwJKKUa8m
 pKKQH+swtnmgqlE49bF1Kx68kPud71PxSo+rESzeweg3rAYoyDGNKr9xJCoN5J7wKwgm7eO+zOF
 TxZFrDUdyEXiYOA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the bcma_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/bcma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 7061d3ee836a..6b5d34919c72 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -68,7 +68,7 @@ static struct attribute *bcma_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bcma_device);
 
-static struct bus_type bcma_bus_type = {
+static const struct bus_type bcma_bus_type = {
 	.name		= "bcma",
 	.match		= bcma_bus_match,
 	.probe		= bcma_device_probe,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-bcma-51f04ad9a6e7

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


