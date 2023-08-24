Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2B78797D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243559AbjHXUl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbjHXUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:41:10 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CECA10E0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:41:08 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OHe8Gc026108
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:41:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=4Fk6AV/6IaQmDihdu+2T+7gC2KZykw1jPXWr6pJtkiE=;
 b=WOBCTq5iCIdKexJS+CxRqWLOH4c6DgfxbIRlDf5EmAuSBfKL/hwA8qbgL5JfU5fdzI7c
 Prt/ENvfioQ4JKQcfOONk6EIzMcdaIUgX5TGU2IB1mrhieGeoJD4qN4weU/J/Bp9TDag
 4M0YkAFHeiBCqiDRWyaRvr5ERCFMT3mZvIaPSrlBUAlGlgz1WvxCX4UIDa3GTMe1bADQ
 hyHc2dVGSmp3vjlFyj19IT2jijP1K8n8IoBi3S+Ps/kJ5AC9QveMg0dPu5dzoePLrd15
 PnEI3W/aSaMBcRT0vHmI9ETEz7AHHvJSAGOaUWMeW5b9vnyeX+lsob+UOJZKqpUEb9sS TA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3spb72syfr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP2Axgv226FtQx0FUXnjTAp40DX2jw5hNC+Ln/HmRSAM8qN+29iuueI5lg+KExxqi0pa1pxRe6hKnch9F/yqBP2umgOCo0cQzTFcDHiKL0m62ZHgpa505wRbBgqj5grDSuKIMIBGysmQWHBKH4iWrelI/LHq7ty2x88OlXlT8nTmv1Q437HccPdlizLjYFzvvXe5pBn54/ConWMkLrqB62cQ+aq8Ndn8VzuKs7CjrBVle0pHLZTZqtHHauV6q7YQvJvim5Ez61PxSueswRessNasrfYKLGWmgLgIFp38el9Ce3Zpsz/EQgEVh5VZaQu5CLo1ipQ6ur5nTSGzS4bLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhFWCBAKqmr657aJ+KjZ2/oC0gmTI/ZPKHqrY0HNAv8=;
 b=Am/BI1HGdLVPk2ylmCg81UqBrzNZNMScxv5Wz6B3+nDPhHXW6q3uX1IYFQf4ZvnfMPnWJEWDB7jfVRX4mrZTCcXTFp4K1bq0B6vft32HqVBVL4OuljMfo4gPxmDO1sLy84FuJLLqkYWoD+tnpodSKesIkepCNtcbWc10m8j3Z/aD0BkDNu8rsq8Ghhy9P/QrGSKkTdKwWDtFr3AFlW//xLgyDErI0spm1GWFlpTp9rRG3+IW/DfdPLyRQy4Gz5gXPKzn8mYYw07GvkZ6pXDJlvqxc8Zqjn+sQYABLxqD5Vwj+SCC1wc9KVH1+1SP5Jv60+s0DLNCiYj8aRN4+dA6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4515.namprd15.prod.outlook.com (2603:10b6:806:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 20:41:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1c93:563f:c78d:9be1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1c93:563f:c78d:9be1%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 20:41:04 +0000
From:   Yonghong Song <yhs@meta.com>
To:     Kees Cook <keescook@chromium.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Liu <song@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [linus:master] [kallsyms]  8cc32a9bbf:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:test_entry
Thread-Topic: [linus:master] [kallsyms]  8cc32a9bbf:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:test_entry
Thread-Index: AQHZ1dEAk0qStkpJF02YoqvL7PdDbK/55qGAgAAEBQQ=
Date:   Thu, 24 Aug 2023 20:41:03 +0000
Message-ID: <SN6PR1501MB2064F8313A3AD64E6F69C2D5CA1DA@SN6PR1501MB2064.namprd15.prod.outlook.com>
References: <202308232200.1c932a90-oliver.sang@intel.com>
 <202308241323.ABBE0B09B@keescook>
In-Reply-To: <202308241323.ABBE0B09B@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4515:EE_
x-ms-office365-filtering-correlation-id: 5fb10749-b054-4e95-9be3-08dba4e26f45
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tmqU00Ga3gOr9WM3RIcQGy76rlMWtr/fAy9ymbl+ALdm4jWL07nqCM6NAZp13IZMo2ETfReJxbeTsR3oYw9bAw8Wl2SE6vGGPDZqY3oSjTkENsPASnBVNvyBhkvISVACWg7GlE77R4+EqzPkOnZ0ezbG7DmPpbBIaD+NH72CJqpyss7V/+2DmYdqym0rj5HiUzHcqDoXgS3jZQs2yTK8CGWw7g+3rH3lP6gUj3IqK2cK5zX2TvJWZOTUMghn02ixREyuCLSm53PZfchJcNqrS/XlVDCnLhrB7Rn083z4yIAddQRTqIf5ZpM0c587LiCedRUfcSHhom4jFQD/fam5czWXfzLu4SF4ajIcHWHVpl2UsMFrA1ie0DXkjRlOfS67Yh1rg2xan3TJA/5hbW0jYUq5PEJWxE0OAlPr540BwSOx7z4lJry4ZsPXcojbVLPvFhNLIbfjidlfUAeRRNtWOvJRXqP/OrmjU7M+fq0z0N7vHVRf4nnWHiby3on1anb/ruhd8QZ2sZ1fTteG3cmiFT6vR9TC2CAssDvAHFtVRyRReh2k9HaU3fLR3btjXBTHkuzy/BQbjkaqlY8j04jp5VPvY/pu51QyzXWUGkaD1D0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(186009)(1800799009)(451199024)(66476007)(54906003)(66446008)(64756008)(66946007)(76116006)(66556008)(316002)(6916009)(122000001)(478600001)(91956017)(55016003)(38100700002)(38070700005)(33656002)(71200400001)(41300700001)(6506007)(53546011)(7696005)(86362001)(2906002)(9686003)(966005)(4326008)(8676002)(8936002)(83380400001)(52536014)(66899024)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/j/eCNRMeH8Fw1FAUIO639Oa6Kc+Sp1d1BWROX2dcpGgjibiQcns5vvuit?=
 =?iso-8859-1?Q?yWyf7BCiGH7UazyXXCAkAE6t83UJ+6v4Loiz8OGt6ypBt0bTfdvvtyQyf0?=
 =?iso-8859-1?Q?GtaUnAciA31Wo86hgiOcZ/teDbfREUlWkbNZ0FTN9PQlzRStSET/O4QEPi?=
 =?iso-8859-1?Q?QzQUJYvegyi3q9+QB3wKSMUiP0YnVHf9ZAqrGYgOzsL7gOUBm76LI270X/?=
 =?iso-8859-1?Q?n6n0UfMsS/VHNHtH8Ur8tVPul5zuWmrVYHbGZl12C4Jt5r9Eumh1NZQAqv?=
 =?iso-8859-1?Q?bsvAVIb2N2ub7jvHgx9vu96U/pYHYZAdRC4NeE0k8uARE6jboLfH3jZWra?=
 =?iso-8859-1?Q?nopzyQpOk6a0Mi/48s2sMl21vkOmNzv8YSD93Xxne1+H+GBG4YsOfij2RE?=
 =?iso-8859-1?Q?bAArVdXMsYf/m2ncy24YVziwnMFxhl7VcVelJxrFfiNPacPyZiYO0ADokN?=
 =?iso-8859-1?Q?04iyh0vmRgW7obu9h7yLpEdVIevqjARYYX+BMOY7s0rVUKGiCaufd6FbNi?=
 =?iso-8859-1?Q?a9wMWtxzC/TTLZvfQPXBhGb6eVxAJt4I3rdpQg09qndxJoDqs8BxBaOI4m?=
 =?iso-8859-1?Q?TCid26KjII8XcTtkHaSwQH1ZKEH/JhMZwLsxqY6P+9Adk7rO1zIFLb9kek?=
 =?iso-8859-1?Q?X14CX0z88V6oseFFoy3fsRX1sGgqk0auRuQIXvoBt6FGLio+Z2UZiTWS+G?=
 =?iso-8859-1?Q?PA1Ug5qwuXv7OV1l2sd+qj29ujRh/nfSpvhvdcvBGFjmuug32lIeqvv4BD?=
 =?iso-8859-1?Q?6CUGlwpHb3aSpQsg+sGInljn6d+j0FBak8ON03hEfZGl6s+g/Ze+RhV9Uj?=
 =?iso-8859-1?Q?b7N3ZLiwApjHs0zNYiRg10Z1q2LVswuXZz4GbMa3dt1n9jW7QatjhkWgl6?=
 =?iso-8859-1?Q?10bXJP+g/wCqGXbtIZhFRzcbBKggtM+o27yo5xQHwy7NNRRZwVzZewmjtX?=
 =?iso-8859-1?Q?MMH/GaVL9xBX3xM/HuRMIupAruAka2o96SFfXusvRbhauEYR/kQUV0773p?=
 =?iso-8859-1?Q?O8D3m20pLUTb5Soj+DM9YqdVxC/bxWssI3RwSB8+YF7vIBR+G40/eSGrG6?=
 =?iso-8859-1?Q?eBI0DEIdZC04t+g75NI5N8b0eyx3b8DKoLk17nItZ2D/9zihSpVfoUi4pW?=
 =?iso-8859-1?Q?tLSxWAed9K+b6yJpSZZeSWHCnRHpU6wjqwh+R7fyGiqZT8tqS4p4EqZrsF?=
 =?iso-8859-1?Q?dS6ZY2SAtBMzpgXNWFNdTuRE/CbZ0YyGLOrK4F9Zfi3CPfTX5Og9n4e45Q?=
 =?iso-8859-1?Q?r5N11cBgK8VNelLzddsqE1HqCUGdp3sW9wWVS3TkmpXH6ytBTsrY6gTZN6?=
 =?iso-8859-1?Q?F3MAQ4yKtRZlnQb3NTqV46hYSgyN5YEZGD71/r9ldmgFLkqBK43pm9KNI4?=
 =?iso-8859-1?Q?405h3Wq0Yz6jBzjLJp74d7/w4D61VfAyKYLyY8Z5Mzx0WrNopffww+AJTk?=
 =?iso-8859-1?Q?cZmQZVHirIK0glmx+DtThOzLsHKqpfWVDZwm5bVLdcsQUZ8/PwTT3y+0Fv?=
 =?iso-8859-1?Q?M1TbQrlobcKfVflDNBPx3fcXI5CVUtadgJEZZqADj/BkefIcRKqy/bWjmP?=
 =?iso-8859-1?Q?PFZV+3hePuOGXSgNnPt1uZYjkjkLmLEoQgIQEdL0n7S3aeHdIjEIddPS5e?=
 =?iso-8859-1?Q?lxeqtJcDhaUPfR9PDIp1t9TEM5qOy4VHhF?=
Content-Type: text/plain; charset="iso-8859-1"
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb10749-b054-4e95-9be3-08dba4e26f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 20:41:03.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMcsG4lWWxt6620ZCFiW7pSp4HdYhlQy4Q8+mtuDZjvv51J9Qe96TQ6q5XVoJD+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4515
X-Proofpoint-ORIG-GUID: 2cixG8Mlgrg0wppvfMELp021nPvwS3sd
X-Proofpoint-GUID: 2cixG8Mlgrg0wppvfMELp021nPvwS3sd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_17,2023-08-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging now. I already made some progress. Should be able to send a patch=
 soon.

Yonghong

________________________________________
From: Kees Cook <keescook@chromium.org>
Sent: Thursday, August 24, 2023 1:25 PM
To: Yonghong Song
Cc: kernel test robot; oe-lkp@lists.linux.dev; lkp@intel.com; linux-kernel@=
vger.kernel.org; Song Liu; Zhen Lei; Nick Desaulniers
Subject: Re: [linus:master] [kallsyms]  8cc32a9bbf: Kernel_panic-not_syncin=
g:stack-protector:Kernel_stack_is_corrupted_in:test_entry

I was able to reproduce this failure. Yonghong, any ideas what's going
on here? I'm still trying to figure out what part of the
kallsyms_selftest actually failed (there are about 4 places that all
lead to this error message).

-Kees

On Wed, Aug 23, 2023 at 10:48:58PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "Kernel_panic-not_syncing:stack-protector:Kerne=
l_stack_is_corrupted_in:test_entry" on:
>
> commit: 8cc32a9bbf2934d90762d9de0187adcb5ad46a11 ("kallsyms: strip LTO-on=
ly suffixes from promoted global functions")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [test failed on linus/master f7757129e3dea336c407551c98f50057c22bb266]
> [test failed on linux-next/master 28c736b0e92e11bfe2b9997688213dc43cb2218=
2]
>
> in testcase: boot
>
> compiler: clang-16
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202308232200.1c932a90-oliver.san=
g@intel.com
>
>
>
> [   28.923687][    T1] systemd[1]: RTC configured in localtime, applying =
delta of 0 minutes to system time.
> [   28.926842][    T1] systemd[1]: Failed to find module 'autofs4'
>
> Welcome to Debian GNU/Linux 11 (bullseye)!
>
> [   30.135342][  T115] kallsyms_selftest: Test for 1153th symbol failed: =
(show_trace_log_lvl) addr=3Dc1033b00
> [   30.135366][  T115] kallsyms_selftest: abort
> [   30.137440][  T115] Kernel panic - not syncing: stack-protector: Kerne=
l stack is corrupted in: test_entry+0x1419/0x1430
> [   30.138878][  T115] CPU: 0 PID: 115 Comm: kallsyms_test Tainted: G    =
            T  6.5.0-rc1-00002-g8cc32a9bbf29 #1
> [   30.140321][  T115] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   30.141688][  T115] Call Trace:
> [   30.142207][  T115]  panic+0xf4/0x31c
> [   30.142789][  T115]  __stack_chk_fail+0x10/0x10
> [   30.143470][  T115]  ? test_entry+0x1419/0x1430
> [   30.144141][  T115]  test_entry+0x1419/0x1430
> [   30.144802][  T115]  ? __die_body+0xb0/0xb0
> [   30.145432][  T115]  ? 0xc1000000
> [   30.145962][  T115]  ? __die_body+0xb0/0xb0
> [   30.146642][  T115]  kthread+0x203/0x220
> [   30.147262][  T115]  ? sprint_backtrace_build_id+0x20/0x20
> [   30.148032][  T115]  ? kthreadd+0x2f0/0x2f0
> [   30.148656][  T115]  ret_from_fork+0x19/0x24
> [   30.149412][  T115] Kernel Offset: disabled
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20230823/202308232200.1c932a90-ol=
iver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

--
Kees Cook
