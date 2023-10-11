Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB77C4792
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjJKB6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJKB6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:58:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC578E;
        Tue, 10 Oct 2023 18:58:03 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39B1NSFQ031962;
        Wed, 11 Oct 2023 01:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=MsZF3DXWS4QBPDVORuNX0rTwbALel9voxnmjcaDgym4=;
 b=BIJp9kKzOslLI2K1n2l24lM9baYdTCTV9LYzAC7fnTl8fIDEfhXUpG7i8vHWH4PXLAyg
 n/ZOS3iit81IPRWlrCv5PZ6f6BRHSXcufxEgyBUj0Xv6uf113ZZZIVmLBErjpZB46OeC
 1bUDYIqRkW798KNUvciPPeytr8De01eFfS7kYDg7sooSv60lOsrQbqQYXPWDxAI2KBJp
 2+s4Nr9e+QzAiJYs2K0WkwTRalhQ9ozGHc8f33ZrPQc5B+ku12ytv0k3QPFOWpd1UyQI
 Ic3Ho/7z5CJvW5aNnlSwRLClx8H2XZ6wS0nI4VOB/n23MzPwFwDwqBaLFPm81BzB6DNw vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tn492sxd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 01:58:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39B1w0lh016686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Oct 2023 01:58:00 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 10 Oct 2023 18:54:13 -0700
Received: from nalasex01c.na.qualcomm.com ([fe80::6c73:4982:d918:fc9e]) by
 nalasex01c.na.qualcomm.com ([fe80::6c73:4982:d918:fc9e%11]) with mapi id
 15.02.1118.030; Tue, 10 Oct 2023 18:57:58 -0700
From:   "Joey Jiao (QUIC)" <quic_jiangenj@quicinc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Thread-Topic: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option
Thread-Index: AQHZ+m0OO8dn2vGceUm2vHhzod0cabBEFOkA//+7qJA=
Date:   Wed, 11 Oct 2023 01:57:58 +0000
Message-ID: <49a0f7c36d8d41abb1204b0780667fe0@quicinc.com>
References: <20231009045636.4143-1-quic_jiangenj@quicinc.com>
 <ZSXR7PJmXZpZxQ2R@bombadil.infradead.org>
In-Reply-To: <ZSXR7PJmXZpZxQ2R@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.132.37]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DlLwjtOXcOZxYCF971rz17sPFrSnysYO
X-Proofpoint-ORIG-GUID: DlLwjtOXcOZxYCF971rz17sPFrSnysYO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

> How is ignoring an error ensuring ordering?
It's not ignoring an error ensuring ordering.
I think It's because `schedule_work(&init_free_wq);` changes when the free_=
wq will happen.
If sometimes freeing init for module A happens before loading another modul=
e B, that memory is freed. B might be loaded into that freed address.
If sometimes freeing init for module A happens after loading another module=
 B, B might be loaded into another memory address.
The change is just to disable the schedule_work.

> Why are you making this only now be called with this new kconfig option?
This sequence loading is especially helpful for syzkaller coverage decoding=
.
When kaslr is disabled, address inside core kernel is fixed, so syzkaller c=
an always get right function/line number from addr2line.
But module address keeps change across rebooting, in first booting, it migh=
t be loaded at X1, and at X2 after reboot, and at X3 after another reboot.
In this way, syzkaller just can't decode correctly for module address. And =
syzkaller currently uses PC and branch info for coverage guided things.

There was a discussion previously here https://groups.google.com/g/syzkalle=
r/c/1Pnm_BjrZO8/m/WOyAKx8ZAgAJ for modprobe.

THX
Joey
-----Original Message-----
From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberlain
Sent: Wednesday, October 11, 2023 6:36 AM
To: Joey Jiao (QUIC) <quic_jiangenj@quicinc.com>
Cc: linux-modules@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Add CONFIG_MODULE_LOAD_IN_SEQUENCE option

On Mon, Oct 09, 2023 at 10:26:35AM +0530, Joey Jiao wrote:
> When modprobe cmds are executed one by one, the final loaded modules=20
> are not in fixed sequence as expected.
>=20
> Add the option to make sure modules are in fixed sequence across reboot.
>=20
> Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> ---
>  kernel/module/Kconfig | 11 +++++++++++  kernel/module/main.c  |  6=20
> ++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig index=20
> 33a2e991f608..b45a45f31d6d 100644
> --- a/kernel/module/Kconfig
> +++ b/kernel/module/Kconfig
> @@ -389,4 +389,15 @@ config MODULES_TREE_LOOKUP
>  	def_bool y
>  	depends on PERF_EVENTS || TRACING || CFI_CLANG
> =20
> +config MODULE_LOAD_IN_SEQUENCE
> +	bool "Load module in sequence"
> +	default n
> +	help
> +	  By default, modules are loaded in random sequence depending on when m=
odprobe
> +	  is executed.
> +
> +	  This option allows modules to be loaded in sequence if modprobe cmds =
are
> +	  executed one by one in sequence. This option is helpful during syzkal=
ler fuzzing
> +	  to make sure module is loaded into fixed address across device reboot=
.
> +
>  endif # MODULES
> diff --git a/kernel/module/main.c b/kernel/module/main.c index=20
> 98fedfdb8db5..587fd84083ae 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2593,11 +2593,17 @@ static noinline int do_init_module(struct module =
*mod)
>  	 * be cleaned up needs to sync with the queued work - ie
>  	 * rcu_barrier()
>  	 */
> +#ifdef CONFIG_MODULE_LOAD_IN_SEQUENCE
> +	llist_add(&freeinit->node, &init_free_list); #else
>  	if (llist_add(&freeinit->node, &init_free_list))
>  		schedule_work(&init_free_wq);
> +#endif

How is ignoring an error ensuring ordering?

>  	mutex_unlock(&module_mutex);
> +#ifdef CONFIG_MODULE_LOAD_IN_SEQUENCE
>  	wake_up_all(&module_wq);
> +#endif

Why are you making this only now be called with this new kconfig option?

  Luis
