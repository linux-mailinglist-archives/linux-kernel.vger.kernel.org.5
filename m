Return-Path: <linux-kernel+bounces-146754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF388A6A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942D71F217FA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5EB12AAD2;
	Tue, 16 Apr 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldypGjqz"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B2127B57;
	Tue, 16 Apr 2024 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269436; cv=none; b=p026pyuLHyrqmvssIaCnV0ApyeQAV3sNkRs0UeGltQdKuzgLuSdNFuOKBaG7u0aCEcGYtzZmoYjg1ZFX/rN4SXGNkylAM85VifioubalDT6moiZNZLtgY0urkH+1CPAED5z2iBDF3F3bmJwwQYP8pFDbENYJlFotMdNf2GSxVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269436; c=relaxed/simple;
	bh=oeygwidh8JjsndjXzqBY/y0hHXvLxr6263bY5yFGTNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lndot2FXB8cwZ35d0IFqQyagJQGLlWFgWDjs8THwEIYgu4YmnCGmsOgUfbXjPKygEsmhCtS0PeYO0a+rcgt6Hcc6q0LutSmiYd89iJ2jOCG52WSLHc5jFnvGgVy+nGiLYH/QGzspXXyocWcvTi9KbV0fbienTGlUPix0IS17ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldypGjqz; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57030fa7381so1915691a12.2;
        Tue, 16 Apr 2024 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713269433; x=1713874233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqic+xVQD7P5NplkS6N+DUp4Zv72nWmu6XLdwVwHsWQ=;
        b=ldypGjqz5fLuig2yA9ppMaghbRhG9KJuSLdYpX0+Yjmn23GXVkdoI7QzLDEjmVgKyG
         /nketclHvTb9FbJTEbGvRIXqEpkwOqXlzpia1R+WknuitblRtw1nrIQQT1zNg8T6Qxfr
         J0EK6ViDg6V/cL6roJI4GrzVEG74+4uMEnPRScwbn0zpXe7HoEnqYC23YbBplko9xu2n
         boyMS1rwmtMfuoSgkynr6yz8DXPjHumJnQ8DkrB5JR4u9aktww3Jws3pTr6MLBHQx0dG
         FbvQAUd2Fe/dE5fWt51M1Yo6wtEHr3CkbVJfBtwEZXFXRJFAVevwsgLqG1q8xYFIeYKW
         88Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713269433; x=1713874233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqic+xVQD7P5NplkS6N+DUp4Zv72nWmu6XLdwVwHsWQ=;
        b=MHf/aRhxRZ7udtNec8CgRvzWLDQtMoxMOlett0msUP5qFWOQYrdN4wRK+gS9rOoosK
         Z5KkTwbW4S3miHDDj66Gr2ABV58gekdcJt2wFWSWbKd45cViCkH34vL4evplrYHaY958
         iw0OawEBYe238YUYN8PHKBmhU7pmACXhWnCLpFiSGIwFAHwDtMvQ5ztyoFu0x40oUKF/
         Ei307gB71ShbTVuOdqI8Uutba60QttD4ddfXJM2OQu6dBFJSpLX2sQx0EKYrnMZ3t1Cu
         AtPFMI7KAT2nbsn4QpSvCx41v1Ge7pt0dQCJHkWU3qYxlMtsnSWGlzS53hQLA79gd3mk
         xkag==
X-Forwarded-Encrypted: i=1; AJvYcCWZsmLHgPKt8PuvICEuntWJERIlC6oSJ+008CJLDR0f4HddboGuQ+vlDof8pnbpHKxZTTAl8IAnEMno4iavea+ysnTdc+AkYrRudzPHYNHmbaQEJLYLavRzDtR0dHFJsGndadwWLVWhLg==
X-Gm-Message-State: AOJu0Yw3oUbZJmaB+klLBtDWZbHh7/YEoIRU1pL7LnT6W1MSloEyxcb8
	by/9agMUM+JVM9Ii6cB9s1s8yTQ0lLgUk3Sep4eblbj9K/hZqX4d
X-Google-Smtp-Source: AGHT+IFNRxgcUBqzcZL/4BDXxV4A+yo+1Eh41CrxJTp7WTXdCd0ry8qbZ8DnIqH6GfmzwX+AS/KLYQ==
X-Received: by 2002:a17:907:7e87:b0:a51:adac:d6e0 with SMTP id qb7-20020a1709077e8700b00a51adacd6e0mr10553313ejc.62.1713269433453;
        Tue, 16 Apr 2024 05:10:33 -0700 (PDT)
Received: from eichest-laptop.netmodule.intranet ([77.109.188.34])
        by smtp.gmail.com with ESMTPSA id hg17-20020a170906f35100b00a469d3df3c1sm6767509ejb.96.2024.04.16.05.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 05:10:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	michael@walle.cc
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/2] mxl-gpy: add option to match SGMII speed to the TPI speed
Date: Tue, 16 Apr 2024 14:10:30 +0200
Message-Id: <20240416121032.52108-1-eichest@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mxl-gpy phy supports a mode in which it sets the SGMII speed to that
negotiated over the twisted pair interface (tpi). This is useful if the
Ethernet controller is not capable of autonegotiation over SGMII, or
does not support the mode implemented by the mxl-gpy driver. This patch
adds a new property to the device tree bindings to enable this mode.

I marked this series as an RFC because I'm not sure if adding a new
property is the way to go or if we should use the in-band-status of the
phylink instead. Unfortunately, it is not possible to access the phylink
structure in the phy context. This would mean that I would have to add a
new function to the phylink driver that would allow us to access the
cur_link_an_mode property, or am I missing something?

Stefan Eichenberger (2):
  dt-bindings: net: phy: gpy2xx: add sgmii-match-tpi-speed property
  net: phy: mxl-gpy: add new device tree property to disable SGMII
    autoneg

 .../bindings/net/maxlinear,gpy2xx.yaml         |  6 ++++++
 drivers/net/phy/mxl-gpy.c                      | 18 +++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.40.1


