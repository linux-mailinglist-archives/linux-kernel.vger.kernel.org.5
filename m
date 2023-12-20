Return-Path: <linux-kernel+bounces-6800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43354819DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF9F1F224F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111AA21110;
	Wed, 20 Dec 2023 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oz53QhOK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB220B06
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5c85e8fdd2dso47837227b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703070845; x=1703675645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGzQnybEjpITALdkC7450FQ/7w+Pj3xEJ4qThHlPc5M=;
        b=oz53QhOKXqFYQ58ab2xZkLD34/qXc+v7HkTYReg5NFJRmq8H5Q5efcQ3ZB2H9OWMwA
         I5iZcHDDxOcl6f1hd9Pw+w4xiD2ujPPMvwb9UVexocbvVLrgzz0GOijiYoS0Bvm7XkCR
         g0VqRBveSL0TwoGlypoJx7RGnAbRDWFyE/7BbKaLok/Q8R7yfTJXBj+ywCTKJNaElaJS
         LRF672m/JmCC05WeprPG4zzTcKL7qxpYjd9pOhKTRCB39Yth23WQ4jplO795hbmwuJDE
         msor63fDls4gdAZs1iAhAscdYcuTSzODimxN/xzuImbYhdayRsNYH30a06q1UC8YMvsF
         KPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703070845; x=1703675645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGzQnybEjpITALdkC7450FQ/7w+Pj3xEJ4qThHlPc5M=;
        b=xBmnog5f1+ArXhAKLpKvZdpQRY5orMhn9t1QgJnWzl6mlmHE2N5EbxjtjxN18ltHKT
         5r3HTo47ALyFO2Txg9XKbva7kBTETKoVYyWmuWtk5MgeXRN80hTzroHKzoJbfqAoNlvH
         Xr2BDHRAiBHtcu8/yJuYuSSZYQS/W14mS4nqDAgtaMEqhpbzyBB2J3sEDjNtX1ABecup
         O44WbMxU9r7RZhhv7KeqvSmznYJ2eL45Tgx+2rDhSvBvn2/HNOfdOAbj9aNkauZANX5A
         Wqu53AxTrjEIL2o9duS7oLnvm/xh0SrdDqtVOzd6wvFANbHqKEQWNj4ndAlnm0DloH4Y
         whtw==
X-Gm-Message-State: AOJu0YwE5azF4cnBmmlDTiv8RrHnHmN/5FgLYCVEpwV17PJrVpIIiMkr
	3oq6Y6Zf1LZULxAuVhalsHxsUg2E6640LHSvNjOkwg==
X-Google-Smtp-Source: AGHT+IH3MSI5JcPfK9BpTmnlC9yURAXkOyeyc0UvrQOplHYYGI2j2YsuaicZyb6/QMAIzZ8M42r40JYbVVdLL8idSNE=
X-Received: by 2002:a0d:cc82:0:b0:5e7:f343:2032 with SMTP id
 o124-20020a0dcc82000000b005e7f3432032mr1956711ywd.4.1703070844932; Wed, 20
 Dec 2023 03:14:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ccbffbafd1f0f48f6574d5a3bf2db6a5603fdb0.1702565618.git.michal.simek@amd.com>
 <e52a415a004e28a43e6d08e9e22d9e8fef3737df.1702565618.git.michal.simek@amd.com>
In-Reply-To: <e52a415a004e28a43e6d08e9e22d9e8fef3737df.1702565618.git.michal.simek@amd.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 12:13:54 +0100
Message-ID: <CACRpkdbso5A0muF6yqVyTquX+uPLTQCUpC0CF8DvR1_-uU0frQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: xilinx: Remove zynqmp_pm_pinctrl_get_function()
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com, 
	git@xilinx.com, Arnd Bergmann <arnd@arndb.de>, Dhaval Shah <dhaval.r.shah@amd.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jay Buddhabhatti <jay.buddhabhatti@amd.com>, 
	Marek Vasut <marex@denx.de>, Nava kishore Manne <nava.kishore.manne@amd.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:54=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:

> There is no user for this interface that's why remove it.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume this will be merged in some other git tree, tell me if it
should be merged through the pinctrl tree.

Yours,
Linus Walleij

