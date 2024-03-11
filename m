Return-Path: <linux-kernel+bounces-99306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A301C87864F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A170282D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FA54DA0F;
	Mon, 11 Mar 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAc4f3pZ"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0754AEFA
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710178127; cv=none; b=G9e9uU7QsS0hB1MAx4Nj/lDad2qcel9wcldbzQOSLAsS36kP7mVgHBgTnAhZNjmnjJhfkfrPTbapLNwzZd4DKQlvbmKxFCBOQubNUv0R1wxrwhQ8EfuZwYt86YU8q7wMNk4FuVTJUoaF5EGU9eahJ4V/aDdJR3AhTQ8eUedc1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710178127; c=relaxed/simple;
	bh=Nw25BQDEBBWTtAI0Su/vGdntGRWOTZRExRHJTOGMSwI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PxfPmrN6eddtdhKrgJBXIAynnDH8lri7LxcmiDdAlGcYR3pe3dOLdfFvC9H6lomPLSSpbpsVV8u/KMqvx12HKvP7ZeiLzlt7ri63hEHCe3tHjZVosRi5WVlYVvotuY9PJZsGrkGJxHGa6zAP5GBrhgyl8TOz/0PYWH5xB7ZalRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAc4f3pZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33e162b1b71so4387295f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710178123; x=1710782923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YaqRMTDlNRfW2PpP+QR36rJyQxLqvOR69AbrC2VVwPo=;
        b=AAc4f3pZ0Hyk+NQ9NZP+qk3nf+ciHiWPAH4icar1D0SqKD9j7HSb4a1D4YnA182TjH
         t21MAaKW4U9G5Prjf4mCILOqgXVb3wOxlhO18unnn3skiXaF2u7dIAOJg8HmYDW0lP61
         o5PfInH6S/Pi0jv2+2b5tkGKTSm5nvWbSls2xzxe4+Ag9zZtJD2YOGOPU9uWMx86U2te
         zydkFKvt7nocEPYYSMN5CDc30Ql5Ixm5mjKDvCrm1rV+Ir3Um633pjYleUUCcEPvCSwk
         Ij1jgLi35oeyMHzLFEWhxdSsqfjJY8cIjRZLJ2a4nhCLGV9ZgO+omFKVqdLa9tIukY3j
         GOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710178123; x=1710782923;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaqRMTDlNRfW2PpP+QR36rJyQxLqvOR69AbrC2VVwPo=;
        b=rOQZowuVxGCQ2nhYM3wXyVMbaY5bG//AdjnNLtttJ/lmf1MexLD9DQFlbPHNm1bdSh
         SUpW344p0h4bJ9ghbu/00M49ITB4nijUywPGtCnQB3W3TquXoYB22Q3FoiCyqZkAnMpN
         l0qwEdUtOIk3Bst67MyLg3T30aZFJLilEV95NcTXwWBBcsZFTSU9MazLaT3116Hp2XCf
         jtnfM7Y54azJXFqYsl1ztnqjS6zz0QcuKjuu8dTxANJjQXMjMMQAMbcyoeYSDNMNeCVz
         BCA89Un/zszsfXCOb17P6s3QSg1KUAIxtPp1BLGRmPLhLQpcv3QEgToajReYe4tjAKAx
         NXoA==
X-Forwarded-Encrypted: i=1; AJvYcCU6S32v7gBR79rJuMFR0Boxqbv45LtiwGTU9nXYb7DRFwkl6qQrmPpQxFOka7L2okMxlpdzhvaNXeNRECo2SCITC8GtaYpJ3jUGpab8
X-Gm-Message-State: AOJu0YzBJg8EQH5mLVHcWqETL24Sk7o910YQO0m8GWrJWXSvqbt/JJPm
	RZ7Klh+rgWmd9w3J4QGSroFK6xxSR7IKH1x0OMijhRdlJk5ZE5C33jxMMUwKSPU=
X-Google-Smtp-Source: AGHT+IFrLJCN2Bq1hiT2DJzxlrw4FVJoQrPBI9Tj7Ld+Y6OA2vh/7ORJ0+xmzZZzHzBKuu5AgaxBGA==
X-Received: by 2002:a5d:456f:0:b0:33d:af84:2a59 with SMTP id a15-20020a5d456f000000b0033daf842a59mr4813193wrc.28.1710178123100;
        Mon, 11 Mar 2024 10:28:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:48be:feb9:192b:f402? ([2a01:e0a:982:cbb0:48be:feb9:192b:f402])
        by smtp.gmail.com with ESMTPSA id bs15-20020a056000070f00b0033e9f6997c7sm940065wrb.66.2024.03.11.10.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 10:28:42 -0700 (PDT)
Message-ID: <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org>
Date: Mon, 11 Mar 2024 18:28:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/4] usb: typec: ucsi: Register cables based on
 GET_CABLE_PROPERTY
Content-Language: en-US, fr
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org,
 andersson@kernel.org, dmitry.baryshkov@linaro.org,
 fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org,
 hdegoede@redhat.com, rajaram.regupathy@intel.com, saranya.gopal@intel.com,
 linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240305025804.1290919-1-jthies@google.com>
 <20240305025804.1290919-3-jthies@google.com>
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
In-Reply-To: <20240305025804.1290919-3-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 05/03/2024 03:58, Jameson Thies wrote:
> Register cables with the Type-C Connector Class in the UCSI driver based
> on the PPM response to GET_CABLE_PROPERTY. Registered cable properties
> include plug type, cable type and major revision.
> 
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Expected cable properties populate the USB Type-C connector class sysfs
> paths:
> nospike-rev4 /sys/class/typec # ls port0-cable
> device  identity  plug_type  port0-plug0  power  subsystem  type  uevent
> usb_power_delivery_revision
> 
> Changes in v4:
> - None.
> 
> Changes in v3:
> - None.
> 
> Changes in v2:
> - Shortened lines to within 80 characters.
> - Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.
> 
>   drivers/usb/typec/ucsi/ucsi.c | 73 +++++++++++++++++++++++++++++++++++
>   drivers/usb/typec/ucsi/ucsi.h |  5 +++
>   2 files changed, 78 insertions(+)

Since those were merged, I see the following errors on SM8550-QRD and SM8650-QRD running linux-next:

[    8.668966] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: UCSI_GET_PD_MESSAGE failed (-95)
[   11.170560] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: GET_CABLE_PROPERTY failed (-95)
[   16.361678] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: timeout waiting for UCSI sync write response
[   21.409633] ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: error -ETIMEDOUT: PPM init failed

perhaps you should check the GET_CAPABILITY.bmOptionalFeatures bit 5 (Cable details supported) and 8 (GET_PD_MESSAGE supported)
before sending UCSI_GET_PD_MESSAGE and GET_CABLE_PROPERTY messages ?

With:
=================><====================================
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cf52cb34d285..eec64a4c8cdd 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1189,8 +1189,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
                         ucsi_register_partner(con);
                         ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
                         ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
-                       ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
-                       ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
+                       if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
+                               ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
+                       if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
+                               ucsi_partner_task(con, ucsi_check_cable, 1, HZ);

                         if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
                             UCSI_CONSTAT_PWR_OPMODE_PD)
@@ -1589,8 +1591,10 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
                 ucsi_register_partner(con);
                 ucsi_pwr_opmode_change(con);
                 ucsi_port_psy_changed(con);
-               ucsi_get_partner_identity(con);
-               ucsi_check_cable(con);
+               if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
+                       ucsi_get_partner_identity(con);
+               if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
+                       ucsi_check_cable(con);
         }

         /* Only notify USB controller if partner supports USB data */
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 32daf5f58650..2e9c35a3af27 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -215,6 +215,7 @@ struct ucsi_capability {
  #define UCSI_CAP_CABLE_DETAILS                 BIT(5)
  #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS      BIT(6)
  #define UCSI_CAP_PD_RESET                      BIT(7)
+#define UCSI_CAP_GET_PD_MESSAGE                        BIT(8)
         u16 reserved_1;
         u8 num_alt_modes;
         u8 reserved_2;
=================><====================================
it works fine again.

#regzbot introduced: 38ca416597b0

Thanks,
Neil

> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index ae105383e69e7..7c84687b5d1a3 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -734,6 +734,52 @@ static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
>   	con->partner_pd = NULL;
>   }
>   
> +static int ucsi_register_cable(struct ucsi_connector *con)
> +{
> +	struct typec_cable *cable;
> +	struct typec_cable_desc desc = {};
> +
> +	switch (UCSI_CABLE_PROP_FLAG_PLUG_TYPE(con->cable_prop.flags)) {
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_A:
> +		desc.type = USB_PLUG_TYPE_A;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_B:
> +		desc.type = USB_PLUG_TYPE_B;
> +		break;
> +	case UCSI_CABLE_PROPERTY_PLUG_TYPE_C:
> +		desc.type = USB_PLUG_TYPE_C;
> +		break;
> +	default:
> +		desc.type = USB_PLUG_NONE;
> +		break;
> +	}
> +
> +	desc.active = !!(UCSI_CABLE_PROP_FLAG_ACTIVE_CABLE &
> +			 con->cable_prop.flags);
> +	desc.pd_revision = UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(
> +	    con->cable_prop.flags);
> +
> +	cable = typec_register_cable(con->port, &desc);
> +	if (IS_ERR(cable)) {
> +		dev_err(con->ucsi->dev,
> +			"con%d: failed to register cable (%ld)\n", con->num,
> +			PTR_ERR(cable));
> +		return PTR_ERR(cable);
> +	}
> +
> +	con->cable = cable;
> +	return 0;
> +}
> +
> +static void ucsi_unregister_cable(struct ucsi_connector *con)
> +{
> +	if (!con->cable)
> +		return;
> +
> +	typec_unregister_cable(con->cable);
> +	con->cable = NULL;
> +}
> +
>   static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
>   {
>   	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
> @@ -807,6 +853,7 @@ static void ucsi_unregister_partner(struct ucsi_connector *con)
>   	typec_partner_set_usb_power_delivery(con->partner, NULL);
>   	ucsi_unregister_partner_pdos(con);
>   	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_SOP);
> +	ucsi_unregister_cable(con);
>   	typec_unregister_partner(con->partner);
>   	con->partner = NULL;
>   }
> @@ -907,6 +954,30 @@ static int ucsi_check_connection(struct ucsi_connector *con)
>   	return 0;
>   }
>   
> +static int ucsi_check_cable(struct ucsi_connector *con)
> +{
> +	u64 command;
> +	int ret;
> +
> +	if (con->cable)
> +		return 0;
> +
> +	command = UCSI_GET_CABLE_PROPERTY | UCSI_CONNECTOR_NUMBER(con->num);
> +	ret = ucsi_send_command(con->ucsi, command, &con->cable_prop,
> +				sizeof(con->cable_prop));
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "GET_CABLE_PROPERTY failed (%d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = ucsi_register_cable(con);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>   static void ucsi_handle_connector_change(struct work_struct *work)
>   {
>   	struct ucsi_connector *con = container_of(work, struct ucsi_connector,
> @@ -948,6 +1019,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>   			ucsi_register_partner(con);
>   			ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>   			ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> +			ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
>   
>   			if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
>   			    UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1346,6 +1418,7 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>   		ucsi_register_partner(con);
>   		ucsi_pwr_opmode_change(con);
>   		ucsi_port_psy_changed(con);
> +		ucsi_check_cable(con);
>   	}
>   
>   	/* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 469a2baf472e4..f0aabef0b7c64 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -265,6 +265,9 @@ struct ucsi_cable_property {
>   #define   UCSI_CABLE_PROPERTY_PLUG_TYPE_C	2
>   #define   UCSI_CABLE_PROPERTY_PLUG_OTHER	3
>   #define UCSI_CABLE_PROP_FLAG_MODE_SUPPORT	BIT(5)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_)	(((_f_) & GENMASK(7, 6)) >> 6)
> +#define UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV_AS_BCD(_f_) \
> +	UCSI_SPEC_REVISION_TO_BCD(UCSI_CABLE_PROP_FLAG_PD_MAJOR_REV(_f_))
>   	u8 latency;
>   } __packed;
>   
> @@ -400,6 +403,7 @@ struct ucsi_connector {
>   
>   	struct typec_port *port;
>   	struct typec_partner *partner;
> +	struct typec_cable *cable;
>   
>   	struct typec_altmode *port_altmode[UCSI_MAX_ALTMODES];
>   	struct typec_altmode *partner_altmode[UCSI_MAX_ALTMODES];
> @@ -408,6 +412,7 @@ struct ucsi_connector {
>   
>   	struct ucsi_connector_status status;
>   	struct ucsi_connector_capability cap;
> +	struct ucsi_cable_property cable_prop;
>   	struct power_supply *psy;
>   	struct power_supply_desc psy_desc;
>   	u32 rdo;


