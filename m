Return-Path: <linux-kernel+bounces-86946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCA86CD61
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6C31C213FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBC314A4E2;
	Thu, 29 Feb 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqFmXvJw"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AC136994
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221671; cv=none; b=qjiRmtaBZ+dF2ejFVJTfGEENzcCWX0nvQG1IQejSZRo+4iXHdrpJvRKSbk5QeMl/7OmLgHxKgQWKOAMbNFbp6YNfRaepO5kXZdI3NCw1ugQekvXWJXFp2M44gjt5OLSqqBYOwZysNpJnJhOD14b8jUAH+PGgN1j7s0zxFdDVMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221671; c=relaxed/simple;
	bh=JIPDHG7XdPCXGEvZpQagQbfuu8E+A7FViAMmAuu5ebY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rxiz61hUjZkGaUWCJgjHFUeYAuwgwPeZsMQ8ByDDxCFyeJ+wPI0Bis543z6fDqRuWCXwtKZT+eWb/tR8CCYFoYIlfmboUaaRfBnLZP7RIRHMb9UksypU3q0kcXISw1zHJXPTjYFRrRAew90F5gKaOeaW0BNcpAf/gxXtnJsBBbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jqFmXvJw; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512fb30dbc9so955996e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709221668; x=1709826468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=saHn9pvhbH8rMCUl9f/14VWu5XXe9OxpuyKx4DoT+Y8=;
        b=jqFmXvJw7+HkJCWDaO73GYpMmRJ6xooBPtllNsL03Qu7J73rbMYacXmK6Zb6TcHacA
         7VIJxmlI08EtU1s3TLCGwFsyVHxt070duFA509/jYRQtpy4dUrMJLcXHnfzQTQBll6zD
         0Ih1tqjQ3/+MHilgeeoqz5NzN9xoQspnCzr3aap84eK/weoX8vEjVwviduA6syUrR7/G
         x9n3X1kAKpZhwXfqWdO1Udblv/eAwGlwuCo/iMSo23cF3TaBFnsocLD43LgqJckEF97d
         PacXnPlZSCooN2pyqbR6VAIf8tPH/wibL4vTdFg/LKtGr/3fpTysPobLJzuOi4uslzlw
         GRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709221668; x=1709826468;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=saHn9pvhbH8rMCUl9f/14VWu5XXe9OxpuyKx4DoT+Y8=;
        b=d2bA8ntyCdd9dAEW/UzuVASZ8Vf+5Jg4ulz4KwaWqIVzPwBo8EJRU0kn0xMEm1qPuf
         uu9Ior7XV3MchZEWtUbI7aaxJNFMG1Mk4FZa6ylJaR6rJuRitvuOXv0GT8dwyK/1IID0
         nn/yi2f1hDtujFvj71X3gxtTc8iku2exUGsbjEbuW4oiLkciOxAVMjMDj3GVlEgxr1oW
         BOOlO64I/rm3y4G4wM1nYnjcpgPpCSbst7u+jqudu4/vrZotu44EZPDEegAYNShhrXfh
         LEc2v04Yk8uV+bm+3V33X4volOsyMP1KDb1C/9nKe1BoGkTUwUYMw2Pl4IEudEKr+Xbk
         vD1A==
X-Forwarded-Encrypted: i=1; AJvYcCWI09712rUeuT+D3Eo++Ue9ypyFd59eT7qEzsbif8Xip5/m5OmrzV0g+J+7YRtcWI/wHbeEletxfMIydl5NBxg/GpSKD9z20x32yXVf
X-Gm-Message-State: AOJu0YxRzZq34B1CZED6DkLbbH+oKD9QT5a1AXsHA05iM8XooeTU1Ulm
	3eyryRJ8Eu3gjGy3HZ6H1FWPJ4SyQcqVpGQkDJSlv6oxMdl39p7y6PJt5sdfWzo=
X-Google-Smtp-Source: AGHT+IEp6msI2/fLofQup9R5+qpigm6NmjqyWNBc8aduy45iExVf4UZOwZnhxmjozHhKa3zlKEeAbg==
X-Received: by 2002:ac2:5bc8:0:b0:513:1573:2dd4 with SMTP id u8-20020ac25bc8000000b0051315732dd4mr1876292lfn.45.1709221667799;
        Thu, 29 Feb 2024 07:47:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:651:5318:b12c:be82? ([2a01:e0a:982:cbb0:651:5318:b12c:be82])
        by smtp.gmail.com with ESMTPSA id j3-20020adff003000000b0033e01e397d6sm2075118wro.54.2024.02.29.07.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 07:47:47 -0800 (PST)
Message-ID: <d50ca4c0-8954-4e4c-9ce9-2c40ebacf8b0@linaro.org>
Date: Thu, 29 Feb 2024 16:47:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT 4/7] phy: qcom: qmp-combo: register a typec mux to
 change the QPHY_MODE
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-4-07e24a231840@linaro.org>
 <CAA8EJpoZn5V8N3=4x4AfYM91XBuCZx47vSS8tB-nCP=LvVsD6g@mail.gmail.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <CAA8EJpoZn5V8N3=4x4AfYM91XBuCZx47vSS8tB-nCP=LvVsD6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/02/2024 16:25, Dmitry Baryshkov wrote:
> On Thu, 29 Feb 2024 at 15:08, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Register a typec mux in order to change the PHY mode on the Type-C
>> mux events depending on the mode and the svid when in Altmode setup.
>>
>> The DisplayPort phy should be left enabled if is still powered on
>> by the DRM DisplayPort controller, so bail out until the DisplayPort
>> PHY is not powered off.
>>
>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
>> will be set in between of USB-Only, Combo and DisplayPort Only so
>> this will leave enough time to the DRM DisplayPort controller to
>> turn of the DisplayPort PHY.
> 
> I think this is not fully correct. Please correct me if I'm wrong, but
> it is possible to switch between USB / USB+DP / DP-only at runtime.
> See the Status Update and Configure commands.

Yes, but the current implementation is still valid because we need to
have the DP powered-off before changing the PHY mode.

I never encountered such setup and I have no idea how to test this.

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 122 ++++++++++++++++++++++++++++--
>>   1 file changed, 117 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> index ac5d528fd7a1..b5fb6cbcf867 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/reset.h>
>>   #include <linux/slab.h>
>>   #include <linux/usb/typec.h>
>> +#include <linux/usb/typec_dp.h>
>>   #include <linux/usb/typec_mux.h>
>>
>>   #include <drm/bridge/aux-bridge.h>
>> @@ -1515,6 +1516,10 @@ struct qmp_combo {
>>
>>          struct typec_switch_dev *sw;
>>          enum typec_orientation orientation;
>> +
>> +       struct typec_mux_dev *mux;
>> +       unsigned long mux_mode;
>> +       unsigned int svid;
>>   };
>>
>>   static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
>> @@ -3295,17 +3300,111 @@ static int qmp_combo_typec_switch_set(struct typec_switch_dev *sw,
>>          return 0;
>>   }
>>
>> -static void qmp_combo_typec_unregister(void *data)
>> +static int qmp_combo_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
>> +{
>> +       struct qmp_combo *qmp = typec_mux_get_drvdata(mux);
>> +       const struct qmp_phy_cfg *cfg = qmp->cfg;
>> +       enum qphy_mode new_mode;
>> +       unsigned int svid;
>> +
>> +       if (state->mode == qmp->mode)
>> +               return 0;
>> +
>> +       mutex_lock(&qmp->phy_mutex);
>> +
>> +       if (state->alt)
>> +               svid = state->alt->svid;
>> +       else
>> +               svid = 0; // No SVID
>> +
>> +       if (svid) {
> 
> We should check svid against USB_TYPEC_DP_SID. Otherwise the driver
> will mishandle the USB_SID_PD states.

Ack will do

> 
>> +               switch (state->mode) {
>> +                       /* DP Only */
>> +                       case TYPEC_DP_STATE_C:
>> +                       case TYPEC_DP_STATE_E:
>> +                               new_mode = QPHY_MODE_DP_ONLY;
>> +                               break;
>> +
>> +                               /* DP + USB */
>> +                       case TYPEC_DP_STATE_D:
>> +                       case TYPEC_DP_STATE_F:
>> +                               /* Safe fallback...*/
>> +                       default:
>> +                               new_mode = QPHY_MODE_COMBO;
>> +                               break;
>> +               }
>> +       } else {
>> +               /* Only switch to USB_ONLY when we know we only have USB3 */
>> +               if (qmp->mux_mode == TYPEC_MODE_USB3)
>> +                       new_mode = QPHY_MODE_USB_ONLY;
>> +               else
>> +                       new_mode = QPHY_MODE_COMBO;
>> +       }
>> +
>> +       if (new_mode == qmp->init_mode) {
>> +               dev_dbg(qmp->dev, "typec_mux_set: same phy mode, bail out\n");
>> +               qmp->mode = state->mode;
>> +               goto out;
>> +       }
>> +
>> +       if (qmp->init_mode != QPHY_MODE_USB_ONLY && qmp->dp_powered_on) {
>> +               dev_dbg(qmp->dev, "typec_mux_set: DP is still powered on, delaying switch\n");
>> +               goto out;
>> +       }
>> +
>> +       dev_dbg(qmp->dev, "typec_mux_set: switching from phy mode %d to %d\n",
>> +               qmp->init_mode, new_mode);
>> +
>> +       qmp->mux_mode = state->mode;
>> +       qmp->init_mode = new_mode;
>> +
>> +       if (qmp->init_count) {
>> +               if (qmp->usb_init_count)
>> +                       qmp_combo_usb_power_off(qmp->usb_phy);
>> +               if (qmp->dp_init_count)
>> +                       writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>> +               qmp_combo_com_exit(qmp, true);
>> +
>> +               /* Now everything's powered down, power up the right PHYs */
>> +
>> +               qmp_combo_com_init(qmp, true);
>> +               if (qmp->init_mode == QPHY_MODE_DP_ONLY && qmp->usb_init_count) {
>> +                       qmp->usb_init_count--;
>> +               } else if (qmp->init_mode != QPHY_MODE_DP_ONLY) {
>> +                       qmp_combo_usb_power_on(qmp->usb_phy);
>> +                       if (!qmp->usb_init_count)
>> +                               qmp->usb_init_count++;
>> +               }
>> +               if (qmp->init_mode != QPHY_MODE_USB_ONLY && qmp->dp_init_count)
>> +                       cfg->dp_aux_init(qmp);
>> +       }
>> +
>> +out:
>> +       mutex_unlock(&qmp->phy_mutex);
>> +
>> +       return 0;
>> +}
>> +
>> +static void qmp_combo_typec_switch_unregister(void *data)
>>   {
>>          struct qmp_combo *qmp = data;
>>
>>          typec_switch_unregister(qmp->sw);
>>   }
>>
>> -static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
>> +static void qmp_combo_typec_mux_unregister(void *data)
>> +{
>> +       struct qmp_combo *qmp = data;
>> +
>> +       typec_mux_unregister(qmp->mux);
>> +}
>> +
>> +static int qmp_combo_typec_register(struct qmp_combo *qmp)
>>   {
>>          struct typec_switch_desc sw_desc = {};
>> +       struct typec_mux_desc mux_desc = { };
>>          struct device *dev = qmp->dev;
>> +       int ret;
>>
>>          sw_desc.drvdata = qmp;
>>          sw_desc.fwnode = dev->fwnode;
>> @@ -3316,10 +3415,23 @@ static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
>>                  return PTR_ERR(qmp->sw);
>>          }
>>
>> -       return devm_add_action_or_reset(dev, qmp_combo_typec_unregister, qmp);
>> +       ret = devm_add_action_or_reset(dev, qmp_combo_typec_switch_unregister, qmp);
>> +       if (ret)
>> +               return ret;
>> +
>> +       mux_desc.drvdata = qmp;
>> +       mux_desc.fwnode = dev->fwnode;
>> +       mux_desc.set = qmp_combo_typec_mux_set;
>> +       qmp->mux = typec_mux_register(dev, &mux_desc);
>> +       if (IS_ERR(qmp->mux)) {
>> +               dev_err(dev, "Unable to register typec mux: %pe\n", qmp->mux);
>> +               return PTR_ERR(qmp->mux);
>> +       }
>> +
>> +       return devm_add_action_or_reset(dev, qmp_combo_typec_mux_unregister, qmp);
>>   }
>>   #else
>> -static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
>> +static int qmp_combo_typec_register(struct qmp_combo *qmp)
>>   {
>>          return 0;
>>   }
>> @@ -3532,7 +3644,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
>>          if (ret)
>>                  return ret;
>>
>> -       ret = qmp_combo_typec_switch_register(qmp);
>> +       ret = qmp_combo_typec_register(qmp);
>>          if (ret)
>>                  return ret;
>>
>>
>> --
>> 2.34.1
>>
>>
> 
> 


