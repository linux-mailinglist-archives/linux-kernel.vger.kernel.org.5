Return-Path: <linux-kernel+bounces-51716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5C9848E8C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886981C21BC6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E122F1C;
	Sun,  4 Feb 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Z1myHvU3"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E07E2261B;
	Sun,  4 Feb 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057596; cv=none; b=GoiexaLFRVVegujJJNlS8GVU5hnPWmhFV44u1xOs1RF+x7uPz/zJM2h+zi64UqLz2PZRlMrFb7BrW3MWDCC9w4JH5aWldBQv/C6VU9fJ7as7XcP/LIsX+o6SBTYJKjMpXGE9D3uOW4IBxdX9X7q96h9Wbr6ZSa1sgVO2zVuQFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057596; c=relaxed/simple;
	bh=DCD6AMLvjzfV2dwxayyk2LAMb3B1QNeqUuCbdIScgfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gA3qsGgVIHO4sDz0/auU8bKqlR4/r7iFknbyrsDVxLv4a/takJusc9b6SbPXkexfIrpxcK0YoJt/pbDHJ6fwz5coS53aPhmV4tp52uwiYH0P7EHRyIWCwPtbO+oFrwnkrskKn8I8vB1EibM3zeOkTvczkPN0GCoKsKRrYYqrWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Z1myHvU3 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-295f3bf41d5so1599887a91.0;
        Sun, 04 Feb 2024 06:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057594; x=1707662394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ezYYHGSX/pcUtiy9cJ9ZdjJ+J+xQpwes4VQvX7jx/zo=;
        b=RT0Sgu0aoNjulOc7Zycjz0j3UtUZc+foDlikSGkLfRxvsJEcTSIlKWmTuXhbIV87Gw
         b6SqDlEvxMS9np90zxUSatvwKkXkQTK+c1JAw/Gv2Euhg0MbkWyY4HlgFydxjos0LYze
         CNeGFdzsMPYNBA8o0O1Rrn0kySQSDi7ln9GV/r+ha7J9lmflb5DcGanopNNHHv/MPjPt
         VEpnv4BGP8qEkc0Eek9hOa+eSuiZBfwvoRcEx7VaQW9LPTivzUprPm6NNLT52u0e9/5D
         dgYc7fZGDnLNmyn49r6g6xve5fqFf9EStCq0Xgl3pb8+6Wi9t4iLdo/xaC+KWQkvuCSH
         ac0Q==
X-Gm-Message-State: AOJu0YzEIAXjvdXRixhQ99MCdZ+gzKMDarXbRitxu6pXUTTxRmCawuvJ
	9NbUZRytSt1mOIpTrdxjqK9JO0bZdfAMIVq5RCnthsK+dvG2JiI33tQyNRLPMd4i+A==
X-Google-Smtp-Source: AGHT+IF/LvGJWFS07g8bPEr+AKxZH71SH4eIfgFeUu6FkNgwsUi64JoyUEuMoMNAu+cDJxo5eqn30w==
X-Received: by 2002:a17:90b:4004:b0:296:2865:cc17 with SMTP id ie4-20020a17090b400400b002962865cc17mr4844717pjb.20.1707057594330;
        Sun, 04 Feb 2024 06:39:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUiJQ+lFPYnIgtSHcOMHhIoRsTg1y8TX4eG3ha1gdpvWlZ8DoutWGCstkDBbT2AyJ9AjUebTbvOsp2OcX2p6SieVVUMfFlEOvyItA3uk/xAApO+w/89aHEkQtAzamj5MVhejKf7TaCTPCJ/mwghU41I9zdHASE6LndooIXlYl1q1AgOL8domq1ITFDmvZvpGgOWA8CHq4WdoiVtizc=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a020300b002965e463ee9sm3536633pjc.34.2024.02.04.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:39:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707057592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezYYHGSX/pcUtiy9cJ9ZdjJ+J+xQpwes4VQvX7jx/zo=;
	b=Z1myHvU3csMaqFB7GKFE3I0v5WQk4GK1zNW4Bb4qUrz5maEWPuvglehuNuL1BFocoxDO+L
	FEZwjdHTq3TTOxh7bm9gIZLiXjqw0SH3xAo+YTVaz8nenpn8fdgPyDrhT81uVnnwX68frP
	aFUDCQea4Qt72A+VaC7R12cxoyC6VVAo/R54m6j1jrbO6UqTEYSQQpr9yxJzmmp2t3MY5r
	yksHNK4pQnexU6BrQbehR8d6K65riD5jMn3LXKGztQKV9ZTCkb8c0kiWcNDV44rRCwAFgc
	Vh3BBvN0AYeCk3qFmFJHu1fe22jwxZxzIdfMvBpyACRF15Dwxl0HYnK5ZT4hkA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:40:17 -0300
Subject: [PATCH 2/2] platform: x86: ibm_rtl: make rtl_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-platform-drivers-x86-v1-2-1f0839b385c6@marliere.net>
References: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
In-Reply-To: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DCD6AMLvjzfV2dwxayyk2LAMb3B1QNeqUuCbdIScgfs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6HQ3+29jKxh1mamu111xgE2/ToCrm5moNnId
 9Ra8XP3s7iJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+h0AAKCRDJC4p8Y4ZY
 poAFD/4rJaNnFbM3l1qCLz9O/ci74mgChD/er5TjAFUHPNVYWPFXacqN50/ui04UubrqQTZtpFV
 aEOIxPcG7vwsbqgump7v3M1z0En9e8EXDqlbCyL9En81NP36ORYJz14qha9G1jwUqVmo6nU23kX
 v+PfuwQFrw8RrDQfVJo+/GvTfgKt1EFoZwNK2GaR/9YHTqSHLnclH4+wU4wKVciaLLLgHfrJ704
 8qUcY0zqRhdtXDf5hcUtJvXj73+KOeoyNRPmyzo/7b+eryawwVOYRFD5PihezfNEBzkjPuelPue
 7UkU66iptLqoWoI64Pv7Dlh7nWC4ddXDFnFCNUYBTSzeTBnX32c/PiqdNy/xfgmmECjmSy54zox
 E1Vo+9wVR8oY5HNCgJZBuY20ebc8tRzl5QIr7UAIbj9XFXmXHb0aHd95SyiPQ2IWzYsLg+aHr8X
 3cQ1+xtVYfvr1bWHXw21tNeUKIxKrgPLova+CpADd5hio1MSlWBOFM7DLXOUN0ZQdi3KAkbYNiA
 +Mju3mFGxYZAUd61eWqDZTeZGwF/3bwXsHBTQ+DsTnJvCrQz3L8RnOvXFmAkmoYBJI6rH3sce/w
 l8OfXdpW62WBCFSLiYPA4wAMiwUmZUEahDWDk1TMhKiYtxSB2SJioLEsCTtZ8FaTH6Q7z4lWw2L
 70SIcne5QNUP6IQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the rtl_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/platform/x86/ibm_rtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/ibm_rtl.c b/drivers/platform/x86/ibm_rtl.c
index 2ab7d9ac542d..1d4bbae115f1 100644
--- a/drivers/platform/x86/ibm_rtl.c
+++ b/drivers/platform/x86/ibm_rtl.c
@@ -179,7 +179,7 @@ static ssize_t rtl_set_state(struct device *dev,
 	return ret;
 }
 
-static struct bus_type rtl_subsys = {
+static const struct bus_type rtl_subsys = {
 	.name = "ibm_rtl",
 	.dev_name = "ibm_rtl",
 };

-- 
2.43.0


