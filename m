Return-Path: <linux-kernel+bounces-46915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEC844653
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C7DB238A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740912DD9A;
	Wed, 31 Jan 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlJJHXig"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879512DD8C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722783; cv=none; b=WOqrjZ4UDMHiMQ70EfrkpnsK3Af/sQxfVy93JozAufr+HeduHqNx+k1QVtgYmFARPZ17Ztjm57frXCT/zI4SmHQprHNXbUBpTXupk7eTgFkFUpLiE7RgrNjR2GaIunuW31O8dy1XBoXZGgRPLT8hx/71+VgyLL2y/3RKlQ6fJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722783; c=relaxed/simple;
	bh=Wmr6FwUgKE8e2RtVUlgvM+N2G0P0c9ELvtsRNvj36p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ff8cA7WQqkXlxm+BNl9o0aKHb2MwtdJVVzbB5JHwlxDnw8GIUAp2qKGzwsRXZN8AiJ/p67EBhxqeEerDgA1oANu08jnYAcL6iCNJ67qlDqieDfDqx1cQiQW0wNR1G4G4UCM/xXby5OwDK7R+VV0uRQ9wa1lPbedljdd7IeUNoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlJJHXig; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6040d33380cso71487b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706722780; x=1707327580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wmr6FwUgKE8e2RtVUlgvM+N2G0P0c9ELvtsRNvj36p8=;
        b=jlJJHXigVIcPFK7gTRT8HMuvAeP55PvCoSx0RKQLr8BAFVxhwtTFBl3EsXDXJFzasl
         yV1ZCc+WU2XU+YJrKnnvJmFaoXw0q65WAaVeCFyo8uORpX/98UveRSRV4FkP6UY9+wq8
         7C0eOLc+eMI6v89o01764spa6Vm8QOs9SkTgyT9T+EW1WelhtdgJdaR3S1RolpxQTYdO
         5i2d03qdzqdRXngsyRrLyKo3hZ7HWhtwcy0dlJO2KQYOiZ3ma3glMik1MFPZIJ6ssHDP
         Sr/1mv98H9Za0FCEWomYBb25tZXBf1KA87KQaqrBOgb3oRtuubxdSg6WUTTB8LsP5YBU
         rSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706722780; x=1707327580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wmr6FwUgKE8e2RtVUlgvM+N2G0P0c9ELvtsRNvj36p8=;
        b=OUBMzjPN55WwyFgXRe3gayTm/qg5rS/3m0bf/bxUgubXEsYdwovAegyLMVqyMXSonS
         j3x2E49TOumULn5K+0+bQswJLi/36mRmLnLsRU+uBo3SfuAlkxb4v3rUgnHiZOzn9jED
         w7pCWzcI7IHDZVJ/1R65qdmg0CjPQrlQpzl7fPZRIy7s812Rivto3ixfF1ME3O3GwoHj
         ggjXe1FJP0gJjYztat2khLcibsfYEludTT1aWrjqVveh7BMG8X4VB8ggzEQsUjXUP5iq
         kkNaZKg84+QCOBNxBHPwPX3Y5SHTVv4P+S0rEvN0JdMg3RHcucjwCQo33sBFc9t3b2eF
         gE1Q==
X-Gm-Message-State: AOJu0YyWKLq+RNP71guSh3YJaFfXMPUJZ3XiWIThZTYOhcc5Nkp6GQA3
	wIBTCOIG7jvsq0aMGFHglYkOV137gj51ij4PsPiltsrw5fPHKJ1CiKQoT+sUocOC6HQELmV4ZkU
	auanXNzZRSa4NYYzhNb+JeIhy9AAEzVermldO0Q==
X-Google-Smtp-Source: AGHT+IHe6uZTnZBFqy29JxxD8jZ18K9pm4CFaqrzg9KcFhM7UsJcIsDHdUFfaVm5bEAJs/0FTd3gLJSWuL2GLPeEcmc=
X-Received: by 2002:a81:4318:0:b0:5f7:992:b018 with SMTP id
 q24-20020a814318000000b005f70992b018mr2190237ywa.5.1706722780568; Wed, 31 Jan
 2024 09:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-4-brgl@bgdev.pl>
In-Reply-To: <20240130124828.14678-4-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 18:39:29 +0100
Message-ID: <CACRpkdY_9=2Uqo9=ZEDrn+RFGdPkq73ZRYLVCbh6BLMzU9LZ_A@mail.gmail.com>
Subject: Re: [PATCH 03/22] gpio: remove unused logging helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The general rule of the kernel is to not provide symbols that have no
> users upstream. Let's remove logging helpers that are not used anywhere.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Seems unrelated to the rest of the patches but OK.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

