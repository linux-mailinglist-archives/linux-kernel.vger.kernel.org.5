Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB8B7FA3D3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjK0O6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjK0O6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:58:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BA2A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:58:25 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARE3wV6003550;
        Mon, 27 Nov 2023 14:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=XQ/yRXFLIasp+bV/depr1T0UJ+5B064yXkIN3kExU9A=;
 b=YJoQuOeIU7x7Tv6a0b1YEXtj37mRVKw/u1LkuM+QXTdcGJUev8fx6ZRmdQkQ3ExPb1um
 rQ1yH0yDvahhUccRoyGS5fXJUjO6QUYBoTAoUoFewn5NO1w+mg4XyOqSCBTtXEo3LxTQ
 CyNA4+w+lHFwTwexxS9+GH8cy1rGXsjMvCfQ2VuDiOmpsTMK7qH7OJUB33ATU1WCWPgA
 OvNbtNif1YxMeBp8OdybgGTUfG31W4/t/fqxv+fst8s5f7p4fPL3tbSjM+FyGBgcq+JN
 sGysDxwPoGrfOQocbgjyFgGJvxbLajBVWb4pJ8/OqHpr6kiUqtdG3tSkXdVM8/WeMge6 YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8yd35nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 14:57:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AREn1NR001437;
        Mon, 27 Nov 2023 14:57:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cbm50u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 14:57:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSAJLLTcqEGsq55GEQNbFH/KrxTbUsv0CfUv6nIiV1vhl5xL8ZJ4ABGVGyVkV4hXVAgSZtFH5p2/VeOE6P+FTpNZOsO0d1vvl7/orutyPyAcPimqAOphvx+SF8s7gQteV2Oj7ZsaLY7SKDMmotwIBy1secOad8hlVW1PhU4MzI5k6KMNi6wViNewmO3lWtK+xyk3Gjd54+6Ubj+3FSLMX1aHO7P7UQkMHf+h4URVMrHdgmfC6xPqYLXt+JQXGJz5Zyd9DsCkV3OURkY9QDyuaWW7Eh9iypyBSsY0ubm+aY/z01+iE4w85lmXznLwprvQiDhG/xBO2bGhlb3Nh2JZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ/yRXFLIasp+bV/depr1T0UJ+5B064yXkIN3kExU9A=;
 b=kdZLVIAqpgen419s3kqbrZThgQwHmcPFDGyYV/AwAc59MRTEsKoKNj3o5LJGFd3arIjcFEQzQX5mpWBf8L1Jt/mIUj3flhXPrLOeSSBu6m1TThbKefPe2yJyjVPGaLtwS3J5Rwt4GUyyvoWYfqq06djWIwBNgPc0xm+V7ImEJa3rUZe1KfIDYdXjEgFYVE2GtPkXUZ0GJGwimcq95b/w1EKvmWX/cRgQgxhmg5b2g+Vju5z1Dfyi6ZM8ai0ntYv+CA1DPwfKaWmCiNSTjotdhE73e3O2P/tu8HmlYcY6XJmiBXFHB4zun+YtIk/c0962wNQppscIKT/AwF984UZwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ/yRXFLIasp+bV/depr1T0UJ+5B064yXkIN3kExU9A=;
 b=HOupqUhUWW7hiR6SiRipDFOokJEUVBLd3IjWgDtU9WdsFfME7KAr+j6kip8SvWYQf39GmDrM0RoO95RucuMOUV72KigPL+p4aCLLmM/vMDNHsRcENLij9z7EPJsi+li1XpJ886ZElArR3tDeTDwHW5otZW8R/QX1ZYY4mzdt6Zk=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 14:57:55 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f1c7:5e12:4b90:ecf9]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::f1c7:5e12:4b90:ecf9%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:57:55 +0000
Message-ID: <69ba2a99-90f7-4d39-afc6-971b0867a1c8@oracle.com>
Date:   Mon, 27 Nov 2023 09:57:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: fix percpu vcpu_info allocation
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20231124074852.25161-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Autocrypt: addr=boris.ostrovsky@oracle.com; keydata=
 xsFNBFH8CgsBEAC0KiOi9siOvlXatK2xX99e/J3OvApoYWjieVQ9232Eb7GzCWrItCzP8FUV
 PQg8rMsSd0OzIvvjbEAvaWLlbs8wa3MtVLysHY/DfqRK9Zvr/RgrsYC6ukOB7igy2PGqZd+M
 MDnSmVzik0sPvB6xPV7QyFsykEgpnHbvdZAUy/vyys8xgT0PVYR5hyvhyf6VIfGuvqIsvJw5
 C8+P71CHI+U/IhsKrLrsiYHpAhQkw+Zvyeml6XSi5w4LXDbF+3oholKYCkPwxmGdK8MUIdkM
 d7iYdKqiP4W6FKQou/lC3jvOceGupEoDV9botSWEIIlKdtm6C4GfL45RD8V4B9iy24JHPlom
 woVWc0xBZboQguhauQqrBFooHO3roEeM1pxXjLUbDtH4t3SAI3gt4dpSyT3EvzhyNQVVIxj2
 FXnIChrYxR6S0ijSqUKO0cAduenhBrpYbz9qFcB/GyxD+ZWY7OgQKHUZMWapx5bHGQ8bUZz2
 SfjZwK+GETGhfkvNMf6zXbZkDq4kKB/ywaKvVPodS1Poa44+B9sxbUp1jMfFtlOJ3AYB0WDS
 Op3d7F2ry20CIf1Ifh0nIxkQPkTX7aX5rI92oZeu5u038dHUu/dO2EcuCjl1eDMGm5PLHDSP
 0QUw5xzk1Y8MG1JQ56PtqReO33inBXG63yTIikJmUXFTw6lLJwARAQABzTNCb3JpcyBPc3Ry
 b3Zza3kgKFdvcmspIDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT7CwXgEEwECACIFAlH8
 CgsCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEIredpCGysGyasEP/j5xApopUf4g
 9Fl3UxZuBx+oduuw3JHqgbGZ2siA3EA4bKwtKq8eT7ekpApn4c0HA8TWTDtgZtLSV5IdH+9z
 JimBDrhLkDI3Zsx2CafL4pMJvpUavhc5mEU8myp4dWCuIylHiWG65agvUeFZYK4P33fGqoaS
 VGx3tsQIAr7MsQxilMfRiTEoYH0WWthhE0YVQzV6kx4wj4yLGYPPBtFqnrapKKC8yFTpgjaK
 jImqWhU9CSUAXdNEs/oKVR1XlkDpMCFDl88vKAuJwugnixjbPFTVPyoC7+4Bm/FnL3iwlJVE
 qIGQRspt09r+datFzPqSbp5Fo/9m4JSvgtPp2X2+gIGgLPWp2ft1NXHHVWP19sPgEsEJXSr9
 tskM8ScxEkqAUuDs6+x/ISX8wa5Pvmo65drN+JWA8EqKOHQG6LUsUdJolFM2i4Z0k40BnFU/
 kjTARjrXW94LwokVy4x+ZYgImrnKWeKac6fMfMwH2aKpCQLlVxdO4qvJkv92SzZz4538az1T
 m+3ekJAimou89cXwXHCFb5WqJcyjDfdQF857vTn1z4qu7udYCuuV/4xDEhslUq1+GcNDjAhB
 nNYPzD+SvhWEsrjuXv+fDONdJtmLUpKs4Jtak3smGGhZsqpcNv8nQzUGDQZjuCSmDqW8vn2o
 hWwveNeRTkxh+2x1Qb3GT46uzsFNBFH8CgsBEADGC/yx5ctcLQlB9hbq7KNqCDyZNoYu1HAB
 Hal3MuxPfoGKObEktawQPQaSTB5vNlDxKihezLnlT/PKjcXC2R1OjSDinlu5XNGc6mnky03q
 yymUPyiMtWhBBftezTRxWRslPaFWlg/h/Y1iDuOcklhpr7K1h1jRPCrf1yIoxbIpDbffnuyz
 kuto4AahRvBU4Js4sU7f/btU+h+e0AcLVzIhTVPIz7PM+Gk2LNzZ3/on4dnEc/qd+ZZFlOQ4
 KDN/hPqlwA/YJsKzAPX51L6Vv344pqTm6Z0f9M7YALB/11FO2nBB7zw7HAUYqJeHutCwxm7i
 BDNt0g9fhviNcJzagqJ1R7aPjtjBoYvKkbwNu5sWDpQ4idnsnck4YT6ctzN4I+6lfkU8zMzC
 gM2R4qqUXmxFIS4Bee+gnJi0Pc3KcBYBZsDK44FtM//5Cp9DrxRQOh19kNHBlxkmEb8kL/pw
 XIDcEq8MXzPBbxwHKJ3QRWRe5jPNpf8HCjnZz0XyJV0/4M1JvOua7IZftOttQ6KnM4m6WNIZ
 2ydg7dBhDa6iv1oKdL7wdp/rCulVWn8R7+3cRK95SnWiJ0qKDlMbIN8oGMhHdin8cSRYdmHK
 kTnvSGJNlkis5a+048o0C6jI3LozQYD/W9wq7MvgChgVQw1iEOB4u/3FXDEGulRVko6xCBU4
 SQARAQABwsFfBBgBAgAJBQJR/AoLAhsMAAoJEIredpCGysGyfvMQAIywR6jTqix6/fL0Ip8G
 jpt3uk//QNxGJE3ZkUNLX6N786vnEJvc1beCu6EwqD1ezG9fJKMl7F3SEgpYaiKEcHfoKGdh
 30B3Hsq44vOoxR6zxw2B/giADjhmWTP5tWQ9548N4VhIZMYQMQCkdqaueSL+8asp8tBNP+TJ
 PAIIANYvJaD8xA7sYUXGTzOXDh2THWSvmEWWmzok8er/u6ZKdS1YmZkUy8cfzrll/9hiGCTj
 u3qcaOM6i/m4hqtvsI1cOORMVwjJF4+IkC5ZBoeRs/xW5zIBdSUoC8L+OCyj5JETWTt40+lu
 qoqAF/AEGsNZTrwHJYu9rbHH260C0KYCNqmxDdcROUqIzJdzDKOrDmebkEVnxVeLJBIhYZUd
 t3Iq9hdjpU50TA6sQ3mZxzBdfRgg+vaj2DsJqI5Xla9QGKD+xNT6v14cZuIMZzO7w0DoojM4
 ByrabFsOQxGvE0w9Dch2BDSI2Xyk1zjPKxG1VNBQVx3flH37QDWpL2zlJikW29Ws86PHdthh
 Fm5PY8YtX576DchSP6qJC57/eAAe/9ztZdVAdesQwGb9hZHJc75B+VNm4xrh/PJO6c1THqdQ
 19WVJ+7rDx3PhVncGlbAOiiiE3NOFPJ1OQYxPKtpBUukAlOTnkKE6QcA4zckFepUkfmBV1wM
 Jg6OxFYd01z+a+oL
In-Reply-To: <20231124074852.25161-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0066.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::43) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|SJ2PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: c1224e94-307f-4d41-f828-08dbef593c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mkdpxwEe5SnMwfbpN7cRV8ojIwQ10J4WGYuXYzI92Br3ojqvKkrejAhen8lTR/6jReX71pVakm8688VbFDtHRJd4r7YpXRTW4uWftHi7mdisfRWYv5Uhn+w4gwuRCkiTUgdUHL+R4aoRofMh9wxJTRj/D0gex+HpA1WYnDlH4fJ+/DntykNeFgfxZyHHquVesvW7zK0iUO+5cF3ocEj8dQ0FjwHyDDaOamR/eAbHEDy3CTOFwmFZoM8AnMfz2OLI0WOCCWqGvT9LXMK59wiwUygXy1DNwsdPmQ2MXH5f26t76ph71bdRrHnnhlt6EEMy0sY1xfukx7bT6XL8E4Q8VuANhT1ZISrqtz8N4sA/zOZVcgPzQxOStwI25F+cGQzB3tdPhLg8lacVU6SVdrRWkQAostrSnyuu1RGisoafnCaieqV9bnk9qxiEakY/Z0Gu6K4EXHth7GHcXLhhc12yz2so7dJJ/M7fcpcxxSa6XcBzEhcy3mCMBsmEBaGYjaGgfF4JYxUTvbfQpZhMEol4Xy0WfjT9cQ8xy6UACE8gBKgY+Qr0Z7EGIOjkC24I03dDBI048KA99vGnbpCpOPzEzJ3WML+GLTI/IAPRZzkp1RCI9trROyMBIMBltPOgTGP8Ucb3pyfCkY2LsgijqEYjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(44832011)(2906002)(4744005)(31686004)(8676002)(8936002)(41300700001)(26005)(66476007)(66556008)(316002)(54906003)(66946007)(6512007)(53546011)(5660300002)(2616005)(6506007)(6666004)(31696002)(86362001)(38100700002)(6486002)(478600001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVNIWVJqdUR5bzRzZ205K2JCMnRCRlRXYVUwdURUeDdhWis4akluUGIxRDlB?=
 =?utf-8?B?MVcrMHNiWjFodmpqU1V5cVBoMkZBYTh0QnBHMkNhT01Wai80bC92ZDJ6ZExK?=
 =?utf-8?B?UnpOVFRIYU02SG5DbHVZb0ZRUXB2eU5LbHhXRzJXZmw0cVRhbTJCamNQOElh?=
 =?utf-8?B?R0h0cGI2SnBZMGl2NlhPeVBCZS83RGpFUGlRS1ZmaENTSFdRMTRXcjh4aUVz?=
 =?utf-8?B?REJMZkhQQ1ZZNTNaVlAyVVk1eEt0bDVnSzREeVpWZHZHbVJLNytvelorK2dy?=
 =?utf-8?B?cGZ6YTVEWkNMTFR3TXcwNEI2YlpFSGZhMElybUJRckRNVUxuVTFLR3YvUStL?=
 =?utf-8?B?UldQWnBCbjhIUVVyb1ZJYXhURGpTWFlyWExDSHZ2TnljK0REaXJPVnB0TmJ5?=
 =?utf-8?B?QTd2Ynl0M3dRaldFSHJURmRIbnRiV0xyTksyNytvYUJYRzh6cXovWDY3SkEw?=
 =?utf-8?B?VGVTVGg3QUhWNmZCcVUzVnBNaDRHMi9Pc1FIc0pZTXVXTUU4MUczYUwvamJa?=
 =?utf-8?B?Z3VlS1JUOHAxNkhpc1VLUGpQUXNNb1c1ZEhIQmpUNkFvU1phVHR1cDdKQ0k2?=
 =?utf-8?B?ZmpIMy9HS3ZKNi80bUw0WTFhSXhhcCtqU29pNkNUWU1jYnEwc3p2YlBnRCs1?=
 =?utf-8?B?WEk3dlA3eTk3aXRacy8vVFdJS282dU1vRDB5OFZBSktJVVhuL3U3T1N6M2l5?=
 =?utf-8?B?Z2MxSU0vcGdQNTJrSEZkbzZOemFUaUplQ0lnOUEwWlFoRjZibUNhRk5vUjFa?=
 =?utf-8?B?WkJNL1NDcGNnMGpieXN5dnlCdXN4OVYwZ0dCV29hanRQL2Q1WUNpWjEzc1BJ?=
 =?utf-8?B?QjN4VW5FV21CZFBYVXVkbjNNclFEOHFKNlM1cU53Lzc4TU1IcXk1VFhPWnNh?=
 =?utf-8?B?eTVuMldycTZhREw1SENBZnhSRkhNUVorZm9GdStOZWJzWkp0TDVkS25SKzhT?=
 =?utf-8?B?eklWcXlZRC9yVGNiZVRvRmxEb2ZWcEZwbkNRbytSbGhtM2t2amlsYkJDaWFv?=
 =?utf-8?B?SE4xcTNteUxEeTB1YTVDd0t2ZUdZNHg5Qm12RHBEM2FzZEowRFRhQ0ViNDgx?=
 =?utf-8?B?WDBsYWJ1eHozM29vWVM0NVk5WWNJSU8zbmhaVXY4T25HWEhwNmNPeUJqMmRT?=
 =?utf-8?B?SC9YQXJuOGpEVXMyN3FVWFJMVHcrejA1dis5WnZPQ3JLRzRwM2NwVHlUWFdl?=
 =?utf-8?B?UDZ0aWpJNHd2R0FwUDdQUlZpVEJmNmcvZTg2VFp3MTQ1b1YvenZaejZtODBC?=
 =?utf-8?B?WHJDaG5jamNxTlBKZkI1ZDRhMUY0dVVwUFpTajhkZTVXRFFWMU9zSHlrWlQ2?=
 =?utf-8?B?Z0VITitIbEZ4S3BUYzMvSE5UNGxBbUt4ZTBBVUoxQWtaYXVTU29QSExwVEN1?=
 =?utf-8?B?NDVTcXF0WmxqQVcrQ1BXOTNJS2NpdjY5WWl0MjdNS0xERlZTdkdmV3dVUVBs?=
 =?utf-8?B?NzVqaGtCZzMraTBkc2V0TGpyT1lEWTRGR2VXS3B6RW9yOTVmcEtWelpKL1A5?=
 =?utf-8?B?MllsSHVyTUo4VTdYU0xTcFdDZklqQ1liZU5VVHlCWmlpTjZvcnlRWXYyUEpW?=
 =?utf-8?B?WmJaM3hnWVFKdTNPQUtsaC81NTM1ZjJGQ04zbG9jYjczbVlCelBtelMvM0RQ?=
 =?utf-8?B?OXRjUzQwSlFRSFZOeXFCRzlMS0hmUHcrOFhiV2FFM3hSMnhXeU5RMUZzbVNP?=
 =?utf-8?B?SFVsV0Z5N0xrbDF3dXlKeXl0c0wwb0IydngzTjJVcklMaXFicXRYeWdGL1k3?=
 =?utf-8?B?ZzcyR0d1V3BvRURjcVlFYkNuRlQyNGJURmhXYkJpbnYwMUZRRFBZZUFjQmps?=
 =?utf-8?B?NmQxTkR2N3pXdlhUZUl4ZHhWazZpOXRxajRhZElveHZ3YUhQMHFEMmdUUHRP?=
 =?utf-8?B?T1JLQ3V6M1lnbUdnMUdlbmpDTzhaN1VJblhzdjQ0OGVhSDhWbjF2SkVXU3hx?=
 =?utf-8?B?eVRUYnphK0U1TWVRakNPeGdhd3lXWTZNWmVNcUVkQzVFRUtMZG1yckNyWmU3?=
 =?utf-8?B?ZEpmVXlQSElUdkxEbnVnWGo3OTFNR2RER3ZhV2hlNngyQkx1M3dsZERhSFJa?=
 =?utf-8?B?Vk1JcHNjT0NjU2hnc01IUzlYdGtsditWeFJUUHU4Mk9Hc0hRV243R2xzbko1?=
 =?utf-8?B?WWZ3NHpUeXBBL3YyRnZyNzVCdHhYR0VoZWlKQ0tGZndoYVV0c2kvVzFCbm13?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZkthYzZTRnZzTjg4NXlNY2FYV1hld0FMc0hMOWJYcHVKVzVSajRZNHFWcjFp?=
 =?utf-8?B?SkNtZ2pXYVk1QVZZWVM3Zk5TeFBSM3JsYVl4aTZDWFZCTjExRWpxSzZiU2NC?=
 =?utf-8?B?MlM3VWtGT3pDeHorM0FZRjEyeExUVElTSEZWTll2ME5vbEZ0ZXNKaVJqVkhW?=
 =?utf-8?B?VUxwS2Y3RTZ3eEJmMzVpanJha2l3NDRPVmR5QjNjd3lybWJxS29PWXVWd2Iv?=
 =?utf-8?B?MnhzNVRVdU40RGdWQjRvdWFMQTRqVUkrTkJzTHF6RVJpeFFOZzNIL1hjY2Jq?=
 =?utf-8?B?YWQxSFBTWnA1SlpraUxJNEhDRE1qWjN5RlBQangwWjZzY3JpSThYZGNYalZu?=
 =?utf-8?B?TnRYM0dLaDhMaXBWSEx3UXZUMUJ4M0dOR1hxb3RhUXVHQUlKMmpjdHVKVDd1?=
 =?utf-8?B?VUxOdS9ZY1VjRW5PWDVqdHF2ZXdjN1o2MXF0RCthWUIraUdCYk13YWh6SHAr?=
 =?utf-8?B?WEZNK29lMWc0YU1Sb1JKSDkzNGdTYkFveVJmNy9GZHh0OHFLUjBNRTZaa1JC?=
 =?utf-8?B?QWhQSXFtRVREOURYQTVibzhUWlVUOWR4NkpJMVZOVVFjWWRMZWZ2RnVLeGpM?=
 =?utf-8?B?Zm9menI5enR4Q2I2QmdGWUtrdjdmM2JzN2Q0WTJqejR3cFdyclpISldCLzdQ?=
 =?utf-8?B?R1A0ZWhVTkQ1cjFBYjdDNFZLT09JMXNWNGRoQ3JUc2l3L2h2Q201OHluY1B5?=
 =?utf-8?B?ckNwN3pNM29lOFBhS1VIbnBzMkxSSXBJeWdQWDFYTmJLTnRaSmtFNGR2Z001?=
 =?utf-8?B?OWpWQXBvWXZrSDdGYWRaRWx0Z2FYT0ZNN1A3UXZnNEN6Sml2LzBBa0dRYlNK?=
 =?utf-8?B?aGRCeHJrY3RZQnBTMkFTVThCTVdkUWt5NnZ1b1BpbzJ4eG9Dc0kxdDFLVTNk?=
 =?utf-8?B?RitOY01BSy9sbWt3dWFlR3JnVUJZRXo1djMrWjBmaGRHajFNMnJlRUpEMVdq?=
 =?utf-8?B?VFBHY3Bha0p0dE1VS3Q0aHh4WkZIeDJzL0IxZlA0Y2hjalZWaTAwaUZxanlz?=
 =?utf-8?B?UFVsY00vMHFIOUxhNzV0NHgwR2xwenBvcmZaUlhRODdmeFZzc2hvZDRtS2hF?=
 =?utf-8?B?TFdreEpFaVozQTNUN056a0FTdmhHN0tEMHNINnRuQU82YVhaU3RHTGZzVURQ?=
 =?utf-8?B?SHByMTRacnhOOE83LzVrNFlNUVdodHg3WUxkZVFreWNOVEc2dWJHOTVCQ1hU?=
 =?utf-8?B?S2JOQVNoOHNVSGhFN0Z3aHIyWC9NV2IzbUo5a1RiTFJGdHB0UWdMbnJYZmR3?=
 =?utf-8?B?VTdqZG56RFpzdDltWmpVZEREeDlSOWhZenRyWXdaTElaYzlwbW5RTUdyRnNX?=
 =?utf-8?B?L1ZsVTN2Q2NRZ04zaWpKS29DenVmVE1UVjZzcjY5VUZnbWUxZGZPVWljV0NJ?=
 =?utf-8?B?VHE2MmNJTWFWTUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1224e94-307f-4d41-f828-08dbef593c7b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:57:55.0217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dh+6rpqBGdEp/I1l2afm+7Rcu7osUZxyYr6OwucU9Drx2puWb+nH9BXwL3ELLqOfEQovgtZ5ivBM4JfQBmszZzENCsivn2JX4rpooghQjbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_13,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270102
X-Proofpoint-ORIG-GUID: lsAtb85udv-wQ7MVwfZq2cVdKscrQT9m
X-Proofpoint-GUID: lsAtb85udv-wQ7MVwfZq2cVdKscrQT9m
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/23 2:48 AM, Juergen Gross wrote:
> Today the percpu struct vcpu_info is allocated via DEFINE_PER_CPU(),
> meaning that it could cross a page boundary. In this case registering
> it with the hypervisor will fail, resulting in a panic().
> 
> This can easily be fixed by using DEFINE_PER_CPU_ALIGNED() instead,
> as struct vcpu_info is guaranteed to have a size of 64 bytes, matching
> the cache line size of x86 64-bit processors (Xen doesn't support
> 32-bit processors).
> 
> Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.con>

although I am not sure in usefulness of BUILD_BUG_ON --- 64 bytes is part of ABI and hypervisor already has its own BUILD_BUG_ON for this.


-boris


> @@ -160,6 +163,7 @@ void xen_vcpu_setup(int cpu)
>   	int err;
>   	struct vcpu_info *vcpup;
>   
> +	BUILD_BUG_ON(sizeof(*vcpup) > SMP_CACHE_BYTES);
>   	BUG_ON(HYPERVISOR_shared_info == &xen_dummy_shared_info);
