Return-Path: <linux-kernel+bounces-57000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227D284D292
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEAC28B5B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA34126F19;
	Wed,  7 Feb 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H5D3I2wP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7886158;
	Wed,  7 Feb 2024 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336325; cv=none; b=IAEd4jYRNTyA1y08aScY4piTclUXHX5A/uA56OzDg+Q9jCyWjnG3HJphIUFtjuxNWABFcUO5MarFsW4yuVklXX1ux8ytT4wVLOiTxPE567S8eHDAWpJkx8Ij7g3OeczDhvegNbPsJP5WSQPxh0P8YDJnLEASnxozHkcAJGIQR5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336325; c=relaxed/simple;
	bh=GcCrKy7PL6NdF5frS+UjafEVO5ifA2D7zV4+wqU/FcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ho2+TltPluXp+RP4AkhbbZvGaPMOckuRb23br2k8h1WDCuurWNMagbZY7+dwh7Vh0vVGgY3dYjSed1yZTK8P8SJ7O8zXUFzyC+PIGaBmvz9aBKhHzjJnmn3Iv+859u9DEsYxy/1B7bAsCHrhD88U5kAjOAPejhzBJIHVxqcImZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H5D3I2wP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417GMhfn002137;
	Wed, 7 Feb 2024 20:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fhRVKEHpe8MsrBlNncNCc93DuwM0zD4mv5ixgCfCuCQ=; b=H5
	D3I2wPmhXrdcCdnVNfue4KWRi7SoVnpgM9ADaSKPcLmiunRhwNtt5DaiTPGU9AkG
	wUCDNaVWftk/MvDa9zTXlQedv6FCrKlcptrWFbAdT/y33NpFvPAbL5DG0HbRqz9z
	/TNGgsx5Opb9Pgk1pxGnmgqRcoj0dJtFcVfWwsXlGkhX/lYS5vRwYFJ/fXP4B7YJ
	CqQwHDBFfNKbJX9KgXrtLAEIMr/F8kdmtktbziEiFN20dtyOj9FoHeKh5rNljosW
	QceLHUx0SJxv2pkUtBpQiI3vcaoCLO3Ku5CP/AzHRMPRVIGjPGmO7rSxXjleZOum
	2dIym7/m79HAwffRKCHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w3x41tc5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 20:05:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417K5CGs027482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 20:05:12 GMT
Received: from [10.110.9.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 12:05:11 -0800
Message-ID: <092a230a-05cb-48ae-daa0-607b15b30177@quicinc.com>
Date: Wed, 7 Feb 2024 12:05:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] drm/msm/dpu: support binding to the mdp5 devices
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn
 Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240106-fd-migrate-mdp5-v3-0-3d2750378063@linaro.org>
 <20240106-fd-migrate-mdp5-v3-2-3d2750378063@linaro.org>
 <b10d6097-b13d-4b47-7127-9200e414b7be@quicinc.com>
 <CAA8EJppV_PYMyJBEogONrDVmZ91XmMkr=J0tsioO20GaAW8GoQ@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAA8EJppV_PYMyJBEogONrDVmZ91XmMkr=J0tsioO20GaAW8GoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XUIiVlPM9QKQg9gobVX05fG-ykNAFtQT
X-Proofpoint-GUID: XUIiVlPM9QKQg9gobVX05fG-ykNAFtQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_09,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070149



On 2/7/2024 11:56 AM, Dmitry Baryshkov wrote:
> On Wed, 7 Feb 2024 at 20:48, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>>
>>
>> On 1/5/2024 3:34 PM, Dmitry Baryshkov wrote:
>>> Existing MDP5 devices have slightly different bindings. The main
>>> register region is called `mdp_phys' instead of `mdp'. Also vbif
>>> register regions are a part of the parent, MDSS device. Add support for
>>> handling this binding differences.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 98 ++++++++++++++++++++++++++-------
>>>    drivers/gpu/drm/msm/msm_drv.h           |  3 +
>>>    drivers/gpu/drm/msm/msm_io_utils.c      | 13 +++++
>>>    3 files changed, 93 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> index 723cc1d82143..aa9e0ad33ebb 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> @@ -1197,6 +1197,78 @@ static int dpu_kms_init(struct drm_device *ddev)
>>>        return 0;
>>>    }
>>>
>>> +static int dpu_kms_mmap_mdp5(struct dpu_kms *dpu_kms)
>>> +{
>>> +     struct platform_device *pdev = dpu_kms->pdev;
>>> +     struct platform_device *mdss_dev;
>>> +     int ret;
>>> +
>>> +     if (dpu_kms->pdev->dev.bus != &platform_bus_type)
>>> +             return -EINVAL;
>>> +
>>
>> !dev_is_platform() perhaps?
> 
> looks good
> 
>>
>> But I would like to understand this check a bit more. Can you pls
>> explain for which case this check was added?
> 
> It is necessary to be sure that we can perform to_platform_device() on
> the next line.
> 

Got it but on the next line we are using to_platform_device on dpu's 
parent device. So shouldnt the check also be dpu_kms->pdev->dev.parent.bus?

>>
>>> +     mdss_dev = to_platform_device(dpu_kms->pdev->dev.parent);
>>> +
>>> +     dpu_kms->mmio = msm_ioremap(pdev, "mdp_phys");
>>> +     if (IS_ERR(dpu_kms->mmio)) {
>>> +             ret = PTR_ERR(dpu_kms->mmio);
>>> +             DPU_ERROR("mdp register memory map failed: %d\n", ret);
>>> +             dpu_kms->mmio = NULL;
>>> +             return ret;
>>> +     }
>>> +     DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
>>> +
>>> +     dpu_kms->vbif[VBIF_RT] = msm_ioremap_mdss(mdss_dev,
>>> +                                               dpu_kms->pdev,
>>> +                                               "vbif_phys");
>>> +     if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
>>> +             ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
>>> +             DPU_ERROR("vbif register memory map failed: %d\n", ret);
>>> +             dpu_kms->vbif[VBIF_RT] = NULL;
>>> +             return ret;
>>> +     }
>>> +
>>> +     dpu_kms->vbif[VBIF_NRT] = msm_ioremap_mdss(mdss_dev,
>>> +                                                dpu_kms->pdev,
>>> +                                                "vbif_nrt_phys");
>>
>> Do you think a "quiet" version would be better?
> 
> Yep, why not.
> 
>>
>>
>>> +     if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
>>> +             dpu_kms->vbif[VBIF_NRT] = NULL;
>>> +             DPU_DEBUG("VBIF NRT is not defined");
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int dpu_kms_mmap_dpu(struct dpu_kms *dpu_kms)
>>> +{
>>> +     struct platform_device *pdev = dpu_kms->pdev;
>>> +     int ret;
>>> +
>>> +     dpu_kms->mmio = msm_ioremap(pdev, "mdp");
>>> +     if (IS_ERR(dpu_kms->mmio)) {
>>> +             ret = PTR_ERR(dpu_kms->mmio);
>>> +             DPU_ERROR("mdp register memory map failed: %d\n", ret);
>>> +             dpu_kms->mmio = NULL;
>>> +             return ret;
>>> +     }
>>> +     DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
>>> +
>>> +     dpu_kms->vbif[VBIF_RT] = msm_ioremap(pdev, "vbif");
>>> +     if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
>>> +             ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
>>> +             DPU_ERROR("vbif register memory map failed: %d\n", ret);
>>> +             dpu_kms->vbif[VBIF_RT] = NULL;
>>> +             return ret;
>>> +     }
>>> +
>>> +     dpu_kms->vbif[VBIF_NRT] = msm_ioremap_quiet(pdev, "vbif_nrt");
>>> +     if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
>>> +             dpu_kms->vbif[VBIF_NRT] = NULL;
>>> +             DPU_DEBUG("VBIF NRT is not defined");
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    static int dpu_dev_probe(struct platform_device *pdev)
>>>    {
>>>        struct device *dev = &pdev->dev;
>>> @@ -1230,28 +1302,12 @@ static int dpu_dev_probe(struct platform_device *pdev)
>>>
>>>        dpu_kms->base.irq = irq;
>>>
>>> -     dpu_kms->mmio = msm_ioremap(pdev, "mdp");
>>> -     if (IS_ERR(dpu_kms->mmio)) {
>>> -             ret = PTR_ERR(dpu_kms->mmio);
>>> -             DPU_ERROR("mdp register memory map failed: %d\n", ret);
>>> -             dpu_kms->mmio = NULL;
>>> -             return ret;
>>> -     }
>>> -     DRM_DEBUG("mapped dpu address space @%pK\n", dpu_kms->mmio);
>>> -
>>> -     dpu_kms->vbif[VBIF_RT] = msm_ioremap(pdev, "vbif");
>>> -     if (IS_ERR(dpu_kms->vbif[VBIF_RT])) {
>>> -             ret = PTR_ERR(dpu_kms->vbif[VBIF_RT]);
>>> -             DPU_ERROR("vbif register memory map failed: %d\n", ret);
>>> -             dpu_kms->vbif[VBIF_RT] = NULL;
>>> +     if (of_device_is_compatible(dpu_kms->pdev->dev.of_node, "qcom,mdp5"))
>>> +             ret = dpu_kms_mmap_mdp5(dpu_kms);
>>> +     else
>>> +             ret = dpu_kms_mmap_dpu(dpu_kms);
>>> +     if (ret)
>>>                return ret;
>>> -     }
>>> -
>>> -     dpu_kms->vbif[VBIF_NRT] = msm_ioremap_quiet(pdev, "vbif_nrt");
>>> -     if (IS_ERR(dpu_kms->vbif[VBIF_NRT])) {
>>> -             dpu_kms->vbif[VBIF_NRT] = NULL;
>>> -             DPU_DEBUG("VBIF NRT is not defined");
>>> -     }
>>>
>>>        ret = dpu_kms_parse_data_bus_icc_path(dpu_kms);
>>>        if (ret)
>>> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
>>> index 16a7cbc0b7dd..01e783130054 100644
>>> --- a/drivers/gpu/drm/msm/msm_drv.h
>>> +++ b/drivers/gpu/drm/msm/msm_drv.h
>>> @@ -476,6 +476,9 @@ void __iomem *msm_ioremap(struct platform_device *pdev, const char *name);
>>>    void __iomem *msm_ioremap_size(struct platform_device *pdev, const char *name,
>>>                phys_addr_t *size);
>>>    void __iomem *msm_ioremap_quiet(struct platform_device *pdev, const char *name);
>>> +void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
>>> +                            struct platform_device *dev,
>>> +                            const char *name);
>>>
>>>    struct icc_path *msm_icc_get(struct device *dev, const char *name);
>>>
>>> diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
>>> index 59d2788c4510..afedd61c3e28 100644
>>> --- a/drivers/gpu/drm/msm/msm_io_utils.c
>>> +++ b/drivers/gpu/drm/msm/msm_io_utils.c
>>> @@ -50,6 +50,19 @@ struct clk *msm_clk_get(struct platform_device *pdev, const char *name)
>>>        return clk;
>>>    }
>>>
>>> +void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
>>> +                            struct platform_device *pdev,
>>> +                            const char *name)
>>> +{
>>> +     struct resource *res;
>>> +
>>> +     res = platform_get_resource_byname(mdss_pdev, IORESOURCE_MEM, name);
>>> +     if (!res)
>>> +             return ERR_PTR(-EINVAL);
>>> +
>>> +     return devm_ioremap_resource(&pdev->dev, res);
>>> +}
>>> +
>>>    static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name,
>>>                                  bool quiet, phys_addr_t *psize)
>>>    {
>>>
> 
> 
> 

