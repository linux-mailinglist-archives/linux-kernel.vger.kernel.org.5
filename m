Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B357544D7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGNWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGNWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:11:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756222119;
        Fri, 14 Jul 2023 15:11:25 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EMAvVo012480;
        Fri, 14 Jul 2023 22:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=SQtXSWqZKG/jgTIl3JTvr+1VdFnyCE0/YsCTU8vPORQ=;
 b=oHYen5KDsTfPD0FX7E1DZUaHB/ow2N97tEo2egapVeLDkRdJ7Kb9bjhjzDPW8cae1BIm
 k2Dzc8EdqDdcpRbkNsTX+fptDkuhFC750SqtiHxakrft3vgaI5coSr7k2BqyZMEW2wgH
 ky7h3phG+uiFKcOppPrIrvEVF0CSZmGZ5biQkdJMtWViJ4ZnNHqEOxJSlJ7nMFUxa4Yd
 cXcmAwT6wm4iWsqCUosQngHFr3xvjPe8lQpOjwwK0yFCCI2IpXuZqtUvqSH3G3UVhjBb
 tX8u8xieC9gAfuoWOuIQi/EhvH2WoybkpjC+meFQxEwP8ANPHM6QgM0ox5PD4ASQ+QpR cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rue4wh0qa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 22:11:15 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36EM1022007496;
        Fri, 14 Jul 2023 22:11:14 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rue4wh0pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 22:11:14 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36EKJumu002964;
        Fri, 14 Jul 2023 22:11:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rtqjknn1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 22:11:13 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EMBDgL13369916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 22:11:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06D2F5805C;
        Fri, 14 Jul 2023 22:11:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885835805A;
        Fri, 14 Jul 2023 22:11:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.79.213])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 22:11:12 +0000 (GMT)
Message-ID: <d622f47e5446f71571170ef72be43ea0a89e5d48.camel@linux.ibm.com>
Subject: Re: [PATCH] certs: Reference revocation list for all keyrings
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        jarkko@kernel.org, dwmw2@infradead.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com
Date:   Fri, 14 Jul 2023 18:11:12 -0400
In-Reply-To: <20230117171506.3888602-1-eric.snowberg@oracle.com>
References: <20230117171506.3888602-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oGJZk1B8EOumB9thbJUq1cHoQm5DppP8
X-Proofpoint-ORIG-GUID: HtactTUtKfJ0xnOJm69Hdb5fIYasUXa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140202
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-17 at 12:15 -0500, Eric Snowberg wrote:
> Systems booted with shim have a Forbidden Signature Database called mokx.
> During boot, hashes and certs contained within the mokx are loaded into the
> blacklist keyring.  When calling verify_pkcs7_message_sig the contents of
> the blacklist keyring (or revocation list) are referenced when validating
> keys on the platform keyring. Currently, when validating against the
> secondary or builtin keyrings, the revocation list is not referenced.  Move
> up the check to allow the revocation list to be used with all keyrings,
> including the secondary and builtin, allowing the system owner to take
> corrective action should a vulnerability be found within keys contained
> within either keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

