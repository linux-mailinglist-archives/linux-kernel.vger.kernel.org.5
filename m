Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF7A76093E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjGYFaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGYFaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:30:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C60E4D;
        Mon, 24 Jul 2023 22:30:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P56GCp012408;
        Tue, 25 Jul 2023 05:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=UA4r+0O9LB/5Hv558gKOBlPsofWoMu9nI7KsSDEWnmw=;
 b=IDU552A+DxoEYWKtb3BB2lXaAbdEbHBpQpr0uMl12BUsLNGbttrz3xmWQUsj4eoK9uPQ
 43UmvKQJ32CC47Vz6ArL+J7akePAb3UPp25Yb2IDieMUkAkIRbNYiT4xEe7WlzhPYKyy
 gR460hxlzy5+H7MRgXc4y50uvc8vTfhSi5y+hkTWkXNPLiV8mRgmxd78FAANEKwPSOCv
 ImQjmYyM/hYWB8jwhTKh5MiGxWHV2Gk0kpmZXGB6El/AhX3FSD+ZzTECKoDzcrsbADX1
 iYwaG4ZQjS8m85DEuPiBuHFv8kCQmuEp4dhfD2xST68fOSg9myFRu4OZvGXAVmvJ3oek Gg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1u3t9kyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:30:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P5UEjT013032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 05:30:14 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 22:30:11 -0700
Date:   Tue, 25 Jul 2023 11:00:07 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
CC:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_viveka@quicinc.com>
Subject: Re: [PATCH 0/3] Add interconnect debugfs client
Message-ID: <b96376a1-4d53-4288-9380-caf9e83817cb@quicinc.com>
References: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R9EHBo9OvUHAH_PEndTIOIKNbDyDS-av
X-Proofpoint-ORIG-GUID: R9EHBo9OvUHAH_PEndTIOIKNbDyDS-av
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_02,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=588 clxscore=1011 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250049
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:28:56PM -0700, Mike Tipton wrote:
> This series introduces interconnect debugfs files that support voting
> for any path the framework supports.
> 
> We've historically relied on an out-of-tree module for this, which used
> the old icc_get() that was recently removed in [0]. The old icc_get()
> took integer endpoint IDs, which made identifying paths in our old
> implementation non-intuitive. The logical node names typically don't
> change much chip-to-chip, but the raw integer IDs do. Take this
> opportunity to introduce an icc_get() that uses string names instead,
> which allows for a more intuitive and generic debugfs interface.
> 
> We rely on this support for debug, test, and verification. Hopefully
> it'll be useful for other vendors as well.

Thanks Mike for working on this series. The downstream driver has been
helpful in quickly pushing NOCs to max during throughput issues
debugging. I have tested this series on v6.4 + revert mentioned here on
SM8550 MTP and it works as advertised.

Thanks,
Pavan
