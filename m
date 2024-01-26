Return-Path: <linux-kernel+bounces-40241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5272A83DD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CC61F220BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3FB1CD3C;
	Fri, 26 Jan 2024 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FaE03Ch/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CB1B970;
	Fri, 26 Jan 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706281528; cv=none; b=Qzf92lBbhU8ctDZmIHNMjZZE/kzZ4xWMLBTLy1mrIJwTyseUzRf7IZlzsgb83oDj3YQepQrGNwpkJLt3nvZqSLxfEPLWOAePDEbDVWs+GfrleWFjStGJh6kpahiUfCQ2TCT4ESY97hhdM6oUMfjPDlDJOUU5ul1yYX5cdWjWCd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706281528; c=relaxed/simple;
	bh=U+99tjIt56hBCPSlbSxS/+VqtJhV/6wL04M231JSrzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOKTg0xi6xqlaxaaw51wNawJHsWlN5Cp6/GuS8K8Aina7Ibd9jEgkJdu2//UFbBQT10ffXgAX78BA6DEG+5QWjWUq2h+RV+8sBDLyHFK+WR3W0OUkiSWNsqy30MB0b9MmAcEynvkNaIJQ9U2xIWI97aBpyawHk7ZH9+nu7HthU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FaE03Ch/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QDirPM006836;
	Fri, 26 Jan 2024 15:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=jHB9hK1+IxDYTk3mHsGBs
	lK9MjCNeNeTQmuomB3w7zM=; b=FaE03Ch/Jzfiv1T2d8ixQbSUtaq1l9MO5jj8n
	yRFebQlkMJBdnxqtn6tchK1EdBTeT2ELjVlWC/Qdc6Jem7DazcTNPoKiA5GK1y+P
	QqFTc8VJ3vZF+mHDkRnpgNWKBevBWtgw2ksSZx/yIxPIrC/vVTRut69wCoXhaM4d
	2WU9VV5pc8NdWJXdnk4f/Lv6uyV21FVBosmjwYEQLt92vWF1NQDOVAZM1ujh7cSE
	R9TCiCONAxMWHnPtXFga7TNVvHCpE3ZkeG7VIUGTKya2pBpwOvRuKvpZZHHJOD/X
	j7d1WaQ+MKfqqlWqjlpAzLHJOtCbhCTGN2LahcOaZS01YapPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4cascjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:05:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QF5DHx029835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 15:05:13 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 07:05:12 -0800
Date: Fri, 26 Jan 2024 07:05:11 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: Johan Hovold <johan@kernel.org>,
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
Message-ID: <20240126150511.GO2936378@hu-bjorande-lv.qualcomm.com>
References: <20240125-x13s-touchscreen-v1-0-ab8c882def9c@quicinc.com>
 <20240125-x13s-touchscreen-v1-2-ab8c882def9c@quicinc.com>
 <ZbNpdaSyFS9tYrkd@hovoldconsulting.com>
 <20240126130232.GA5506@aspen.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240126130232.GA5506@aspen.lan>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zkWHTT7R8Yj7UAoh4kZBsPEbusf-OyKI
X-Proofpoint-GUID: zkWHTT7R8Yj7UAoh4kZBsPEbusf-OyKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260110

On Fri, Jan 26, 2024 at 01:02:32PM +0000, Daniel Thompson wrote:
> On Fri, Jan 26, 2024 at 09:12:37AM +0100, Johan Hovold wrote:
> > On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > > The failing read-test in __i2c_hid_core_probe() determines that there's
> > > nothing connected at the documented address of the touchscreen.
> > >
> > > Introduce the 5ms after-power and 200ms after-reset delays found in the
> > > ACPI tables. Also wire up the reset-gpio, for good measure.
> >
> > As the supplies for the touchscreen are always on (and left on by the
> > bootloader) it would seem that it is really the addition of the reset
> > gpio which makes things work here. Unless the delay is needed for some
> > other reason.
> >
> > (The power-on delay also looks a bit short compared to what is used for
> > other devices.)
> >
> > Reset support was only recently added with commit 2be404486c05 ("HID:
> > i2c-hid-of: Add reset GPIO support to i2c-hid-of") so we should not
> > backport this one before first determining that.
> 
> This comment attracted my attention so I tried booting with each of the
> three lines individually.
> 
> 
> On Thu, Jan 25, 2024 at 07:55:14PM -0800, Bjorn Andersson wrote:
> > +             reset-gpios = <&tlmm 99 GPIO_ACTIVE_LOW>;
> 
> This is not enough, on it's own, to get the touch screen running.
> 

No, because pinctrl already brings the chip out of reset without this.

> I guess that's not so much of a surprise since the rebind-the-driver
> from userspace trick wouldn't have been touching this reset.
> 

Right, it would just have been left deasserted from the first attempt.

That said, the addition of the reset means that we're now asserting
reset in such rebind attempts. And as such the
post-reset-deassert-delay-ms is now needed between the explicit deassert
from the driver and the i2c read.

> 
> > +             post-power-on-delay-ms = <5>;
> 
> This line alone is enough (in v6.7.1).
> 

So the delay taken through really_probe() until we reach that i2c read
is almost the entire delay needed, on your specific device.

> 
> > +             post-reset-deassert-delay-ms = <200>;
> 
> This line alone is also enough!
> 
> In short it looks like the delays make the difference and, even a short
> delay, can fix the problem.
> 
> Of course, regardless of the line-by-line results I also ran with all
> the changes so, FWIW:
> Tested-by: Daniel Thompson <daniel.thompson@linaro.org>
> 

Thanks,
Bjorn

> 
> Daniel.

