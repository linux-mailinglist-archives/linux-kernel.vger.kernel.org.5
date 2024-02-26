Return-Path: <linux-kernel+bounces-82346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6BC868314
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC8CB23A72
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937B131E20;
	Mon, 26 Feb 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dQuiR6Iw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32D213173B;
	Mon, 26 Feb 2024 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983000; cv=none; b=BNexx5zxFQgjuVZci5TlDS1027/rHiwTDvEKVhJl+0+IA/dXWtWpLPaOs8o2rURixPZw7SgUgs2+Emuj8YQTByFxM4KCa/GWihx4N7csOgwpcaG9znkYoYk8HRw8eqdl0u1nM5G1trDRZiOIphspAkrJkv/vW6v/WqVjag6jzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983000; c=relaxed/simple;
	bh=8gDuz5mgWE/ZhtidoEWJByIRzXHYukx0InCNd6LB0Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ERFwfguD5Wtk522tLKWW+INCxlxH5bMJgxNd5J+dsjMzbLa6w1EI/5uc+CSDODrIaExTW07rh+dDWsUkCRhhS0uog+9Ka045bxX9gujGBsYF9GoUZMwOe+9IasFRtMQl89DNc2aW5t0bxKwcchP2pMAYSWk20B4znC6OQPGwNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dQuiR6Iw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QL0Z77032516;
	Mon, 26 Feb 2024 21:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MZ9f9rx25naR6v9FTKXv7ZUWyP2Ub5DoHHljraBXq+8=; b=dQ
	uiR6Iwm1M/80I2n1yK3UbrMnlAD0X7LQNOlx5yhzo6urTdyyKCOL4l/1mwf4LgKX
	J1PYxMHASNCR3jZ0G9lRg9GNnQWx6gZDs1sVlIDq9KY6hCNtXMfgBwwlmyoWj/7w
	sygvs4TbzoBsNBEPcyQUAK0LDIN1c3cj2RqMJjiQ80UE+CVHmtGHEe/W4YNIzDsm
	mnOU6v1rxQnrhjPp7a/h8NS6RPa/Z5fqozpa4gdKUFAYmL0ptTyLYZS0qqRDkMXa
	cZFWksqyqP4sk8kseGJCfC7/Tx02ris+oiq0FlmhGX1UEKBZEapTSoAk2iscnrGd
	E2iIdKZoEt8ilZsonnwA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh232r295-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:29:46 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QLTj4c018054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 21:29:45 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 13:29:44 -0800
Message-ID: <a13eeb01-7df9-4577-975f-34b3aed8400f@quicinc.com>
Date: Mon, 26 Feb 2024 13:29:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm: panel: st7701: Add Hardkernel ODROID-GO Ultra
 panel support
Content-Language: en-US
To: Adam Green <greena88@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240221194528.1855714-1-greena88@gmail.com>
 <20240222164332.3864716-1-greena88@gmail.com>
 <20240222164332.3864716-2-greena88@gmail.com>
 <f9446923-acd3-41cf-92d4-676b946280c4@quicinc.com>
 <79a4b60e-24f3-47fd-b3b3-7d207cec1470@gmail.com>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <79a4b60e-24f3-47fd-b3b3-7d207cec1470@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: icxhoZ3v6B03FuVtuvP-mhxjkuhE5VZX
X-Proofpoint-GUID: icxhoZ3v6B03FuVtuvP-mhxjkuhE5VZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260165



On 2/22/2024 9:47 AM, Adam Green wrote:
> On 22/02/2024 17:14, Jessica Zhang wrote:
>> Hi Adam,
>>
>> Just wondering, why the change to 120 here?
>>
>> Thanks,
>>
>> Jessica Zhang
> 
> Hi,
> 
> The 120ms is taken from the datasheet specification for the controller 
> as maximum time it takes for the display to reset,

Got it. Was the shorter sleep time breaking the display and is it 
required for the new panel to work?

Thanks,

Jessica Zhang

> 
> Kind regards,
> 
> Adam

