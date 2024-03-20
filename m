Return-Path: <linux-kernel+bounces-108486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A2F880B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3E21C21FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B356199AD;
	Wed, 20 Mar 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i8lipXK4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC53182C5;
	Wed, 20 Mar 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915277; cv=none; b=dC0J8PFJ3lxRsy0j1HCwr322cUtCPkqZuh/kETADj1/ID+e05hjlkU0Dxsmy1K/+g8tHiYfueAixYy/atw5mVppRwnqeI5/U+hgkaR/eJaZ/7/tJXLnFHACJrVaKsTIlil4UWH5p4DDAsl83PM4M9wcvUZfliUZj5Puf2lLNhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915277; c=relaxed/simple;
	bh=sYjgMXmmRIeUswy8yAn2bF1ZX+zugdRaoOqJPs8SWpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UlSFu99vvv6TDlxpaGZtb5Iyq14hJhT/l9KKpqRTAYIYybe2DuHeJ56gQFlFeHeuYCVKhubFgrxGBrBBYRM/6vJ12ytOm1xbbIGT2xY23556g3k84oKoUptfQYk33O4K77hnOLo1fp8n9JB/yy5H6llRODzksMOd8NBqE0cNgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i8lipXK4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K4Tn5h003074;
	Wed, 20 Mar 2024 06:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Lif/BQbrb6h/PF0d7/WMWEzXs4USXv3wbzbR/YNq5MY=; b=i8
	lipXK4QmQsjrrcC/1yW0ceum9ADlCnY6tthU5tkJZNsyPNerczg2ADIqxYBT/VUX
	3A+EwwiCbCNa5zuuC4Nn0XJWoESzwjh2JmdVNE7EQLay2ga95tFVV28Jm+rH0G9V
	aZN9Paowz+yhAmBFWYK1B5tJOCcTcEOvH4rdzrm7FIfCSMUftBjqSeC5x/Rgv4W0
	5Igrv/tPYSs++C8WGd1Ib51RSFAmPjZIJf2TpZSkEPVWM/CZJrVlE0bCLcp6j4gH
	iTVk3fox6NNSEIV20wdRiaG15DgnMtG0NU3OH2woNXc2nQeDa4tZIIfe/+YfMF/t
	vpBXUm75OXLWm4CZBOoA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyqh609rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:14:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K6EU74018131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 06:14:30 GMT
Received: from [10.216.4.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 23:14:26 -0700
Message-ID: <8b1da227-ad6b-4fec-b9e9-d07b8bcbd813@quicinc.com>
Date: Wed, 20 Mar 2024 11:44:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] rpmsg: glink: Add bounds check on tx path
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>, <afaerber@suse.com>,
        <ivan.ivanov@suse.com>
References: <20240113002505.15503-1-mkoutny@suse.com>
 <151f5738-791e-42cb-b8fe-e0cfbf9f7dca@quicinc.com>
 <egp4g4i54le4iizpdfpxi24k563hniwub7iy2dwrk7ul47uhf4@z5scfrisbd46>
From: Deepak Kumar Singh <quic_deesin@quicinc.com>
In-Reply-To: <egp4g4i54le4iizpdfpxi24k563hniwub7iy2dwrk7ul47uhf4@z5scfrisbd46>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ol2m4hLgpHUiR9bNXbXqpc3G4pfj9RU2
X-Proofpoint-GUID: Ol2m4hLgpHUiR9bNXbXqpc3G4pfj9RU2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=547 malwarescore=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200048



On 1/29/2024 10:03 PM, Michal Koutný wrote:
> On Mon, Jan 29, 2024 at 04:18:36PM +0530, Deepak Kumar Singh <quic_deesin@quicinc.com> wrote:
>> There is already a patch posted for similar problem -
>> https://lore.kernel.org/all/20231201110631.669085-1-quic_deesin@quicinc.com/
> 
> I was not aware, thanks for the pointer.
> 
> Do you plan to update your patch to "just" bail-out/zero instead of
> using slightly random values (as pointed out by Bjorn)?
> 
> Michal
Hi Michal,
Yes, i will be fixing those comments and re post patch.

