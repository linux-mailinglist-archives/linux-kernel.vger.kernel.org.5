Return-Path: <linux-kernel+bounces-602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96081436E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2DB22235
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81912E4F;
	Fri, 15 Dec 2023 08:17:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8C111B1;
	Fri, 15 Dec 2023 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 569D17FE2;
	Fri, 15 Dec 2023 16:17:29 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 16:17:29 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 15 Dec
 2023 16:17:28 +0800
Message-ID: <1c26fe9b-20f9-4b03-b263-ca030d20a5ce@starfivetech.com>
Date: Fri, 15 Dec 2023 16:17:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] pwm: opencores: Add PWM driver support
Content-Language: en-US
From: William Qiu <william.qiu@starfivetech.com>
To: Rob Herring <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>, "Emil Renner
 Berthing" <kernel@esmil.dk>, Thierry Reding <thierry.reding@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Hal Feng
	<hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
 <20231208094209.1910934-3-william.qiu@starfivetech.com>
 <CAL_JsqK8fsAocOu3OBdz1kzNiApf1J0Uc0spn8gfdJaVnomFHQ@mail.gmail.com>
 <62bb91ad-5d4b-4ec6-80c8-6c3edf5d25cd@starfivetech.com>
In-Reply-To: <62bb91ad-5d4b-4ec6-80c8-6c3edf5d25cd@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable



On 2023/12/13 17:27, William Qiu wrote:
>=20
>=20
> On 2023/12/12 1:41, Rob Herring wrote:
>> On Fri, Dec 8, 2023 at 3:42=E2=80=AFAM William Qiu <william.qiu@starfi=
vetech.com> wrote:
>>>
>>> Add driver for OpenCores PWM Controller. And add compatibility code
>>> which based on StarFive SoC.
>>>
>>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> ---
>>>  MAINTAINERS              |   7 ++
>>>  drivers/pwm/Kconfig      |  12 ++
>>>  drivers/pwm/Makefile     |   1 +
>>>  drivers/pwm/pwm-ocores.c | 229 +++++++++++++++++++++++++++++++++++++=
++
>>>  4 files changed, 249 insertions(+)
>>>  create mode 100644 drivers/pwm/pwm-ocores.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 788be9ab5b73..7a11a22da09e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -16204,6 +16204,13 @@ F:     Documentation/i2c/busses/i2c-ocores.r=
st
>>>  F:     drivers/i2c/busses/i2c-ocores.c
>>>  F:     include/linux/platform_data/i2c-ocores.h
>>>
>>> +OPENCORES PWM DRIVER
>>> +M:     William Qiu <william.qiu@starfivetech.com>
>>> +M:     Hal Feng <hal.feng@starfivetech.com>
>>> +S:     Supported
>>> +F:     Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
>>> +F:     drivers/pwm/pwm-ocores.c
>>> +
>>>  OPENRISC ARCHITECTURE
>>>  M:     Jonas Bonn <jonas@southpole.se>
>>>  M:     Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> index 4b956d661755..d87e1bb350ba 100644
>>> --- a/drivers/pwm/Kconfig
>>> +++ b/drivers/pwm/Kconfig
>>> @@ -444,6 +444,18 @@ config PWM_NTXEC
>>>           controller found in certain e-book readers designed by the =
original
>>>           design manufacturer Netronix.
>>>
>>> +config PWM_OCORES
>>> +       tristate "OpenCores PWM support"
>>> +       depends on HAS_IOMEM && OF
>>> +       depends on COMMON_CLK && RESET_CONTROLLER
>>> +       depends on ARCH_STARFIVE || COMPILE_TEST
>>> +       help
>>> +         If you say yes to this option, support will be included for=
 the
>>> +         OpenCores PWM. For details see https://opencores.org/projec=
ts/ptc.
>>> +
>>> +         To compile this driver as a module, choose M here: the modu=
le
>>> +         will be called pwm-ocores.
>>> +
>>>  config PWM_OMAP_DMTIMER
>>>         tristate "OMAP Dual-Mode Timer PWM support"
>>>         depends on OF
>>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>>> index c5ec9e168ee7..517c4f643058 100644
>>> --- a/drivers/pwm/Makefile
>>> +++ b/drivers/pwm/Makefile
>>> @@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_MICROCHIP_CORE)      +=3D pwm-micr=
ochip-core.o
>>>  obj-$(CONFIG_PWM_MTK_DISP)     +=3D pwm-mtk-disp.o
>>>  obj-$(CONFIG_PWM_MXS)          +=3D pwm-mxs.o
>>>  obj-$(CONFIG_PWM_NTXEC)                +=3D pwm-ntxec.o
>>> +obj-$(CONFIG_PWM_OCORES)       +=3D pwm-ocores.o
>>>  obj-$(CONFIG_PWM_OMAP_DMTIMER) +=3D pwm-omap-dmtimer.o
>>>  obj-$(CONFIG_PWM_PCA9685)      +=3D pwm-pca9685.o
>>>  obj-$(CONFIG_PWM_PXA)          +=3D pwm-pxa.o
>>> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
>>> new file mode 100644
>>> index 000000000000..996ca3805901
>>> --- /dev/null
>>> +++ b/drivers/pwm/pwm-ocores.c
>>> @@ -0,0 +1,229 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * OpenCores PWM Driver
>>> + *
>>> + * https://opencores.org/projects/ptc
>>> + *
>>> + * Copyright (C) 2018-2023 StarFive Technology Co., Ltd.
>>> + *
>>> + * Limitations:
>>> + * - The hardware only do inverted polarity.
>>> + * - The hardware minimum period / duty_cycle is (1 / pwm_apb clock =
frequency) ns.
>>> + * - The hardware maximum period / duty_cycle is (U32_MAX / pwm_apb =
clock frequency) ns.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>=20
>> You probably don't need this header and the implicit includes it makes
>> are dropped now in linux-next. Please check what you actually need and
>> make them explicit.
>>=20
>> Rob
> Will drop.
>=20
> Thank you for spending time on this patchset.
>=20
> Best Regards
> William
Hi Rob,

After checking, I need to use of_match_device() in of_device.h, so this
interface will be moved to which header in linux-next?

Thanks,
William

