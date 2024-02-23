Return-Path: <linux-kernel+bounces-79270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB02861FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B571F234C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB614535B;
	Fri, 23 Feb 2024 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nulq0hYu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52BE1419B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727900; cv=none; b=ta4e1CEd/4AvaonOmJ+jxQniXVC09/q7kjBi7kJD0MeExWbgZt1iVpEWrXTwQvfxlupWc0bnofdBTUY04z2dJwb6ImNZruvZY+PfgBUauqwnKw8HtvkdKSDrVxitECKk3ISShg+O+smKH+J0Z1iMOxg5gJHMECCX+SsP77cXIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727900; c=relaxed/simple;
	bh=xRYQtEwmZR15JdXIRclUyKWaVz7SYgwkLtWar0fwArQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=bGJwqNiaCdCbcHDS8l6drM9yf0lSYzfiyz9mD0KvWc1+Kkpn6SilHgcshVzk8k1XzC1RfPjKMsa7J8AQoDTcWfwZ09MFZmkHL1h/1y6KhXNtbsPL274wNveoM6df9L9BuhlUNmISeBLT5v17pMYzt/jNbu4q+hXUzg8jCYa0DbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Nulq0hYu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NMY2HJ023402;
	Fri, 23 Feb 2024 22:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:cc:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J46BJAXfpllB88/E0IwkFqoWI3dmnzmmD8LlpP0L3o8=; b=Nu
	lq0hYuLT4c34CgZHTde6YxYl37zYEQFxu4PrC/yei7lCNzNRmnrDWMlO/iNU789c
	bXLS1uCZdnd+fN3yx3uWOm0cf67nstFMXGLDffLAU2mu406tGnrcHWaS3ifzuySl
	eLyoCx/zPxWELN/wmjXaY8V/XsZ6SHM6EbociSPhcz+ORTLtOjy5FOXdoCIlEanR
	9iW9O/QrgpzvhQrViuDeptUZIfj4fjnS4kC+Z6nE5TWDzhOR9WiMmJTvLsiK3LA2
	MFInpoIkzpKhIaMsh6iwDg5OYOYyjzh5Fqv0IQ9rR6pkAutpK/ZvM9fACBxkTwc2
	tSFUJPoipJuQ/fTGKrCw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf3gm02tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:38:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NMcBtG030812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:38:11 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 14:38:11 -0800
Message-ID: <1eb926a6-3467-aaf4-2bc0-8d9756516d9c@quicinc.com>
Date: Fri, 23 Feb 2024 14:38:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] accel/habanalabs/gaudi2: use single function to
 compare FW versions
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
CC: Ohad Sharabi <osharabi@habana.ai>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 52C1PbaEr4JUDsBhIa0e1QkFvnkNeUYb
X-Proofpoint-GUID: 52C1PbaEr4JUDsBhIa0e1QkFvnkNeUYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230162

On 2/20/2024 8:01 AM, Oded Gabbay wrote:> From: Ohad Sharabi 
<osharabi@habana.ai>
 >
 > Currently, the code contains 2 types of FW version comparison functions:
 > - hl_is_fw_sw_ver_[below/equal_or_greater]()
 > - gaudi2 specific function of the type
 >    gaudi2_is_fw_ver_[below/above]x_y_z()
 >
 > Moreover, some functions use the inner FW version which should be only
 > stage during development but not version dependencies.
 >
 > Finally, some tests are done to deprecated FW version to which LKD
 > should hold no compatibility.
 >
 > This commit aligns all APIs to a single function that just compares the
 > version and return an integers indicator (similar in some way to
 > strcmp()).
 >
 > In addition, this generic function now considers also the sub-minor FW
 > version and also remove dead code resulting in deprecated FW versions
 > compatibility.
 >
 > Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
 > Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
 > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
 > ---
 >   drivers/accel/habanalabs/common/firmware_if.c | 25 ++++++++
 >   drivers/accel/habanalabs/common/habanalabs.h  | 20 +------
 >   drivers/accel/habanalabs/gaudi2/gaudi2.c      | 57 +++----------------
 >   3 files changed, 34 insertions(+), 68 deletions(-)
 >
..
 > diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c 
b/drivers/accel/habanalabs/gaudi2/gaudi2.c
 > index 1f061209ae21..4a0917aa4dd7 100644
 > --- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
 > +++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
 > @@ -2601,6 +2601,8 @@ static int gaudi2_set_fixed_properties(struct 
hl_device *hdev)
 >
 >   	prop->hbw_flush_reg = mmPCIE_WRAP_SPECIAL_GLBL_SPARE_0;
 >
 > +	prop->supports_advanced_cpucp_rc = true;
 > +
 >   	return 0;
 >
 >   free_qprops:
 > @@ -3308,8 +3310,6 @@ static int gaudi2_late_init(struct hl_device *hdev)
 >   	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 >   	int rc;
 >
 > -	hdev->asic_prop.supports_advanced_cpucp_rc = true;
 > -
 >   	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS,
 >   					gaudi2->virt_msix_db_dma_addr);
 >   	if (rc) {

Is this change in support of the others in this patch? Feels like this 
should be more than one patch (adding new version_cmp, removing old checks).

-Carl V.

