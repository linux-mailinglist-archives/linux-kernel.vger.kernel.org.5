Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8F7C49AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbjJKGMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjJKGMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:12:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F1E98;
        Tue, 10 Oct 2023 23:12:04 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B2OArT012013;
        Wed, 11 Oct 2023 06:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=+1oHRlUZoyPoBfETmV4XFsDzXDHgXJ6Jn1zytXgTvuw=;
 b=cxe9zXl816mN6YVvIobbx9glEDDEge29jpNk7tbXpz/Z7JKG58wv7Qj6H2nKHKddQVPv
 RXc61IDN5acPoofDou/zaRPRI0yiHKdJfmZisrqWTxzBdypqi6q3p1+0z4Zys6P9gYFH
 Ok07vyMkiyYL+QMPOfjqPbjC+bX5s5NAdTqYcekBu+pPsQF6pGJD6chcmx4O/LtWqQii
 vCW/ELHKZPuLcZ4YM3EZAjRjD/Bolz9Zs8250PwUco9M7+/opRYBc5Q4o6KEXWvWTXv/
 aaQOhcQ0CUjdo/SLpyOFRLYW+fDwL8PgPCbNI+b6sTiWx37lSKWwXJUbLF6G5bLw7qLC ag== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tngtp8hyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 06:12:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B6C1tf005469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 06:12:01 GMT
Received: from hu-jiangenj-sha.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 10 Oct 2023 23:12:00 -0700
Date:   Wed, 11 Oct 2023 11:41:56 +0530
From:   Joey Jiao <quic_jiangenj@quicinc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Message-ID: <20231011061156.GA1625@hu-jiangenj-sha.qualcomm.com>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
 <ZSXR7PJmXZpZxQ2R@bombadil.infradead.org>
 <49a0f7c36d8d41abb1204b0780667fe0@quicinc.com>
 <ZSYGmQhlGKmYXENG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSYGmQhlGKmYXENG@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: m7SY9hF6jmBU9tILS3IrevWYIERGrXEd
X-Proofpoint-GUID: m7SY9hF6jmBU9tILS3IrevWYIERGrXEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_03,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Luis, will recheck these two points.

On Tue, Oct 10, 2023 at 07:21:13PM -0700, Luis Chamberlain wrote:
> Please find a good email client to reply to patches.
> 
> On Wed, Oct 11, 2023 at 01:57:58AM +0000, Joey Jiao (QUIC) wrote:
> > Hi Luis,
> > 
> > > How is ignoring an error ensuring ordering?
> > The change is just to disable the schedule_work.
> 
> That's different and can be made clearer. Try:
> 
> if (!IS_ENABLED(CONFIG_FOO))
> 	schedule_stuff
> 
> > > Why are you making this only now be called with this new kconfig option?
> > This sequence loading is especially helpful for syzkaller coverage decoding.
> > When kaslr is disabled, address inside core kernel is fixed, so syzkaller can always get right function/line number from addr2line.
> > But module address keeps change across rebooting, in first booting, it might be loaded at X1, and at X2 after reboot, and at X3 after another reboot.
> > In this way, syzkaller just can't decode correctly for module address. And syzkaller currently uses PC and branch info for coverage guided things.
> > 
> > There was a discussion previously here https://groups.google.com/g/syzkaller/c/1Pnm_BjrZO8/m/WOyAKx8ZAgAJ for modprobe.
> 
> You are missing my point, you are disabling in effect a piece of code
> where it was not before.
> 
>   Luis
