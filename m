Return-Path: <linux-kernel+bounces-86763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A839586CA69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58910284CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F8186241;
	Thu, 29 Feb 2024 13:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7PLT07C"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5137E599
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213848; cv=none; b=ZCTveTBpItXne2ZtZZ7AVOijsVzvJJwPd1ctivfDJSsG2tIAuoct83GF+GS1Vd1jDsV8uM1hd34poKZVn9cS9cVE9D9DHpjOQiCDy+xPcRcMhmcByeN9alRF2bw7CbszsGoB2k4/lI2PhoMVmsPiHn2Q0k+ddmQoRE34FOC2llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213848; c=relaxed/simple;
	bh=jRIC3inpQYVl05aLG7u0tOU2SIStN8WcCQsGMVDW6OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwW36ylA0z3J0bjUCCxrKZBvKbmT/sLGNw461ngHdgahAN31MCo5/ERHFb4xyEf4BWEiUNwGTmP4zw/XGp2PpMEjBJU4s3DBqMxDgKqp+IdoabzML5ecpLkSfAvRZbPyLpJhxWNLrmXKTsx9gXm+hH7ynyglBZ43vCWMmhIM0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7PLT07C; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1011726276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709213845; x=1709818645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRIC3inpQYVl05aLG7u0tOU2SIStN8WcCQsGMVDW6OE=;
        b=F7PLT07CUmWk4tyrAfO1wpH6n1+QyJLoTISpZvypmFcFhldNT9lXL5ldbg2s5xOG7V
         Prm7i+RozSXzpoGxtlScnCDCGOh/K+JDpzOkQMxK/K/WiIY88gplfgzdodXTHHZ89lvu
         SZj68SX21GntFy8YZKPbZEgrevekkjVAYa2g7CpBv0LHOj3Ni8viSKpOn+aTPBjW1qI4
         moMnk7fldk3XUrfDU08zsQSmdIkWydaEOHZH0Czy6kPIbMwr16JjuBFGNhjTGQw/iEgi
         dR/OndMhh8MvweWVYdvbOQvA/hwt7KwIanTDUnrqqIWaMY3T8Ci4YXW4IMVUYLOJ9wEy
         0lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709213845; x=1709818645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRIC3inpQYVl05aLG7u0tOU2SIStN8WcCQsGMVDW6OE=;
        b=wy2mIZ/I0CD3RoUu2E2CHxloDqy7FeRfbm3fai5fTMG5rI3ZK57cBVFt6po5px8noS
         6e47ZFph6jouGEixOPqL05wAY1k324zt1FbHXZpaTpATSMKK00GyZ05MhBxWCOsqr55u
         CLCM2rlAVjp2AS/SPNjPW0RPJTUyifaPzzryi0NxQuKlAT7SDXNBvFxvZnLUdE+O0wfs
         vCTDhtnUbWfX86SeAiR4EfDfTrR0GZcKQoPwXZ3KbsLOgeNARU1nPPqlaMQ4qAKYfaBy
         cYxMNzOdL7+OPppTynEXe7vwN/+nsrRAx158mlCO0FcUMYiKUJlIWtflel2wxiB3fDJR
         De0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXX6rTi1Wk2ZfNELarD1/m4a/Xotsroks7uFUFS1ByJQbhpyQpLlmXGVWRoIW/3b5FNlkJV0Kpe/tMtkir/H+vYexkwmaUCi4ri79+/
X-Gm-Message-State: AOJu0Yza2NZPHLtoFCY3QbeWxU3tc3wZwyMFzSn0uoe84pGalfxXsJIQ
	kuN8yIkhwDdIqpPHIQKGdBHqSgOfKFQXHrioBGGNy9SxCeeYnUOuwIWEoYbS+bg9v6v2oI1tMIa
	Roa6e2SCr5AB1M9QLbT4E7NksKDLaSa6JRIb9rw==
X-Google-Smtp-Source: AGHT+IEMh6s/EUM+PFmpWfZpJLi60H0JYBSs53MwWi3aRXQ1sYvHhKkVKi/rHlsRVf1EVaybg37zMg1n7n9kjEny9V8=
X-Received: by 2002:a25:8701:0:b0:dc6:c510:447a with SMTP id
 a1-20020a258701000000b00dc6c510447amr2201760ybl.58.1709213845284; Thu, 29 Feb
 2024 05:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223123214.288181-1-brgl@bgdev.pl>
In-Reply-To: <20240223123214.288181-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:37:14 +0100
Message-ID: <CACRpkdZ3fFS9yCRkr2iO2=8ftRDs-pVdArhScY6Fse5e6SmPSQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: don't put the reference to GPIO device in pinctrl_pins_show()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 1:32=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The call to gpiod_to_gpio_device() does not increase the reference count
> of the GPIO device struct so it must not be decreased. Remove the buggy
> __free() decorator.
>
> Fixes: 524fc108b895 ("pinctrl: stop using gpiod_to_chip()")
> Reported-by: David Arcari <darcari@redhat.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied for fixes!

Yours,
Linus Walleij

