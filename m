Return-Path: <linux-kernel+bounces-2565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3F815EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EBCB21BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267E132C72;
	Sun, 17 Dec 2023 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0QNSVdB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957932C64
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so1778930a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702815100; x=1703419900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t/MMH/RXWEUDqFDBFvyU8RBy5WsaZx0F+yOSGlX0vEs=;
        b=i0QNSVdBKuC86ZYerq5ftfZS+Fey1RqrGcXqAZTQ1az8YhphUpRFXzfhZZ75uoCAeT
         P7ao2/ibkYTiP/TpuCTkMG4q76T+GiBzgtfQ2EPQN6yB9ahzP3soiCAfxceg7wHodL2u
         vazKqSEjUdqFbYaiik/G02JJE4ClL8PIooXJS0P7DN0HgBMErRnJJSG6Ehh1ge6ww+1d
         DK/gTRUpWz6ud6v3e+E+/42Qm5jLi2irQboLCKNwYcUMJTuiNQrV1JdGZBXTY3TWBWot
         HHgItpuhNv8yZlQ+/9pGBEvDa5nrGvo+5b1IpNlDBamhk0LU+qCdG5KmaI+87zuvnzNb
         MDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702815100; x=1703419900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/MMH/RXWEUDqFDBFvyU8RBy5WsaZx0F+yOSGlX0vEs=;
        b=nPzygolqF59PsjULSIvWnDiCunS3jvaIRL5JBOQ+FxLOMeRSjw06r2qJCOFGiqZ+Ws
         5+Nyggk2wyrolBQecTjJAUzzoMvwl9MF7aKNZJKSCEVDPYWNeicVj02sewh5mHCgfkks
         aMJDARF26DVOwn46rVM4/wTEwSCkWj/AVY9HeKpGQXCDoeseVRjobLymdQpUz49/ivYF
         pPwkgxENamlN43Y9rF1yra5M6IuokV3TqjNW1C5WQ92SOKp8V4PtH1ZhyhCcb5BFhZOH
         X4z/MB83IJVzSQRmP7SwPBuCo1lWaXkVk9gItHcqqE9FTCnZuf3zMIW/PFELEL2vs+G/
         JkOg==
X-Gm-Message-State: AOJu0Yx7N1wBPDhCr6X6xc2kVK6CCAtM/Bej+j8frJ/Ytz1uKAuawERE
	57y/t2GVkOYV2qF5z8M78qE=
X-Google-Smtp-Source: AGHT+IGlwBarWW8BN7EzHnLxpFvf9jMFNfFpKc+TmGFmIcyui6zQZ2QPyccmtj0qWGVAg42Q51rvLA==
X-Received: by 2002:a05:6a20:ba7:b0:18b:5a66:3f70 with SMTP id i39-20020a056a200ba700b0018b5a663f70mr16135498pzh.2.1702815100477;
        Sun, 17 Dec 2023 04:11:40 -0800 (PST)
Received: from toolbox.. ([2406:3003:2007:229e:ac29:68d8:877:4f72])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006d5a62c612asm890156pfb.215.2023.12.17.04.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 04:11:40 -0800 (PST)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: greybus-dev@lists.linaro.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	jkridner@beagleboard.org,
	nm@ti.com
Subject: [PATCH V3 0/1] Make gb-beagleplay driver Greybus compliant
Date: Sun, 17 Dec 2023 17:41:31 +0530
Message-ID: <20231217121133.74703-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In beagleplay beagleconnect setup, the AP is not directly connected to
greybus nodes. The SVC and APBridge tasks are moved to cc1352
coprocessor. This means that there is a need to send cport information
between linux host and cc1352.

In the initial version of the driver (and the reference implementation
gbridge I was using), the greybus header pad bytes were being used.
However, this was a violation of greybus spec.

The following patchset creates a wrapper around greybus message to send
the cport information without using the pad bytes.

---
V3:
- Rebase on char-misc-next
V2: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/7YX5I6ZYZTNTAHBH3M3KAMOWXMTAWQNW/
- Add more comments explaining the new greybus hdlc frame payload
- Remove msg len warnings. These checks are also performed by
`greybus_data_rcvd` and thus no need for it here.

V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/Y3ELHKLKTP5TQZ5LYKCE6GHWMA3PUOTV/


Ayush Singh (1):
  greybus: gb-beagleplay: Remove use of pad bytes

 drivers/greybus/gb-beagleplay.c | 58 ++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)


base-commit: e909abe885e2f399be7ac0560a010d7429f951e1
-- 
2.43.0


