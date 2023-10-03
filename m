Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371DD7B5F69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbjJCDei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjJCDef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:34:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE77CC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:34:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3932wiln007721;
        Tue, 3 Oct 2023 03:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=C6yKQiz4nC/sow2Nu8LRSZ9+Aktpjp/VSz7aWT+efMg=;
 b=l6Gl72Nx3Xp+SIyl3F7NH2rdwaAw1MguHQYjECeqezUuSndeGO5VO4VVkalGR2Jrk8i1
 AoPMdJW8MyOAcqeo4EpzYzqA6FKQn5+N/YSie/oaR2xXlUebGPIBgTyP1KdY8VF98UZV
 ltelWFgdviVzYyQH1dGdxV/Alq+SWRHi5GBPnCkc7VuSFCNE0Yd55CpZiOkOhXKaIdZx
 8VkNbypqTyfC4DS81yIcevsuFZtvfyPaB2gC9Vt3tYOYNkhT4tVdPh6lJd2cJglVtzeM
 a5IMRgQ4clDIDyL58hwQPLUHrwAxvbpExuBArB/0/f/cufu/HghCwrOGFOiZIkWrmghb 0g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tg9hdr553-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 03:34:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3933YPbN010874
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 03:34:25 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 2 Oct 2023 20:34:23 -0700
Date:   Tue, 3 Oct 2023 09:04:20 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_tingweiz@quicinc.com>
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in
 device_links_purge()
Message-ID: <ebc07a1b-dbf6-40d9-8f62-03d58e4b3038@quicinc.com>
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
 <CAGETcx_+62Rt4fh0jM6stO2_eGPjtxaxVC=KxAei5XfBLq3_Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAGETcx_+62Rt4fh0jM6stO2_eGPjtxaxVC=KxAei5XfBLq3_Zw@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TzMr4kreoICFfCrrnr5dZ9zauLn6tvb5
X-Proofpoint-GUID: TzMr4kreoICFfCrrnr5dZ9zauLn6tvb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-02_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=911 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310030027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:40:52PM -0700, Saravana Kannan wrote:
> 
> > It usuallly happens in the case of a glue driver. Of_platform_populate()
> > allows us to populate subnodes. We may do it in ancestor node probing
> > function, then check subnode's probing status because there may be chances
> > that suppliers of subnode are not ready. We may further need to do
> > of_platform_depopulate(which purges device links) and in some time
> > of_platform_populate() again. Such case we miss fwnode links(so that device
> > links) during second time of populating subnodes.
> 
> Why is the device driver for the parent device adding the child
> devices before it knows it can finish probing? Adding the child
> devices should be the last thing you do as part of your probe.
> 

Is there a way how a parent device driver can know if the dependencies
of its child are met before registering the device?

Does it make sense to treat the child dependencies as parent (if it
opts) dependencies in the firmware device links? Not every child may be needed
for the parent to operate but some devices which are glue devices (SoC
specific) for children (say 3rd party IP or generic devices) would
definitely want to know if their children are ready for probe.

Thanks,
Pavan
