Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1318042E0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjLDXvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjLDXvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:51:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F52218F;
        Mon,  4 Dec 2023 15:51:26 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4NcRiG020830;
        Mon, 4 Dec 2023 23:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rmUVCeXIectaoX8MbaXlnvAauz1h+STGG4XYQSDxSe4=;
 b=dve4FYNKyL7/0Fev322UdoGoR0DEnUqIyAwYnUjxgjt6S5fUhlaj5Z59iZlMjV3MgVzU
 zDx1OTYqblyjUmbKjCOHo1vW3erOWRpte4QBT2QUupsD4nDgblIYadU8l/ck5D1nJbfl
 l8Gk7mnRGg0rzjeXYknXTPNDMWLhfhR6Wi5k2BdbMOd/J+uV7hq0er/wGkaEJARkeCaa
 wxbrHTz75mgEnlY5Eaf9Us3FKkoTmZqoGNER4qeel6McwUBYP0X2LVCcqIaKv2JcVSXU
 0vOZHXniKWS5XSsNeM0a2iQeqjjy1Dmij3us/dpY17e+DRI5WhBCTbaHLp7hRw7X5T34 Wg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usfu79ady-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 23:51:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4NpCb2018847
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 23:51:12 GMT
Received: from [10.110.122.69] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 15:51:09 -0800
Message-ID: <fdd1caf6-66dc-485d-bd03-72e7ac99f571@quicinc.com>
Date:   Mon, 4 Dec 2023 15:50:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] arm64: qcom: add and enable SHM Bridge support
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Maximilian Luz" <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        "Srini Kandagatla" <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
References: <20231127141600.20929-1-brgl@bgdev.pl>
From:   Deepti Jaggi <quic_djaggi@quicinc.com>
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tCZanKmebhxkYp4Z_Fa2x37x6nHBr_is
X-Proofpoint-ORIG-GUID: tCZanKmebhxkYp4Z_Fa2x37x6nHBr_is
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040187
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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
Verified the following :
Shm Bridge creation
Successful qcom_scm_assign_mem calls using tz allocator 

Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
