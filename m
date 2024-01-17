Return-Path: <linux-kernel+bounces-29440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDE3830E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B185B213C8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC4F25547;
	Wed, 17 Jan 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZBuseg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FF250E8;
	Wed, 17 Jan 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524853; cv=none; b=AejrSVm9cMokZ++BNve8HMEGEht7smDbPZxXyGhLiNcB9kQJyI5Np5QpxQIzjqOkKroRbxpWJK11y9RT5kTRpjifv9lV8u4JCk+MucIiS8Z8VR0X+BRAGYu1jIY7gtccpJtiav4T1C6u+8vfVYNCAJNbdyQYumJinMsEzVUyh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524853; c=relaxed/simple;
	bh=Gvb0ALIs32Uhtesp9BbYxYVqNhkSwokGRm9LkLff6DA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=gVHfvpieTdR4UT55d5Ts8cG40w1Bh6oTMS0aGtl7R6bXejwSRGg9G2D36fI0RFxgn83H/bdhDRq1KhsMlo/1A0o//sx1Di2vSZMc8Hm7H874bG5gG0q73e5umCK0rxWch17DHdrKnTNGimyiYnN55koO7bLkD3pS4XTokkpH7W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZBuseg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-557ad92cabbso11618622a12.0;
        Wed, 17 Jan 2024 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705524850; x=1706129650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvb0ALIs32Uhtesp9BbYxYVqNhkSwokGRm9LkLff6DA=;
        b=LnZBusegOzr09qS3GnSonh+yW8iLaFf1+Z4UpDeNe8w6oRBNOiLjIYwk7VUFWh9h9W
         jntULaMaL6KZL173j9bUQTXsvefnKybNDsr+fTmx4cr7eYON9Oy5x5sXHitSVsjhvvkX
         LP8oc52EpsHRvPu7GhWQqRkk9kKGXvFev1Jq60DUjUWbHvuJvR2ITfd6hxKF/LKVdEAa
         vV/ceSEYHUpsN7tgeBriKamb7nK4qiRO19nOXRe2VoBJeGhYcbk8kDvQYnstp+pC/vgn
         yPd3e0l56vZGg31FjPosdO/TaqLa2c/ZzuPlh0nhVXb+BQJB71KLaOs7MyA4UP3BXKbR
         BC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524850; x=1706129650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gvb0ALIs32Uhtesp9BbYxYVqNhkSwokGRm9LkLff6DA=;
        b=oQ0Oiays/dgGEl/F6OogXATzw74ZnkSAqBSNqMHfk3xXlX1Yptn1eWDUVYJa/SDq8r
         MeqY/xj6HLkABnmgZN8KiqPoSWvNE3zxxpgqSw3RIpLFd2SeueG/sBjTX5l2u2P624ov
         tSZVKyxbh54I2KbIKYWtQrKLL4+ubXMuueD8SBzcbR5CdZhAsxD9S7Oz9i5SvDwOP6yJ
         8IVFxB/d1oSF5DF9eRVYjDNCNADwShi6/E6a6uEOwm6ibdadfOpI/fd+/X0WPX94LuOk
         2EqOANEWGF7bg1DKxyt8S0J3btKu1i6+omSucUGnzlAQJpbVRwt1BbG0TyvperFmoHat
         5SdQ==
X-Gm-Message-State: AOJu0YynAktft0yDPMLivKWRkEQkOgnXxmBSxcW1MVskuJXbjvgzMEl6
	AkuKzIIrX7+1RhVjcGdk9xGBBUuz8x0s6BxTADE=
X-Google-Smtp-Source: AGHT+IHu/d6LG6bzL5O6GP0Fb7oK+rmMYDeJxjv+aom8dzUkKP10RwWSxI0lzlcrH+69uH1H4AqAQZ4xROuYMS0Rpuo=
X-Received: by 2002:a17:906:fd81:b0:a28:fb94:b773 with SMTP id
 xa1-20020a170906fd8100b00a28fb94b773mr3225489ejb.223.1705524850520; Wed, 17
 Jan 2024 12:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117094453.100518-1-hector.palacios@digi.com> <20240117094453.100518-2-hector.palacios@digi.com>
In-Reply-To: <20240117094453.100518-2-hector.palacios@digi.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Jan 2024 22:53:34 +0200
Message-ID: <CAHp75VcDXPmoiS_KzGf7mRTSOTy1sj+bY4rd3eiKtMyH8-QDHQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] gpio: vf610: add support to DT 'ngpios' property
To: Hector Palacios <hector.palacios@digi.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 11:46=E2=80=AFAM Hector Palacios
<hector.palacios@digi.com> wrote:
>
> Some SoCs, such as i.MX93, don't have all 32 pins available
> per port. Allow optional generic 'ngpios' property to be
> specified from the device tree and default to
> VF610_GPIO_PER_PORT (32) if the property does not exist.

Same comment/Q as per v3.

--=20
With Best Regards,
Andy Shevchenko

