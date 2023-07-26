Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63225762822
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjGZBYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGZBYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:24:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494226A2;
        Tue, 25 Jul 2023 18:24:39 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0GclZ003334;
        Wed, 26 Jul 2023 01:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=BoHM+y3BhJJPHDvvRZLtRRY8v1u517l8UV27xLIM/Yw=;
 b=AM23OHlkF/jXpMPGP24RNQBbePYsOtMHrpU7ZI8P4MBDFCVNlknVrM9nPHRDZ1OFtwgW
 dz5gFtUBN+1eqVbGttQ3tW1cao0Uyows2pXIAp1n0bB/r6v+a7e1aBXVIwTX9RRVgdje
 OIpwDAyv+ZjhTwMTECaEIW9g5sAWv5smAUJBnr6M1waxaR/R5tBSaiQMsspPS1Rq9QXM
 Eeb4EZ5rMQkkAs9R9UVUzWoR1x2DzQHXfdMRE48wTTBtbV6vPNC0EIHPnpIvJIrHi0jT
 7ZjSXuE+U6oGD1Z0+b85h3Oiirbdzr8iqHQQZbhEZ9NhaQmLuGu2/uCJqrzKEFxxGAD1 pw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2mxrgj1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 01:24:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q1OVAw023134
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 01:24:31 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 18:24:31 -0700
Date:   Tue, 25 Jul 2023 18:24:30 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <djakov@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_okukatla@quicinc.com>,
        <quic_viveka@quicinc.com>
Subject: Re: [PATCH 2/3] interconnect: Reintroduce icc_get()
Message-ID: <20230726012430.GA7072@hu-mdtipton-lv.qualcomm.com>
References: <20230725012859.18474-1-quic_mdtipton@quicinc.com>
 <20230725012859.18474-3-quic_mdtipton@quicinc.com>
 <c68630ee-9f94-40ec-adb1-a899dc22ca1b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c68630ee-9f94-40ec-adb1-a899dc22ca1b@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RWTAKaJ3Soo5rm7A5IqgICgn8Ex1L-QJ
X-Proofpoint-ORIG-GUID: RWTAKaJ3Soo5rm7A5IqgICgn8Ex1L-QJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=664 mlxscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:18:58AM +0530, Pavan Kondeti wrote:
> On Mon, Jul 24, 2023 at 06:28:58PM -0700, Mike Tipton wrote:
> > The original icc_get() that took integer node IDs was removed due to
> > lack of users. Reintroduce a new version that takes string node names,
> > which is needed for the debugfs client.
> > 

[..]

> 
> Is this API meant to be public()? As you pointed out, it was removed
> recently as there were no users. Since debugfs client is part of ICC
> frarmwork, should it be made private?

With debugfs as the only user, it could technically be made private.
Generally speaking, people should use of_icc_get() instead of this. We
have some other downstream users of icc_get(), but we'll likely push
them to switch to of_icc_get() instead. There are some potential future
use cases that would require exporting this, but none immediate.

