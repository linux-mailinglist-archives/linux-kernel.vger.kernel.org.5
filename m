Return-Path: <linux-kernel+bounces-28552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFAD830006
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA11287E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D58BF6;
	Wed, 17 Jan 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yrl1SmwY"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769479DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471955; cv=none; b=CyqXTkqPORu4APQRrexF+d4WBVb7D1GkmZ8fk7CFs6TGZT9I/D9cKr7IOMdJSfGgEtEOnmWRrW1goARIPlrOZETpo9tnKqBP1bH+rXO/jn67fmdngyP6F3RYh3o8HPgB1P8qSkBwCZdYoXHbLoyn7T6iGBAtA0pSOLT418Sttis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471955; c=relaxed/simple;
	bh=/O+i3bBbSGhrHffLTYKEuytn1lpaNu1aT4x1166hMzo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uFzmcxmAFhHaVbsRn60/H7AAwO0ou/zO03RX89hlKOspyZ4GkfyEjfei59woealPfMtZSSD/1fhcgbMmneM2fuhceYZdfEn/oBDTkrHJRO4WjB3NahDB1RcJTTbrZG9yyucFi7mDU5ovk9X4kV+Pds0wT7PuJCUpCOLmgDPg6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yrl1SmwY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so8246537a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705471952; x=1706076752; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VqTNHbNPjeR+iNnNOrzGjC0iGge9LE6I5Ajdhk+khs=;
        b=Yrl1SmwYwgkT3e6+ZpWpu1+mWJCCjChxV6OpTNnaugnpcFw3e1lKxA/IArxXTKiQCa
         XM2X1FRqjticXwHIhZXJWYtYHGrNWtba5KkJ1sH7oojmDQPtsQeIOWxOcm3JkJ9b7vAR
         DnGCk2Kim38HKXyywyxGIfmHriijNjtb+YqKEUAi1NbXSsPS2DXQdkAdTjKAV4dn+nsH
         BESPZ0OTmWWkLSxSYrZwUciPl5egfLLBxf2vhhoLg8Bvfc50jvAbpyycESYcS2e08Vvu
         C098M2xgt79Z9Dq0tSQ4xiYX3tJhg2oBermKfAE8Gz+4kgjkvVHQvn/QkhrVAfY0OLcN
         9AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705471952; x=1706076752;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VqTNHbNPjeR+iNnNOrzGjC0iGge9LE6I5Ajdhk+khs=;
        b=WTa2pDaI8eUJm8Fq5YVicfunjD9K0YDhXZK7LZ8IFddo4/lfazsqMmeuX47qNAOZpc
         wxHdYBSfQECsWCvskIDXNnPpLgFtGzWI2eUFuUSlOifJ/WJMQAfgBZ7pXhHCdHXNL5ne
         kTq8XQ2p9l3o6uDBouk1BCDN76VcaA6UL5U6jqCYgYk4XLxyvZS20o6nHMXxbMkAQrAE
         M69AFni5pgju5rQCYA7leL6BJPKRTzdHhcc8pr9f8n07D4LjyeSqFHfhI/BWq4AGXTfu
         nXSwIgX6za0z+yksj60dOZo3FbKy+oB055sOMd4TB+xvBmlEAzvYPrGCMRg6eB5e6XS8
         w3Ig==
X-Gm-Message-State: AOJu0YxKYMyqZvleDhCZZ2PEVw+v6FdIFwzrkkERVNcEzQsKKMRYqypU
	ZSrOQTZRBKSR6UY29c3Yz/8=
X-Google-Smtp-Source: AGHT+IEtq5SYYQiA6hfQIqwyTvOpyyO8Pf/HvPVOM/ROBNgBa76wLMrUsRCMpteseYk9rocQRBlzBw==
X-Received: by 2002:a05:6a20:182a:b0:19a:589d:498d with SMTP id bk42-20020a056a20182a00b0019a589d498dmr7179205pzb.48.1705471951850;
        Tue, 16 Jan 2024 22:12:31 -0800 (PST)
Received: from LAPTOP-7VGLEE77 (19.216.252.27.dyn.cust.vf.net.nz. [27.252.216.19])
        by smtp.gmail.com with ESMTPSA id si1-20020a17090b528100b0028d8fa0171asm13194725pjb.35.2024.01.16.22.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 22:12:31 -0800 (PST)
Date: Wed, 17 Jan 2024 19:11:17 +1300
From: Hoorad Farrokh <hourrad.f@gmail.com>
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: prism2mgmt: Removed unnecessary parentheses in if
 statment
Message-ID: <so663sd33rgvgzufcxe4oc666os2gq5nrdinqaqquksrkvnr3c@odkxhcxhb3ux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a Linux coding style problem.

Reported by checkpatch:

CHECK: Unnecessary parentheses around 'msg->prismheader.status ==
                     P80211ENUM_msgitem_status_data_ok'

Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index d5737166564e..a1adf69ba9f9 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -1288,8 +1288,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
 
 		/* Set the driver state */
 		/* Do we want the prism2 header? */
-		if ((msg->prismheader.status ==
-		     P80211ENUM_msgitem_status_data_ok) &&
+		if (msg->prismheader.status ==
+		     P80211ENUM_msgitem_status_data_ok &&
 		    (msg->prismheader.data == P80211ENUM_truth_true)) {
 			hw->sniffhdr = 0;
 			wlandev->netdev->type = ARPHRD_IEEE80211_PRISM;
-- 
2.42.0


