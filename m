Return-Path: <linux-kernel+bounces-5809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21130818FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 360C7B241B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94738DFA;
	Tue, 19 Dec 2023 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nloN4sZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6538DE9;
	Tue, 19 Dec 2023 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJDDEZu004213;
	Tue, 19 Dec 2023 18:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=l2mjR068uBgssSL2NBDdgKbwryFxHPTPbyLcDtsZecg=; b=nl
	oN4sZNm5DLgsslfyIKB/BhmU7XsbhLUGV+HLerlrU4qV6pivcYxoO0Xfz6gBr7oa
	OOSHlgD/U5NtPDp5qcqC551Qf9lQo2kBgn46aDH8CL8deAhVLd86PPrEtoJlLF+2
	0ahlY1oXDUwyMW9yw2Vo+ydfimWdiGdyL4SNoZzLV8BbRMY5BwhBSb4ugas+xiCz
	JagIiNHLjKQ2rdFlnDuIrbl/OMy654LMaqnX8KpYHf81WN91X3Y0rVuabut24r0+
	P2gDk5OTlaCJFFgS/2+2c+pxjOJuj1bBuoRnUq8X7o6u4lrbawN18NkA7mRrEhgS
	0OY+1MlNMM+ez+spbGFQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v330kt453-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 18:25:04 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJIP3aq012087
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 18:25:03 GMT
Received: from [10.110.67.222] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 10:24:58 -0800
Message-ID: <35eaac60-5617-4b42-bf1e-55d4f4dbbd2f@quicinc.com>
Date: Tue, 19 Dec 2023 10:24:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] arm64: qcom: add and enable SHM Bridge support
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh
	<quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian
 Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20231127141600.20929-1-brgl@bgdev.pl>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _aK5AV8CyCUucdYhkxl0iI19k8lsA1ME
X-Proofpoint-GUID: _aK5AV8CyCUucdYhkxl0iI19k8lsA1ME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190137



On 11/27/2023 6:15 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is pretty much another full rewrite of the SHM Bridge support
> series. After more on- and off-list discussions I think this time it
> will be close to the final thing though.
> 
> We've established the need for using separate pools for SCM and QSEECOM
> as well as the upcoming scminvoke driver.
> 
> It's also become clear that in order to be future-proof, the new
> allocator must be an abstraction layer of a higher level as the SHM
> Bridge will not be the only memory protection mechanism that we'll see
> upstream. Hence the rename to TrustZone Memory rather than SCM Memory
> allocator.
> 
> Also to that end: the new allocator is its own module now and provides a
> Kconfig choice menu for selecting the mode of operation (currently
> default and SHM Bridge).
> 
> Due to a high divergence from v2, I dropped all tags except for
> patch 1/15 which didn't change.
> 
> Tested on sm8550 and sa8775p with the Inline Crypto Engine and
> remoteproc.
> 
> v5 -> v6:
> Fixed two issues reported by autobuilders:
> - add a fix for memory leaks in the qseecom driver as the first patch for
>   easier backporting to the v6.6.y branch
> - explicitly cast the bus address stored in a variable of type dma_addr_t
>   to phys_addr_t expected by the genpool API
> 
> v4 -> v5:
> - fix the return value from qcom_tzmem_init() if SHM Bridge is not supported
> - remove a comment that's no longer useful
> - collect tags
> 
> v3 -> v4:
> - include linux/sizes.h for SZ_X macros
> - use dedicated RCU APIs to dereference radix tree slots
> - fix kerneldocs
> - fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
>   that creates the SHM bridge
> 
> v2 -> v3:
> - restore pool management and use separate pools for different users
> - don't use the new allocator in qcom_scm_pas_init_image() as the
>   TrustZone will create an SHM bridge for us here
> - rewrite the entire series again for most part
> 
> v1 -> v2:
> - too many changes to list, it's a complete rewrite as explained above
> 
> Bartosz Golaszewski (13):
>   firmware: qcom: qseecom: fix memory leaks in error paths
>   firmware: qcom: add a dedicated TrustZone buffer allocator
>   firmware: qcom: scm: enable the TZ mem allocator
>   firmware: qcom: scm: smc: switch to using the SCM allocator
>   firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
>   firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
>     allocator
>   firmware: qcom: qseecom: convert to using the TZ allocator
>   firmware: qcom: scm: add support for SHM bridge operations
>   firmware: qcom: tzmem: enable SHM Bridge support
>   firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
>   arm64: defconfig: enable SHM Bridge support for the TZ memory
>     allocator
> 
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/firmware/qcom/Kconfig                 |  30 ++
>  drivers/firmware/qcom/Makefile                |   1 +
>  .../firmware/qcom/qcom_qseecom_uefisecapp.c   | 261 +++++--------
>  drivers/firmware/qcom/qcom_scm-smc.c          |  30 +-
>  drivers/firmware/qcom/qcom_scm.c              | 179 +++++----
>  drivers/firmware/qcom/qcom_scm.h              |   6 +
>  drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_tzmem.h            |  13 +
>  include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
>  include/linux/firmware/qcom/qcom_scm.h        |   6 +
>  include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
>  12 files changed, 669 insertions(+), 255 deletions(-)
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
>  create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
>  create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h
> 
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

