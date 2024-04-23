Return-Path: <linux-kernel+bounces-155760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9298B8AF6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A03F2880D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65D713C677;
	Tue, 23 Apr 2024 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bpGE6YPp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3285653;
	Tue, 23 Apr 2024 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897766; cv=none; b=IBtpvF5MP+XvsEUUOdR+k5+/yoFk7iTjIzLI+GIZP81FUIDoFgb10KEeXWn/NoZR7EtDsLTy0v4cObSr1Wum+RwvkYEE05EAef1WauqUs5nE6vH/7qWhqCgRac9Nk0T1NFC0XCUq0KV3+H+SW96K5ll3sWgRE93/2fEQ3VTbDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897766; c=relaxed/simple;
	bh=2U6q3AnIep0O9K7JjfLvpOuvvCYxZ9voAB/ZwE7uOUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uVuX3VVtomR12CvNoCq8zsht8DPbqkE+CvyG1Olh4RUAb+TBv3ZcBBrrGSGSA5T08z0hHOPmR/aKXNpOOttUwewVak3SPkRhAyWY67LOruP7WIm0ocyvwLK+0Nzc/I+YZGBzjvbfVrQ6b0Er2Bd+HBsHjLX7AD6YKIC4hgtQJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bpGE6YPp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5qCGh013043;
	Tue, 23 Apr 2024 18:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tqHQDFqMUEDZk57HJ3NWrEhyU2BqbzhbR5rPVKR1UEM=; b=bp
	GE6YPpdalyvKNMg8X8nS7wymRW/A62GrJ4Ah7GJQbVcr4s9CPlFvkQp5yinpHnrX
	XNFi9Yr77JECaCgneF5IUZwMNR2UGqvl6tCISUhdjLApIDBS9p/G69jXV2VYFVq9
	is9gTDSJaGC7glspL1WkSUBvQqarcOfyms8eE5vnfgKf0gVLEvlC+uQdcbmYkFTB
	76KlicJvE0omenoxstR1vOA7a2sGVaBysgpFf8+erDiLf4T3Hk5x2WFfKa6lU4KQ
	cGURS7mh9jTJn1muAGjF3/TYGa64xr0PugBV8hcdRDxw4l5eIyEdwY2bgG1ATLxr
	HdOmBgNqALEYI3iUAGIQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtnb6u2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:42:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIge11023290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:42:40 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:42:39 -0700
Message-ID: <4e766214-1bf4-9377-d9db-ed7b0b9e2832@quicinc.com>
Date: Tue, 23 Apr 2024 12:42:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v4 1/3] bus: mhi: host: Add sysfs entry to force device to
 enter EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1713868417-37856-1-git-send-email-quic_qianyu@quicinc.com>
 <1713868417-37856-2-git-send-email-quic_qianyu@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1713868417-37856-2-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xzaDnPiYSyLWFIa9-BJF5PvQh2FDQK8K
X-Proofpoint-ORIG-GUID: xzaDnPiYSyLWFIa9-BJF5PvQh2FDQK8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=732 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230043

On 4/23/2024 4:33 AM, Qiang Yu wrote:
> Add sysfs entry to allow users of MHI bus force device to enter EDL.
> Considering that the way to enter EDL mode varies from device to device and
> some devices even do not support EDL. Hence, add a callback edl_trigger in
> mhi controller as part of the sysfs entry to be invoked and MHI core will
> only create EDL sysfs entry for mhi controller that provides edl_trigger
> callback. All of the process a specific device required to enter EDL mode
> can be placed in this callback.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

