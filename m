Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63047702E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHDOZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHDOZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:25:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24ECC;
        Fri,  4 Aug 2023 07:25:04 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EFYJW002076;
        Fri, 4 Aug 2023 14:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+u/eLI9gfCUlanLl7aINXPZVZoCJsLmRPU0DfLIfGmc=;
 b=hBkXyiJzURyGiqhfUCRIrwUR/tJ17yvIGb9rGCGqjCW+3It7v0pjj2MEgcumztIf6eaD
 wEwUL/NibpNTjmpcgZvzR2njt+3Sjz78NVkyXJlRrYVkmPdVO6VoScOzqUz/5O7O8xWz
 XAYhwdQrbSbTPn8+/LWfsDQloidA8pgjPcU/ocFxwNZ+vqTn6q1+V6QBMna7MaSmk5cA
 At0bXbkpGhFO78LxnSYdQUzs6z/HqV9oPuswpVy3/jrWAFvMDV2WQH9PQsqOR5TKD02U
 +RhOwCG6Piq+/+A2tOYQaKso2Utv8mXC2tnnOlDp6DtpSEcwuHwvdiHNNJRgl1dVwbQn RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s92xfg9du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 14:25:01 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 374EGiZ7005369;
        Fri, 4 Aug 2023 14:25:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s92xfg9d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 14:25:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374Dvqlm018450;
        Fri, 4 Aug 2023 14:24:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kp4xb18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 14:24:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374EOwp165339764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 14:24:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D19C58051;
        Fri,  4 Aug 2023 14:24:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0270958060;
        Fri,  4 Aug 2023 14:24:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.12.187])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 14:24:57 +0000 (GMT)
Message-ID: <7c288bb1bdc0a7c48ce5bd92c180f95ecbffcef9.camel@linux.ibm.com>
Subject: Re: [PATCH] crypto: lib - Move mpi into lib/crypto
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date:   Fri, 04 Aug 2023 10:24:57 -0400
In-Reply-To: <ZMzD0q52dbeXNeaM@gondor.apana.org.au>
References: <ZMzD0q52dbeXNeaM@gondor.apana.org.au>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q__wxrnP4mi1lbFp874iOakc_EXeKV5F
X-Proofpoint-GUID: WIU3Jjlz9ZZbcpKvUicq7Cb8HkFjAyu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 17:24 +0800, Herbert Xu wrote:
> As lib/mpi is mostly used by crypto code, move it under lib/crypto
> so that patches touching it get directed to the right mailing list.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks, Herbert.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

