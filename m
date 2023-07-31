Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1A76A184
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGaTqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjGaTqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:46:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224FF1BF1;
        Mon, 31 Jul 2023 12:46:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTSxe017416;
        Mon, 31 Jul 2023 19:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=YofNA/SoSWh/JvhktFoWFUESscDA6zq9IXN98ADTKv0=;
 b=Xc5O6hVeCMYT1cnmP64IQbPnyOGvS9Y9+tuxn4lNyphYAe1s2q+/JdcO5AJFpxq9hcQN
 cCwBYyEkIUGZnWH9sRzHIU4KeDuJX5VIbh+WcGVRvTK6/YgcowXzkd+ktkHCwYFdowTm
 V+JDS0aARES5Nm/dy/AO9qQEwvkvzydWqpiLHNqz5vKPwlJzOreUBIlOkFmFk2iTsRQh
 Ulpj1q88+/H3MDDJetQujTPve3wTLWPwZ4S8nS1E1owRAGwVgZL75cci5GzJXwYPK0Rp
 G+qdq1zXWRBtHZT7+G2mGY3QPtipT+c59Hlna/xfitx8D8GaB5WcjOPwXmXGSUJbnmE2 xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2bf7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:46:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VIAPLs008786;
        Mon, 31 Jul 2023 19:46:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bmugm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 19:46:20 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36VJkKqA011875;
        Mon, 31 Jul 2023 19:46:20 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3s4s7bmug6-1;
        Mon, 31 Jul 2023 19:46:20 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Alexandra Diupina <adiupina@astralinux.ru>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Subject: Re: [PATCH v2] 53c700: add 'slot' check to NULL
Date:   Mon, 31 Jul 2023 15:46:16 -0400
Message-Id: <169083273235.2873926.5042177740872240900.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728123521.18293-1-adiupina@astralinux.ru>
References: <20230728123521.18293-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_13,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=388
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310179
X-Proofpoint-ORIG-GUID: K4y4GqTFkZz2qrG42-LJIGwi5oNxh3oU
X-Proofpoint-GUID: K4y4GqTFkZz2qrG42-LJIGwi5oNxh3oU
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 15:35:21 +0300, Alexandra Diupina wrote:

> Add a 'slot' check for a null value to avoid
> dereferencing the null pointer
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 

Applied to 6.5/scsi-fixes, thanks!

[1/1] 53c700: add 'slot' check to NULL
      https://git.kernel.org/mkp/scsi/c/8366d1f1249a

-- 
Martin K. Petersen	Oracle Linux Engineering
