Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E796D76DB1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjHBW7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjHBW7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:59:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D58930F3;
        Wed,  2 Aug 2023 15:59:26 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MgVIl014857;
        Wed, 2 Aug 2023 22:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GpAGXLlF4MFiIeIlOeRB3FOTgQoo/nj/0JBNKef5ICc=;
 b=ARK92OU5wOn/CBW5EfcY7SV2jBk8DWb16hu+hOLdO7FpaRG6DBacp0T4Pgf18trYSshu
 tycnQe4vf75vpUgLquNIrwYxyQ4yI0c4VJFAopBDEkg5wQ17JPKNfVB3JyYnWZRGuy6b
 mBcBi8ov/Z/IbFgc9+VKeD8mhMW+Fv+F9G1+Gu6hpCX1hws+LMIwkFMnxHu4b/2mzEIV
 RLrOg9bsUKd6pfV90L7zhpvURgVAPx5oYjDk6Mle2NntudD0vNk9oAt8ZNV78L69mRHH
 wLNlj/ML76Xp5dmomLcftFcHTUoIjHIT6/hpi1D62YyjCxUrsNWKbH/OIhPhJCSR/6p4 hw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s7yysgbf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:59:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 372MAkVN014533;
        Wed, 2 Aug 2023 22:59:18 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s5ft1qvta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 22:59:18 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 372MxHci66060792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Aug 2023 22:59:17 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3AA458054;
        Wed,  2 Aug 2023 22:59:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A331558050;
        Wed,  2 Aug 2023 22:59:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.115.23])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Aug 2023 22:59:16 +0000 (GMT)
Message-ID: <b3a604758ef1bc18efb6a7750b4362a23cb9adf2.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] integrity: PowerVM machine keyring enablement.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 18:59:11 -0400
In-Reply-To: <20230714153435.28155-6-nayna@linux.ibm.com>
References: <20230714153435.28155-1-nayna@linux.ibm.com>
         <20230714153435.28155-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jwv7mcVB6RPCzbrgVEN_2_WremGD4Tt-
X-Proofpoint-GUID: jwv7mcVB6RPCzbrgVEN_2_WremGD4Tt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=691 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020199
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 11:34 -0400, Nayna Jain wrote:
> Update Kconfig to enable machine keyring and limit to CA certificates
> on PowerVM.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>

