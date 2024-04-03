Return-Path: <linux-kernel+bounces-130029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12AE897364
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C46E28C69A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81485149C68;
	Wed,  3 Apr 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxuxGcA6"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4369114A093;
	Wed,  3 Apr 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156744; cv=none; b=ZyWoqkOY5SroJ1jEZdHawBjkKRDo/64TPbu/s6LrXiAdzQQ/n0WZbnYQhgtjL7VJg0K6X6vIu9fuwl96KEiNVENJQBvQXNET4m+i3GPkzNMzml3Rq9F+Y+Zxx38i35O415Ql9freRKcq6L19uYcKdTFlj2ell68owebaW2Pvxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156744; c=relaxed/simple;
	bh=vKEnA46LNIYBD/r4zg6POqJ9fE49+HQ7ou3GmwNLpXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZczvBqgoI6/UT+wSGkZdEbgVI3xIpXBGSksYakzjPTDSGpyLCEtT8CmfoDHR5FS5K0hjYF8Pi+0zCufSXwWxC2lkFiNik/JnpKzo6W+oGurPYgjl3jCt8PimH+xcm2Hplx5iGkttduVU1U44ds54AHHmw+A8hAt+iGRH/xuoBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxuxGcA6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a466e53f8c0so854401566b.1;
        Wed, 03 Apr 2024 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712156741; x=1712761541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxHB0J6rX43HE9ciPEpBOcvr3yTZZIhFw+viwUxDb3A=;
        b=IxuxGcA6CaqMjulWV2+hdE06+hvFAjv/sXCj0+Z4UUSd+sbZo5xbj/QUQ3C0UBo7eO
         T0nIVli4XD6lcXk7jhyCSp/6B+sI4+FnVaf0a2eD29RStzdKgXdq766tiUWkGWJEnGji
         VWJVgwYZCxwyGXASKfOd0+mDSEH8Ge3d4d7zFyAdrIdIQrNviUNBDSuJ7cIGeAr5Aotu
         U3RsK0ci8vMewyBmHEFIIbG5nlMPvu0Lb7/aUGcsWWjVv0mZ78lnS9YD6YxA2BVC1jWv
         vZZ/jYuhxPUL73c+CD9Ya+xqwVjmx59hUEV7Ro86xs82F4Mu8cZ7GFE8DoU7n3/IGgJY
         mu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156741; x=1712761541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxHB0J6rX43HE9ciPEpBOcvr3yTZZIhFw+viwUxDb3A=;
        b=lBKdMgVP2TEPbM7MzRSEzHqlrxouFC8uiT+6H7xLrqZhBhwncxpPLwm9fpWISBCWGv
         CSrn1j7s2ro2accplFkGRUx/ABlqXnant8U16nAFciwMo5nalvJ0R+iOyYCXYZRk+k+N
         kTtkVgoCreev/op272qGODtRMsRUOZSTgUWwgRQgB2d87mJ1G7wWGjUxEuI0gsMUASCn
         pHROL8j0OLC7qZD3lLn0yjt59Lj0UKe6hwdhOyrUy2aR8WlY97GCEw3NF/Z2YMu3QBZy
         R64DafTad2ZltwaJzsxZ3AxcsSsnj8o8wI/dBLazbcbyVAm8uIXHuU74jYDJwHooC2/s
         oygQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsJrVwuFZez+CpifIYVfhSm04hjBYpXMFEqtCPxhVPW/oATrGMQh1NORLbSVrPHgiujO9WGYqwtvULCUSNabd2izCJxep9qVFPSNOaxzngcqPCOR0fGnU3jHAbX/VCvghVL1bAud9u2us=
X-Gm-Message-State: AOJu0Yzbx+wgXpc+ZEyavgeKYZ5sIIQoqx2I0DfHZ5rNoOVq5Js5UOeu
	G5UD9mRuwtADVbNz/EXub+kpoHCQMTw8s2LQFRnnIMOTCG7N+RIc
X-Google-Smtp-Source: AGHT+IEncL4sraW/La3SvP9mabjQkzry8cXX1FpqbfCr6j+zWLCdOGzW7WkLTPeOPIEB55ulkuJhZQ==
X-Received: by 2002:a17:906:52d1:b0:a44:51c1:733c with SMTP id w17-20020a17090652d100b00a4451c1733cmr12217795ejn.39.1712156741170;
        Wed, 03 Apr 2024 08:05:41 -0700 (PDT)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id bw17-20020a170906c1d100b00a46b4544da2sm7777241ejb.125.2024.04.03.08.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:05:40 -0700 (PDT)
From: Yaroslav Furman <yaro330@gmail.com>
X-Google-Original-From: Yaroslav Furman <Yaroslav.Furman@softeq.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>,
	Yaraslau Furman <yaro330@gmail.com>,
	=?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org (open list:HID LOGITECH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] HID: logitech-dj: allow mice to report multimedia keycodes
Date: Wed,  3 Apr 2024 18:05:14 +0300
Message-ID: <20240403150514.18058-1-Yaroslav.Furman@softeq.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
References: <7e34dc43-b70b-4a50-86fd-f021f2de4845@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaraslau Furman <yaro330@gmail.com>

So, I think this should work fine for now, but IMO we should see if it's
possible to allow the driver to receive all events that a keyboard can send,
since Windows application can assign pretty much any keycode to any mouse
button (perhaps not the main ones though), and then we might see the same situation again.

I tried doing that on my system but the driver stopped working completely.
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


