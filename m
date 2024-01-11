Return-Path: <linux-kernel+bounces-23389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2444A82AC26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8F81C23D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158814AB2;
	Thu, 11 Jan 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6exD5dh"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611914A82;
	Thu, 11 Jan 2024 10:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so5828917e87.0;
        Thu, 11 Jan 2024 02:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969574; x=1705574374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MuVNFMNu/znFyjhI4YiVPNBcWz8JIXuuibOlcW6cauo=;
        b=l6exD5dhQxAdw7J509IOWuqTjfdXjGjeKueQkdjjbfb+obmxHG7trxUajB+HY/xGqT
         8A5dthvizvm1g0TwlOK0HIKyvXRzbzFrw+EsV8bZFixv1Khaw7woxUIF8NAo3q6tk4SG
         6dQL0meiHsDQRn0FX/qwzbtT4yBZgu0IDz7OKl6JC9kBehFXBOHlxXENjW4KDBK0hSWj
         C9YUHGzf0W90NhUq2x3gmNDEMZGf/3A6pD390CDMKu7kwWzit3xt95i9p/x3HaHkaJ0a
         FjIUf/fdMs/Eet78uiK8eEm/hxE0hnyU9g1a4ADKMrpkOOLA3bynQlvAjtqrMOvigAXA
         2uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969574; x=1705574374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuVNFMNu/znFyjhI4YiVPNBcWz8JIXuuibOlcW6cauo=;
        b=gElVf9y2KjxgdXI+4on4Ocbw343IuKfwZ669HxxsJVbdw90+7BeLWgsPtUJ3iUl5DV
         6CJDjLDlGAwBOp0yWmlSHWzMkS2i94/Mlm0dZcxzyac1dzJa7d/hVIsWdYspcVZhPIQ4
         x3uqyNq2ycQEd0itNRrc7Z9DfdT9lFBEsZdjlZYjSVvkTVQWbqy0S0K6IhZ8QPFe/XDD
         uD9eV76x+yn1b/gqDgSyzKb87YHNBUW98/c6Ipn6JJ6+bq5uQ4Qsw+K8PAuImUbEJwOp
         BKhvIUhJ4vtJgep8N/5peAOgNlInV4BZFXchMseELdlj6lLKNpttjtM8Cp5YLEB0EJmB
         slBQ==
X-Gm-Message-State: AOJu0YwXKdTJRk34S8QCfpUkBJ+vJWFr/PehFLFbFQxg8pXCBCGDuK3v
	k+/oNY+7nxzu24qhhlyAZxU=
X-Google-Smtp-Source: AGHT+IEnpP/pKX/gXbee57tP/8wAV93Q1jQEFfaBg+OenM/0Ooa1lAhiPzT2sTpofQ+k5kRMXR9eVw==
X-Received: by 2002:a19:ad4b:0:b0:50e:dc99:b9d4 with SMTP id s11-20020a19ad4b000000b0050edc99b9d4mr385313lfd.44.1704969574165;
        Thu, 11 Jan 2024 02:39:34 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906c20e00b00a298e2f6b3csm407179ejz.213.2024.01.11.02.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:39:33 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	soc@kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/2] mt7981b: initial DT code
Date: Thu, 11 Jan 2024 11:39:26 +0100
Message-Id: <20240111103928.721-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This work is based on linux-next content and was successfully verified
using "dtbs_check".

I'm not sure who should apply this work. Given I received reviews from
AngeloGioacchino should I expect Arnd to pick it to his tree directly?

Rafał Miłecki (2):
  dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi AX3000T
  arm64: dts: mediatek: Add initial MT7981B and Xiaomi AX3000T

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   |  15 +++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 105 ++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b.dtsi

-- 
2.35.3


