Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D1806DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378100AbjLFLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378192AbjLFLTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:19:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA4C137;
        Wed,  6 Dec 2023 03:19:09 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6BEPAW001660;
        Wed, 6 Dec 2023 11:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WdHS4QRrfZvHC7fm++KINmIX2iGh9wLBGS4zK2bcGcU=;
 b=gqtnmY+4mEAKa6cxGcMbXL2Pox7X8eV/3pYXieYci2oGwEBxJxAvSAzBG0Ld0l8iMceH
 gIe2soVeTrLz79LpP7Q3eQEC6y38k9Rlr5Q6xBHYq6MKymFn4J13X4etRwbMJekWYyuK
 WGMpmM4Vs64ppkluitkUrYXtpUfa+0Sd2OfIDOaFPis0FD2kCrwF6AlsxC4Esl7t1plF
 ffveDNEyx2jMMnyZhV67XI4SPsUFMxzMGq0qINuJaJCASbWi/4ZzYs4bktkQQXLAVzsq
 2Ykmv/SayH/9zpsWWZPXeooNg4AqMfHcRHrClgFWYRD8I17VBNMP/y0tUh8Wra9O496T Ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda169t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 11:18:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6AEwVh032684;
        Wed, 6 Dec 2023 11:18:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utan8ymnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 11:18:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jT72rymYPjgSg8E/1gIHL/KsIn9bNo6LPBMrf5Ql6V5f34MWWujZ7Egpnln269ZevFRIVPcNvKHXTL32EvnREqOPImEakLX+25d4JKkYaYh6y1bZikmAG17qrTybwbiyxAkexjk3LDOxp+1eSiI4rJsxfbS+vrcvzHURROrPjq/mrNVOsP9PBrbEApjXYyOpHuVfjLf7rW1GxZ1VXiLGIefWJ+CoEpHMeCYoYCp6OdW06Pj+D3C8ooRUYdkz1tZdRrC9bIsmoc2v68oRm2poBF+BQ4eFmHPgi8IJAUtfnhF0Af/xRK9vMaOVs+DMotSAaiw01nKW2ZsbJGy83IsRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdHS4QRrfZvHC7fm++KINmIX2iGh9wLBGS4zK2bcGcU=;
 b=RmTzOlqRLH3kv/xb1az5y5uBx6Rb3oPAoUb8tmuy76VouW71ei4uEedZ1kz7ZEuH36eIcKws9wvvh5RZiDWOtU5r69GWGjw9zf6Fx4S+c8hdtii7I2gaXrumPYloSOE1umHHtgU2PSUEidgsZG9GKOLWXFEENsXey15tN9m1qfe5NxDArz1B+F+UUgdHXqzY5YIByKnyKrUKEeHIvfaRnXGoQCyVb220g1uan8XC37nIASxF9kX+hexZs3ackUPH+m6J7YGDGXRbKxRF9DuGpjJ0RHCfwna7NJ3WZyIR5nKrBHoa14U3mR615FC3xDH2v7DiIzlyQ7ZzojJrtXt72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdHS4QRrfZvHC7fm++KINmIX2iGh9wLBGS4zK2bcGcU=;
 b=SiDUmdK8FUw+SaIoLepZsg8hHByTDJsOdvzpng96pQQTyz7Ih7SPgWci3gpTgbppgDLVZtVBXcIH6mFaMIsqbTtKUg7P2s3icPIK2h2pD/R5VpJe+M1XX35a0pPP2eJilV3IcFKMgfPBJzBBUWED1+6zJglMcsauER0UHOVUj/M=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB5231.namprd10.prod.outlook.com (2603:10b6:5:3b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 11:18:16 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 11:18:16 +0000
Message-ID: <85da34cc-6d01-44f1-9733-439561ab55ac@oracle.com>
Date:   Wed, 6 Dec 2023 16:48:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/64] 5.15.142-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231205183238.954685317@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205183238.954685317@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::20) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0617bc1b-765d-4d2b-8296-08dbf64d080b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udYt2CD4gQu9BIxW5zr+Md1NyeUlkUVGj9h/YQptvV7ZoBWTLEo4yw8eSKhYT9WJvihlie8TunrvBt+r/J3rH843jMFaCVj3ltAyxgKAT0dZrVCA9qjRDLQbC64bDONtuPkPFbwHQtuLmnd6GaMX59W5kHWJBWlk5+liV/HZsLbQ66SxznmOvfNIFEYUAXFGB7npxpzHU5y1wBZnVnATOtdLQMFq3JWbl9GCSdRQn0aq0lcPyLmyjqSUuMv74rUOsvXjDa8GW5kaHjDfwAl4CRrfPXrUb4KNBrhmMZ6KPch8NJOLoD1vMrPCcU9LXP+m5PoJVc2weJxkx8/sUxclGLb74i3sytfsbVjUmNNHRCsBw5RAo9wKm3H85Spzhvj7rTZw4CISCC21aa2wHS2hFk86eSjfb5Z7YBb72X3kQUsTxCYocp6bThwNhZMtPOowS8gzlyR82l0CXcxzlJzqnIGyoj2N3BnhwVUhkLy1z3gm1Yc8yAztoY1h0u7xNHWn7jrcCIcUmWbGz8AlL5x7+dvP3z6iAZeP7NLA27XE7Z/kL2vkDN61ouHrZpiG425U+36Fe/R5BC1BKBYzOOZBE53R4Yb0G016jSzb49/tMXzB9wLCqqMzCvCX3fiP1+qvHGqbsfz2Sh57OPKhv4f/hA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31696002)(107886003)(31686004)(2616005)(4326008)(8676002)(8936002)(6512007)(6506007)(53546011)(26005)(6486002)(38100700002)(478600001)(6666004)(966005)(66946007)(66556008)(316002)(66476007)(54906003)(2906002)(41300700001)(36756003)(86362001)(7416002)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThZV2dLUkM1aDVJV2ZGZlhDNVJleXN1K2FEckhZQzVpVDl5OGJzSXFkZHln?=
 =?utf-8?B?bHpkbDVSeWtjQUFyU0pCamZYakZ5WWFnRkRkL0NxN3lNRWFaM3RXNnd4YnYz?=
 =?utf-8?B?MFBkbVJjOElyQW5JeGhRaG5aNCtNSGpjY2Y0dTZza0dMdGlzVVVNdHNIb3hW?=
 =?utf-8?B?VUE0MTRwczJOY3E0YngrbnJiVGNyaUZpQzByQXFZY0tZbkJqT3JJSzdqNWdl?=
 =?utf-8?B?Mktaamt0ckpVNEtUQXRUeE1rVFN0VkVEaGlsekpoNlhtMlZUZlhhOFE5bE9Q?=
 =?utf-8?B?SmJod1RFdmxTZ3Vham40YUhYaHhSZEtnMU9qcHRSLzR6Wk1VZFlWemVDNkVT?=
 =?utf-8?B?Y3B2Nm1ZUTh0dFBqeEtQdGhvWHFQV3ZvYklMZ3BMSXZCSWIzUW5xWFZIZVQ5?=
 =?utf-8?B?QWJhVzYzbHVCTlc0MlNXWkZUUmo4V2JXazVNSHhDdk95MHh3azJ4d1JPYTIr?=
 =?utf-8?B?OWZtcjZndzhPNEdiVUwwdWRTQ3c3SEc1UW96NUZxdDBoZmVqUU5yVDcvTUlX?=
 =?utf-8?B?TUg0QUFFV3ROK0JPYlNJUkJrbW1mdEI1OFlzOGtRWTRJQ09INGxFaW5FMUxi?=
 =?utf-8?B?MDlxMmtkbG9rUnVFVWMwUlF0T3NPNFFzM1U0d1k1VXdKak9KUXUyaGhLK3pD?=
 =?utf-8?B?Y1ZrbmNVUHo1Sjh2cUs5VE1LNkh1NnY0TWRjWDJkUHpJNE43TEsyd25XQUV4?=
 =?utf-8?B?VDEyRGlkRjArTlUxZ3dyWnRMOUUwZnU1djB1b0pHaW1ObzNoTEk2RVZJUUNJ?=
 =?utf-8?B?dXZzeGdsMDhCVlZNR1hkdEZSeXBpZkZGcXNIQzhncmhWdzNVZlNnUUNyOXhF?=
 =?utf-8?B?K0xCemcwR21PVnRXRlpVNTloUXRNVG1lWis3elVnZzlESlQ4NDJNRVpBK2x0?=
 =?utf-8?B?MStTZWFnQ0pPYzVqMG92djFZQlA5cndSMXdXWWdsRmtVNUZlSWhLVUpxb2JJ?=
 =?utf-8?B?VjYxVW85ZzNZMjhyZjBsRWlWZjMveGtUWHEwSmtyTmxBN1RLUVI0NWp6Y3JK?=
 =?utf-8?B?LzhjM0RYaEVEQzVlU0tWQ1paN3JLcmdrYWlLaHp5ejVDMXp6K2M3UDRsOTU5?=
 =?utf-8?B?V3FJWEZvOHBoZFc3WVAxYzVDWHFGY0wyM0NCRDlhdEVqZG1VNTUzQ01ObXZV?=
 =?utf-8?B?UWFRY1hjRDBNMUJJSE5uWWJtcndvUm5Hb2ZDcFl4dGJxWnpqaUVwVEhCSE9i?=
 =?utf-8?B?b011amw3SGtUNFBxQUQwZ2I3NDJqVG9zT2syZUpsUFNBTnVhcUFjVjJLVFR1?=
 =?utf-8?B?ZGZwemVzVTl4cUs0RjJsRGhoNU1FK2ZMSGM5UU5DOENEWXZXNVpnaEh5bDFq?=
 =?utf-8?B?SXlUQkJVNkY5S0VaRVlBeURXNURxd1ZZVnZuTE5ncVRHZHRONmdBY3RiM2pX?=
 =?utf-8?B?cktVR2pjZWVuRCt0TDJnN3h0K0ErTElFU2Fra2lRVlA5V2t3c3I2WDluMWhm?=
 =?utf-8?B?dEYxNy9NcXlBdU11REVTVVEyMWQ4VHo1RmhqL0xOdlJKeXVLc0hwUnl1V0t6?=
 =?utf-8?B?UDJ2bEhmN29rQU9sT2dsT2RTL0Q1WGF1cklpcnc4azZiRVpwQTduRjNvRUpM?=
 =?utf-8?B?WnVYYThjU0FyelRsc2Y2cG9qR1MwVDJMaGVpeTJ4K29KNWs0UHYxa29QcW95?=
 =?utf-8?B?QkFQM0JYS1VrRmZhbWZBMFRialNCdkxFcmhMR1dQaERMVi9YdllIQzg0VzVy?=
 =?utf-8?B?czh1M0VQYjY5bUdQbG9rSUQyeU43bTJ6bUZpYU02N3c3a2NUbHBwR3ZUTkZx?=
 =?utf-8?B?UFdaSnpsbk9qZUM3YmNRb3R4cC80Mm1CaFdRSWtKWUFKZGFIaTBZeis1Qnk5?=
 =?utf-8?B?ZS9aeGpBZmw0aTNQaFhXZmhscytpaXhDamJnVDhzOU5jY2k2dS9RczAvbk13?=
 =?utf-8?B?Z002Z2RDT1lMVVFXK2tVZVNHY2RSQlRJZkg0QTgraEM4Z1pqRDVLdGwxak5z?=
 =?utf-8?B?TFh5TlY4SWZucHB2TU5oUFIrazFvZ00zSkZ1aWpSN0puOHNDa3EzVjJWYk1G?=
 =?utf-8?B?LytjZURJSEVLWjBqa0pPdUdVQTBkQ3JiOUhXS3FGaHdKTWtSeldTYXNrcUYz?=
 =?utf-8?B?SW5GeXhRQk5JUG5Zd0ZzNzI3Ym9NSkVpZjhra29wR1VsT2lIb2NjSzA3S2s2?=
 =?utf-8?B?MGdpUmZKWWhmWEY4L0lEUCtYeXpVaGYvTUtZeFk0ajI4Y2VOTmJuYnYyUVN6?=
 =?utf-8?Q?KEiy6cMFBsgjhZL9wa/kpS4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2MyYnlEWlRMeDhNMW5lZHg2Q0YzcWhBeE42SGF4NnB5RlZOWUVGeExQbyts?=
 =?utf-8?B?U3FCdmw1bmkyV1R6aVZ3emtmL1pCQ0tjUURwK2IzTkNpRk5ITWNhV1VFTWlJ?=
 =?utf-8?B?b3BwS2tTcktNOUcxWlVQK3U5MXVXUVJDUHRJTnE1SjVFU2RWZ3Zhb1J2czNE?=
 =?utf-8?B?eWdwYW1oWWwzZ2tYZUQzSTBWM1ZFRzE4WEZYRzJOaDBPM3RJL0VyS1NZbnFq?=
 =?utf-8?B?ck44UkJMejd2Y3QvVzFGM3RDamdMSnF6RnVFZk9qSEtoV1RUQzF3MkhkQTZB?=
 =?utf-8?B?bmZpaTNEeDkrTzdKZWtzVVVReks0alp5bXFmbmUzbnY4TG4xR0RuY1pjRHI3?=
 =?utf-8?B?bWprU2oxMUlXd0NtQnM0ek9ZSnA5WE45cU5EeVRuTlRQQnpEM0ZYcytVdFR6?=
 =?utf-8?B?b1pDYXlPNFBuanlOSm0yU1JMcENmWlpLN0pUQzA4eDRodDJ0NStzSm13UnR4?=
 =?utf-8?B?cW5EUGJ2eW9QaHZYcEE2cVJCSmtKRXhDdGJTdW1vUXZqUHQ5bjJxZ1V3RTIx?=
 =?utf-8?B?M3JMWmhCSlB0cFdUbnFpbE96V1U5anc3bGVuN3NFQWVqU0RhenlDeUIxclJE?=
 =?utf-8?B?Njc4RTROeEgrb3JpL1VZaThSZFlwUGpDd1ZhSWlvRnlMSU1JZXoyMjBDekI4?=
 =?utf-8?B?OUVKaVlIZncvczI3QWkvMkhNSkV0bDJNZ3FHb2hsNm1SZ25VZ3Y3alB4eHJN?=
 =?utf-8?B?aW5tRzhmWXovd0l1NDVXY3gzNmdPQ1ZGNkFlWWRzTTZyVm9QYlNJU3JuSmor?=
 =?utf-8?B?VklZT20xNUxVaUF4ZTY4VUx1bWR0Yi84MDAxTDVMYXFhM3BaS1FYd0d6RG93?=
 =?utf-8?B?QmNlejJaVXE0ckE3YWNNQW1BWmtFdDNuVUlaQmY0YUdLUjJ1UTV1bnhnd1dh?=
 =?utf-8?B?V1lOUWlqU0VUMlNEUFdHTlZ0YzhBS0VIYTRiaEEveUdveGVOMHZ0Sm9DelNm?=
 =?utf-8?B?U2xLcVk4elA4bFVRbGtmYTdkOXFVcTVqazhjUXF3RFFVT1FOUGE5em5IbXdx?=
 =?utf-8?B?QytaMU9VaEF5OWJTSHN4aGdaRmVReG9OVVFob0Voayt4bm1VTENDUVRSYTNZ?=
 =?utf-8?B?ZjRhSkFWZHFtWjJJMk13SjM1UE5sYzB1bytwU2p2czg3YUcxSmUzSHZTTDFO?=
 =?utf-8?B?K1dkaXJCbkM3U2lYTkI4ZHJ4YzQwNEVkZDU5dnlLenpTcFNiRkVwWkt0N1pS?=
 =?utf-8?B?RnkrdVNnWkdWWjlOQkxHLzRwRjZVWEN4MTdySnNyVzd1WTNmaUJRbUR2a1E2?=
 =?utf-8?B?YVUyRzNuWnBrZk1NK3g1VXFNTS9jQUJnejgrMjBJSHZQdFduQ3liWVplcDZL?=
 =?utf-8?B?VEI5QUliekFmT2F0Tjlxai9zcXpNRU1VUGlmOWtGTXc5OXBySmJGRXVMREM3?=
 =?utf-8?B?ZktoalZwcFZNTkZlMDJpRVFJZ2JaZ2o5c3kzdVhSdTAzZEYwSVBaQUJ6VFhW?=
 =?utf-8?B?WVZnRTNHS2RUR242L0RWT2JFbUVEYit5RWZDZk1yQWhMRTcrTG1JeEtMb2s2?=
 =?utf-8?B?VUI2TVhxUVRmYXJGVmo4dDE5S0QwZEs3OGtiQnpWOWZnQURNcnVUK0UzM3Vh?=
 =?utf-8?Q?XSbWLg3WJy6FCxl6m4SpmcQLfkVC/KDRIvHaWZJC44MHrN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617bc1b-765d-4d2b-8296-08dbf64d080b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 11:18:11.7909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EubmAOUhIEZEfPSqFAqn4ZtDoLbReVtmh3DO5Ax/NpdOXT/ndS4Nca7ptyEmhn0AiQRt8y2CF/lkfLRpf4CFjg+UtFj71ljp9jJOYJ9/5WmlLocJUBw1v/YcVWB97db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_08,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060094
X-Proofpoint-GUID: We_B2uTQQ9DX7uq-G0cCehCHf_nY-H-2
X-Proofpoint-ORIG-GUID: We_B2uTQQ9DX7uq-G0cCehCHf_nY-H-2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 06/12/23 12:52 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
