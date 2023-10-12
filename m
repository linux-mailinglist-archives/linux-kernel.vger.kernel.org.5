Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311947C70C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379095AbjJLOx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJLOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:53:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64FB8;
        Thu, 12 Oct 2023 07:53:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEOJpv026501;
        Thu, 12 Oct 2023 14:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=btiIm/DzZlkQfV+/p6RgDEZ7M/jkW6PXyQEYco+1vpE=;
 b=qlwjVzhOVLXFIUGkBSVERNsYIAHYHsPWzd/+3jfK7KAZIY4B+IzqMxiMK1EmWppJb2Lb
 k3KlHZJShng0VACxWT3Mmq3ESv0UKj2CQgKHEsPiq8i7Ye/93pDPgJ1AMPE3+1SlntQq
 SxPfflfcIY8k6a86kIkM93Ekw/Oy4sRPSssSS0pbTL/Mq1MJHCg3WzfShaKLuHI3TEnm
 qqfRW7RIxNkCX4KETF8uG5wbVgiUfUcvMW+yTjIbEeBaa1wP6bSllQ2L0CXUymriy5aB
 CZUM78yuQhZjOhw2O/D59urXS5t01lu4LRvTKi3eqR4o8oizG5GFUrbkZmqAn7bvFYQk 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2b28x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 14:53:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CEXleX010605;
        Thu, 12 Oct 2023 14:53:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsaguk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 14:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFHS2EezSEWvgO+4MDdvuyvyWKp35IGTzaw7GwZeHMxFDcK3IRHdErSfinEGvyX07lR7RYv+KUpS0oFWxXK8aZWS4bohj0RQPvCjMmW5TnwiXYem+e+a825sfQN2hgIxK+Da/u+S7lPmpOsMFZF9D0dKTIuZl1vrE3o6p/tUkVnGMjMvqAZIzGm1u2hWI3W0R+YIgHfoGJX3s+5/8pNEvcTYlgxcsOdc4ZJXBLrDiHtnmpswuXxPj05PiaDc7QUaWeIwUsgcJCdpeZFnzYE1GKUnSYEBT7rjAGvSK8Pm6EY4NKm7Uwr57Cf9yo8RK97zo9WMXlorUkBIKmcmRm6mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btiIm/DzZlkQfV+/p6RgDEZ7M/jkW6PXyQEYco+1vpE=;
 b=Wn2Y0XYpP/ZOXqTbjJUnKvA44LQWrWuTPPJ7ULE0OTq8SQKx7n5bRoxnwoAOpnueQ8u5wa+HpTv5G9ElnQKiz+ixNX/CrWKIhL5JKbFQM91NHhDGqx0P89MtmGG0hQHMhE6ewRVQ9S6WDD7DVOezn175vTBKOKa8JuNoAjWNfFFjlErQ7mI5pbxgk5dhsTxAMAntppqGS+zRRTfSV6bjiKlfIcH8eYMzJP+dXRH77pu7kz65+WDn4jUQ8NMpxXnMqiGTT3Lqw28kENn3Ybin28pqnvDWRQO6r6owUiXPkCbqDZ9afIQrgutRD6hwX+vU10KaI5RkvDKW5HS6CSGNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btiIm/DzZlkQfV+/p6RgDEZ7M/jkW6PXyQEYco+1vpE=;
 b=LKkfwAav3eoEw2tX93qFnCRocd9cz++e4+Utf5tMdC3XzaAyVAGXBLZv6++FwRT+k4jFYH2GAEJdvcyWTA6KggLdj01CLPhwznQBMeX85hNAz4O7TrGaPzAlTnYn52gpOzWLvWbcdbNO6ZJMnp7jGl+VB0bnFubWAoAAiEXEnhY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7402.namprd10.prod.outlook.com (2603:10b6:8:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 12 Oct
 2023 14:52:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 14:52:53 +0000
Date:   Thu, 12 Oct 2023 10:52:51 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jason.sim@samsung.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: Add GFP_KERNEL to allocations in
 mas_expected_entries()
Message-ID: <20231012145251.n54lwp74gmdlympc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        jason.sim@samsung.com, Andrew Morton <akpm@linux-foundation.org>
References: <20231010141737.1592866-1-Liam.Howlett@oracle.com>
 <14679c1d-463c-4dfb-8ccb-8b58c9e36c36@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <14679c1d-463c-4dfb-8ccb-8b58c9e36c36@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb63aa3-c606-4b5f-44af-08dbcb32e9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXXU4Omo+rLawTJNIG3eGejYm/U9mYdg80qoKcsqe6pKIurq47E8BoM4qKK14tE8gOvsL6+nE1gRsXT0wUF4jIJ/K5knLS7U9u+tbNba8RtRSHJMw/7NLbqBHlcujBMVlzBdftyMApdQs94N9CuNMyMm7JxttJKBIWOULjKr2PMAXAp4vHpjZQqW/gNNMPmfVhQKsKOuz9Jjw07LKvJzqv7wsRTv3+qXMbYQd2fJK2S8pw4YNQqJrQ/Ob1CoJfA+F16/50a90M3vfRjK2hjwDCnN2jn25dQZsMEvigjeEcimq3LmCqp0XZjlWzlfIMTvD2nHM0gKq2GmXYVvRyI2Tme1JOAM759arQ+D+qykzhuiKBblT59KelWu3nKDCxuNFTuNokSsFmaMlSWaGnus9V8AuVFiJT2fTSgigqlNwxDw8M25yyUNf621GOLGXNgbZcyFUZEJipzEUHowMuPpOwBHnzyaRQg9xbbqe6d404uckT9o30EJYZ4ai7p53oNWLpRGIyNYsjYHpFWGTzKpNljMG3YZRhozLN7H2QvbG6llZpE6is9L4w5mocEX/JHGiibiuL9WgmHLhhrrAWQXUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(366004)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(33716001)(6916009)(2906002)(316002)(41300700001)(5660300002)(4326008)(8676002)(8936002)(86362001)(83380400001)(6512007)(9686003)(1076003)(26005)(966005)(6486002)(66476007)(66946007)(66556008)(6506007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGEyTkd1UTYxUnZ5NlM4TmVPTWFsZWpPTkUwNkpOYU5YT2V6cy80dG82cHpk?=
 =?utf-8?B?MXFGSklsN0VzRmlGdTVhdTY2OENwY3ZkVmNRbFRwR3RuZGR5R09MYWNhK00x?=
 =?utf-8?B?VmJnQmF6WTRwMlUvYVZaSk85VXZqd2ZBOW82alVSQ3dubGcwRXM2UHkxSThC?=
 =?utf-8?B?UzhBMHFxTkFObDE4NEYxR3o0QnhzbEU2MVlPNTdVVmtSbEptZlNhVEZlcXho?=
 =?utf-8?B?WGkyVGtvSFoydFQ3aWwrTEtnbktKTTRSN2Npc2U1aHo4N25kblNTbVRvRjBS?=
 =?utf-8?B?cmF5MCtyeXBBNWh3enZJWTRaUFRNRVdJZFdMYUtJeW12K2xoWkFqOUVxVk5H?=
 =?utf-8?B?dFh0YWlrMTZOSEx1S0lvUGRGTlpvTWRyamo3bGFWbTlsM2c0S3k4MjlpYVBy?=
 =?utf-8?B?bUdONjRleEVFd2U3Qld4cURXVjZzR1Z6SmZqaUlLb3lqbGhUN1NrUFZnQlJv?=
 =?utf-8?B?bTBZQk9hOGNBMVhkVlpISUJ5bzNrQzRydWF4djJraFlCcWRvd1BlOEpYcWVE?=
 =?utf-8?B?dVlOZ0ZEZHUzMGJ2TncyMENYSFVmbThGV0RPUkQ2dEw4VndyVG0ybTY5THBC?=
 =?utf-8?B?V2N5T3Z6ZlQzK2tTNHRQN09sbEpFcUFUb0J5VzVyTVpwYkViT3pDYXBOMXF5?=
 =?utf-8?B?MHZBU0d0Rlk3SWJybkNsSGdwYnl1ZTZQZ2ZoU2VnWGVBRmlvZDdvNFBWWUVn?=
 =?utf-8?B?NVNQcGpMQ3hXV3gyazJHWCszRWpFQUFhNmVIaHhHKzdEU1BJNndtaGk5S25k?=
 =?utf-8?B?dCs5NlRRSnVwaHJOYWVRTlNZK3dHa1dwMjhqVzdleGxCSExaNXdzTTdzcVMr?=
 =?utf-8?B?eDdlNkJXSEpnblBoTEZERml4NkVwMFd1YVFmcHZaRFFYZ0lxTlVDUVFkQVYx?=
 =?utf-8?B?eWpTR2lZSkdPdFlONlZHdTBMWDZ0VzB0QlNQaEZmaU9xak84aVlDQkd3TTN3?=
 =?utf-8?B?VnY5Q0V3ZDI4WjkrcDg4dG9hNmh4QXFZanB4QUplUVpzRDJvUEw3Sno0Z29z?=
 =?utf-8?B?K1ZkSzNUQUlhaHJ3cHdiV2dlOWFGb1Q3UE5kYTRvZXIrUk5NbjR1emg4encx?=
 =?utf-8?B?NUtaOTdmUHV5M1orUHh4cXNlZXdFNkh5dHl6VWVoTDVLNkEySWVJcDBhMk9i?=
 =?utf-8?B?TUZFOW1CazRhZjRMUEpmZkRnSjdkdHluakhKSGZrZm1TYWxCME05dkhUUXFr?=
 =?utf-8?B?SkhwUUpTSXdRWm9na0U5U0lqQzJQbXBBTld0UHRWYTlhU3RBOWpxTTFwSFlV?=
 =?utf-8?B?anV3Q3M1dHpwQkZERTd6QXZMc1liZ1NPeHlJYWxERGJpcURNQVp0S0d5Q1ZF?=
 =?utf-8?B?Vnhoc3hCZ3B4SSszYWtqTW00bzNjWlBpYkVkaE1RK0o2TG5HdC9XNko4U0NL?=
 =?utf-8?B?OFpOcUY3TEZ4M2pnRkZQcmF2RDQwN3VhVXhiZE00WFMxbnQ2UHNRcEc2Nmgr?=
 =?utf-8?B?OFBkR205L2Q3N2FGQ1Nlcmg5NzZ5bnhLSlFSajZsUEVYSHp1MXoyc3BQU0dK?=
 =?utf-8?B?SGhSSWJ2N1MxMXhQR0FrdDdrMXI2WTRmb2ZyVFBJUThJZjZGc0dja203eHVl?=
 =?utf-8?B?ZHFWeEZLdkVMMnNCaTUvK3UvNzAwYS9FOU5tYnBUQngvbjV6Qk9LSXJ1ZHVr?=
 =?utf-8?B?TUZaS2xwNW1EVmpSWWphajF6b3BsUGVrdVBkbE9mcEFWVmlaZVdTc1FrVlRt?=
 =?utf-8?B?VEkyZFhSelNuL1BQOUlQazRJR3hEUEs2aDVUblhSTmJxNm5idlFHdkFvN2lH?=
 =?utf-8?B?cnl5ZjhzakZZaVNjSlFnbXJKKzgvRG9XK0lhSFZSVUgyY09rajJmNW14Smk3?=
 =?utf-8?B?S3Y5TEJ2cHpSWEFiU2d5MVV5ZGFBR3I0bnJIbkUySVhMTDNUcnF6Rnc5dGF4?=
 =?utf-8?B?MWNmUEVjWU5GSHd5NVAvWm9zZjZoUzk5SG15bXIzVEFIRlJ6ZWdwbEN4NzM2?=
 =?utf-8?B?SVAyRkJqUTZ2ZHcwbnowV00zcXBFcEh2SEhhU29BcHJkYmhTdDhzQ0ZsSjVw?=
 =?utf-8?B?Tjc0TE5qaGIzOC9JTUVvVUdJQ2s4bTRrNUFBaGJZOHdGQ1l3SHRCcGk4U0Jr?=
 =?utf-8?B?YVZXMHB0dERub3k0b2hKQXo1RmxSYnNvd1FzZmJKbWk3NG1BWDFNVTNPNERH?=
 =?utf-8?Q?TP31kCxrGjjlvBubYzddCHkYr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTZMUVlIcXhPbU1XNThkZGI5cWNGMjlNVXdGM0djdndKYmJKRU1PaWljRU9k?=
 =?utf-8?B?QlU4cUROcUNTRHlXN1JQK0tsVGpWcE02dVlRZUYyT1cxcG9LV3B0aHMxTHkv?=
 =?utf-8?B?N01jWkdUd3QwUThqK2E4WDVIeHN0WWRZbnFydEMzaXFUZ1VMNDZpMTAzdmlV?=
 =?utf-8?B?eHUvS2tlZU9vclMrd2lhcXJHU2ZxcE1KRkprVkVadHJJTG9UQ0J5Tm5zUVRh?=
 =?utf-8?B?NkpQdHpZZ0gvTC9PVm9nbXVIeDZ3OFBCcUhGZUdTMjdEZWZBUDIvZ1M1OTd3?=
 =?utf-8?B?aHVYRm9oZVBlQ256akZUNjZuTitsTlJxTnNmb1dVaTlCRnM4MkZzUFRkZXpP?=
 =?utf-8?B?QXIzMVNxcW8xbzd5N2k5L1pzcExibWVydit5M3V4SXl6aEtSa3VhMmpqakdH?=
 =?utf-8?B?TXpqUitMZHZoRFZLYmMrTDQwd3RQZzEySDc2NytWWlMxM1hSUURnNGQ5SXBY?=
 =?utf-8?B?aTd3cThBQ3JsR3hpd2dUMEg0MFdxOEFUdkZmZmMrQUo4a1RKT2lCSnZkOHQ3?=
 =?utf-8?B?Rnp2d2FtR0FwbEhNTjVBZjhtS1pBTEpMQ2VLNzQxVmdLcTJtbXVraEtrNXNG?=
 =?utf-8?B?eW51aTNna1pEUjVlMkFwcWVtYnZnVFNRSVpCc0xUSFZkM3hZNjBaQndlSGpY?=
 =?utf-8?B?bEFMQ2I1MzhLSHhWK0doaVVobnJUb0ZLNERubVc4L2JwclJHamgzNzNkMW1W?=
 =?utf-8?B?OUNtWUpYaDl3bWd6cXhYRFFMdG5GWFJRZGhJdjN4UVpKdVo2dHlldjZUR1BC?=
 =?utf-8?B?Z3dWQ2pXbHIrTkRTQjNUbmR0cElpMVdCSW56VWp0aDdTWWpyUFhaaXFFQllX?=
 =?utf-8?B?alptRUtnTEo2SFNhZXlMbHdSTEtnOS95NkYzUnNrS3lWOFFlTCtrOGhVV2NE?=
 =?utf-8?B?TDR4bm9CeXE0YVpzazlqbVhmMk1mbDZNdFUxQnJwbzJNZ2s4Vzd3dkp1Z3d0?=
 =?utf-8?B?ZnAvVHpQK1BhSVpycldtUWorS2hKVjlhREoyOHE4L05aSytZd3NHTnMyVXdo?=
 =?utf-8?B?OTFUempjN1lvQk10OWdQcC94OHIvV3gyYzNrbXBWdUMwLzdyS0pseUFabWc1?=
 =?utf-8?B?QVlwY3M3QjZXT0dxZzloL3hJUEZHOEVJNlZxVG1iak5FZjN3VEZCNXZQK2Z3?=
 =?utf-8?B?THlTSWpkeDM5N0ZJajBWd1pUcUtrUEFkRjZkOGdNaUF5S2oxSUVoa2FwVGN4?=
 =?utf-8?B?dFhweEdyc2NkNlRSa3RQMjc5Tlkwano1Mk9YRHR0eVFndEtyVkJiUERldzh0?=
 =?utf-8?B?QXpNdktnWkd6dGp6ZHorM3E4SHFqd1hKUVI4TmErTFczUzJFQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb63aa3-c606-4b5f-44af-08dbcb32e9e6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 14:52:53.7721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85rOq2pbb0gA1DM2/0k92iCuSiFNxnrfqCkSL+cG2agDS9QX79l28B7HB0xJVuSl0Wtdz/DqJcZPoWx0iCNFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7402
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120123
X-Proofpoint-GUID: j6Sz5aYbqLZredDSWHEGeZkveK1F899I
X-Proofpoint-ORIG-GUID: j6Sz5aYbqLZredDSWHEGeZkveK1F899I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [231011 22:52]:
>=20
>=20
> =E5=9C=A8 2023/10/10 22:17, Liam R. Howlett =E5=86=99=E9=81=93:
> > Users complained about OOM errors during fork without triggering
> > compaction.  This can be fixed by modifying the flags used in
> > mas_expected_entries() so that the compaction will be triggered in low
> > memory situations.  Since mas_expected_entries() is only used during
> > fork, the extra argument does not need to be passed through.
> >=20
> > Additionally, the testing in the maple tree fork testing needed to be
> > altered to use the correct locking type so that allocations would not
> > trigger sleeping and thus failures in the testing.  The additional
> > locking change requires rwsem support additions to the tools/ directory
> > through the use of pthreads pthread_rwlock_t.  With this change
> > test_maple_tree works in userspace, as a module, and in-kernel.
> >=20
> > Users may notice that the system gave up early on attempting to start
> > new processes instead of attempting to reclaim memory.
> You still haven't updated check_forking() and bench_forking().
> It will still produce the same error as [1].

This did not show up on my testing, I will pull the bots config as I
must be missing something in there.

Thanks.

>=20
> [1] https://lore.kernel.org/oe-lkp/202309242123.7ebe65b5-oliver.sang@inte=
l.com/
> >=20
> > Link: https://lkml.kernel.org/r/20230915093243epcms1p46fa00bbac1ab7b7dc=
a94acb66c44c456@epcms1p4
> > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > Cc: <stable@vger.kernel.org>
> > Cc: jason.sim@samsung.com
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c            |  2 +-
> >   lib/test_maple_tree.c       | 13 ++++++++----
> >   tools/include/linux/rwsem.h | 40 ++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 50 insertions(+), 5 deletions(-)
> >   create mode 100644 tools/include/linux/rwsem.h
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 0e00a84e8e8f..bb24d84a4922 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -5627,7 +5627,7 @@ int mas_expected_entries(struct ma_state *mas, un=
signed long nr_entries)
> >   	/* Internal nodes */
> >   	nr_nodes +=3D DIV_ROUND_UP(nr_nodes, nonleaf_cap);
> >   	/* Add working room for split (2 nodes) + new parents */
> > -	mas_node_count(mas, nr_nodes + 3);
> > +	mas_node_count_gfp(mas, nr_nodes + 3, GFP_KERNEL);
> >   	/* Detect if allocations run out */
> >   	mas->mas_flags |=3D MA_STATE_PREALLOC;
> > diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> > index 06959165e2f9..204743bc161c 100644
> > --- a/lib/test_maple_tree.c
> > +++ b/lib/test_maple_tree.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/maple_tree.h>
> >   #include <linux/module.h>
> > +#include <linux/rwsem.h>
> >   #define MTREE_ALLOC_MAX 0x2000000000000Ul
> >   #define CONFIG_MAPLE_SEARCH
> > @@ -2616,6 +2617,10 @@ static noinline void __init check_dup_gaps(struc=
t maple_tree *mt,
> >   	void *tmp;
> >   	MA_STATE(mas, mt, 0, 0);
> >   	MA_STATE(newmas, &newmt, 0, 0);
> > +	struct rw_semaphore newmt_lock;
> > +
> > +	init_rwsem(&newmt_lock);
> > +	mt_set_external_lock(&newmt, &newmt_lock);
> >   	if (!zero_start)
> >   		i =3D 1;
> > @@ -2625,9 +2630,9 @@ static noinline void __init check_dup_gaps(struct=
 maple_tree *mt,
> >   		mtree_store_range(mt, i*10, (i+1)*10 - gap,
> >   				  xa_mk_value(i), GFP_KERNEL);
> > -	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE);
> > +	mt_init_flags(&newmt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN);
> >   	mt_set_non_kernel(99999);
> > -	mas_lock(&newmas);
> > +	down_write(&newmt_lock);
> >   	ret =3D mas_expected_entries(&newmas, nr_entries);
> >   	mt_set_non_kernel(0);
> >   	MT_BUG_ON(mt, ret !=3D 0);
> > @@ -2640,9 +2645,9 @@ static noinline void __init check_dup_gaps(struct=
 maple_tree *mt,
> >   	}
> >   	rcu_read_unlock();
> >   	mas_destroy(&newmas);
> > -	mas_unlock(&newmas);
> > -	mtree_destroy(&newmt);
> > +	__mt_destroy(&newmt);
> > +	up_write(&newmt_lock);
> >   }
> >   /* Duplicate many sizes of trees.  Mainly to test expected entry valu=
es */
> > diff --git a/tools/include/linux/rwsem.h b/tools/include/linux/rwsem.h
> > new file mode 100644
> > index 000000000000..83971b3cbfce
> > --- /dev/null
> > +++ b/tools/include/linux/rwsem.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +#ifndef _TOOLS__RWSEM_H
> > +#define _TOOLS__RWSEM_H
> > +
> > +#include <pthread.h>
> > +
> > +struct rw_semaphore {
> > +	pthread_rwlock_t lock;
> > +};
> > +
> > +static inline int init_rwsem(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_init(&sem->lock, NULL);
> > +}
> > +
> > +static inline int exit_rwsem(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_destroy(&sem->lock);
> > +}
> > +
> > +static inline int down_read(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_rdlock(&sem->lock);
> > +}
> > +
> > +static inline int up_read(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_unlock(&sem->lock);
> > +}
> > +
> > +static inline int down_write(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_wrlock(&sem->lock);
> > +}
> > +
> > +static inline int up_write(struct rw_semaphore *sem)
> > +{
> > +	return pthread_rwlock_unlock(&sem->lock);
> > +}
> > +#endif /* _TOOLS_RWSEM_H */
