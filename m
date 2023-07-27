Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48687765A84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjG0RhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjG0RhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:37:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB41B5;
        Thu, 27 Jul 2023 10:37:10 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RHKu8l006291;
        Thu, 27 Jul 2023 17:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/fUHauk0oWCtsaoIjKHWvmxdaWr3Sa/QvzSOgw/2Mr0=;
 b=YZA6bS93j9vDoHPPGkY0VWg7QD0LvkdJVmhbNGNsFvgY8xlJ09cGIWoDEtVpp4heNHck
 EBoH9M/juy0PFuPDhthWjceGkeyMUQnnsy4odL7GSbouA2FhEDIdhE93WsizQWa7xHJU
 PN1e42+6XDtetoHBE4Dg8TAGNaMP+fCIOcCIMJni7lhQH9FfQWZWkaA5lHZr82u+XSft
 UmhG0WkVQs/tq2LmTHuFCBqu7QXqpxsFqQiFWpLQgjDTRhCOV/d54CZqXljlHZWVmkUt
 Fmo4uozgwQRbjJ/LWRmoNpGcJRGkJjklPGg0kKFPaHOwKqRm1gQO5aDKVPhTlQhgYx8L lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3vwd8e0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:36:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RHL4DN006829;
        Thu, 27 Jul 2023 17:36:47 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3vwd8dyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:36:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGp950026217;
        Thu, 27 Jul 2023 17:36:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0sesfv5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:36:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36RHajKd35979560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 17:36:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3116B5805F;
        Thu, 27 Jul 2023 17:36:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 177465805C;
        Thu, 27 Jul 2023 17:36:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.89])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jul 2023 17:36:43 +0000 (GMT)
Message-ID: <860501de903bba660adcdad3e3ccf750dc29b432.camel@linux.ibm.com>
Subject: Re: [PATCH v4] integrity: Always reference the blacklist keyring
 with appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 27 Jul 2023 13:36:43 -0400
In-Reply-To: <20230726211725.393056-1-eric.snowberg@oracle.com>
References: <20230726211725.393056-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7RhVSh3MrpZtub_IJJP3Rd74u1rCFMHB
X-Proofpoint-GUID: rBDy_T_PLQIu3N96Y_IGm_1xz3tDi3Ww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-26 at 17:17 -0400, Eric Snowberg wrote:
> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
> modsig") introduced an appraise_flag option for referencing the blacklist
> keyring.  Any matching binary found on this keyring fails signature
> validation. This flag only works with module appended signatures.
> 
> An important part of a PKI infrastructure is to have the ability to do
> revocation at a later time should a vulnerability be found.  Expand the
> revocation flag usage to all appraisal functions. The flag is now
> enabled by default. Setting the flag with an IMA policy has been
> deprecated. Without a revocation capability like this in place, only
> authenticity can be maintained. With this change, integrity can now be
> achieved with digital signature based IMA appraisal.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v4 changes:
>   Fixed typo
>   Also did some performance testing with this patch. With the associative array
>   implementation used within the keyring code, there doesn't seem to be much of a
>   difference between doing  an appraisal with an empty blacklist keyring and one
>   containing 1500 entries.  At this time it is unknown how many entries a user
>   would place in this keyring, but this seemed like a bigger number than most use
>   cases.  With the 1500 entries, there were only 7 lookups to get through the
>   entire list for a file not contained within it.  For something that was
>   on the list, there was an average of 4 lookups and a single string compare.
>   Based on this testing, IMHO, there could be a lot more entries added to the
>   blacklist keyring without any real performance issues.

Thank you for the blacklist performance testing.   The patch is now
queued in next-integrity-testing.

--
thanks,

Mimib

