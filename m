Return-Path: <linux-kernel+bounces-155409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD48AEA03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B3E1F23301
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D441413B78A;
	Tue, 23 Apr 2024 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LO3PANN1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93937144;
	Tue, 23 Apr 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884454; cv=none; b=mgmvuLBxJMapQizVnEqLDokzGs881SFp+CKPToj8FMQyYz3tYWLSPPVUxpgfXvOCDXixISnCPW9WibAkCflFPOZhWzwV4LgAgL5G1iaiBgk0JOdRJzL0Rq/Dp980d6N2qTjqwB7M6RyK2B6axiKgJfwkn9EdR8HzcovlpZzWUEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884454; c=relaxed/simple;
	bh=hmeVqi+qrZVt/f7xTxCmrGrnQQUbPC9ejTbVnnleWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P8omm+nmTUe98QJZ1C90oVpBW7uzi5/E2em4rJMwPrTolRip4uvrrhFxoYlef5U39k62SFsXdcYZ9uieJ0hBrhOXhtUXiV0TheQNSRczb61woJOJqAMfSayL7Y0q2LwBqaINIuA8XxvrWf0tibeltBWzZk5Hq0hIm7EbXQH060Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LO3PANN1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5f803c625c2so294761a12.3;
        Tue, 23 Apr 2024 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713884452; x=1714489252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2wANaF47n6On5+vFRcN7v5yzxObci+ACRKNwWYJyNE=;
        b=LO3PANN1EvwP2oyqnp2oXMCmKxY1fSKccsmZPlqO0fsqmr6yjcqcnpdxebsXNZtWzf
         +mQS05inZG1po+0QIBRGZhjHbaThyKBKGcfJHvA0cvzruXSU9YXxXWh3GLrtztj5zO8x
         fYQQj/aw72kuJb5tZAs2OYKe0xEqjGc6ewQ2mkaSJ/72OIiCFJyJHRDSfJnrF9yrTfvP
         +iuLA4dtaSrrafcpG0P7dl98ng/2upRsm4XwgoeCuxAvxT+2WcDhYsgHKMfx0O1SqXEF
         zf8f5L1XftQNauVvnIhlo5MxfpBkwXJ+5zMOri4YSwMTojE2Qc6KwW+41kvTki9z4hSb
         Mbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713884452; x=1714489252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2wANaF47n6On5+vFRcN7v5yzxObci+ACRKNwWYJyNE=;
        b=wc6LLMwPTOa/ZGSsH8AB8xJINv/1MOyp1ni/ibwI3oaFRF/cCqfQDIxsxBiynyetC+
         2ufaBuLfpXUDzS6n7PWSo+1b6XUBM2C32jS1bsf3okuAow5+8MYcWzTa566W5p8MM0I4
         wZ6kubyNn+bAyIOKZKy7j7Y2D4vOnL/WTiJEPgDfVWaPPZyvhb8tTY+zfL11Pf+s66fU
         IByU+N+XU1WlhZ7Rk4rgwDEjKc8JO+xYercvoB7sgUv3yAW0DUIm6xifW9/welOYTAPc
         uZAfcix1mokDoOYWEUcf9tPb2iX9P3nglQqoLaIRYPsj2K3raWH9g8ygvcFGjrGAL+rh
         2E5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVa+v7qhEefOlcoD0xrGZw2JIjW9wE/vn4NcvsupWpyCg3W/tMkDyo+Q1FgRht8+yrxdS9hReQM1w4xNBjsqSz/01s0RWb/75XMs05FiQgZ2r1BUMzHum0mzy2QqND8BwFLzi/C6QGSIw==
X-Gm-Message-State: AOJu0YxCzsf2x12Bof3TvcI0sFpL+lRywfKtieGtzZdvUAHxSs45YCiI
	EKK0EWM5N0IrwxnhL4oQXoId/dbweiKkK+SytlPh7CLRx7NienhxP+mD5j0iZFYfAxaL5rtJub6
	wIt+TpMitZYeN1vu2cZEmUpiPipQ=
X-Google-Smtp-Source: AGHT+IFn2yuRMGtnCOCZ9haIy6asgB1VJISBJ2JWZDYXPVjsgXUOB4wzsW1lq6qm9SIQX9IyptcD2zTouEZyB0sKEUc=
X-Received: by 2002:a17:90a:440d:b0:2ac:4c0f:a34 with SMTP id
 s13-20020a17090a440d00b002ac4c0f0a34mr13158241pjg.2.1713884451644; Tue, 23
 Apr 2024 08:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423-b4-dts_dxl_audio-v4-0-0c57eb7399a7@nxp.com> <20240423-b4-dts_dxl_audio-v4-3-0c57eb7399a7@nxp.com>
In-Reply-To: <20240423-b4-dts_dxl_audio-v4-3-0c57eb7399a7@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 23 Apr 2024 12:00:39 -0300
Message-ID: <CAOMZO5DkphPdrkQa8J0fE3=G5ia+hnSmy5W+=opCiShDiGaYyw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: imx8dxl-evk: add audio nodes
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:11=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:

> +       sound-wm8960-1 {
> +               compatible =3D "fsl,imx7d-evk-wm8960", "fsl,imx-audio-wm8=
960";

fsl,imx7d-evk-wm8960? Why not simply: compatible =3D "fsl,imx-audio-wm8960"=
;

