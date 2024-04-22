Return-Path: <linux-kernel+bounces-153698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563808AD1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39801F2263C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB5F153BCB;
	Mon, 22 Apr 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZIMCKvpL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D92153837;
	Mon, 22 Apr 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802881; cv=none; b=u2CPU9Qg7CG7jxJnaWnEQ+IC9R40XCQ5CGl43FuWpqt8ve+ZnHwiyEdCdd61DaIuXNXFE0xBOQYb482rEFfftRwY52iLY0T22j/yHR972eEJ8sNHXNcfoBYiD+gmPYajUkb+Ty5U7rxYjJV2w7wx+0m6bqWLjt3KOtAJWEa3+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802881; c=relaxed/simple;
	bh=0UobfBGE+SyjW5hpf/zsJLUNrWOzqshbd4AmR8Z7g9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JiegcIsxaOuUWoF9SEWHZOAGxXoDKHrusFu+K2zkfDT5b1Gr22UVQcYUTW98+zmJaDbqghZ/FURfkNGqx1NV4iC6vJmT+CpEVkaapuL0Sp52R6wE4X6jTNizvZ8gMTt3RkfG49PJybGJw1GYtbwYcpUKkYEvT/67yy0ECkKw2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZIMCKvpL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MFfaaI008025;
	Mon, 22 Apr 2024 16:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BeB6ld/0x9MpnPNJNCXzKwtz17XBbhkY2cn9Yw1AGC8=; b=ZI
	MCKvpLQmoLhxmEjIgFn4mexrYRZ9l6voRX8g2Zwukc2crYxm8nuv/dFZ4yDLUoJb
	GpfeUs7CrET0JYFfXIG6HIVLkS6oe1HNFYgdLwFGbHJD74TZDSJavzuPGWW9H77N
	EexLlBUKDZ90/0OlZ3OAnbRe7p9ofYj+iEMyPtmiQ005ZHuvWCS+V+TkhxLzXJnZ
	NCv1c+yqZ0G+ceH0r2FZPcuM1017vTHFBmU+X2NCBHj0X4u5eDtJK14DF6sC424d
	i/9T2RBZf/fZxix+Wtz/sIN9eMi0rrf+n+rlmIC9Fmu9LmoIwdbVky8aMBqx/RPH
	MWUEhp4RTAEoJOjubQwg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qdd2a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:21:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGL2X7027898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:21:02 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:21:01 -0700
Message-ID: <9fc9866b-b2fb-40ee-97ea-0e819f05dc15@quicinc.com>
Date: Mon, 22 Apr 2024 09:21:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2] wifi: ath10k: Fix an error code problem in
 ath10k_dbg_sta_write_peer_debug_trigger()
Content-Language: en-US
To: Su Hui <suhui@nfschina.com>, <kvalo@kernel.org>, <jjohnson@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <morbo@google.com>,
        <justinstitt@google.com>
CC: <c_mkenna@qti.qualcomm.com>, <linux-wireless@vger.kernel.org>,
        <ath10k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <kernel-janitors@vger.kernel.org>
References: <20240422034243.938962-1-suhui@nfschina.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422034243.938962-1-suhui@nfschina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0A8r2vmO4FIBEAzjcwXp__E0KoBsziKC
X-Proofpoint-ORIG-GUID: 0A8r2vmO4FIBEAzjcwXp__E0KoBsziKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=762 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220069

On 4/21/2024 8:42 PM, Su Hui wrote:
> Clang Static Checker (scan-build) Warning:
> drivers/net/wireless/ath/ath10k/debugfs_sta.c:line 429, column 3
> Value stored to 'ret' is never read.
> 
> Return 'ret' rather than 'count' when 'ret' stores an error code.
> By the way, remove some useless code.
> 
> Fixes: ee8b08a1be82 ("ath10k: add debugfs support to get per peer tids log via tracing")
> Signed-off-by: Su Hui <suhui@nfschina.com>Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


