Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD88088EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjLGNMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbjLGNMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:12:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBB10E4;
        Thu,  7 Dec 2023 05:12:18 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7CFSUE004171;
        Thu, 7 Dec 2023 13:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pq9tlMAU45aQTY12lwhk5UDN9Rk9+Cf4WTKPJEyrQQw=;
 b=WJJdh3JVJNFTHyHhtb6cmX7wKwe487HSa1yHMTTzK8x6DFsETkbXn9Q3Xq12xYOfq9HF
 OC1MBsIB1uz/ZO1ipSzo/05siAUOP2jvRI68IkCY3EFjZZcfBFhn5gu9RcJKwPHhtM6Z
 23byy4+sxsbEfpw8ySazMHO50uLq9NlcRwtwIb8dZ8hs+q5130g0al/NCThOO1boE0Zr
 Q7JmmnOPFIvxdO+9TcRHzD/ERLn+01zxEGL77cBBrz65S9tu97eqBx+ukUJru4S2w2vo
 SLNJtUm8IXo484gkyQOasX1UfkYP9Ou1Gha7InbrDvA1NAWLxP0OmCWc0pLSpKYAUWvT +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuajaqvke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:12:14 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B7DCD9G013046;
        Thu, 7 Dec 2023 13:12:13 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uuajaqvh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:12:13 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7B5il0015401;
        Thu, 7 Dec 2023 13:12:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utavkk8rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 13:12:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B7DC6Zq24380048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 13:12:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B555320040;
        Thu,  7 Dec 2023 13:12:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84D272004B;
        Thu,  7 Dec 2023 13:12:06 +0000 (GMT)
Received: from [9.152.224.24] (unknown [9.152.224.24])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  7 Dec 2023 13:12:06 +0000 (GMT)
Message-ID: <0e2cbf20-bd58-49bf-8000-6d3f80f50380@linux.ibm.com>
Date:   Thu, 7 Dec 2023 14:12:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix missing byte order conversion in CLC
 handshake
To:     Wen Gu <guwen@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        ubraun@linux.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pyPlAxCYf6O0LsoSaApc_LH8y-D2Zudh
X-Proofpoint-GUID: 8qP-iISBaAlxC7jX63c4lAAUEkTTQJsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=849 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.12.23 18:02, Wen Gu wrote:
> The byte order conversions of ISM GID and DMB token are missing in
> process of CLC accept and confirm. So fix it.
> 
> Fixes: 3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---

Thank you
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
