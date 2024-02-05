Return-Path: <linux-kernel+bounces-54102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC484AAC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5640A1C23EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883804B5CA;
	Mon,  5 Feb 2024 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NR1zohk/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3566E4D9F0;
	Mon,  5 Feb 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176594; cv=none; b=O2sI6RugLLjqLeKbaQyyhgx4/RMMRovdaOFplEU/L3IPsRLU6KXRu1sNUam9YrSKmIlbmbILeWxgjnWgPZy1X0a9VfnpZTUcojyjkE3PGxSmzGbJWvXd7eswoozRJkujELMFcOkKjuuaOoRpimdanYe+kZEsXlYX9KTkqFubReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176594; c=relaxed/simple;
	bh=/j8Me4jOfxM2HK+iG5EIgQmxB68U6ITj91R98wi3LDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AbZL5Q7c7VOArNAiUVw0L14Xmrex9YmE0E/HnBYaGEZhUNIPmuTcTqNzQiiz67bMtUQlSqU3i5hUapXUk08kwdWOPJnDBuQLitLa/qLZWFWzFdfCpE+wxWARUHUTh24mWVdv83ewO1kU/oCMt3ciqZeeKCokjbYT0NUwmUv9/Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NR1zohk/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415NXFtc028179;
	Mon, 5 Feb 2024 23:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ZUwfEox2Gmy2Mb7bQh8JJ1dI1oJWyCYJiPWEmtTM5E8=; b=NR
	1zohk/HjsiUjRhW2p/9oyOqXieLdAbi1mapluipweZyCW12L1Qc3Y0QC4n4T/lJo
	4kf3eapA9XW4SHpQi7AnuzxlyZ9o4Jh3kY9XCPPktIrMSMU/YLHqVvmfs6YVPJdm
	ICl09gOyC/EQeuw03zjMoKl9y1Oc5SU6A3N+5SA9tlg2sUU6edQMvoVF+0jaH8S8
	cGHOnfxxtrlKqixFnXAHReuZuhsLcNYF04OeTArKwl87Gp5k2H0pshu5bIIUHZfy
	QyffJllmKWKgFwrWyB2Ty5YgtvUHsd4QXciK+TkqdIuGOMpZyfHCxIXc7seRT8GE
	2+QMI/iSHviadfUPU01g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2udda2p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 23:43:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415Nh0ch013530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 23:43:00 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 15:43:00 -0800
Message-ID: <3c344e06-ac15-abe2-4fd6-5735090a1f58@quicinc.com>
Date: Mon, 5 Feb 2024 15:42:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] spmi: pmic-arb: Replace three IS_ERR() calls by null
 pointer checks in spmi_pmic_arb_probe()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, <kernel-janitors@vger.kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn
 Andersson <andersson@kernel.org>, Fei Shao <fshao@chromium.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peng Wu <wupeng58@huawei.com>, Stephen Boyd <sboyd@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
References: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
From: David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3MuUxwA4YiYlrpUe-0svT0s0Ry0JovhR
X-Proofpoint-GUID: 3MuUxwA4YiYlrpUe-0svT0s0Ry0JovhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_17,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=740 clxscore=1011
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050177

On 2/4/24 01:24, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 4 Feb 2024 09:39:48 +0100
> 
> The devm_ioremap() function does not return error pointers.
> It returns NULL on error.
> This issue was detected once more also by using the Coccinelle software.
> 
> Update three checks (and corresponding error codes) for failed
> function calls accordingly.
> 
> Fixes: ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")
> Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> 
> See also:
> Suggestion by Peng Wu
> [PATCH -next] spmi: pmic-arb: fix a NULL vs IS_ERR() check in spmi_pmic_arb_probe()
> https://lore.kernel.org/lkml/20221115090927.47143-1-wupeng58@huawei.com/
> https://lkml.org/lkml/2022/11/15/197
> 
> 
>  drivers/spmi/spmi-pmic-arb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Thanks for making this fix.

Take care,
David


