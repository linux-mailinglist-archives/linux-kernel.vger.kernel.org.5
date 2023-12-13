Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3548118FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjLMQSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjLMQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:18:10 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D49CF;
        Wed, 13 Dec 2023 08:18:16 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDF985q020589;
        Wed, 13 Dec 2023 16:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=nMpqpToUbMmOflSDpK5xEseDBmZu9/9GMS4KnazN6rs=;
 b=FVJB3kLwE5DdqqyuYdxuqeuU1cHR2+WcAKSjz3y79g6ra29IZYxc1uW9PZEA6lOLwJVT
 f6I2krPvAnLrJIucxj8oyXh+g7mCcp922l1K3E6dOQxlscHRvs2TSNR/SVkjWBK32rcg
 vdH0zWhE8/2VAAoWMPRLNAngzYdgsDWynvFxro8jw3yvJRPyqgQTb/gBfyPHvGfxushj
 xP6WzLKTGPLc0whGjOYKPRmwGi/2y4X7pn+5qqn1eBcMhXrlrSscplkM2wbj3BDlTHgw
 IECD21rAUVDUGQIjWM5TF0M6O2mMlq4imTnqjZmZPPW4MuA+Kib60PKK5KT56Zb1CSPa ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uycuq5y18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 16:18:10 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDGG2QM022733;
        Wed, 13 Dec 2023 16:18:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uycuq5y0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 16:18:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7EGIa014833;
        Wed, 13 Dec 2023 16:18:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kf534-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 16:18:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDGI5HL46334612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 16:18:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8927E20043;
        Wed, 13 Dec 2023 16:18:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1702E20040;
        Wed, 13 Dec 2023 16:18:04 +0000 (GMT)
Received: from [9.179.18.31] (unknown [9.179.18.31])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 16:18:04 +0000 (GMT)
Message-ID: <0851ca19-ef4d-4fef-a182-6b9e0b6b483b@linux.ibm.com>
Date:   Wed, 13 Dec 2023 17:18:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
To:     Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kgraul@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: svdNPIDk_S9t0FJY5S1FgEnpwQiFSXCH
X-Proofpoint-GUID: -L85_3GBpl2bPU3eTul0kKzYE0isnf3Q
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_09,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 adultscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2023 09:52, Wen Gu wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

Also there was a typo in the
linux-kernel@vger.kernel.org
Fixed it on this Mail.
Sorry for the noise.

> 
> v6->v5:
> - Add 'Reviewed-by' label given in the previous versions:
>    * Patch #4, #6, #9, #10 have nothing changed since v3;
> - Patch #2:
>    * fix the format issue (Alignment should match open parenthesis) compared to v5;
>    * remove useless clc->hdr.length assignment in smcr_clc_prep_confirm_accept()
>      compared to v5;
> - Patch #3: new added compared to v5.
> - Patch #7: some minor changes like aclc_v2->aclc or clc_v2->clc compared to v5
>    due to the introduction of Patch #3. Since there were no major changes, I kept
>    the 'Reviewed-by' label.
> 
> Other changes in previous versions but not yet acked:
> - Patch #1: Some minor changes in subject and fix the format issue
>    (length exceeds 80 columns) compared to v3.
> - Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
>    and smc_listen_v2_check() compared to v4.
> - Patch #8: new added, compared to v3.
> 
> v5->v4:
> - Patch #6: improve the comment of SMCD_CLC_MAX_V2_GID_ENTRIES;
> - Patch #4: remove useless ini->feature_mask assignment;
> 
> v4->v3:
> - Patch #6: use SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid
>    entries in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the
>    max devices to propose;
> - Patch #6: use i and i+1 in smc_find_ism_v2_device_serv();
> - Patch #2: replace the large if-else block in smc_clc_send_confirm_accept()
>    with 2 subfunctions;
> - Fix missing byte order conversion of GID and token in CLC handshake,
>    which is in a separate patch sending to net:
>    https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #7: add extended GID in SMC-D lgr netlink attribute;
> 
> v3->v2:
> - Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
> - Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
> - Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
> - Remove smc_ism_set_v2_capable() helper for now, and introduce it in
>    later loopback-ism implementation;
> 
> v2->v1:
> - Fix sparse complaint;
> - Rebase to the latest net-next;
> 
> Wen Gu (10):
>    net/smc: rename some 'fce' to 'fce_v2x' for clarity
>    net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
>    net/smc: unify the structs of accept or confirm message for v1 and v2
>    net/smc: support SMCv2.x supplemental features negotiation
>    net/smc: introduce virtual ISM device support feature
>    net/smc: define a reserved CHID range for virtual ISM devices
>    net/smc: compatible with 128-bits extended GID of virtual ISM device
>    net/smc: support extended GID in SMC-D lgr netlink attribute
>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>    net/smc: manage system EID in SMC stack instead of ISM driver
> 
>   drivers/s390/net/ism.h        |   7 -
>   drivers/s390/net/ism_drv.c    |  57 +++-----
>   include/linux/ism.h           |   1 -
>   include/net/smc.h             |  16 ++-
>   include/uapi/linux/smc.h      |   2 +
>   include/uapi/linux/smc_diag.h |   2 +
>   net/smc/af_smc.c              | 116 +++++++++------
>   net/smc/smc.h                 |  10 +-
>   net/smc/smc_clc.c             | 318 +++++++++++++++++++++++++-----------------
>   net/smc/smc_clc.h             |  58 ++++----
>   net/smc/smc_core.c            |  37 +++--
>   net/smc/smc_core.h            |  18 ++-
>   net/smc/smc_diag.c            |   9 +-
>   net/smc/smc_ism.c             |  50 +++++--
>   net/smc/smc_ism.h             |  30 +++-
>   net/smc/smc_pnet.c            |   4 +-
>   16 files changed, 445 insertions(+), 290 deletions(-)
> 
