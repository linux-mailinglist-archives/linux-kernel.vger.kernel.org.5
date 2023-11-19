Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD37F06C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSONH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69DAD8;
        Sun, 19 Nov 2023 06:13:01 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEBDhi005344;
        Sun, 19 Nov 2023 14:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=t6/LH3DJPxANC0T8RNJ8m5HT/bXXnVCsCpC3L0JD3e0=;
 b=DlYKwozcZKAFOQwZzY7EJ/7iXUyteSoX4QoU1t/VetJG2g/zrwA507i5UYO9jOwE0lue
 ix6KZNc1z3mPZXgT1RaPEiXSZ3iBsUXr8mpmVlocSD1TA8iZ1VC6Y8ROJ3iLegyXqngQ
 4ZaAMGOV7f4KGbckyUDSMFLEhlVWYWXv/Pbo9b+/wi+M7X+8gVrHW6XMa7khrODv4HJq
 QmIVjIREaS0efzWnPGVwklVrGVuHwlRc+OFFGaRng291yDdAhAx9D4w4GxkCXPpnPMIF
 KLd6GmzOcKkFyWnyjsLrMVNpTNNn0VqZvkjZrGI01fhbNqBUs1lelSwobF0q4u5GB/uh dw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf7kh1q0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 14:12:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJBJQRZ002185;
        Sun, 19 Nov 2023 14:12:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy3gj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 14:12:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJECvE557803150
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 14:12:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6D2E58055;
        Sun, 19 Nov 2023 14:12:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16E555804B;
        Sun, 19 Nov 2023 14:12:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.145.128])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 19 Nov 2023 14:12:56 +0000 (GMT)
Message-ID: <bbb29d8a51b1c686c9fa708aeba5d7a8fd5621af.camel@linux.ibm.com>
Subject: Re: [PATCH v2] rootfs: Fix support for rootfstype= when root= is
 given
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
        stable@vger.kernel.org, Rob Landley <rob@landley.net>
Date:   Sun, 19 Nov 2023 09:12:56 -0500
In-Reply-To: <20231114141030.219729-1-stefanb@linux.ibm.com>
References: <20231114141030.219729-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: StZ-f78JR0cXDRCjCRV4M-pUi_xO2dcZ
X-Proofpoint-GUID: StZ-f78JR0cXDRCjCRV4M-pUi_xO2dcZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190108
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-14 at 09:10 -0500, Stefan Berger wrote:
> Documentation/filesystems/ramfs-rootfs-initramfs.rst states:
> 
>   If CONFIG_TMPFS is enabled, rootfs will use tmpfs instead of ramfs by
>   default.  To force ramfs, add "rootfstype=ramfs" to the kernel command
>   line.
> 
> This currently does not work when root= is provided since then
> saved_root_name contains a string and initfstype= is ignored. Therefore,
> ramfs is currently always chosen when root= is provided.
> 
> The current behavior for rootfs's filesystem is:
> 
>    root=       | initfstype= | chosen rootfs filesystem

^rootfstype=

>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs
>    unspecified | tmpfs       | tmpfs
>    unspecified | ramfs       | ramfs
>     provided   | ignored     | ramfs
> 
> initfstype= should be respected regardless whether root= is given,
> as shown below:

^rootfstype=

> 
>    root=       | initfstype= | chosen rootfs filesystem

^rootfstype=

>    ------------+-------------+--------------------------
>    unspecified | unspecified | tmpfs  (as before)
>    unspecified | tmpfs       | tmpfs  (as before)
>    unspecified | ramfs       | ramfs  (as before)
>     provided   | unspecified | ramfs  (compatibility with before)
>     provided   | tmpfs       | tmpfs  (new)
>     provided   | ramfs       | ramfs  (new)
> 
> This table represents the new behavior.
> 
> Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root=  specified")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

As the patch author,  "Reviewed-by" is unnecessary.

Please add a reference to the original patch on which this is based.
Link:  https://lore.kernel.org/lkml/8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net/

> Signed-off-by: Rob Landley <rob@landley.net>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Add Changelog as requested.

>  init/do_mounts.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 5fdef94f0864..279ad28bf4fb 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -510,7 +510,10 @@ struct file_system_type rootfs_fs_type = {
>  
>  void __init init_rootfs(void)
>  {
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> -		is_tmpfs = true;
> +	if (IS_ENABLED(CONFIG_TMPFS)) {
> +		if (!saved_root_name[0] && !root_fs_names)
> +			is_tmpfs = true;
> +		else if (root_fs_names && !!strstr(root_fs_names, "tmpfs"))
> +			is_tmpfs = true;
> +	}
>  }

Please change all "initfstype" references to "rootfstype" in the patch
description.

Otherwise,
Reviewed-and-Tested-by: Mimi Zohar <zohar@linux.ibm.com>

-- 
Thanks,

Mimi

