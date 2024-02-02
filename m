Return-Path: <linux-kernel+bounces-49649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A3846D77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A62294D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366A479930;
	Fri,  2 Feb 2024 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M/8tfW5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBDF9C6;
	Fri,  2 Feb 2024 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868786; cv=none; b=hqu3IK/mHgb3AfivkoZPBpmgRJRDG0D6Td3/73199SXO24B1RRfch/ABHMSazmz1vZIIvSAzBQcQZmIQrthk3b0MuOZlUKq31nBjHGU21065BaE5kavgmF81Ygez0nhiDBvWE3WMVkxodZHwNaWaEYghC05dX8zBy+RlWDcTNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868786; c=relaxed/simple;
	bh=dHJGRlevi/QAVq8fajBfMOVi2PTkZsb3r4E3Fh7Ef0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hPgBQTa46jkpoRKqEXAOuOG3jtyPSvsP8aoWBfCXr2DGe26jaBwhnmb6jhk2ZDThHOQ2kaK4zGy6bnakVfUNG9g+FOJRGVHbqGngOYKyq54IvBgBgNev+lmjWsJC0C+MCMtxk0wY5wt22pvjZuwg7RnWWzQl3Wu4DZ/8gW+XQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M/8tfW5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121X6mY020285;
	Fri, 2 Feb 2024 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dHJGRlevi/QAVq8fajBfMOVi2PTkZsb3r4E3Fh7Ef0I=; b=M/
	8tfW5tDycQFiPA/rmt1Z6KUkmzypEUGE70Kw4PNiHHYiWCed4rU3mPOSvat7JQDb
	/ZjXdLFMKhQkTuF6EikqdLCQa/7byMRD+0EWffHnmIO1SwQ74Uq0rcTuKq8up1QR
	54ooWBueOv8ReKl1IZOrM7VDZE0w0cBYonZMSDkidd7Bz7L4vBSWiPLiRKeblVCz
	ro9oNt5UgHaYhzKdyZLlN7YleULGOfEFLTzrKN4JEJKLygY5n5Xb3pZ6rd1JTNu5
	SanNju7BDB975ASnLD4EB5kQzCRW5uY9HQ6r8sgKSFb6XcpyjFnygMtaUPbE9nBm
	tfTdkrZEaM99jbuzi8Qg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptxh3r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:12:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412ACaAt001367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:12:36 GMT
Received: from [10.50.50.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 02:12:32 -0800
Message-ID: <1fc07430-40bf-42ce-b6f3-316c4d3ced87@quicinc.com>
Date: Fri, 2 Feb 2024 15:42:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm: Drop unneeded selects in DRM drivers
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
        <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        "Rafael J . Wysocki"
	<rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
CC: "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS"
	<dri-devel@lists.freedesktop.org>,
        Melissa Wen <mwen@igalia.com>,
        Mark
 Pearson <mpearson-lenovo@squebb.ca>
References: <20240201221119.42564-1-mario.limonciello@amd.com>
 <20240201221119.42564-6-mario.limonciello@amd.com>
From: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
In-Reply-To: <20240201221119.42564-6-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LtARww-F6AFB766SHH_-hrgefCFa-wVI
X-Proofpoint-GUID: LtARww-F6AFB766SHH_-hrgefCFa-wVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=515 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020074


On 2/2/2024 3:41 AM, Mario Limonciello wrote:
> All of the selects on ACPI_VIDEO are unnecessary when DRM does the
> select for ACPI_VIDEO as it provides a helper for acpi based EDID.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>

