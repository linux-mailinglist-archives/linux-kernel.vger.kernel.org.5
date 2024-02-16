Return-Path: <linux-kernel+bounces-68670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B45857E25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01FCF2842AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D912C526;
	Fri, 16 Feb 2024 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q09jlW7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC01292C9;
	Fri, 16 Feb 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091698; cv=none; b=WACtmVH118PySTsGsDpt0fq1ydN+VavGHEDwYpBFdK5blWcarGRKqcaOqcN8XrAmEHLNsNxvDe7E77pGlzeUt9I5dXmTbKaF5wxhjHzJ3Q+cCr74oK21pyNDe6Sr4ZcCQZFomKkrascO6DIdIkD1he/OE7MGNrS+Hiv3/jRukiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091698; c=relaxed/simple;
	bh=cqe2USBFaJaYZRQLPE2KZZhfmm188QBvEeoHTdm6t1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkWXTvP2mgP3t/VwraPjGCJAefRboHBJaXnKVvfcyiR/FWyitHdeS+QyK6cn1tknU68AOl9pct2a1VthO8t9yu59AJ+NXZlBzXThf/7Sj0m7r2z4uoT8BmM48PAMeKNAx0VU+7yA6LeUboujrZCBjFAdnLTNJ8Ra5Fi9T3E0K7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q09jlW7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D93C433F1;
	Fri, 16 Feb 2024 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091697;
	bh=cqe2USBFaJaYZRQLPE2KZZhfmm188QBvEeoHTdm6t1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q09jlW7CLpPeUZakZ2gjjUaGgYRuXa7YhwbuPa/nOTRpL04jHWDGXNIKmW1kz5MsH
	 JRvWgcNCB1qQ4fEu4UrLjIRieAMdXg/vHGm4hLirX8CNxz4hTQc3V0j2Tft3yxO6i9
	 x75gSUFrV7XU0ocyWbGDZ/NMco+kLo43Q9QjgMpX2QnCMxvFMEQBhyzbVFU6tRCiFU
	 c9fE+0Endgu7RVv0cN8hFb4ljjEVA0pi8QfmuEtunDx1Q2TexNsbwHFHZs6bHQJTQH
	 gqC4LENcfX0eZqyacuzeKkq8iwuGSaoB175eAiQ1hocIdnOUNHYIRPcl8wvCRsB7D+
	 EHYhvbw5WoVhg==
Date: Fri, 16 Feb 2024 13:54:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <lee@kernel.org>, <andriy.shevchenko@linux.intel.com>,
 <daniel.lezcano@linaro.org>, <dmitry.baryshkov@linaro.org>,
 <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
 <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
 <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
 <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
 <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
 <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Subject: Re: [PATCH v3 3/3] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Message-ID: <20240216135440.401f25ba@jic23-huawei>
In-Reply-To: <b02f20fd-c682-4b47-8d61-1d0e2adbdd57@quicinc.com>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
	<20231231171237.3322376-4-quic_jprakash@quicinc.com>
	<20240101175453.5807483a@jic23-huawei>
	<b02f20fd-c682-4b47-8d61-1d0e2adbdd57@quicinc.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 16:10:18 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Hi Jonathan,
>=20
> On 1/1/2024 11:24 PM, Jonathan Cameron wrote:
> > On Sun, 31 Dec 2023 22:42:37 +0530
> > Jishnu Prakash<quic_jprakash@quicinc.com>  wrote:
> > =20
> >> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
> >> with all SW communication to ADC going through PMK8550 which
> >> communicates with other PMICs through PBS.
> >> =20
>=20
> >> +
> >> +	for (i =3D 0; i < adc->nchannels; i++) {
> >> +		bool upper_set =3D false, lower_set =3D false;
> >> +		int temp, offset;
> >> +		u16 code =3D 0;
> >> +
> >> +		chan_prop =3D &adc->chan_props[i];
> >> +		offset =3D chan_prop->tm_chan_index;
> >> +
> >> +		if (!chan_prop->adc_tm)
> >> +			continue;
> >> +
> >> +		mutex_lock(&adc->lock);
> >> +		if (chan_prop->sdam_index !=3D sdam_index) { =20
> > Perhaps factor this block out as indent already high and adding scoped_=
guard would
> > make it worse. =20
>=20
>=20
> I don't think I can completely factor it out, as we need to update=20
> several local variables here (sdam_index, tm_status, buf, also chan_prop=
=20
> above), but I'll try to reduce it as much as possible.
>=20
>=20
> >> +			sdam_index =3D chan_prop->sdam_index;
> >> +			ret =3D adc5_gen3_read(adc, sdam_index, ADC5_GEN3_TM_HIGH_STS,
> >> +					tm_status, 2);
> >> +			if (ret) {
> >> +				dev_err(adc->dev, "adc read TM status failed with %d\n", ret);
> >> +				goto out;
> >> +			}
> >> + =20
>=20
> >> +
> >> +static void adc5_gen3_disable(void *data)
> >> +{
> >> +	struct adc5_chip *adc =3D data;
> >> +	int i;
> >> +
> >> +	if (adc->n_tm_channels)
> >> +		cancel_work_sync(&adc->tm_handler_work); =20
> > If this is required before the place where a simple
> > devm_request_irq() will result in the irqs being cleaned up
> > them register this callback earlier to avoid problems there. =20
>=20
>=20
> On checking again, it looks like I can just use devm_request_irq() and=20
> avoid having to free irqs explicitly here and elsewhere. I'll=C2=A0 still=
=20
> need to call cancel_work_sync() and I think you have also asked me to=20
> keep this call in another comment below. I have another question for it=20
> below.

Keeping it is fine, just make sure it's registered in the right location
to ensure it is taken down after we are sure it can't get scheduled again
(I think that is what I was getting at - been a while!)
>=20
>=20
> >> +
> >> +	for (i =3D 0; i < adc->num_sdams; i++)
> >> +		free_irq(adc->base[i].irq, adc);
> >> +
> >> +	mutex_lock(&adc->lock);
> >> +	/* Disable all available TM channels */
> >> +	for (i =3D 0; i < adc->nchannels; i++) {
> >> +		if (!adc->chan_props[i].adc_tm)
> >> +			continue;
> >> +		adc5_gen3_poll_wait_hs(adc, adc->chan_props[i].sdam_index);
> >> +		_adc_tm5_gen3_disable_channel(&adc->chan_props[i]);
> >> +	}
> >> +
> >> +	mutex_unlock(&adc->lock);
> >> +} =20
>=20
> > + =20
> >> +	prop->hw_settle_time =3D VADC_DEF_HW_SETTLE_TIME; =20
> > I'd prefer to see you has through the value that maps to this after qco=
m_adc5_hw_settle_time_from_dt
> > so then you can just set a default in value and call the rest of the co=
de unconditionally.
> > Same for the cases that follow. =20
>=20
>=20
> I can remove the return check for fwnode_property_read_u32() as you=20
> suggested, but I think we still need to keep the return check for=20
> qcom_adc5_hw_settle_time_from_dt(), to check in case values unsupported=20
> in this ADC HW are set in DT. Same for the other properties.

Sure, you can check for errors in using the property. Just do it unconditio=
nally
so that you call the same code for the default (even though you know that w=
ill
be fine).  Should simplify the code.

>=20
>=20
> >> +	ret =3D fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &val=
ue);
> >> +	if (!ret) {
> >> +		ret =3D qcom_adc5_hw_settle_time_from_dt(value,
> >> +						data->hw_settle_1);
> >> +		if (ret < 0)
> >> +			return dev_err_probe(dev, ret, "%#x invalid hw-settle-time %d us\n=
",
> >> +				chan, value);
> >> +		prop->hw_settle_time =3D ret;
> >> +	}
> >> + =20

> > =20
> >> +
> >> +	device_for_each_child_node(adc->dev, child) {
> >> +		ret =3D adc5_gen3_get_fw_channel_data(adc, chan_props, child, adc->=
data);
> >> +		if (ret < 0) { =20
>=20
> >> +		ret =3D platform_get_irq_byname(pdev, adc->base[i].irq_name);
> >> +		if (ret < 0) {
> >> +			kfree(reg);
> >> +			dev_err(dev, "Getting IRQ %d by name failed, ret =3D %d\n",
> >> +					adc->base[i].irq, ret);
> >> +			goto err_irq;
> >> +		}
> >> +		adc->base[i].irq =3D ret;
> >> +
> >> +		ret =3D request_irq(adc->base[i].irq, adc5_gen3_isr, 0, adc->base[i=
].irq_name, adc); =20
> > Don't mix devm and non dev calls.  And don't group up multiple things i=
n one devm callback
> > as it almost always leads to bugs where for example only some irqs are =
allocated. =20
>=20
>=20
> I can replace request_irq() with devm_request_irq(). But when you say=20
> not to group up multiple things in one devm callback, do you mean the=20
> devm_add_action() callback I added below or something else right here?

Yes, I meant the devm_add_action() callback.

>=20
>=20
> >> +		if (ret < 0) {
> >> +			kfree(reg);
> >> +			dev_err(dev, "Failed to request SDAM%d irq, ret =3D %d\n", i, ret);
> >> +			goto err_irq;
> >> +		}
> >> +	}
> >> +	kfree(reg); =20
> > I would factor out this code and allocation of reg so you can easily us=
e scope
> > based cleanup (see linux/cleanup.h) to avoid the kfree(reg) entries that
> > make for awkward code flow. =20
>=20
>=20
> The kfrees are not really needed, I'll just use devm_kcalloc to allocate=
=20
> memory for the "reg" variable. With this and devm_request_irq, I think a=
=20
> scoped guard would not be needed here.

If you don't need it after this function, then better to clean it up.

>=20
>=20
> >
> > =20
> >> +
> >> +	ret =3D devm_add_action(dev, adc5_gen3_disable, adc); =20
> > As above, this action does multiple things. Also use devm_add_action_or=
_reset() to cleanup
> > if the devm registration fails without needing to do it manually. =20
>=20
>=20
> I'll change it to devm_add_action_or_reset(), but do you mean I should=20
> call devm_add_action_or_reset() twice to register two separate callbacks=
=20
> instead of just adc5_gen3_disable? Like one for calling=20
> cancel_work_sync() alone and the other for the loop where we disable all=
=20
> TM channels?

yes

>=20
>=20
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "failed to register adc disablement devm action, %d\n"=
, ret);
> >> +		goto err_irq;
> >> +	}
> >> + =20
>=20
> >> +
> >> +	if (adc->n_tm_channels)
> >> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work); =20
> > Until this init work seems unlikely you should be calling the cancel
> > work in gen3_disable() =20
>=20
>=20
> We are already calling cancel_work_sync() in adc5_gen3_disable....is=20
> there any change needed?
Yes - add a devm_add_action() here (not need for reset in this case as noth=
ing
can have queued any work yet) and handle this on it's own.

Each cleanup action should match with a setup action.

Jonathan



