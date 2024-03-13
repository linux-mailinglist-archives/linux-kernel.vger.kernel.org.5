Return-Path: <linux-kernel+bounces-102599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AE87B469
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A213A1F2390A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F95B217;
	Wed, 13 Mar 2024 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYDuki+q"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B14691;
	Wed, 13 Mar 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369404; cv=none; b=YWve5LGkTwT6tG0acb66htHsWmYi814v1goL7Y+AaKUYElW+YyR6SEnEb099iw1NpES8NDb08gI+OvIs2PahFKVAWyV5rQVdA6tYnIKiBdHnRpwtTo69rFyc8caqBOS5bXbQTbhbTHuoMoWMIpUnVDkIkwMuHT+7YaaqZRB/JF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369404; c=relaxed/simple;
	bh=HoNiHyn2z/ceoZINAmLkTLotxgBXw6b3DpSALXSG1eE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wym1gbbS7U1Gqemd9s1BG26pqB09zSMrGX+zVNUH/K1zl2Dg5cRNMBO+8/GXe1ysKcUc8K4H5obdxwec/7uBMhetn1BoHeZ3TH5iwSKyLBE5PjqjEeEUd/eKMOyC2Hl4JX6Xbf/3Fn8gOGbHY+/Fc8pfnQU64Hzn9cIycLZlU2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYDuki+q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5685d46b199so503354a12.3;
        Wed, 13 Mar 2024 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369401; x=1710974201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i1/rg6loiRVefnT/ad+BPRTM7wjwljQZZ0izBe/guu4=;
        b=BYDuki+qzEz16KWhwZuMn9IVRsESp5VwOm/hSuSrqnCuvvuoqpyhBPrtwUhhEyYlry
         i1MBh1X/OETIjRaRsl0wrQQFYZ98xw9ZccvD5ioLTZ/bK6RZ834IkTraryCJVETpWE42
         4sw5KPz+NbDu7scfZg9FXGf2tWD76W7VK6biR+yMArbjNckVrxFeShtIRL2eTKGPbZ9I
         sQ6a0AJgNfNLtwiYdap8kzYcx4QCXldEY4DElIJGR33s5u4bPoU7EQTdhUHme641aUcY
         xAjHZ5naAzhiCkGSPpdtUshO5J366KRX+dVOBLa8A2MxsFOh8Z5Y2I+9pRIzjEv+tKCM
         0rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369401; x=1710974201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1/rg6loiRVefnT/ad+BPRTM7wjwljQZZ0izBe/guu4=;
        b=i+r8Eo7h7zR7uz342deSdTeJGfk1MeXJoiDiKtir7xdS/pHnbMwYYHm5UudJTY4R08
         dr8/07t13LsROrvFcyCQohJDGZ0/br6/NDiUDwv+gwxN3v8wGqh1aN5/7fHclDJwYW+q
         4nIcS1LTYcC5gfwnaL1gtBSDzo3YefMrQbk3o7tgch2+77SN4+pBpQEGml5WPJqFjD6z
         bmctMGH141+FJCyRhaJgxIKWSHZcfvJdJ1wAn+B36wRntP5VUymUe3nq1LSmItxXBQsU
         +5FAMILZNbK0ZrS+wRiT5y3rUVMPaJIgrHf2yWAcEpT1LNsqzy0nJlFWE8fIRit7qZj/
         jQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGc1LktP5BGJY8x7ryYOf3zH4PHqbbMeUMWEFMFwR4WEIwTFtOv3BW6O8RW20NRrQGFYrxA/kcU1NMaBr8QHw8AqJ6Jx6ziMNIPVDlio2BkPfe6dMCic7iQkpRpBzWYX6BsYDwJCZpGgaHlH0TmqJz0+WH6UWljLizn9yORQgk
X-Gm-Message-State: AOJu0YzEQESzbS/6mlETRqDkE7ls8zT19d454LCLBK3T0KSLxWR7373k
	PiILH38JLBvhYLTOhYVakEycNi+vNF6gOt3XIiJb2sjy1QZ7STGk
X-Google-Smtp-Source: AGHT+IExQacc7OFEKg7kTWtl0PIi+BT2OE2qYBYhGday2AS1EvZCTPtJQ/90lGZfDHmQk1t4kSk3og==
X-Received: by 2002:a17:907:d047:b0:a46:3aa2:d452 with SMTP id vb7-20020a170907d04700b00a463aa2d452mr6750954ejc.64.1710369401595;
        Wed, 13 Mar 2024 15:36:41 -0700 (PDT)
Received: from fedora.fritz.box (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id dt22-20020a170906b79600b00a4669f6c2e2sm70366ejb.44.2024.03.13.15.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:36:41 -0700 (PDT)
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: fabio@redaril.me,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Valla <valla.francesco@gmail.com>
Subject: [RFC PATCH 0/1] Documentation: networking: document CAN ISO-TP
Date: Wed, 13 Mar 2024 23:34:30 +0100
Message-ID: <20240313223445.87170-1-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the in-kernel ISO-TP stack is fully functional and easy to use, no
documentation exists for it. This patch adds such documentation,
containing the very basics of the protocol, the APIs and a basic
example.

Sending as RFC because my experience with the stack is as user and not
as its developer, and also because it's my first kernel contribution.

Thank you,

Francesco

Francesco Valla (1):
  Documentation: networking: document CAN ISO-TP

 Documentation/networking/index.rst |   1 +
 Documentation/networking/isotp.rst | 347 +++++++++++++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100644 Documentation/networking/isotp.rst

-- 
2.44.0


