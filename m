Return-Path: <linux-kernel+bounces-40226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBC83DCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B141F255D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63AF1CA90;
	Fri, 26 Jan 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cQgN1XDy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F99134B1;
	Fri, 26 Jan 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280841; cv=none; b=PzBf2Y1JGsaa7uYxPA79jOjaJoR11pH9atzuHz7IHrocb6AlooDs1MMrzGLM3ZIhSw5KpE92tlzk0uYqypZr/uy28H9R/mAHH0OMVDvNhZJbZFt9XBjq2mQF2/cAciLyfyKnmTPcFQ3SgxOn5ziGqKWNdURjhvDB7TtsgHHspqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280841; c=relaxed/simple;
	bh=1j1a87TYuL7HVJgjDjSKLga0ol8xwDXznY29YeCIAn0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE35pcuykRj1rLrNpwQ4kmkRICGE6luOhGKKZWZUDrAPdjdhzWtWG/sifLvsbjFw0FyEmGuadzslZ1/JUBTdY6HVo5af5N/FOpQ1gppAoHP/BLSjUCFJAJasyO8JNmK6/bwNw469umvhPuNROMP0Ojn8PP24jt77Zsl9h4JSMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cQgN1XDy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QEoqt2015147;
	Fri, 26 Jan 2024 14:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=rjJO8r+D56PlvTquNfeBs
	vaogxnc+8WZ9L1wd1K3rlA=; b=cQgN1XDykPRpatZxr6j0GyJLViq29Sy0gciHr
	KMnyk1GFjCika2PqsWyeLjKBnWh8JJJpPKEQ8duXrZaKc2YELD9JYxCMAskOP58s
	TmA2YQ2j10hSkUDCTby8Gw+9YrsGQr9BhmLg7ltyhIcdEUXkvjyPsKpkqkTwAWb7
	A20EnstrImO8BWpSD/ov/huypoC71iNIEh/leeY7z8tUXSeUz1gPqHj+0t45LUZn
	k0u/QOhHELWC1xbm6bkPilSsW9/BHsQArrmMWEMkxQfRlhQs6mUUmf59u0i9InS8
	Mj7BrvoxQnfIJbbnEBttheIX4vw67YDN6HAI8ivwlsl0tM+FQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv8e88sgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:53:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QErlUx010339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:53:47 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 06:53:47 -0800
Date: Fri, 26 Jan 2024 06:53:46 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Johan Hovold <johan@kernel.org>
CC: Daniel Thompson <daniel.thompson@linaro.org>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp-x13s: Fix/enable
 touchscreen
Message-ID: <20240126145346.GN2936378@hu-bjorande-lv.qualcomm.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
 <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
 <20240126130232.GA5506@aspen.lan>
 <ZbPCJv7HW8OQzPMT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZbPCJv7HW8OQzPMT@hovoldconsulting.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mkK8KsKyC34BE9-QgIYjMpicC3bbLL3n
X-Proofpoint-ORIG-GUID: mkK8KsKyC34BE9-QgIYjMpicC3bbLL3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260109

On Fri, Jan 26, 2024 at 03:31:02PM +0100, Johan Hovold wrote:
> On Fri, Jan 26, 2024 at 01:02:32PM +0000, Daniel Thompson wrote:
> > On Fri, Jan 26, 2024 at 09:12:37AM +0100, Johan Hovold wrote:
> > > On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > > > The failing read-test in __i2c_hid_core_probe() determines that there's
> > > > nothing connected at the documented address of the touchscreen.
> > > >
> > > > Introduce the 5ms after-power and 200ms after-reset delays found in the
> > > > ACPI tables. Also wire up the reset-gpio, for good measure.
> > >
> > > As the supplies for the touchscreen are always on (and left on by the
> > > bootloader) it would seem that it is really the addition of the reset
> > > gpio which makes things work here. Unless the delay is needed for some
> > > other reason.
> > >
> > > (The power-on delay also looks a bit short compared to what is used for
> > > other devices.)
> > >
> > > Reset support was only recently added with commit 2be404486c05 ("HID:
> > > i2c-hid-of: Add reset GPIO support to i2c-hid-of") so we should not
> > > backport this one before first determining that.
> > 
> > This comment attracted my attention so I tried booting with each of the
> > three lines individually.
> > 
> > On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > > +             reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> > 
> > This is not enough, on it's own, to get the touch screen running.
> > 
> > I guess that's not so much of a surprise since the rebind-the-driver
> > from userspace trick wouldn't have been touching this reset.
> 
> Right, I realised that after hitting send.
> 
> For the record, people have successfully been using the touchpad after
> forcing the driver to reprobe through sysfs:
> 
> 	echo 4-0010 >/sys/bus/i2c/drivers/i2c_hid_of/bind
> 
> > > +             post-power-on-delay-ms = <5>;
> > 
> > This line alone is enough (in v6.7.1).
> 
> Thanks for confirming.
> 
> > > +             post-reset-deassert-delay-ms = <200>;
> > 
> > This line alone is also enough!
> 
> Yes, the driver honours this delay regardless of whether a reset gpio is
> defined currently, so this is expected.
> 
> > In short it looks like the delays make the difference and, even a short
> > delay, can fix the problem.
> 
> Right, but since the suppliers are left enabled by the bootloader (and
> never disabled by the kernel), that only begs the question of why this
> makes a difference.
> 

You're right, the supply is kept on by other things, so this isn't the
problem.

> Without the delay, the other HID devices are probing (successfully)
> slightly before, but essentially in parallel with the touchscreen while
> using the same resources. Is that causing trouble somehow?
> 

The difference to those other HID devices is GPIO 99 - the reset pin,
which is configured pull down input from boot - i.e. the chip is held in
reset.

When the HID device is being probed, pinctrl applies &ts0_default starts
driving it high, bringing the device out of reset. But insufficient time
is given for the chip to come up so the I2C read fails.

If you later try to probe again, 200ms has elapsed since the reset was
deasserted (driven high).

Regards,
Bjorn

> Or is there a bug in the i2c controller driver affecting only this
> device that can be worked around by adding a delay before the first
> transfer?
> 
> Johan

