Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FB7F87F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjKYCzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjKYCyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:54:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F9E1FF6;
        Fri, 24 Nov 2023 18:54:49 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1b0EV028524;
        Sat, 25 Nov 2023 02:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=t2XmwvFjukFwuTz/SUSXk2rks2dH+lU6ckR4eeevBEM=;
 b=F4Zp5Mbmz1spMonx1UsuxNkjC5caMxpgppgjzG7Sf91Ghr0hyrLjXU71ShgK4lTxi/LS
 LWiOxy0n7utxzT//2SjH7K8gPOpEW3dentnw1NOkLh8dB02H4GEmabU63WTgLNNdUh9j
 caoEnkkEbkNXDFfS7DtewrctcypNapffgLet1+WEqMJXQXIMRprXUKkzQz5npGYKRpN7
 T6+fCHg/Ktlzihzo6svcJctAa0IIM7/ajVvZzB72zdyOb+LdmAtItYi1k60LTXatYZyJ
 piJDfWof7afdTOhQwGyPdpNXUvwBWTnsqhAudiUIfsTKsWtMjyL2pxmEP2LA4A4uby57 Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bkxgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AP1Xo5k027021;
        Sat, 25 Nov 2023 02:54:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c99f6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Nov 2023 02:54:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AP2sRT3011828;
        Sat, 25 Nov 2023 02:54:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uk7c99f5h-8;
        Sat, 25 Nov 2023 02:54:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, Can Guo <quic_cang@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Lu Hongfei <luhongfei@vivo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] scsi: ufs: ufs-sysfs: Expose UFS power info
Date:   Fri, 24 Nov 2023 21:54:20 -0500
Message-ID: <170087016633.1036733.5693164654454165304.b4-ty@oracle.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
References: <1698890324-7374-1-git-send-email-quic_cang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_01,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=675 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311250020
X-Proofpoint-GUID: Ldr8gfnmatpIUNHuunYSXil8Ml5AwVDc
X-Proofpoint-ORIG-GUID: Ldr8gfnmatpIUNHuunYSXil8Ml5AwVDc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2023 18:58:36 -0700, Can Guo wrote:

> Having UFS power info available in sysfs makes it easier to tell the state
> of the link during runtime considering we have a bunch of power saving
> features and various combinations for backward compatibility.
> 
> 

Applied to 6.8/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-sysfs: Expose UFS power info
      https://git.kernel.org/mkp/scsi/c/4f6dd2a4bf37

-- 
Martin K. Petersen	Oracle Linux Engineering
