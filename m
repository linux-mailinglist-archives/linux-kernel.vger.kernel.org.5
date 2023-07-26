Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC2762A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGZFK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGZFKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:10:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B852D1FD5;
        Tue, 25 Jul 2023 22:10:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q54QPl026955;
        Wed, 26 Jul 2023 05:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=ykITIp4s0lCi1UIGjfiPGkvre4fdRjy5qd4zJo1PJ1c=;
 b=bKqCy6wEnne8Xu3F/Z51Rmv+GB4yOTj+ZHWNmAfGURylVyvwM9gKCD3Sn2kYeX4wbGnO
 cNtxjvrlEbZ8q2g8MQOnk6ZsfTgCvwUy2elk1RZI3j6gvEl7A9ZcF94tPp3EmYM5fpN/
 9af7PfmS0fp2y9mi0AtCrUOuab/G27nhIt6tU8wJ/6SNA1Ls/YS+7BbiZzkayVXLLfuR
 smJ/ZfUkU4cqlIqccwBOrLpNFtTSAK502wahEdZAvcNNQkIM3rZpUFAGaaB9FQt8CSRW
 aroOmoXiWcvp3wSlCyCYO5R3PHcNZmuS/VE4NArDr4XNFnfFflde3/MiWYq1WtdhOxp+ 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2fms1rj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:10:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q5Ajeo010962
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 05:10:45 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 25 Jul 2023 22:10:40 -0700
Date:   Wed, 26 Jul 2023 10:40:36 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Elliot Berman <quic_eberman@quicinc.com>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>
Subject: Re: [RFC PATCH 2/4] power: reset: reboot-mode: Wire reboot_mode enum
 to magic
Message-ID: <e6060e0f-7c1c-4c4f-bbc1-ebafb11cc91f@quicinc.com>
References: <20230724223057.1208122-1-quic_eberman@quicinc.com>
 <20230724223057.1208122-3-quic_eberman@quicinc.com>
 <27d9bd35-b69c-5596-8e1a-c42ec2b01f75@quicinc.com>
 <fa1c8f0d-f949-0e20-5ff3-b98fd4d64ada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa1c8f0d-f949-0e20-5ff3-b98fd4d64ada@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EjL6WBDZzb5QTKF8NxwqVX90bcXTldzQ
X-Proofpoint-ORIG-GUID: EjL6WBDZzb5QTKF8NxwqVX90bcXTldzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:04:28PM -0700, Elliot Berman wrote:
> 
> 
> On 7/25/2023 3:03 AM, Mukesh Ojha wrote:
> > 
> > 
> > On 7/25/2023 4:00 AM, Elliot Berman wrote:
> > > Allow the reboot mode type to be wired to magic.
> > > 
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >   drivers/power/reset/reboot-mode.c | 30 ++++++++++++++++++++++++++----
> > >   1 file changed, 26 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/power/reset/reboot-mode.c
> > > b/drivers/power/reset/reboot-mode.c
> > > index a646aefa041b..4ea97ccbaf51 100644
> > > --- a/drivers/power/reset/reboot-mode.c
> > > +++ b/drivers/power/reset/reboot-mode.c
> > > @@ -22,12 +22,8 @@ struct mode_info {
> > >   static bool get_reboot_mode_magic(struct reboot_mode_driver *reboot,
> > >                         const char *cmd, unsigned int *magic)
> > >   {
> > > -    const char *normal = "normal";
> > >       struct mode_info *info;
> > > -    if (!cmd)
> > > -        cmd = normal;
> > > -
> > >       list_for_each_entry(info, &reboot->head, list) {
> > >           if (!strcmp(info->mode, cmd)) {
> > >               *magic = info->magic;
> > > @@ -45,6 +41,32 @@ static int reboot_mode_notify(struct
> > > notifier_block *this,
> > >       unsigned int magic;
> > >       reboot = container_of(this, struct reboot_mode_driver,
> > > reboot_notifier);
> > > +
> > > +    if (!cmd) {
> > > +        switch (mode) {
> > 
> > IIUC, mode will be filled up with reboot_mode during restart
> > notifier and not reboot notifiers ?
> > 
> 

I went through the patch in isolation and came to the same conclusion on
why you are using mode directly here. Now that it is clarified, why
not use reboot_mode directly instead of introducing restart notifiers
here?

Also you might want to clarify that we are using reboot_mode as fallback
to wire the magic.

Thanks,
Pavan
