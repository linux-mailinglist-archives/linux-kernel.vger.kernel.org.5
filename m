Return-Path: <linux-kernel+bounces-59245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C8484F3C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EDF2881B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727128DB5;
	Fri,  9 Feb 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB+ND9Pp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26725601;
	Fri,  9 Feb 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475817; cv=none; b=MSWJDziKB7j7fBtp9z5dn+rw8xlIWK0RoAucvbqcXqXntFoGUV+fWy8Arvz9hoSi/sH46ln4ePfom4DKajaiH4tEnqq4YU8YJ7iQ2YcefoJPy4bLmsONebY83uqDYSPVwnJo/Mitnkab3iNX5UyyYtWGlrH88+CWOJVOzkymjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475817; c=relaxed/simple;
	bh=bINds3wnwjsfuZArQrwolY39Op4Zultj31lCbJh0k+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U1i6MIjSEzVb73pT+3n0OwE89tCjkSQvD6tk+frPe/+jRwkLgF8x3NAAt99xQI0LNHPIsqdyhTBeRMoinFxwDf0qjyxgwkgtbFj3M1KnBj6w4eW7NQFaQtBL/rGRo5SQoFqfupn/2V75p04pfUeua1xWUV+3ipL8pBkjxOVhM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB+ND9Pp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51168572090so1375985e87.0;
        Fri, 09 Feb 2024 02:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707475814; x=1708080614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6uYbxf7yYToxU6OmDz8coT5iHkSyLV83vl+tZgOKS0=;
        b=RB+ND9Pp4XGpI2WX7zE6kaazLToPakCvXUu5eWSBtsL8nw6VXEmKBjVHVA0Er4HL/c
         fmwSqrLNDBUHzk+STQUjX5kFzljLn5O5P9yK8oC/cg8414klbOwWxWcxoScVnXuybKOQ
         L6xU6HzzHP+D94fDmUBGM0cd4GOTD+rWFJtyXMT1WK43Zvm5gp7F6TJpUIL4bpQbOZod
         rViKo0mzPvjleboPZiIWWcOkiLBCCoZ78RzEyC2DDkKYgR7OMcJLrGs/ylmGj55nTsbV
         nCMSxU7A5gjCAm2xuFNt4DIwtoFsgCf6/hdMYnEfK2kGj2eSyzM9TOtpXZuL4Gj+3NQT
         hcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707475814; x=1708080614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6uYbxf7yYToxU6OmDz8coT5iHkSyLV83vl+tZgOKS0=;
        b=UG9bAbWdAONdh4+dS0t7kigMfGN2HuRXQT8/eiBHSo80MbsZ+0Pb18uI4Swg8JR2dH
         K6TGHzYm5kN6257o+SzoURdhWZmz/O5D1MQ/qcBNWughhw9bD5fpHVf85YpSGXyqck0/
         A5cHAlOLviEda/hQSU7ewFGq359oD/nTqrUCa6UMktpidpj+pipOF3okUEdeLhHnjB33
         dvMsJpbqmmi4vJLVZzjEhVjrTJBNtuqCWf/a22soJAaJLBhHv0tQZ6qUZDNfVD01uTSx
         SmmmUNApE5Usw7MNacCwM3HInMr7AR/MXi2HITO6G+YRFNiYqK/+CCQvj6YrQahe2enS
         44gg==
X-Gm-Message-State: AOJu0YwYj9lhVT/9r+PzPXz7Fjry/KDTIc8D7FugyoY6qbBj35qZW4Gd
	QmSGp/958lHMKSXYtOAwK9hy/35CXct1qMGfN+1iT2JMktO8/zkT
X-Google-Smtp-Source: AGHT+IEpIumUNsf3xiDQPPvz/mreysnuOLMTL8jtpyugnii1nY9eDYj78HAqFUquXMdkJh6Uqam2SA==
X-Received: by 2002:ac2:4568:0:b0:511:706d:72f2 with SMTP id k8-20020ac24568000000b00511706d72f2mr708108lfm.68.1707475813482;
        Fri, 09 Feb 2024 02:50:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpNxTnu5n+LmuDXdn+i9OCGDckrfR6gbVuF5lYldSVYxaTEAprOvu3h9L16s0T201fQmaRC24aer8Ie5EpRN5blle3HrDylW7bp9CQlmTOKAQklaLgPR8/l8XSron3DKGB5tyjDGzNHk588ziuBXHsnB3iyjAgYSe1zIIJlxdLaUEPdeFwYrXJCVP2wJM//C95Fm8kKd/D6OIl5Stq7V8mG69VKzrTDzRoOLmO9WzothIMpjDohI8cooDbZvHz6ZDNF+tQZ9hN0WiFtJpyw41mntJrseO/usnYZiotir8Y70fyaQZyzlIdclYKEzAxhQhmF9b2wAefb2hmW2y7rFGOeWD/0KFLtDlx4zfhdUL63zop+kpgArG337C89FoKckhOC9PVrkJdOcfoG6CQ5I+nEhZkkCTKoz0aDZGHOCRO3z1l1fFRQwAONcB/pGNh49210fthq8Y+bRkNUt9Z9GXvXqZ5oM2ETLhXaF5u68RTaWZOXq2EQQIdYhb951kMYhs1NK7c
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0040fc26183e8sm253627wmq.8.2024.02.09.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 02:50:13 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com
Subject: [PATCH RESEND v3 0/2] Add a property to turn off the max touch controller in suspend mode
Date: Fri,  9 Feb 2024 11:50:10 +0100
Message-Id: <20240209105012.22470-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our hardware has a shared regulator that powers various peripherals such
as the display, touch, USB hub, etc. Since the Maxtouch controller
doesn't currently allow it to be turned off, this regulator has to stay
on in suspend mode. This increases the overall power consumption. In
order to turn off the controller when the system goes into suspend mode,
this series adds a device tree property to the maxtouch driver that
allows the controller to be turned off completely and ensurs that it can
resume from the power off state.

Resend v3:
- Previously I messed up the series because send-email crashed. This is
  a resend of the original series:
  https://lore.kernel.org/linux-input/20240209084543.14726-1-eichest@gmail.com/T/#t
  https://lore.kernel.org/linux-input/20240209084818.14925-1-eichest@gmail.com/T/#u

Changes since v2:
- Add Reviewed-by tags from Linus and Krzysztof to the dt-bindings patch

Changes since v1:
- Rename the property and change the description (Krzysztof, Linus,
Dmitry, Conor)

Stefan Eichenberger (2):
  dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
  Input: atmel_mxt_ts - support poweroff in suspend

 .../bindings/input/atmel,maxtouch.yaml        |  6 ++
 drivers/input/touchscreen/atmel_mxt_ts.c      | 72 ++++++++++++++-----
 2 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.40.1


