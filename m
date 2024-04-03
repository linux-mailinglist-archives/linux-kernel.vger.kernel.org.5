Return-Path: <linux-kernel+bounces-130223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1258975A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E227B1C23084
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C136C152164;
	Wed,  3 Apr 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdKyulW7"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C86F099;
	Wed,  3 Apr 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163293; cv=none; b=fPOvmYCkSv8kuuuJnb1mPKx7q4yjsPet7BFEBwv6WOUtcDVHB2z1hZ/y8drS03NMMu7c9FeVnV6sdniiP5CNc2GaDBv/dM+DcqbFJRKea+S5w3uuMgmjJQqBfogHeEQpx4SIl9cjZOWy6xpKDMpaXGjXGXyzzHE748j+CfMyjfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163293; c=relaxed/simple;
	bh=Fvh9o6wzrL+wsj4izndQI3gNw6KnWCFeK+z9xbZzFAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+gv5FVXea1X4KuiRNGSoDhfmdybhE0c1lOICLIysygfXH/VYTHH8OYtaZGDK6i4Wbvt7cjLI6Up14OTXFxmxukOgEAG0wvPBauxerc16tM5epyZqcmprIM0wBUD/S0askLR7rrdb5C0MfUX3RpkgbqjakNQv4uiQcL0Tz+W0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdKyulW7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c1922096cso47204a12.0;
        Wed, 03 Apr 2024 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712163290; x=1712768090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ftGbdvyEENqXj9Y227BGsAh9CPLKud5Rc3uo4/P1+0=;
        b=VdKyulW7IcWr0IGG3uC7HmiNR2nyav8U8LVxNdtup13+3/wxnlzKyIqCbxJcV0ulnC
         3bskPxxBSMZ6E5TLCdg2PLaVWoutjvU+r+aoesFGocEhsStnznaHN5Qcy0qsDZ1C17zf
         zSkUEDZHIAROn0KwIfV2JsnPz6vn0WZaAMx+i8m1S36WObJZdjNFHcVtvUfcrkj7qlOR
         iGcVZoUe0w7WhFqjti5zpkt2COo4WsZrfVKdbZBnHN1h9+GbLg9XWAqGACvXP5jq2fDB
         DXFApmDMCYxforM8zXTogp+SrXa9TAfbQeNXHpApVK6qpv2pDleAHCalUNLGWY3Z3hTG
         jR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712163290; x=1712768090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ftGbdvyEENqXj9Y227BGsAh9CPLKud5Rc3uo4/P1+0=;
        b=Cj4HxQ1j83Fd2tuhQvhoTzIQHUIT+jSQNHu3gtwkLDzQk2NItPVkKnYjpPeWWz5RXo
         TrUZat8Pfc73JfAkLile/HOQmvUP4NmVMXgXVuPGEqD48mfKXz5PtKppDr6aw6QN1Vz5
         gLScL6JXiJRH8sK2tKh2w3mTf/phCdiMh+jYE8E993iBtx0O3JE9m2KN7cL43zaVCjEZ
         B7LcdmgZJMciXtgsCw9ueVeT7BGI74mdcAfUyAKCBtNhjsFCGVs5j/UaPO/mfGupzlUM
         JOu7Mj2Zbhy4PYAQaeq6EnBBy77y8D+4Ns8Qch1z92RBM1YjLV0lQWs5rYjjKxh11t26
         O7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUjJHhka1AnpvQpKGtiV/ECCZDZ8plWQ7/C3FMZPEa4vOXvMYnwiFbXUQCutGINz/rteV6SDlV7nKM6PrWdq42JtJPHyxlKh2aJ4MzqN4wmzCf5+G6jSV780Yjuc/BAK0RQnuKzhBxst8=
X-Gm-Message-State: AOJu0Yzq9qdPBjplwi2eBYLKYnDYUp38II67yWO4uOQU+0WtJVc3zQbJ
	4ZUIYqwX2OtjAMRDDimwcZdLsj5jWChgBci3iJwz1G0PtzwjINcz
X-Google-Smtp-Source: AGHT+IEbwyfBS/zTwpi8STC3Og6/P5SrW6e8xm+boHDtjn/92SMRx6EJfCuTXOTjfBlBkPvdAWijfA==
X-Received: by 2002:a17:906:da81:b0:a4e:a114:1afe with SMTP id xh1-20020a170906da8100b00a4ea1141afemr2085490ejb.2.1712163289646;
        Wed, 03 Apr 2024 09:54:49 -0700 (PDT)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00a4e24d259edsm7578477ejh.167.2024.04.03.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:54:49 -0700 (PDT)
From: Yaroslav Furman <yaro330@gmail.com>
X-Google-Original-From: Yaroslav Furman <Yaroslav.Furman@softeq.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Yaraslau Furman <yaro330@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] HID: logitech-dj: allow mice to use all types of reports
Date: Wed,  3 Apr 2024 19:54:24 +0300
Message-ID: <20240403165425.114844-1-Yaroslav.Furman@softeq.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6713652f-9a44-422e-b6a7-45501093cb08@redhat.com>
References: <6713652f-9a44-422e-b6a7-45501093cb08@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaraslau Furman <yaro330@gmail.com>

You can bind whatever action you want to the mouse's reprogrammable
buttons using Windows application. Allow Linux to receive multimedia keycodes.

Signed-off-by: Yaraslau Furman <yaro330@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index e6a8b6d8eab7..3c3c497b6b91 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -965,9 +965,7 @@ static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
 		}
 		break;
 	case REPORT_TYPE_MOUSE:
-		workitem->reports_supported |= STD_MOUSE | HIDPP;
-		if (djrcv_dev->type == recvr_type_mouse_only)
-			workitem->reports_supported |= MULTIMEDIA;
+		workitem->reports_supported |= STD_MOUSE | HIDPP | MULTIMEDIA;
 		break;
 	}
 }
-- 
2.44.0


