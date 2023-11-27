Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A387FAB41
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjK0UV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjK0UVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:21:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8610E4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:21:10 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARKAl5D001494;
        Mon, 27 Nov 2023 20:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=ROsI72neNiMsrbDjpDAbOmRQTD42BFapmOHkosJ6S28=;
 b=s62PHsIDGV/1pFHXVtgSalIU+nDmEDRR9XERvpOLopQPCVhW11tdWq+3a7Pg501zObLG
 LBnzlsP2CDQWo+ygMT3SH/qBuYmhPzqXZ36uLo+rIDvglzC2C8XTOD5tOc7YF8B6ZFp4
 Xr0UhTTgyz5dK1j8zDOqdXPvBF8q/yLoTuHAADsECFo2hGWQscXIayYlwb9ZZ/jf9o8I
 jkNH9QKty9D0U/zelt7RD8bI1PmicW7wxKUxpnQz58caj/5EMyuD5gDhO3sjg21xNHzB
 Ha6NM1DbVQPjlSv7SWDSYxGC0owfXnOJ2USOQSHBZ7VaxWsXSvttQpMDetAreei5w7YB mQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3un0mdjdbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:20:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJchIK018544;
        Mon, 27 Nov 2023 20:20:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjtrc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 20:20:55 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ARKKsw821168714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 20:20:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6026958057;
        Mon, 27 Nov 2023 20:20:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DB9758058;
        Mon, 27 Nov 2023 20:20:54 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 27 Nov 2023 20:20:54 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        regressions@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>
Cc:     Benjamin Gray <bgray@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: Powerpc: maple_defconfig: kernel/rtas_pci.c:46:5: error: no
 previous prototype for function 'rtas_read_config'
 [-Werror,-Wmissing-prototypes]
In-Reply-To: <CA+G9fYt0LLXtjSz+Hkf3Fhm-kf0ZQanrhUS+zVZGa3O+Wt2+vg@mail.gmail.com>
References: <CA+G9fYt0LLXtjSz+Hkf3Fhm-kf0ZQanrhUS+zVZGa3O+Wt2+vg@mail.gmail.com>
Date:   Mon, 27 Nov 2023 14:20:54 -0600
Message-ID: <875y1n2bix.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tX3c5ral_rPt_9wQ1R492hQBUM4oY95E
X-Proofpoint-GUID: tX3c5ral_rPt_9wQ1R492hQBUM4oY95E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_19,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> writes:
> Following Powerpc maple_defconfig and other builds failed with gcc-13 / 8
> and clang toolchains on Linux next-20231127 tag.
>
>   build:
>     * gcc-8-cell_defconfig
>     * gcc-8-maple_defconfig
>     * gcc-8-tinyconfig
>     * gcc-13-tinyconfig
>     * gcc-13-cell_defconfig
>     * gcc-13-maple_defconfig
>     * clang-17-cell_defconfig
>     * clang-17-tinyconfig
>     * clang-17-maple_defconfig
>     * clang-nightly-cell_defconfig
>     * clang-nightly-maple_defconfig
>     * clang-nightly-tinyconfig
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Build logs:
> -----------
> arch/powerpc/kernel/rtas_pci.c:46:5: error: no previous prototype for
> function 'rtas_read_config' [-Werror,-Wmissing-prototypes]
>    46 | int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
>       |     ^
> arch/powerpc/kernel/rtas_pci.c:46:1: note: declare 'static' if the
> function is not intended to be used outside of this translation unit
>    46 | int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
>       | ^
>       | static
> arch/powerpc/kernel/rtas_pci.c:98:5: error: no previous prototype for
> function 'rtas_write_config' [-Werror,-Wmissing-prototypes]
>    98 | int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>       |     ^
> arch/powerpc/kernel/rtas_pci.c:98:1: note: declare 'static' if the
> function is not intended to be used outside of this translation unit
>    98 | int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>       | ^
>       | static
> 2 errors generated.
> make[5]: *** [scripts/Makefile.build:243:
> arch/powerpc/kernel/rtas_pci.o] Error 1

This appears to be a latent issue in this code... the prototypes for
rtas_read_config() and rtas_write_config() in asm/ppc-pci.h are guarded
by #ifdef CONFIG_EEH for some reason. So I would expect this to happen
whenever it is built with CONFIG_EEH disabled and -Wmissing-prototypes.

So I guess it's fallout from commit c6345dfa6e3e ("Makefile.extrawarn:
turn on missing-prototypes globally").

Unfortunately the resolution isn't as simple as moving the prototypes
out of the CONFIG_EEH-guarded region, but I think I'll have a fix for
this later today.
