Return-Path: <linux-kernel+bounces-131510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D4B8988DC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E41C2710F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFA9127B51;
	Thu,  4 Apr 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gwb1Yspj"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D3127B45
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237725; cv=none; b=e9rP3UxfW551CxVhxl66ueHdGfQvCXnSqab3FrJ+MJxRJNj36f+mH6F2DC5Q2Oeu+V4mIEzan4cJvsGFXzWHBzCnl78EiNsvtIGq24sazG+a5avDg6/pca8ZL/oT+oD9gS+GdQ4nCtWV/JdcFlhkOqcdl3GjdUFNWX5AbndUqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237725; c=relaxed/simple;
	bh=T/e2Z+UzwFEEvo+yZto4ozOs7PdQ42qjues1cZwdgpM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pZ6EIpi/o7CmoHRqLEdhWiAy1Il3GltYaTSkx0P/yK9f4qcZXKKLqmTDgsY/V6G7nE4d9lI/BR2vhM/kJ9daX8g0+ZR8Njgh+MUug04vuY9YJEwD5gprvB5ZWT8wMoOSE903WW9Xm8EbtPLM6yxkUN/ecqttHlaI1NY2LkDGOjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gwb1Yspj; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615032a8ce5so17680467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712237723; x=1712842523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hetVaClf/9lVuj24JMrL9FriyluZzetl+ezDnz2xhz4=;
        b=Gwb1YspjPjlKQOzxQrEOzaNoio97brSgVgZtURqlFK9AQRkVjc+AKZhv9IPSw761QO
         TK59d60amicIGvJb5ZYpe2sPP8ce9Y6bDKUxbzUhRZ99J0ZwuJHQTgOtvTxNo6ePOqnX
         NAe5aKws2NtSJWI2X+3I4YMEF0ewNPeiyRp48TwahzssSauh3ldaxKuDjLt46VisuS5M
         vP+R9jYZhqUXlD0d5DRQZVLcqUNxKVMjaGdBfvLVY0s0UdpDfvpB9v9Klf9pYroejlEn
         aPouzLNfpfd5naljZHi+i8lAM7zi2RXRwz2xX7p8uob+8N/+lPH1jcL3FEr5O3tQLgsm
         FxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237723; x=1712842523;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hetVaClf/9lVuj24JMrL9FriyluZzetl+ezDnz2xhz4=;
        b=r5+KJKiklTgQfAhW3Fso//2X5ZZNsQ++DaE8aEalDRamKgwJq1IYbnKXX+4ET/5nhF
         hBXSimgLD3ijq4uk6N33hveuB6uJRhOMW1uEQMs9hjvv6H/B7KNm9/poE5CtaaDda5pY
         rjB3JAno4dUcF89ktvroakcd/aJVQi7xyIYjjB0glJHR1xwDjjL9NUCgn7NHjurTLLfW
         5Vo7R3w6mrrtN2SRp+VOOZL5u9+sYQn4QhaibAgznSPKPjS0FQsf8j+sCZtUzD3FxX28
         MlLSqG7tPf6rqDgvoaxchKr29OFjFTzbCxxeA8euoVfspo1HYJvZJduojsAv73k1WXHj
         QgMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAr6kwtY0VTWBwMkXb1mNbtX0q6Bz3m0ZbOoZ3xtQXXIWX9CCXnzx5nnRtTC+4ejjExF6/8R2m1VrEx3eDf2PKhsopgp2EKdyXBSv+
X-Gm-Message-State: AOJu0Ywc5NPsFmP0+eNRivaJu7c+YsyqoVkUyRbUT9Z9kwvcVpz7uc4I
	d13twM2kmj/NEz5KFweQa5VWRpXS/0oPAFllYPnj9R/ULn49KO1/U4tgb3Bu5L5CjeQc3/wu1hl
	EpdFfLg==
X-Google-Smtp-Source: AGHT+IFpeL1kU/z52ZFjT6Yrsam39v7avneNXzrxyor3Qi+k37OG1axFH7Cbl8OqGm1CW+N2ZPKFP/zd6MMX
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:a7:c:ad10:daac:95a5:1fe1])
 (user=kyletso job=sendgmr) by 2002:a05:690c:600d:b0:611:7166:1a4d with SMTP
 id hf13-20020a05690c600d00b0061171661a4dmr699112ywb.3.1712237723382; Thu, 04
 Apr 2024 06:35:23 -0700 (PDT)
Date: Thu,  4 Apr 2024 21:35:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404133517.2707955-1-kyletso@google.com>
Subject: [PATCH v3] usb: typec: tcpm: Correct the PDO counting in pd_set
From: Kyle Tso <kyletso@google.com>
To: linux@roeck-us.net, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Off-by-one errors happen because nr_snk_pdo and nr_src_pdo are
incorrectly added one. The index of the loop is equal to the number of
PDOs to be updated when leaving the loop and it doesn't need to be added
one.

When doing the power negotiation, TCPM relies on the "nr_snk_pdo" as
the size of the local sink PDO array to match the Source capabilities
of the partner port. If the off-by-one overflow occurs, a wrong RDO
might be sent and unexpected power transfer might happen such as over
voltage or over current (than expected).

"nr_src_pdo" is used to set the Rp level when the port is in Source
role. It is also the array size of the local Source capabilities when
filling up the buffer which will be sent as the Source PDOs (such as
in Power Negotiation). If the off-by-one overflow occurs, a wrong Rp
level might be set and wrong Source PDOs will be sent to the partner
port. This could potentially cause over current or port resets.

Fixes: cd099cde4ed2 ("usb: typec: tcpm: Support multiple capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
v2 -> v3:
- rebase on top of usb-linus branch and fix conflicts
- add Reviewed-by tag

 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c26fb70c3ec6..ab6ed6111ed0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6855,14 +6855,14 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
 	if (data->sink_desc.pdo[0]) {
 		for (i = 0; i < PDO_MAX_OBJECTS && data->sink_desc.pdo[i]; i++)
 			port->snk_pdo[i] = data->sink_desc.pdo[i];
-		port->nr_snk_pdo = i + 1;
+		port->nr_snk_pdo = i;
 		port->operating_snk_mw = data->operating_snk_mw;
 	}
 
 	if (data->source_desc.pdo[0]) {
 		for (i = 0; i < PDO_MAX_OBJECTS && data->source_desc.pdo[i]; i++)
 			port->src_pdo[i] = data->source_desc.pdo[i];
-		port->nr_src_pdo = i + 1;
+		port->nr_src_pdo = i;
 	}
 
 	switch (port->state) {
-- 
2.44.0.478.gd926399ef9-goog


