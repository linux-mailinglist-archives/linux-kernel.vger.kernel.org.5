Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8B37A02B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbjINLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjINLeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:34:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF811FC9;
        Thu, 14 Sep 2023 04:34:16 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EBOZ2p011614;
        Thu, 14 Sep 2023 11:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=v/rgcR0kkyQPdpyr7j0ww+hfbXTrJx0WvQpvJwPUWPI=;
 b=Ced2txkveHOCo78dV1YmnFJi6JFO7m2vMd3GxbSoDqUK5z9ti88yGjGdh6Lp7Kr5ThST
 9BjFuXOQdIpQ/Y7YpoTYGCgnRFjwRyVx6olghbQYs1pOwaq4Ibei+wrnl4ftZNNgLEmg
 j3ECyPTVE0BuqwdA792jekhXVPKx/UlFhJ8Bo23zxFqYKpdqZmW1LBgZswRkxX7O14xV
 VGaTLRxMVksPw8Iy9SfRbmHKEqtrySckoQBdYDBKLDelMUCQ2xTlexHWhWgu7mmWnWWu
 OccHa3fWtz3iTnGFLa134C+0VXr8m85r90KBzLBChxpoplrCSqhijqOGhHg5x6I8i5ys TQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3r15sart-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:33:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EBXWBD030265
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 11:33:32 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 14 Sep
 2023 04:33:27 -0700
Message-ID: <8a9cc52c-9c7d-1f8f-8a98-1a816f59aa79@quicinc.com>
Date:   Thu, 14 Sep 2023 17:03:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/6] scsi: ufs: ufs-sysfs: Expose UFS power info
To:     Can Guo <quic_cang@quicinc.com>, <mani@kernel.org>,
        <quic_nguyenb@quicinc.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <beanhuo@micron.com>,
        "Arthur Simchaev" <arthur.simchaev@wdc.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        "open list" <linux-kernel@vger.kernel.org>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <1694411968-14413-6-git-send-email-quic_cang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XIyqZAed4Z4Jm6wGSYLkz5OKfSPiDUvD
X-Proofpoint-ORIG-GUID: XIyqZAed4Z4Jm6wGSYLkz5OKfSPiDUvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2023 11:29 AM, Can Guo wrote:
> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bounch of power saving
> features and various combinations for backward compatiblity.

Please fix spelling mistake - *bounch -> bunch


> 
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>   drivers/ufs/core/ufs-sysfs.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
> index c959064..53af490 100644
> --- a/drivers/ufs/core/ufs-sysfs.c
> +++ b/drivers/ufs/core/ufs-sysfs.c
> @@ -628,6 +628,76 @@ static const struct attribute_group ufs_sysfs_monitor_group = {
>   	.attrs = ufs_sysfs_monitor_attrs,
>   };
>   
> +static ssize_t gear_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.gear_rx);
> +}
> +
> +static ssize_t lane_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.lane_rx);
> +}
> +
> +static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.pwr_rx);
> +}
> +
> +static ssize_t rate_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%u\n", hba->pwr_info.hs_rate);
> +}
> +
> +static ssize_t dev_pm_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->curr_dev_pwr_mode);
> +}
> +
> +static ssize_t link_state_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct ufs_hba *hba = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", hba->uic_link_state);
> +}
> +
> +static DEVICE_ATTR_RO(gear);
> +static DEVICE_ATTR_RO(lane);
> +static DEVICE_ATTR_RO(mode);
> +static DEVICE_ATTR_RO(rate);
> +static DEVICE_ATTR_RO(dev_pm);
> +static DEVICE_ATTR_RO(link_state);
> +
> +static struct attribute *ufs_power_info_attrs[] = {
> +	&dev_attr_gear.attr,
> +	&dev_attr_lane.attr,
> +	&dev_attr_mode.attr,
> +	&dev_attr_rate.attr,
> +	&dev_attr_dev_pm.attr,
> +	&dev_attr_link_state.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ufs_sysfs_power_info_group = {
> +	.name = "power_info",
> +	.attrs = ufs_power_info_attrs,
> +};
> +
>   static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
>   				  enum desc_idn desc_id,
>   				  u8 desc_index,
> @@ -1233,6 +1303,7 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
>   	&ufs_sysfs_default_group,
>   	&ufs_sysfs_capabilities_group,
>   	&ufs_sysfs_monitor_group,
> +	&ufs_sysfs_power_info_group,
>   	&ufs_sysfs_device_descriptor_group,
>   	&ufs_sysfs_interconnect_descriptor_group,
>   	&ufs_sysfs_geometry_descriptor_group,


How about having one power mode attribute displaying all useful info 
(lane, gear, mode, rate).

Regards,
Nitin Rawat
