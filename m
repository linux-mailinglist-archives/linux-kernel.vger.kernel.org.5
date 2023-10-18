Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA37CDD64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbjJRNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjJRNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CAF83;
        Wed, 18 Oct 2023 06:34:51 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IDRIM0018290;
        Wed, 18 Oct 2023 13:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=v1hbk3o2iW6VZiZOHYqCLqw6rsfgHH1WHNcVMCZL7Lg=;
 b=XeXNKEoKxeYKo8OdNhS43HFY3CCEhYxdwTmIz5j30pKOMW/PAy4nx6/csUz8wyzoN3cg
 rWltPMe/bcP8sA5vJxW28e5Rma9TebUemKq5m0/N2twAv5ViftB5VeEUMhfB+jb6sHK0
 qEuk5CIRyi1EVg15yjKSpp58tnTQUMupAZYQxpdrl+8saeCLtQHc1HSpm4nE5Sps78fA
 NljvmmvKL768yFKojXEIrbNi+S/Kt0a3k7oIByQmopYtEc0v2ByddFzhULT+oohBEzuk
 3UxlNwV/8PPGmfD2VXrodVGm4AYyfpaWgzueFhr1NjzzKI+lPhhUuvjlkmFSht0U+TO2 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttg8v8cr9-79
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:34:29 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ID7P4x016033;
        Wed, 18 Oct 2023 13:10:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ttfydr61x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:10:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39ICpYgH020101;
        Wed, 18 Oct 2023 13:09:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr6an8hx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 13:09:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39ID9CL450200984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:09:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 217BA58063;
        Wed, 18 Oct 2023 13:09:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A7235805A;
        Wed, 18 Oct 2023 13:09:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.77.189])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 18 Oct 2023 13:09:11 +0000 (GMT)
Message-ID: <c896c8ed559d0075146070be232e449b6951eb99.camel@linux.ibm.com>
Subject: Re: [PATCH v15 00/11] LSM: Three basic syscalls
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        linux-integrity@vger.kernel.org
Date:   Wed, 18 Oct 2023 09:09:10 -0400
In-Reply-To: <2637d5294d4a7ae871f1b758f5a30234836e2463.camel@huaweicloud.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vfsivn6sAVLBujdoYS7Plieh6W-ICf3d
X-Proofpoint-ORIG-GUID: vzSDU5G1JRFXs3FNhIyRJAQRNlXG6h78
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 11:31 +0200, Roberto Sassu wrote:
> On Tue, 2023-10-17 at 18:07 +0200, Roberto Sassu wrote:
> > On Tue, 2023-10-17 at 11:58 -0400, Paul Moore wrote:
> > > On Tue, Oct 17, 2023 at 3:01 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Mon, 2023-10-16 at 11:06 -0400, Paul Moore wrote:
> > > > > On Mon, Oct 16, 2023 at 8:05 AM Roberto Sassu
> > > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > > 
> > > > > > Sorry, I just noticed LSM_ID_IMA. Since we have the 'integrity' LSM, I
> > > > > > think it should be LSM_ID_INTEGRITY.
> > > > > > 
> > > > > > Mimi, all, do you agree? If yes, I send a patch shortly.
> > > > > 
> > > > > I believe LSM_ID_IMA is the better option, despite "integrity" already
> > > > > being present in Kconfig and possibly other areas.  "IMA" is a
> > > > > specific thing/LSM whereas "integrity" is a property, principle, or
> > > > > quality.  Especially as we move forward with promoting IMA as a full
> > > > > and proper LSM, we should work towards referring to it as "IMA" and
> > > > > not "integrity".
> > > > > 
> > > > > If anything we should be working to support "IMA" in places where we
> > > > > currently have "integrity" so that we can eventually deprecate
> > > > > "integrity".
> > > > 
> > > > Hi Paul
> > > > 
> > > > I fully understand your argument. However, 'integrity' has been the
> > > > word to identify the integrity subsystem since long time ago.
> > > > 
> > > > Reducing the scope to 'ima' would create some confusion since, while
> > > > 'ima' is associated to integrity, it would not encompass EVM.
> > > 
> > > Using LSM_ID_IMA to reference the combination of IMA+EVM makes much
> > > more sense to me than using LSM_ID_INTEGRITY, especially as we move
> > > towards promoting IMA+EVM and adopting LSM hooks for integrity
> > > verification, opening the door for other integrity focused LSMs.
> > 
> > + Mimi, linux-integrity
> > 
> > Ok, just to understand before posting v4, the code looks like this:
> 
> I worked on a new proposal. Let me know what you think. It is available
> here:
> 
> https://github.com/robertosassu/linux/tree/ima-evm-lsms-v4-devel-v6
> 
> 
> I made IMA and EVM as standalone LSMs and removed 'integrity'. They
> maintain the same properties of 'integrity', i.e. they are the last and
> always enabled.
> 
> During initialization, 'ima' and 'evm' call integrity_iintcache_init(),
> so that they can get integrity metadata. I added a check to ensure that
> this function is called only once. I also added the lsmid parameter so
> that the integrity-specific functions are added under the LSM ID of the
> caller.
> 
> I added a new LSM ID for EVM, does not look good that IMA and EVM are
> represented by LSM_ID_IMA.
> 
> Finally, I had to drop the patch to remove the rbtree, because without
> the 'integrity' LSM, space in the security blob cannot be reserved.
> Since integrity metadata is shared, it cannot be reserved by 'ima' or
> 'evm'.
> 
> An intermediate solution would be to keep the 'integrity' LSM just to
> reserve space in the security blob. Or, we remove the rbtree if/when
> IMA and EVM use disjoint integrity metadata.

One of the major benefits for making IMA and EVM LSMs was removing the
rbtree and replacing it with the ability of using i_security.

I agree with Roberto.  All three should be defined: LSM_ID_INTEGRITY,
LSM_ID_IMA, LSM_ID_EVM.

-- 
thanks,

Mimi

