Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AE780A68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376349AbjHRKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359212AbjHRKpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:45:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880B026A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 03:45:11 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IAeGq1027595;
        Fri, 18 Aug 2023 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=KfERY46rgIcK46MYIrrrbcH+Bi0AGIA8uAKMLCCgmfE=;
 b=TT6FNDBk8HIsxW5UmL6iD5YQNa25X0yP9e2D+hsAGTshtFgVMfHsFgiLubl/u095tSSF
 1h5ubZk2FLICBMfMRWJQEZ6h2X2w3Zj1cp5Df6nJW9UsVKXalfi8RWa1jm1USpzodh/7
 M4JM5UYpLm+VMdNsiT9eeLJwLThyw9LV3Te67r76jERxHPNtjcI0PH+iBv58fMCXKybm
 3UprsDRU1xhaFHQpXn51poJSH9gVaAFCq44iugQLGT41ZnqIDY/soKt8e0e0M9eMlArw
 dcJ/x3AauhNFfLTmzKe4d1r7kMD4Zi5CAh/RkQjct8/5qDHVp+QdOnanUoH7I0DWnoD1 mA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj6un0b3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 10:44:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37I8aqN1007832;
        Fri, 18 Aug 2023 10:44:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwkx559-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 10:44:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37IAik9724052234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 10:44:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AC1820043;
        Fri, 18 Aug 2023 10:44:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6A5C20040;
        Fri, 18 Aug 2023 10:44:45 +0000 (GMT)
Received: from osiris (unknown [9.171.32.106])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Aug 2023 10:44:45 +0000 (GMT)
Date:   Fri, 18 Aug 2023 12:44:44 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com
Subject: Re: [PATCH] lkdtm: use the return value of strim()
Message-ID: <20230818104444.10148-A-hca@linux.ibm.com>
References: <20230817142117.972418-1-gongruiqi@huaweicloud.com>
 <202308170954.B18CCA9@keescook>
 <953b0290-a703-2bd8-179b-01442f736768@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953b0290-a703-2bd8-179b-01442f736768@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xMEMTh4uEjaix7Up2OO2w3c3F8cbLc7l
X-Proofpoint-ORIG-GUID: xMEMTh4uEjaix7Up2OO2w3c3F8cbLc7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_12,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=340 bulkscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:39:06AM +0800, GONG, Ruiqi wrote:
> 
> On 2023/08/18 0:55, Kees Cook wrote:
> > On Thu, Aug 17, 2023 at 10:21:17PM +0800, GONG, Ruiqi wrote:
> >> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> >>
> >> Make use of the return value of strim() to achieve left-trim as well as
> >> right-trim, which prevents the following unusual fail case:
> >>
> >>  # echo " EXCEPTION" > /sys/kernel/debug/provoke-crash/DIRECT
> >>  sh: write error: Invalid argument
...
> >>  	/* NULL-terminate and remove enter */
> >>  	buf[count] = '\0';
> >> -	strim(buf);
> >> +	buf = strim(buf);
> >>  
> >>  	crashtype = find_crashtype(buf);
> >>  	free_page((unsigned long)buf);
> > 
> > Will free_page() still work in this case, though? The address won't
> > match the allocation any more...
> 
> Yes I noticed that, but I was under the impression that it's fine to do
> free_page(paddr + offset_in_page) since the offset is within the page,
> and its corresponding struct page can still be found when being freed.
> Please let me know if this thought is wrong and I will submit another
> version.

The question is rather why you think this patch makes any sense at
all. Nobody is doing what you described above - hence there is no
problem. The comments in the code even say strim() is used to remove the
trailing '\n'. If anybody passes a string with whitespace at the beginning
then that's just a user error.

There really is no point in patches like this.
