Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EDC7BA4CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbjJEQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbjJEQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDB7E207;
        Thu,  5 Oct 2023 08:52:27 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395CwDgK012965;
        Thu, 5 Oct 2023 15:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=fE8UxgxFd/+tbRnT90cqvx9+XVdQKge5mU28dzOU2JI=;
 b=itW+cueeVhBvD/SJRYJKKomxKEJu/qcwwCnA5Jy2XqOiePynqlvXBHE2i7qo3hjZJX/H
 Sdnv1Cwdis7zPbsHUyjJKokb/WvBocElaXd+tpXVCBSYcbWoCJonLAirVuPGLp+URnyD
 cZa8joTdEyZHtpvmtYUN8J9zohRICV+wveXBUxCYiC7YqPDi7E6vuC70OnAnsKsrLc1m
 BT2nc1OjBOqsbAOFwQ9H6yLjIV0fXrij0ZAIiCwTZMYCo5KUxdqr5kNVCLdoDOYspfPf
 OOF37c6Lz0dV4hoRLt7N9YRin2fDIUbbbgdborBgQJNwm/XDTJvw1cHaeG1aGl5Egac1 XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thnfa98ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 15:51:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 395Fphso012311
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 15:51:43 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 5 Oct 2023 08:51:31 -0700
Date:   Thu, 5 Oct 2023 21:21:28 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, <corbet@lwn.net>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [REBASE PATCH v5 08/17] arm64: mm: Add dynamic ramoops region
 support through command line
Message-ID: <85d5aea1-71f8-4465-9787-b3289119cac2@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-9-git-send-email-quic_mojha@quicinc.com>
 <20230912101820.GA10884@willie-the-truck>
 <202309131613.C0E12D0D14@keescook>
 <3273977a-be7d-85f6-6754-52a3dd9b784a@quicinc.com>
 <0120ea7e-e9cc-4955-81dd-6801b56068dc@quicinc.com>
 <7c59b835-d29e-04af-7f2f-801da584c71c@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7c59b835-d29e-04af-7f2f-801da584c71c@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9576hdoEh0Sr0KThF3OkDVBMsWRJhQEg
X-Proofpoint-ORIG-GUID: 9576hdoEh0Sr0KThF3OkDVBMsWRJhQEg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_10,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:12:25PM +0530, Mukesh Ojha wrote:
> 
> 
> On 10/5/2023 5:14 PM, Pavan Kondeti wrote:
> > On Thu, Oct 05, 2023 at 04:52:20PM +0530, Mukesh Ojha wrote:
> > > Sorry for the late reply, was on a long vacation.
> > > 
> > > On 9/14/2023 4:47 AM, Kees Cook wrote:
> > > > On Tue, Sep 12, 2023 at 11:18:20AM +0100, Will Deacon wrote:
> > > > > On Mon, Sep 11, 2023 at 04:23:50PM +0530, Mukesh Ojha wrote:
> > > > > > The reserved memory region for ramoops is assumed to be at a fixed
> > > > > > and known location when read from the devicetree. This may not be
> > > > > > required for something like Qualcomm's minidump which is interested
> > > > > > in knowing addresses of ramoops region but it does not put hard
> > > > > > requirement of address being fixed as most of it's SoC does not
> > > > > > support warm reset and does not use pstorefs at all instead it has
> > > > > > firmware way of collecting ramoops region if it gets to know the
> > > > > > address and register it with apss minidump table which is sitting
> > > > > > in shared memory region in DDR and firmware will have access to
> > > > > > these table during reset and collects it on crash of SoC.
> > > > > > 
> > > > > > So, add the support of reserving ramoops region to be dynamically
> > > > > > allocated early during boot if it is request through command line
> > > > > > via 'dyn_ramoops_size=' and fill up reserved resource structure and
> > > > > > export the structure, so that it can be read by ramoops driver.
> > > > > > 
> > > > > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > > > ---
> > > > > >    arch/arm64/mm/init.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > 
> > > > > Why does this need to be in the arch code? There's absolutely nothing
> > > > > arm64-specific here.
> > > > 
> > > > I would agree: this needs to be in ramoops itself, IMO. It should be a
> > > > ramoops module argument, too.
> > > > 
> > > > It being unhelpful for systems that don't have an external consumer is
> > > > certainly true, but I think it would still make more sense for this
> > > > change to live entirely within ramoops. Specifically: you're
> > > > implementing a pstore backend behavioral change. In the same way that
> > > > patch 10 is putting the "output" side of this into pstore/, I'd expect
> > > > the "input" side also in pstore/
> > > 
> > > How do we reserve memory? are you suggesting to use dma api's for
> > > dynamic ramoops ?
> > > 
> > Sharing my thoughts:
> > 
> > Your patch is inspired from how kexec allocate memory for crash kernel
> > right?
> 
> Yes.
> 
> > There is a series [1] which moved arch code (ARM64/x86) to
> > generic kexec core. Something we should also do as the feedback
> > received here.
> > 
> > Coming to how part, we still have to use memblock API to increase the chance
> > of allocating contiguous memory. Since PSTORE_RAM can also be
> > compiled as a module, we probably need another pstore layer that needs to
> > be built statically in kernel to allocate memory using memblock API.
> > once slab is available, all memblock API will re-direct to slab
> > allocations. This layer can be enabled via ARCH_WANTS_PSTORE_xxx or
> > another config that only supports 'y'. PSTORE_RAM can still be a module but
> > when this layer is available, it supports dynamic ramoops. Another option
> > would be just including this layer in PSTORE RAM module but take away module
> > option  when this layer is enabled.
> 
> I thought about this but still the caller will be in Arch code,
> right ? would that be fine with others ?
> 

The caller is not necessarily to be in the arch code. For ex:
mm_core_init()->kfence_alloc_pool_and_metadata()

> > 
> > 
> > [1]
> > https://lore.kernel.org/all/20211020020317.1220-6-thunder.leizhen@huawei.com/
