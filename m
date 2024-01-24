Return-Path: <linux-kernel+bounces-37700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5626C83B413
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1211C2388B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376E13540B;
	Wed, 24 Jan 2024 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWvssRvX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CD131E26;
	Wed, 24 Jan 2024 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132218; cv=none; b=SUwl0ajC/kyKFfBeK9IRgdLvEalkdzjp6qAiDHB2bVts+pbA9qJHc/V4EGN8cCE5tJFd/19mzVi4BYvB7ILXCDxWDFAc0KEiDTAQfZkyXqXBPkG1ZRYOXmALUCxKA6dyReURkhZFgrY2dOlw15Q8Jznv9Ll9+Tp5LeiL3XiBIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132218; c=relaxed/simple;
	bh=ER8YRl0Ubg2rVsBw6JLH22yHGovsalfF9HW2+d0UgUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIJovH0qIxYP+W5PtWDPIWRAPqbwGPB/yn8OntUZWcjzfBGtMMsT8BsK/uQlkApgTtdLPv8vxbcTqmeh2ipua8C5KHjKpTHMQIwshJBipzoZeBRKhNN41HE8zxgwEkNLOdYxBOblEov7lOd6wAq1BBORogerkldS6Um9WxUqGeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWvssRvX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ec048e0c1so18917555e9.2;
        Wed, 24 Jan 2024 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706132215; x=1706737015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOtE6Xk1J/NKQNtTqJEIAQz1hcLUCo0Y1saDef3VZSg=;
        b=CWvssRvX/nyDqfGGrqBChMAN+vJvDRowNlkfvGAfJxgyFVPtr0G2OUVAzQesDfbj/d
         bqBKAOujibLNEdS0aYiSoEzxCxYBk370D4Y0WKY4jPLr/3Bz1gi37qnlF0So5bN6T/FC
         z1IvTMZVHxNgSNrWYKkWa7wgxfDK9+91v6zTaV690QH56W5Qh6ImjtBKd9nH0GFTS+H5
         9zQ8NeE+a5sHWx3CKFeQVimzKqSO9VmIxhE2ocTdk8n5II6c1QTfjyRiDZnbeJbx7jrF
         z8Ord+imHq4Sl94JnyBQSBbHaCwZUgjo45aAIGhsnfFfzfdJe4vf4kJ9c2wRI82j6Vt5
         Jeaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132215; x=1706737015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOtE6Xk1J/NKQNtTqJEIAQz1hcLUCo0Y1saDef3VZSg=;
        b=NBUvVhnjdXHTJSGcnTJjQ4uioY9AO+FKosHcxnRxRfcBujTWJRDL1XMVoU8YG+k+5Y
         Rq7FsVbKu5QA7hEwzS/uuV6pSNcjDunrUXzeAf1b5EjbjGnz6jCxM5L0qlFmK1QvpPeW
         MIivHUjB7f8Y62/cbNNnpq+YdYFtMafWYw6TMUDiNeR8YO6R+t7WGSAc5S4lcBERCXsx
         E0SXN89cjRJp++2h506WEL76NuVEhBuRY64rY9CXaSirFNXiIGPw7zhdXZhm2GGbVfDx
         rEgp28kUrM1uLsnV5ziJLyCF+nCaZV5oLrc2fMWMtk1/T1NMcP3v8ZeBOtwRTg+ORfv1
         RBHA==
X-Gm-Message-State: AOJu0Yy6icuXWDhgRh2ZAU7fgwMrF/mLS+eZeacAsUcJwoGwoZ39CRY+
	UC0FZuyRyUTWAFD81d8c21bk1Z7XFOnw9Uot/tAMQoHRXWkfJ96C
X-Google-Smtp-Source: AGHT+IEhShE9I2lbDwxDWRi5vb+kivrkxinTFc5QgvSilZvf6DqSUcIiZ6aKZAsoR3FngQETjoBKBw==
X-Received: by 2002:a05:600c:3115:b0:40e:7852:bc85 with SMTP id g21-20020a05600c311500b0040e7852bc85mr2216775wmo.41.1706132214635;
        Wed, 24 Jan 2024 13:36:54 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id q13-20020a05600c46cd00b0040e89ade84bsm339466wmo.4.2024.01.24.13.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 13:36:54 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/3] net: mdio-ipq4019: fix wrong default MDC rate
Date: Wed, 24 Jan 2024 22:36:30 +0100
Message-ID: <20240124213640.7582-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was a long journey to arrive and discover this problem.

To not waste too much char, there is a race problem with PHY and driver
probe. This was observed with Aquantia PHY firmware loading.

With some hacks the race problem was workarounded but an interesting
thing was notice. It took more than a minute for the firmware to load
via MDIO.

This was strange as the same operation was done by UBoot in at max 5
second and the same data was loaded.

A similar problem was observed on a mtk board that also had an
Aquantia PHY where the load was very slow. It was notice that the cause
was the MDIO bus running at a very low speed and the firmware
was missing a property (present in mtk sdk) that set the right frequency
to the MDIO bus.

It was fun to find that THE VERY SAME PROBLEM is present on IPQ in a
different form. The MDIO apply internally a division to the feed clock
resulting in the bus running at 390KHz instead of 6.25Mhz.

Searching around the web for some documentation and some include and
analyzing the uboot codeflow resulted in the divider being set wrongly
at /256 instead of /16 as the value was actually never set.
Applying the value restore the original load time for the Aquantia PHY.

This series mainly handle this by adding support for the "clock-frequency"
property.

Christian Marangi (3):
  dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
  net: mdio: ipq4019: add support for clock-frequency property
  arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node

 .../bindings/net/qcom,ipq4019-mdio.yaml       | 10 +++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |  2 +
 drivers/net/mdio/mdio-ipq4019.c               | 68 +++++++++++++++++--
 3 files changed, 75 insertions(+), 5 deletions(-)

-- 
2.43.0


