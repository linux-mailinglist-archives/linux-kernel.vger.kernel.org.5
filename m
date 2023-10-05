Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FAD7BA747
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjJERGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjJERFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:05:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5223AB3;
        Thu,  5 Oct 2023 09:51:58 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395GoQXH009724;
        Thu, 5 Oct 2023 16:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=BSDOGUc+JL9tA2cDFhfNjolCDslHhA0NmpBlnFKh2vs=;
 b=doMomtAxPLQ9ZicS3gR4V1yDjOwEmPt8s1QXcjtKaQS/RMCUM2GEzlSxhxTyE6OfR6uF
 4GXFi4FqasQNfyDZxDslmnBqnO7Hj50H28EhXDeDsNZ/cEj9HvVrcqSCeNo6VGsPBFzR
 TRpDgztUkbJwyfvV0FHqW6zR8YQG7nqtbfJbExBpmMq5str4XzA91tzRa6KMkYAmfeV8
 Gek2c8LfRqockq6UlM39zUceGG873zTtBtas+1zq83XSrNxKSd3lFbTqbaHNFUsBaeTZ
 rUnGhujRpdTV4+GitL4sA8gDEue8JsL+9ejw9LjCeG7NxQOoowenZZeYfY5epcXgMCGf AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj11082kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:51:36 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 395GoSfC009908;
        Thu, 5 Oct 2023 16:51:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tj11082hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:51:36 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 395GROnB007444;
        Thu, 5 Oct 2023 16:45:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3teygm5y1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 16:45:09 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 395Gj8bs21168402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Oct 2023 16:45:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FF0F58060;
        Thu,  5 Oct 2023 16:45:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E4E35803F;
        Thu,  5 Oct 2023 16:45:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.90.188])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  5 Oct 2023 16:45:07 +0000 (GMT)
Message-ID: <e1570b53b991301ee73be185244ef43487bf5961.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: trusted: Remove redundant static calls usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>, torvalds@linux-foundation.org,
        jarkko@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Thu, 05 Oct 2023 12:45:06 -0400
In-Reply-To: <20231005133306.379718-1-sumit.garg@linaro.org>
References: <20231005133306.379718-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AZfxM2HWduYWXK5tKbH3MW8Ha74FZdKX
X-Proofpoint-ORIG-GUID: 8EcC0hJpp4Xb9w9BWrOx4e9kmUmdazCA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_12,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Summit,

On Thu, 2023-10-05 at 19:03 +0530, Sumit Garg wrote:
> Static calls invocations aren't well supported from module __init and
> __exit functions, especially the static call from cleanup_trusted() led 
> to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.

Split the above paragraph into two sentences.

> However, the usage of static call invocations for trusted_key_init()
> and trusted_key_exit() doesn't adds any value neither from performance
> point and nor there is any security benefit.

   don't add any value from either a performance or security
perspective.

>  Hence switch to use indirect
> function calls instead.
> 
> Note here that although it will fix the current crash reported. But
> ultimately we need fix up static calls infrastructure to either support
> its future usage from module __init and __exit functions or not.

The first line is a sentence fragment.  Please replace the period with
a comma.

   report, ultimately the static call call infrastructure should ...

> 
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Closes: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t

Replace "Closes" with "Link".

> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

-- 
thanks,

Mimi

