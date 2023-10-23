Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06787D2A20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjJWGQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjJWGQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:16:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C24D67;
        Sun, 22 Oct 2023 23:16:16 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N3wMdU003559;
        Mon, 23 Oct 2023 06:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lEFNoF4rN8WZMKKieKNwqGc3g/Baej+6lRfkBSKGipk=;
 b=StOgpwzEFAulnjCVOyGnf2qn2obzK6FDNGPQ2rxSrKyqO1Vy7I+8CiJjmW5ksbY53Flt
 z3EIKlXpSD5SQNrt5bfjY90YAIHZjDl5NLaN79RVA5mlXNuVK3mIghqv7wRlWrn88uKr
 PdsRWkhMnPVW5PCmGa3eXRiAY4STL05cYp1l7K1L556UGrSkFCVoZriCU0mapEpoH364
 P7ef8Z161IMX3d7IgLkMw3pkRsosjcBSFUOhahDFaqX5Ft1NwqHRaLx6mWWYl0vw22ks
 j/g5ZVRrLf018jMjx7+e5jceQ6ajxSygY1qdDBhZNTtvy5Cn8rQyGrvV2G07QE8ugUkn UQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3ugxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:15:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6FY3U016953
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:15:34 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:15:23 -0700
Message-ID: <13d5dee2-1da4-2ad0-91f8-a53b43adba2b@quicinc.com>
Date:   Mon, 23 Oct 2023 11:45:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "Mike Looijmans" <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Ibrahim Tilki" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-8-quic_jprakash@quicinc.com>
 <20230708165955.08c1159c@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708165955.08c1159c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OLTCkTxF7To5eGPtwuON5oTCHLuZt2ZQ
X-Proofpoint-ORIG-GUID: OLTCkTxF7To5eGPtwuON5oTCHLuZt2ZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 7/8/2023 9:29 PM, Jonathan Cameron wrote:
> On Sat, 8 Jul 2023 12:58:31 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS. One major difference is
>> that the register interface used here is that of an SDAM present on
> What's an SDAM?


SDAM (Shared Direct Access Memory) is a PMIC peripheral that allows 
other peripherals to access the shared memory available on QTI PMICs. It 
can be considered a general purpose storage which can be used for many 
purposes (for example, storing data across reboots).

I'll add the full form in the next patchset.


>
>> PMK8550. There may be more than one SDAM used for ADC5 Gen3 and each
>> has eight channels, which may be used for either immediate reads
>> (same functionality as previous PMIC5 and PMIC5 Gen2 ADC peripherals) or
>> recurring measurements (same as ADC_TM functionality). In this case,
>> we have VADC and ADC_TM functionality combined into the same driver.
>> By convention, we reserve the first channel of the first SDAM for
>> all immediate reads and use the remaining channels across all SDAMs
>> for ADC_TM monitoring functionality.
>>
>> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> Various comments inline.  Some apply in various places but I typically
> only call out one or two.
>
> Jonathan


Sure, I'll check and update them all.


>
>> ---
>>   drivers/iio/adc/Kconfig               |   25 +
>>   drivers/iio/adc/Makefile              |    1 +
>>   drivers/iio/adc/qcom-spmi-adc5-gen3.c | 1193 +++++++++++++++++++++++++
>>   3 files changed, 1219 insertions(+)
>>   create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig

>> +
>> +	  The driver supports reading multiple channels. The ADC is a 16-bit
>> +	  sigma-delta ADC. The hardware supports calibrated results for
>> +	  conversion requests and clients include reading voltage phone
>> +	  power, on board system thermistors connected to the PMIC ADC,
> voltage of phone power supply (perhaps?)


Will update it in the next patchset.


>
>> +	  PMIC die temperature, charger temperature, battery current, USB voltage
>> +	  input and voltage signals connected to supported PMIC GPIO pins. The
>> +	  hardware supports internal pull-up for thermistors and can choose between
>> +	  a 30k, 100k or 400k ohm pull up using the ADC channels.
>> +
>> +	  In addition, the same driver supports ADC thermal monitoring devices too.
>> +	  They appear as thermal zones with multiple trip points. A thermal client sets
>> +	  threshold temperature for both warm and cool trips and gets updated when a
>> +	  threshold is reached.
> Would expect to see thermal maintainers cc'd on a patch adding thermal support.


My bad, I missed that, will add them for the subsequent patchsets.


>
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called qcom-spmi-adc5-gen3.
>> +
>>   config RCAR_GYRO_ADC
>>   	tristate "Renesas R-Car GyroADC driver"
>>   	depends on ARCH_RCAR_GEN2 || COMPILE_TEST
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
>> new file mode 100644
>> index 000000000000..fe5515ee8451
>> +
>> +#define ADC5_GEN3_SID_OFFSET			0x8
>> +#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
>> +#define V_CHAN(x)				(((x).sid << ADC5_GEN3_SID_OFFSET) | (x).channel)
> FIELD_PREP() makes the cleaner.
> Obviously lots of cases of this - one major advantage is you get rid of the offset
> defines in favor of the MASK is used for everything.


Will update it in the next patchset.


>
>> +
>> +enum adc5_cal_method {
>> +	ADC5_NO_CAL = 0,
>> +	ADC5_RATIOMETRIC_CAL,
>> +	ADC5_ABSOLUTE_CAL
>> +};
>> +
>> +enum adc_time_select {
> Why adc, not adc5?


Will update it in the next patchset.


>
>> +	MEAS_INT_DISABLE = 0,
>> +	MEAS_INT_IMMEDIATE,
>> +	MEAS_INT_50MS,
>> +	const char			*datasheet_name;
>> +
>> +	struct adc5_chip		*chip;
>> +	/* TM properties */
> Got plenty of space, so spell out TM


I don't think we actually have a full form for TM, it could be something 
like thermal monitoring....I'll use this:

/* TM(thermal monitoring related) properties */


>
>> +	bool				adc_tm;
>> +	unsigned int			tm_chan_index;
>> +	unsigned int			timer;
>> +	struct thermal_zone_device	*tzd;
>> +	bool				high_thr_en;
>> +	bool				low_thr_en;
>> +	int				last_temp;
>> +	bool				last_temp_set;
>> +};
>> +
>> +/**
>> + * struct adc5_chip - ADC private structure.
>> + * @regmap: SPMI ADC5 Gen3 peripheral register map field.
>> + * @dev: SPMI ADC5 Gen3 device.
>> + * @base: pointer to array of ADC peripheral base and interrupt.
>> + * @num_sdams: number of SDAMs being used.
> Define SDAM somewhere in here..


I'll add a line for it in the definition.


>
>> + * @nchannels: number of ADC channels.
>> + * @chan_props: array of ADC channel properties.
>> + * @iio_chans: array of IIO channels specification.
>> + * @complete: ADC result notification after interrupt is received.
>> + * @lock: ADC lock for access to the peripheral.
> Can you be more specific.  Access to peripheral could just be controlled via
> regmap locking.


OK....I'll try to elaborate some more in the next patchset, although we 
do have just this same line for the mutex lock definition in the earlier 
QCOM VADC drivers at this point.


>
>> + * @data: software configuration data.
>> + * @n_tm_channels: number of ADC channels used for TM measurements.
>> + * @tm_handler_work: scheduled work for handling TM threshold violation.
>> + */
>> +struct adc5_chip {


>> +static int adc5_gen3_read_voltage_data(struct adc5_chip *adc, u16 *data, u8 sdam_index)
>> +{
>> +	int ret;
>> +	u8 rslt[2];
>> +
>> +	ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CH_DATA0(0), rslt, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*data = (rslt[1] << 8) | rslt[0];
> get_unaligned_le16...


Will update it in the next patchset.


>
>> +
>> +	if (*data == ADC5_USR_DATA_CHECK) {
>> +		dev_err(adc->dev, "Invalid data:%#x\n", *data);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(adc->dev, "voltage raw code:%#x\n", *data);
>> +
>> +	return 0;
>> +}
>> +
>> +static void adc5_gen3_update_dig_param(struct adc5_chip *adc,
>> +			struct adc5_channel_prop *prop, u8 *data)
>> +{
>> +	/* Update calibration select */
>> +	*data &= ~ADC5_GEN3_DIG_PARAM_CAL_SEL_MASK;
>> +	*data |= (prop->cal_method << ADC5_GEN3_DIG_PARAM_CAL_SEL_SHIFT);
>> +
>> +	/* Update decimation ratio select */
>> +	*data &= ~ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_MASK;
>> +	*data |= (prop->decimation << ADC5_GEN3_DIG_PARAM_DEC_RATIO_SEL_SHIFT);
> FIELD_PREP() after masking the bits out.


Will update it in the next patchset.


>
>> +}
>> +
>> +static int adc5_gen3_configure(struct adc5_chip *adc,
>> +			struct adc5_channel_prop *prop)
>> +{
>> +	u8 sdam_index = prop->sdam_index;
>> +	u8 conv_req = 0;
>> +	u8 buf[7];
>> +	int ret;
>> +
>> +	/* Reserve channel 0 of first SDAM for immediate conversions */
>> +	if (prop->adc_tm)
>> +		sdam_index = 0;
>> +
>> +	ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Write SID */
>> +	buf[0] = prop->sid & ADC5_GEN3_SID_MASK;
>> +
>> +	/*
>> +	 * Use channel 0 by default for immediate conversion and
>> +	 * to indicate there is an actual conversion request
>> +	 */
>> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | 0;
>> +
>> +	buf[2] = ADC5_GEN3_TIME_IMMEDIATE;
>> +
>> +	/* Digital param selection */
>> +	adc5_gen3_update_dig_param(adc, prop, &buf[3]);
>> +
>> +	/* Update fast average sample value */
>> +	buf[4] &= (u8) ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
> Hmm. Is this cast necessary? I can't immediately spot why.


I think we can avoid it, will update it in the next patchset.


>
>> +	buf[4] |= prop->avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
>> +
>> +	/* Select ADC channel */
>> +	buf[5] = prop->channel;
>> +
>> +	/* Select HW settle delay for channel */
>> +	buf[6] &= (u8) ~ADC5_GEN3_HW_SETTLE_DELAY_MASK;
>> +	buf[6] |= prop->hw_settle_time;
>> +
>> +	reinit_completion(&adc->complete);
>> +
>> +	ret = adc5_gen3_write(adc, sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
>> +	if (ret)
>> +		return ret;
>> +
>> +	conv_req = ADC5_GEN3_CONV_REQ_REQ;
>> +	return adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &conv_req, 1);
>> +}
>> +
>> +#define ADC5_GEN3_HS_DELAY_MIN_US		100
>> +#define ADC5_GEN3_HS_DELAY_MAX_US		110
>> +#define ADC5_GEN3_HS_RETRY_COUNT		150
> Why these particular values?  Good to state assumptions behind them
> incase someone wants to be modify them in the future.


Will add some comments here in the next patchset.


>
>> +
>> +static int adc5_gen3_poll_wait_hs(struct adc5_chip *adc,
>> +				unsigned int sdam_index)
>> +{
>> +	u8 conv_req = ADC5_GEN3_CONV_REQ_REQ;
>> +	u8 status = 0;
>> +	int ret, count;
>> +
>> +	for (count = 0; count < ADC5_GEN3_HS_RETRY_COUNT; count++) {
>> +		ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_HS, &status, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (status == ADC5_GEN3_HS_READY) {
>> +			ret = adc5_gen3_read(adc, sdam_index, ADC5_GEN3_CONV_REQ,
>> +					&conv_req, 1);
>> +			if (ret)
>> +				return ret;
>> +
>> +			if (!conv_req)
>> +				return 0;
>> +		}
>> +
>> +		usleep_range(ADC5_GEN3_HS_DELAY_MIN_US,
>> +			ADC5_GEN3_HS_DELAY_MAX_US);
>> +	}
>> +
>> +	dev_err(adc->dev, "Setting HS ready bit timed out, status:%#x\n", status);
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +#define ADC5_GEN3_CONV_TIMEOUT_MS	501
> Why?  Perhaps a specification reference?


Will add a comment here in the next patchset.


>
>
>
>> +static irqreturn_t adc5_gen3_isr(int irq, void *dev_id)
>> +{
>> +	struct adc5_chip *adc = dev_id;
>> +	u8 status, tm_status[2], eoc_status, val;
>> +	int ret, sdam_num;



>> +	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
> If you got an IRQ and could tell it was definitely from this device, IRQ_HANDLED probably the
> appropriate return - rather than triggering the unhandled irq generic stuff.


I think you're right, I can update it.


>
>> +		dev_err_ratelimited(adc->dev, "Unexpected conversion fault, status:%#x, eoc_status:%#x\n",
>> +				status, eoc_status);
>> +		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
>> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_CONV_ERR_CLR, &val, 1);
>> +		if (ret < 0)
>> +			goto handler_end;
>> +
>> +		/* To indicate conversion request is only to clear a status */
>> +		val = 0;
>> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_PERPH_CH, &val, 1);
>> +		if (ret < 0)
>> +			goto handler_end;
>> +
>> +		val = ADC5_GEN3_CONV_REQ_REQ;
>> +		ret = adc5_gen3_write(adc, sdam_num, ADC5_GEN3_CONV_REQ, &val, 1);
>> +		if (ret < 0)
>> +			goto handler_end;
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +
>> +handler_end:
>> +	return IRQ_NONE;
> Return directly as then more immediately obvious that there is a problem.
> However I'm not sure IRQ_NONE is appropriate as it doesn't mean error...
> Normally we just log something then return IRQ_HANDLED.


Will update it in the next patchset to use IRQ_HANDLED alone.


>> +}
>> +
>> +static void tm_handler_work(struct work_struct *work)
>> +{
>> +	struct adc5_chip *adc = container_of(work, struct adc5_chip, tm_handler_work);
>> +	struct adc5_channel_prop *chan_prop;
>> +	u8 tm_status[2] = {0};
>> +	u8 buf[16] = {0};
>> +	u8 val;

>> +
>> +		mutex_unlock(&adc->lock);
>> +
>> +		if (!(upper_set || lower_set))
>> +			continue;
>> +
>> +		data_low = buf[2 * offset];
>> +		data_high = buf[2 * offset + 1];
>> +		code = ((data_high << 8) | data_low);
> code = get_unaligned_le16(&buf[2 * offset]) or similar.


Will update it in the next patchset


>

> +
>> +static const struct iio_info adc5_gen3_info = {
>> +	.read_raw = adc5_gen3_read_raw,
>> +	.fwnode_xlate = adc5_gen3_fwnode_xlate,
>> +};
> ...


Did you mean to leave any comment here...?


>
>> +static int adc_tm5_gen3_disable_channel(struct adc5_channel_prop *prop)
>> +{
> As mentioned below - this shares a bunch of code with the disable in the
> remove callback.  If that shared code can be used in both paths that would
> be great.


Yes, I can do that in the next patchset.


>
>> +	struct adc5_chip *adc = prop->chip;
>> +	int ret;
>> +	u8 val;
>> +
>> +	prop->high_thr_en = false;
>> +	prop->low_thr_en = false;
>> +
>> +	val = MEAS_INT_DISABLE;
>> +	ret = adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_TIMER_SEL, &val, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* To indicate there is an actual conversion request */
>> +	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
>> +	ret = adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_PERPH_CH, &val, 1);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = ADC5_GEN3_CONV_REQ_REQ;
>> +	return adc5_gen3_write(adc, prop->sdam_index, ADC5_GEN3_CONV_REQ, &val, 1);
>> +}
>> +
>> +static int adc_tm5_gen3_configure(struct adc5_channel_prop *prop,
>> +					int low_temp, int high_temp)
>> +{
>> +	struct adc5_chip *adc = prop->chip;
>> +	u8 conv_req = 0, buf[12];
> Why 12?  Can you use a define or similar to express where that magic size
> comes from?


Will update it in the next patchset, it's just meant to update registers 
from 0x4f to 0x5a, which are used for configurations here.


>
>> +	u16 adc_code;
>> +	int ret;
>> +
>> +	ret = adc5_gen3_poll_wait_hs(adc, prop->sdam_index);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = adc5_gen3_read(adc, prop->sdam_index, ADC5_GEN3_SID, buf, sizeof(buf));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Write SID */
>> +	buf[0] = prop->sid & ADC5_GEN3_SID_MASK;
> FIELD_PREP() preferred for field configuration.


Will update it in the next patchset


>
>> +
>> +	/*
>> +	 * Select TM channel and indicate there is an actual
>> +	 * conversion request
>> +	 */
>> +	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
>> +



>> +
>> +static int adc_tm_register_tzd(struct adc5_chip *adc)
>> +{
>> +	unsigned int i, channel;
>> +	struct thermal_zone_device *tzd;
>> +
>> +	for (i = 0; i < adc->nchannels; i++) {
>> +		channel = V_CHAN(adc->chan_props[i]);
>> +
>> +		if (!adc->chan_props[i].adc_tm)
>> +			continue;
>> +		tzd = devm_thermal_of_zone_register(
>> +			adc->dev, channel,
>> +			&adc->chan_props[i], &adc_tm_ops);
> Short line wrap.   BTW I don't mind if you go over 80 chars if it helps readability but here
> that's happening anyway.


Will update it in the next patchset


>
>> +
>> +		if (IS_ERR(tzd)) {
>> +			if (PTR_ERR(tzd) == -ENODEV) {
>> +				dev_warn(adc->dev, "thermal sensor on channel %d is not used\n",
>> +					 channel);
>> +				continue;
>> +			}
>> +
>> +			dev_err(adc->dev, "Error registering TZ zone:%ld for channel:%d\n",
>> +				PTR_ERR(tzd), adc->chan_props[i].channel);
>> +			return PTR_ERR(tzd);
>> +		}
>> +		adc->chan_props[i].tzd = tzd;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +struct adc5_channels {
>> +	const char *datasheet_name;
>> +	unsigned int prescale_index;
>> +	enum iio_chan_type type;
>> +	long info_mask;
>> +	enum vadc_scale_fn_type scale_fn_type;
>> +};
>> +
>> +/* In these definitions, _pre refers to an index into adc5_prescale_ratios. */
>> +#define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)	\
>> +	{						\
>> +		.datasheet_name = _dname,		\
> Use of datasheet name is historical and makes a horribly messy userspace interface.
> Unless there is a very strong reason otherwise, the read_label callback should be used
> instead.  Unfortunately it's hard to fix this issue in existing drivers without
> breaking ABI.  We don't want more cases.


OK, I'll remove the usage of datasheet name completely and define a 
read_label callback as you suggested.


>
>> +		.prescale_index = _pre,			\
>> +		.type = _type,				\
>> +		.info_mask = _mask,			\
>> +		.scale_fn_type = _scale,		\
>> +	},						\
>> +
>> +#define ADC5_CHAN_TEMP(_dname, _pre, _scale)		\
>> +	ADC5_CHAN(_dname, IIO_TEMP,			\
>> +		BIT(IIO_CHAN_INFO_PROCESSED),		\
>> +		_pre, _scale)				\
>> +
>> +#define ADC5_CHAN_VOLT(_dname, _pre, _scale)		\
>> +	ADC5_CHAN(_dname, IIO_VOLTAGE,			\
>> +		  BIT(IIO_CHAN_INFO_PROCESSED),		\
>> +		  _pre, _scale)				\
>> +
>> +#define ADC5_CHAN_CUR(_dname, _pre, _scale)		\
>> +	ADC5_CHAN(_dname, IIO_CURRENT,			\
>> +		  BIT(IIO_CHAN_INFO_PROCESSED),		\
>> +		  _pre, _scale)				\
>> +
> These seem rather over wrapped.  Could get nearer 80 chars and use
> a few fewer lines.


Will update it in the next patchset


>
>
>> +static int adc5_gen3_get_fw_channel_data(struct adc5_chip *adc,
>> +				    struct adc5_channel_prop *prop,
>> +				    struct fwnode_handle *fwnode,
>> +				    const struct adc5_data *data)
>> +{
>> +	const char *name = fwnode_get_name(fwnode), *channel_name;
> I'd break the definition of channel_name out on it's own (so not in the same line
> as name)


Will update it in the next patchset


>
>> +	struct device *dev = adc->dev;
>> +	u32 chan, value, varr[2], sid = 0;
>> +	int ret, val;
>> +
>> +	ret = fwnode_property_read_u32(fwnode, "reg", &chan);
>> +	if (ret < 0) {
>> +		dev_err(dev, "invalid channel number %s\n", name);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Value read from "reg" is virtual channel number
>> +	 * virtual channel number = sid << 8 | channel number
>> +	 */
>> +
>> +	sid = (chan >> ADC5_GEN3_SID_OFFSET);
>> +	chan = (chan & ADC5_GEN3_CHANNEL_MASK);
> Slightly nicer to just provide the masks as defines and use FIELD_GET() for both.


Will update it in the next patchset


>
>> +
>> +	if (chan > ADC5_GEN3_OFFSET_EXT2 ||
>> +	    !data->adc_chans[chan].datasheet_name) {
>> +		dev_err(dev, "%s invalid channel number %d\n", name, chan);
>> +		return -EINVAL;
>> +	}
>> +
>> +	prop->channel = chan;
>> +	prop->sid = sid;
>> +
>> +	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
>> +	if (ret)
>> +		channel_name = name;
>> +	prop->datasheet_name = channel_name;
>> +
>> +	prop->decimation = ADC5_DECIMATION_DEFAULT;
>> +	ret = fwnode_property_read_u32(fwnode, "qcom,decimation", &value);
>> +	if (!ret) {
>> +		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%#x invalid decimation %d\n",
>> +				chan, value);
>> +			return ret;
>> +		}
>> +		prop->decimation = ret;
>> +	}
>> +
>> +	prop->prescale = adc->data->adc_chans[prop->channel].prescale_index;
>> +	ret = fwnode_property_read_u32_array(fwnode, "qcom,pre-scaling", varr, 2);
>> +	if (!ret) {
>> +		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%#x invalid pre-scaling <%d %d>\n",
>> +				chan, varr[0], varr[1]);
>> +			return ret;
> As this is only called in probe, you can use dev_err_probe() for a small simplification
> here and in similar cases.


Will update it in the next patchset


>
>
>> +		}
>> +		prop->prescale = ret;
>> +	}
>> +
>> +	prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
>> +	ret = fwnode_property_read_u32(fwnode, "qcom,hw-settle-time", &value);
>> +	if (!ret) {
>> +		ret = qcom_adc5_hw_settle_time_from_dt(value,
>> +						data->hw_settle_1);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%#x invalid hw-settle-time %d us\n",
>> +				chan, value);
>> +			return ret;
>> +		}
>> +		prop->hw_settle_time = ret;
>> +	}
>> +
>> +	prop->avg_samples = VADC_DEF_AVG_SAMPLES;
>> +	ret = fwnode_property_read_u32(fwnode, "qcom,avg-samples", &value);
>> +	if (!ret) {
>> +		ret = qcom_adc5_avg_samples_from_dt(value);
>> +		if (ret < 0) {
>> +			dev_err(dev, "%#x invalid avg-samples %d\n",
>> +				chan, value);
>>
>> ...
>>
>> +
>> +static int adc5_gen3_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;
>> +	struct adc5_chip *adc;
>> +	struct regmap *regmap;
>> +	int ret, i, irq;
>> +	u32 *reg;
>> +	char buf[20];
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (!regmap)
>> +		return -ENODEV;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	adc = iio_priv(indio_dev);
>> +	adc->regmap = regmap;
>> +	adc->dev = dev;
>> +
>> +	ret = device_property_count_u32(dev, "reg");
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	adc->num_sdams = ret;
> The binding needs to make it clear that reg can be a bunch of different base
> addresses.


Yes, I'll update it in the next patchset.


>
>> +
>> +	reg = devm_kcalloc(dev, adc->num_sdams, sizeof(u32), GFP_KERNEL);
>> +	if (!reg)
>> +		return -ENOMEM;
> I think this is only used locally.  So I'd prefer local allocation and clean it up
> afterwards rather than tying it to the lifetime of the device.


That makes sense, will update it in the next patchset


>
>> +
>> +	ret = device_property_read_u32_array(dev, "reg", reg, adc->num_sdams);
>> +	if (ret) {
>> +		dev_err(adc->dev, "Failed to read reg property, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	adc->base = devm_kcalloc(adc->dev, adc->num_sdams, sizeof(*adc->base), GFP_KERNEL);
>> +	if (!adc->base)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < adc->num_sdams; i++) {
>> +		adc->base[i].base_addr = reg[i];
>> +
>> +		irq = platform_get_irq(pdev, i);
>> +		if (irq < 0) {
>> +			dev_err(adc->dev, "Failed to get SDAM%d irq, ret=%d\n", i, irq);
>> +			return irq;
>> +		}
>> +		adc->base[i].irq = irq;
>> +
>> +		scnprintf(buf, sizeof(buf), "adc-sdam%d", i);
>> +		adc->base[i].irq_name = devm_kstrdup(adc->dev, buf, GFP_KERNEL);
> Why not devm_kasprintf()?
>
> Unusual to have such a separation between getting irqs and the requesting them.
> Why not push this until after the adc5_get_fw_data) and then I think you can
> do it in a single loop.


Yes, I'll update it to use devm_kasprintf().

You're right about the separation, I'll combine them into a single loop, 
but I think we should keep it before adc5_get_fw_data so that we 
complete going over top-level ADC node properties before starting to go 
over child node properties for channels.

Will update it in the next patchset.


>
>
>> +		if (!adc->base[i].irq_name)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, adc);
>> +
>> +	init_completion(&adc->complete);
>> +	mutex_init(&adc->lock);
> This is interleaving some general setup with a bunch of firwmare related stuff.
> I'd push this above the getting of irq's above.


Will move it above in the next patchset


>
>> +
>> +	ret = adc5_get_fw_data(adc);
>> +	if (ret < 0) {
>> +		dev_err(adc->dev, "adc get dt data failed, ret=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < adc->num_sdams; i++) {
>> +		ret = devm_request_irq(dev, adc->base[i].irq, adc5_gen3_isr,
>> +					0, adc->base[i].irq_name, adc);
>> +		if (ret < 0) {
>> +			dev_err(adc->dev, "Getting IRQ %d failed, ret=%d\n", adc->base[i].irq, ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = adc_tm_register_tzd(adc);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (adc->n_tm_channels)
>> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);
>> +
>> +	indio_dev->name = pdev->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc5_gen3_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static int adc5_gen3_exit(struct platform_device *pdev)
>> +{
> As you are mixing devm manged cleanup and the explicit sort the
> result is that you remove the userspace interfaces 'after' you run
> everything in here. I'm thinking disabling the channels at least
> isn't a good idea in that case.
>
> If you want to use devm (which is good) then you need to work out how
> to register additional callbacks during probe to tear down everything in
> the right order (typically the reverse of what happens in probe)
> devm_add_action_or_reset() is the way to add those extra callbacks.
>
> If not, just don't use devm for at least those bits that will end up
> running out of order (such as iio_device_register()) and manually call their
> cleanup routines instead.


I checked some other examples in the iio/adc/ folder, I think I see what 
you mean here. It looks like drivers with a remove callback always use 
iio_device_register and iio_device_unregister instead of the devm_* 
variant, due to the issue with sysfs removal as you said.

I'll update the probe and remove functions similarly, to do explicit 
cleanups as required, avoiding devm_ usage for places where it should be 
avoided.


>
>
>> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
>> +	u8 data = 0;
>> +	int i, sdam_index;
>> +
>> +	mutex_lock(&adc->lock);
>> +	/* Disable all available channels */
>> +	for (i = 0; i < adc->num_sdams * 8; i++) {
>> +		sdam_index = i / 8;
>> +		data = MEAS_INT_DISABLE;
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TIMER_SEL, &data, 1);
>> +
>> +		/* To indicate there is an actual conversion request */
>> +		data = ADC5_GEN3_CHAN_CONV_REQ | (i - (sdam_index * 8));
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &data, 1);
>> +
>> +		data = ADC5_GEN3_CONV_REQ_REQ;
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &data, 1);
> This block is very similar to adc_tm5_gen3_disable_channel() Perhaps you can factor
> out a little function to be used here and in that function.


Will update it in the next patchset


>
>> +	}
>> +
>> +	mutex_unlock(&adc->lock);
>> +
>> +	if (adc->n_tm_channels)
>> +		cancel_work_sync(&adc->tm_handler_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver adc5_gen3_driver = {
>> +	.driver = {
>> +		.name = "qcom-spmi-adc5-gen3",
>> +		.of_match_table = adc5_match_table,
>> +	},
>> +	.probe = adc5_gen3_probe,
>> +	.remove = adc5_gen3_exit,
> adc5_gen3_remove() naming preferred.


Will update it in the next patchset

Thanks,

Jishnu


>
>> +};
>> +module_platform_driver(adc5_gen3_driver);
>> +
>> +MODULE_ALIAS("platform:qcom-spmi-adc5-gen3");
>> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. PMIC5 Gen3 ADC driver");
>> +MODULE_LICENSE("GPL");
