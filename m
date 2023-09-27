Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A97B0D17
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjI0UCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjI0UCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:02:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E82121;
        Wed, 27 Sep 2023 13:02:14 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RJkZ32011894;
        Wed, 27 Sep 2023 20:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ryZutAebLaGLyVKZ1wZ2WPr3DnN8n1DAG80EGJowehs=;
 b=DBixV+Y6w/MthTtGGUv8auiu7df9weX4/brq78PevdvCw1sECoaaM+5R4iT87qhjSgL+
 hdUy7zS256Ojq/xQg1E24st0QXoY1ajZdkiusKkHt7Vbwfj1xqq2gFt7Ns6UoJNFyIj/
 HiSY6CNFUnKlQQnmdx7JspuYLT1yy5xTrSUieZ82n8DMw+y/vitVMD0nSnyRX7Hnk5sm
 OYdfyzdbVtKfVyLsCxEbwfhVYrqc57iLygWAd8RA6f9KfjIVktV39sn1t0UVmqk/tdbl
 B5gxgMR1foTSmnryE6xuzaU/7mNgIdqbzCS4+LAK6n19h8E7iY41q4Tlf7eBotdYbDBd Cg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcpkgrrh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:01:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RK1fxj004565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 20:01:41 GMT
Received: from [10.110.25.80] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 13:01:40 -0700
Message-ID: <29584061-a7e9-5db4-a024-eaf7774a03dd@quicinc.com>
Date:   Wed, 27 Sep 2023 13:01:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 09/33] ASoC: qdsp6: q6afe: Increase APR timeout
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
 <20230921214843.18450-10-quic_wcheng@quicinc.com>
 <ZRRBIa+bVSqTHprO@finisterre.sirena.org.uk>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <ZRRBIa+bVSqTHprO@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wmE0swXrHDd9mXk1xvEgSZNzbdkoY5Fi
X-Proofpoint-ORIG-GUID: wmE0swXrHDd9mXk1xvEgSZNzbdkoY5Fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=324 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270170
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 9/27/2023 7:50 AM, Mark Brown wrote:
> On Thu, Sep 21, 2023 at 02:48:19PM -0700, Wesley Cheng wrote:
>> For USB offloading situations, the AFE port start command will result in a
>> QMI handshake between the Q6DSP and the main processor.  Depending on if
>> the USB bus is suspended, this routine would require more time to complete,
>> as resuming the USB bus has some overhead associated with it.  Increase the
>> timeout to 3s to allow for sufficient time for the USB QMI stream enable
>> handshake to complete.
> 
> ...
> 
>> -#define TIMEOUT_MS 1000
>> +#define TIMEOUT_MS 3000
> 
> That seems worryingly large but if it's what the hardware/firmware needs
> I guess there's nothing doing - even the 1s that's being replaced would
> be nasty if we ever actually hit it.

I may have gone overkill with the delay, but when I measured the 
duration of the AFE start command it took ~1.5-2s.  It has to also 
account for the overhead within handling the USB QMI request in the 
qc_audio_offload driver.

Thanks
Wesley Cheng
