Return-Path: <linux-kernel+bounces-155107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7008AE556
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2D328647D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2985278;
	Tue, 23 Apr 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP0VnXmx"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6171284A57
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873093; cv=none; b=iJGK+75oUy0Ooove1xjoOggO1R7bWBwWsves5NCF6WneWs6pOEK3OZjgVOoJdU8YBfoviqMG1zOxIQg6zIoaS3msBM5+OsnbmOBkcnfjVz6GDP4UUCcVW28nuCeyCS54EGo+t7d/4HsPUKCXDZ1+6UnQ/I7SxoQrNbpQaRQaTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873093; c=relaxed/simple;
	bh=ddANpevsQ0h8yC7sChZkSDyELfUcHh2lTwkyZVxuxCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYbG6/KiFh+b9j9ZbugcMG/FGJo8UGxcPr4n9Kb/gVtBsJmR57aN4Y2i9T09AsvuUD2+axn8J7TsQgaE8TF8nqOgfQMjm/6HIXxCUlLocuW2MLttoYgREyO+0ydyaNgIU4zCclW3eDaLWi5WuRxA6RKontam0hQ5YWtA14m+bhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WP0VnXmx; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de54cb87998so787448276.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713873091; x=1714477891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddANpevsQ0h8yC7sChZkSDyELfUcHh2lTwkyZVxuxCk=;
        b=WP0VnXmxUEc4NZsYug9tqxW6QXQVth4YWa4neSVh+objxK1qv0sgVNJB1chDGb5oIR
         X2XR+tuvG2Xa/OGPhS9Ba9YOq4vdcrHOCsuCdOqN8IYWV4Iw6xxopiWFu0VicB1FX8Za
         v7PhRdrKN68/oEDZoMcFNHvSIs5pH/bVM43YBkAmExnHOt2otm9xRVLYaNxt/ePv+cEa
         STuSuklpxYB5w3AH4lu6eUFR2SEW43X5jXm69zDe8g5Aob9B6jiUi5bvDv9id7vGrnG7
         ExzFzIVqxPow4irN5drE/Zm6ujfJNd592Oo2HKGXF3PYPOkbbHtTRyZL+av2K+aEhlQP
         hWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873091; x=1714477891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddANpevsQ0h8yC7sChZkSDyELfUcHh2lTwkyZVxuxCk=;
        b=ldAgDyvepn1oKJ6kT92S/JXhlC6j52tJpYfo9qv87wONSNmo0pcU6+8oMe0e+WtLXJ
         a+Pmv5FEms+81xsktX1I0dyDdfX0HZRQKeYkdtBJmapWrUILb9bhNOV7xUo/KAzzelQ4
         t+y3If1nWRxIMMULbvJq93SPA6tpAebnTQDqQgD71Psgb8lZBYyD5S4KS/Ogrqe82KR2
         9u9qEDyILe8HkRt4Qx4tFWxDRzQRhaIEZ4oPAe3NuJzGqnPSiLlBzcBtOVbbWhqT3tVD
         7Ckuuviron6V5KZlHAM1pJW0nQbd6fgR6g+p51wSnl2NxGilvvXywq+i6xRmxrSj9EK3
         CBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpPUIF0KGg5morZcQhbYjwycrG8P2ctGVNoJ2zP7maeeBEdHxZxND3mtUmUqtz/oKuvP1BcIiPoCG8C0c1MvjIWHuVt4BzZxmNBlcM
X-Gm-Message-State: AOJu0Yza4pDYDlcQSmXus+Hn3hucZkyWr3wqgIsoo39r0WQdu0UU676n
	IUq4c8Gp4KP6TxpwnEt+5pQAhi3TD8ebjI6bIpR+4PlBUv4wwMtl1RmhbXJl99okxRYvLKPZMBV
	hsH7bt+UvlzH0zqGvWyqkY/ADb86Euy3O1n2vwA==
X-Google-Smtp-Source: AGHT+IE5jJvGfgj3iRgV11ykFoGcs5sKXFaguZHxhJpbm+7d0DH1KNrcZry+M8oWEoNCnacit2O4bIf0pXqIyxVcUDY=
X-Received: by 2002:a25:aad2:0:b0:dcf:c7ef:e4e0 with SMTP id
 t76-20020a25aad2000000b00dcfc7efe4e0mr13844166ybi.1.1713873091410; Tue, 23
 Apr 2024 04:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com>
 <20240423-for-soc-asus-rt-ac3200-ac5300-v3-5-23d33cfafe7a@arinc9.com>
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-5-23d33cfafe7a@arinc9.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:51:20 +0200
Message-ID: <CACRpkdZNoQBzqZTZty5iSySj4ZYWF4TwJSTB=uU_-uDDnvePEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: BCM5301X: Conform to DTS Coding Style on
 ASUS RT-AC3100 & AC88U
To: arinc.unal@arinc9.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Tom Brautaset <tbrautaset@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:51=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 R=
elay
<devnull+arinc.unal.arinc9.com@kernel.org> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Reorder the nodes and properties to conform to the Devicetree Sources (DT=
S)
> Coding Style.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>


Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

