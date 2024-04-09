Return-Path: <linux-kernel+bounces-137495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B589E2E3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9F51F23A6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BA7156F5E;
	Tue,  9 Apr 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvbZFIt5"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4786D1A9;
	Tue,  9 Apr 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689360; cv=none; b=tVZsBV5/V8iUHixGAlsQEbfIuw83cPl+909qeI2putzfICEZA1HoicYBejvFqsLhodio+F+VjiSPk9m2zh9fHTtQfcHdHTskr9LWgUdCsswtXrJ3fPZpSwidPqMASiK0yz+RvEUxXh7TWxk3CQ6Dy+PHgJ59TddVbRG6we3i8R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689360; c=relaxed/simple;
	bh=o7hrAYi0nJ4UnJF9L0FefbB+dczQwLGeHO4S3Tb5hGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cAwt4jwujhcrVoTWX3nPllckMoiDRYwDbbHp13Ox3fmxjzVwpDU3O60iBFTUQymZHTNHhBCNcwyo61oadzRAM70rvf6d4RarA/14GVAaouWRf8OXI9LEZM+BqwD7HFVKLhfiVTwQRgGwNFyUZWuL2wzVq/EIUCBdc9RI9RKWN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvbZFIt5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2fbbd6cd6so1496612a91.1;
        Tue, 09 Apr 2024 12:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689359; x=1713294159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7hrAYi0nJ4UnJF9L0FefbB+dczQwLGeHO4S3Tb5hGc=;
        b=hvbZFIt5DDJhaDCWGiJNMOxd18XWLX7Hsf+VKVsEtMZtVtIu/iTdbu8Ph8NDtsEQna
         J1LnsYsPPGZFmz0w+4rlf5WaTy+LhCPlMGxdoqMb19SfyS06J/RjlRzmkN5S88e7Bc6q
         C2lNMGNPUFOLbqI9t3nVUaNt9NYUzxOk0B23ymCxYM2Mh9Q3DoaK/TSCInfbpjs5JKou
         84qoQdZNxq17KoTybgREvFaBTSGPD5HWiu6sCyrMib/voiJWSLq1K5yil+320BSnTOo/
         ud3AXBBe4oAE3gLYlOgpkGcFMKuBl1TpKTPXAprt/4DEVZKxssTvVQ4z1DbsCfbLrWNX
         q4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689359; x=1713294159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7hrAYi0nJ4UnJF9L0FefbB+dczQwLGeHO4S3Tb5hGc=;
        b=FWclGBd+NnoK96FGUbexm6K6nVmWjhU0gc+Ju4tl8aqaKIXRT/3D662y8tXpxLdAms
         iMR0d/o8cQWVamQpH5yrIRqRI4Tl9lUQo7OmPwlXeFcbD9W30XDW8s/PnZbk3PovOXPw
         j7x90ALPF7gulrPL5Irr0XK3DdP/4GxE9+PdHbQJxj0nqPbn32FvN++Yrjm98S0E1WwD
         /3oFvP2VXUNMDoZhfMO0aG3CWPyx0T+h7tt5eSFYf/ieuo9PbAF5gUCxxJxePz1BPnUR
         LcBTvbfQ1i36+Sguk78B8Sq2Ag+HLjdouPY0fYVLbM9GNPRSFDebFWSaNLyQ+5dEBJAs
         jW+g==
X-Forwarded-Encrypted: i=1; AJvYcCVNWtPRINKyZHMin7Xi8Nyb/5byPLo2wmEjk+Fw6ZXRr3NiOhiIoXtR7GVnWvZOFpFj3amiwMz5bhuaSNkqRRhhnqjkex9rmi7S3MhummpsNWTa6ZVmz+CeY9UVb1ePjTqEdbF55zSD1wW1sVYqnwtPtR83IaIBcs6CZJsYdARed1Tr8ytv
X-Gm-Message-State: AOJu0YznMJxZP0wF8iPeDgPCAb6IWvX9v+qTYziZQ+YH8N/cvxSwvKd2
	8GANQL2J0LPpRnBj8qp7trgVDP6A+VhMXNy08yP2pzriHtvvkw8UveMn2wlr8F5xjMAaYwlDHYg
	w3+fZw8KBrh9qs/PoBV9sQvT6GpA=
X-Google-Smtp-Source: AGHT+IHyUGvGakm/GRDqNPY/mi72SpILHWwbXaseDKMv1qwJ7UytV8j+qA+cMOhsqtA59ecW62tNo+SkRqsULw0+FXs=
X-Received: by 2002:a17:90a:550b:b0:2a5:395e:8677 with SMTP id
 b11-20020a17090a550b00b002a5395e8677mr519798pji.2.1712689358793; Tue, 09 Apr
 2024 12:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145406.2613256-1-Frank.Li@nxp.com> <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
 <ZhWP+Cxy9yMAYXJC@lizhi-Precision-Tower-5810>
In-Reply-To: <ZhWP+Cxy9yMAYXJC@lizhi-Precision-Tower-5810>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 9 Apr 2024 16:02:26 -0300
Message-ID: <CAOMZO5C=AQOBkOwMBjkgn9TbQ8242Wj0AEHRJ0j_1=N8WfWYRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt
 to yaml
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, 
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 3:59=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:

> Yes, I run dtb_check for one platform. Which dtb report this warning?

Try imx_v6_v7_defconfig.

