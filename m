Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BAC7BE4CC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376815AbjJIPcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376553AbjJIPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:32:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37989A6;
        Mon,  9 Oct 2023 08:32:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EiUcw027758;
        Mon, 9 Oct 2023 15:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Rinux5Wv3J1gfd4DGhUVdVucpb0uUgQGs8OA/ffK6GM=;
 b=V8H+m91qfMX8rr9IpgiwFT3lS4q3dVnJRCLSRukXbRReszh6vGYEQ89toWOrew2Fo3Me
 vWkGesn8QqQd+xQo+lMASlxTZSOoM3Jsxe8hPkW6plHdjNfAGmRa1FUGTvfwgXLu1QML
 HVcSL6YWMmTCEuJmXIMiC1Hh+5FebkBDTNLlFDui2ZIVfTC6kcfDseorQkT9PTKZaiYc
 rfhtb/XbdX5Lbn/yWUxGvYt5zcccye3xPqLfOz832Maj8jcJqRlFuvFfY9Lt+2P3l7og
 WhLh3zpjlb8S4snl1/KhVIozRsot+kjwBBH+87SnnMRloH6FrumaPD50vMxefz7LNg5Z pg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkhj12qpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 15:32:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399FWeYj004390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 15:32:40 GMT
Received: from [10.216.9.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 9 Oct
 2023 08:32:36 -0700
Message-ID: <a9efdc23-0417-48dc-aa17-ef7b1459b85a@quicinc.com>
Date:   Mon, 9 Oct 2023 21:02:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <2023100931-reward-justice-ed1c@gregkh>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2023100931-reward-justice-ed1c@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ep5yAcQC-zjQMlAugky62JPgA3008I_N
X-Proofpoint-GUID: ep5yAcQC-zjQMlAugky62JPgA3008I_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_13,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310090128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2023 8:38 PM, Greg Kroah-Hartman wrote:
> On Mon, Oct 09, 2023 at 07:50:05PM +0530, Krishna Kurapati wrote:
>> Currently the NCM driver restricts wMaxSegmentSize that indicates
>> the datagram size coming from network layer to 1514.
> 
> I don't see that restriction in the existing driver, where does that
> happen?

Hi Greg,

  In the ecm_desc, the following line restricts the value:

.wMaxSegmentSize =      cpu_to_le16(ETH_FRAME_LEN),

> 
>> However the spec doesn't have any limitation.
> 
> What spec?

NCM Specification.
I didn't mention "NCM specification" as I thought the patch header would 
imply it is NCM Spec. Will update the wording here.

> 
>> For P2P connections over NCM, increasing MTU helps increasing
>> throughput.
> 
> While increasing latency, right?

I used iperf for capturing the data. I was more focussing on throughput.

Here are some results I found:

For throughput, the increase is as follows (HS link with and an old iperf):

MTU Size	Throughput
1500		145
2500		204
3500		208
4500		223
5500		227
6500		299
7500		324
8050		335

As per the latency, an internal test application I was using didn't show 
much difference in latency as MTU was increasing. Then again, it could 
be application specific.

> 
>> Add support to configure this value before configfs symlink is
>> created. Also since the NTB Out/In buffer sizes are fixed at 16384
>> bytes, limit the segment size to an upper cap of 15014. Set the
>> default MTU size for the ncm interface during function bind before
>> network interface is registered allowing MTU to be set in parity
>> with wMaxSegmentSize.
> 
> Where does 15014 come from?
> 
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ncm.h |  2 ++
>>   2 files changed, 53 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
>> index feccf4c8cc4f..eab297b22200 100644
>> --- a/drivers/usb/gadget/function/f_ncm.c
>> +++ b/drivers/usb/gadget/function/f_ncm.c
>> @@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
>>   /* Delay for the transmit to wait before sending an unfilled NTB frame. */
>>   #define TX_TIMEOUT_NSECS	300000
>>   
>> +#define MAX_DATAGRAM_SIZE	15014
> 
> Where does this magic value come from?  Please document it really really
> well.
> 
Sorry for not being clear. The 14 here meant ETH_HLEN which gets 
appended to MTU usually. I wanted to limit mtu to 15000 max (via 
wMaxsegment size) and mentioned it here as 15014.

Will update comments here in v2.

>> +
>>   #define FORMATS_SUPPORTED	(USB_CDC_NCM_NTB16_SUPPORTED |	\
>>   				 USB_CDC_NCM_NTB32_SUPPORTED)
>>   
>> @@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>   	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
>>   
>>   	if (cdev->use_os_string) {
>> +		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
>>   		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
>>   					   GFP_KERNEL);
>>   		if (!f->os_desc_table)
>> @@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
>>   
>>   	status = -ENODEV;
>>   
>> +	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
>> +
>>   	/* allocate instance-specific endpoints */
>>   	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
>>   	if (!ep)
>> @@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
>>   /* f_ncm_opts_ifname */
>>   USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
>>   
>> +static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
>> +					      char *page)
>> +{
>> +	struct f_ncm_opts *opts = to_f_ncm_opts(item);
>> +	u32 segment_size;
>> +
>> +	mutex_lock(&opts->lock);
>> +	segment_size = opts->max_segment_size;
>> +	mutex_unlock(&opts->lock);
>> +
>> +	return sprintf(page, "%u\n", segment_size);
> 
> sysfs_emit()?
> 
Apologies.

I followed u_ether_configfs.h which used sprintf. Will replace it with 
sysfs_emit in v2.

Thanks for the review.

Regards,
Krishna,
