Return-Path: <linux-kernel+bounces-145313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247D8A528D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C608C283B06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9B474425;
	Mon, 15 Apr 2024 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYy7YDQ4"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26873189;
	Mon, 15 Apr 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189675; cv=none; b=dG8Oky7s2knWYGRKj/Fif93wlVtGclnJrhfowU+usyd2NqbjgNm901oj+bBTq1U+80ilR483qt/mt+cwprGxHha5aU8wxZki8+NpX38NHEN2RymONNBqdPXu05+e8xeSQvsYu8PcLh+Gu4fFURnWIFxJkUxwJIjf8mBIEaMfKPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189675; c=relaxed/simple;
	bh=lpBPkRDdCzQNZjrZ+c7eHd34o93n0pvgK/Pf7ypBlwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALRhmPXjajJNctqOiAWAC07ByQ3KWZnyRcJ2ArhErBRtdCrFyBE8SxN0jBpuJclX7q1UCxeaZUuYLAqioNRnLkE9zarTtCdj5lvhtezz+jWeB2Xv3RkbMF1h3B6Hvqyhb88b3SNEVQWxG+2sj4CjFYZNW/uieMwTuthI7yofDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYy7YDQ4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-570175e8e6fso1991071a12.3;
        Mon, 15 Apr 2024 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713189668; x=1713794468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p24MW4lT8Qhns1Y9ZBylqR7BJKJfhrh/oDdc/sbfEQk=;
        b=YYy7YDQ4ruW5DHpniNynHooTjnzHWdQpQJLKOP93yhJyq7ZSK1lguAXFxIGzSq7Tsl
         ptEjrb15JY3BZJjco7y/jbqs4kBGBd+ZH4uePhscuD3wvzeRnc4aizIoTuHB8W2ARd7K
         GJJkaqTra80UR5vMLcpyGf4ag09OxG3U+P5v3DWvJhSQbqh812o4vVB7p5Rn42VVsvbE
         iK/DK3AFeerzGNLS/DN+g0cs+ctyfTh4Gi2BaOGU2YTqPJj3/NPvnZYNLcSkSUKsx7p2
         wo8QPSwbjH3mF7CRLR5bAqqPzZuqb3AkZk0q94earTjvfwD6E3Tl8qE6l5pav6zsze0D
         uNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713189668; x=1713794468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p24MW4lT8Qhns1Y9ZBylqR7BJKJfhrh/oDdc/sbfEQk=;
        b=Dmuz3BcfW93mDntMQ86WIJkJOP3Xafq/Oz4IMFnUp+MVTC14BQm84z+q/lva/iCb9a
         rpB+7xat+VcILl1rP846FHyXWMkLZ9r3ndcblSxkz5t361z1tEewJpcxxHiikZw/EFI5
         aQc3EPBNRnFm0g+fSZ8aB5+bdE+9kRgiVVE76XzToK8h4ZJP4CH1NaxoyAhFmXNpOVeL
         9/03cQC/JDWbkAkCAokudOJZLPqio7q0ZqHSBtVxWkWHGEdZFovYmC7ucDFmNU56yaxx
         RwWLr9rYhe3BBjxXWSGueuSfJxuMo0nWGNQvkNUXc6//+sJh4FiJuzAuAFLtBkBVz4eA
         Hb1A==
X-Forwarded-Encrypted: i=1; AJvYcCU1yX8UW6RUZdPZbP2AZY9Yvf73ljjFgnH0PkA2GGgvbZlskk+dP4Z6VOPbssXKkHtaQGh0KZmSxS0MVpPv2ipoUes7BIVFEC495oWPIjte616Yj0pzUBRIb6NtXYpGcS3XvBBHWk8AVqaVcqG9pYnIKo/oDyP17ToasIqXJ9BEVZHJW90=
X-Gm-Message-State: AOJu0YzlBJMcTsa/MPchpxgtkjSRRbogBRpEL0L4HbJzBQP7hlnz3SPY
	+H5Ftun4oh687MIImh+BvTxyZOrbB4EkdmEYnSEu2Bmu1bK6AJvhWEp+o8Z+zBF3PX51k9Czzw3
	vq4Bhby20paF1zDH2udi1XoOOP2w=
X-Google-Smtp-Source: AGHT+IGC1BfZnQLhZFzAUp5MFPYOAUjH5/+Y5w23zzmSabgzkZplX8A2dmV0W5bVlElQTHiFmOsGdVmTzH1nBpvI8Ik=
X-Received: by 2002:a17:907:b9d5:b0:a54:c130:21fd with SMTP id
 xa21-20020a170907b9d500b00a54c13021fdmr983688ejc.13.1713189668195; Mon, 15
 Apr 2024 07:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-pinctrl-scmi-v10-0-59c6e7a586ee@nxp.com> <20240415-pinctrl-scmi-v10-4-59c6e7a586ee@nxp.com>
In-Reply-To: <20240415-pinctrl-scmi-v10-4-59c6e7a586ee@nxp.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 15 Apr 2024 17:00:31 +0300
Message-ID: <CAHp75VdoaL-66vDFeDWXg5V0XnL45F_JQZ_BNeaaOcSwQz5gnQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:43=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCMI platform firmware, which does the changes in HW.

Below are some cosmetics, but in general LGTM, thanks!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

..

> +#include <linux/device.h>
> +#include <linux/dev_printk.h>

The second one is guaranteed to be included by the first one, so
dev_printk.h can be removed.

> +#include <linux/err.h>

+ errno.h as ENOTSUPP is defined there and surprisingly err.h doesn't
include that.

+ mod_devicetable.h (for the ID table type definition)

> +#include <linux/module.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>

..

> +/* Define num configs, if not large than 4 use stack, else use kcalloc *=
/

kcalloc()

..

> +       ret =3D pinctrl_ops->settings_get_one(pmx->ph, pin, PIN_TYPE, typ=
e,
> +                                           &config_value);
> +       if (ret) {
> +               /* Convert SCMI error code to PINCTRL expected error code=
 */
> +               if (ret =3D=3D -EOPNOTSUPP)
> +                       ret =3D -ENOTSUPP;
> +               return ret;
> +       }

It can be split as

       ret =3D pinctrl_ops->settings_get_one(pmx->ph, pin, PIN_TYPE, type,
                                           &config_value);
       /* Convert SCMI error code to PINCTRL expected error code */
       if (ret =3D=3D -EOPNOTSUPP)
               return -ENOTSUPP;
       if (ret)
               return ret;

..

> +       ret =3D pinctrl_ops->settings_get_one(pmx->ph, group, GROUP_TYPE,=
 type,
> +                                           &config_value);
> +       if (ret) {
> +               /* Convert SCMI error code to PINCTRL expected error code=
 */
> +               if (ret =3D=3D -EOPNOTSUPP)
> +                       ret =3D -ENOTSUPP;
> +               return ret;
> +       }

As per above.

--
With Best Regards,
Andy Shevchenko

