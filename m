Return-Path: <linux-kernel+bounces-6663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BA819BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97231C2251A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68730200BE;
	Wed, 20 Dec 2023 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="H60Ql/re"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDA1F61D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso6145210a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1703066178; x=1703670978; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13u6CJzloCwNROWpaaN5LYVVec8rVqVlyAkXjhxCkLQ=;
        b=H60Ql/reVB+0UddANd3OPOMJ11nwxlC3c2VUXEd2Jax63GnZ5pSQRXy6uQhxziJIfW
         kVeO7DfzKJ1qYqeIY3io23TO0mbzriXT6EmbDuRXBe0e1ojFrtwBNXLtQ/iPWX2nQZSO
         jNFGVjHOwqfJQ2mKmThYPaAFCDYEaCsGV5/DEDOAiOEFduE4OcjL3ruv9k6HWd7pwTke
         rTaTEA1lUJ/vfAeK0zkiaNVeZitq//6jWsk6TVAdqhZFMtGaTGwItM8Gno4i1Utv4JC4
         yCBWKa1pFMtmxc4ZdBsadL1+HcPkyCC1Zt2K3UJ1whJ1+IbE1UBZloSFak7OKLT5NZx/
         qbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066178; x=1703670978;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13u6CJzloCwNROWpaaN5LYVVec8rVqVlyAkXjhxCkLQ=;
        b=eNGQvfAyZdBVVqf9LWC9XVmRm76kmf0ykVl09C9k42wvRNBXzhIBFDEIHi3TIeGAwo
         H3ACpR8vOprc8Ef+tDkRPxeqW70KlzGW6EdcmrvOY+OEbM4seq17zzZ4rsSA3M9XnmFq
         23HZu1C0ZVOgr7A0U9UATQ/vboIfQvturPBS54WUxIydw+hijleNKI+TQTfE07nLM8qK
         PfPpaJxETH/YjzQlKlnLzZOYg38DSZlmCSt6WiaWvnUBFTSLK70WCH0oSDWrJJCg/D/a
         1ZtzRFu1j1zTwJ0DnJaxMQudElgSTI1s6WFJju9gZN89wh5Sp6YRzpjH4ecMiCdUmPvJ
         /6ug==
X-Gm-Message-State: AOJu0YzuzG/4Swb1FD4PYpKWrpSO9gD4fzxz52LZ6SV6X+mGLw3m3vmQ
	v/MTWyvSM1ioP1qhprBmDa6izA==
X-Google-Smtp-Source: AGHT+IEXWIO5wMlW1tjJniy5ZXS0gAtwe5IrjLIJfXFU5RFe9pDvkHeSDozUmVsEE67rdQe/OZQ24Q==
X-Received: by 2002:a50:cc4a:0:b0:54d:d2af:6353 with SMTP id n10-20020a50cc4a000000b0054dd2af6353mr10870434edi.48.1703066178609;
        Wed, 20 Dec 2023 01:56:18 -0800 (PST)
Received: from localhost (2a02-8388-6584-6400-d322-7350-96d2-429d.cable.dynamic.v6.surfer.at. [2a02:8388:6584:6400:d322:7350:96d2:429d])
        by smtp.gmail.com with ESMTPSA id h29-20020a0564020e9d00b0054c63cc0469sm12550507eda.33.2023.12.20.01.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 01:56:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Dec 2023 10:56:16 +0100
Message-Id: <CXT2KOUYYB7G.11K72VA0G9DKI@fairphone.com>
Cc: "Marijn Suijten" <marijn.suijten@somainline.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>, "Johan Hovold" <johan+linaro@kernel.org>
Subject: Re: [PATCH RFC] power: supply: qcom_battmgr: Register the power
 supplies after PDR is up
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Sebastian Reichel" <sre@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231218-topic-battmgr_fixture_attempt-v1-1-6145745f34fe@linaro.org>
In-Reply-To: <20231218-topic-battmgr_fixture_attempt-v1-1-6145745f34fe@linaro.org>

On Mon Dec 18, 2023 at 3:41 PM CET, Konrad Dybcio wrote:
> Currently, a not-yet-entirely-initialized battmgr (e.g. with pd-mapper
> not having yet started or ADSP not being up etc.) results in a couple of
> zombie power supply devices hanging around.
>
> This is particularly noticeable when trying to suspend the device (even
> s2idle): the PSY-internal thermal zone is inaccessible and returns
> -ENODEV, which causes log spam.
>
> Register the power supplies only after we received some notification
> indicating battmgr is ready to take off.

Hi Konrad,

This seems to fix an issue I'm seeing consistently on
qcm6490-fairphone-fp5 when having adsp driver built-in and manually
starting it with:
  echo start | sudo tee /sys/class/remoteproc/remoteproc0/state

Before upower was thinking line_power_qcom_battmgr_usb and
line_power_qcom_battmgr_wls were "battery" devices with 0% charge and
not "line-power" (which is what they're shown as now, and also before
with adsp =3Dm).
That caused upower to have its "Display Device" only show a third of the
actual battery percent because it was including those fake batteries
also.

At least for this exact case (didn't test more tbh) I can offer my:

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 109 ++++++++++++++++++++----------=
------
>  1 file changed, 60 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index ec163d1bcd18..a12e2a66d516 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -282,6 +282,7 @@ struct qcom_battmgr_wireless {
> =20
>  struct qcom_battmgr {
>  	struct device *dev;
> +	struct auxiliary_device *adev;
>  	struct pmic_glink_client *client;
> =20
>  	enum qcom_battmgr_variant variant;
> @@ -1293,11 +1294,69 @@ static void qcom_battmgr_enable_worker(struct wor=
k_struct *work)
>  		dev_err(battmgr->dev, "failed to request power notifications\n");
>  }
> =20
> +static char *qcom_battmgr_battery[] =3D { "battery" };
> +
> +static void qcom_battmgr_register_psy(struct qcom_battmgr *battmgr)
> +{
> +	struct power_supply_config psy_cfg_supply =3D {};
> +	struct auxiliary_device *adev =3D battmgr->adev;
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &adev->dev;
> +
> +	psy_cfg.drv_data =3D battmgr;
> +	psy_cfg.of_node =3D adev->dev.of_node;
> +
> +	psy_cfg_supply.drv_data =3D battmgr;
> +	psy_cfg_supply.of_node =3D adev->dev.of_node;
> +	psy_cfg_supply.supplied_to =3D qcom_battmgr_battery;
> +	psy_cfg_supply.num_supplicants =3D 1;
> +
> +	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP) {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sc8280xp_bat_psy=
_desc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			dev_err(dev, "failed to register battery power supply (%ld)\n",
> +				PTR_ERR(battmgr->bat_psy));
> +
> +		battmgr->ac_psy =3D devm_power_supply_register(dev, &sc8280xp_ac_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->ac_psy))
> +			dev_err(dev, "failed to register AC power supply (%ld)\n",
> +				PTR_ERR(battmgr->ac_psy));
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sc8280xp_usb_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			dev_err(dev, "failed to register USB power supply (%ld)\n",
> +				PTR_ERR(battmgr->usb_psy));
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			dev_err(dev, "failed to register wireless charing power supply (%ld)\=
n",
> +				PTR_ERR(battmgr->wls_psy));
> +	} else {
> +		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
> +		if (IS_ERR(battmgr->bat_psy))
> +			dev_err(dev, "failed to register battery power supply (%ld)\n",
> +				PTR_ERR(battmgr->bat_psy));
> +
> +		battmgr->usb_psy =3D devm_power_supply_register(dev, &sm8350_usb_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->usb_psy))
> +			dev_err(dev, "failed to register USB power supply (%ld)\n",
> +				PTR_ERR(battmgr->usb_psy));
> +
> +		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
> +		if (IS_ERR(battmgr->wls_psy))
> +			dev_err(dev, "failed to register wireless charing power supply (%ld)\=
n",
> +				PTR_ERR(battmgr->wls_psy));
> +	}
> +}
> +
>  static void qcom_battmgr_pdr_notify(void *priv, int state)
>  {
>  	struct qcom_battmgr *battmgr =3D priv;
> =20
>  	if (state =3D=3D SERVREG_SERVICE_STATE_UP) {
> +		if (!battmgr->bat_psy)
> +			qcom_battmgr_register_psy(battmgr);
> +
>  		battmgr->service_up =3D true;
>  		schedule_work(&battmgr->enable_work);
>  	} else {
> @@ -1312,13 +1371,9 @@ static const struct of_device_id qcom_battmgr_of_v=
ariants[] =3D {
>  	{}
>  };
> =20
> -static char *qcom_battmgr_battery[] =3D { "battery" };
> -
>  static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  			      const struct auxiliary_device_id *id)
>  {
> -	struct power_supply_config psy_cfg_supply =3D {};
> -	struct power_supply_config psy_cfg =3D {};
>  	const struct of_device_id *match;
>  	struct qcom_battmgr *battmgr;
>  	struct device *dev =3D &adev->dev;
> @@ -1328,14 +1383,7 @@ static int qcom_battmgr_probe(struct auxiliary_dev=
ice *adev,
>  		return -ENOMEM;
> =20
>  	battmgr->dev =3D dev;
> -
> -	psy_cfg.drv_data =3D battmgr;
> -	psy_cfg.of_node =3D adev->dev.of_node;
> -
> -	psy_cfg_supply.drv_data =3D battmgr;
> -	psy_cfg_supply.of_node =3D adev->dev.of_node;
> -	psy_cfg_supply.supplied_to =3D qcom_battmgr_battery;
> -	psy_cfg_supply.num_supplicants =3D 1;
> +	battmgr->adev =3D adev;
> =20
>  	INIT_WORK(&battmgr->enable_work, qcom_battmgr_enable_worker);
>  	mutex_init(&battmgr->lock);
> @@ -1347,43 +1395,6 @@ static int qcom_battmgr_probe(struct auxiliary_dev=
ice *adev,
>  	else
>  		battmgr->variant =3D QCOM_BATTMGR_SM8350;
> =20
> -	if (battmgr->variant =3D=3D QCOM_BATTMGR_SC8280XP) {
> -		battmgr->bat_psy =3D devm_power_supply_register(dev, &sc8280xp_bat_psy=
_desc, &psy_cfg);
> -		if (IS_ERR(battmgr->bat_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> -					     "failed to register battery power supply\n");
> -
> -		battmgr->ac_psy =3D devm_power_supply_register(dev, &sc8280xp_ac_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->ac_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->ac_psy),
> -					     "failed to register AC power supply\n");
> -
> -		battmgr->usb_psy =3D devm_power_supply_register(dev, &sc8280xp_usb_psy=
_desc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->usb_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> -					     "failed to register USB power supply\n");
> -
> -		battmgr->wls_psy =3D devm_power_supply_register(dev, &sc8280xp_wls_psy=
_desc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->wls_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> -	} else {
> -		battmgr->bat_psy =3D devm_power_supply_register(dev, &sm8350_bat_psy_d=
esc, &psy_cfg);
> -		if (IS_ERR(battmgr->bat_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
> -					     "failed to register battery power supply\n");
> -
> -		battmgr->usb_psy =3D devm_power_supply_register(dev, &sm8350_usb_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->usb_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->usb_psy),
> -					     "failed to register USB power supply\n");
> -
> -		battmgr->wls_psy =3D devm_power_supply_register(dev, &sm8350_wls_psy_d=
esc, &psy_cfg_supply);
> -		if (IS_ERR(battmgr->wls_psy))
> -			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
> -					     "failed to register wireless charing power supply\n");
> -	}
> -
>  	battmgr->client =3D devm_pmic_glink_register_client(dev,
>  							  PMIC_GLINK_OWNER_BATTMGR,
>  							  qcom_battmgr_callback,
>
> ---
> base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
> change-id: 20231218-topic-battmgr_fixture_attempt-ec86ef8df7e3
>
> Best regards,


