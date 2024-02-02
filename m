Return-Path: <linux-kernel+bounces-49224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E48484675F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175B41F234C6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9216E171AF;
	Fri,  2 Feb 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RVIwWGOW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D71168A8;
	Fri,  2 Feb 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850029; cv=none; b=ldWClKAcdu3a1T9o7UhNJb8Yu/Dfd21ZVJymo3Ngnt9ijitM4XytwvwKL0XOPEFCEnmr50W/G2pOALRk/5ZtPNNhelrkrdZ/2ZXtQNRvSRoQzq6TB+x+nLcDdCrt1mxDubH930i4s48+h1ygG1oZ79ul0Rbn8pc8S9ZPkMMeaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850029; c=relaxed/simple;
	bh=TTF9pIjOvmYCK7xj74APPIL6UJt+YN06DbhD6BwGLRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TFf5j9bGIKph4Ri3ftsigcXrTkeHIZxON8Yzsi7o+K7T5F+Ky1xdM4Py3yzoTCoEG+6q27d7fqu4vVxu6yvu/PifsENnDif7/GiAZEIDQl/rA8iTLA4Lc3bJ+vvE5rvWkYORmxD+/ZkU8Vuy+kZCkpOYPpH2YHdgSLLbyJSSf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RVIwWGOW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121WueO016177;
	Fri, 2 Feb 2024 05:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mmbLhvHwv02ZMGLBVAAIet0bcTLvaM48nkxu87LZJ4I=; b=RV
	IwWGOWBebEzaKCmx6z+g6zeUZgGqrenxNffBj/0EsEt9IHIWuNQDzKjVb3xlwWAn
	k39viQRD1D6G87nh1b38Z6mqN/ZQE3Ni+T0wdTlDyUPEdTHQEJN+SM0IFADDCEL5
	JjooZj1a8iDwH4b5bynpXpcG9WPzZCGNKPNtl3rad4jN0dh+7GKh34ZYJumTQKNM
	INUdxEA+s/PhBNgDBUhJ1y2hemQjbae+ZQU3pOuEC7PQTzd4Eguh4sbfFvZvgqKl
	R72qv4Y4DkAL1DqJUUkKP0mraejTSymTAyL9z8pQdTLG70ERm+RdkpIQ7FpZmjwk
	wTQkiGGGyVlyaaQdSGjw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00dbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 05:00:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41250LN1020193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 05:00:21 GMT
Received: from [10.216.18.100] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 21:00:15 -0800
Message-ID: <b929f0cd-89b6-c48d-d466-db6bbed621b5@quicinc.com>
Date: Fri, 2 Feb 2024 10:30:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <20240124145631.GA873781-robh@kernel.org>
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <20240124145631.GA873781-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FiaoEXri2mgT76E2ysfraOjz-5wrbyDs
X-Proofpoint-ORIG-GUID: FiaoEXri2mgT76E2ysfraOjz-5wrbyDs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020034

Sorry for the spam, earlier mail had some formatting issue.

On 1/24/2024 8:26 PM, Rob Herring wrote:
> On Sat, Jan 20, 2024 at 04:50:47PM +0530, Amrit Anand wrote:
>> Device manufacturers frequently ship multiple boards or SKUs under a
>> single software package. These software packages will ship multiple
>> devicetree blobs and require some mechanism to pick the correct DTB for
>> the board the software package was deployed. Introduce a common
>> definition for adding board identifiers to device trees. board-id
>> provides a mechanism for bootloaders to select the appropriate DTB which
>> is vendor/OEM-agnostic.
> Show me a 2nd user. Or does vendor/OEM-agnostic just mean vendors of
> QCom devices? Multiple SoC families using this would help your case. I'm
> not inclined to take it into the DTSpec without that.

Agree; since the DT selection identifiers and algorithm used by various 
DT users has been largely undocumented, we were trying to reach a 
generic solution based on our known use-cases.

>> Isn't that what the compatible property is for?
>> -----------------------------------------------
>> The compatible property can be used for board matching, but requires
>> bootloaders and/or firmware to maintain a database of possible strings
>> to match against or have complex compatible string matching. Compatible
>> string matching becomes complicated when there are multiple versions of
>> board: the device tree selector should recognize a DTB that cares to
>> distinguish between v1/v2 and a DTB that doesn't make the distinction.
>> An eeprom either needs to store the compatible strings that could match
>> against the board or the bootloader needs to have vendor-specific
>> decoding logic for the compatible string. Neither increasing eeprom
>> storage nor adding vendor-specific decoding logic is desirable.
> You could hash the compatible strings if it was just a size issue.
>
>> The solution proposed here is simpler to implement and doesn't require
>> updating firmware or bootloader for every new board.
>>
>> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
>> -------------------------------------------------------------
>> The selection process for devicetrees was Qualcomm-specific and not
>> useful for other devices and bootloaders that were not developed by
>> Qualcomm because a complex algorithm was used to implement. Board-ids
>> provide a matching solution that can be implemented by bootloaders
>> without introducing vendor-specific code. Qualcomm uses three
>> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
>> pmic-id.  This does not scale well for use casese which use identifiers,
>> for example, to distinguish between a display panel. For a display
>> panel, an approach could be to add a new property: display-id, but now
>> bootloaders need to be updated to also read this property. We want to
>> avoid requiring to update bootloaders with new hardware identifiers: a
>> bootloader need only recognize the identifiers it can handle.
> So the id list will be always expanding list for every last component
> that is 2nd sourced? The ChromeOS folks are also trying to solve that
> problem.

Agree, this could be an expanding list as and when any new hardware 
identifiers for DT selection become pertinent in future.

>
> There's a similar issue for EFI boot with how to select an OS installed
> DTB[1]. You might not care now, but users may later on (like we have
> already with QCom devices with fixed bootloaders). If you do this
> board-id route, then no doubt that compatible values won't be specific
> enough or have suitable fallbacks to be used. Then EFI boot can't use
> compatible either and needs to use this QCom specific logic. It may be a
> common property name, but all the types you defined are QCom specific
> and the matching logic is pretty much undocumented. I'm not saying we
> have to use compatible. There wasn't even agreement to use it for EFI
> boot case. This does need to work for multiple vendors and multiple boot
> scenarios.
>
Agree, given so many hardware identifiers Qcom uses to find the DT based 
on a best and exact match algorithm, it may not work as is for other 
vendors/users outside the scope of Qcom.
Since we have none to very limited visibility into complete set of DT 
selection identifiers being used by other users or into their selection 
algorithms since it is mostly undocumented,
designing a perfectly generic solution (one-size-fits-all) could be 
far-fetched. The number of board files in Qcom DT selection software 
package often reaches over 100 DT files due to multiple SoCs and
board types being supported out of a single software package and these 
multiple hardware identifiers helps to pick the closest best match DT 
within a very large pool of DTs.
Not to affect other users/vendors who would be using their own set of 
identifiers and an entirely different algorithm for DT selection, would 
it make more sense to define these Qcom specific
identifiers within Qcom specific bindings (qcom.yaml), along with 
detailed documentation on our DT selection algorithm?

Thanks,
Amrit

>
> Rob
>
> [1] https://lore.kernel.org/u-boot/20231114232012.GD6601@bill-the-cat/#r

