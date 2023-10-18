Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1988B7CE8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJRUXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:23:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399B9F;
        Wed, 18 Oct 2023 13:23:05 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKMF1K018027;
        Wed, 18 Oct 2023 20:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nvxqqHd/++dDR8770ODWelhQTrliTjrz69MRjRHrnpI=;
 b=PBpA2W7cZlk7DLZk6iB7hE5wSXhH6s2+PhJujUx3c7AdeSHRYdld616jbf7Hm8szdKV8
 IEQDs6+AkCDA9EK0YhdKJrReTKIU6yDoycDrQV7/J13PJuKXLs+flsktPffyf697ciZA
 Uynyfig8mFINOmmxdTJWBWBwsgfF81295YlyvmqScAysONlcXe24oKctiOawMapDysyj
 eZkAWB5V9JbwpXCmdq3VX4whMwxnlM+JKgDrzbAKNxMk91PFRx/4OkNWLfE9cn/rLZO4
 Vfy2Hb59H3SU6oMYshW1HtGc2GxKj06kgsrgw321Y184it4tENVxyJCaADkPyrBq/2tI Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttpbbr002-26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:22:33 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IKG188010972;
        Wed, 18 Oct 2023 20:16:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttp4b0692-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:16:00 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39IJPam2027190;
        Wed, 18 Oct 2023 20:10:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6tkkhue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:10:57 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39IKAuRv19464762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 20:10:56 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5347B58056;
        Wed, 18 Oct 2023 20:10:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 821F358052;
        Wed, 18 Oct 2023 20:10:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 20:10:55 +0000 (GMT)
Message-ID: <80f05011bf9fe19bde1f923e98c2db69ffc91065.camel@linux.ibm.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
Date:   Wed, 18 Oct 2023 16:10:55 -0400
In-Reply-To: <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
References: <20230912205658.3432-1-casey.ref@schaufler-ca.com>
         <20230912205658.3432-1-casey@schaufler-ca.com>
         <CAHC9VhRcbp3iWQwL7FTUrcU1C3OsZ413Nbq+17oTwW7hZ7XvBw@mail.gmail.com>
         <CAHC9VhSqY5+DR-jXprrftb1=CzDvhTh0Ep66A16RMd4L7W7TYw@mail.gmail.com>
         <ae39864947debbc7c460db478b8abe1c147b7d5c.camel@huaweicloud.com>
         <CAHC9VhRQ7xpeSX7b3VZfzQ15noJ8mgauNMuHWo_n3hMgsYMAfQ@mail.gmail.com>
         <468436cf766732a3cfc55d07ad119a6ccdc815c1.camel@huaweicloud.com>
         <CAHC9VhTjHT-DGKu0=cZPVb=+kMwmbPdr8HiVWJq-yzaDiYk_SA@mail.gmail.com>
         <6f33144c850c40e9438a6de2cf3004e223508755.camel@huaweicloud.com>
         <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
         <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
         <283bf52d-af6e-4d20-a5ba-d98511c2e530@huaweicloud.com>
         <CAHC9VhSiUgY1Dzy6LGOjPF6XQ3pVBiZ9LPdcQANNXZ9rj-WURw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xqWxDfmTr2aAlPiB0WY8wigT9rf4wm4g
X-Proofpoint-ORIG-GUID: SvXp6I_greHhLH3T3Fn2kSnoM2k4U9j9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 mlxlogscore=868
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180168
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 12:35 -0400, Paul Moore wrote:
> On Wed, Oct 18, 2023 at 10:15 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On 10/18/2023 3:09 PM, Mimi Zohar wrote:
> 
> ...
> 
> > > I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
> > > LSM_ID_IMA, LSM_ID_EVM.
> >
> > I did not try yet, but the 'integrity' LSM does not need an LSM ID. With
> > the last version adding hooks to 'ima' or 'evm', it should be sufficient
> > to keep DEFINE_LSM(integrity) with the request to store a pointer in the
> > security blob (even the init function can be a dummy function).
> 
> First off, this *really* should have been brought up way, way, *way*
> before now.  This patchset has been discussed for months, and bringing
> up concerns in the eleventh hour is borderline rude.

As everyone knows IMA and EVM are not LSMs at this point.

So the only thing that is "rude" is the way you're responding in this
thread.

> 
> At least we haven't shipped this in a tagged release from Linus yet,
> so there is that.

What does that have to do with anything?!  Code changes.

Mimi

