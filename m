Return-Path: <linux-kernel+bounces-155105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635CA8AE552
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E681C21AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA768003B;
	Tue, 23 Apr 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQHL/jBw"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53286AC8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873057; cv=none; b=UiD/XG1GDAKY47kk2dFxEQMxy7FlUhFuREbETq8pIU7WcVv0sJp3HtaZiJZN9aWx34P3ppoNCIvlgEXjyW4xR9bEgK5Vdw/V3Ut2ZKdgSFgsydronyLYu1BvZTtnu3hMFMTQkENYAav3vT3im6LHS3FYsud8JG8lWUqMrIEWYO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873057; c=relaxed/simple;
	bh=QhV8sC53PuoWeO2HSJ4LPypflMXSSVbyY/ZD56aWh1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh9ZX0PDKjkJIgsyRvSQsmS2Eb27V41l49MuHTM3xQrB81c7PzTYKpvy/XIzzSjR9L5+gwvUu8v5z1zJC25Xl64Agu7aYw8HkU/DuUHhKmSrw2+NtthAyn4r6dwNVaMnieJJBIj/4GPsQaXLV6oBsJUsr8jJ1wSneV4RMDBDTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQHL/jBw; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so4042258276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713873054; x=1714477854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhV8sC53PuoWeO2HSJ4LPypflMXSSVbyY/ZD56aWh1o=;
        b=RQHL/jBwj0uZhjk/jROTT4fXiy5UlK0Tl2Ab2lYGLDdg8YnZyWdGp44gbyMmATvupk
         06zd3H1HHr2Lbq5EayrVZu0WkrVDBIxQ2Znq/k7zp4ZN7xcYCsXDy3vqysslC+ubFcRC
         aRATxPVGKxS4lfdDD4tDWVOPRaLc+g2VMuyJG9U4ajMCYRgqJ9NjxhHeDkXAX3mbeL4e
         kYLj5+UkquWa+agZg6NmWwxS/jPhCqWXT8utHc1NDXcadY4LkqFl6ZFgfH2SLs3Q6sT8
         1ADS1f1Bvpf2PcIW+etUbj2vfKM5fmtQkuVFgLI3v08uK3GW2xvkiKIXSbUKpl/uguWR
         Tgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713873054; x=1714477854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhV8sC53PuoWeO2HSJ4LPypflMXSSVbyY/ZD56aWh1o=;
        b=NBCRsxseBmtTvzhejl+S4F+EP65+SqSuC6UsoVJcQu3cQ/HDGsjatyhOvFsW/DumpJ
         5lMzdafyB8v3FCHRIKEAle7t4v7IyVZLcfZA/ZTe2PfwsocdLdlzkGJOfG/Egio1t8QX
         K9UmCGg8C5v7068LoDBqZZFAHGrZvsgV2WzEywuGfUQBbKv7efK6r6ZKedefh0pa16TO
         Le0pgShuXi/A+2Xgl3Tf78uSkGiqm/lyzfLMz9HGZV2VblU7HZ2MvgtUNBveSb5+j1qX
         uM7y/hcc5E0WlOfRk+qgX3qf/2sYEZiZxvePrEVZcAw2eqykjSqLsxmQiPNLJi+yBjND
         Iqsg==
X-Forwarded-Encrypted: i=1; AJvYcCWrHOyhoKkX6+IbJ+o1/7yNSiCcgwvAoZqctNcKXPzf66MmdYARb0INUykT/YjwSJbyZkcdjLaSDaBkvqjfoqXbfgE3Yb3z8L10MoIs
X-Gm-Message-State: AOJu0YxcAYiGrnT7W/dDipDbsHjp/9GH/VsoBtH9GHqJYqLwuw96tEkz
	JH67akN+b/JpHTDhgeMbjZGbRACZXpQfGOdfKd22avwGh7JbVLv/qxF4bB8TEv+jclon6cILeDI
	ElBDz3twUm0/8GJCl5lQ2pj6gqeLH58kT4AN3kA==
X-Google-Smtp-Source: AGHT+IEMnU8XNu87RAEsJ69VRL2qjj7jhNKel9ZUUn93ZhdFBWYiV+1+tARnvMwhlv0ojQcSoF2a3VXIJEXW65XJUPE=
X-Received: by 2002:a25:e80e:0:b0:de5:4b29:22e6 with SMTP id
 k14-20020a25e80e000000b00de54b2922e6mr1668265ybd.1.1713873054232; Tue, 23 Apr
 2024 04:50:54 -0700 (PDT)
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
Date: Tue, 23 Apr 2024 13:50:43 +0200
Message-ID: <CACRpkdaDmBN1kbMbbJEroN6DXPTAtkftupWrbMO_weoDF6PMRw@mail.gmail.com>
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

