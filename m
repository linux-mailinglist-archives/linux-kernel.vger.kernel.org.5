Return-Path: <linux-kernel+bounces-166806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78398B9FC8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5C01C21E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D3172BCC;
	Thu,  2 May 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LEERy5kx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDE171084;
	Thu,  2 May 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672205; cv=none; b=EoV8ZrhAVRewZbHaxyZwrQ8PcbVajpMbKSJNPQrAwd1zm9R6N6o1wWKXxPH70geX6gLHLze8d3T4LXk+b+nfCAPpeGWTX5KqP4Aftx+afOhiiggRAjlJlJ8rHlKD6evlxQDH+TSvgMT+55e4P53c0bXrMzAzZ7pgduV24utlqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672205; c=relaxed/simple;
	bh=8D8Kanjqj4Duz0uj0LpXU4CcD738RwtJEYDvUj9KeBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N2fVjWxojkqlL291OmkQhJEKiUnHwLjzV1cFpgzASAJi838//d3qrDeIgkrsGc+vVbBIoxFjRPugl/9p5mfN3viy9XceFEKgIy5/dDdVjD+rEj4TUi4JsdUJJy8iukDLZnIjZK/VAaUomqoWqqPfxd3+wFTdPoVZv/nHE1j3cZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LEERy5kx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442D9YS8013434;
	Thu, 2 May 2024 17:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XvdVMLx1MFCRl0I6Or8try5dwWTO2c6SLc2mEHmOAyc=; b=LE
	ERy5kxoc3gcsOa24tXOUylSrYLSgIPqFipeYpPCtJWJTcTaDHs/0nkEDCsCoxN9t
	TLortv9OSpSlPY3wknXPp9uYx4NC2PYmMj/iVkvHcmQzyBjUsNwZYf3IDei8VSLj
	giEw8y1e3eGJ77y+r1etN8A1Et4xQz98cKh4d1AY2WUjxHEJG1U52VHrL/fr0XS4
	8uVi94scLX2moyQjz/ar52F882ZkT8PQFVi3Orc6HVOVNBcpVFDHOrLTgpqAYl+q
	Jx7J+joBxXdgD+97TcbRjiLlLnXdda6qVtxzrS6toNtQn8FJ36+Gk2tTKIwNGjaE
	5DRb6atGxQm6UjB7TSqw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvbeernh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:49:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442Hnu6M011185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 17:49:56 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 10:49:55 -0700
Message-ID: <7571022b-2055-4900-9b30-c12917b68f01@quicinc.com>
Date: Thu, 2 May 2024 10:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZjLFIa31BGPVCGh1@neat> <202405012008.38A5EB34F@keescook>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <202405012008.38A5EB34F@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yRF6ckCMI1YKp4mX7wRvhHv1Sh9MlGRY
X-Proofpoint-ORIG-GUID: yRF6ckCMI1YKp4mX7wRvhHv1Sh9MlGRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_09,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=751 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405020117

On 5/1/2024 8:09 PM, Kees Cook wrote:
> On Wed, May 01, 2024 at 04:41:37PM -0600, Gustavo A. R. Silva wrote:
>> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> So, remove unused structs and fix the following
>> -Wflex-array-member-not-at-end warnings:
> 
> Heh. Yes! Very effective. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
My favorite kind of patch :)

