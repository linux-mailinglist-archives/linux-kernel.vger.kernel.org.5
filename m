Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF897DE3CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjKAPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjKAPGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:06:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB8AD4E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:05:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1A8MhO008098;
        Wed, 1 Nov 2023 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=+0huDTM/i5Tgh/EztubUY1NMtafM6tZ+wD8uGcxabnA=;
 b=ItbFwmh9nqgg3pnrncd4Xbe4P9Vpzhilh5J0qzq4nP8Ik64/VHAs6mE/qKX8HgtcllvY
 U3lIp5dlOvrmLD3LNX70x6UL6QdJZNFwBKcjUxB+fkZtKPi0AbeXe9/HxDFGNAU2ElBz
 z846fCEuFrMMZWUHQoA3G1b+Vkxfq6+L5m9kXy8EZqIB2yyegcgwu5Ut5ObqnuZIQVtx
 nVx7VI1XSBtQ24xp+opR0f3w93mAHZJ0ZBZMj5llQ9WY8Z1a5dguvi6CfqbobCM5u3IM
 bCeOFH42P5/4EHwiwnYuh/lZuDhIGJXw1h2cOwzsJVT3AekIHx/X19pyr3lVvwm/Ev6U 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rqdypq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:05:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1DdQTY020168;
        Wed, 1 Nov 2023 15:05:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrdd0nx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9njd9fpnfcgOV11VU+eKma4oc4Xl4laN2MzL6B9tEGlYPxdWVM3UysAcGuLhGSBAgwR/UqWTbS2Wt+mTe5ocVOH9gcJ7bA9x2Xk9R+Ihr3q6vnQbRGOothxbkL+jKzs+vv5xeeQ0IvhDJVQUYNt/ikvbWlA3bbWcO2sTYaY0dM6riuoBNpTgvCyBu12V1Kf+pcMYn58B+WewFWs37ll/kov6d2M5o7QEXOz7xqJuEBwgKT6hK/FKz1f1GBk4gWY97cxdfS08xswTuYvY0XO1DyUxQey7S0DaBCepu+bFB2HaXhKcf+Kater02Yj5DZFzYCN8XSJrQ7pj2CKg6QpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0huDTM/i5Tgh/EztubUY1NMtafM6tZ+wD8uGcxabnA=;
 b=aa0fX2hSXB7h4TW4qb6XsMXUUBrN0a6GaE5qwZkeL2GJ3tZFmg348kNOEGTkBpojStSH3uk1092qP3Am8wLAzAop3wPRhicUP66gyicjnQs04CkqIXavf+yQgeAJUcvKszpTTwS4B+WB3f4jW5XRoQL50j7DqviJLDYACkkhz7ynl39f2j6E2NJMfy/1Rev5nOSSiHynZjVTA9NvIxe6cmWjdtVc0lQ5jeIril/VS8jetEHVW6inLF193CZdXp//BfqcA65xCDJXsJNzfpHfmIwLP7zDBub6oDnzFatdOjNRlDKDQJCgHXdO+DPObw6hLztNrYpP/OVd8wuvgKGa0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0huDTM/i5Tgh/EztubUY1NMtafM6tZ+wD8uGcxabnA=;
 b=nn7exp9OvqxBLM6UOL4fRDd5/U8rIPYaxjd+ubi92Jyg564dNvo7VbRI8uRxLOAUceD0+G4AVVC0DkXNctNSPhUjhFF+0oleWZohkGmXgq8w9NeXnHSFRvSwRNHosADp1TqlUsJgttBIo/DY8u3Kc02e4nS3fEQoITnB85MXE1w=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Wed, 1 Nov 2023 15:04:57 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 15:04:57 +0000
Message-ID: <5b131b90-513c-4442-bc1f-07817023df71@oracle.com>
Date:   Wed, 1 Nov 2023 10:04:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs : fix array-index-out-of-bounds in diWrite
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, shaggy@kernel.org
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
References: <20231008174745.27342-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231008174745.27342-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::7) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e50842-a616-4a3f-da86-08dbdaebe978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIGVYiuyLUNKJvsUJ2XpUwF0KNQ/Kq7oFxolt2oJLjaItzzWxt602lfgkagxEv8HbNvXRFtwERQVUAG1itSuGdNi/bqeQMzH9W/OS2Hfrnx8XOYsDf9n0qfAIqQqB/NZNSRGBgxwspBjGsO4buBYRuQNXwy9Gcro3LdM2wq/b44qO6SIWHlASnwm32QoiW6RH5G58ZeaBiT+l5VhbLSrdMg3L4tjqJ6shApJ9AO/8AprPsfxI426tB+S69Q/S1tXooUnW7XoN71KHY/LdEcxhi1LakJhGKoN9bUDRQHczXN6gmXi8yNYSFNph8tKa6SfEcVYGAs3zGMxk8lAocjyJ3G3dWLF5XCX/kTeQJViNqlPocOusAmXnywN8cPuOK7KBluH5ETyDrM7ejMaWHLYGb9hpiD0QM8MuCmzOEteIll+3Ydg22LYgQX6s14Nhr5yvAK79DBsYpRlHLCg+WVevXHtcNuW3xGGpWlnb9cZPXIijQdUPl5OnKjCT7MSYMEPziSu11utPlod/DCeO8556eZFofydnGYexBvtxWabdVMtm7QkEf+b9e9dIYYSo9GBdPtMp9CIZm3kQGjAxylo0itf7e2ZMgB7ex74kYZa0zEb4Fy4vgCq9IWvwlYJ+0kwRfWGIwNYXb5ZVrsN+DdBW9rRTKANkfFdkgSsRGFpJmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(26005)(2616005)(6512007)(31696002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(478600001)(6506007)(5660300002)(8936002)(66946007)(66556008)(4326008)(66476007)(316002)(8676002)(41300700001)(44832011)(966005)(6486002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVuYktTY3VLOXNvN0NxM3VFNXRUeDhmOXgyOGpHYXJwMytMUGZuSkw3cVlT?=
 =?utf-8?B?MjNPNGFwUmNEbHdPWEFWYXdQL09JczVkS2NKSkc4cHZZb09RY1MrcWpuS0tO?=
 =?utf-8?B?NFNGMkpsMW9yaUo2VHJEQ1VPanhZTWt2UURGdzFDN2VpVVhHbUFiTGIrVUpG?=
 =?utf-8?B?UWFrczJpejVxSEdnc3B3UGVxbklIY2UzbnFHMlI5VkgyYkg5RGI4cWoybDJ2?=
 =?utf-8?B?dGVBWlhXc1F3cUV4YXFFTFdiVEFZMUhray9NKzVkS0tFUml1TUJ5MkFWOFo4?=
 =?utf-8?B?RloxNCt1ZXl3K3BJR2dGOWdDTFpPd1JmeGNnRDVJaDJ1NStEQ3E2OGw3RWNu?=
 =?utf-8?B?eDc1YzNObHBDc3lhVDF4dnpQUzBzMUMya2kyc0g5bUJQazFTZ0tUWk5YTkpz?=
 =?utf-8?B?VS9RS21MNjA1Z1BDcE5iTHQ2dHBMeld4eE9wcGlyaEtzcTZENWNZTkgxQy9m?=
 =?utf-8?B?UmhlYlRSdVV5NndkdEE4Wnd1NkthUkRjZ3RxTzFzd0xmaWVWNlBaTkxsQjlZ?=
 =?utf-8?B?NkRCalZxcEVCS29udldUM1pyc0hoa2FtYmN6cXRkd0hKczNHTDlEYXRjdSsz?=
 =?utf-8?B?K2RoNkVEVDN4bjh0ZXcrS2dWTFM3ckxlZ2lhckcwZzczSjg5UjUxMlRkb2p1?=
 =?utf-8?B?bkVMbjgzdmRRWFBNLzVQakd2YnpuY01PTFFqT2g0ZUxpTTloMEkrUk9ldVJx?=
 =?utf-8?B?TmN2SE9SWGdRZDU4VytKYjVHSWtUVWo1dkdidU1FenM0RWNCMW03aUNxYzdG?=
 =?utf-8?B?Rm1PcDFGT3pXYkFzSlFrbFhjWkFBZ25BM2tMUEg5c0ZMUGNMSUxQdGFkWFpY?=
 =?utf-8?B?ZUVOMGJZUVJJb3JQRWFINzh3eTVaTW9scDdQdXZsTXFObnpOV25LaG1xS1dD?=
 =?utf-8?B?ak9aUHhhNDRySmJEU0ZGYU5aN2N5TjR4Q0xNNituTngvTTJNSFRZbWFyZS9w?=
 =?utf-8?B?YlBCTFBUR2VqdVZqdWNUZ2R0cnRpalpFVWU3aENJTC9yUUtkUXlUOE1xUEI5?=
 =?utf-8?B?RHdETEZjMVV4WDhycDNNQnc0NHFRLzZaK0V2ZTRHZ0tOWlpGbStUYUZiVzBK?=
 =?utf-8?B?cVc4TENrS2tQRlJzN0dZaEx0dVNLUm5uTHQ4dVdEWllSZCtOb3J6MVdGaGpO?=
 =?utf-8?B?Rnd4bUd0d1MwTmFJY3JmQ1VBWHpGWWtCWW8yYW8wdy9hSEMwcjErTmoxbm1H?=
 =?utf-8?B?eHorenJvenJHa3M0ZUFQdkNhZnQ0UWlIT2ZxNzBsb1ZtZENoTHJHaFB2NVBV?=
 =?utf-8?B?YUQ3ZWIydGFXbi9vQURWTU9yaDJUV1dHL2NabzFpYVYyMHBPMml0elpVUS9j?=
 =?utf-8?B?d3hzSlhLNlhhUXQzci9CQ0djbmxibDJpbU4rRC9iZmtpTjVzNURBUHcveHI0?=
 =?utf-8?B?NXdneUNYZVVLRk5uekNaVjJJOTdVL1luaGJCWnJtem84VjdmR0dBMGVDaEE5?=
 =?utf-8?B?UFZqQXYrT3FEMktJWkFRNUNldmVzRXAxR1BqSThwbmVIZFU3WW5QdUtSZVdP?=
 =?utf-8?B?cDhBelB3NHUvMzRHUjIyNUtEajFjb3ZhdXZBWGk0ci8wYnpKbU5xanh5aTVL?=
 =?utf-8?B?UTB1SzFkWnNyOGF0cTRZb3dkaWdOZzZSYzRvV1psSEt0dHliYmRyY1BldThP?=
 =?utf-8?B?czNsWVhzc3lMSGFtNDF6RjEydittOGJMMzYvYXZRS0pGeHQyZlNMNGZ0a3lD?=
 =?utf-8?B?OXRXMGUrRTNGVGdSSnEveWRYRUU4Y2wyNGVOVlpRcnUxQ1dHKzhqY1M2LzJy?=
 =?utf-8?B?OCtaODdrNGFiclV5alVhNkpCVldRY285aW50QlgwYStxWXJPSnFldGl0U3Zw?=
 =?utf-8?B?aTJUQlFML0MzRkw0OWZyditYMVc3UUc1cTk0WTJKT1d0QkphbEorUWVLRzRk?=
 =?utf-8?B?cEdUVU5BckhEVkdqazJhOUdSdStwZHhWU1JVTENoSzdvMlFueTA2U3o2YUcv?=
 =?utf-8?B?RmxxaWFRcExlRHhVaU1KeWJSdHlKdGFock4zSHowUlFXNGlNNy9oVVZob3M0?=
 =?utf-8?B?L09PQ0hJeW5uQ05tUE1KMTIzclVQbURrMlFUR2UyZ1hQOVRQdEM1YjZ5OFM5?=
 =?utf-8?B?ZHhXWTZKdXVTWVBVU1hUeDhYbGgvVGRkNG83aXdrYjNPSzdpVFAybzhYdjYx?=
 =?utf-8?B?cXFwS25aeWZFQmtSVlU5VU1FOGo0c0gyTEttMnR1dDVYMGFFMThVREtTUUZs?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTZLcm9PNHBMSXJHbjFOblJmcFR6N2daaGtkUUs1Zmx6ektDK1c2d0Jxd3hx?=
 =?utf-8?B?Ni9Fa09HbExpNk5BblpDU3BuWDFrdFdRR0g0NHRrU3hucHhpYmdMRitWNjcy?=
 =?utf-8?B?VXUxYktjUVk4UkdObjBYbGJ5QXRWYUg0MXpPVVlMWFhHdW13em9DeFMzVXB5?=
 =?utf-8?B?NHZuMDI1Y1ZiNUF4YXV6YVN3SjVXbkRDcHozdzFTcXdWNVBJcGl6QWVUYVI5?=
 =?utf-8?B?aTdla0JEenJXUTNSQW9UL0wzRm50Z0NxZk11OFExK1JGU0s2RUFuQ0RNRE56?=
 =?utf-8?B?c0g0SUo3RkxkeFMzczEySlBPQ0ljWTczTjBzNytwTlFwTzJlK3NrSnB5elRY?=
 =?utf-8?B?TmpOKzFLSEhtcmhPTC8zWmg2TkxjM3gyNDkvRFlabWFwR29YSy9tcFdKeXZ2?=
 =?utf-8?B?WUJudWJUODZzMnV6Q3RaL2wwaDVlQkdTL0NGNzgxRVRrOVBsVXhCQ2pLRTdt?=
 =?utf-8?B?eVYvRWlxWndXV2V3NURQRnNLRzNKZlJYeXZGUUFZajBXMDNKMzFDM1Bpc21q?=
 =?utf-8?B?Q0VsT1AvZkRmRFBtVFovalNPY0lwWkZ1b2NoQk1TNXZWNGQ1eGxOK1ozR0NV?=
 =?utf-8?B?Z1IwRyt2S211L0QvTVRRL1BpS1BNZ09VZCs5OWJJTlpKT0xkWmNRU1N1WXhO?=
 =?utf-8?B?cks3VkxHMXVDNVZWOW9wQTR3TWpHNlVBdEVQeGhGSzZxRTN3bkl6a0EyczRa?=
 =?utf-8?B?K2dmOURiRUtVUWZCdE1kOG55NWUydWVDVW14NSt2MTNDK1UxeXhNY2Nna2cv?=
 =?utf-8?B?TXJsTGJzY2EwdHBSZCt2UzN6K0xuKzJiRGRXNEU3UitPQjBEeXJySUpoY2RL?=
 =?utf-8?B?bFZGY3pFYkhNK2NLdWVNZTVHZkluQ3U5RlRtcWZOellDdG1ub0V1cU45QlZQ?=
 =?utf-8?B?QTFkSThicmdEbm5oMlQyS1dyN28vNGJvK3lNdUtoWmw1UmNOQ25iZHBSdXhP?=
 =?utf-8?B?Qkc5aHAvTHRFNjYycFZIeU5pcXlrTTNnc0ltQ1NwUTM3Z2hXdWtvSHdHZExE?=
 =?utf-8?B?bWtxdmNlMENTTlkrRlJQY0FxRXh2cUtkZ3VjcDFWSkoyejBPYVZSUXV1eU83?=
 =?utf-8?B?Z3NrMXYyNkg4aEhUQ0RxNStRM2l0bjk1UFRQZkxLdGNZZ2x3V1pDVWlMR2xI?=
 =?utf-8?B?VmRJV3NkNnM1em1zU0JFcGxwV1JsTjhvOGh1S2ljMW9DRnNtVDVCd0p0YVdh?=
 =?utf-8?B?bnNMeG5lZ2pQQVoyN2NXanBJRTFqSXFoOThpeGxHazVISGdnbE00N1Rncy9N?=
 =?utf-8?B?dlhYcGdhUmt1MzRlTTBvUFhBSm9PMHBHdEZIZ2lpd3owSzFHTTNFNm5VTGp3?=
 =?utf-8?Q?19aBTbnioC/T1QPE/4dazv81MFN3m+rUKk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e50842-a616-4a3f-da86-08dbdaebe978
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:04:57.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKQNvgv4gDqM9jxaGS2Qwp5WRrMNeGhdRV0ZQAk3pTTmU3DV3F12XlL8vIcPrkAeY7B7/kJlN6lgbHwqF56ai3Bbw9hGZxlgHJaOH0qJaC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_13,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=891 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010126
X-Proofpoint-ORIG-GUID: T1DOLoeOkGT8rpFntV8LIAcQd0qFHcu3
X-Proofpoint-GUID: T1DOLoeOkGT8rpFntV8LIAcQd0qFHcu3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/23 12:47PM, Manas Ghandat wrote:
> Currently while copying dtree root from inode to dnode in the xp slot
> there is a out of bound memcpy. Added a bound check to the memcpy.
> 
> Reported-by: syzbot+c1056fdfe414463fdb33@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=c1056fdfe414463fdb33
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_imap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 799d3837e7c2..d1f897848be0 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -746,7 +746,8 @@ int diWrite(tid_t tid, struct inode *ip)
>   		xp = (dtpage_t *) & dp->di_dtroot;
>   		lv = ilinelock->lv;
>   		for (n = 0; n < ilinelock->index; n++, lv++) {
> -			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
> +			if (lv->offset < 128)

I'd use DTPAGEMAXSLOT instead of hard-coding 128.

Also, we could at least set rc to -EIO, or we could do something more.
Calling jfs_error() would mark the superblock dirty and usually makes 
the file system read-only until it's fixed.

> +				memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
>   			       lv->length << L2DTSLOTSIZE);
>   		}
>   	} else {
