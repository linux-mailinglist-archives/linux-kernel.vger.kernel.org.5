Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48CE7CA49F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjJPJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:58:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCA29C;
        Mon, 16 Oct 2023 02:58:30 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39G9R4WW000607;
        Mon, 16 Oct 2023 09:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8xJXJe5Mc7B6uRR7ZkTloHCwIiM6IViavS69mQygsSk=;
 b=TCeYwZICzEzeXMXIcImWhxl7BcQyb/peWc+WCBaAVI2KJzdHU/xKLrqtbjf44FXuND5K
 lsskW7PpyIslgJPwuOKyjtl8yiO4DI0vBuO98AbQNfk+VXiK3vSGCYOU53gO1NWhqEW9
 VifPq8WetR+Nvq6+SLiwvLAMmFSoe84Dk3nFeSH4+LlE4GJsZJ0D7jOTKuOLLBAmqoVv
 4H68eAKHeVbWkuaup17qob9oJ6pGHfY5h3Gn3w/eoXxVKMNhUCi60Cni1v5OxYrsnMJp
 rSDMLmyPDo3OyrsZwJpTmBWawWJFNtILPkMc5WseCHhG/YkON6iVl+VudO7maw1CrjCm kQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tryn10bav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 09:56:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39G9uCho001874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Oct 2023 09:56:12 GMT
Received: from [10.217.218.207] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 16 Oct
 2023 02:56:07 -0700
Message-ID: <f6f6ee14-2e19-44f9-88cf-fe0c2339221e@quicinc.com>
Date:   Mon, 16 Oct 2023 15:26:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Enable MMC_CAP2_SLEEP_AWAKE for
 Qualcomm controllers
To:     Wenchao Chen <wenchao.chen666@gmail.com>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_rampraka@quicinc.com>,
        <quic_pragalla@quicinc.com>, <quic_sayalil@quicinc.com>,
        <quic_nitirawa@quicinc.com>, <quic_sachgupt@quicinc.com>,
        <quic_bhaskarv@quicinc.com>, <quic_narepall@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20230929102831.9702-1-quic_sartgarg@quicinc.com>
 <20230929102831.9702-3-quic_sartgarg@quicinc.com>
 <CA+Da2qz=jSfi=WzJyykaMUd4RSYMORe05YQS_y3c0cEW=o4-Vg@mail.gmail.com>
Content-Language: en-US
From:   Sarthak Garg <quic_sartgarg@quicinc.com>
In-Reply-To: <CA+Da2qz=jSfi=WzJyykaMUd4RSYMORe05YQS_y3c0cEW=o4-Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F_P9bgKq3-ko654WExOiJSN2NuK3Sjl7
X-Proofpoint-ORIG-GUID: F_P9bgKq3-ko654WExOiJSN2NuK3Sjl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2023 7:52 AM, Wenchao Chen wrote:
> On Fri, 29 Sept 2023 at 22:44, Sarthak Garg <quic_sartgarg@quicinc.com> wrote:
>>
>> Enable MMC_CAP2_SLEEP_AWAKE for Qualcomm controllers to let them use
>> sleep/awake functionality for faster eMMC resume instead of
>> doing full initialization.
>>
>> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
>> ---
>>   drivers/mmc/host/sdhci-msm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
>> index 668e0aceeeba..be44a6851fc9 100644
>> --- a/drivers/mmc/host/sdhci-msm.c
>> +++ b/drivers/mmc/host/sdhci-msm.c
>> @@ -2627,6 +2627,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>>          }
>>
>>          msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>> +       msm_host->mmc->caps2 |= MMC_CAP2_SLEEP_AWAKE;
>>
> 
> Need "MMC_CAP_AGGRESSIVE_PM"?
> /*
>   * Callback for runtime_suspend.
>   */
> static int mmc_runtime_suspend(struct mmc_host *host)
> {
> int err;
> 
> if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> return 0;
> 
> err = _mmc_suspend(host, true);
> if (err)
> pr_err("%s: error %d doing aggressive suspend\n",
> mmc_hostname(host), err);
> 
> return err;
> }
> 
> 
>


Thanks for pointing .. yes this is needed and missed to push this. Will 
push in V3.

Thanks,
Sarthak


>>          /* Set the timeout value to max possible */
>>          host->max_timeout_count = 0xF;
>> --
>> 2.17.1
>>
