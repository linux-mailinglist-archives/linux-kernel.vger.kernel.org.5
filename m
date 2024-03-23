Return-Path: <linux-kernel+bounces-112505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD2887AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC31C20B09
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267B5B696;
	Sat, 23 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdD34H7D"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7D0523C;
	Sat, 23 Mar 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233992; cv=none; b=N4+eIxI9Xh0k22WhiKOQNKTt41EQBKxEINTRyrd8zHp9hrPeLeNLSK2MGt9nWpKbfUN31m75b0LjHglBoW4P9H95zzIF6baICRL2ob3DobEzoj59QZDkXMudG6o6ceFHXynCBIDg7sYTD5gfQqFNdHmgulCdbTJ3FIEpoLrbwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233992; c=relaxed/simple;
	bh=OQSSw+T2GoSY+lThACkiEgEy2fpte8QkQPUTmVc8eQM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sf1c8WPXYOK3hSF0PNWDamUiaYeiAxOI6OdSOIER/msrzebxtO8xo+OomrkWSbPzDe7/7R3T8/OsEHmDufrS+UEbfAaH/Xsj4TpBv3/s+41bh4BnGRYIbo/Sf2WgdWRs3wVdR8morT6lBGFmrYeTVjAnv2C2zq6nwYxSR2ZeT1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdD34H7D; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45f257b81fso384869566b.0;
        Sat, 23 Mar 2024 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711233988; x=1711838788; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vdLKkWsnw1j494EGgMaTbPStZ25MGp4Y5oYBzg/8JQ=;
        b=AdD34H7DjQbqMxETjlief8yG3o9ToResgh9XH+4uBHon/KbMj5WSIo/tb7Pp/DkKnN
         fjVI8MSO9jJBfwW34GmaAzRyO5wh21nzrD9L1SHouEY7FespIhWqVKWxMWBmB89RXnMp
         SczGBYV4YnULZegzUpDCxo66HquiKBXlegInTM5m3XmYXbqdArNszPowD1u+MXnJ2eLh
         H8FDEPTVBLPYP1X8MsTebkD6Xlp4JZvxUdcnUWF2RU9HA3Tt274c2PYCXung/Qwn32g+
         6yj999dbaxaton9CS8CpnuEvJmpFm8SzZEUy7Pr3ElHhwiGXa5ENgiHd28ldvoeLskc4
         Z7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711233988; x=1711838788;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vdLKkWsnw1j494EGgMaTbPStZ25MGp4Y5oYBzg/8JQ=;
        b=OYHURhkwVeadSiPZXbXInhvnssNqltOED5gbur3G3zd4xzf85EFMVe7/SLLTtHuAkk
         8LWsrs+30Yvsptl8CVmodaj3NNTc+J/7c/iz+Oao8RHGmszZJrzbqV/9+Bi32diVNbzF
         rQgqRC2lJrbjPXVOXHxnSTWiQP0a1IAzHb4JmtZA8Kiq9bXsNs8GMS/cSpqsHMOF/Ee0
         A/d+a8XjoVbjT19zq8T/4V5u0vxVu9vXBXAXXTgZS0F/Lfp+r/HBoSbhzZCruSkOV3ep
         STQDsokagBua1LuDIUbX9DyxGebC1G29D44UkBSPsvHocSw3s/9qepZwWJxH8FnOE43x
         Ub9A==
X-Forwarded-Encrypted: i=1; AJvYcCXaCsRL/2iboMllYypz/+corvuJ/Mwhq1PA9KW4yPrNH73n5/sG8SYy7PFXPDxik2Nj0ss3aAxN5QaRoqHrt7GFadfKUtqmcLW64ACMkk9xOyUZoUdYp42zOAZh9kPOpp7AqOxySOHO/Q==
X-Gm-Message-State: AOJu0YwVHuNAoqn0VjwpOaf94G1PsUzcnfJ36vx4QVEPswk+uJE235/X
	72lapVh5wkiYYdR4MHvoP0WZ0vUHWKrQ/2pHu6LvMNy6fLtUoq1zqgI+lziEAZf24g==
X-Google-Smtp-Source: AGHT+IF8/Br3QbKfw2wQhGWqXTVOFVXWScNWHEIhe/xJOkDyos/3cULILhtOu2HoIzT+4oWmbFocBg==
X-Received: by 2002:a17:906:6d91:b0:a47:669:d0f2 with SMTP id h17-20020a1709066d9100b00a470669d0f2mr2618567ejt.50.1711233988518;
        Sat, 23 Mar 2024 15:46:28 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-195f-8ce5-d7d9-2242.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:195f:8ce5:d7d9:2242])
        by smtp.gmail.com with ESMTPSA id bu22-20020a170906a15600b00a461d2a3374sm1350424ejb.47.2024.03.23.15.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 15:46:28 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/4] dt-bindings: rtc: convert multiple devices to dtschema
Date: Sat, 23 Mar 2024 23:46:12 +0100
Message-Id: <20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRb/2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMj3aKSZN3KxNwcXRNzY2Nj0+SkNEtDQyWg8oKi1LTMCrBR0bG1tQB
 xMgBbWgAAAA==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711233987; l=1791;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OQSSw+T2GoSY+lThACkiEgEy2fpte8QkQPUTmVc8eQM=;
 b=9DM2WDRL4T9klzIHyp6os5BOpJxSAEU/Hg4J/lMG1mN9XA8VmPLJo8AejvgmCZHck4K+NOfPY
 nzsLdhQQkcoBrCvzY0PVVjmQHi2C3q6Kw1GbvF/66kB5FdvapRX2z8w
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- armada-380-rtc
- alphascale,asm9260
- digicolor-rtc (renamed to cnxt,cx92755-rtc to match compatible)
- nxp,lpc1788-rtc

All bindings include at least one compatible that is referenced in the
existing dts (arch/arm). Those dts could be tested against the new
bindings.

It might be worth mentioning that the reference to nxp,lpc1788-rtc in
arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi also includes another compatible
called nxp,lpc1850-rtc, which is not documented or supported by existing
drivers. That generates a warning when testing against nxp,lpc1788-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (4):
      dt-bindings: rtc: armada-380-rtc: convert to dtschema
      dt-bindings: rtc: alphascale,asm9260: convert to dtschema
      dt-bindings: rtc: digicolor-rtc: convert to dtschema
      dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema

 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 --------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 49 +++++++++++++++++++
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ---------
 .../devicetree/bindings/rtc/cnxt,cx92755-rtc.yaml  | 37 ++++++++++++++
 .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 -------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 48 ++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 57 ++++++++++++++++++++++
 8 files changed, 191 insertions(+), 81 deletions(-)
---
base-commit: 70293240c5ce675a67bfc48f419b093023b862b3
change-id: 20240322-rtc-yaml-473335cbf911

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


