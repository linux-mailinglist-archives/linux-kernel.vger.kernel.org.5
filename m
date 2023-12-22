Return-Path: <linux-kernel+bounces-9565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07E81C7A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BC728519D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524A10A08;
	Fri, 22 Dec 2023 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHvi5Wy8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB7FBE5;
	Fri, 22 Dec 2023 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a22deb95d21so203445266b.3;
        Fri, 22 Dec 2023 01:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703238787; x=1703843587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XSn0qtrctsj5NofJhols7aiVK9MkKubyEzCV4SaRbE=;
        b=hHvi5Wy8kXHz5OwyaSAVTVQBFIyIN74Y/xQLA1vdt0O7nnW/RRhoHioAqPwza/LTSJ
         7ZqXmTFmmAb2tgBop4RwuN0GCNzjaXs8cceips6S2f0rrEKmhLYh4u1aTg4uOA1PGwLL
         wFa6zwqC/tadVHRV5tLh5plL9a4GpGdoqgjBS6zBwD3WqVWFEuYUOHKXZ5PAIVHac7oX
         +qS/OQYd+teXSkA4ygiGEp9pkp9C7dbITTcObkqgJ0mRuA1oXbyOoShaJQqpGknstdDL
         FY2Km2ku7vMrVoiAPqMqOsVgr/Lp3qlODXlVxwZLeE/XUP5WU271sEwaGIASa/Ay2Gf7
         4Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703238787; x=1703843587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XSn0qtrctsj5NofJhols7aiVK9MkKubyEzCV4SaRbE=;
        b=cwA+4atnj2nnlw5y9LW9SRu41FyNnpETBK0boJWp9yUIK99qi/IYJP2sqzviSb/6Pi
         BjBGsboenx+/Qhu068JQcxrFo4Aqg6jXvnlURilM6AlXVEobBmyEHSOQqe22uEoF+09E
         nJssaT8cKA1V1BU1UeIs9T7hAA4ST8J7IPPSOZJmtxLOtraNZkROxC22wL8lkfEcpHVw
         kw02Wr0XpB7xMY6phnhhZrOswjyX5D83QVwUr3PUpFuUt3UqxqF8gprbx5Cl7myG3Xdr
         q6seP6MGL66tUPaCjTDB3qFivCusBokdoArmgqGS9sbPPmo69pM9sK3c3OJUGbRfyEIx
         WlFw==
X-Gm-Message-State: AOJu0YwA6GSHqfyd3/SJVPXOgQA/1TPSY1md496X/GYY15VlrwoqPwJn
	R4vctjKEMn3sYvDCJB4ZfsE=
X-Google-Smtp-Source: AGHT+IH1WtUh4lLDLXG5IiblI45G3p6EXiy1nYiInTnkW1SJPSDVOYTwlRUoP94KmI9gaBCJDsAvhg==
X-Received: by 2002:a17:906:198d:b0:a26:975b:a18d with SMTP id g13-20020a170906198d00b00a26975ba18dmr521736ejd.148.1703238786352;
        Fri, 22 Dec 2023 01:53:06 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:f05b:3f84:67d1:580])
        by smtp.gmail.com with ESMTPSA id su24-20020a17090703d800b00a26ab41d0f7sm1311838ejb.26.2023.12.22.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:53:06 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nick@shmanahar.org,
	dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linus.walleij@linaro.org,
	francesco.dolcini@toradex.com
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v2 0/2] Add a property to turn off the max touch controller in suspend mode
Date: Fri, 22 Dec 2023 10:52:56 +0100
Message-Id: <20231222095258.33369-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Our hardware has a shared regulator that powers various peripherals such
as the display, touch, USB hub, etc. Since the Maxtouch controller
doesn't currently allow it to be turned off, this regulator has to stay
on in suspend mode. This increases the overall power consumption. In
order to turn off the controller when the system goes into suspend mode,
this series adds a device tree property to the maxtouch driver that
allows the controller to be turned off completely and ensurs that it can
resume from the power off state.

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


