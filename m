Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3647E4692
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjKGRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKGRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:11:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29649B;
        Tue,  7 Nov 2023 09:11:49 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GwXYg029699;
        Tue, 7 Nov 2023 17:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=P2/0r41YhdGhqR0vt7CFe2kQwbY5e3cpRfy81sHeWe4=;
 b=eeo87wUhH3XYt+LRH2bgxqCBjEVCVMi0dZtVUbM6XPdUE6rvky+tziXIhEMpBMjRF8re
 05+zsaKXsUSnJIksXlt3mBUh8CC+iwOObZbEN1LBfK0Zg6fADtLcHUMLVluNKG3RqA6N
 cQjaaezJVLMZOIeCDen3IPn4v11FuXbbN/OUCFfioTkAvNbcxl1w7ijDWHj8fvXkmmT0
 8pjuIAFQ8stmNuCkSkFiCz2KO2lEbNJxC8OC7Olg4M3o0HmW764ZvtIcZliLGnVgEUCF
 G5mK/OQDvXN2lyW3yRulxs8ELgAtlNZAQAaFFxziQ+MQw6XlveR1P0YDffcXrxBGbI4s ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7s2n91f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:11:48 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7HBmIn000413;
        Tue, 7 Nov 2023 17:11:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7s2n9128-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:11:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7Gae3N028230;
        Tue, 7 Nov 2023 17:11:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gk1uqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 17:11:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A7HBDqC22807054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 17:11:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3A2B2004D;
        Tue,  7 Nov 2023 17:11:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DCE020049;
        Tue,  7 Nov 2023 17:11:13 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.66])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Nov 2023 17:11:13 +0000 (GMT)
Date:   Tue, 7 Nov 2023 18:11:05 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc:     Janosch Frank <frankja@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] KVM: s390: vsie: Fix length of facility list
 shadowed
Message-ID: <20231107181105.3143f8f7@p-imbrenda>
In-Reply-To: <20231107123118.778364-3-nsg@linux.ibm.com>
References: <20231107123118.778364-1-nsg@linux.ibm.com>
        <20231107123118.778364-3-nsg@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iXE-Ie6CzKNY1mPDELbBM-zBi2lMQ6IN
X-Proofpoint-ORIG-GUID: Red-iamF0QfLzJwuSLGiBcAKemFbA9eN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_08,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=648 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Nov 2023 13:31:16 +0100
Nina Schoetterl-Glausch <nsg@linux.ibm.com> wrote:

[...]

> -obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o
> +obj-y	+= smp.o text_amode31.o stacktrace.o abs_lowcore.o facility.o
>  
>  extra-y				+= vmlinux.lds
>  
> diff --git a/arch/s390/kernel/facility.c b/arch/s390/kernel/facility.c
> new file mode 100644
> index 000000000000..5e80a4f65363
> --- /dev/null
> +++ b/arch/s390/kernel/facility.c

I wonder if this is the right place for this?

This function seems to be used only for vsie, maybe you can just move
it to vsie.c? or do you think it will be used elsewhere too?

[...]
