Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC4762F84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjGZITW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjGZISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:18:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E730E0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:08:27 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q80BdM032335;
        Wed, 26 Jul 2023 08:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=jpw0ZnOOUpjcp/35VH40grYwUq/U2eV9RmVWmFebxKk=;
 b=cKGjpbCzJViq71+U3TzZPFIwuxtui3r3C52/AUJ4zowmwxtW1/h8noXWray4+ZMjlLmn
 J/HrRIkbezapUyhpypFXUeXYOEYCeOrMTNLCW4tiSBaeSJ93a2ubGHPprsvVQF28Ubv1
 SVvSGb/Gs8xIAtt7EWlQm7iocYn9zwJ+Q5yg49y6ab15yF/TP50M2FvJtakQBXg2O5av
 tw9zUuPLSMSny7mMTh1WJO4Tq6+t2AHIxzJHgC4ihtM7z3c+aU8L5xuhmSptcFD5Va/Z
 Nea7A29P3XBn9IYOd/stNVKx29mueCCLIVl5sX/x5gOyMhMqlOcmXd4GhfexpIEDkoAZ IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2ykj0er4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 08:08:16 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36Q80LnB000378;
        Wed, 26 Jul 2023 08:07:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2ykj0d9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 08:07:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6TESP002639;
        Wed, 26 Jul 2023 08:07:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txk30tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 08:07:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36Q87A9L55116046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 08:07:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 287C02004D;
        Wed, 26 Jul 2023 08:07:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E451320040;
        Wed, 26 Jul 2023 08:07:08 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.206.66])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 26 Jul 2023 08:07:08 +0000 (GMT)
Date:   Wed, 26 Jul 2023 13:37:06 +0530
From:   Gautam Menghani <Gautam.Menghani@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unnecessary endian conversion code
 in XICS
Message-ID: <uwmugr3tcx2gwujvit7ve77xtx7n7b4kz4yuo2pwoemx2im7hi@4sqglwnh3c6w>
References: <20230630055628.17790-1-gautam@linux.ibm.com>
 <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39920b0f-f261-8417-af7a-eef791ad5726@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xb-qKmY1UzHAzWLWxMyBJiOGDJ68_AxJ
X-Proofpoint-ORIG-GUID: IsRg_ePtkxyBglHCeqg0QWj7fK7Cj_NX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=921 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 05:50:57PM +1000, Jordan Niethe wrote:
> 
> 
> On 30/6/23 3:56 pm, Gautam Menghani wrote:
> > Remove an unnecessary piece of code that does an endianness conversion but
> > does not use the result. The following warning was reported by Clang's
> > static analyzer:
> > 
> > arch/powerpc/sysdev/xics/ics-opal.c:114:2: warning: Value stored to
> > 'server' is never read [deadcode.DeadStores]
> >          server = be16_to_cpu(oserver);
> > 
> > As the result of endianness conversion is never used, delete the line
> > and fix the warning.
> > 
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> 
> 'server' was used as a parameter to opal_get_xive() in commit 5c7c1e9444d8
> ("powerpc/powernv: Add OPAL ICS backend") when it was introduced. 'server'
> was also used in an error message for the call to opal_get_xive().
> 
> 'server' was always later set by a call to ics_opal_mangle_server() before
> being used.
> 
> Commit bf8e0f891a32 ("powerpc/powernv: Fix endian issues in OPAL ICS
> backend") used a new variable 'oserver' as the parameter to opal_get_xive()
> instead of 'server' for endian correctness. It also removed 'server' from
> the error message for the call to opal_get_xive().
> 
> It was commit bf8e0f891a32 that added the unnecessary conversion and never
> used the result.
> 
> Reviewed-by: Jordan Niethe <jniethe5@gmail.com>
> 

Hello Michael,

Do you have any more questions on this patch or is it good to go?

Thanks,
Gautam
