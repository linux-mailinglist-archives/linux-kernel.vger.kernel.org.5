Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9B771D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjHGJmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjHGJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:42:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C4F810C1;
        Mon,  7 Aug 2023 02:42:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7DA1FB;
        Mon,  7 Aug 2023 02:43:03 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E5353F59C;
        Mon,  7 Aug 2023 02:42:17 -0700 (PDT)
Message-ID: <73a5313d-9ab2-f5f9-42af-c3d9939198c6@arm.com>
Date:   Mon, 7 Aug 2023 10:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 07/13] coresight-tpdm: Add nodes to set trigger
 timestamp and type
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-8-git-send-email-quic_taozha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <1690269353-10829-8-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:15, Tao Zhang wrote:
> The nodes are needed to set or show the trigger timestamp and
> trigger type. This change is to add these nodes to achieve these
> function.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 24 ++++++
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 94 ++++++++++++++++++++++
>   2 files changed, 118 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> index dbc2fbd0..0b7b4ad 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> @@ -21,3 +21,27 @@ Description:
>   
>   		Accepts only one value -  1.
>   		1 : Reset the dataset of the tpdm
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the trigger type of DSB tpdm. Read the trigger
> +		type of DSB tpdm.

Please use: (RW) instead of (Write).

		(RW) Set/Get the trigger type of the DSB for TPDM.
Similarly for the items below.

> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB trigger type to false
> +		1 : Set the DSB trigger type to true
> +
> +What:		/sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
> +Date:		March 2023
> +KernelVersion	6.5
> +Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
> +Description:
> +		(Write) Set the trigger timestamp of DSB tpdm. Read the
> +		trigger timestamp of DSB tpdm.
> +
> +		Accepts only one of the 2 values -  0 or 1.
> +		0 : Set the DSB trigger type to false
> +		1 : Set the DSB trigger type to true
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> index acc3eea..62efc18 100644
> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -20,6 +20,18 @@
>   
>   DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>   
> +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
> +					   struct attribute *attr, int n)

Please keep the alignment.

> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	if (drvdata && (drvdata->datasets & TPDM_PIDR0_DS_DSB))

As suggested earlier, add a wrapper for the above check.

> +		return attr->mode;
> +
> +	return 0;
> +}
> +
>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>   {
>   	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
> @@ -229,8 +241,90 @@ static struct attribute_group tpdm_attr_grp = {
>   	.attrs = tpdm_attrs,
>   };
>   
> +static ssize_t dsb_trig_type_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)

Please follow the above alignment for all functions throughout the 
series. There are unaligned parameter lists scattered around the series.

> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->trig_type);
> +}
> +
> +/*
> + * Trigger type (boolean):
> + * false - Disable trigger type.
> + * true  - Enable trigger type.
> + */
> +static ssize_t dsb_trig_type_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->trig_type = true;
> +	else
> +		drvdata->dsb->trig_type = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_type);
> +
> +static ssize_t dsb_trig_ts_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +
> +	return sysfs_emit(buf, "%u\n",
> +			 (unsigned int)drvdata->dsb->trig_ts);
> +}
> +
> +/*
> + * Trigger timestamp (boolean):
> + * false - Disable trigger timestamp.
> + * true  - Enable trigger timestamp.
> + */
> +static ssize_t dsb_trig_ts_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t size)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> +	unsigned long val;
> +
> +	if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
> +		return -EINVAL;
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (val)
> +		drvdata->dsb->trig_ts = true;
> +	else
> +		drvdata->dsb->trig_ts = false;
> +	spin_unlock(&drvdata->spinlock);
> +	return size;
> +}
> +static DEVICE_ATTR_RW(dsb_trig_ts);
> +
> +static struct attribute *tpdm_dsb_attrs[] = {
> +	&dev_attr_dsb_trig_ts.attr,
> +	&dev_attr_dsb_trig_type.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group tpdm_dsb_attr_grp = {
> +	.attrs = tpdm_dsb_attrs,
> +	.is_visible = tpdm_dsb_is_visible,
> +};
> +
>   static const struct attribute_group *tpdm_attr_grps[] = {
>   	&tpdm_attr_grp,
> +	&tpdm_dsb_attr_grp,
>   	NULL,
>   };
>   

Rest looks fine.

Suzuk

