Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194975A35A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGTAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGTAVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:21:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9932722
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:20:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOLS2029558;
        Thu, 20 Jul 2023 00:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=amRYQOnVWk8/XWWJhyaKfynG2rYzg1Vb9/8GcMrqMtA=;
 b=bZa+5vgJYZzqT7K1rHjkQT/zC1KZCu2cjr8hB467TmuKwpl8fCgd7WNDmD6uvMz8KIud
 GkfONkWHDTWxU+cnhsknX0NmPDrx58Ik7NcAPZzw3/zoz/7ppIxxS/eicDy5BJPr+sGw
 bu+LEEOFTC/U3wGnyZgdZtPVkWA03DB+0WKXooSaSfi+FyYqcdllOnwCFFgc02f+jbGo
 /PLcuG5VjO5vysAbb4Cd6GCDhHyJKBESg+kx+dm1prMxI1TKiTczzCmK41l2uQr+7ZLV
 KcqUuSQeXpOPZjyH97ix5PrQC1VSMSyDz8PS6CxHvjhqWNgJUMl5Ro9HeY1tHnQrR9ku 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88rr35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 00:18:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K01684000774;
        Thu, 20 Jul 2023 00:18:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7r92y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 00:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJgnAVm/8r5y5XoW20QSmODZOKtAck1UTlrMAChzYMOys1C7bZii7S46E1jMFGlPONWWP3VGskLbsEu9yPathe7d3y+VG9+Njm9uY0SPR2VpfOu/IIEZy6k0KQGB6L4F+5Gm1YCCV1zuAlpp5yCJHe5GPjIEIPGrJ2SKAZhVJwmahABWg60AT4e7f0Qe08SzEzEFpTuQ2elp3BnHjTVt42TQp6GC2abcBwkHOYETK2D96n26DEgRwUUhx8Kb66WePs85AsEC1mkE1uzcf1Qa9qjw88nMaSPdMEYUJ5eSuDZQ29KrRQnF3ypG+hDNasgwplURKNSdfzHlScB0DCw3/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amRYQOnVWk8/XWWJhyaKfynG2rYzg1Vb9/8GcMrqMtA=;
 b=XfToCvY+tzUDtXfLIwBuDzi2rwTtVZ6ZoButZZpnI6pP8RY+d7Ca4CQWhhYkJDmCRh2e3KlFIm56VnaRyK20spQfpUCALRiQvi/2zQA42GQO33ZtqKyXIpYVsxal7gP+DAxqubGgPagvvlHmY7aTwfb/vuGSVJzSFh8KwgQkQdiQapPYsTetmREoyzTnQh3Zxo+qneZE60Hh1Wr7AWEPwWToqSG3PBPTmXmr88IRgpUnSHRi53zCj/SXTEpERwmCpixqebOL/86Npt9i7+QJvti2xv29evMoKrc8eT9CYQSMNhTt69o7m3YzO1rgp6XbCsNFmk5dc4oNTRqGdSdBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amRYQOnVWk8/XWWJhyaKfynG2rYzg1Vb9/8GcMrqMtA=;
 b=XFBRMBlfxpsEly6EeTzEOTtIlLxAEH/n7DO4crq139xcMj0lXn+Qn02U0BaemNTwyHoKcNyXKyXiYt8N6SuWLbzP9FyKjRJj+JMqDKsiut8mxx/aTbDRO6MWDCQSFxt8rHg1ifBjtxdUuFzxztoR13mxvkkQUS4Ze7SMF7AM+2Q=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7139.namprd10.prod.outlook.com (2603:10b6:610:127::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Thu, 20 Jul
 2023 00:18:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Thu, 20 Jul 2023
 00:18:36 +0000
Date:   Wed, 19 Jul 2023 17:18:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] hugetlb: optimize update_and_free_pages_bulk to
 avoid lock cycles
Message-ID: <20230720001833.GE3240@monkey>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
 <20230718004942.113174-3-mike.kravetz@oracle.com>
 <CADrL8HVfBCmNYL5pM_LyHQNWyvihK=_GFnbtWB0tpTuLgiDybw@mail.gmail.com>
 <20230718164646.GA10413@monkey>
 <CADrL8HU9QbtU=Rs7jCVgOw-ykv1DTQukBiZwqVi16dVdcadG0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HU9QbtU=Rs7jCVgOw-ykv1DTQukBiZwqVi16dVdcadG0A@mail.gmail.com>
X-ClientProxiedBy: MW2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:907::26)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e9ce07-e53d-49b8-fe15-08db88b6dc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WXgveZvQclWsLGKZSFAV3wHIbdneA81I0ZMlerE+t4HzsMCt8De+nnwErSY34aQh/NX2NkAmVZ8H21izs7DbF+gi50DC+BZw0Gb2FWnAWywLI3VsMVhOm9cHpnc+GQwgNhVOjFliNPJoJFYAo+HDlC08oq4swmM7f7TqTIy+Cgn5rF3Suwk/vvj4UmC75i1IFJcsncFw6lAapb7JChroZDwPYchvnJVPHAmYUHx3KaOyMNH34uWfgX3/l/Gy5rStYyatQxgHCCyxIOdxeK0IBE73FghTy2+lWjUXuJK8v6JokcPhUnS2OuQ0KrIWyLaQ8eTa4rRYPHMkwhJXdCce98TE7EC9VSeRg+NA7jqDn7kXbF1EFrb2SKAYStSSDK8OsduDKXUv5RzYbZePBPUnPNZ+x00iS3x6ZsxAg8wa/SzV4/SJX0x//LSLiJlB/LwKfbzV0Aw27g0tFomn8YlrSa1zJkh+yhL+kJ5jQ5MxcW7zzXd/5yvaZ3lmpA2Khdzh77oAjKediNDMeJ0YCOyVBnq6V19TN4t2U+2Re+paBYMTxlNM2TwLDrDefRnpUAv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(54906003)(478600001)(6666004)(6486002)(6506007)(26005)(6512007)(186003)(2906002)(53546011)(1076003)(33716001)(66946007)(9686003)(5660300002)(41300700001)(316002)(4326008)(8676002)(8936002)(66556008)(7416002)(66476007)(6916009)(38100700002)(86362001)(33656002)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRRRkVpWWNWaSt3SDlTVy85NUE4blpkZ291OEhDZXRURjBtU0RjWHFzNW5q?=
 =?utf-8?B?VWpaa3o0U3NOcHIvcHhSdlJTSnc4ajdrdEFwVmhieFFwaVRpeXBSVDRyVElk?=
 =?utf-8?B?VDc0K3Y5ekQ0Sm1PRUs3Mis4VmRQaU85Ri9ZZWZHMjEzUnAyU3NJcjlUcTl1?=
 =?utf-8?B?TnJHMDhrQXpISE5TNjVBTlJacWFrL3JGU1l5eVJZUVNrSUYzdXN1Z1hvNE41?=
 =?utf-8?B?bjRleFRkSmFsOHpOTXZpTFNXWm9LZExKNFVDYzRFTUpUeFNmTE9zQkZjM3Fz?=
 =?utf-8?B?SldqaU8zeCtSTlZPcTB3dDNxUzRTQVdyMkloUGhjNFFldEtQRE90c1RJNldO?=
 =?utf-8?B?UTNibDFmeWg5T2w3Ri9tQzdtZ3FtSW10MWVZYmQyK1NEbjVVMSt3Nno1czBV?=
 =?utf-8?B?OE9Rd2lCNXZKOGM3aEtJS1UwTWM2eWJ4UTc5MVFYTkZmSE9kbGwvalNYMG1l?=
 =?utf-8?B?WisvRUNpNGRaWmtXWmlpQ2FuOWI3eHFscHdheGFOYXZKTjhvWFBpOXg1TWF5?=
 =?utf-8?B?VWgxaEVmRi82Ylp3bXk4eHdZdXdSc29ybGFvaVBrS3JxKytwLzNHM2J4MFVJ?=
 =?utf-8?B?bjM5MUlYVktrYStLc0VUQ1BzYmJ6WHRCc21Id2N6Z29DOXJKbmJWUm96K254?=
 =?utf-8?B?eXF0ZzJFUGtvVlBGT1RmSG5yR2dFMkRReTA2cU16eVNDMmgzZkovVndCRU9E?=
 =?utf-8?B?eVZiT1JkOGpKenpNb0xrUXVBVm9VRHpwN0dQL1VmZ0xWSEI2ZEF5SnhiTHlD?=
 =?utf-8?B?ajF4TUxwcFROSHRYazhlS3VvOHBtaC9KTXQ4SFJoKzVIbnI2bVlSMmhIMlhH?=
 =?utf-8?B?RXdJb1BsTFBtbTdRMENiSE5WSTJFb0tXM3JQMTdlZDJxSzNIQjRpL2JjUlhM?=
 =?utf-8?B?NTg3VGd0b1VpeGtjb2hQeUpqL2QyU0dvSUg4NURzZmFsMlo2MUFKNDVYNldL?=
 =?utf-8?B?VUZKdGtrWldFVzlLUmxjZEdITndZOUdIa0tvb01VQ2dZNkdLbE5Fdmd4TGJE?=
 =?utf-8?B?L1ZZREFncXV2TUhPODFpZzZ1UHY2Zm9wSzNRQWRhYkswSnBLdDhKRlFHQmM0?=
 =?utf-8?B?OHVBWDBBWFJZbmZTVUhzU05pVzF2N3pwdDVPZUY5eStyQzQrUkJicEdYWWVL?=
 =?utf-8?B?L0tkTjZDMXFFazFva1I4dWRDZzZSaEV1dTNiUGE0ZUQwdk9aZEFqTGhza1I3?=
 =?utf-8?B?bkJmWVcxT0RVdHplek94STlFUkdTT0k3K1RKVTlRQmxOQm9tUnEzL3ZIQ3hv?=
 =?utf-8?B?N2tHRUxNMmtoRFlCYndEdDF5eDdXdXovWWIrcC9aQWF5dEhxK1RKTEFWMStE?=
 =?utf-8?B?QzIrT3E1TEFZWWVhRWIrbGlJTkx4TlRhdUtINzJsWHVsMEtFQm9iV0drbTU3?=
 =?utf-8?B?WG03am4zaEFkTlh4VXVheVo2UnhwK3ZXWHdjQVIrQjBPMENDa2RzSkxtaExB?=
 =?utf-8?B?ektVL1dEdzVhSHBqUE9GRVZSM1ZoeUlLOU1nRU9EUHA1U2ZiTXBERFIydHhs?=
 =?utf-8?B?eFdUM1BOVVM4MkJscDNhTy82WXRjTnBVTE9ERjJEamtIYVB3clRLV0MwMFRr?=
 =?utf-8?B?NmFHbTJNK0k3TG4zKzRHS3dyajcwNnpDTTZxWE1mTmtZT1NHcXFNTXc2bUoz?=
 =?utf-8?B?TXRKQ1dzNCsvOHFoT2xaeXQyZVgvSlpZVWVIZ3AvaHlJNFpOY0VoTGxKaDJi?=
 =?utf-8?B?bzdqREZvNkd1bTBWTkxwM29ybkdueVppUVFHVHdudytvWlZCYjhnRjNLTGJ4?=
 =?utf-8?B?aGdudWgxRmp6bm5QYmRNdk93TTcrZitjV2JMSzRYOEJKbGNNSTc4cTUyYnBY?=
 =?utf-8?B?eW1qcDB2bGZMaVJmcUhDU1F5SGxPVk90U21RRDVnY2RnckRpV2NmUVVsd095?=
 =?utf-8?B?RDRKblJsK3pGZ3FMMGc2SG00SThSYmZ0bGROZ2N4cmhKMDQrbE5pUm5ET0xC?=
 =?utf-8?B?NVM5STFVYkNwSzRsMUtyOTBhY0IyYU0vekRGOEp5YmlINXdkNFhRUlZhNkJ3?=
 =?utf-8?B?WHN3RERDNytjM3VqK0Q5QllDSTUwVU5kLzNWVmVBWW1hblp5d0J6MElCMnBx?=
 =?utf-8?B?RlBsazZGWkdEbWJ3aFdFS3BSMy9JcFdQU0ZpS3hyeStnVXVPUlkva3M5YURM?=
 =?utf-8?B?OFlQSERGZ1kyQkRoVEp2dmxCMWZTT29qSExIeE1BYXBUZFB2VXhxQU9seU5H?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RzQ3NWNmSHV0WWJrdGFaWnZpS2YrenRDRGQwZDRucDJHWTM5NWx2S3RXQUhI?=
 =?utf-8?B?ZGhDRHlvWit6RldCaHFRTWdGMWVsRWpDVWRlT3d2Y25rQVNEM2NPN3dpeDFu?=
 =?utf-8?B?Z2FMMDg5UWNvNXRJMGwvMWRKNkZDREJxYkswZGovQXhRVkFtRVBSRExwcllU?=
 =?utf-8?B?L2JFaVc1Mk9vMnhMcVJCemovWVQ2OEJLaFdLOG1TTUZrZmhGYS9hcFRJT0Vw?=
 =?utf-8?B?UFBlOCttWW1jdGdMQ1NYOWV4N1NaMDhXVG44aXRnTElpeEs0azZPSjI3Tk10?=
 =?utf-8?B?N3lpNDVrZTFtaU5uZm5qcGlIQnExMW1ZQjBwZzFPRTQ3a0FTNXAwTW1mbG5y?=
 =?utf-8?B?ZEhvUmZ0R3hiUDdWSWo0ZWcwQUZVengweHdwZFg0aU9IRFk0T1ZaWFdDb1Ns?=
 =?utf-8?B?VnJ6MjFuV0ExTW9DdWs1TitGaTJmbC9yOEYzRWdnNmpSM1FEM2k4N3VHK09m?=
 =?utf-8?B?NDE0TmRzcllrVEhaaDk3UnlJSW9qNkxaZnZVOVF3ZmY5UHZTMm5rV3NTRHJL?=
 =?utf-8?B?NkJCanpTaXhpOU04V0d1WGV0T0Q2UXU4SVNiUldDZW93RUk5M2RkWm1ScURp?=
 =?utf-8?B?Tmhpa3JMUkdqd3R3aXBRL2xyakc5SmdhaFAxMkFiNGplblBDNlR3bnRaT1Ew?=
 =?utf-8?B?VUZxblU4RXB0b1pxYUlydU9IQjlyemdxd01VbjN1K1R3M0QzbjhNK256Wjht?=
 =?utf-8?B?OE9mY2xteFJBdThuTTFVLzFNdVRuSU1ZdWE3S1I5YXlpdnRFNHJMWTB2THd6?=
 =?utf-8?B?ZGlsejhrK2J6ektKa3U0azJ6OFFSVnVsY0J3QkJKSDlKQmJvV05lWlBrVHZ4?=
 =?utf-8?B?R2JiTUFVSkhXOXhCRXlHVU9kd0Vmd1YwakpEWEU5dDJMbnhmcnNxUHRCMVA4?=
 =?utf-8?B?cWFGVjlESC93SU1oUWxkZWpqekRFSTM4ekV1aWNpUTZ2OVRMNkN3aDkyYW1I?=
 =?utf-8?B?MlFWcklrS0hwV0Urd1BscllHMURpKzBRM2J3b2ZJM1VNdzNaa3psQ29Fc254?=
 =?utf-8?B?VnpQbjFEbStrRzg0N0duREt5UUl1M3ZwSVpWdTh2Myt1SW5JRUIyekpOMGli?=
 =?utf-8?B?aUtubkwrQTJ6QTVsdkJGREZUZ0Q4QzlhUDdmV1VZT3hkcVBZbk5BV3M4Z1pu?=
 =?utf-8?B?MVpOZUdZQTdiU1VoTUxvMkM3UXF0RGtycFFHZkdaaXc0dXJlNlNQeXVlT2hm?=
 =?utf-8?B?Uzd5K3dhN0FZckg1eSs4YU9UZnNKWXQ3VzVtSUlQSk0wcUVXZ3VueGx4NUpr?=
 =?utf-8?B?TGo0VTBCeFZuRGJob1NWNU11S2k4U04zdmZCQmpucUhEL2R0TFV1dUVwbFdW?=
 =?utf-8?Q?Foa0e6ueVXmeB62cJz3l/cTraAPL7z/NJY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e9ce07-e53d-49b8-fe15-08db88b6dc0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:18:36.1669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyeWXlWv5ecVSTnl15j6L8TYJjy7+xAo8NdwdQXqqEdiHm1G9b9M/AW78zReFL/xRPflWm/MrBiito2/2XhVaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200001
X-Proofpoint-GUID: n0FM_Q80cqXYIBVP2fFrjuGMnEig8Zb6
X-Proofpoint-ORIG-GUID: n0FM_Q80cqXYIBVP2fFrjuGMnEig8Zb6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/23 17:02, James Houghton wrote:
> On Tue, Jul 18, 2023 at 9:47 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > On 07/18/23 09:31, James Houghton wrote:
> > > On Mon, Jul 17, 2023 at 5:50 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > +        * destructor of all pages on list.
> > > > +        */
> > > > +       if (clear_dtor) {
> > > > +               spin_lock_irq(&hugetlb_lock);
> > > > +               list_for_each_entry(page, list, lru)
> > > > +                       __clear_hugetlb_destructor(h, page_folio(page));
> > > > +               spin_unlock_irq(&hugetlb_lock);
> > > >         }
> > >
> > > I'm not too familiar with this code, but the above block seems weird
> > > to me. If we successfully allocated the vmemmap for *any* folio, we
> > > clear the hugetlb destructor for all the folios? I feel like we should
> > > only be clearing the hugetlb destructor for all folios if the vmemmap
> > > allocation succeeded for *all* folios. If the code is functionally
> > > correct as is, I'm a little bit confused why we need `clear_dtor`; it
> > > seems like this function doesn't really need it. (I could have some
> > > huge misunderstanding here.)
> > >
> >
> > Yes, it is a bit strange.
> >
> > I was thinking this has to also handle the case where hugetlb vmemmap
> > optimization is off system wide.  In that case, clear_dtor would never
> > be set and there is no sense in ever walking the list and calling
> > __clear_hugetlb_destructor() would would be a NOOP in this case.  Think
> > of the case where there are TBs of hugetlb pages.
> >
> > That is one of the reasons I made __clear_hugetlb_destructor() check
> > for the need to modify the destructor.  The other reason is in the
> > dissolve_free_huge_page() code path where we allocate vmemmap.  I
> > suppose, there could be an explicit call to __clear_hugetlb_destructor()
> > in dissolve_free_huge_page.  But, I thought it might be better if
> > we just handled both cases here.
> >
> > My thinking is that the clear_dtor boolean would tell us if vmemmap was
> > restored for ANY hugetlb page.  I am aware that just because vmemmap was
> > allocated for one page, does not mean that it was allocated for others.
> > However, in the common case where hugetlb vmemmap optimization is on
> > system wide, we would have allocated vmemmap for all pages on the list
> > and would need to clear the destructor for them all.
> >
> > So, clear_dtor is really just an optimization for the
> > hugetlb_free_vmemmap=off case.  Perhaps that is just over thinking and
> > not a useful miro-optimization.
> 
> Ok I think I understand; I think the micro-optimization is fine to
> add. But I think there's still a bug here:
> 
> If we have two vmemmap-optimized hugetlb pages and restoring the page
> structs for one of them fails, that page will end up with the
> incorrect dtor (add_hugetlb_folio will set it properly, but then we
> clear it afterwards because clear_dtor was set).
> 
> What do you think?

add_hugetlb_folio() will call enqueue_hugetlb_folio() which will move
the  folio from the existing list we are processing to the hugetlb free
list.  Therefore, the page for which we could not restore vmemmap is not
on the list for that 'if (clear_dtor)' block of code.

-- 
Mike Kravetz
