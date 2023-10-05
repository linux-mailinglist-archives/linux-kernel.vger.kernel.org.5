Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBDF7BA3F5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjJEQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjJEQBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:01:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360743C03
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:51:33 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395AaqFo031880;
        Thu, 5 Oct 2023 10:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=u9pnp+ZY/KgTHh20p8opH0SSQL8nx37bWqmpGi43Vl4=;
 b=eiIHUyLwOmH849o2EgJDemhFTjoQR77LpYUEMvY+0zODgQ3ZqH1IDfA4e2/mo7nKdBtH
 GK7yC5UbIXTYChqPjiU7Hrrc3P10o1YKVl7RZECskSQtjsH3CSKsg1U/+Mp4l2kRm1fO
 kO755DPsXzSf7TRBy/Q9wCDelQ+Ld57/oIZBq/t5rlI9ONaHa+wSsfASa9i9027umZS7
 tr6wI17ijysW0rDM7188j5xoOC6pC9vTx5/0uLtFBTgTkPa1TlWd4DOJFBTUmwn9DIpm
 tS1cWusSL87A8C08oz4hRcb4LmUsqyz0DQ3sUYKlx9L+d4ym1b42omqHfC5RfPNk4zbr tQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thn058puq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 10:49:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395AnnNT018849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 10:49:49 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 03:49:47 -0700
Date:   Thu, 5 Oct 2023 16:19:44 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <saravanak@google.com>
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in
 device_links_purge()
Message-ID: <50508cf9-fd4f-4199-9df3-e42ebb489499@quicinc.com>
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
 <2023100501-entourage-bounce-3364@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023100501-entourage-bounce-3364@gregkh>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RUN43ddnq3qfOwBT9bT7pFoYL4MvnC1i
X-Proofpoint-GUID: RUN43ddnq3qfOwBT9bT7pFoYL4MvnC1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:32:22AM +0200, Greg KH wrote:
> On Wed, Sep 27, 2023 at 10:30:10AM +0800, Zhenhua Huang wrote:
> > Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
> > only adds it once after fwnode links creation in fw_devlink_parse_fwnode().
> > After that even device links being purged, the flag will not be cleared.
> > 
> > Fwnode links are converted to device links and will not be added back
> > forever in normal case. Essentially if a device is registered and
> > unregisted (also deleted) before it is probed (due to missing fwlink
> > dependencies, abort in device_links_check_suppliers), the fwlink is not
> > setup next when device is newly created again. This means the probe gets
> > called without meeting all dependencies.
> > 
> > It usuallly happens in the case of a glue driver.
> 
> What exact glue driver is causing this to happen?  Why can't we fix that
> up instead?
> 

Yes, we are looking at fixing the glue driver and/or the probe order of drivers
involed by controlling modules load order. To answer your question,

It is observed with dwc3-qcom on a downstream kernel based on
Android GKI 6.1 kernel.

usb_1: usb@a6f8800 {
	...
	usb_1_dwc3: usb@a600000 {
		compatible = "snps,dwc3";
		iommus = <&apps_smmu 0x40 0x0>;
		...
	};
};

The parent device has no dependency on IOMMU but the child has
dependency. The parent probe gets called before IOMMU is probed.
The parent glue driver adds the child device and removes it since its
probe is not completed. Once the child is unregistered, all the fwlinks
are lost. Next time when the child is added, its probe gets called
before IOMMU is ready (since the fwlinks are lost). 

Thanks,
Pavan
