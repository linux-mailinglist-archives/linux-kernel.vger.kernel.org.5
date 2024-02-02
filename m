Return-Path: <linux-kernel+bounces-49670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DD846DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E51BB23D50
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183CB7C0B6;
	Fri,  2 Feb 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BTsbKr6G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58C7C0A4;
	Fri,  2 Feb 2024 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869525; cv=none; b=Gghw0iNHEF88KtCnsLzbI5FfbU5keFN6JTxIe3DfrBIFniTsldQpTv+cKRy7qP6E1aa7hjmZ2KKQHQD5ZbYEUyi6bBfDYwsLF2fR/DYvWBLgjUEBwyuZq0ttWECRXK/TCgd567InJgcnv2X/vbcCvYiH38DSM1nC6SbG6DSfQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869525; c=relaxed/simple;
	bh=u4sJKtSk54wQgUyn68IoBS+Mh9GWAoft79AKkN9he1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LGT1ErpW57HmZm1qdSm5TlijtNX7FOeHs0famiULKIzx0ZuAh9mohFdzVo7g3Nfj0M1MVSvdJ28+5YUlkJH/KZxtUni2ljB9MvIG7hyVLOksj5J6fS05tazvK4ibr1PEXCXh7zmg4mxo6buz00tOhdGPX0dR+Qgah1yIvJT+euY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BTsbKr6G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126YlDA013355;
	Fri, 2 Feb 2024 10:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gLZJpiBD39Y8migvDMg1XNW1md0helkHFYv/jFdLzWU=; b=BT
	sbKr6Ge7i80MDyYsadQBnqh9b/Np82eFaPFrini5g9rz8aDFvyP7dVjOvRLFGtRe
	Hg2fsquo3MrIgSUafYZyp765bjqfdvaGaLEmYJkDyRYiQ9Ruhxg4nLOG3w2AdJPW
	6J+ze98SN7SEQz5o9dmre45ref6RG9IFWmdFJnW399nySUwzv1KapSY/+WpcBtjG
	+yAa9syxAXv858/2DXzboB6EXju3IPjlKNDnY/MaLK8avPbu7ivPhGAgYlW+myNm
	8gJwTwaus42tmB4deUxSsjNfYm4cHUNC/nNBcrUz4my0RAINonRGIR3bWNPHFrvt
	aZxxPBOvbvIZwko90tDg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptyh3vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:25:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412AP4c9008970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:25:04 GMT
Received: from [10.50.50.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 02:25:00 -0800
Message-ID: <50c3abcd-cd2e-4ef6-9462-efe3017e70dc@quicinc.com>
Date: Fri, 2 Feb 2024 15:54:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm: Add drm_get_acpi_edid() helper
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Mark
 Pearson <mpearson-lenovo@squebb.ca>
References: <20240201221119.42564-1-mario.limonciello@amd.com>
 <20240201221119.42564-3-mario.limonciello@amd.com>
From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
In-Reply-To: <20240201221119.42564-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rexgPSLyqAohsLaQPymfnNmgr96GlYMP
X-Proofpoint-GUID: rexgPSLyqAohsLaQPymfnNmgr96GlYMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020075


On 2/2/2024 3:41 AM, Mario Limonciello wrote:
> Some manufacturers have intentionally put an EDID that differs from
> the EDID on the internal panel on laptops.  Drivers can call this
> helper to attempt to fetch the EDID from the BIOS's ACPI _DDC method.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Split code from previous amdgpu specific helper to generic drm helper.
> v2->v3:
>   * Add an extra select to fix a variety of randconfig errors found from
>     LKP robot.
> ---
>   drivers/gpu/drm/Kconfig    |  5 +++
>   drivers/gpu/drm/drm_edid.c | 73 ++++++++++++++++++++++++++++++++++++++
>   include/drm/drm_edid.h     |  1 +
>   3 files changed, 79 insertions(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 2520db0b776e..14df907c96c8 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -21,6 +21,11 @@ menuconfig DRM
>   	select KCMP
>   	select VIDEO_CMDLINE
>   	select VIDEO_NOMODESET
> +	select ACPI_VIDEO if ACPI
> +	select BACKLIGHT_CLASS_DEVICE if ACPI
> +	select INPUT if ACPI
> +	select X86_PLATFORM_DEVICES if ACPI && X86
> +	select ACPI_WMI if ACPI && X86
>   	help
>   	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
>   	  introduced in XFree86 4.0. If you say Y here, you need to select
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 69c68804023f..1fbbeaa664b2 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -28,6 +28,7 @@
>    * DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include <acpi/video.h>
>   #include <linux/bitfield.h>
>   #include <linux/cec.h>
>   #include <linux/hdmi.h>
> @@ -2188,6 +2189,47 @@ drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
>   	return ret == xfers ? 0 : -1;
>   }
>   
> +/**
> + * drm_do_probe_acpi_edid() - get EDID information via ACPI _DDC
> + * @data: struct drm_device
> + * @buf: EDID data buffer to be filled
> + * @block: 128 byte EDID block to start fetching from
> + * @len: EDID data buffer length to fetch
> + *
> + * Try to fetch EDID information by calling acpi_video_get_edid() function.
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +static int
> +drm_do_probe_acpi_edid(void *data, u8 *buf, unsigned int block, size_t len)
> +{
> +	struct drm_device *ddev = data;
> +	struct acpi_device *acpidev = ACPI_COMPANION(ddev->dev);
> +	unsigned char start = block * EDID_LENGTH;
> +	void *edid;
> +	int r;
> +
> +	if (!acpidev)
> +		return -ENODEV;
> +
> +	/* fetch the entire edid from BIOS */
> +	r = acpi_video_get_edid(acpidev, ACPI_VIDEO_DISPLAY_LCD, -1, &edid);
> +	if (r < 0) {
> +		DRM_DEBUG_KMS("Failed to get EDID from ACPI: %d\n", r);
> +		return -EINVAL;
> +	}
> +	if (len > r || start > r || start + len > r) {
> +		r = EINVAL;
-EINVAL ?
> +		goto cleanup;
> +	}
> +
> +	memcpy(buf, edid + start, len);
> +	r = 0;
New line before goto label?
> +cleanup:
> +	kfree(edid);
> +	return r;
> +}
> +
>   static void connector_bad_edid(struct drm_connector *connector,
>   			       const struct edid *edid, int num_blocks)
>   {
> @@ -2643,6 +2685,37 @@ struct edid *drm_get_edid(struct drm_connector *connector,
>   }
>   EXPORT_SYMBOL(drm_get_edid);
>   
> +/**
> + * drm_get_acpi_edid - get EDID data, if available
> + * @connector: connector we're probing
> + *
> + * Use the BIOS to attempt to grab EDID data if possible.  If found,
> + * attach it to the connector.
> + *
> + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> + */
> +struct edid *drm_get_acpi_edid(struct drm_connector *connector)
> +{
> +	struct edid *edid = NULL;
> +
> +	switch (connector->connector_type) {
> +	case DRM_MODE_CONNECTOR_LVDS:
> +	case DRM_MODE_CONNECTOR_eDP:
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	if (connector->force == DRM_FORCE_OFF)
> +		return NULL;
> +
> +	edid = _drm_do_get_edid(connector, drm_do_probe_acpi_edid, connector->dev, NULL);
> +
> +	drm_connector_update_edid_property(connector, edid);
> +	return edid;
> +}
> +EXPORT_SYMBOL(drm_get_acpi_edid);
> +
>   /**
>    * drm_edid_read_custom - Read EDID data using given EDID block read function
>    * @connector: Connector to use
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 518d1b8106c7..60fbdc06badc 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -412,6 +412,7 @@ struct edid *drm_do_get_edid(struct drm_connector *connector,
>   	void *data);
>   struct edid *drm_get_edid(struct drm_connector *connector,
>   			  struct i2c_adapter *adapter);
> +struct edid *drm_get_acpi_edid(struct drm_connector *connector);
>   u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>   struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>   				     struct i2c_adapter *adapter);

New line before return ?


