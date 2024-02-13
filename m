Return-Path: <linux-kernel+bounces-63563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDB853169
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB8E1C22FBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9851C58;
	Tue, 13 Feb 2024 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h7Jw+cB9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8238DDF;
	Tue, 13 Feb 2024 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829757; cv=none; b=Ynp268RF5djr+dbfFF5IcwRiHmiElnE1Y9NbJv5hcYi11e4segPu62L2/zMwGFVI4WfnFFX6LugLDu9l0/CZ/oPXktezJk8JJ8S52AC058HifkajfyZWZmEVTjem7GmdpuaxME9Bt8Fxl3Ytlb5X/wn8Pw/NDkric/FHd8UPB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829757; c=relaxed/simple;
	bh=fwjPbwWJuAg6/oVUHwI9+iVzWOd2/i2+1WYTkZqm2tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=stIOgE+woc7f5z9F9IxoWG9Oxf53E3r8G5Jj0L0aVZxhEWmJeVBwSPqHHRDhw8QdFmoYWBnPSXDslASQNJVcSUxRS/Kx5JHDYYuPIYAGoFo4eW8C0ehV+DncyWDwfWD/w3JUxZsgx4oxLKYwSbfShl2IwCm/HsmBq/DKEii426Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h7Jw+cB9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DCOHJl008150;
	Tue, 13 Feb 2024 13:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WgNQG4hvr6W840pgn8q/mmFJTING5Dc9KpCyyDaDphE=; b=h7
	Jw+cB9ffaHkpv1KfC2kg10QYbbINHrDRNlWUbITMAxwsz5HZE/Q+PJM9gPlf2IK5
	bZvJjoPFcpSh4o/4GVPxBqcPUtHY4uDuFBeFj9X6Hf9sNkDyhakzr+Z76VNqzw9U
	pnorGyVf3xrh1em6NVcVKCFGinX0klCCVZuGCjKojabTS7J6BSa2kbMmWwRVXLYK
	FKUgxS3Cy44FG7eBnW+nfFd3cdmiPX2KLi0+UTtOeQqW4ZOczQGGk7EJ0iUpZIAU
	jvIIpLicGgEdrOJryL9SxMaeckf4Yinw0yVFXh3Yn32kbcQIl99ERihwoNHrcRZq
	HbROtNr9apOd8Gkt7Brw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5s5w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:09:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DD95lV005353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 13:09:05 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 13 Feb
 2024 05:08:58 -0800
Message-ID: <f59244eb-a05d-4aa4-89e8-81cfcbafe288@quicinc.com>
Date: Tue, 13 Feb 2024 18:38:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] clk: qcom: gdsc: Add set and get hwmode callbacks
 to switch GDSC mode
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman
	<khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-media@vger.kernel.org>
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org>
 <20240122-gdsc-hwctrl-v4-3-9061e8a7aa07@linaro.org>
 <qbqsvxmnl2tuansxzr6u4vqxemw4dzrsvz2ill6qnyxdp5gtji@lsemt4asmsax>
 <xl767op6zn5iene3h4jg3x3w7fofrqztqkdgg4qqmiy34p27if@hnev3tnldqw5>
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <xl767op6zn5iene3h4jg3x3w7fofrqztqkdgg4qqmiy34p27if@hnev3tnldqw5>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nmn1K82QbuOgmsLF47Nec_d7br0AR5-e
X-Proofpoint-ORIG-GUID: nmn1K82QbuOgmsLF47Nec_d7br0AR5-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=590 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130104



On 1/31/2024 5:49 AM, Bjorn Andersson wrote:
> On Tue, Jan 30, 2024 at 05:00:28PM -0600, Bjorn Andersson wrote:
>> On Mon, Jan 22, 2024 at 10:47:03AM +0200, Abel Vesa wrote:
>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>> Add support for set and get hwmode callbacks to switch the GDSC between
>>> SW and HW modes. Currently, the GDSC is moved to HW control mode
>>> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
>>> mode as part of GDSC enable itself. The intention is to keep the
>>> HW_CTRL flag functionality as is, since many older chipsets still use
>>> this flag.
>>>
>>
>> This provides insight into why we end up with both HW_CTRL and
>> HW_CTRL_TRIGGER. This doesn't describe why this change is needed, but
>> rather just an implementation detail.
>>
>>> But consumer drivers also require the GDSC mode to be switched dynamically
>>> at runtime based on requirement for certain usecases. Some of these
>>> usecases are switching the GDSC to SW mode to keep it ON during the
>>> enablement of clocks that are dependent on GDSC and while programming
>>> certain configurations that require GDSC to be ON. Introduce a new
>>> HW_CTRL_TRIGGER flag to register the set_hwmode_dev and get_hwmode_dev
>>> callbacks which allows the consumer drivers to switch the GDSC back and
>>> forth between HW/SW modes dynamically at runtime using new
>>> dev_pm_genpd_set_hwmode API.
>>>
>>
>> This still expresses the need for HW_CTRL_TRIGGER in terms of "some
>> drivers need for some use case". We don't need these many words to say:
>> "Introduce HW_CTRL_TRIGGER for client drivers that need it."
>>
>>
>> I find that it would be useful to document that every time a GDSC is
>> turned on the mode will be switched to SW...
>>
> 
> I believe I'm wrong here. Reading the patch again, I think we might
> retain the mode across a disable/enable cycle. I at least don't see
> anything explicit returning us to SW mode.
> > According to Linux though, the GDSC is off, so as described below, there
> will be no votes for supplying resources.
> 

Yes, With HW_CTRL_TRIGGER flag, the GDSC mode gets switched only in new 
set_hwmode_dev() callback when consumers explicitly call for it. This is 
to ensure GenPD f/w's hwmode aligns with the actual GDSC mode in HW.

With the new API, the expectation is consumer drivers should move the 
GDSC to SW control mode before disabling the GDSC, which ensures that, 
GDSC is turned ON in SW mode every time.

Thanks,
Jagadeesh

> Regards,
> Bjorn

