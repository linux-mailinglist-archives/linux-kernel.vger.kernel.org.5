Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1C6783930
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjHVFU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjHVFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:20:55 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020015.outbound.protection.outlook.com [52.101.128.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FF3130
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3fc/L6UYhljbVmkQ0toKUKp4lVfNmH1IN8O5/LODIl/YkOdQsumX9G1HqF2P+LIvmdtSxEZzlnlqIV46J2u5NJHsRdFIaZKFW4/SrUOOVyZByUydY/7wqJLzvi0EF5hHhNP/mYJCpDPE0spY9q4ppGWc6CzRx+H2n6AqmfmBHyJ37oP+QTuJiIQrINCDlM8N4YLlUeIUxLkGYds2ag/v2j4OhP1WVpAzyb6juJuMGxxVHxx70+amR7o/mfcKoYOTMl883R654S6AeNf+klGMr6kR8gd13SKnH5JO223K4twUNrWWJZu2XsJgBkYwkWPtqEiOdjePd8J2su/WT5tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXXGcWZdwK62dXpHKe0W9n4LD63Rwc2g/Ea7dvW23GQ=;
 b=P16r2sWkB6FSgiMG3m5gf1k5wOtQJclZnBWzqxM1XEf6vu4CHPn5Z3Qhk8ESKfZF2hSBKBzeS8Nb6NC4TzPAuQeeX5D8HV8put8cvJcHqFZTZpQbnSZHbucOvX8yJukzX3z6OhSGvpZZPsK3fRZkCDi7h/H6HDja58YaXsICHChhwQR8wbR8aspq0yBLw0SbZkH3XuSi4jhrws9Z1jptUaOso/paOjl+FdMChseVSgcT4aR1eNLkpnyZ7O66D/fAEDimG1foATSQpX23QVjRP5n0g0qcWAe7/g5hOq8BvX2i3NjjsJZDwyaOGTMGVdoH8Mn9sYt5DC7JCOQfmA8U2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXXGcWZdwK62dXpHKe0W9n4LD63Rwc2g/Ea7dvW23GQ=;
 b=UoabdPEL6e8o181fivS70Wdj775fio3YOHACszGe9nhqEtQOorgYJVNYz0zfvbEmQcLR8Ciebn4mknsCGRkJ7mgJOCK97C1/YumYYztRDmrNVwZZ5kGsUGqf4lvdUFDasuHRqDHC3Dc77xZ0Y+ecBg8nb5e9Vyx+gAp2eDgbRPU=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 PSAP153MB0488.APCP153.PROD.OUTLOOK.COM (2603:1096:301:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.4; Tue, 22 Aug 2023 05:20:47 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::4153:b8b:7077:5188%6]) with mapi id 15.20.6745.001; Tue, 22 Aug 2023
 05:20:47 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Zach O'Keefe <zokeefe@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Topic: [EXTERNAL] [PATCH v3] mm/thp: fix "mm: thp: kill
 __transhuge_page_enabled()"
Thread-Index: AQHZ1IoM8HgPXEhY9kCoPB9U6oVgbq/1x4Bg
Date:   Tue, 22 Aug 2023 05:20:46 +0000
Message-ID: <PUZP153MB063595F6B819308E09008796BE1FA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <20230821234844.699818-1-zokeefe@google.com>
In-Reply-To: <20230821234844.699818-1-zokeefe@google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=621b66d9-689e-4426-b40b-d960c4ce19de;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-22T05:19:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|PSAP153MB0488:EE_
x-ms-office365-filtering-correlation-id: a17e8155-5145-4415-3dd5-08dba2cf8a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pEIPe1p3LxSbS0/l3ZaiDvEi9Sqvo65KzLziwNccd+InLPQAvIwMlATKQlP37EGVG2+jvSgAfsJayFMU8LlRkYG8iZUXf8JutWVDJc8sAMbLmGX5j3RNMFMoi7inziL8bUeoHp6VBzgDIQ9Z45zUNSBZzxhlU5smVDEVbYqa/CfvOZ9v2mgf5IZjBu+6y9MIyP5jvJ/pbMJhagfnrvldxcdLiZ4GUpGr3mzwHahKRKf1GTg/NYetvMeRDtr5ffUV5AS3GMVv/jD5IIP1rkHlJjtTBfARascucnftbgOkqv6GmRJbawfEQF3lSdZvNhiFnikl/WmNkdIzuG6hRc5TxbaixSlbGvCBXts/aHAEvz717w2kQzPzrjp5x7u8j2kPbow2ircaZvCvG352zidncjilypIF6uR7DVWn4KNfQ8ML+raE9pmUxPKqVDoL3shQd3mzdYcsT/mfFAWLKFW3yWqQqxo8a9R0pnFuXAyPKNlj+lNJX9GREYlNySdyPnMzzAOm26Oh5WSVzCWNWOeXCBsWFyFdra2qsThUEsa7ekRwPgZfYw5VSvTVbRr9eodNNc1+2nZkyfhd+UFLFWqeni9dTVJOSIo2M7F1NOjIz+CciDPEaTD/gzERa/DbNPABDKaFrATcqvoXgYR56PjFKiaO/wJ+1udT+MBSTnYKD4eavQHLu6t7K20MWejO9kvu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(5660300002)(4326008)(8676002)(8936002)(66899024)(52536014)(83380400001)(2906002)(86362001)(82960400001)(122000001)(38100700002)(38070700005)(82950400001)(33656002)(8990500004)(55016003)(6506007)(7696005)(478600001)(10290500003)(966005)(53546011)(71200400001)(316002)(66476007)(66556008)(76116006)(66446008)(64756008)(110136005)(66946007)(9686003)(12101799020)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GuaeDFOnDdDqav30h4LKYkxTFNMmslhmg3n3Rz/9CXYZTbsEr8XpmP9B2QFA?=
 =?us-ascii?Q?6wWz/1qRWogKOgBmQeyDzKzWIdRywZ0PAyvauIFUEdrmYpy34jIj4PaXCGFY?=
 =?us-ascii?Q?mmG3qnx0fp8+vUA7SFKjDbXW5B8E84P1x5+ot+FjPbcYOLjqZrF5UssA2/nP?=
 =?us-ascii?Q?1syC5x3TCG4dFpq12iXlCOmcFbhXWJXUHLD78Guc5Jgc6OoKjSwBtOkAtHed?=
 =?us-ascii?Q?MqU9HxR9KKS+zSNIn6B8gXkE70kJcnVqjKYEySQMyoLNAgInB2gPKo7+3OeZ?=
 =?us-ascii?Q?Pz3rphPTBupiMZFw7haFHiiRMLQlNrICLT/Lq8WSCfxIZ9O6wC+xR8hJ44lU?=
 =?us-ascii?Q?7b/f5osNsGFIUvVPyEvzUnV/M/qnUImLxK6gmyE8t1nGDKMDMLg0ONfofrKV?=
 =?us-ascii?Q?JzBYi0k+f6CukmIwPBNbt54xoslgphLoTLaY4ZHrzEB+BphYC50sIfeNFPDn?=
 =?us-ascii?Q?EHhOBQH7vKb8gkk/rfcgfRe7rvUdckd4ugmz5EoELf2V4doAJ/Y6pi5RrVSj?=
 =?us-ascii?Q?YBsAdjC9O3SV5VzTibU3agTnLyQVqr2xvyLnrPBaPknkS9D1jUdX93EqgSec?=
 =?us-ascii?Q?sD9F14DGyfAiTlBuYSOhX6sv5Ujb+AfCKLnDm9eOIw43T5qIvhRXjQX4SkU6?=
 =?us-ascii?Q?fcgJ22M512/WRl6VN+mJs4Ly7dF/3cQW6tBTeFad1Ic/CmHk4wzCR4hI1fGD?=
 =?us-ascii?Q?hr9l8qhlZame1LOsTamFJMSEuryYIeyuaHalsa3i6y20S2UU9MW4Vxf88vvb?=
 =?us-ascii?Q?GlsO8BfXYTgq5mzH/HXfj2iGerb2wijRcNsihfStlPYq41uPT4KriZfymNHT?=
 =?us-ascii?Q?Bv0JRoBP5QCgc74hTyBkDQmG3kheBm5RP6EJkaGK4NKspdQtYqNTazjW3mv4?=
 =?us-ascii?Q?/nXSuThzhwjdCnAbM6lJxY4+ziEWODW1NvBwWMrnCcuVd2MdAe8EXongFdmr?=
 =?us-ascii?Q?srads3VJ4+ApnXiJoEKPW8TzNXFjQN7p6GeFnBTS+Igtoy9D5Jh30IYjQCTO?=
 =?us-ascii?Q?X1nRaSJs3eUvG0H3JgU5CSjzkvaTzVceJ0c/WcFTFJfQXu5zMdl+FJkWv6Ox?=
 =?us-ascii?Q?254NQ+YRY+EGaqtTk6p5nvM/8zF8AWTWf95P4kQ+UwrIiVfnvhfeFA6zwS4N?=
 =?us-ascii?Q?ZkNHi3ptLJwF69eJ1x563IVRCkq+totmb5WOLAyVn8ZOBGUffCLFYf3j9MKV?=
 =?us-ascii?Q?n5coA8+YZYG7/ARv8gEav+ZZ6O4X0p3MacPpJWlOzCVVB7nKQ//Vvx8w1txi?=
 =?us-ascii?Q?p23B1MzIiASlIII//w4Wi1gLEr4BU4+cG1Gad1jh4Y6HcBM7zUcbjP0/JGSV?=
 =?us-ascii?Q?7X/Wz0DR8+4OEkEEVAKyTEt4B6a6ALakET98x3+EhyJkLjf1tOwJUcxAAagi?=
 =?us-ascii?Q?wyRXmrK84ro+J+qMiF9G3/Q25jTz3Ah1+3Ycxe5Ta47cIS1SyK+P7OcA59XQ?=
 =?us-ascii?Q?epnWuNOvwA+4HmGF+SB5qhX4QI/Y2ybIUdWUMJ003dpKWlRoY4cCf51BKdKl?=
 =?us-ascii?Q?pH7LOs7PwlBRgOeno2hHVwoBvOsLR4vQjdCLjwEyj+yE7hiOhTfa0NRh6MGt?=
 =?us-ascii?Q?rZ2dCrbjtqWRj1thlCgG2PA0MmqgDw4ArL1dCJ6T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a17e8155-5145-4415-3dd5-08dba2cf8a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 05:20:46.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EVMQovzfZ/vTtU6CzveN8mj9RS3PBEOEiqyOX1R8vM11x/odnS4dGH0Atgswhegk3AW6kN/l0GvKNxRZsjw+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAP153MB0488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Zach O'Keefe <zokeefe@google.com>
> Sent: Tuesday, August 22, 2023 5:19 AM
> To: linux-mm@kvack.org; Yang Shi <shy828301@gmail.com>
> Cc: linux-kernel@vger.kernel.org; Zach O'Keefe <zokeefe@google.com>;
> Saurabh Singh Sengar <ssengar@microsoft.com>
> Subject: [EXTERNAL] [PATCH v3] mm/thp: fix "mm: thp: kill
> __transhuge_page_enabled()"
>
> [You don't often get email from zokeefe@google.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>
> The 6.0 commits:
>
> commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()") commi=
t
> 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
>
> merged "can we have THPs in this VMA?" logic that was previously done
> separately by fault-path, khugepaged, and smaps "THPeligible" checks.
>
> During the process, the semantics of the fault path check changed in two
> ways:
>
> 1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps
> path).
> 2) We no longer checked if non-anonymous memory had a vm_ops-
> >huge_fault
>    handler that could satisfy the fault.  Previously, this check had been
>    done in create_huge_pud() and create_huge_pmd() routines, but after
>    the changes, we never reach those routines.
>
> During the review of the above commits, it was determined that in-tree us=
ers
> weren't affected by the change; most notably, since the only relevant use=
r (in
> terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is explicitly
> approved early in approval logic.  However, there is at least one occurre=
nce
> where an out-of-tree driver that used VM_HUGEPAGE|VM_MIXEDMAP with a
> vm_ops->huge_fault handler, was broken.
>
> Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> any ->huge_fault handler a chance to handle the fault.  Note that we don'=
t
> validate the file mode or mapping alignment, which is consistent with the
> behavior before the aforementioned commits.
>
> Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
> Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
> Changed from v2[1]:
>         - Fixed false negative in smaps check when !dax && ->huge_fault
> Changed from v1[2]:
>         - [Saurabhi] Allow ->huge_fault handler to handle fault, if it ex=
ists
>
> There are some logical holes in smaps' THPeligible checks here, but those=
 are
> best dealt with in follow-up patches.  For now, just make sure the fault =
path is
> dealt with.
>
> [1]
> https://lore.k/
> ernel.org%2Flinux-mm%2F20230818211533.2523697-1-
> zokeefe%40google.com%2F&data=3D05%7C01%7Cssengar%40microsoft.com%7
> Ce782558e7bce4f9d060608dba2a12b58%7C72f988bf86f141af91ab2d7cd011
> db47%7C1%7C0%7C638282585367952964%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C3000%7C%7C%7C&sdata=3Dt%2FwAGlOyKmKp%2FnDPGv9cl2j3h%2F3xVuV
> Y%2BQqeu3A4HHk%3D&reserved=3D0
> [2]
> https://lore.k/
> ernel.org%2Flinux-
> mm%2FCAAa6QmQw%2BF%3Do6htOn%3D6ADD6mwvMO%3DOw_67f3ifBv3
> GpXx9Xg_g%40mail.gmail.com%2F&data=3D05%7C01%7Cssengar%40microsoft.
> com%7Ce782558e7bce4f9d060608dba2a12b58%7C72f988bf86f141af91ab2d
> 7cd011db47%7C1%7C0%7C638282585367952964%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000%7C%7C%7C&sdata=3DlT6ZqrOBoVIcPbOH%2BHto5pPTmpC6pk
> QMu58gnKG7aLo%3D&reserved=3D0
>
> ---
>  mm/huge_memory.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c index
> eb3678360b97..901dcf8db8d2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct
> *vma, unsigned long vm_flags,
>                 return in_pf;
>
>         /*
> -        * Special VMA and hugetlb VMA.
> +        * khugepaged special VMA and hugetlb VMA.
>          * Must be checked after dax since some dax mappings may have
>          * VM_MIXEDMAP set.
>          */
> -       if (vm_flags & VM_NO_KHUGEPAGED)
> +       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>                 return false;
>
>         /*
> @@ -128,12 +128,18 @@ bool hugepage_vma_check(struct vm_area_struct
> *vma, unsigned long vm_flags,
>                                            !hugepage_flags_always())))
>                 return false;
>
> -       /* Only regular file is valid */
> -       if (!in_pf && file_thp_enabled(vma))
> -               return true;
> -
> -       if (!vma_is_anonymous(vma))
> +       if (!vma_is_anonymous(vma)) {
> +               /*
> +                * Trust that ->huge_fault() handlers know what they are =
doing
> +                * in fault path.
> +                */
> +               if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
> +                       return true;

Thanks for the patch. I have tested it, looks good to me.

- Saurabh

> +               /* Only regular file is valid in collapse path */
> +               if (((!in_pf || smaps)) && file_thp_enabled(vma))
> +                       return true;
>                 return false;
> +       }
>
>         if (vma_is_temporary_stack(vma))
>                 return false;
> --
> 2.42.0.rc1.204.g551eb34607-goog

