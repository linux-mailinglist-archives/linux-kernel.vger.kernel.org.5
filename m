Return-Path: <linux-kernel+bounces-98838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3087801D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17A8283E60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30D38F87;
	Mon, 11 Mar 2024 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBCNLZYU"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8E3D54C;
	Mon, 11 Mar 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710161025; cv=none; b=Q74byKWNY2c3XJotx+wyrO9tcFXD+y3n7f4sHhU2gI/BRNkQBcfDJs+7HXSvt5Uy0Bkd+rzlYJfP9NPdQs2jo51aNa1+xU4lZ+I4yj5vNj+892vb9QHzdJ6jsZUVRRn38cBgk1Cmw/F1PnMPd5F4nZ6fwcuCuYpQk8wHZ8AVUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710161025; c=relaxed/simple;
	bh=7rkxVfWdjgxeUXlDYAl4GqDBKvIzQvzh/NeCtvyEiWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Upx8Y6ePfP+T9tpBMQRkPHydJQSDrHyUeW1Yho6yzfkYP6PZZEoIRFWwiNFNMGv0TwmRSEng1Zae4UeUqz71lJZ8GwU0g9lMwlvKh+b83qPWlQwbpz0ibUXyOe7uXnw/EXFhwtA3LI/vO+Wofo7uMFwfcRxj19JRRdYw7SAyAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBCNLZYU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e693adc8a2so88136b3a.1;
        Mon, 11 Mar 2024 05:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710161023; x=1710765823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+eKmG5DRWeq8jWjrfLnT4GR8dOlHkf0y/wIX9CpqgU=;
        b=HBCNLZYURWn343T5fx62iuxfuYghxyGaangGozMGsyxj+Qz2dN5ynZGMZ5KJbPLWPr
         Z15RGTZQOTxk1utCJt+whapFB0r1sS5dRKoCjfDJ7bgkuGEpneWfwfSvAdcmTldhgu4R
         d7lsgp1FwT3oOgNcZBjm6tKjdHLFqz6GZ3QIjHDbFSiPAOMnHSz6L8D+hnbaKYhdSE4c
         weuHdF4bAls80Z5tp51l+1Gkmdf0HRTiUGSLFNIGzOui141X5VyzuIU6AIyr3/oYTtQv
         fM2Gy95N+L5FQW6xrpGBKqmKMaUzLjc3jCl08uT/Wi3hnGaMifSTmTtTucuKl47meBTg
         eRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710161023; x=1710765823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+eKmG5DRWeq8jWjrfLnT4GR8dOlHkf0y/wIX9CpqgU=;
        b=h7WIJJI38gfOllqaTFwM5xYFusopllKx+747GXZTQdVjAXSO9ej6KNvWyCIkrpXJzi
         s0XLfolUxkfHaJDvEPNfX+JFdij9eCv79l/Qv+/aqVvRovB6qXC6FuMPNjRWmcKx3dNQ
         8NRgP69byipAF+RFV8easfL/9738fzR1UwPk1Oi75JHwBkIU+fH+pdYZLCtBtSKouqoA
         A1b0A6VVm0fT3pS5dRpF5XMEZSfmBLY4z2oI513dx4KcV/ut7RJY1GKZKFtZBJfkcv7B
         xHmtXXoI4awk9TgGHNpZgebA/gqAdoVRjEB84q4M8jkR7yfgQorc6BRaqJyW4rc8Bnii
         QaAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvho2iSVhxYnCqFfrYxCva0o/NMoKO1rJ0kriVjrZIkl//iOhoEHk9qBYaC2GPIUIy0ScMAKpLYWrzR8SxO6kCdoGYuUgI2KPNScE6XkMRoog7S27LjLlpyJ6+M5EVTgPqofel5WvcWw==
X-Gm-Message-State: AOJu0YwQ4V7P6n4tDBRz0kybk8MBo7yukLX2wNrf63j7LcGPrf1ZdF3a
	LQAPK7v8D2t/g6El/8X1y/ENUfvBIzLh7/jEB4Jv1c6tCDRJf3i9gFX+cMk6TPYzPCSeZ0WFH3r
	9TCPYS/XoppAfoknzDVnd4xyggYc=
X-Google-Smtp-Source: AGHT+IGELvIZKO/o+82ukdl6Bain1axvAR43a4fG9E+vEyKQOeZMQ2KPK/HHkku1vDElCvf6wbHLc1esaxIl4xs1t2w=
X-Received: by 2002:a05:6a20:9f04:b0:1a1:42db:9c5a with SMTP id
 mk4-20020a056a209f0400b001a142db9c5amr10364781pzb.6.1710161023346; Mon, 11
 Mar 2024 05:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311113201.664252-1-joy.zou@nxp.com> <20240311113201.664252-4-joy.zou@nxp.com>
In-Reply-To: <20240311113201.664252-4-joy.zou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 09:43:31 -0300
Message-ID: <CAOMZO5A_5mUgEL6MvO=D1RS9aT-DFc8eGiF7VDCZqeSkYtGYcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
To: Joy Zou <joy.zou@nxp.com>
Cc: ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	linux-imx@nxp.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 8:24=E2=80=AFAM Joy Zou <joy.zou@nxp.com> wrote:

>         /* need to config the SION for data and cmd pad, refer to ERR0520=
21 */

Please remove this comment. The SION bit is set for I2C pins.

Also, this erratum affects uSDHC according to:
https://www.spinics.net/lists/devicetree/msg641846.html

