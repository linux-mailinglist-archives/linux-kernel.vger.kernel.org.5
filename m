Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5B765B38
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjG0SNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG0SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:13:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E500130D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:13:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RFOdBE014601;
        Thu, 27 Jul 2023 18:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=/WwfsCBEkyh+jwroQJbUfPpM6J5jeijcBUTA8u5dCF0=;
 b=InNbyf4KUve3gMedOnnjyr+26omw7oQ+svovqjF1vLXfOyLERTVKZaMS1Onhqh8bVY+m
 yDm552txzxGhQ2VTGeSxALJkcLusU5cOJBOwAxbxB3YMhZwQOR31XcXsoUojKGRiN0C0
 wEYs4W1+IXZPB+GJfgPyPE1LJKlugdyY9xACG/nP5PWJIl8ARrKd1gCppm5HF11je6QK
 B97bN+z0HhEN8zINyjBmrOinAzSaxoGsYrQGPNshK4LmCgtQE0XiY8mNOftmFA6Z2DgP
 nqmpVVDT24qlTq1U7XLO3jNoAk6l3G7v+jx+GwnK6CSXkMMDVohLvhNZcVDTNC1Ul9u7 Bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b2bd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 18:12:38 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36RHQHcw023011;
        Thu, 27 Jul 2023 18:12:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j7ykqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jul 2023 18:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAo0QTuk0tBL1lamPgsODgOvF2U3X5/0Oj7Jh7NE9m3gYabvo7MJfS+k3FRjutjb1ARHDUg74Sjd99zE8yM2UJJKJNs7l1NFGMa/+phxRvCXv9z8iweAAsGxutjqU7OdSj0mx42oVwiGZ1V8s9JE+ij6qfAWVEAwlu+nSu4GI6rlmx/UBUxm6TEg4tSnC36FobVrrm1r4/U+lNvWK+o5DiNaMrFV4X2FNoaiH6k+phrCwlkjOVFudxFT8yx6CLJO+gKe1nVPhDThnXVxdPHFpxQfnBH/x4isfYFxkDeduBczmIQ7/9PK8baj+bgdbKIFIelFIlzZ3fw/m0txEYRCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WwfsCBEkyh+jwroQJbUfPpM6J5jeijcBUTA8u5dCF0=;
 b=Y8QFEk5uNICY2cjZq8e17KX3WWPvSNj3L/MkhBI2CIkUIM+oLCkpfYEM6IPzVcM+0HY2Zr124PM1q2RycRvqU9FgZG3iDsMA6N8FZO2VKBWu4BXQMDM2Zv1P+SZXkPqVp9ntQReGT7xdUedqy4DV5PZAIUOrGMmmv8yF2AMhzOuuCNbUnk+5xAQQAJ48+US/uUgqnh+32VmSp0hDFnUJkjD0mUS9CDthkERiZi25yyrUEDfYvaC563XQaUkFFC4tWkatDdqgTxiQ1QAdJBVuOl0J/0oWNiJF7nsy0sUlFre6ooStyCjXX3wdbA42V1kJrfYeAJi1UdolZos75oe01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WwfsCBEkyh+jwroQJbUfPpM6J5jeijcBUTA8u5dCF0=;
 b=UmZh1NwEocPMs/8CIPdzaZ04Wpy+HIT5ZBcu//5Swlz40nCye20J/A0lhYihP1g2NOrrkb0uc9YbODWBOwaih8E/+c0E96QpDgG7R0dNzRsXR0qWzdjLkXSdILOadcY3k7rWYGIIAZb9KYx1/Xtx0KHCsyb7qH7HIYKjnoeWNGE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 18:12:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:12:34 +0000
Date:   Thu, 27 Jul 2023 14:12:31 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
Message-ID: <20230727181231.pjyxvn7yv2ytssy4@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
References: <000000000000607ff905ffc8e477@google.com>
 <0000000000000aeb7f06015e5cbd@google.com>
 <20230727164757.e2di75xjybxncohn@revolver>
 <CAJuCfpEyE18kbH84FfmfzUnar2dxgzpi=FOYPbU8MOpz-SbVjg@mail.gmail.com>
 <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAG48ez1yg7m=aNsjNiGt_s0_tEBEmEXXx0-vijuN9MBmoxL7PQ@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b011bf0-976c-4747-d01b-08db8ecd0d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWTL2AZMNJ1FAsP1O1ihxqDDbGMyXEy2HDX+tgczUFskjeAL7MltTf8a6S76ilkobHH90JW8y26OSDlPJxu5QMDO9h/8/DWbCqZwfmOyiVNLcVDs7xbvDWvwlEYjnrlcAPU3OtaWOVyJYuwlETvuO5P17zZNrCXB0YxGMxN8+ZDYqe/JkCPJLcO0QYxAy3afQz/5mtwMKk/HD6IyFbmanMxH/W4v06FJUAD0NZHZq+hskCO8ckappv3Fd4e9R6TXwePhRXEVitBTP1NnEw2cmzUnOQub/n1AKqTDK/dmMr0Ml6t/KWutDl0q3Rm5cqrDDQjb0uAGu09U32hTDirfxs+ECOp0fQ6n182leFo+vNFbM2qn01x+9QukgRxYEoLwvoeghY2bUWgWHccuwjiEosxRKhasLtmCr4WIdURZ1jgDtiIi7MDqE9BjQvM+HdVYsz+uU5u563BeWHyV5mox/SxO9LfwEAFs4u7wgZzjpap+UhkXC8rV+82uxNFsLsJnIWYQDFfY8PEzeCkaqpCuT5lTS+puIqmgYuHbtD1iHKoGOlTpXaujtEU0MzRm0i1zWw4UE4eaczkAtMGGHjvCetfkgac/AlqRa9gEgy+Dz4I3+uHc4heqHtH8rLbpcSxGBcTOH2rn9bib6Q+McCgw/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(54906003)(6666004)(966005)(38100700002)(6512007)(6486002)(9686003)(478600001)(8676002)(316002)(41300700001)(6916009)(4326008)(66556008)(66946007)(8936002)(66476007)(5660300002)(186003)(83380400001)(26005)(1076003)(6506007)(53546011)(86362001)(33716001)(2906002)(99710200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2VTMmZyS25CUGN4Y1NZZERjckVwelJmaHFuWDBVUjFqUDYrWkJSK1hSYlkw?=
 =?utf-8?B?VzdsQTJBZmpTMlYvUktvY0J2WXl0ckc0U1R5N1NGOG40ckJaNVRuN1dxTkNw?=
 =?utf-8?B?N1pKZVMwbHdwd3k3Vm9YR0g4K2VtVFJaSFZsK2ZvNDQ1V1Y0TkxKSzBua2dL?=
 =?utf-8?B?NWViWWs5ZFFCR0M4cW9BKzBQc2pXMExtdi9GZXluNmY2M2NRekMzZWZQY0xN?=
 =?utf-8?B?Y1NSaWdaZjluSVlBcTlpRDhnSnJpUC8rS0UwaWhxR1grZW9aWW5PbW9Bbk0r?=
 =?utf-8?B?VFJMcTh4Q2RnSXBqZlZHSEdsRzNXeUFObnBpL0NCYlNLVmU2VGNLTTZWcEVX?=
 =?utf-8?B?K1NnZmNvWjdlSkhCd1RweVdLZVdHTUVwR0hGbVNxMzdlTWNmVDc4elRBY2ZB?=
 =?utf-8?B?TjRwRytHR1VMNE9lK3hCb1ZpZzZUYWcyMU01M3VkN2NGaGd1NHF3Qmw2VlZ6?=
 =?utf-8?B?aFVlME9PR0k1eENVRTZtQ0hWaHlCZE16MEhkODZNcVBuaXlIakpiRjdLTG5L?=
 =?utf-8?B?Yms1b3BQVVdMWVoxZDFNWXBmZXMxNlZSU253RkJTTHB4bkRiUlZnMXhPVGly?=
 =?utf-8?B?elRXaTN6amw2Q0dUR1A0cW5EV3NBUVowdHJKNGg1YVpEU1RRSHlOc215eHUz?=
 =?utf-8?B?ejFMeWFGZ1R5YmoxbVJXZUMwRHNBWVp4K1h4SW9OYUV2Zm1aQmlwa1ZlZU51?=
 =?utf-8?B?ZCtIUVZta0ZjdGF4bW1TKzBveDJ3SHdkb3JUSkFDOFd6SlluaTZwN1pJc1li?=
 =?utf-8?B?S25RVnVSWisxeVQ2ZUJ4NzYrbldwL0hUMmVheXBCUjU2TlNKV0N6NmlqRWRP?=
 =?utf-8?B?S1huT2tKRmZjL3VFUWtXdjZsS1NoZGhGSlRGMFMyZFJjQjJ4YWh3N2R0clFQ?=
 =?utf-8?B?R0RYckYwY2JKVTFMS3FWelU4QkNYVXRHSzh0ZlFxcHU0Y1JHem1UR2hLZTFi?=
 =?utf-8?B?M2F5OVVXdXpKK0hnVjB3MkQ5ZG9MV0hkbVhpelZ2ZjlOK2kzL2NCWk9ja3FU?=
 =?utf-8?B?M1BvdFNER0ZPZEl6a0tBY1N3ZFFpWCtlWjlSdTZUNW1GTndkUHZmcHAxM1ZI?=
 =?utf-8?B?amtrN3dXaGFXcXRuYnFvaExialpZVzBkaFVCT0ZOVTQ3dlBWd3JDanJ4Vnkw?=
 =?utf-8?B?MHhyRzdwcnNmd1R1TUR2YWdJNU0rQnlJbUtWd3ZtNTVjcG9RQ0w4Zys2Mk9a?=
 =?utf-8?B?TmtTN0V2M3IwN0hLQWlzRGJqM2dZT3kzc3RMWUM4Uy9neGFLditIMk50M1F3?=
 =?utf-8?B?dExhblFDNHFXUVJ5TTlrbHlIR0VIUmhuV2gxVjZiSGFzZUhYSWYyQzA2a2Yy?=
 =?utf-8?B?aDYweldBclNBTEptYnAvK2JvOURyK3dFaVd3QUFhU0dIRG5ud2hkMUo4T1pt?=
 =?utf-8?B?bUJaMDhLZ1d0Z245aTlkeW9ldXA3eC85UFQzOW9qd1Z4YXl4MHFZbDJMVVJr?=
 =?utf-8?B?MGsxK3RVNHkreEFiRG4yZU5xYURjdUxZT2VJL28xd3BtTkFSSjgrSXBKMS85?=
 =?utf-8?B?TEhpNENrV0s5WnVaQ3d4eFJtVkRIaDZiWE9oaEZvZ1dsNUw5TEZvZjlXa25U?=
 =?utf-8?B?UUNKMFBGWGFiWnRXcEgvUk1QV3htRVNoR3U3SDZlSFRHZWZjTkxZUjRBZXU3?=
 =?utf-8?B?a2N2UFJlalNRUGt3QkN1NVdsMDZFVkhDQ1V1ZW14WVRxVWJzZXdzK2tVdzVH?=
 =?utf-8?B?RHd5Y1lVa1paOEVkWkRMYUs3bG5Melp4a2UwUmQza1ByUThvVkZSbUlNTWh0?=
 =?utf-8?B?bVJkRTE3RlZ1b1lkaGVzR1J5NzlrOWxCMk4rRjZ0NEpLN0lCKzduK1V3M0t5?=
 =?utf-8?B?dUkwL0pBeUtSd2lzd1NkcmZHVzJ2eGRqSW13UTd2MzJ2VlZkL2tQOHBLcThj?=
 =?utf-8?B?Rm9xQkJmL3VXd0VJTzVrbkMrWS9YQU9kNi9pa2tpd2FxeUU4bE8zMHdQSkdt?=
 =?utf-8?B?blZseVdLQlFxSmhzNjd2eG9XaEVnYlZlN0NNSktaVUVWV3ltMUt4ZmxwVGdB?=
 =?utf-8?B?aVVybDNuRmNudlhrTlE4VGFvWXFNdW1RcFZSUVp1cmVtU3VGWXRVYnB4anQz?=
 =?utf-8?B?WUlvVXcyaXpiZDlCMURnVE8xWWt4RGZNTzZDWElzT1pQTmVDelVJc1BXL0FV?=
 =?utf-8?B?TmIzb0ZYSVllSVFFNWUybFFac1FZeEZLSXFJdU1jUTExYUFXK2l2QlFFQXgx?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?azNXU0VoZThNTGY1MU1ieFFSQk5Cd2dSU2VVYWk2NUZ4QkViaGY5Vytmc1Bp?=
 =?utf-8?B?aDhKOVFYZnlCQTljYW1FVW9uclJqTkVHTUswcnpmN0RPYUtkUWlLWitYZFlS?=
 =?utf-8?B?K2QwbUxvdlYxMFJVNXkwbzhxWHAzdnJaN21lOXhnTTkvbS9KZUFGa29mSFBw?=
 =?utf-8?B?aGhHMHprN1RaVnNBWnZJaFRYdG5uTmRSOTNWVWMxWm1FSmVmMHNRaDl4aGV0?=
 =?utf-8?B?RnNJMEJFTkU4V1hnVjlwcXJGVkxvLzcxbVlqWWdVbzV6UUxHR05PMnU2bUFz?=
 =?utf-8?B?VGNrb1hnYVZRUU1VT3VYZkVrc3gyZ0FDbHRoUWNzbUYvMGhsdkJ4T1BJbVVI?=
 =?utf-8?B?b2R6UXRzMzJYY0I4RlQ2VXBKcjNCaHhXT3VETGl3UjJwaHB4YmNMQzhLQjJD?=
 =?utf-8?B?SVYrcFRJTjJuSUVBRCs5SU9pdUk3TmozQ0pxT3F4SS85WEtQemlVZm5KK2NN?=
 =?utf-8?B?WExnYnczVWZ3bFNYMEpubnBoei9WRStBUFErQ0JmYXBjck96ajVHKzIvSzZj?=
 =?utf-8?B?Ly9iWTZzUXhTdzA0eXg4cnB0RnZvUER3RVJROGkwWEprMVU3L3M1d0toS3dV?=
 =?utf-8?B?TkhlYmFxVmxZQ3ZhTzEvUWpyL3owVVpQQmlKUjNHVjRTNWlwM3lUREU4TXJy?=
 =?utf-8?B?N21pVFptckhrN2V5cnJzTHBUTmQ0N3pwUXpmeWZ2aW1LUi96NUcwVUNjVlNJ?=
 =?utf-8?B?NGF5R0JsaU5UQ0ptbk1rSnVpdEdPYTV4bEJBNWgrRzErWVhvN3ROeHJyWGtL?=
 =?utf-8?B?TlFaelJLRms5UnV4UmdkUzk2a2VZUWFsSkxiZVI3VnRhVndldHBtU1NkZzlN?=
 =?utf-8?B?WXlYWHZKcWtzUkU1SVRuaXB0dHM1dlFuV3pnbndHMEQ1aWt2OThRTXhxNktL?=
 =?utf-8?B?bDQwSlFyQlFac1lySjJncE5KbWhSR0FtRGliV1E3Y0p3SDZsc1JjT2FSSGdS?=
 =?utf-8?B?TFZ2akhIZHhtNURpZWRFRGR3alR0RE1hS2dLT05lUDVqUE1naEhvTnZUeWRU?=
 =?utf-8?B?UVFJZ1E3Zkc2T0Z3R21XS0xqVXhwU0JpMmhja0RwSlVVbDhESnRMYnJHei8v?=
 =?utf-8?B?NjRYck1GUVRFSW1KZXNGZ0RmSktUZkF1WENMbDlvc3JKK3ZIQ3dFMEV4Mkxi?=
 =?utf-8?B?RGkwTEdiMTV0YXNCcCtvSThUbDZTUllGQWdGYzl6eGJ6YUE3MVpocnFaTmIy?=
 =?utf-8?B?cEtMcEh3QTA2RUR6amZqNlZ6ZGsyOUd5MnVtRVpibGF1NksvOVVoM0thRXNS?=
 =?utf-8?B?S1IxK1Z2aVlhc0VueDVNcVdZbDEwT3NQazhJMnFXdS81QkFRdkd5K2g1ZFo4?=
 =?utf-8?B?V3dCR2NZS1hDb1VOWTVNMGRNakkzVHNXRG16Mi8xYnEzaHhZeVI1NWY0UjFH?=
 =?utf-8?B?OFVIR1NrR25IK0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b011bf0-976c-4747-d01b-08db8ecd0d69
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:12:34.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEf4u5PP2fL9ZiLQIuIVHv2OZFAyApLUoVYdeldRLeu6IbCY8E9blllIBu7r/0U0hN9pHJ1kMvspcudEpEDBAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=550
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307270164
X-Proofpoint-GUID: kBHbPGxFKYFtIQsyd5TKXWyDNK1F7d3G
X-Proofpoint-ORIG-GUID: kBHbPGxFKYFtIQsyd5TKXWyDNK1F7d3G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [230727 14:00]:
> On Thu, Jul 27, 2023 at 7:22=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> > On Thu, Jul 27, 2023 at 9:48=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com> [230=
726 02:57]:
> > > > syzbot has bisected this issue to:
> > > >
> > > > commit a52f58b34afe095ebc5823684eb264404dad6f7b
> > > > Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Date:   Mon Jul 24 18:54:10 2023 +0000
> > > >
> > > >     mm: handle faults that merely update the accessed bit under the=
 VMA lock
> > > >
> > > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1783=
585ea80000
> > > > start commit:   [unknown]
> > > > git tree:       linux-next
> > > > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1443=
585ea80000
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1043585=
ea80000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df481ab3=
6ce878b84
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D8645fe63c=
4d22c8d27b8
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1697c=
ec9a80000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1566986=
ea80000
> > > >
> > > > Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com
> > > > Fixes: a52f58b34afe ("mm: handle faults that merely update the acce=
ssed bit under the VMA lock")
> > > >
> > > > For information about bisection process see: https://goo.gl/tpsmEJ#=
bisection
> > >
> > > This is caused by walking the maple tree without holding the mmap or =
rcu
> > > read lock when per-vma locking is used for the page fault.
> > >
> > > We could wrap the find_mergeable_anon_vma() walk with an rcu read loc=
k,
> > > but I am unsure if that's the correct way to handle this as the anon_=
vma
> > > lock is taken later in __anon_vma_prepare().  Note that the anon_vma
> > > lock is per-anon_vma, so we cannot just relocate that lock.
> >
> > Hmm. lock_vma_under_rcu() specifically checks for vma->anon_vma=3D=3DNU=
LL
> > condition (see [1]) to avoid going into find_mergeable_anon_vma() (a
> > check inside anon_vma_prepare() should prevent that). So, it should
> > fall back to mmap_lock'ing.
>=20
> This syzkaller report applies to a tree with Willy's in-progress patch
> series, where lock_vma_under_rcu() only checks for vma->anon_vma if
> vma_is_anonymous() is true - it permits private non-anonymous VMAs
> (which require an anon_vma for handling write faults)  even if they
> don't have an anon_vma.
>=20
> The commit bisected by syzkaller
> (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/comm=
it/?id=3Da52f58b34afe095ebc5823684eb264404dad6f7b)
> removes the vma_is_anonymous() check in handle_pte_fault(), so it lets
> us reach do_wp_page() with a non-anonymous private VMA without
> anon_vma, even though that requires allocation of an anon_vma.
>=20
> So I think this is pretty clearly an issue with Willy's in-progress
> patch series that syzkaller blamed correctly.
>=20

Thanks for the analysis and quick response Jann and Suren.

I'll stop digging now.

Regards,
Liam
