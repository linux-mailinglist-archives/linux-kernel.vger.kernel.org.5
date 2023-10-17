Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40FC7CC5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjJQOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344055AbjJQOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:15:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75B5FA;
        Tue, 17 Oct 2023 07:15:35 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HECtqg021776;
        Tue, 17 Oct 2023 14:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ACi5eTARhKvQqEEvAFgNcoSlkqmFPO0yXbmr3r1fRE8=;
 b=BuhHU8zODY0fN5SbWxOQDDcAI672+9JEAF5zkuT8/mLZs+6SNkgXdiH1wfo8TQEmr5pt
 YavOjp/qqm2vAon2pF+c+Z2Ii7fVqxZGwMsjzp/JdQ22nJpOlsifa+RPMtc3vY4XhG2X
 +mwO8AZQCDBEDT492Nmrjm/Cwn21p94xTm04k0bPoDGi4tALw9JVA40024K4EVQvdQow
 o6nxhT6z7qv58AyIgcJAgRnZRufBEpSzHkoyhys/RLhr2k7A/YHbCPeqWmfPW4az1GTt
 /G6FIhcpWUXSSalX5Ib9W86QV5WxZ+zo0CfD89ap6ZKxG1/8wGHoavdOce5TxNZxCGS4 EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsuu0r426-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:15:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39HEDcHU025064;
        Tue, 17 Oct 2023 14:15:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsuu0r40c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:15:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HC8IbU027154;
        Tue, 17 Oct 2023 14:15:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tk97t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 14:15:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HEFLvK46792964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 14:15:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567922004E;
        Tue, 17 Oct 2023 14:15:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0112520040;
        Tue, 17 Oct 2023 14:15:21 +0000 (GMT)
Received: from [9.155.208.153] (unknown [9.155.208.153])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 14:15:20 +0000 (GMT)
Message-ID: <b152ec7c0e690027da1086b777a3ec512001ba1f.camel@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
From:   Gerd Bayer <gbayer@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>, wenjia@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
        alibuda@linux.alibaba.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
        jaka@linux.ibm.com
Date:   Tue, 17 Oct 2023 16:15:20 +0200
In-Reply-To: <afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org>
References: <d9a2d47d-c8bd-cf17-83e0-d9b82561a594@linux.ibm.com>
         <20231006125847.1517840-1-gbayer@linux.ibm.com>
         <afd142a2-1fa0-46b9-8b2d-7652d41d3ab8@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ygHLqLKxeizfpEdiz0ZOsakjb0xjj2Lq
X-Proofpoint-ORIG-GUID: xrGBjupqLn5GVl5gb-Pha81j7jub6hSG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=856 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 16:09 -0700, Randy Dunlap wrote:
> Hi Gerd,
>=20
> On 10/6/23 05:58, Gerd Bayer wrote:
> > When the SMC protocol is built into the kernel proper while ISM is
> > configured to be built as module, linking the kernel fails due to
> > unresolved dependencies out of net/smc/smc_ism.o to
> > ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> > as reported via the linux-next test automation (see link).
> > This however is a bug introduced a while ago.
> >=20
> > Correct the dependency list in ISM's and SMC's Kconfig to reflect
> > the
> > dependencies that are actually inverted. With this you cannot build
> > a
> > kernel with CONFIG_SMC=3Dy and CONFIG_ISM=3Dm. Either ISM needs to be
> > 'y',
> > too - or a 'n'. That way, SMC can still be configured on non-s390
> > architectures that do not have (nor need) an ISM driver.
> >=20
> > Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client
> > registration")
> >=20
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes:
> > https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae=
@infradead.org/
> > Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> > Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> > Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>=20
> With this patch, ISM can be build without SMC being enabled.
>=20
> This leads to some build warnings:
>=20
> ../drivers/s390/net/ism_drv.c:572:12: warning: 'ism_get_local_gid'
> defined but not used [-Wunused-function]
> =C2=A0 572 | static u64 ism_get_local_gid(struct ism_dev *ism)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~
> ../drivers/s390/net/ism_drv.c:506:12: warning: 'ism_get_chid' defined
> but not used [-Wunused-function]
> =C2=A0 506 | static u16 ism_get_chid(struct ism_dev *ism)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~
> ../drivers/s390/net/ism_drv.c:432:12: warning: 'ism_signal_ieq'
> defined but not used [-Wunused-function]
> =C2=A0 432 | static int ism_signal_ieq(struct ism_dev *ism, u64 rgid, u32
> trigger_irq,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~
> ../drivers/s390/net/ism_drv.c:292:12: warning: 'ism_query_rgid'
> defined but not used [-Wunused-function]
> =C2=A0 292 | static int ism_query_rgid(struct ism_dev *ism, u64 rgid, u32
> vid_valid,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~

Hi Randy,

I must have missed testing a config of ISM without SMC. I'm working on
a fix.

Thanks for reporting,
Gerd

