Return-Path: <linux-kernel+bounces-81010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A44866EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D71B1F27393
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0F7D3E8;
	Mon, 26 Feb 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p7YTWwNA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6967CF23
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938530; cv=none; b=PYZbu0V9ymuP1vF/zc+KcUh/bUzbFbLPwqtaFVviUVAzW4CMdnVVT30NO6aWg7TKcgO9aReahSxc/DcRTm8wVRbdLIL08JXvy4mUAh6bkpxRD9YomZRMoS2SIzSwpCKz+V16ShVWRoVnOXq0vJIrw7I5cVHYdh/RqtMBuq28zNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938530; c=relaxed/simple;
	bh=EYsI1LZBbncUTAmOuyIJu18BxVT7+WsLgQQ665eJbx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEpnqtMQXX4ET5vJAoK8u0lScn6p3uqYyTR4Ica8unm+f1cWQnnnhM6LLZVGw7zL/WSc4rFM+BCsypJeezJte9tkDPhPzbK4JWUkQ7zWpOfa/Z1urWrh4O9KeJCvX6OelOOoTEa/6xRuS+t84Ldr1jvWG4OsCWZDQEMcz/gwaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p7YTWwNA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3f4464c48dso307479166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938527; x=1709543327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb7IMhmTx8i/LWrPoon1dHgEvMAM2d9dC3jvsSmDack=;
        b=p7YTWwNADtrTOtROPYHYM80rzl8P8jveEuXWbqM5Sa3N1So0M6Wzu+7M42xYiI9maT
         gQFRliPpYMg+9JvndrjlY8JUiBOcfRRcib8BSm01jJ49ah8epIzYv1OYfZ3swG00nYED
         PA1b59ptbShUi27/HtHI7+yUF5EPuL/Lho80yvRgEO+VPp+hi6664ynX7VF/P8Aigm+O
         anZL8rquabXr1QumZqSJVdp66xE0v9AwV45yenaYZpSfQCHq90xe8HV6aBOY8I2RNfee
         2Z3JgIWWQNxpzS34UVMux7c8K6o9U0fwwvQC2bRUq+eb3EFK9oHp2W6Lf4i1jUjJgtog
         ghMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938527; x=1709543327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb7IMhmTx8i/LWrPoon1dHgEvMAM2d9dC3jvsSmDack=;
        b=pCfHeh0f1J1K6TDlUtpalS0nFu+RxKRhwrBwSIGsNP07T9zCaZR9tJpguQ6rnYhI3k
         i7w9y+n5xJXpC6zIcuGRLGAnfn+D/iLYdu/CqhVf3l/QF4ZYzxCP4BAg/ED+0ZFWBa+u
         mR8ebNG5UVltizkmxAJBT6DZp3/CwQ/K6G8KzGbsqrBC6EAGwtXyoTARxGKJRHxM55Wv
         GmVUhOcnaJDz3X+rdmDlwcgTQTH7turAD3W5O2cqxdwdbYWZCDtRMUXsjpYg7j22uDec
         GTcWo/IaTHAeBfXVMabHhf7mY2z3Zy9qUK8KYmgvMA6uPm48Zx3HKmiCGRu8tiKkSWkT
         mqXw==
X-Forwarded-Encrypted: i=1; AJvYcCW3SQPMTqxQHkARjxVYHgdDPrsHllNagULsbJpbCjw3cCbrTbThvFr+h5lELUzvXIMgnqJ0ujqcod0elhey2XpzRSEY4tv+HixccDuY
X-Gm-Message-State: AOJu0YzZ9X8sJ0FeB1KyY+oc5zLecWLAUdcbNpf7HsSnw0FN2l2R64La
	cLYN5L1zjWNtYb/SGVAV1ywjYVbmufn1Tk3J1xBrkAOb/v22OivsUEMsyPA8zaI=
X-Google-Smtp-Source: AGHT+IGVsp94PJy2lJJy9tQfk213eQD624g7GpkEcfnnu1vD2Yeon47oJ/XPJ3LVLVJW8gQV50qSVw==
X-Received: by 2002:a17:906:e0d6:b0:a43:8468:ac0a with SMTP id gl22-20020a170906e0d600b00a438468ac0amr100945ejb.71.1708938527001;
        Mon, 26 Feb 2024 01:08:47 -0800 (PST)
Received: from linaro.org ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906085300b00a3fce8c0f99sm2227363ejd.191.2024.02.26.01.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:08:46 -0800 (PST)
Date: Mon, 26 Feb 2024 11:08:44 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel@pengutronix.de, linux-imx@nxp.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: clk: imx: scu: Use common error handling code in
 __imx_clk_gpr_scu()
Message-ID: <ZdxVHLce6mk975Zp@linaro.org>
References: <20231210171907.3410922-1-visitorckw@gmail.com>
 <0e906ec6-fe73-4dbd-b555-a2c03b6e1030@web.de>
 <Zb04UUeE/cU9HtKZ@linaro.org>
 <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3c05b8-45f8-4205-8cb5-3b8f2d791877@web.de>

On 24-02-02 21:21:19, Markus Elfring wrote:
> >> Use another label so that a bit of exception handling can be better reused
> >> at the end of this function.
> >
> > Please don't send patches as reply to other(s) patches.
> 
> This is a general possibility to connect an information sources with
> a corresponding change idea.
> Will the acceptance grow for the presented source code transformation?
> 

Nope, please don't do that. The b4 tool will pick up the old patch if
you do this.

> Regards,
> Markus

