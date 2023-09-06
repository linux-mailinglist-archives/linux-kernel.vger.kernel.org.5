Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E33979382F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjIFJ1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbjIFJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:27:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69636199F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:27:13 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3868oeeJ017295;
        Wed, 6 Sep 2023 09:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mqA3wuwGhvjP9Ph5tb7Pddey+PCfEVz2IiJuF3Mfgfk=;
 b=TRCtLoRj34oMzyKOQZ81tNS/XmbRzXkAO2z1y6jVHiTT6x007vGH+ZAzr1r5HBk8ac38
 MHgJPqfOhew8BT3e5jHuEHW3a3v23lg2zbC+DzTYRvjuON8khAVbewGl90lHLeR0b8fT
 UIaC2W8Bjxw/nQoe/a0/C87nI0h8A8MGdECo1Cl3R1i1ayXkz1Dp0iLZ8AK5LBH5geKb
 KXJppYfAVa8wsiq2e37kyCRC8TJAbtcmL/I4rsKrMeZ/xN4sKGr1RHRQlu5+qmABGJbs
 CXa8L9/LF+igvIR4CWO8eGr79NzeOWMMb+t9PO5ZaIiWJsFlZ2AmZ/TGF1pjlizaout7 Fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxp8y0350-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:26:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3867QHLv028165;
        Wed, 6 Sep 2023 09:26:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5yg3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRjE6o/BpZLQlcTO4OEhfFN5e5RkGt9JwvarTfU+ykh/lI23YFm37jONMyLQkFQiKnc7KqFR/Jfzq36Nt2G9jt3xPhDbcU8J+oBCuh53feEHvZL4pHKr0DGpkkJzXit9Wf5NkZ7hzRE07t57tcMOB+f4eDBt1TdKU2nYDT4OubVcLSC05G0YGKqb2KSZkhx3NNU/68gXF8hTCVYSJO7lMZ48F92mHCU5qa5f9rCiiEfFeQMtKSF8v75xh+J53Ufwm13faToxidpaB3NlzDD/qFWispKhNGXog+oOsg8CimLFfRbGy3E/ohCVsAbIm0uz8GV96RXsEjM4FEOA39HjqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqA3wuwGhvjP9Ph5tb7Pddey+PCfEVz2IiJuF3Mfgfk=;
 b=ik6yLHTxkaebg715Kek37PTpM1sqQVwOBEEx2G6vtmvZ2Uo1iB6WFvtndf9hPlfVpX0caxGmTgHriCKZ/1gWBn9G8uWvFv0qikfX2GnmFLry14HSErS+n62vhs6AW2xs57dBK1zUOP9KNaddvmjgBKJaLMiXEmKSj1m2h6+WVLXdMUpD6QMagJ+8EeHaOcZ2ycg2UXEKewbvp9THpwOSmXvU+L5L7sg+eqIysWDW/4fDc5yaPZ6YnCyVRdAT1LHJMQDNyUdSyLkp2Pah19VJQGo5aYVITkBv7fBEYWkh5UTRxM8qhqEFVRaWRI4basIUAbnQtfO2EnmhyBH0J2BHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqA3wuwGhvjP9Ph5tb7Pddey+PCfEVz2IiJuF3Mfgfk=;
 b=ck4P+r0zLe9damck9r3I0gg0Il8HHFOaJphNazwUS0up1UTA1/liS9eAzbDoyxJqPd4KEefDpf4rdIjUm8VipfRk3C9dIO2NNR9I94ANYS95CfTCpLiFjAMT/5wq5Wbzp/YDg4CR73uxFpmvcaYIMTUhqi2TuZC3137SzOTPfSQ=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MN0PR10MB5911.namprd10.prod.outlook.com (2603:10b6:208:3cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 6 Sep
 2023 09:26:16 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:26:16 +0000
Message-ID: <2e942706-5772-0a93-bab3-902644c578e7@oracle.com>
Date:   Wed, 6 Sep 2023 10:26:09 +0100
Subject: Re: [External] Re: [PATCH v2 09/11] hugetlb: batch PMD split for bulk
 vmemmap dedup
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        muchun.song@linux.dev
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com>
 <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
 <CAMZfGtU2HX4UR1T2HW75xY70ZMSOdzNZ2py=EggoBYqP_1+QFg@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAMZfGtU2HX4UR1T2HW75xY70ZMSOdzNZ2py=EggoBYqP_1+QFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0128.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ce::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MN0PR10MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 17884803-3684-4665-b7ca-08dbaebb51d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK4Z0bBB5pacp/w2+pGZjnvtHvDDhI60JzupZ/YFYQLTGQ1kg2RozKoTI23Crdky0xy3lvdH2tv7NwPiRYt1pzeybwOE0qZp15JIHMzHnbQu6j9ea+NJpYYbidFEh+bYL/JkvQvizOI4Z0p1A4n5Qb2C+mQNaRrEDFJfLhIBkWXwtNv2WRn1/eNXwoJdgr5PmfbZCNvofMkkbrs1jPk0YckEtE2xLiTtBwogaZ2QytyFFKP56xsvY+P09NQYh+xKvtPvw/blxudJ6M/XF33qDXgLi/ZT/tmI57JI2aIbsNqWKGVcIDFrM4rTmugIM964cwqHW67eFazPyHcOzQJ9ZsYP2c0sRIInYWO8oL8xyZlSgg7p+EvmwDHgoNOIF/2+NI5qP4P9eLW6Y+6B/vOYSerP4Ri/LfnnE28ES9UQDAw4lXJ3fbquHMzWwy36BWo5ZpgIctdq8arzU6hXilz5vl0OBZ68Iu6ZghHOF/IzVkp9TxwVsRAJMtnTvFuefYyHcmGfSHuelBSoEgnVcV6fqrcKQDGWI2tNPCr9hlwTGOaEnmZloaFmd33ZYEu/vWZqDIUSmBq0/Og+DfVs96+0WqSWlZMhfqxSy5WJwGVMBqh/qcXNOdU9wMM2QmjFkJzz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(31686004)(7416002)(36756003)(86362001)(2906002)(38100700002)(31696002)(5660300002)(53546011)(66556008)(4326008)(110136005)(8936002)(83380400001)(41300700001)(6506007)(54906003)(66946007)(316002)(6512007)(2616005)(26005)(6486002)(8676002)(6636002)(66476007)(478600001)(6666004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEdyOURnY2dzTHo1bEZ2b0lMYlg5dng1b2laMlYyTVpuOFdQZmZMVnZETnUv?=
 =?utf-8?B?ckI1dWVxNUlTSTVCR1dFUXZIRml2UzBTWE84YUx6bktpb0hKMlZoUVdsaE1t?=
 =?utf-8?B?VWlJOG1BbnQ2ekVVQVBHVXFDSU4wTlNpc0wwdUlKajVDcjk2WFBOWEsrOWk2?=
 =?utf-8?B?TGlwYlowYU9QS2NKWHJzSHY3MThrMkFzMFlQbFhoVjBwYkFoNXdiZHdFUG5l?=
 =?utf-8?B?R0xhNUhBbXprZVNFL01CbnliMkdtYnJkMHU3SDRTTkVNZVZWZTB3ZksyTlR2?=
 =?utf-8?B?WE1lU1hlOGRnMHMyR2lNZWZtQ215YmtZbit0U0dpNE55TndMQ01xVmJJT1Br?=
 =?utf-8?B?NVlKMncvQ3F6SXM5VlQveWphRXVxQVJUM2JvZGduM2cxSnRiRXpLNXlmZjZN?=
 =?utf-8?B?OVdLT2h1NXNhUjIxR2QxOFdXYll6SEdwMGdmNFBOTW4wTU5DSDcxVmEvTlhm?=
 =?utf-8?B?R3FUZERDSlFhZU1kd1ZFcFJZUEl4STFjUlpsTiswcTh4eFpLTHBkOHNoL01M?=
 =?utf-8?B?ZDBORXoxeFVvY05XMlpYU3FmM3hPOGlNOVZkREpscCs0ODBoeTRjSEd1RGdC?=
 =?utf-8?B?d1JRamNzSHUrc2pzOUxYMzFscVBQK1JyNC8zVDl5eEZTSjFRRzVxSk9iTVVm?=
 =?utf-8?B?QjltaUpGdUV6YUs4NkwxYk8zOXBzSFdvUnMrR2d4dnZNN0o4R3lEQ241R0tH?=
 =?utf-8?B?M0kwZHlvcHRYOUNMdWxmM0NmTC9TSW02OCtEUDFrRVNYZFk2aFVBTmsySndj?=
 =?utf-8?B?K2JMYUZ6d3IwK2E3RUM2NUo0RDJVTS9IbGZhWW9remlxTzdxYk5hUjFWUlhC?=
 =?utf-8?B?Z280Y0VvN2hpZkh1U2FObmV5Y0tBWFN0U0dZMXNQa3JXZ0VlYXNab0cxTDht?=
 =?utf-8?B?QjlDQWdlNVZLOFEyWE1CRGxFb3N1ZG84ZjFzMXNMTCtibVpNOGdyT0Era20r?=
 =?utf-8?B?U3pqZmI1WmorWG5SY1N3RW9tc0RRNGIvdWsyRndIWU1qNG5KVlJnR2tBYmtT?=
 =?utf-8?B?M3RGVjRvSDU3b25VRUY5V2ltYXpLQTMvZkZRVXkwVENKQmRseHp1aXYxQm5Q?=
 =?utf-8?B?VXZUbTZZZUdTZkNGUmlacnRQY0dsa1BJV09OQUZvVXpyTUZ5a2ZRdjJqZ1Zx?=
 =?utf-8?B?QUg0RElvOHdoRENqTGd0NFdQR20rWWNkcUEyNDVkbWVRNTNuSzQyb1Q5S0w2?=
 =?utf-8?B?R3RCTThtSWtYYnlML3dLU1ZSSnlTTnhwWU9vL1JtTHM5L3pTVTVtSlQxZDVo?=
 =?utf-8?B?cm9UWmJmTVd5RUlURWdTTmpqeTM3dGpzTFBWUkEzd3FGaW8wZkNlaXdtcVdK?=
 =?utf-8?B?NjhQT2M3VlJpYkZhWjRVU2xiQjV5MjQ0dlpMcGtVd3duSE1IQUFCM2xhUis0?=
 =?utf-8?B?R3N4Tk5QLzV1S1FUQkZWK2Q3eTY0cklLNTVXWk5PU3JSVGxLQXFreXN4QXJz?=
 =?utf-8?B?N3lxTElkV0pnbitVVkVYVDN3Y05taDBLMmFxUVdTMjE4YndxaWNYSjgreFd0?=
 =?utf-8?B?OXBrN0VqSkM2NHlKZ0MvcW9KVVAramFCK3FJZVN3ZUFvKzg2MTB5RU1aL2Yw?=
 =?utf-8?B?ZzE4WnJWWEhUczlJTXJLbDdaTHU1VVNjanVsWVNpaGwwYXhPWnpWV0o0eGRF?=
 =?utf-8?B?dHBNR3l0MWVhNzFLcnREWVVQMm5EL1lKUVBWaEk4OTdTQTVpN2pjenpMcGlT?=
 =?utf-8?B?OTNaNUxmaG81bFlNUzNxWGozTVdqSDlsNlBqSHlnd0dyNCtsUGMxeTFYdElh?=
 =?utf-8?B?blFTU2FzRWZuVXhWT0RCRUlHWXpIWjFQaEg4aGlGYUlBSmZWL003L2J1aEZq?=
 =?utf-8?B?TWhFN1c4T1VkM1crbWJBNUhHQnNlWndzMDB6VHB6Q3dja0htRWtOVDN4YlQv?=
 =?utf-8?B?V0grNVFyVmhFVG5HS1dvV1dxWlM0U3YyMzNzcENPaGFpdUF3ZjliRi9SaHNj?=
 =?utf-8?B?SStEdkhtN21SMFNyK2tXQ3RjSzRsT0x1V2JxLzRFM294NzNRejJ5K2xDdFV2?=
 =?utf-8?B?QlJ4WlY1R0w0OFgwdmtibnVUdDJ3c2pCSlBvdEEvdUtleXpjUk1wVkMzcTNF?=
 =?utf-8?B?SitMdFFsWjRlTDU0NmRrUERuSTZUWElsOWE3UTRGWmdBNFloYTJmcTZVa0pw?=
 =?utf-8?B?cU9nLzhHclFMRCsyekpkN3R4TnlhZ0dPcVJibnJoZFdMR1F1M2N1NlFyOVJU?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?M05MNFJQMmhQMldXVHQ3SmJvOUovK3RkQklDVjUrdHhlaXBsQzFjaURjcGRR?=
 =?utf-8?B?bnBEUDA1cHVRRHNvenJzbnZBUGhyYllBZkNMYnlJT1BXTVRZVWtVUldzemxo?=
 =?utf-8?B?VUVUVnk4djh2R1dydWE4cFhTOVdpdWZxbStyZURHbGtGU1FmVGZ1YzB2UUFO?=
 =?utf-8?B?dVRlL0FEWHp4UDFQdjFXQmFoemYzdE1ENjhqZmpaNy91SUxsbjlKc2YyZVl6?=
 =?utf-8?B?b1lyaWlLa2JaaDdyY3BELy9VVlpTa2QzN0RXWDJKVDRWcVZEWlFaU3VXcUt6?=
 =?utf-8?B?MmdoTVZEUUZmRm9zeERXckVybjgwM3VHZ0ZreHJRVmpaUzQrQTIvcVEzSXNh?=
 =?utf-8?B?RW90Q3U2STFJMWxrdUtWVThJMWs5eThWTmwvRm9iUXFYZ3RhNGpXWHFyTkRl?=
 =?utf-8?B?ZFZQaCtzdHdlYWdWRTZOM1pXc3ZBQmtTWVk3NkdaRWVTbnJ0a3luTmxxLzYy?=
 =?utf-8?B?QWYzZ3plaUNaU0xzOTZjVXdTdUlyR1RwZEZGbUpBak1qUjFVTFVDTTB4OWNS?=
 =?utf-8?B?TGd5UnROWGRNVzhDcWpUcGRpMFdXTFE2aG54ZW8wc0FSVjg4a2k4L2g0WFk1?=
 =?utf-8?B?OE82L3EyWHAwa2RvZjdpOHJQWVNzRG9KV2dvTjBqWnh0WXZWM0F0dEprWXdK?=
 =?utf-8?B?ZTB4MFNtS0htQ0VxLzFaQTRrK2NuS0YrQjRscnlINURLcXJBMk5oZU9HRnRR?=
 =?utf-8?B?cFlxTnd5ajJlcW45RFNCWE1GTldMNlUzSThQRkQrTXNwOG0yQU8zZmx4RGl0?=
 =?utf-8?B?VlJvdTVEMjkvK0dLQnlVRWJtODFvd2xVVE9kanF3MnlaWGxOa0RkamY1QjJy?=
 =?utf-8?B?eWxxNjJva3BmRzlra1pOdzFLMUVTdjFXOGFNekxwL3UrZ2FXd2dRMXdYalJt?=
 =?utf-8?B?WlhTL2IwUjF5TzhTczNmQUFVNGhyZG9Fd25Gd3ZJUUl4YWN5TmxIdytsRFIr?=
 =?utf-8?B?VmM1YW95MHZvUENSVzU5TkVwYnlCNzhMSTN2Q0s1T1NwOTBlT21rTG81SlJu?=
 =?utf-8?B?cXlhOFRCTHFWOFY2YjVpbGF5NVJEblloTGNNbG1RNXpOSVd5L3dVTnVSRmNM?=
 =?utf-8?B?TlVXQ3gyZnoxYXJRUWZqN2xtUjVQMWtiZjFLL2tLdlE2amJzVS9ieDYySk9r?=
 =?utf-8?B?R2loSnRvdFZiRlVTR1R0WVVnMjVDUWlBdm5mR3g4U21Ud1VZQWI3aXNSQm8z?=
 =?utf-8?B?MVhkSVdnUTlSQ3hsVzFkUjlKTzZNdTVYNXRlOTFpSUk5a21ndFlPQ0lmOWox?=
 =?utf-8?B?NE1GSVBwQXJHempGMXZQT1VRbHBLdTg4TGxuVFBXWlZMYnlHZTl6WElqVHRM?=
 =?utf-8?B?bXRJMGwwSVp2YjdDU2xISWlIYkFvNWlQZ3pFZTRvenVqMWM3S2RWQVlsT05O?=
 =?utf-8?B?dndHNWt1SHNTWTVnUStvaFNKNkc1OVFkZ1VJeDU2ZFJRZ2tuMmxsWFpyZlR4?=
 =?utf-8?B?L21jVnBNWEwzRFpSNW4zbG1zN2IzTHNlamQrRzNRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17884803-3684-4665-b7ca-08dbaebb51d4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:26:16.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jD+JqqAjwKNRwwXlrcos2cSY0pW77yVgAQ6gl82Ka678yr+OmYxY3mruRwOXIpFexUXhvtE0/iiGhTjLQhcXDVcOc9YoNSn3NC7hOyab1Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060079
X-Proofpoint-GUID: xAEfOIwdqQP9oGoyahZw6YAVdYx7IfRb
X-Proofpoint-ORIG-GUID: xAEfOIwdqQP9oGoyahZw6YAVdYx7IfRb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2023 10:11, Muchun Song wrote:
> On Wed, Sep 6, 2023 at 4:25 PM Muchun Song <muchun.song@linux.dev> wrote:
>>
>>
>>
>> On 2023/9/6 05:44, Mike Kravetz wrote:
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>
>>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>>> belonging to a range of pages in order to perform only 1 (global) TLB
>>> flush.
>>>
>>> Rebased and updated by Mike Kravetz
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> ---
>>>   mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 68 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>> index a715712df831..d956551699bc 100644
>>> --- a/mm/hugetlb_vmemmap.c
>>> +++ b/mm/hugetlb_vmemmap.c
>>> @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
>>>       struct list_head        *vmemmap_pages;
>>>   };
>>>
>>> -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>>>   {
>>>       pmd_t __pmd;
>>>       int i;
>>> @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>>>               /* Make pte visible before pmd. See comment in pmd_install(). */
>>>               smp_wmb();
>>>               pmd_populate_kernel(&init_mm, pmd, pgtable);
>>> -             flush_tlb_kernel_range(start, start + PMD_SIZE);
>>> +             if (flush)
>>> +                     flush_tlb_kernel_range(start, start + PMD_SIZE);
>>>       } else {
>>>               pte_free_kernel(&init_mm, pgtable);
>>>       }
>>> @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
>>>       do {
>>>               int ret;
>>>
>>> -             ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>>> +             ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>>> +                             walk->remap_pte != NULL);
>>
>> It is bettter to only make @walk->remap_pte indicate whether we should go
>> to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
>> to indicate whether we should flush the TLB at pmd level. It'll be more
>> clear.
>>
>>>               if (ret)
>>>                       return ret;
>>>
>>>               next = pmd_addr_end(addr, end);
>>> +
>>> +             /*
>>> +              * We are only splitting, not remapping the hugetlb vmemmap
>>> +              * pages.
>>> +              */
>>> +             if (!walk->remap_pte)
>>> +                     continue;
>>> +
>>>               vmemmap_pte_range(pmd, addr, next, walk);
>>>       } while (pmd++, addr = next, addr != end);
>>>
>>> @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
>>>                       return ret;
>>>       } while (pgd++, addr = next, addr != end);
>>>
>>> -     flush_tlb_kernel_range(start, end);
>>> +     if (walk->remap_pte)
>>> +             flush_tlb_kernel_range(start, end);
>>>
>>>       return 0;
>>>   }
>>> @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
>>>       set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>>   }
>>>
>>> +/**
>>> + * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
>>> + *                      backing PMDs of the directmap into PTEs
>>> + * @start:     start address of the vmemmap virtual address range that we want
>>> + *             to remap.
>>> + * @end:       end address of the vmemmap virtual address range that we want to
>>> + *             remap.
>>> + * @reuse:     reuse address.
>>> + *
>>> + * Return: %0 on success, negative error code otherwise.
>>> + */
>>> +static int vmemmap_remap_split(unsigned long start, unsigned long end,
>>> +                             unsigned long reuse)
>>> +{
>>> +     int ret;
>>> +     struct vmemmap_remap_walk walk = {
>>> +             .remap_pte      = NULL,
>>> +     };
>>> +
>>> +     /* See the comment in the vmemmap_remap_free(). */
>>> +     BUG_ON(start - reuse != PAGE_SIZE);
>>> +
>>> +     mmap_read_lock(&init_mm);
>>> +     ret = vmemmap_remap_range(reuse, end, &walk);
>>> +     mmap_read_unlock(&init_mm);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>>   /**
>>>    * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>>>    *                  to the page which @reuse is mapped to, then free vmemmap
>>> @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>>>       free_vmemmap_page_list(&vmemmap_pages);
>>>   }
>>>
>>> +static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>>> +{
>>> +     unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>>> +     unsigned long vmemmap_reuse;
>>> +
>>> +     if (!vmemmap_should_optimize(h, head))
>>> +             return;
>>> +
>>> +     vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>>> +     vmemmap_reuse   = vmemmap_start;
>>> +     vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
>>> +
>>> +     /*
>>> +      * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
>>> +      * @vmemmap_end]
>>> +      */
>>> +     vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
>>> +}
>>> +
>>>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
>>>   {
>>>       struct folio *folio;
>>>       LIST_HEAD(vmemmap_pages);
>>>
>>> +     list_for_each_entry(folio, folio_list, lru)
>>> +             hugetlb_vmemmap_split(h, &folio->page);
>>
>> Maybe it is reasonable to add a return value to hugetlb_vmemmap_split()
>> to indicate whether it has done successfully, if it fails, it must be
>> OOM, in which case, there is no sense to continue to split the page table
>> and optimize the vmemmap pages subsequently, right?
> 
> Sorry, it is reasonable to continue to optimize the vmemmap pages
> subsequently since it should succeed because those vmemmap pages
> have been split successfully previously.
> 
> Seems we should continue to optimize vmemmap once hugetlb_vmemmap_split()
> fails, then we will have more memory to continue to split. 

Good point

> But it will
> make hugetlb_vmemmap_optimize_folios() a little complex. I'd like to
> hear you guys' opinions here.
> 
I think it won't add that much complexity if we don't optimize too much of the
slowpath (when we are out of memory). In the batch freeing patch we could
additionally test the return value of __hugetlb_vmemmap_optimize() for ENOMEM
and free the currently stored vmemmap_pages (if any), and keep iterating the
optimize loop. Should be simple enough and make this a bit more resilient to
that scenario. But we would need to keep the earlier check you commented above
(where we use @remap_pte to defer PMD flush).

> Thanks.
> 
>>
>> Thanks.
>>
>>> +
>>> +     flush_tlb_all();
>>> +
>>>       list_for_each_entry(folio, folio_list, lru)
>>>               __hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
>>>
>>
