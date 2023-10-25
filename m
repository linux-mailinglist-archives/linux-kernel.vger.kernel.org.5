Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377D87D5FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjJYCUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJYCUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:20:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFD10D9;
        Tue, 24 Oct 2023 19:20:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUSx2031886;
        Wed, 25 Oct 2023 02:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=YQ1S0iXNbZho4Wpqsy+xl5MCTVmj2GQuRVt2I4LvY2I=;
 b=CM4z//iVjb/nQj9EHz2+TLShAjG3wVm5NL2RRo6+PDOkh/o91VnmWFt91nPPhHrhmqyh
 omM1c0oiCiZhLakN9DUXP9Ruvs01awGX18aE4LyB9b9c8SFuXDlSylgur97zcxKG+L36
 My2RWv1Sm8Pi/KjtvPieg0tgeTMwIuGJ9RHvR+QWRWavtPPKchopAjgBpxN2RBvHF77H
 1p8w8ep2SYTB2Q3p/UMxkux3QGOqn7Z011xP7wQE32ttTA3tYrJm+zsXA6WsbgU83ZX7
 mIZyQMYh5mDjLCkYgowbdqwJ5qJoPwdpMOZU+ZmesAH1wYX1RLhkSjbh5aXKjnLZptQA 4A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pcxrhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:19:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P0ixvb015230;
        Wed, 25 Oct 2023 02:19:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53621b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:19:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39P2JpFM000926;
        Wed, 25 Oct 2023 02:19:55 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3tv5362196-3;
        Wed, 25 Oct 2023 02:19:55 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, Manivannan Sadhasivam <mani@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com
Subject: Re: (subset) [PATCH v7 0/5] UFS: Add OPP support
Date:   Tue, 24 Oct 2023 22:19:45 -0400
Message-Id: <169819964289.2667926.6896160165282471325.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250018
X-Proofpoint-GUID: cA960LhyGdWnnRpD8iOOlsOXGJszXekX
X-Proofpoint-ORIG-GUID: cA960LhyGdWnnRpD8iOOlsOXGJszXekX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 22:51:24 +0530, Manivannan Sadhasivam wrote:

> This series adds OPP (Operating Points) support to UFSHCD driver.
> 
> Motivation behind adding OPP support is to scale both clocks as well as
> regulators/performance state dynamically. Currently, UFSHCD just scales
> clock frequency during runtime with the help of "freq-table-hz" property
> defined in devicetree. With the addition of OPP tables in devicetree (as
> done for Qcom SDM845 and SM8250 SoCs in this series) UFSHCD can now scale
> both clocks and performance state of power domain which helps in power
> saving.
> 
> [...]

Applied to 6.7/scsi-queue, thanks!

[1/5] dt-bindings: ufs: common: add OPP table
      https://git.kernel.org/mkp/scsi/c/e820de1d115f
[2/5] scsi: ufs: core: Add OPP support for scaling clocks and regulators
      https://git.kernel.org/mkp/scsi/c/930bd77ebe3d
[3/5] scsi: ufs: host: Add support for parsing OPP
      https://git.kernel.org/mkp/scsi/c/72208ebe181e

-- 
Martin K. Petersen	Oracle Linux Engineering
