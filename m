Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCDD7DE1AA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbjKANKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343771AbjKANKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:10:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A62B7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:10:42 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1D9x8N012380;
        Wed, 1 Nov 2023 13:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=O/1fke/X1Lag4SbhkIhlJ5pIx16MoSjoPlAuGpnCidM=;
 b=VHuD0GlnjaGYmhJwyRSIFt2sp2xSOoPxcLpz+S6UOxHI34dOCegqo7Ak4+rZ9UIaZwxK
 hl1KtY1AaB8D7V6Yi+7kO68luCL+kGmPZdVlh1bLAe57WHwnVucY0hLhzxagDLIsF7sr
 b3nIEh68rr9yhJOdBsESUJq8Q1TAa5Q4+ugMWVrLoVe3ZCGha1iQ8PgpFYX8EEGHCAhj
 gBFFrTslJOIfnPkWxFRApwEOxF56I6OsR1B7UyeZpJnh5izZn45SxJgDdhF0Le0RJoBt
 dDOOyommaPpK+vOU4OP+pfPJnqDM3Rx3UeDA0a1qIxEC6BscrTH109CwHR4k9duYeyRP 5w== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3ntnasqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 13:10:35 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1D6MY0011608;
        Wed, 1 Nov 2023 13:10:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4kyk3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 13:10:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1DAUKn24183468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 13:10:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E73EE58059;
        Wed,  1 Nov 2023 13:10:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80DB558043;
        Wed,  1 Nov 2023 13:10:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Nov 2023 13:10:29 +0000 (GMT)
Message-ID: <f9d57ae7-6dd6-4854-b9cf-1eec4cfa2a92@linux.ibm.com>
Date:   Wed, 1 Nov 2023 09:10:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] fix rootfstype=tmpfs
Content-Language: en-US
To:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
References: <b455394f-9faa-1f1a-f171-0b9d5e9ada35@landley.net>
 <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <8244c75f-445e-b15b-9dbf-266e7ca666e2@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qUKeLZTSOltymsFyF5ttNVJdurzJNIfd
X-Proofpoint-GUID: qUKeLZTSOltymsFyF5ttNVJdurzJNIfd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_11,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010110
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/23 16:04, Rob Landley wrote:
> Wire up rootfstype=tmpfs to force rootfs to be tmpfs even when you specify root=
> 
> Initramfs automatically uses tmpfs (if available) when you DON'T specify a
> root= fallback root to mount over initramfs, but some people can't NOT do
> that for some reason (old bootloaders), so let rootfstype=tmpfs override it.
> 
> My original code tried to do this 10 years ago but got the test wrong,
> and nobody's corrected it since, so here you go...
> 
> Signed-off-by: Rob Landley <rob@landley.net>

I would like to be able to have this for some work with OpenBMC and 
ideally it would propagate to one of the recent kernels with a Fixes tag 
like this?

Fixes: 6e19eded3684 ("initmpfs: use initramfs if rootfstype= or root= 
specified")

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> See https://lkml.iu.edu/hypermail/linux/kernel/2207.3/06939.html
> ---
>   init/do_mounts.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 811e94daf0a8..01d80fb828fd 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -665,7 +665,7 @@ struct file_system_type rootfs_fs_type = {
>   
>   void __init init_rootfs(void)
>   {
> -	if (IS_ENABLED(CONFIG_TMPFS) && !saved_root_name[0] &&
> -		(!root_fs_names || strstr(root_fs_names, "tmpfs")))
> +	if (IS_ENABLED(CONFIG_TMPFS) && (!root_fs_names ? !saved_root_name[0] :
> +		!!strstr(root_fs_names, "tmpfs")))
>   		is_tmpfs = true;
>   }
