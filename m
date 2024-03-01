Return-Path: <linux-kernel+bounces-88114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A786DD7A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676D51F2952E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B96A33D;
	Fri,  1 Mar 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W24gBmbu"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194076A032;
	Fri,  1 Mar 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282967; cv=none; b=fvqJBamAaoHOHMcsuh4mKTliZTKbhlTkBNkg38Kt7cVRsU/KRF/gs4YrHtvu8FwqpO4RCw0vYgUMZpx+3kwhovzVqXuQhYcKupERyMbpYJgvZwYN5baLAPMYkMIi6XLd8VSbobDI1UXkxuKAoAcYjw4mT6e7coYutmEnX2dTzAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282967; c=relaxed/simple;
	bh=gbWWC4K9eTGH4dhmTQDU1bh6VuuTU/OkgdClr0lTnKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVzduVdceHokYIa8N/us1/TDo0kcZsl9ghTiXQidSuhNIh9mWR1IesgtiaUNjUB4aGABi1M1ovIypNtFXiyt+3ZGP9h9jLQXtEpoN+zB/gH/BibnnUqvXqAXE8onP1SZ6qB9mHAQOdklimLvRdCDBIhRBWCHYEBdLR4qLUPpIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W24gBmbu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d27184197cso22533621fa.1;
        Fri, 01 Mar 2024 00:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709282964; x=1709887764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrYRSAUoeQ8J5WS8v4YJVTlbKwPXfvoBkY+Nt0CJRX0=;
        b=W24gBmbu82hSLEg2+ZcJDSG5apM9JwxrBBtuTmW57P54hQmB8aBW/0lNJ2lmuhArBu
         9+WN6nFOLl0c10ynOVCuGDgqA3o5i1mRwK33AYHUbaev8MYSrhy90VOT3JeXEeJdYR2y
         i1BC9vDoxI8Y8mdk9ElgYHEZMGgV2OPufuY6DSA6L1YymUUABHFtEwQ6ZKIA3hq8Tp8F
         oEz3V7rF0fhiDwNQD+qozwkIs9EZL4gXMgv8iwjPMbbZJe9FQz29qKCFA3PIm0UDmcMb
         /uWFcYRWsg718iU7xejNs0Q4tbgJ4Dwrcj79aylv6O04DC7wtY0L7BuwyEP89svMsGXJ
         psSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282964; x=1709887764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrYRSAUoeQ8J5WS8v4YJVTlbKwPXfvoBkY+Nt0CJRX0=;
        b=Y66E7H5MT4dZIB1P8PIxQr2Ey3ImBnBFYYyjE2heq2GT6GxrDUnZe/jooyx+VsjdVu
         9KuSFbznarU+B3bKMNKSpmetuEHXgyi4v8v6m+se+ifsMAoVN5bckh613gmaFWKvtscM
         5qrPdCztVVwUWBiTZEIchnzXpRyrDhwS3GF8Cv4bZPHGtYZeUJnWfyaH7uVEWHZq2q1D
         9Gq+TExrq04w+Un2zmmER/nOzvUagyl+oega3vFXgoHN0htT8xdj/wmNq7EEhOh0/S6b
         BRWcpw1MpwUmzIE3ShGZfDeuggbIbCdalMoWHqmPxVNXeG0Z6+rPSsc7n4Vanef13IWI
         vHag==
X-Forwarded-Encrypted: i=1; AJvYcCWU/iafyIwYCTExAwVxNGL3ai7XPMlEp9HRwr3AO5nMkKIN0FoJrQd77xRXnxaUk+hevNZ8KYbLoom06bZWT6mbrCH3nOx6Umik6I7kFJSzCP9Yz8UTXDD+AnpFyetqRGhGBuj3ZkZZzw==
X-Gm-Message-State: AOJu0YwjldJvNBtudf7sAf68ynCFtDbMLFYjV4HifzACZjxrAWtRFTcN
	hEo6m5atjlqtnXniejNNt7RO163Z7AA4dznzNN5SIEwh+ruHIVi8
X-Google-Smtp-Source: AGHT+IHnu4c6XyaUCopPrBZplYhIt51nFKHDhwroMzJezwFzgWmL1hNnrWVBkUooTXCo7TUqCZQGog==
X-Received: by 2002:a19:4359:0:b0:512:9857:34f3 with SMTP id m25-20020a194359000000b00512985734f3mr719899lfj.39.1709282963921;
        Fri, 01 Mar 2024 00:49:23 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:46fd:a61a:68:ed87])
        by smtp.gmail.com with ESMTPSA id 4-20020a05600c028400b00412b10ce488sm4583566wmk.23.2024.03.01.00.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 00:49:23 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 0/2] arm64: dts: ti: k3-am62-verdin: add sleep-moci support
Date: Fri,  1 Mar 2024 09:48:59 +0100
Message-Id: <20240301084901.16656-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

This patch series adds support for sleep-moci to the Verdin AM62 in
combination with the Dahlia carrier board. sleep-moci is a GPIO that
allows the system on module to turn off regulators that are not needed
in suspend mode on the carrier board.

Commit ba9d3cd71f15 ("dt-bindings: usb: microchip,usb5744: Remove
peer-hub as requirement") from linux-next is needed to make DTB_CHECK
pass without peer-hub set for the hub on the usb1 interface.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Stefan Eichenberger (2):
  arm64: dts: ti: k3-am62-verdin: replace sleep-moci hog with regulator
  arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci

 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    | 22 +++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 24 ++++++++++++-------
 2 files changed, 38 insertions(+), 8 deletions(-)

-- 
2.40.1


