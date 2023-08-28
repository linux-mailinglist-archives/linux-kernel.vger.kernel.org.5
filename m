Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B8278B823
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjH1TU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjH1TUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:20:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466E7CC4;
        Mon, 28 Aug 2023 12:20:30 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SIeCKm022470;
        Mon, 28 Aug 2023 19:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=7IyXPlI7RXoFkdzF8bVHd5nZmUhvCyYEa+ig+bycilk=;
 b=jpR2p9n6JwACBW5NzQOwyyC1AvfcE505yic44eI1jxCCLXUDlGgHFwIQR7LA8m5NGfa0
 qlYdmbUeTkiENMnqafuHUz0vNn9+uWC/FL+I9r9vd/TzjvW2Xfp5559K3vAZwPfwTHS2
 hyjH3hb41nMuG58wM/jo51sV2QZhn1NgT+zVMXdLD5jRtPNwoIUEkFzbfFXSnnYPMtBz
 Z+1HjBNk5PHF1QRwmBktsSLfOhY7nuHUXLC1UmEOxMUxIEOLdsWQFe4lF2jM5VMdkpdC
 QOnRttMM6jxYMaKbTOVafBJvnt3CzgmETT/ypjXnU2HpwN9n9ajGsF8acTXVIGxTxKYD VQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss05206n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:20:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SJKOtL004309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 19:20:24 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 12:20:13 -0700
Date:   Mon, 28 Aug 2023 12:20:11 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Trilok Soni <quic_tsoni@quicinc.com>
CC:     Arun Kumar Neelakantam <quic_aneelaka@quicinc.com>,
        Ninad Naik <quic_ninanaik@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <psodagud@quicinc.com>, <quic_ppareek@quicinc.com>,
        <quic_kprasan@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [RFC PATCH 0/1] Add driver to read secondary bootloader (XBL) log
Message-ID: <20230828192011.GD818859@hu-bjorande-lv.qualcomm.com>
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <badd7471-b28f-4948-b6b4-eddb8bf1b0d6@quicinc.com>
 <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0abc0e3b-077c-d7b9-e561-2c2e01d46540@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cZjwhKZ_a6ZNxBdhtoV5Y45Y6oUTlyNP
X-Proofpoint-GUID: cZjwhKZ_a6ZNxBdhtoV5Y45Y6oUTlyNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_16,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 11:44:08AM -0700, Trilok Soni wrote:
> On 8/28/2023 10:19 AM, Arun Kumar Neelakantam wrote:
> > 
> > 
> > On 8/22/2023 5:45 PM, Ninad Naik wrote:
> >> Boot time logs for Qualcomm secondary boot-loader or XBL can help to
> >> identify different set of information regarding firmware configuration,
> >> SoC boot KPIs. A dedicated region is carved out in the memory map in order
> >> to store this log in the memory.
> >>
> >> The objective of this driver is to read the XBL boot log stored in
> >> this memory region post boot-up, and provide an entry in debugfs, which
> >> can be used to read back the logs and print them on to the console.
> >>
> > 
> > I see couple of use cases for this kind of logging like logs from
> > boot, Hypervisor, Trusted Execution environments and also one in
> > upstream for chromeos EC console. Can this be made a generic driver
> > which take log name, log memory buffer address and size to read from
> > debugfs.
> 
> The one downside of generic solution here is that log format may not
> be consistent. Some may have binary format of logs which will need
> further parsing in kernel or userspace. 
> 
> If we need to make such feature generic then it needs to be generic
> across arm64 / arm32 then and not SOC specific. 
> 

More importantly, it should provide a consistent interface towards the
consumer of the data, so that one wouldn't need a custom app to collect
every type of data.

Regards,
Bjorn
