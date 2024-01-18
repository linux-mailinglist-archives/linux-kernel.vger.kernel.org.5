Return-Path: <linux-kernel+bounces-30295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200DE831CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54BC283FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3F4286B6;
	Thu, 18 Jan 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Chk0Y6eW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797981DA35;
	Thu, 18 Jan 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592662; cv=none; b=EILXqSt1DUCGbA26Otzdnhk9b7PKAwfN/2AW7JWpyzh82m1eMiReQtjUOpSxI8VcCzr2LP8U9v3yiLVrHqTn1qYMtvjFuBLNefztSdzzCS3xAEyeQjAr5wg8/jsQs8nx/lt5uE3Z8CFf6H2pt5pNK7/bcuhikqUcnftCMYYvZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592662; c=relaxed/simple;
	bh=29lW8a3oUPVivJkn9P3g67vzRlvnzseWiPxL1zLp8pU=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=VTp6kXTxOuSMwtux9fbesqTGkTasb/mUJlAK9z4VufQ2tTIj8ReJcNeTZ/Cf4ppTjUc9xKPbtlS8A0ElLOsxK6BpxwKu2uodw11Rf4BXep25hPnnrTibuzk9mzzoKzysx7QcySkIZIyvj1K47SbEntBM2kQN6m7tM3GuEAmfh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Chk0Y6eW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IF0EDN015329;
	Thu, 18 Jan 2024 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+ZVAgZga1ii+/Sn5ORFdOSTTD7OrfCcFwm/OpdMmb8Y=; b=Ch
	k0Y6eWiXMr2eCVZwWihw+4wX6E3jXZZmfQ+kXvZtcBXezznGdbAcmqNNabjgaB5T
	f3MPs/IYmHZqrkZ4mNG6eX6bHE4amI8NhrEMTFmMnlY8uS/kjH1Ok61xVs5ERBLl
	/MxblLxd5V755MfpDmDggpKXj1a5DK6xCGgqLmwYJe/lbp+WdTVR6hHw4v1tMohW
	TzVz40k0eWrf+FppwtngLGqbwqXJBOx6cCvMEqnm68lcqd+JKroZdJninCG74+PW
	cd4TbU9eG/w/IQzXEzEWHb5fsPjvVO5scEd4Nebi8U7v0BnMwRIoMWWEKN3IKDI8
	OnE6s+T3iCRUNGLg2rRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vq5qrg65s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 15:44:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IFiBbb020942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 15:44:11 GMT
Received: from [10.110.99.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 07:44:11 -0800
Message-ID: <fc6ca019-83e9-4571-bfce-2b4e5c233aef@quicinc.com>
Date: Thu, 18 Jan 2024 07:44:10 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
 <874jfg7xm4.fsf@kernel.org>
 <b4f29511-e001-4964-b88d-208dabf88121@quicinc.com>
 <875xzq526o.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <875xzq526o.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -VQvq0zZEl9ZJ6TH2fjw2tzKOMgYchL_
X-Proofpoint-ORIG-GUID: -VQvq0zZEl9ZJ6TH2fjw2tzKOMgYchL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 mlxlogscore=791 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401180114

On 1/18/2024 3:08 AM, Kalle Valo wrote:
> * To make sure there are no kernel-doc warnings we would have to add
>   checks to ath11k-check, which would slow down it considerably and it
>   would again slow down our workflow (I run it several times a day).

I currently run the following on every upstream patch series I review:

scripts/kernel-doc -Werror -none \
	$(find drivers/net/wireless/ath/ath1*k -name '*.[ch]')

It takes a trivial amount of time.

> * To use kernel-doc formatting alone doesn't really make sense so we
>   would have to start creating a kernel-doc book or something. But who
>   would read it?

Due to the sparseness, nobody would read the actual rendered
documentation; only the documentation as it exists in the code would be
read. However note that Linux cross-reference tool also links to the
documentation, which I often find useful when looking at core kernel
code, and would find it useful when looking at driver code.

> * kernel-doc moves field documentation in structures away from the
>   actual fields which I find confusing.

kernel-doc does support in-line commenting as well:
<https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments>

Although I don't see that used much.

> * The risk of having outdated kernel-doc documentation is high, it would
>   need active maintenance etc.

Agree, but that is true of any documentation. The nice thing about
kernel-doc is that it can actively tell you when the documentation
doesn't match the code.

> * I'm worried about creating useless documentation, like "Count number
>   foo" for foo_count() just because of kernel-doc.

Valid concern

> This is why I consider return on investment is low here :) My preference
> is to make the code understandable (good symbol names etc) and document
> the special cases, which are not obvious from the code, with a normal
> code comment.

Which I'm also fine with.

>> I'm curious what others think of the ath10/11/12k level and style of
>> documentation.
> 
> IIRC iwlwifi uses kernel-doc to document the firmware interface, not
> sure how much it's used elsewhere in the driver.

They have the same problem I'm trying to fix ;)
% scripts/kernel-doc -Werror -none \
	$(find drivers/net/wireless/intel/iwlwifi -name '*.[ch]')
..
322 warnings as Errors
%

I'm not looking to change the status quo. Let me get the last of the
ath10k cleanups in place, and I'll continue to run kernel-doc to make
sure the existing ath1*k documentation is kept up to date.

/jeff

