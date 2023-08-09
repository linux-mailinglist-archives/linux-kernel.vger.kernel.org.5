Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB777535A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjHIG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHIG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:59:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B019BC;
        Tue,  8 Aug 2023 23:59:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3795SeCG027257;
        Wed, 9 Aug 2023 06:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1KAZVnnVfcDStYfdro82HDZhSg8f14qqJ8BNvobI0MI=;
 b=NmO4UMS5BE1og9J9/KVjDrglA8BskYsbTW4hGav8OQiyeFSbxmS8Ar5zFabjqWE7gRuB
 /ZL2GrRtSqBpKRyOQnmENfoOz7+aYA8IYG43niI7VSd73/Cuw7OfhiO33fCub3W8YALO
 DrOAo1DbbGiMBO+xz17KuyLS4kOWc4hb9RA1NLfIdoai4VUgrdmdH+3WQFtK7AIv0sA8
 A/qdV1paist9MeTnmE3FBONhI1dpzuS7g4uBb64X/0oBwSEP6CQtN+H1ncRkurIR6pwl
 /MYJNNI8Q+E/4tvFhGItYPzAPDeJTmxxiZjWj5nIE9phJj9j9MidjbHYWGNKrJ3mkAbC qA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbppchurv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 06:59:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3796xGY6030180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 06:59:16 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 23:59:11 -0700
Message-ID: <59a4ce95-0b9d-b48b-73cb-29ade99b28c3@quicinc.com>
Date:   Wed, 9 Aug 2023 14:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 09/13] coresight-tpdm: Add nodes for dsb edge control
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-10-git-send-email-quic_taozha@quicinc.com>
 <4cfd50c3-834c-8f8d-187b-8cfe38d7ece0@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <4cfd50c3-834c-8f8d-187b-8cfe38d7ece0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UGHbLC7AQt45raFVi9WChjgQTJBNgjd3
X-Proofpoint-GUID: UGHbLC7AQt45raFVi9WChjgQTJBNgjd3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090061
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 6:58 PM, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> Add the nodes to set value for DSB edge control and DSB edge
>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>> resgisters to configure edge control. DSB edge detection control
>> 00: Rising edge detection
>> 01: Falling edge detection
>> 10: Rising and falling edge detection (toggle detection)
>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>> configure mask. Eight 32 bit registers providing DSB interface
>> edge detection mask control.
>>
>> Add the nodes to configure DSB edge control and DSB edge control
>> mask. Each DSB subunit TPDM maximum of 256 edge detections can be
>> configured. The index and value sysfs files need to be paired and
>> written to order. The index sysfs file is to set the index number
>> of the edge detection which needs to be configured. And the value
>> sysfs file is to set the control or mask for the edge detection.
>> DSB edge detection control should be set as the following values.
>> 00: Rising edge detection
>> 01: Falling edge detection
>> 10: Rising and falling edge detection (toggle detection)
>> And DSB edge mask should be set as 0 or 1.
>> Each DSB subunit TPDM has maximum of n(n<16) EDCR resgisters to
>> configure edge control. And each DSB subunit TPDM has maximum of
>> m(m<8) ECDMR registers to configure mask.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  39 +++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 158 
>> ++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  30 +++-
>>   3 files changed, 223 insertions(+), 4 deletions(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 2a82cd0..a4550c5 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -60,3 +60,42 @@ Description:
>>           Bit[3] : Set to 0 for low performance mode.
>>                    Set to 1 for high performance mode.
>>           Bit[4:8] : Select byte lane for high performance mode.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_idx
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        Read/Write the index number of the edge detection for the DSB
>> +        subunit TPDM. Since there are at most 256 edge detections, this
>> +        value ranges from 0 to 255.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_val
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        Read a set of the edge control registers of the DSB in TPDM.
>> +        Write a data to control the edge detection corresponding to
>> +        the index number. Before writing data to this sysfs file,
>> +        "dsb_edge_ctrl_idx" should be written first to configure the
>> +        index number of the edge detection which needs to be 
>> controlled.
>> +
>> +        Accepts only one of the following values.
>> +        0 - Rising edge detection
>> +        1 - Falling edge detection
>> +        2 - Rising and falling edge detection (toggle detection)
>> +
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl_mask
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        Read a set of the edge control mask registers of the DSB in 
>> TPDM.
>> +        Write a data to mask the edge detection corresponding to the 
>> index
>> +        number. Before writing data to this sysfs file, 
>> "dsb_edge_ctrl_idx"
>> +        should be written first to configure the index number of the 
>> edge
>> +        detection which needs to be masked.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> \ No newline at end of file
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index c38760b..98fd6ab 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -71,7 +71,14 @@ static void set_dsb_perf_mode(struct tpdm_drvdata 
>> *drvdata, u32 *val)
>>     static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>> -    u32 val;
>> +    u32 val, i;
>> +
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>> +        writel_relaxed(drvdata->dsb->edge_ctrl[i],
>> +               drvdata->base + TPDM_DSB_EDCR(i));
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>> +        writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>> +               drvdata->base + TPDM_DSB_EDCMR(i));
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>>       /* Set trigger timestamp */
>> @@ -302,6 +309,152 @@ static ssize_t dsb_mode_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_mode);
>>   +static ssize_t dsb_edge_ctrl_idx_show(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->edge_ctrl_idx);
>> +}
>> +
>> +/*
>> + * The EDCR registers can include up to 16 32-bit registers, and each
>> + * one can be configured to control up to 16 edge detections(2 bits
>> + * control one edge detection). So a total 256 edge detections can be
>> + * configured. This function provides a way to set the index number of
>> + * the edge detection which needs to be configured.
>> + */
>> +static ssize_t dsb_edge_ctrl_idx_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val >= TPDM_DSB_MAX_LINES))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->edge_ctrl_idx = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_edge_ctrl_idx);
>> +
>> +static ssize_t dsb_edge_ctrl_val_show(struct device *dev,
>> +                       struct device_attribute *attr,
>> +                       char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    unsigned long bytes;
>> +    int i;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
>> +        bytes = sysfs_emit_at(buf, size,
>> +                  "Val:0x%x\n", drvdata->dsb->edge_ctrl[i]);
>
> This feels a bit odd. edget_ctrl_val allows storing one "edge ctrl"
> value, while "show"ing all EDCR values. We could split them to :
>
> Read only sysfs files:
>
> dsb_edcr0 ... dsb_edcr15
>
> for each EDCR register (similarly for the mask)
>
> and may be show the specific edge_ctrl_line for with the above 
> function for selected index.
Sure, I will update this in the next patch series.
>
>> +        if (bytes <= 0)
>> +            break;
>> +        size += bytes;
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +/*
>> + * This function is used to control the edge detection according
>> + * to the index number that has been set.
>> + * "edge_ctrl" should be one of the following values.
>> + * 0 - Rising edge detection
>> + * 1 - Falling edge detection
>> + * 2 - Rising and falling edge detection (toggle detection)
>> + */
>> +static ssize_t dsb_edge_ctrl_val_store(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    const char *buf,
>> +                    size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val, mask, edge_ctrl;
>> +    int reg;
>> +
>> +    if ((kstrtoul(buf, 0, &edge_ctrl)) || (edge_ctrl > 0x2))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    /*
>> +     * There are 2 bit per DSB Edge Control line.
>> +     * Thus we have 16 lines in a 32bit word.
>> +     */
>> +    reg = EDCR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
>> +    mask = EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
>> +    val = drvdata->dsb->edge_ctrl[reg];
>> +    val &= ~EDCR_TO_WORD_MASK(drvdata->dsb->edge_ctrl_idx);
>> +    val |= EDCR_TO_WORD_VAL(edge_ctrl, drvdata->dsb->edge_ctrl_idx);
>> +    drvdata->dsb->edge_ctrl[reg] = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_edge_ctrl_val);
>
> This can be WO attribute to write to a given line.
I will update this in the next patch series.
>
>> +
>> +static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    ssize_t size = 0;
>> +    unsigned long bytes;
>> +    int i;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++) {
>> +        bytes = sysfs_emit_at(buf, size,
>> +                  "Val:0x%x\n", drvdata->dsb->edge_ctrl_mask[i]);
>
> As mentioned above, please don't do this. One value per file. Add
>
> dsb_edcmr0..dsb_edcmr7
>
> and print only the selected index mask for this function.
I will update this in the next patch series.
>
>> +        if (bytes <= 0)
>> +            break;
>> +        size += bytes;
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +
>> +static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         const char *buf,
>> +                         size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +    u32 set;
>> +    int reg;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    /*
>> +     * There is 1 bit per DSB Edge Control Mark line.
>> +     * Thus we have 32 lines in a 32bit word.
>> +     */
>> +    reg = EDCMR_TO_WORD_IDX(drvdata->dsb->edge_ctrl_idx);
>> +    set = drvdata->dsb->edge_ctrl_mask[reg];
>> +    if (val)
>> +        set |= BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
>> +    else
>> +        set &= ~BIT(EDCMR_TO_WORD_SHIFT(drvdata->dsb->edge_ctrl_idx));
>> +        drvdata->dsb->edge_ctrl_mask[reg] = set;
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
>> +
>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>                        struct device_attribute *attr, char *buf)
>>   {
>> @@ -374,6 +527,9 @@ static DEVICE_ATTR_RW(dsb_trig_ts);
>>     static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>> +    &dev_attr_dsb_edge_ctrl_idx.attr,
>> +    &dev_attr_dsb_edge_ctrl_val.attr,
>> +    &dev_attr_dsb_edge_ctrl_mask.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>>       &dev_attr_dsb_trig_type.attr,
>>       NULL,
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 49fffb1..4afdb29 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -12,6 +12,8 @@
>>   /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>>   #define TPDM_DSB_TIER        (0x784)
>> +#define TPDM_DSB_EDCR(n)    (0x808 + (n * 4))
>> +#define TPDM_DSB_EDCMR(n)    (0x848 + (n * 4))
>>     /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> @@ -34,6 +36,16 @@
>>   #define TPDM_DSB_TEST_MODE        GENMASK(10, 9)
>>   #define TPDM_DSB_HPSEL        GENMASK(6, 2)
>>   +#define EDCRS_PER_WORD                16
>> +#define EDCR_TO_WORD_IDX(r)            ((r) / EDCRS_PER_WORD)
>> +#define EDCR_TO_WORD_SHIFT(r)        ((r % EDCRS_PER_WORD) * 2)
>> +#define EDCR_TO_WORD_VAL(val, r)    (val << EDCR_TO_WORD_SHIFT(r))
>> +#define EDCR_TO_WORD_MASK(r)        EDCR_TO_WORD_VAL(0x3, r)
>> +
>> +#define EDCMRS_PER_WORD                32
>> +#define EDCMR_TO_WORD_IDX(r)        ((r) / EDCMRS_PER_WORD)
>> +#define EDCMR_TO_WORD_SHIFT(r)        ((r) % EDCMRS_PER_WORD)
>> +
>>   /* TPDM integration test registers */
>>   #define TPDM_ITATBCNTRL        (0xEF0)
>>   #define TPDM_ITCNTRL        (0xF00)
>> @@ -60,14 +72,26 @@
>>   #define TPDM_PIDR0_DS_IMPDEF    BIT(0)
>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>   +#define TPDM_DSB_MAX_LINES    256
>> +/* MAX number of EDCR registers */
>> +#define TPDM_DSB_MAX_EDCR    16
>> +/* MAX number of EDCMR registers */
>> +#define TPDM_DSB_MAX_EDCMR    8
>> +
>>   /**
>>    * struct dsb_dataset - specifics associated to dsb dataset
>> - * @mode:             DSB programming mode
>> - * @trig_ts:          Enable/Disable trigger timestamp.
>> - * @trig_type:        Enable/Disable trigger type.
>> + * @mode:               DSB programming mode
>> + * @edge_ctrl_idx       Index number of the edge control
>> + * @edge_ctrl:          Save value for edge control
>> + * @edge_ctrl_mask:     Save value for edge control mask
>> + * @trig_ts:            Enable/Disable trigger timestamp.
>> + * @trig_type:          Enable/Disable trigger type.
>>    */
>>   struct dsb_dataset {
>>       u32                mode;
>> +    u32                edge_ctrl_idx;
>> +    u32                edge_ctrl[TPDM_DSB_MAX_EDCR];
>> +    u32                edge_ctrl_mask[TPDM_DSB_MAX_EDCMR];
>
> Please keep them aligned with the rest of the fields.

I will update this in the next patch series.


Best,

Tao

>
>>       bool            trig_ts;
>>       bool            trig_type;
>
> Suzuki
>
>
>>   };
>
