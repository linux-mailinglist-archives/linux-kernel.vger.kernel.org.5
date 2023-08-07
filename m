Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF83772E1E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjHGSqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHGSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:46:08 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4D171E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 11:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpsuFWTZjGdHnrGMY/HpG35cJIIcIKEmXujq+0Hl0sBXCrzdPHrH9JyQGoyygg+o/Gw1wP35BUMk8FVmbNjClKWmsaPsAcp7kGFTEOnUp3/Z7CJTobmt6cSoE689jQd1s8SbJdiTosCdT09JYwgmv0Bvh8Uk53MPhrUhFdRigWFJ7UlQzy6j8kDhD5lnXe7btQQWqUBAJ2Pzx3PBh7Ee59gjT/SBzaF6pLshmZPBwKEHNfh/GCFgsVk0S/YheUtyr0SE+g0Zdjv0z2o25xDcbEg9S4MtP0/Yb/yQ99pOfnl4VOLO26aYnvmf0hpgyNXGFVDKoAM9UigZdDR0omYSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkbUjT7JxdW5egLEn9iiiuUoXGL3UeN+bHbBsuHGYMs=;
 b=OOs28v8Cd+5vL1b5Pq3y1c2sxLe3KETG64Wf2U4tyIpPi2ge7+apjc710JKxLrnv7CVvW7skwbzxFAM2WJ3dw+6oLRtLpubqn/lSxFLJW6nCcdUeeM608/ZFqGthM93dQsONjSmTVB1BKMt0bvR4i79aZf1Y9QDSnQvGRQibqkvRgJGYxSgVyauJfIEPc3Qm56AsENMNn5R5YunHAsCeQ8jvkzdfnQRnjMkor76GVDGSl/BUkDwpuqKobfgi+t4m5Iu6o8gnATUdpY80pMqSCoDaQMhj9Ldu1gZneuhcEGz6SNsMGAqPZFwVkgJqpTHHRYJMRWlg2NpU2d8oapJNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkbUjT7JxdW5egLEn9iiiuUoXGL3UeN+bHbBsuHGYMs=;
 b=C9fUWnAVxBfbceLhI1bJXfD1ozPfuECMlR/NyhTOjs4qeJgyaqPkt/znr/ES8gXDMNBWdecHARytpBsM9wJn1ns79t2UrTL8phbOdDg/8Fk7oYKBuqLUiWLajX6RMxAKvKWDGWfVOwyfUNp/vzRYMBkfxLcirxY+FhUlqOBNtAmC5UD7uoxeMwo2hdIlaKIBEa0kSHUIK7hdCW7SwkpBzRdK+kJiE5B5zRVxH1lvsyPS1X4vLq3FqT/baW/mSQPXXq3NUPmXb3mFuMZ7GHw8Mg+AoC0UF9hlKWzGjymnbV+fbQ4dJ1jvn6T2JPLU8+c+XTtCsXGt8jU8DCJ9IhzVqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 18:45:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 18:46:01 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Date:   Mon, 07 Aug 2023 14:45:59 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
In-Reply-To: <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D1A869DF-D4D0-4CA6-8237-85B3F5D9848D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0014.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5ec2b6-bc99-4e65-2731-08db97768be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEQFBcbQcuTDkKLvx6QkAUfDY8qCMWpqXD6/h+LwydngDDiT4ufna0KU32I46ZzgKzatuq2zzfs1cdD/aQHU9o5yIgsDI0P5FvTUsvLfLzMreLkYyUJidRFK9KEE8LSQGni+RNG0OoaHTptgjwSCsqde1OZSuXR39OncwIWJQbA/OnFExFFM5G25+jbxTEz+GSbp3jb8VTXxzxqj4kXtl7CzBeU6RX9jrBAtl/NpI4hjOq/Ebo8RuXl5C2fuDSSErZ6Q6KLS4i8CKgm7UX2uCiTm4TS1MTKqi+enXhPPhEXwXYZyzFwWyEXnc3NeX+ulgadISqdj0ebC3lGSCam2NI3Ggnpjv/okQceoPXMhKTE5/i2ZopIx/e2JCpml+aChRvdH3zbs7sFM++TX8ABQAxOxKiRv5vm5aDJU3qy8sNBZoYgSlosELUztYLNva5XbfdQaB6HovTamIvLPPUH8i4kbUcqlTaPQ6SCiCqE8usvJOd8UbgsjOKwoLSWYfNBDWYpWvQNzuVuw8++Fu8pQaXwGlM73EaWUv4RhTqFyYt6YKBWcjrO7wkiomLWXTPBsRlLfiX2ytrYrfTSPl4OYfx2PEsT1ZyRehme33NG5nJw1H/EzYBS1PflAArvPHdI4Jvy9S3ha1tbaShGkBieEaFv3awiMJmo+DsFF7c9mE5l0OIcHwDHCcV5bTVyI6OWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(54906003)(2906002)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(235185007)(66946007)(66556008)(66476007)(38100700002)(86362001)(966005)(6512007)(478600001)(33656002)(6486002)(33964004)(41300700001)(36756003)(6506007)(26005)(53546011)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHFsNmlnaUpoV0dWdHNaUzVrSUhSdmVYWUVzb1k4Um9DMlU1cC9CS09ZUGJI?=
 =?utf-8?B?TWRjRTJYVW9SNGxvbUYxOEhpZHk5L2g5c2htKzFuYjNiQ2JuVDhDaXdILzhu?=
 =?utf-8?B?b3JUZWUzRzdZN3cwRGR5MWJadXhPK0JWamI1VUU2NmNxaUdQUmpidklMOG83?=
 =?utf-8?B?dFVpWUxpUUl4WFNkQUNwcVlCR0U4VWxEeTdXR3NNUHlIb21wZGlkQzYzRERl?=
 =?utf-8?B?ZlgrNWRTcTlmYlc2ai9pbTV0NmhDSW5LNElEYzc2V1VlZEVSeFd2N1pXaUxq?=
 =?utf-8?B?amEzWllTVG0wWStiMERqM25kL3ZjcHd6Q0x4TFNQeHREL1hlNkhkSnBCeFdx?=
 =?utf-8?B?T3QwN0hrOTNWOG9PYXJYOWlPK1hUaU9SenpseHNLY0VBZnJmbjk4cDJDYldJ?=
 =?utf-8?B?MDgyajdiTGkwSklYTTlkT2ptZEZ2Qm0zWE9jT2FnWjFrLzdmQ0pBU1NDT1BX?=
 =?utf-8?B?UHNjeTRON0hFUVdSRlg2NmZCRWVhQmxtdWFjOVpuK0VLempBUFh4VlF1Wldm?=
 =?utf-8?B?UFlFbEU0UUZSUm9KdVVWbHh0L0w5Tm1pbHovVHFPVnExRSs3NkJiRCtVZmhR?=
 =?utf-8?B?OEZ5QldGQnRnbmpPUnZMSUFyLzZRMGIrc0FKb2hhSzdZblVTdXpRSzlHYjYx?=
 =?utf-8?B?YkVmOUY1cHBuUmQ0M1JNbzVhYURmQVJ4aGdUUk1CYm5vb0NBQllBcGY3ZmNa?=
 =?utf-8?B?RFBZSXJDWHVWeWZrc2hVbVF3bUx2aDJGTG9pTUZHc0hYWHdFU1k0bDlsUFhz?=
 =?utf-8?B?alhKRUpGNWI4RG1LWFVQQnRjOUNhUURjVG8wZk1Fbm4zRXQxM1JpZjFDWjBD?=
 =?utf-8?B?NkRsQVFtL1pMRCt4R1JhRFN5NHBrb1NkT2Mza2tWbmt5eUlhbnJyS2NEVVlq?=
 =?utf-8?B?RERiNGFBVVBFZkNnZG83R3hpWjJyMzdIUHg5WFJZZm1VUU11a0R3ZEVJbEZ0?=
 =?utf-8?B?cHZKMmo5c1N6VHZBNnVQa1dTU1hLZTZtc1o2QnI1NUZDRk9GL2tHMTFBTGtz?=
 =?utf-8?B?Y3RSblBWQXZFYUEzekVNdjVkdE9TUERxVjN5cUlNVW5JU21LNW1Rd3U3c1A4?=
 =?utf-8?B?MGdRY1E3S0YvWDJOTVozVXRoVCtkcGNnTjRxOXJpdVl6NHlycXZMNnAzcGxM?=
 =?utf-8?B?d2cvMFM4bHc2ZVhiMXFRaEZRbVgwK1N4MFdsWXR0OGVvYzdmbXBOU2tsbllw?=
 =?utf-8?B?Y2QxcnFuTmxKVmlqMnJ6andlT1UxaHQzUVJGVVBYSXIwNmp2RnpUQkRJeEpX?=
 =?utf-8?B?Um0vaGtJbmp1OVg0SnI3dmthSEQwYjBneHBMQ0QyMXJCRFRHZ1pVNExreDJV?=
 =?utf-8?B?QnBkVERrRjFXcVMwYVN1Z2VHL01JTXRTZGUwb2tmWktYTDZjKzJLeDV6aGo0?=
 =?utf-8?B?Q0EvMWxlMGMwajJMQnFhR2piM2VHbUdTWXFSV0dYQlN0YXRZS0RWRTRaZDFl?=
 =?utf-8?B?WTZLS1Bsbkx5RmdJbnR2Y1JhdHZVa0hSc1BtZE1vWEpQcUNRVDlDVlBDY0ph?=
 =?utf-8?B?bTQ4U1BkclBGS3YyaDk3TUZzVjQwNUlYR0lFYVc2SHl3SFdnT3NkZ0VOc2ln?=
 =?utf-8?B?SGl0YS9NRXkzYldoQ1drR0dJazQzcis2N244dldlMDZ4eXNncGtFa2RtSkhQ?=
 =?utf-8?B?U2wrbnFpSlJRZ05CWWtpa3VkQ3d3R25zSU01emhZLzhpZ2NKR2pXU1huYUlQ?=
 =?utf-8?B?cUlrZ0VYMGRlV0xBMitmdUFjODhJWmJvaFhKakQ3c1JBUHd0dVMxS1NRTis1?=
 =?utf-8?B?bldOWHh5SmtYS2xjS00vKzFPZXBxSzlPYm1rSGtydzlnWklPSXl1V3IvenJL?=
 =?utf-8?B?Mlc0ZDdEeVY4UzhzcXhzdlRjVEhVVFhVVVZ3cjkwbkZMRXp3MERlUzJoWUVz?=
 =?utf-8?B?Z3k4ekdKSk9QUFFxSC9tZm9KR3VXWDY1YVNkMVhYT0QzMXZwU3g4TmVaWGdK?=
 =?utf-8?B?bXRObGJlUkpwQzZ0T0xOZUxCVWJqYml3SzNPay8zYklPdXI1cFRYYkF2UGZx?=
 =?utf-8?B?N3FIUDVSNGpBcHlBeGtmMWo2OXdHVGJLanRlbmQxUDZYNnVGQnZBbzcyT0pw?=
 =?utf-8?B?a3d2TXdxU000QVV1aEtHZEhtZzBPODZoV0FJd1k2T1N5Mm53RDlZVkxXUys5?=
 =?utf-8?Q?0qPk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ec2b6-bc99-4e65-2731-08db97768be0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 18:46:01.2980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V/gj0Ead8+o3WyfzjuHRlA461Db5PCRE+Cn6NwEtx2m6n9DAif2Jxok2CjkUF1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D1A869DF-D4D0-4CA6-8237-85B3F5D9848D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7 Aug 2023, at 8:20, Kefeng Wang wrote:

> Hi Zi Yan and Matthew and Naoya,
>
> On 2023/8/4 13:54, Kefeng Wang wrote:
>>
>>
>> On 2023/8/4 10:42, Zi Yan wrote:
>>> On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
>>>
>>>> On 2023/8/3 20:30, Matthew Wilcox wrote:
>>>>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>>>>
>
> ...
>
>>>>
>>>>
>>>> =C2=A0=C2=A0 if (PageHuge(page))=C2=A0 // page must be a hugetlb pag=
e
>>>> =C2=A0=C2=A0=C2=A0=C2=A0if (PageHead(page)) // page must be a head p=
age, not tail
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 isolate_hugetlb() // isolate the hugetlb page if head
>>>>
>>>> After using folio,
>>>>
>>>> =C2=A0=C2=A0 if (folio_test_hugetlb(folio)) // only check folio is h=
ugetlb or not
>>>>
>>>> I don't check the page is head or not, since the follow_page could
>>>> return a sub-page, so the check PageHead need be retained, right?
>>>
>>> Right. It will prevent the kernel from trying to isolate the same hug=
etlb page
>>> twice when two pages are in the same hugetlb folio. But looking at th=
e
>>> code, if you try to isolate an already-isolated hugetlb folio, isolat=
e_hugetlb()
>>> would return false, no error would show up. But it changes err value
>>> from -EACCES to -EBUSY and user will see a different page status than=
 before.
>>
>
> Before e66f17ff7177 ("mm/hugetlb: take page table lock in follow_huge_p=
md()")
> in v4.0, follow_page() will return NULL on tail page for Huagetlb page,=

> and move_pages() will return -ENOENT errno,but after that commit,
> -EACCES is returned, which not match the manual,
>
>>
>> When check man[1], the current -EACCES is not right, -EBUSY is not
>> precise but more suitable for this scenario,
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 -EACCES
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 The page is mapped by multiple processes and can be moved
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 only if MPOL_MF_MOVE_ALL is specified.
>>
>>  =C2=A0=C2=A0=C2=A0=C2=A0 -EBUSY The page is currently busy and cannot=
 be moved.=C2=A0 Try again
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 later.=C2=A0 This occurs if a page is undergoing I/O or another=

>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 kernel subsystem is holding a reference to the page.
>>  =C2=A0=C2=A0=C2=A0=C2=A0-ENOENT
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 The page is not present.
>>
>>>
>>> I wonder why we do not have follow_folio() and returns -ENOENT error =
pointer
>>> when addr points to a non head page. It would make this patch more fo=
lio if
>>> follow_folio() can be used in place of follow_page(). One caveat is t=
hat
>>> user will see -ENOENT instead of -EACCES after this change.
>>>
>>
>> -ENOENT is ok, but maybe the man need to be updated too.
>
> According to above analysis, -ENOENT is suitable when introduce the
> follow_folio(), but when THP migrate support is introduced by
> e8db67eb0ded ("mm: migrate: move_pages() supports thp migration") in
> v4.14, the tail page will be turned into head page and return -EBUSY,
>
> So should we unify errno(maybe use -ENOENT) about the tail page?
>
>
>>
>>
>>
>> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html

I think so. I think -EBUSY is more reasonable for tail pages. But there i=
s
some subtle difference between THP and hugetlb from current code:

For THP, compound_head() is used to get the head page for isolation, this=
 means
if user specifies a tail page address in move_pages(), the whole THP can =
be
migrated.

For hugetlb, only if user specifies the head page address of a hugetlb pa=
ge,
the hugetlb page will be migrated. Otherwise, an error would show up.

Cc Mike to help us clarify the expected behavior of hugetlb.

Hi Mike, what is the expected behavior, if a user tries to use move_pages=
()
to migrate a non head page of a hugetlb page?

--
Best Regards,
Yan, Zi

--=_MailMate_D1A869DF-D4D0-4CA6-8237-85B3F5D9848D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTRO+cPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUAE0P/149O0Wit/HL4Fo5mqNJlWR797qVstmIhuiu
wSKi8rZ3sBQKT5oaOIjmvCtKwO2ibvJsoOPXMY6OBvmXPaqfC2jNv//npuG7heZ0
IZ4qivf5+e8wl5BFPyYMjUanNaRvtIb86B9Qdq8UsmvlTEd4/H2BtJ9MCaLc4nH5
HC5tBEePcqYuRrGjWn9kAKHrsFJNUa52pqpNrPCHoa0P9mInONyp+v8MAZnpAlYd
fL6aOh9bmZusFTXhT23mlHtz3LXN9NrZvGWzaMne4riQ4FQwYsKpXK54XHSd+LpS
g1WoSOLS9tabfP5tZbh1Se5I98FgzZAPziWjgONYd5hb4jiULBR6FdDEwMuKtu9i
cfncM8OF0gwGtjxyOsVwX8lnmUwAXVnwGippPa4CMBfLmrE4+KadYkOqWynxme+U
Cl2DVtAL9xv6AWqbd1bG8itRUr0fF9BTE7s1Egzzd+WxWmD2Joc1o+FAypXKCFyn
io/5gNnIYLGquHt9kyPckGdD1qCzs3fjlEpFYAXc/prp392oz1Y9uTXTTZNG9ECm
i8qfg8CBaaDKty8zHQ+F0qOM+xqXwRqIfjh6Iqjv20vB2d2p0Ab7ZApFukKJpMD2
f3Lf/1Kitu7HtVCXIS12jsZ4TKPB4lXUWTqa+LQEF/l+Um4y9YbvUKLUav0d00ik
mGrku0bJ
=tggN
-----END PGP SIGNATURE-----

--=_MailMate_D1A869DF-D4D0-4CA6-8237-85B3F5D9848D_=--
