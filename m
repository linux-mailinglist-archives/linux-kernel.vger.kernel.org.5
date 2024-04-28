Return-Path: <linux-kernel+bounces-161528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B28B4D3A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89181F2135A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73C73527;
	Sun, 28 Apr 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqIaZeoJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26D6F086;
	Sun, 28 Apr 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714325444; cv=none; b=QmM+czafCyJd1exJcOrTkzlM3gJK9AyL1iADqRdreTv6kBLvWr7/HMYp94bz+jK9izF/7q4Qvq6LmGiXwk2qFhEeuSTFioMl+TSPywfN6YUeA6BbNcLy7MRILdMbcEYLjPv2IXx4u+2ws/gLW5TdluE1inbDKHO0KZIUcE1HC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714325444; c=relaxed/simple;
	bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4nOh5mZawDvb0BJJBdnRYuO7GYZI6ZBYkZH3nc74/+GIO25kjZn7C/oLIeSd2TCvHmXa5aFp08DiUQ/vF8/T5MCpTIMXjVVKxjKeWkkde+dL3pdELUvJlj2mQFJk2/QjImsJJngTe/43F8pcMqJCjepCjoEJJNhc1QutBaFWIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqIaZeoJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6123726725eso513360a12.3;
        Sun, 28 Apr 2024 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714325442; x=1714930242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
        b=GqIaZeoJ+L8WmspzlZM74m4dgxAoGtOv8UixRLJMpGSVfokGjl+CdZmQCjYEOlZuBl
         8TDltN0shuZcTg3/eerCnthk3gWhCfw+Q69UIn0eI5MKm44Ix4kAisY54BE3HvgWX2oN
         hNtOwboaXUufqIr9h67xhI1UFQ33NuB70CT+dCJCATz9ukVH5dcU7PjFv9Zqlyg1xDg3
         S0jQgvWTO+OaoXu3Jy9U3BvYW5Rpw9DohV04+K/vu6r31yUxns+Cai9xC93CriULY6Ua
         FwdS0nFZJIUOZi9SXTt+hl4f1rgRMuKeF4RWK4KRF1wahtPX6WBvLfciN3N/M99f+ypZ
         ROxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714325442; x=1714930242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C4iC5ro3NJyO5M+1IwRkJQ4c+Kk2vhMSEHiWNEkb7A=;
        b=OJOqfDHMDg5KYRbnnfS23HNWmFWQZ8W3UKvcmHAXZ13QKdy94/Z58n3ytDGnGdZ96T
         BDAq1spy/nD3oyPVzGg4MNVWd/3R68eNvYsbOFiaht8nfamXRV9ywC706XVQ33gtmQVu
         rQRfsv6hBAQEEXWKWZmTnt2YA1lkictkYUe3GDDNtyEw0ewjkr583nifZ+g2OFEGaVYS
         UNChN/28t1EBJE9zNUooaJnYEixIdy5Ntbpy5Pl0tfIQnpQsVp07i6WBohbhAekHjhYm
         MfkH7VF/Ayn+CHwTVk/RamH0azsJ0C/duKr0lXWBDP0f/7JrhM0aOYNa8nCoRMdMTL7t
         cCUg==
X-Forwarded-Encrypted: i=1; AJvYcCV1QXELZQiMHOfnkZRPHT+oHxraKNIRhGgDG9CI+/RvHG3ENxc5/J+IrmgVWCgfu/NwG5gN1P65POJIZWogj8dwd4QS6Kok3nqUdgpWxleql5DFE8XXFVdywGRkVZHuDb0DUiaNUgAGxya4LbMhax3eHLI/nbbp2PX9iyZztI2OenHqOFCb
X-Gm-Message-State: AOJu0Yy348kyN5QkgXszbp3nNkqlRqYC1R1FmvFNjq8Fk7yRz+jxtUTN
	mT9pEj1EtPsxGNRUImykmzTWeUrw4JrVefG2z6ezxV4MxFj7d+MyCyLuUCGYWkaDJA==
X-Google-Smtp-Source: AGHT+IEAHcZT2hqdPXrUrD9utnViKm/pFwS+gPtcpridRGIUu3is+jGvfjVMNz/1yOUWrCv/AUnT2A==
X-Received: by 2002:a05:6a20:430c:b0:1a7:73ed:7f8d with SMTP id h12-20020a056a20430c00b001a773ed7f8dmr6549978pzk.38.1714325442453;
        Sun, 28 Apr 2024 10:30:42 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id b186-20020a62cfc3000000b006ecf56cb55fsm19089266pfg.96.2024.04.28.10.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 10:30:42 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	ezequiel@vanguardiasur.com.ar,
	frattaroli.nicolas@gmail.com,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	linkmauve@linkmauve.fr,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	liujianfeng1994@gmail.com,
	macromorgan@hotmail.com,
	mchehab@kernel.org,
	nicolas@ndufresne.ca,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	robin.murphy@arm.com,
	sebastian.reichel@collabora.com,
	shreeya.patel@collabora.com,
	sigmaris@gmail.com,
	will@kernel.org
Subject: Re: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Mon, 29 Apr 2024 01:29:19 +0800
Message-Id: <20240428172919.691602-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3784322.QJadu78ljV@diego>
References: <3784322.QJadu78ljV@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Heiko,

On Sun, 28 Apr 2024 19:01:38 +0200, Heiko Stübner wrote:
>the basic problem is that exposing multiple jpeg encoders would require
>userspace to do the scheduling. Which is bad.
>I.e. all userspace programms would need to know the existence of
>all jpeg encoders and then somehow negotiate how to use all of them
>most efficiently.
>
>Think multiple different programs that would need to negotiate to
>spread across all of them in the best way.
>
>Doing this in the kernel, we just expose one encoder (and queue) all
>programs would just pile onto that one encoder and the kernel then
>would be on the hook to do the scheduling - which the kernel can do
>better (with relevant code implemented)

Yeah let kernel do the scheduling is indeed better. And I'm happy to
hear this method.

So I will keep the vpu at feb50000 with jpeg endoder disabled until
multi encoder scheduling is implemented.

Best regards,
Jianfeng

