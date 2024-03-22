Return-Path: <linux-kernel+bounces-111264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFC8869DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5101C2298D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD98383B4;
	Fri, 22 Mar 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHAgAoqS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AA222606;
	Fri, 22 Mar 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101738; cv=none; b=qMMC72VcPjHCMYfMbT6CtlD3L4P0aM9aHHt9g+wX6YEyVE9mz6QT7qPaWIP9AQYvZD0cvmbDav5S0wXHGu2BEOkar9hVQM/q9dJDqkMewTwSvwOwmiZa1UyupHBQ7a15SpWsRUlMUlcXB98LmdbPiyD6qe8HxxZDvy1alLQY5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101738; c=relaxed/simple;
	bh=62jJUrHoHP38Rn0k5oyzA1XG37qfUMJ2K/zBdqfGUP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4AHdAATcI3uGv6iJnNWGegWnH8y38HKKAjq6eDl4r83IJujw9S6Qr7gm7R2IuDFUMTXaaUMwTjtokuR8pTqoFGCUEpjUWUXjNR1d4DwOG2SrYkOCkhWpvRCUUmAUR0E+sAJB22B6yYQLS9aw0x+czoAWEFjD2rk6cYHQptjhIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHAgAoqS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d717269fso2489019e87.0;
        Fri, 22 Mar 2024 03:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101734; x=1711706534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj0KtMulKS6qm6DDe93mpg4hZ8YoO1D0E1T1zPxRB2E=;
        b=YHAgAoqSamqXEEMEVjjA4agNbSdruMKdK1zRYQlubATz1T1JNxPlEHsSr+GFvDwAI9
         BqcIsc3I6SgqHYzgrLOBF+sz/tAckM4HlwFr1MDbkVtSKymu8P84soTSBJHzotHFc/l3
         6r40wQ4vQGPskV3HptLosgqTxb4jLOZVlik4wot2NrbHN6pjLAg+6IHskctQO65taWFg
         XxKbxe/k7HOhKE8WTjf+33hc9YyN7yzCoKyVhTm2MS3kgoKUmKGiwJQB/DNKIKtWOSgL
         B01wnBbg7SjNbSbx8CERUbV1GogjfmsvKt+/WM4fWLttDx2YdofVuv5ihmHJaUUXN1TC
         1CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101734; x=1711706534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mj0KtMulKS6qm6DDe93mpg4hZ8YoO1D0E1T1zPxRB2E=;
        b=o0N6Dr/3jIZRmQjlgAPNvbOE9bnsxDjtNkgnUXQqjzRZcjNeUTfl+iNdT2N0BKiEsc
         UrqdJLmeSEmBmpPg2kBHvlchDrERV1f9jZFKZJ2hiw1v9eu5G6pB47Z91hVxhxaKNzAH
         pMeXVU+haoqJkOeQTHC/Pm75tFxc4VEEhLQo6NIsQq9JlTRwMSeW39hB9ekSqH3JEoo+
         Qzs4ICBqlbpwhiazw+s0CJa0dElGxEVlRzu4RxeGwDByAXFuzZlE94wqNwgmj5RbIkm6
         Czg1+2i210j2MzcoyX/brLQ7sqBB6+oNd5Qq+6H9dnQWx6RB9C+qdX+zYg4akwLrv0rv
         RR7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSeUSap2t0c32o48DfogVMhGqyDVmlYKh7p75MVdHBeucN+X83jCK+imxsvN36iDX6VzUSBIlmbrJTPs4CrZqq3aYPnwvwbShSo3AvFOQ3BLeQP5O9R4lm82JZIbVtDTi6+1uFXfYCeOo=
X-Gm-Message-State: AOJu0Yz45WzFlPFcXKXBJLq3BibMsVzVALnZ+M8oharh23fsm55zDXZn
	5wmWl8mNmVsRqnC3PtjAzE758t9pyfSK73KKIPX6wg2gjNVB7cHI
X-Google-Smtp-Source: AGHT+IH9Y3UpLmdTOXIqvveYBiseNYTB0Eco3RNa2ww8MpzfP3uW2s8d8aIkGKTFTjebmZYEiETaug==
X-Received: by 2002:a05:6512:3133:b0:513:c658:799b with SMTP id p19-20020a056512313300b00513c658799bmr1179063lfd.55.1711101734271;
        Fri, 22 Mar 2024 03:02:14 -0700 (PDT)
Received: from fedora.. ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b0041413aefeb9sm8389434wmq.48.2024.03.22.03.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:02:13 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 1/1] HID: uclogic: Expose firmware name
Date: Fri, 22 Mar 2024 10:59:58 +0100
Message-ID: <20240322100210.107152-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322100210.107152-1-jose.exposito89@gmail.com>
References: <20240322100210.107152-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some vendors reuse the same product ID for different tablets, making it
difficult for userspace to figure out which table is connected.
While matching the device name has been used in the past by userspace to
workaround this limitation, some devices have shown that this is not
always a valid approach [1].

However, if userspace could access the firmware version name, it would
be possible to know which tablet is actually connected by matching it
against a list of known firmware names [2].

This patch exposes the firmware version name in the hid->uniq field.

Link: https://github.com/linuxwacom/libwacom/issues/609  [1]
Link: https://github.com/linuxwacom/libwacom/issues/610  [2]
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 9859dad36495..5bab006ec165 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -884,6 +884,9 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		goto cleanup;
 	}
 
+	/* The firmware is used in userspace as unique identifier */
+	strscpy(hdev->uniq, ver_ptr, sizeof(hdev->uniq));
+
 	/* If this is a transition firmware */
 	if (strcmp(ver_ptr, transition_ver) == 0) {
 		hid_dbg(hdev,
-- 
2.44.0


