Return-Path: <linux-kernel+bounces-31149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5FC8329C9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42461F2220F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B8D51C51;
	Fri, 19 Jan 2024 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gi25NXZo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FC4F1F6;
	Fri, 19 Jan 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668922; cv=none; b=kQ8Ie/gpswicmm+YroAlOWDjB/WWkZdvr39o52mgSi/04M0mAclxoHejgLjtg+plRQvvPLDLb2kvbtwai3hKsvXqkSn82nm6jwKla3UGdbxoQkDzqLnc6r60CtZr3B/eHkH6ny7HgN33Jc1vj+FvT/B3iLWLszRCJsyNkBVxVKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668922; c=relaxed/simple;
	bh=EjVFyi70iDYG2czWyG5owoqc7kRO3Kwh6/BYrb/3DaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLTHVw8KHY3kRS1Ns+P1Z96W7V4ZuR00Ts4tC4AXxLZbvbVk6nt51m6oscsjjTsX2wnLcFlMvd1YAY5RdDOM4G38dV9gi1OC7/sAFEe+vrAhpwWMJSGncj/WXDrT0i3lefBlx5cpNAVbY2d6kEba4JOEk6C94kTN+yNc0cmWhNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gi25NXZo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705668918;
	bh=EjVFyi70iDYG2czWyG5owoqc7kRO3Kwh6/BYrb/3DaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gi25NXZozg2EM16pBusHJ8U/66PZA9mP1CBI+PoTceS7c0uK1LlgS86/LDw5NgbjA
	 9rVrgra8maMORZaM6gsp/xxGfsUoqwBbJwCX9XGFUI5z8cb8fp4q1Gbixcj9oXX6MO
	 OiKUG2exK0dBaEwiu1LH6s3es0NnBoc43mpSkO+Ait5tkIkP7JLlYKBOiMy/2HkzP6
	 LSz24OcAeADWbq50K8CPlr/sNIZvtV5AfQsVFp98SrSLQEzyUlAX/V6MUCcXBMDID7
	 k9NhAsBQ8qEpi/sRgMm4rCabeCUOSgzWVP+KVaIRasak67GsGncaBfMfkXCn7Ub4Fg
	 8ICsFEPKfP/3w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B767037803EE;
	Fri, 19 Jan 2024 12:55:17 +0000 (UTC)
Message-ID: <8834d309-19f2-466f-aed4-ab0f9e2df02d@collabora.com>
Date: Fri, 19 Jan 2024 13:55:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: typec: mux: Add ITE IT5205 Alternate Mode
 Passive MUX driver
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
 neil.armstrong@linaro.org, andersson@kernel.org, nathan@kernel.org,
 luca.weiss@fairphone.com, tianping.fang@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240119104550.140061-1-angelogioacchino.delregno@collabora.com>
 <20240119104550.140061-3-angelogioacchino.delregno@collabora.com>
 <CAA8EJprroFtKvCeZtP_FySr5d6v4dogYQKFQvzPJLpwWBuMrKw@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAA8EJprroFtKvCeZtP_FySr5d6v4dogYQKFQvzPJLpwWBuMrKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/01/24 12:44, Dmitry Baryshkov ha scritto:
> On Fri, 19 Jan 2024 at 12:46, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> The ITE IT5202 is a USB Type-C Alternate Mode Passive MUX, used for
>> muxing the SBU lines of a Type-C port with DisplayPort altmode and
>> also providing an orientation switch.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/usb/typec/mux/Kconfig  |  10 ++
>>   drivers/usb/typec/mux/Makefile |   1 +
>>   drivers/usb/typec/mux/it5205.c | 292 +++++++++++++++++++++++++++++++++
>>   3 files changed, 303 insertions(+)
>>   create mode 100644 drivers/usb/typec/mux/it5205.c
>>
>> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
>> index d2cb5e733e57..399c7b0983df 100644
>> --- a/drivers/usb/typec/mux/Kconfig
>> +++ b/drivers/usb/typec/mux/Kconfig
>> @@ -36,6 +36,16 @@ config TYPEC_MUX_INTEL_PMC
>>            control the USB role switch and also the multiplexer/demultiplexer
>>            switches used with USB Type-C Alternate Modes.
>>
>> +config TYPEC_MUX_IT5205
>> +       tristate "ITE IT5205 Type-C USB Alt Mode Passive MUX driver"
>> +       depends on I2C
>> +       select REGMAP_I2C
>> +       help
>> +         Driver for the ITE IT5205 Type-C USB Alternate Mode Passive MUX
>> +         which provides support for muxing DisplayPort and sideband signals
>> +         on a common USB Type-C connector.
>> +         If compiled as a module, the module will be named it5205.
>> +
>>   config TYPEC_MUX_NB7VPQ904M
>>          tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
>>          depends on I2C
>> diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
>> index 57dc9ac6f8dc..bb96f30267af 100644
>> --- a/drivers/usb/typec/mux/Makefile
>> +++ b/drivers/usb/typec/mux/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_TYPEC_MUX_FSA4480)         += fsa4480.o
>>   obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)       += gpio-sbu-mux.o
>>   obj-$(CONFIG_TYPEC_MUX_PI3USB30532)    += pi3usb30532.o
>>   obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)      += intel_pmc_mux.o
>> +obj-$(CONFIG_TYPEC_MUX_IT5205)         += it5205.o
>>   obj-$(CONFIG_TYPEC_MUX_NB7VPQ904M)     += nb7vpq904m.o
>>   obj-$(CONFIG_TYPEC_MUX_PTN36502)       += ptn36502.o
>>   obj-$(CONFIG_TYPEC_MUX_WCD939X_USBSS)  += wcd939x-usbss.o
>> diff --git a/drivers/usb/typec/mux/it5205.c b/drivers/usb/typec/mux/it5205.c
>> new file mode 100644
>> index 000000000000..99203b8a086d
>> --- /dev/null
>> +++ b/drivers/usb/typec/mux/it5205.c
>> @@ -0,0 +1,292 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * ITE IT5205 Type-C USB alternate mode passive mux
>> + *
>> + * Copyright (c) 2020 MediaTek Inc.
>> + * Copyright (c) 2024 Collabora Ltd.
>> + *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> + *
>> + */
>> +#include <linux/i2c.h>
>> +#include <linux/kernel.h>
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/regmap.h>
>> +#include <linux/usb/typec.h>
>> +#include <linux/usb/typec_mux.h>
>> +#include <linux/usb/typec_dp.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio.h>
>> +#include <linux/usb/tcpm.h>
> 
> I'd say, it is a usual custom to sort this list.
> 

Oh, whoops. Totally forgot to do that, sorry - thanks for pointing that out!
Done for v2.

> [skipped]
> 
>> +
>> +static int it5205_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
>> +{
>> +       struct it5205 *it = typec_mux_get_drvdata(mux);
>> +       u8 val;
>> +
>> +       switch (state->mode) {
>> +       case TYPEC_STATE_USB:
>> +               val = IT5205_USB;
>> +               break;
>> +       case TYPEC_DP_STATE_C:
>> +               fallthrough;
>> +       case TYPEC_DP_STATE_E:
>> +               val = IT5205_DP;
>> +               break;
>> +       case TYPEC_DP_STATE_D:
>> +               val = IT5205_DP_USB;
>> +               break;
>> +       case TYPEC_STATE_SAFE:
>> +               fallthrough;
>> +       default:
>> +               val = 0;
>> +               break;
>> +       }
> 
> Please add a check for state->altmode. All states at TYPEC_STATE_MODAL
> and above (which includes TYPEC_DP_STATE_[CDE]) are only relevant with
> connection to the particular typec->altmode SVID.
> 

Done for v2.

>> +
>> +       return regmap_update_bits(it->regmap, IT5205_REG_MUXCR,
>> +                                 IT5205_DP_USB_CTRL_MASK, val);
>> +}
>> +
>> +static irqreturn_t it5205_irq_handler(int irq, void *data)
>> +{
>> +       struct it5205 *it = data;
>> +       int ret;
>> +       u32 val;
>> +
>> +       ret = regmap_read(it->regmap, IT5205_REG_ISR, &val);
>> +       if (ret)
>> +               return IRQ_NONE;
>> +
>> +       if (val & IT5205_ISR_CSBU_OVP) {
>> +               dev_warn(&it->client->dev, "Overvoltage detected!\n");
> 
> Will it cut the voltage automatically?
> 

As far as I understand, yes.
Unfortunately, there's no datasheet.

>> +
>> +               /* Reset CSBU */
>> +               regmap_update_bits(it->regmap, IT5205_REG_CSBUSR,
>> +                                  IT5205_CSBUSR_SWITCH, 0);
>> +               regmap_update_bits(it->regmap, IT5205_REG_CSBUSR,
>> +                                  IT5205_CSBUSR_SWITCH, IT5205_CSBUSR_SWITCH);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
> 
> The rest LGTM
> 
> 




