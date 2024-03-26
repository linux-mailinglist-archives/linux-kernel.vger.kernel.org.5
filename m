Return-Path: <linux-kernel+bounces-120031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C836F88D086
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4D328365
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE013DB8C;
	Tue, 26 Mar 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fdN7hXKw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA916FE16;
	Tue, 26 Mar 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490978; cv=none; b=N/ZW3pSObzYB9UT9KWqUIVlTWl1+7z/1giCfVyeCvyTVF1M53Vx/WMvKHrSrzneDa+hqUqVG1bYK7D+IFahODfM0yqHPppxDDusbTuS7d0GkCmh4ZPph4A1nvDIVf2xliw5mHTVaRDg+j/Weaq0tXdh7HksxbJyyOZnGWe4O6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490978; c=relaxed/simple;
	bh=mtMkhn3CfgiqKNePweOv4Nxw2Ho38rO8NpPlXWz4g4M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBEVrCgizkn0BUdeXL81KdV7Db0HQqYxvC9ecIjvZIaR8SOajIVVKTZrAbCO25/1vDW0QoLtjjIbr62Dv658GW37dDtmDfB/i77qSxQAQpIyKh7pNCNvHMb/Ep2RIOAQ0FpIW+ERKTyYgIA3pz/tG5jBNI3UBLOkYeTK4GHyfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fdN7hXKw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QM8CZq028203;
	Tue, 26 Mar 2024 22:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=+QDqt7fkKKNbqUcMuvxF1
	CaKjYlw/mVm2eVrDepyTWY=; b=fdN7hXKwBSOSMoyuzbGLvQrw88Hk5iXYfBFK/
	aH5rbpZcCIQJAoa4fA9xFMa5VgGk8ihJMTwNBZ+m2JzXSrQLzkHFHXCOINtbSRTe
	8uE4QKHI9Jm6fWBADvp8Hln66VGvwA9JC7WXnZsJDR7aItNtzhIfX8hyUwrJKBHa
	b09FQDC9aI8Wd3+0PGCDwFlIf2G5ZQ3MqT+2eN68g0RcoWmUEnR6oTlo/i3Iqjw8
	9lbWC/UqJfRDvIimW8XhfTat5fTJMgrxaBZ0hkGrxOcWH+5SMpScpGk9OBhvzIvV
	vcUr4Zp0N1V045YvJL+ZUGyMlzbFyDxSAa0ojI8tR+VN9UdnQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3w0x9qy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:09:23 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QM9LVS001691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 22:09:21 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 15:09:21 -0700
Date: Tue, 26 Mar 2024 15:09:19 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: <neil.armstrong@linaro.org>
CC: Jameson Thies <jthies@google.com>, <heikki.krogerus@linux.intel.com>,
        <linux-usb@vger.kernel.org>, <pmalani@chromium.org>,
        <bleung@google.com>, <abhishekpandit@chromium.org>,
        <andersson@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <fabrice.gasnier@foss.st.com>, <gregkh@linuxfoundation.org>,
        <hdegoede@redhat.com>, <rajaram.regupathy@intel.com>,
        <saranya.gopal@intel.com>, <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Linux
 regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v4 2/4] usb: typec: ucsi: Register cables based on
 GET_CABLE_PROPERTY
Message-ID: <20240326220919.GA2136359@hu-bjorande-lv.qualcomm.com>
References: <20240305025804.1290919-1-jthies@google.com>
 <20240305025804.1290919-3-jthies@google.com>
 <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44e8142f-d9b3-487b-83fe-39deadddb492@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h-E4Gy2N13WJuPoHmePuq7mzy3MXPXnh
X-Proofpoint-ORIG-GUID: h-E4Gy2N13WJuPoHmePuq7mzy3MXPXnh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_09,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260160

On Mon, Mar 11, 2024 at 06:28:41PM +0100, neil.armstrong@linaro.org wrote:
> On 05/03/2024 03:58, Jameson Thies wrote:
[..]
> With:
> =================><====================================
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index cf52cb34d285..eec64a4c8cdd 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1189,8 +1189,10 @@ static void ucsi_handle_connector_change(struct work_struct *work)
>                         ucsi_register_partner(con);
>                         ucsi_partner_task(con, ucsi_check_connection, 1, HZ);
>                         ucsi_partner_task(con, ucsi_check_connector_capability, 1, HZ);
> -                       ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> -                       ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> +                       if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +                               ucsi_partner_task(con, ucsi_get_partner_identity, 1, HZ);
> +                       if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +                               ucsi_partner_task(con, ucsi_check_cable, 1, HZ);
> 
>                         if (UCSI_CONSTAT_PWR_OPMODE(con->status.flags) ==
>                             UCSI_CONSTAT_PWR_OPMODE_PD)
> @@ -1589,8 +1591,10 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>                 ucsi_register_partner(con);
>                 ucsi_pwr_opmode_change(con);
>                 ucsi_port_psy_changed(con);
> -               ucsi_get_partner_identity(con);
> -               ucsi_check_cable(con);
> +               if (con->ucsi->cap.features & UCSI_CAP_GET_PD_MESSAGE)
> +                       ucsi_get_partner_identity(con);
> +               if (con->ucsi->cap.features & UCSI_CAP_CABLE_DETAILS)
> +                       ucsi_check_cable(con);
>         }
> 
>         /* Only notify USB controller if partner supports USB data */
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 32daf5f58650..2e9c35a3af27 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -215,6 +215,7 @@ struct ucsi_capability {
>  #define UCSI_CAP_CABLE_DETAILS                 BIT(5)
>  #define UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS      BIT(6)
>  #define UCSI_CAP_PD_RESET                      BIT(7)
> +#define UCSI_CAP_GET_PD_MESSAGE                        BIT(8)
>         u16 reserved_1;
>         u8 num_alt_modes;
>         u8 reserved_2;
> =================><====================================
> it works fine again.
> 

The series broke role switching on qcs6490-rb3gen2 (next-20240326 is
broken). You're proposed addition brings it back, thank you.

Was this posted somewhere?

Regards,
Bjorn

