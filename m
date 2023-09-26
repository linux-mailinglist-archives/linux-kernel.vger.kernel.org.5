Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629CA7AEECB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjIZOz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjIZOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:55:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ABDE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:55:50 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38QEhwLl020500;
        Tue, 26 Sep 2023 14:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RiUXppu1+5Yngydlcha4x8gXW1Cydv8umTCepXYkfJw=;
 b=tCtp3UGTtCXCyxIKAqvlZZ7547YK7XcU3EzwDYFZkdpNDn9D7KGEx+9r/SlY148S8gMb
 FVIf83REE1uWzlP5sEK6W4CQGWEhKe/irgxT1WNvTwKM9GHshXfbMb11bqbFXhPaCcG2
 eEvjGbIFMxJt28OjTdjuI4Tz2CxnqsxhPswzK9jC1aovwm2JwZOgXKHX+pE5CisxMoID
 9oKX0ImMMxdgBOB3DCVSuCxfi/CNadgtPYFlvYYSAYHjQl3rD+4aMPqw7XqoADRlvOJN
 nNLhnby1bIccmqWfo8HKd2+tcZFC96bi+NrQDFZi4N4tqSs4WVr0u5KmpwW2w4abwWz4 tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3ptda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 14:55:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38QEoIVh034957;
        Tue, 26 Sep 2023 14:55:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf6ffms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Sep 2023 14:55:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDia3lczJYw1P6pO1WO8kMdAhyz9kzIyuddNx6L9byKb4Blofsk/S32T/1f/UTURiEn7MRGG+bOHcMgrg95ROegCmcDyfeGiIB1u00CKSxcCLrXw7tVEXqDe74tkNBGTs0i2yMV2IKETx0517GfKiiyFe2PKlfcwr87nt4yyXdq3XhpQEo/gQqWRuloQQ5QPpBlPFKEFKr6IItU7r1p0svOydkAmBXvYmCTleLu1Ne5lj47yoYPCeE+R3YIsf9KtXWDrFoJDO5ArIcQxMg+WCb8U2JwlbckkLXmz6UO/Fd8GmyZ9IMY1PotVnMRVa2GOzm2w+R7eOlko4kE30sa2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiUXppu1+5Yngydlcha4x8gXW1Cydv8umTCepXYkfJw=;
 b=QGwXfPjehlAJJh1C+B8ZRy+FuKjreeACZgBUhFGF49v//eU6eEgsdiJQmCRSCypQuivQaDc4jVqWdwpEVmomwmFU9TOgJof1c0EhcTdMIU6EQiC34xqkd7Qmv0xVpzDfHsSvdEx5/d9SXcICLXM+1QQvKyW4f2anqse/LQ1mQhe8T1Qn26uaoQeJvpNQc6hvBtDMAQqswfvv9Cs7cT07v7C3Onx+zT1DSva+zY/BG5qPgbwSQYVGQBwHnEhs7m+seo21uzTzRmr6h8wfFx1151MyskAozwmCQLI+NpRXD2inDlGLEQyCFJlTIyr+MowejOJjnm4DBFeM+Qlutbgf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiUXppu1+5Yngydlcha4x8gXW1Cydv8umTCepXYkfJw=;
 b=YzgW+cg1CnNUwGvhKvYLhmxmMFcUIkWIjfVZfm7DaPg0Kt1kEAN8liRTo8r9gyz4p7C84dnLeQ2cQpTn6M3GyBfuHoItrIQVIrj59LUOb960xgD6p5DLqSWBkJbj3TNHlEk/x6ptjezOs+Y+hT5yHHWoqVbBzxe+G6ITcyMShpQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4162.namprd10.prod.outlook.com (2603:10b6:a03:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 14:55:36 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 14:55:34 +0000
Message-ID: <4d6c291b-9b10-a4fe-6486-14b0a0e9ee86@oracle.com>
Date:   Tue, 26 Sep 2023 09:55:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        vschneid@redhat.com, sourabhjain@linux.ibm.com
References: <20230926120905.392903-1-bhe@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230926120905.392903-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:5:134::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 199905b6-459b-4a7a-52d2-08dbbea0a30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6gQvxkFQu+DslS6FbaAdIxV/LodcIWuVGA0PN3Sgw1NHCWKjsCmjPgYTj/AklJ5P729eSny0xvm+gBOsbuJZc4aHsSwEUdltjMO/kX9uuz+48rUJC3B1Bb2pNJi7zimAz92hAWvGrXOC3j1G0T6rs+b34J0fFJh+qfLTgdg2s21PmaoqRMu34KePmfRTG3vfsVmN+Q17XS8KBNZvXPr602p6u23nLqSb2JYiFJvGn36K3n3rZSSiWPGRhm4OzGwS9mpI3Vkher4DFu3k8PVlQvWOOdncHARrWAwUH7ynZA4u6dBCADRWPAMasL7ZZJg8eslLw79E1uFVDFN0Hfrh/Olx7+a5OOTog6K7/29Nzs0cvrEg4zgMr2bKTIoK/yFCktnftWCVhV6KS1oxYx0Co+uJKlFwZUj50Ll2gU1bhb096eKqQr9VIgVpac2ds8z613H2vD4ZP58EK0GrIxJASrWzhcFWTOz91TnwZW2WClh29kroPPi2a+4qT8NH1l11Ya+PqOVclQGmxaBvvoVuKfty1Y03K9yi0ubZkMHBU2464i5gVXM1ABca2cNjnQ9NV82h03BYeUui5mwCyicVsEaro97yrFz5l7y1puVl4NMIK+udr/nPW198Pmrxaxc8gdV80Sh5wiwJ8lb9ntAOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6666004)(478600001)(2616005)(86362001)(36756003)(31696002)(83380400001)(6506007)(6486002)(53546011)(5660300002)(38100700002)(6512007)(8676002)(4326008)(2906002)(8936002)(31686004)(316002)(41300700001)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhEYXlpWTY0U2tSSG1qYnBmZG5Da0lnVGJsQlFpMTQ4V09PbGw2bGNPNzNG?=
 =?utf-8?B?aTRYUmtldTREZUR4ZXZndFhmUkpMY040NGhrclFpK0p5WHRDUXZoNFJFUlRn?=
 =?utf-8?B?QWNEYWZtdFBlY0pyTlgwYWFsY3JOT2hpWGFqb0VwZjlGUmpUR2ZNTlpvanky?=
 =?utf-8?B?ZmJicUp3VmU0NUdSV3B1SUJXaDVhYjFZSFkrSzRaQmlUdDJ1WWZiR2hiWkJs?=
 =?utf-8?B?UURsNHAwNlJieWFIVFdOVGpCUFRlck16am9FcmRwQ1BsS1B5UFNqQUxBUFMz?=
 =?utf-8?B?d0JVR1k4NFVxR3A2SFdHb3hIK0Y0YUtpNW4wQmFweVRrOVpIZlVwR1hEdno2?=
 =?utf-8?B?Z2FFUTJrOW4yZXRnU0FhSVJJbDBTb1YrSTRkSlR5emJHQUh3NzZKcFY3YjJK?=
 =?utf-8?B?WTEwd05QNUhzTGJuYUdhTVl0TXJITDRFa3kwMzVBZTh2dWl2d2l3dGZnM0RP?=
 =?utf-8?B?MDQ3MERDK0JUT0FRN3hoSGVRaDVtNzZTODRyMVpuTkpvM2hMUmFoWStYU2RV?=
 =?utf-8?B?dWEzOG1HVVN2cDRXbTVrbGtVaCtlQTdsMTNvZERXVUVMVWRYTGQ4OUhYdk9m?=
 =?utf-8?B?OE9TcC8rT3FlRVhndHJnRUxLZUpKU3c0czRUMDZ2bUN3TjhuUVZDbTZaWFhK?=
 =?utf-8?B?bUZBb0VSeUl2NHBpeGpMR3R5MExEeWkxWk5hZXY1N2tKR3UwbGpzb0Jtc2tL?=
 =?utf-8?B?TDJxMDZwY3FmN0g4NjNMN0xXSW5PaXBMQkltMnVnN2NEUU1Gc2dRWnJGcTBM?=
 =?utf-8?B?bjZucFlaK1JoK0ZpM3Z0RDFHQ0hoZS8zTGRibXc4ays2bnpMQy9MTFgwWjBF?=
 =?utf-8?B?Q2xoYXg1aE5nYnFGQjA3T2V1NGJYV01IWjlQeldJZzBWRkJCT1N1eEIzWWVX?=
 =?utf-8?B?N2tCdzFCL25JY1N1TzVpaVpXa2xXcnFkN0JSTEVQaUk4OW5FVzBZNVRTTklh?=
 =?utf-8?B?dzZPT3RIMUoxeGZIS05Wc2JZME9IVGozSnlVQWk4TGduYi9IV3c4TmZnKzdM?=
 =?utf-8?B?R2FRQytZS2k5Q3R3VW9yeWZ0aDYxSGx3RVg0RG1jcnJES2EyY0RIRHpLWlA2?=
 =?utf-8?B?R0NuTnd2Z0pUME9oQVpMMm9pZWdQc0dGeG1XWlY0N25nQ1ZkNU52ekpmNmlF?=
 =?utf-8?B?N2lrUVBqSi9lUC84QVA5dWVGaXVCb0Q2NTMzVS83MFlSNS80R0dza0JQcGU1?=
 =?utf-8?B?WXV1aXR3aXE4djUzWkh1ZWhUR2EwdlVqT0xZdGZkUE9tSlpsT2tLUDhHYzR0?=
 =?utf-8?B?ajN5bVRjU3NrV3NOTS9mM0JjVzdNQUVDdnNuMElsbTFDN0gxMkliSWNxVkdr?=
 =?utf-8?B?UG83eWxLOUF0elkyc2ZkY1dtOEEwb2l6cjgxSDV4VWNtbC9TQjNrMzhTMm0x?=
 =?utf-8?B?emozd0tFaEM3SGp2amViNG1UVWo1OWszbWJkVG12K0lINWtTVkRzNkZ2ems5?=
 =?utf-8?B?SkFZYnpZdE1GU3MzMWI5Vk1wRmdiRWo4Z0Z6L3hHYVVTNVhlMGhaT2pjVHBx?=
 =?utf-8?B?cGRXZUNod1BTL0c2V1VBditwbnB1aXVuOUQ3ZDRYMGdoaWQ4c1JaMnI0ZExh?=
 =?utf-8?B?M05VQ1k2ODVPaTB2czJ4SUFIQnFXb2UvVys5U1dsYldNK2dNRG44T1NYYS9y?=
 =?utf-8?B?TE1BQ2UzR2x0bFAwa2cvcTlibEdHREhick9admtQZDgzZUdLSlVJYTZjQTRq?=
 =?utf-8?B?S0lqNVYwc2wyanZqaU9JdzR3TGNRR3VnaWlLL1VyY2pKMlFVdEppaHJQSklz?=
 =?utf-8?B?aEF0UzJSc1c1VEJuMDl1NXh3amVkb3ZTQ0RkcUROdmgzNFBiekpjWU9nS21P?=
 =?utf-8?B?c295Mm9FY2p3LzVIQ3ZIbUk0Zy9scWhDd1hwdDRhczBjNUZaYnhtU0hZSkVh?=
 =?utf-8?B?QUVHOFNya0pNQ296UXkwQXNGbzZUdzljWG13M2YySis4clRZbWs1V2lQYTBp?=
 =?utf-8?B?K0dSVEFPQ054eGgwMW1raDM5YW8ySEEvMk9nbklLd0lucXc2d2NwZkJLNXgr?=
 =?utf-8?B?VW9IZUl5eUo3UXNBUkNxQXVEV2tWbUxuSFZ0QjE5dkdwdFJueDRlRnQ1Vmhx?=
 =?utf-8?B?ekZ0ZVpRenFtMS91VFQ5YStNSXJ5Sk0yYXJ1RFBZQVB0cjVMMnJjV2krRk5q?=
 =?utf-8?B?UlIwYm5MSEkwNCt2UysrVDBOci92cVNIdTJJeTdVUUZFMjNQNGtreHo2akZi?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eHhDM2hleUd3c0U5STh2d2FaelhRREYxNDFlVURUM3VBcWNjLzFiRlVhVDVH?=
 =?utf-8?B?OGU1T1ZMOHFVRTd6Vm9EcGhjMmdSZjRMOTArWU1USWhvWVlIVWpzVG81ajZ4?=
 =?utf-8?B?aXRXNEtrb0lRRjVkZjVrVnBhaW1UZ3pBaFVvN1NsQ21OaHdkaDQ5RHZFQXRj?=
 =?utf-8?B?c3B4NjNTMU0vTndzZ2NLR2NTcEVyL283ZnFGNVBFb1NWaTJhVm0zM0pJeEF4?=
 =?utf-8?B?dkp4Ynd4dENBQU9MMWZPZUluUmw0TmdwUGJJNkZ4ZGt3YzR1SndqMXdNYytS?=
 =?utf-8?B?V1cxd0lxNm1SbnoxSHlod1M2cWlNNU9HbE43N3VnaHB1WmNUS05oWGJuVHJF?=
 =?utf-8?B?UUUyQlJWZTZTOVFISUN0VTVlOHV2d0Z2cDcyV3h5RkNHR0RsbVF3SkkxSVhX?=
 =?utf-8?B?bnpLSzhld1NKRCt6TWtuT09EenlhVEpVOXV5R3I4Qlg2THZva05SSENkTVF1?=
 =?utf-8?B?QUlybXpEM0pybkFtV3I1bzBaNHNMam42cmJPb3NENEZnbGhqakpmcS92VTVn?=
 =?utf-8?B?MmhpTmx0SWRZUWNYeWRnYUo1MkxmamNzc2RSTlAyUlFjQU90eEtwNjJ4ejFM?=
 =?utf-8?B?TWs5RjR6MHJKMGR1WVZ0RkxJcVllVnRtQjZ1eGRYUXhyK3dlSzFiN1o1ZHJ4?=
 =?utf-8?B?Tm5TRjF6dmd0YnE2UU9tTjlmUmhqTEsrMkJtVnplODgvcGV1dmpIM2ZTWUpm?=
 =?utf-8?B?c0ErVGJhWmFNMkNJYmFpSGdCWUR3R284V29VR0Rrak9vMXBvdyswZktNZDli?=
 =?utf-8?B?eTVOdmRCcUg5aTJ1QVVzZ0ZiUHhIcTIzRmZ4RW9pVGVpVTROb21XMU9nWWJW?=
 =?utf-8?B?R0p2aW94NlRTTFlQOWg3QkJsdG1uelJHT1Q3ZHFhQWdZWk8zZlIzRDNyQWZY?=
 =?utf-8?B?REs3U2FEd3lHVHlldGRUeWhCbFI1NVZ1YXh5SnZiREFpaDdPbnN1aUUyN0pT?=
 =?utf-8?B?N09SRnRGcXVOR0Y0Tmw4MmJiT0FZQ3BGL3hPK2pCZ1hsbFVXTEdjMnNKOWtP?=
 =?utf-8?B?MnlQVkRWcDV3TFltSGw3aHFjNlAzOUVPdTRKWE12NVhKOGY2TVdZQTlabUxK?=
 =?utf-8?B?akpzR0E5blFPekx0dmZMcWpyM0plYmlkWGFXek1PdkRsMXR1V0g1RytCVzQr?=
 =?utf-8?B?aGFTa3g0RWwvTGJpTTNHd0pWYWVXVHYyWDdxd0pUNFhqelBNZUhXbU5zLzg4?=
 =?utf-8?B?b2pEbERiYnVhcDBOam9YdEhFSHVRNU9iS2dzcWJkajVBWkNLUmVxdkJVRlhT?=
 =?utf-8?Q?kna9VEMIq3dsG80?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 199905b6-459b-4a7a-52d2-08dbbea0a30e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 14:55:34.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzdM0nPRj2jtH1kcYiVI8n/LjVar/jZu9lF0hpBKSR/vYB1PPIGoJ9Q7bT3LScP5PnQ/R8KAuYbNbPHxjga/vMnAU4kKd3+EWWWwc6p2v0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_11,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309260131
X-Proofpoint-ORIG-GUID: 8lDC5PTMsXImAtNcudJBUH1sN4EEeNrE
X-Proofpoint-GUID: 8lDC5PTMsXImAtNcudJBUH1sN4EEeNrE
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 07:09, Baoquan He wrote:
> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.
> 
> =======
> [   78.714569] Fallback order for Node 0: 0
> [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> [   78.717133] Policy zone: Normal
> [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   80.056643] PEFILE: Unsigned PE binary
> =======
> 
> The memory hotplug events are notified very quickly and very many,
> while the handling of crash hotplug is much slower relatively. So the
> atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> serialization of crash hotplug handling.
> 
> Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> hotplug handling specifically. This doesn't impact the usage of
> __kexec_lock.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

I've run this patch in my regression environment and I do not see any
lock failures! And I've done this with a variety of DIMM sizes up to 8GiB in
order to vary the "size of the swarm". Both with kexec_load and kexec_file_load.

Tested-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
> v2->v3:
>   - crash_check_update_elfcorehdr() need take __crash_hotplug_lock
>     too because there's tiny racing window when kexec_load interface
>     is taken. Eric pointed out this.
> v1->v2:
>   - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
>     scope in kernel/crash_core.c because the lock is only needed and
>     used in that scope. Suggested by Eric.
>   kernel/crash_core.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 03a7932cde0a..2f675ef045d4 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
>   
> +/*
> + * Different than kexec/kdump loading/unloading/jumping/shrinking which
> + * usually rarely happen, there will be many crash hotplug events notified
> + * during one short period, e.g one memory board is hot added and memory
> + * regions are online. So mutex lock  __crash_hotplug_lock is used to
> + * serialize the crash hotplug handling specifically.
> + */
> +DEFINE_MUTEX(__crash_hotplug_lock);
> +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> +
>   /*
>    * This routine utilized when the crash_hotplug sysfs node is read.
>    * It reflects the kernel's ability/permission to update the crash
> @@ -748,9 +759,11 @@ int crash_check_update_elfcorehdr(void)
>   {
>   	int rc = 0;
>   
> +	crash_hotplug_lock();
>   	/* Obtain lock while reading crash information */
>   	if (!kexec_trylock()) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		crash_hotplug_unlock();
>   		return 0;
>   	}
>   	if (kexec_crash_image) {
> @@ -761,6 +774,7 @@ int crash_check_update_elfcorehdr(void)
>   	}
>   	/* Release lock now that update complete */
>   	kexec_unlock();
> +	crash_hotplug_unlock();
>   
>   	return rc;
>   }
> @@ -783,9 +797,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   {
>   	struct kimage *image;
>   
> +	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		crash_hotplug_unlock();
>   		return;
>   	}
>   
> @@ -852,6 +868,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   out:
>   	/* Release lock now that update complete */
>   	kexec_unlock();
> +	crash_hotplug_unlock();
>   }
>   
>   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
