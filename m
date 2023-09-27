Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16507B0238
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjI0Kwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0Kwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:52:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09FEF3;
        Wed, 27 Sep 2023 03:52:45 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RAcnXf004094;
        Wed, 27 Sep 2023 10:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=p7bvpxWTCGZRqRAt93RFhT/3ttmtfCYh5WDFB+WXbag=;
 b=jVo8G+6kOWhgLfdgK8hGDI11lSaNi6i7w4MYB70/KTV9hjmZq0vYb4+MzGAE7Ss0twPp
 KKyV22r3d5TkhETw8L4G8p0mGuStHG0V30BAKzLS6iinEwdpvlO7p3iOhjA9HUmUvvhk
 4VHrU/9BZIk1mJ4P5qKgZDfo/eGM4IoKr838B/Jm+eB7X+ZtWm7Nn8sMiAaUUs/xn9p6
 hN+54RZfXDK632+O5m7a8FCO/c9td2wSVU5rKVbpjEuNweUL+ON30xl6AZhTXWE1M4Mo
 ouUUrSBN4FuyJtyN0VcdYXJijmygngV+eKtCAgqxZn3guw4OY53exl8fw2gH9C4gUee2 uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcjewrv7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:52:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RAdvUl011232;
        Wed, 27 Sep 2023 10:52:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcjewrv74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:52:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38RA77MG030805;
        Wed, 27 Sep 2023 10:52:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tacjk2fgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:52:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38RAqS58262882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 10:52:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF3858055;
        Wed, 27 Sep 2023 10:52:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EDC158043;
        Wed, 27 Sep 2023 10:52:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.13.22])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 27 Sep 2023 10:52:27 +0000 (GMT)
Message-ID: <31585f93157c5c4487b53e3bcb6aac9e92e62f92.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: rework CONFIG_IMA dependency block
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Oleksandr Tymoshenko <ovt@google.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Sep 2023 06:52:26 -0400
In-Reply-To: <20230927072223.2555698-1-arnd@kernel.org>
References: <20230927072223.2555698-1-arnd@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1rKSBq5tsJb9MXCO0ypd9YQTzLUmz48w
X-Proofpoint-ORIG-GUID: JfqdLNvu-WSj1Q0qk5oY6hgVqKfRYm1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_05,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=995
 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 09:22 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Changing the direct dependencies of IMA_BLACKLIST_KEYRING and
> IMA_LOAD_X509 caused them to no longer depend on IMA, but a
> a configuration without IMA results in link failures:
> 
> arm-linux-gnueabi-ld: security/integrity/iint.o: in function `integrity_load_keys':
> iint.c:(.init.text+0xd8): undefined reference to `ima_load_x509'
> 
> aarch64-linux-ld: security/integrity/digsig_asymmetric.o: in function `asymmetric_verify':
> digsig_asymmetric.c:(.text+0x104): undefined reference to `ima_blacklist_keyring'
> 
> Adding explicit dependencies on IMA would fix this, but a more reliable
> way to do this is to enclose the entire Kconfig file in an 'if IMA' block.
> This also allows removing the existing direct dependencies.
> 
> Fixes: be210c6d3597f ("ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Oleksandr Tymoshenko's patch to address this, made it into linux-next
today.

Commit be210c6d3597 ("ima: Finish deprecation of IMA_TRUSTED_KEYRING
Kconfig") made it last night into linux-next.

-- 
thanks,

Mimi

