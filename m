Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D897E52E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343932AbjKHJvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjKHJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:51:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C45E198;
        Wed,  8 Nov 2023 01:51:35 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A89pHot020550;
        Wed, 8 Nov 2023 09:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : content-transfer-encoding : in-reply-to : references : from
 : subject : cc : to : message-id : date; s=pp1;
 bh=GJS+lfx698uo4dMAPAezpADnQYOz/Lk64FPPBIDsaQI=;
 b=WSi+JL9t/aczZMwq9Em9WbmcYXbiTAYNLv/aOGAZmff4/7Mg/aP1i5CdlTwEmD7lWIYz
 W58SLFRWAfTFWRgjWtRrsqWt7PmcbZjTVx63IRPIQQU4Q+SPOYnJ8wz2JcHgB7nxx9Yh
 eLX3xi890cGNS5N6xgg0CXfAQGtz86nvzWpXuOYj+jfbTqWxOMaRrA/QmTfJxJ4h31cd
 5h9xUF2HOu7bRtvd8X3BDZYJiJWHMio6sN4oMCzUqESVxHXGijq/C0kEyvKu8x5aFHmf
 3wgJcEW2+NcrZ3JMw56LTmHt97ami7mJ4/byI02bpyVYoz5UpUKO5dcuaBbDpeY1TmSN qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u87werarb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 09:51:33 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A89erKE019920;
        Wed, 8 Nov 2023 09:51:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u87weraqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 09:51:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A88iYPc000667;
        Wed, 8 Nov 2023 09:51:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22uvg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 09:51:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A89pTNW22544970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Nov 2023 09:51:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8DE020040;
        Wed,  8 Nov 2023 09:51:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D4AA2004B;
        Wed,  8 Nov 2023 09:51:29 +0000 (GMT)
Received: from t14-nrb (unknown [9.171.59.93])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Nov 2023 09:51:29 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231108094055.221234-1-pbonzini@redhat.com>
References: <20231108094055.221234-1-pbonzini@redhat.com>
From:   Nico Boehr <nrb@linux.ibm.com>
Subject: Re: [PATCH] selftests: kvm/s390x: use vm_create_barebones()
Cc:     Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <169943708853.84865.14594024975699715241@t14-nrb>
User-Agent: alot/0.8.1
Date:   Wed, 08 Nov 2023 10:51:28 +0100
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nSt93xc_8hrk9K8UXsBKUZPRHLZ0Qms7
X-Proofpoint-GUID: Qm-C5q9JlYI1LbPaEFjvduwe_L3OA5TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=760 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Bonzini (2023-11-08 10:40:55)
> This function does the same but makes it clearer why one would use
> the "____"-prefixed version of vm_create().
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks!

Tested-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
