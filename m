Return-Path: <linux-kernel+bounces-3549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89484816DB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3601C284DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A54F1EE;
	Mon, 18 Dec 2023 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4U1kRjJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63E8495F0;
	Mon, 18 Dec 2023 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553046ea641so1984875a12.3;
        Mon, 18 Dec 2023 04:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702901470; x=1703506270; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcl+6+3YL9EARZxu79BgP77yuw4dwcRKEDjQGoe+jcE=;
        b=f4U1kRjJT6CMLkpY0LIwJ5r27/7FnWxgG/T7xUxOPbiOeAlCjUO/zG1RtpMzr78PjK
         Biwjf+56BiqNaGdpmjdtFFESFkKWgUZZ8fKd/eWs22ijagzMN/SGzfcH4UM8iC5Vw/QO
         inv6Qnb8muLJdMKdazuQF5RiWlSgXHjepziQSLV3DTYlX8IQmOsnAnnRszasUEyaP0g/
         O4wOYuPUgacOsxdmSA7hfEITP5ypeueNhfBG21gLSTQgHzzyuyGchVA7ukYNiom6l0Li
         Pyir5IhsWXg767qNOd/OoZMO3e9yLQie9o8gz8E5dgxwKdWSCUE7V+UyU2TlXR+7dA9J
         Eetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901470; x=1703506270;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcl+6+3YL9EARZxu79BgP77yuw4dwcRKEDjQGoe+jcE=;
        b=RR6aZ8xWWFyy/bTZ9DMcmR8ZTTt987PpPNQunmrZXBqvRmkYbhdbHAsO2p7+4uUhy7
         UzIwYJIPoxN4jSu6SwuVS+TuUlkB5ATpPXuoOVZcFgOVflJa1cjSpbPcvnTXa4904BgK
         AGrrr8kkGBNJ+k0FqNqvLUkDt6LIKIBzA7qpNPUS7mHianEbEk6F3bbuld9L7QuITcP3
         R3IK7gSMVqvAj2Wxwo6GwBj2pkLnLEkSzdP3qFKJ9tQEXoFEsVdUIoA7+YG/lRRdCZzO
         qpGphJg/ru+gWpAswaci2Cn1+bHcnIFIe55N65IF5itFrkOSBgxlmOOjbTBlW3dTIPQO
         pcxQ==
X-Gm-Message-State: AOJu0Yxblh52qYBlJtO+YNOYNXshAsAO9lO3u4c4bCUxdhnPkwfLAzip
	vKi0gyUdxOeOBhspC9Z3PUo=
X-Google-Smtp-Source: AGHT+IGvY+/MLO836UxK0KN3FbrCCW1ixC/a0qxzKQ5O69sm9GdqpJBJxE1ZgrBIazFhU82UaIpD2A==
X-Received: by 2002:a17:906:340d:b0:a23:56a6:2c56 with SMTP id c13-20020a170906340d00b00a2356a62c56mr390655ejb.180.1702901469657;
        Mon, 18 Dec 2023 04:11:09 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:801c:2315:7dea:474f])
        by smtp.gmail.com with ESMTPSA id gc18-20020a170906c8d200b00a235e5139cfsm774221ejb.78.2023.12.18.04.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:11:09 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove non-existing SHA-cyfmac-dev-list@infineon.com
Date: Mon, 18 Dec 2023 13:11:05 +0100
Message-Id: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When sending an email to SHA-cyfmac-dev-list@infineon.com, the server
responds '550 #5.1.0 Address rejected.'

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d984bd745e93..0db8909f4fc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4156,7 +4156,6 @@ M:	Franky Lin <franky.lin@broadcom.com>
 M:	Hante Meuleman <hante.meuleman@broadcom.com>
 L:	linux-wireless@vger.kernel.org
 L:	brcm80211-dev-list.pdl@broadcom.com
-L:	SHA-cyfmac-dev-list@infineon.com
 S:	Supported
 F:	drivers/net/wireless/broadcom/brcm80211/
 
-- 
2.17.1


