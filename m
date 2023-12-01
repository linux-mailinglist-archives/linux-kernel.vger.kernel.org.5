Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F88801150
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378258AbjLAQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjLAQct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:32:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E912A;
        Fri,  1 Dec 2023 08:32:55 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1GOLeo016348;
        Fri, 1 Dec 2023 16:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5M7Oz9FzCbW5fvOTLVZ5n7LZUTsSWnNgqyueKE9l+QU=;
 b=MfcDVb7XcvA5ihwy+TolKbw91X+U37rGKph393fwxTcWG36/5xfQOgO58n2wWzCWNAcI
 +K2guh2Uh2lLbCFwGelvx8k4olYw2ojF8SticB3WQMCPy/su08QJTxiUeWaLjp1AhDwY
 NUO+vRqoRh4xiwwxWrGeMB38zqk94eu+wZDqpXVs5ZRjfBOGh5VfHy++54byuiJb2IKG
 g7nKGw5TrZZzefFafwdn364C7h1rifC+ECGSe4hH8bsMLsRJvN/DcEkyvr1stnUz8Bas
 kHo2wUdnxjHsDi2y16Vl454MD9lUhmZ4Kx9SA4leQkyeaWwK6379suNNddyqh4v/3tSr tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqjrb8g7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:32:51 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1GPhYj021690;
        Fri, 1 Dec 2023 16:32:49 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqjrb8fs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:32:49 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1DjaUU006257;
        Fri, 1 Dec 2023 16:32:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfkntg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Dec 2023 16:32:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1GWGOh23397048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Dec 2023 16:32:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99A6F2004D;
        Fri,  1 Dec 2023 16:32:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7740720043;
        Fri,  1 Dec 2023 16:32:15 +0000 (GMT)
Received: from [9.179.28.5] (unknown [9.179.28.5])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  1 Dec 2023 16:32:15 +0000 (GMT)
Message-ID: <c1a7b672-4a43-4494-acd1-500026566f69@linux.ibm.com>
Date:   Fri, 1 Dec 2023 17:32:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/7] net/smc: implement SMCv2.1 virtual ISM
 device support
Content-Language: en-US
To:     Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O4Zxo2EGs2le1cBsLLdYnHE-0Nnt38hg
X-Proofpoint-ORIG-GUID: r3w8RpXk-nuSdUnFPEnlOrVU5xgU4fXQ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_15,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 12:28, Wen Gu wrote:
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
> 
> v3->v2:
> - Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
> - Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
> - Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
> - Remove smc_ism_set_v2_capable() helper for now, and introduce it in
>   later loopback-ism implementation;
> 
> v2->v1:
> - Fix sparse complaint;
> - Rebase to the latest net-next;
> 
> Wen Gu (7):
>   net/smc: Rename some variable 'fce' to 'fce_v2x' for clarity
>   net/smc: support SMCv2.x supplemental features negotiation
>   net/smc: introduce virtual ISM device support feature
>   net/smc: define a reserved CHID range for virtual ISM devices
>   net/smc: compatible with 128-bits extend GID of virtual ISM device
>   net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>   net/smc: manage system EID in SMC stack instead of ISM driver
> 

Wen Gu,
as you can see in [1] your patches 5/7 and 1/7 still have formatting issues. 
In this case they need to pass

scripts/checkpatch.pl --strict --max-line-length=80

(see linux/Documentation/process/coding-style.rst)

[1] https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=&state=&q=net%2Fsmc&archive=&delegate=
