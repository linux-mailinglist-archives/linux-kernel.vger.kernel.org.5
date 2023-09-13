Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769079F4FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjIMWa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:30:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66E1BCB;
        Wed, 13 Sep 2023 15:30:23 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DFhBpO029751;
        Wed, 13 Sep 2023 22:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=opeJ8j4iyXcVQLKuVS0/UBNZIfpqlFhVFOccrCv5m38=;
 b=QnXD8WzpT8aZIywGYE2oQaKmpNYblW2MSXCiT+GcxLtv+P28Nq+/umdqBMhAYIvYLrwW
 2EcryUtB0JWBua9SBpdyO5Wtfxi/bheksik9jWjHL8k49WxHpu+PIYaNpdJzgsvsNRCG
 E1PQqM1iwD0NbFf3GJs2Fbboc3Yu/LP/hEjD65LeNiKBb5CGp3mOLpwW9xWCn33PWIws
 V4pvblvGnLwl/POuVQ/5FiskvTT+xEvx3MkW5qaVl1F7/SZeTt8PLtfOkXquWRj5tFKS
 779cnavxCjFsgC6VrgXlUZcX3zDeq7BJuBaadGeP/A1lHwV59lb4DMwYUYvbBgQ9q+WC Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rbg6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 22:30:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DLmjMx002335;
        Wed, 13 Sep 2023 22:30:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5e5g75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 22:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+m06PF7LmGRX8uwnnCovKca6KN1OVhdXDUyQxZhIfUlo4iRsgq8NcNHXNS4H4neL7Oie2HuvHBSD7fCAQ/gAJgp4uYCMz2KIlKFWq76UslhpklU723CcTdvyKmUcek/R5m5+HFReeGyNLHYOUwaOJ76PG7EBTzVymXKJtyLlC7LxVewCUsDoPYvTjlRrn2zIvNNT+PMJwHSI8zfS6r92ERMutHEQgpnJ+hZXLzvYWgSPVg7daaM0oSpSwztjStPXJVxPfNPvEg6deqRuwLSbLhENfrAfvytA0l0Z4Ridrt+6SQxRcd6E5ca2g+aLG/Q5TZfhAe0v3hr7QDne+o0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opeJ8j4iyXcVQLKuVS0/UBNZIfpqlFhVFOccrCv5m38=;
 b=JRXg0UeeLX0fDljwF/h0PciC9vA/owdZXGBI6Ag+mEMME5jGPkR8LU7v7CXVyCDaCnuJSJFUuBLrTmfaB+18Q/K6eamsWvHPgywHFcOXy463jLdUHnI2raZf0mlGtuYiKKtnPC1aukR3nNhu+fWq/jUFhk2yeYRcdKtQJOfQU4XsxZn3pclSfwxEa0+dqnU2fC4Pqgk4XWe6I2jYU5c5vbrrxTzGCXugm2pMPOYSZ5mvWkWJLETQCmGZANSiVt3CNPhX5AD8hI/sJtfo2A8+rgaXyegyXDiw8nEAk51TEchmOMcDgqFZFa+aRF0gH7riM68rvP2U2Q4QclGeNPXtnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opeJ8j4iyXcVQLKuVS0/UBNZIfpqlFhVFOccrCv5m38=;
 b=Cq4kyWVDe9X2tsrUFnL1ud49ICUEHg9wCnI5v51qJn77+ti5pvgU3BQW0W6tlEDlZKJc6y0Np53qHku5IFYDiefpyT06M4tdMKstLE+QeyF1kXqi90cqMrn82QwwpQr0u+Fbs3w0pT0+X0CJo9RkPQ0DQteKPCR8hYrhBR/w8hU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB6869.namprd10.prod.outlook.com (2603:10b6:8:136::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 22:29:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::3f7b:855:6a95:8aed%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 22:29:58 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Topic: [PATCH] certs: Restrict blacklist updates to the secondary
 trusted keyring
Thread-Index: AQHZ4p0BkG9ylPk27Eafo4TPmLwJdbAVoqeAgAA4j4CAAFsjgIAADhYAgAAwIgCAAKYcAIAAWEmAgABd5ACAAEEugIAAgP4AgADLZAA=
Date:   Wed, 13 Sep 2023 22:29:58 +0000
Message-ID: <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com>
References: <20230908213428.731513-1-eric.snowberg@oracle.com>
 <097a0413b27ed9792dc598ff184730bcf6ae8fcf.camel@linux.ibm.com>
 <20230911.chaeghaeJ4ei@digikod.net>
 <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com>
 <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com>
 <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com>
 <20230913.Ceifae7ievei@digikod.net>
In-Reply-To: <20230913.Ceifae7ievei@digikod.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB6869:EE_
x-ms-office365-filtering-correlation-id: 261d8b89-39c2-4d96-a771-08dbb4a8f6ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfrwufIkRZsekByxyVeuTEo5M1jq4Jl3s2PebEos9BPl6beErUgonNQ35V40L14iAJ0ApsOO0RrDgIvrVo9wwPrW2LomemkAxjgpgRCYIY78/zYW/LElQO9+8Xt7vTV1oAftnSS4x36Gy5OFfIzfxQ4lxv6/DDhDhz+fn2iPH8PDrE0EefXAc2k4wTBCXQ4WcDISMExR5sPUlIJMiP1ST3BOvp0iJwVd8Oetn2iyUt0Pq6ctvfZm7noMX8afGleo+eiTwOMtW6SMbbqF1hg8bhfv7b1QS+WNXNub95I8mFdH0nhyaQzbquvheFsIEpVHM8vsdbcdIpW210n1Z+1TQJ8AkWLkbn3M8lO15A0ed0F5G/R1yFYRq7m+enUjuFntnRkb8yYge11yA9j4/56/L23arjt6lD6ih44SmJdfhWx6VQXxFYWVw/pu3p6nTjymom3DMCVShRKlUp6XGqb155BqU5pLSZuNETNgN5lci4/oWRwD2bvb9ypPkR2aQifWN7cznrHBMrKU6E4IKv50OmbTHRbIQsDleN1R2UAlPPjBr+nIeI/6e2c3ULMRMR0jss19QIL2xpSx6f3J9e3Cz0KzFXmR2B5ka0hDywx4zJB7FubRGXLLQK3fpyByapiK9B+qxNUMxHl//9lHVrZyPbWnKfM21a+ldofowmRCJk9YKLLa8GN4PymcZZs0sDrX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199024)(1800799009)(186009)(2906002)(66476007)(26005)(76116006)(66946007)(316002)(41300700001)(15650500001)(66446008)(66556008)(110136005)(44832011)(64756008)(91956017)(7416002)(54906003)(478600001)(5660300002)(966005)(8936002)(4326008)(8676002)(6512007)(6486002)(6506007)(53546011)(36756003)(66574015)(2616005)(86362001)(38070700005)(83380400001)(71200400001)(33656002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c29TbjZLK0doamFDOTFjZ2xlelFaV24xcENtcm1kQS9DV2ZDOC8xWUZtT3Zj?=
 =?utf-8?B?bmViOENiZ3liRTlWbG9WeVVVdTU1MGlFeHNJcm1QS24yOHI5OSs5Z2w1YkU1?=
 =?utf-8?B?cXJyQ1JIVVRKcEZLODRLYk53YkxUemxpOXovVkhZTFN3NWc1cVFwb2lCOVRO?=
 =?utf-8?B?Mnd3bFFvdTBVWnBqZEwxMkZ2NDNYZlZhbytSR3FkcWx3WEcyVm4vU2JNT096?=
 =?utf-8?B?M29CdzNwMmV6bTAyRzF2QThmRGlZWlU0ajhzQjZvVTRTQlpqM0ZWUDhodTVx?=
 =?utf-8?B?aXVvTVhQZ0tnQmk2WDNraHlGbnI2WXd3eHdSM25sRStiSVVScWI5ckJCWm1S?=
 =?utf-8?B?d00zMStFdmJpSGNXekNDcVN4VzNXdXN6eGRjbWxIUjZIcnBtL0VVV3JrK1NO?=
 =?utf-8?B?NUZ5N21MVFpCbnltQmh6UzV3cTdOdGdYN1BtUUlpMHdFOHNQd3M2Y3E0WXRK?=
 =?utf-8?B?Qi9FMzZzbklhVUZwaC84ZnF3aVRHdmw5SGtkbmxuckdaQlB2eGgwMTJ3S3ZF?=
 =?utf-8?B?U0RRS2tMNmlXQTRzV3NvMVBlTU9WSk8zcDFPQ0RmdWhMZ0luY1hEb2tDYkxm?=
 =?utf-8?B?cVdGSVVOa2gyM0trSU8vNldNamZoZk5jSlljU0ZhbmZ3ZkszUVR2Tk1tZTlD?=
 =?utf-8?B?c01jc242UDRsbnkyRzNHRmtxZWM0MGY4S0wvSnd2WUQxRjJjSThuOEpDRzUr?=
 =?utf-8?B?Q2h4REIzRXJVZnFycWdOQUdZWTJ0M3gwUThQT01Ka1dPaTNlUDUrcS9HRzlP?=
 =?utf-8?B?TE1wU1JHa1hoSEJPMXRVR3Y5c0NROVNhbnozR0U2YUJ2ZkN1cFVNZ3NVUmNq?=
 =?utf-8?B?MEEzMTNRZDd0b2xhRHU0QjRHU2x5T0ZtcjNsaHhBWm5KTWkyYXp3cVVVMjdt?=
 =?utf-8?B?TDJXblQ1aWdhVk5iUDJ1TCtiWDBQbDJzeHJKU0NJaWNSbnd1Q1p2eDQvNEVO?=
 =?utf-8?B?aGxFbTFLV1NpeFo1aG5WZzEzMk5VNWg2ZTVpNXBrc3ZoaU54L1RWU1A5aGp3?=
 =?utf-8?B?cUpaZUVhYU5CL1ZLMHJkM0lNeCtFSEs0SzFIaERSaEdtOTltbVlwU3J5L3hn?=
 =?utf-8?B?dzRXN2hEK3B2NzVQNFhDUHNIb2ZHNE0zNFlpZktHNkc5cjNyc1BIQTY4YlNh?=
 =?utf-8?B?d3Rkci9RZVNnSE14Y2NYb1BlR0hlZVB1UkpoYTZkOGgzVmlKRENXemx2WWp4?=
 =?utf-8?B?UUY2dkpvVU5jM2tSeUZXNlRBdGQzczJyQ05CcEYxY28wdStFWEg0THcvTU5v?=
 =?utf-8?B?WVZ1YVVwTHNrUnRyOXIxNnh6VExKRnF2UHdKR2Vjc0lMU29sYjNaWW0wSysw?=
 =?utf-8?B?S1ZDT3prcHZHV2ZlWWp5MHBTVUZBSW4weEhseEE1R2lVOUpyYXNwQUJENjlj?=
 =?utf-8?B?VjQvWkJzK2p3QVRpd3IvaWpLTDZFNEtzOVZVeEFMcDZGM3VvV0JrMVN0Rkk2?=
 =?utf-8?B?dWNtOWZFRDVQVnBjbVBDdGlPc0hDMGNOZmxTcVZ0T0cxakR1eFI3VXJ2K3BO?=
 =?utf-8?B?eVBUdlByRjNUQUdBMnlUeGYxUDlLZzZnKy9rcVRPQUI0aDQ3dlQyd09lUjZ4?=
 =?utf-8?B?cWJaQ2hQWE9Rd1lRdnF6UWZ0T3VtOG8zamFvZ1piR2ozb2hmRUxPT2cybTZX?=
 =?utf-8?B?TkpGbzNsbTM0elN2anQ2WXlDcWNyMGxOSnhURE0vUE5JQlBDMWh2Zko1RE5t?=
 =?utf-8?B?UjdZWFIvMTBUdC9rRWEwY3ZoMmNqRkhsUU1vQXA5Q3AxTXM4cFBJQW1Zc0N2?=
 =?utf-8?B?ZE1hUGxYeW1SR0ZzMDlydHBFcnBBR3pJVmhDb0tqS3BLNUdnb2ZuL3BkU1Ny?=
 =?utf-8?B?K09aTWVQMDZIN1QrQzhYVHVIS0szZ01Uc1NDc29PQnNScU5mQmlFcU5TSHRB?=
 =?utf-8?B?Lzg3aHlGOXNkZVRBbzgzTUNlaHhURjA0d09Jc3BQZjRBZjQzVVJneWRRYmN5?=
 =?utf-8?B?aHJaRVJ4MmlwdXVZc2htOGgyVXFyVTBOSVZkUGtMeVMwN21KQWJOSm1zNVpK?=
 =?utf-8?B?NXNVN3RQWFlTYWcrQjJ3ajVUVm1rc1YvQVJRMS8rT0gvWVpTcHg4YjIwczU2?=
 =?utf-8?B?aUVteEFQOWVJRXNUV1R6ZjNkU28xbUh5V3M5ZlFqVEw2R0VVNnBtdWJkeTlk?=
 =?utf-8?B?dkkxV2hLYjQ2cFAvdlFiM0Q3c1JlYjV0WmJNUDliMS9jMmo4bm9KZ0lVdGVY?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46A44CEE1CF74B43AF8E6699ACEFBD07@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDNrYmk2SUI4NFJPd3FYZFpSR0VCbW5CUUpoZlpuR1VjWDd3S3hZL05jZWpF?=
 =?utf-8?B?bUNFKytXSnJYOUdvVE9KN1VUVnljY1BrZTladUg3UWgxb0RYOTZaanZkVjJx?=
 =?utf-8?B?RXJLcjhDN25PZVNLN25aTUV6MkdHd1ZKK2pkbVAxbEdkanFTa0VaWm1RVmR2?=
 =?utf-8?B?RStNeHpkMGRZaXJBMHZmT1NMWlNKYUM0R2FuRzYrMHNZZEZxOCtGVzNrUG83?=
 =?utf-8?B?OVI1THdOWTZsRWg0UUZCUXl6TzJicy9TeEx1eHhtU1JvM1Z4WWxQcmgxWWdi?=
 =?utf-8?B?cWZoOGZiT2dsMUFYOTd2TCt4czQwcHJjRXJRa25YK255YW4wV0I1TmtCcmtO?=
 =?utf-8?B?MTRJeGFHcWRBS0FUd0tzazFrZGI5cVR0SlFxaWxjV2M4R3NDT0oyUStMdFZk?=
 =?utf-8?B?Rk1HSFhpWU1OZE5EZ3NGYzBhN0lFKytRQndPbCtVTmxWRFpkYzJaRGJYYVc4?=
 =?utf-8?B?UHBOQk0rUkR2d3hwS1d0T0RTOERNV3plVG4wZWhYN0U0UEZ2NXFabFlvWVJH?=
 =?utf-8?B?NHRTQWtObVdNUnVJMzFJd0xqUUNFblAyVDZuUVZPUlduWVJNdVpEVUpEU3FC?=
 =?utf-8?B?alNqcUFlTHBQbDhSM3FxWFpLd3FIZUZFZlhQYWhIb2c1dHF1R2RvS2ZmRldh?=
 =?utf-8?B?N1dGYWI4UlN3aFhUdnQ1R1BlVzBvNHZVNytvc04waFlyUXZQY3VvMVdnM3dV?=
 =?utf-8?B?RElQVEdIN2dkUDI5cTBpUGlwTFRmY1UyUjdLR3BFZUVIUHVRSXQ5a2swTEN4?=
 =?utf-8?B?U2dZSEFyN281RFpHWFNjS2RuZWY3UUxRL1lmd3I4VnIrTjlnS0t1MndPUjZ4?=
 =?utf-8?B?WXNsbWgxOVpZTVhERVNiR3BBWXN3c21NWHRJV2c2OFppRyt5WkRsZDJsWTAx?=
 =?utf-8?B?bjV3UUtTZHM0NG13Vk5zODhrTnEwWml1RHg1Y094cGhmblcxWkRyNitGWXNK?=
 =?utf-8?B?bTBUaGIzYlFCdTVVTjIrUzJvWkNkL3d1anJLN2VaaEVsL215U1JiUjhQZ29L?=
 =?utf-8?B?ZFV2bWg1Lzk4dDZDcUhEUGNWTExyK0RmMk1pYnJPU3llb0F2KzY2NmpJZkx1?=
 =?utf-8?B?VnVwNEw3ZmlNSnVhS3JtcWNkYlRjL1p1WmlhL2FSYVpUKzQyNzU0SC9JRytL?=
 =?utf-8?B?OC9KdlRMTGk4dDczamRHbXZteDNTSXQ0dUowOHRxSUsvTUNSZ1NiRWw4eTUx?=
 =?utf-8?B?aDVkcHYzdlhGQzJqUXM0czBTL0kveWZxYS9wTUgvcGU1aWN0RWM0dGMvdEZl?=
 =?utf-8?B?UDdPYk0wK1NPTFhCTm9rdExxMGxwMFU3c2lrSW02eG1uS3FuOEw4ZXlnMmlP?=
 =?utf-8?B?dFlNbUk0QnAwUURtQjdZT1Y1Wm9WUHkyQXN0YXIyMTNGciszQSs2ckhPOG9q?=
 =?utf-8?B?NG5JaFdtV1hid3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261d8b89-39c2-4d96-a771-08dbb4a8f6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 22:29:58.8574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkZdXiCrcFkegLwFDnsM8hvEEn8YyWC+6YaPOpIAQQ74qdm43bpQ5Q5PM6Mzjz0/T9S2uEhiyjxlLaMWSSqSfMPMrwGINh7SsfQj/Iok8Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6869
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_17,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130186
X-Proofpoint-ORIG-GUID: lbHgAuM-R7bEfNGii2LVcOUkznSA9g5i
X-Proofpoint-GUID: lbHgAuM-R7bEfNGii2LVcOUkznSA9g5i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gU2VwIDEzLCAyMDIzLCBhdCA0OjIxIEFNLCBNaWNrYcOrbCBTYWxhw7xuIDxtaWNA
ZGlnaWtvZC5uZXQ+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBTZXAgMTMsIDIwMjMgYXQgMDI6NDA6
MTdBTSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gU2VwIDEy
LCAyMDIzLCBhdCA0OjQ3IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90
ZToNCj4+PiANCj4+PiBPbiBUdWUsIDIwMjMtMDktMTIgYXQgMTc6MTEgKzAwMDAsIEVyaWMgU25v
d2Jlcmcgd3JvdGU6DQo+Pj4+IA0KPj4+Pj4gT24gU2VwIDEyLCAyMDIzLCBhdCA1OjU0IEFNLCBN
aW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24g
VHVlLCAyMDIzLTA5LTEyIGF0IDAyOjAwICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+
Pj4+IA0KPj4+Pj4+PiBPbiBTZXAgMTEsIDIwMjMsIGF0IDU6MDggUE0sIE1pbWkgWm9oYXIgPHpv
aGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gTW9uLCAyMDIz
LTA5LTExIGF0IDIyOjE3ICswMDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4+Pj4gDQo+
Pj4+Pj4+Pj4gT24gU2VwIDExLCAyMDIzLCBhdCAxMDo1MSBBTSwgTWlja2HDq2wgU2FsYcO8biA8
bWljQGRpZ2lrb2QubmV0PiB3cm90ZToNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBPbiBNb24sIFNl
cCAxMSwgMjAyMyBhdCAwOToyOTowN0FNIC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPj4+Pj4+
Pj4+PiBIaSBFcmljLA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT24gRnJpLCAyMDIzLTA5LTA4
IGF0IDE3OjM0IC0wNDAwLCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gQ3VycmVu
dGx5IHJvb3QgY2FuIGR5bmFtaWNhbGx5IHVwZGF0ZSB0aGUgYmxhY2tsaXN0IGtleXJpbmcgaWYg
dGhlIGhhc2gNCj4+Pj4+Pj4+Pj4+IGJlaW5nIGFkZGVkIGlzIHNpZ25lZCBhbmQgdm91Y2hlZCBm
b3IgYnkgdGhlIGJ1aWx0aW4gdHJ1c3RlZCBrZXlyaW5nLg0KPj4+Pj4+Pj4+Pj4gQ3VycmVudGx5
IGtleXMgaW4gdGhlIHNlY29uZGFyeSB0cnVzdGVkIGtleXJpbmcgY2FuIG5vdCBiZSB1c2VkLg0K
Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBLZXlzIHdpdGhpbiB0aGUgc2Vjb25kYXJ5IHRydXN0
ZWQga2V5cmluZyBjYXJyeSB0aGUgc2FtZSBjYXBhYmlsaXRpZXMgYXMNCj4+Pj4+Pj4+Pj4+IHRo
ZSBidWlsdGluIHRydXN0ZWQga2V5cmluZy4gIFJlbGF4IHRoZSBjdXJyZW50IHJlc3RyaWN0aW9u
IGZvciB1cGRhdGluZw0KPj4+Pj4+Pj4+Pj4gdGhlIC5ibGFja2xpc3Qga2V5cmluZyBhbmQgYWxs
b3cgdGhlIHNlY29uZGFyeSB0byBhbHNvIGJlIHJlZmVyZW5jZWQgYXMNCj4+Pj4+Pj4+Pj4+IGEg
dHJ1c3Qgc291cmNlLiAgU2luY2UgdGhlIG1hY2hpbmUga2V5cmluZyBpcyBsaW5rZWQgdG8gdGhl
IHNlY29uZGFyeQ0KPj4+Pj4+Pj4+Pj4gdHJ1c3RlZCBrZXlyaW5nLCBhbnkga2V5IHdpdGhpbiBp
dCBtYXkgYWxzbyBiZSB1c2VkLg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBBbiBleGFtcGxl
IHVzZSBjYXNlIGZvciB0aGlzIGlzIElNQSBhcHByYWlzYWwuICBOb3cgdGhhdCBJTUEgYm90aA0K
Pj4+Pj4+Pj4+Pj4gcmVmZXJlbmNlcyB0aGUgYmxhY2tsaXN0IGtleXJpbmcgYW5kIGFsbG93cyB0
aGUgbWFjaGluZSBvd25lciB0byBhZGQNCj4+Pj4+Pj4+Pj4+IGN1c3RvbSBJTUEgQ0EgY2VydHMg
dmlhIHRoZSBtYWNoaW5lIGtleXJpbmcsIHRoaXMgYWRkcyB0aGUgYWRkaXRpb25hbA0KPj4+Pj4+
Pj4+Pj4gY2FwYWJpbGl0eSBmb3IgdGhlIG1hY2hpbmUgb3duZXIgdG8gYWxzbyBkbyByZXZvY2F0
aW9ucyBvbiBhIHJ1bm5pbmcNCj4+Pj4+Pj4+Pj4+IHN5c3RlbS4NCj4+Pj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+Pj4gSU1BIGFwcHJhaXNhbCB1c2FnZSBleGFtcGxlIHRvIGFkZCBhIHJldm9jYXRpb24g
Zm9yIC91c3IvZm9vOg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBzaGEyNTZzdW0gL2Jpbi9m
b28gfCBhd2sgJ3twcmludGYgImJpbjoiICQxfScgPiBoYXNoLnR4dA0KPj4+Pj4+Pj4+Pj4gDQo+
Pj4+Pj4+Pj4+PiBvcGVuc3NsIHNtaW1lIC1zaWduIC1pbiBoYXNoLnR4dCAtaW5rZXkgbWFjaGlu
ZS1wcml2YXRlLWtleS5wZW0gXA0KPj4+Pj4+Pj4+Pj4gICAtc2lnbmVyIG1hY2hpbmUtY2VydGlm
aWNhdGUucGVtIC1ub2F0dHIgLWJpbmFyeSAtb3V0Zm9ybSBERVIgXA0KPj4+Pj4+Pj4+Pj4gICAt
b3V0IGhhc2gucDdzDQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IGtleWN0bCBwYWRkIGJsYWNr
bGlzdCAiJCg8IGhhc2gudHh0KSIgJTouYmxhY2tsaXN0IDwgaGFzaC5wN3MNCj4+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVyZyA8ZXJpYy5zbm93YmVy
Z0BvcmFjbGUuY29tPg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gVGhlIHNlY29uZGFyeSBrZXly
aW5nIG1heSBpbmNsdWRlIGJvdGggQ0EgYW5kIGNvZGUgc2lnbmluZyBrZXlzLiAgV2l0aA0KPj4+
Pj4+Pj4+PiB0aGlzIGNoYW5nZSBhbnkga2V5IGxvYWRlZCBvbnRvIHRoZSBzZWNvbmRhcnkga2V5
cmluZyBtYXkgYmxhY2tsaXN0IGENCj4+Pj4+Pj4+Pj4gaGFzaC4gIFdvdWxkbid0IGl0IG1ha2Ug
bW9yZSBzZW5zZSB0byBsaW1pdCBibGFja2xpc3RpbmcNCj4+Pj4+Pj4+Pj4gY2VydGlmaWNhdGVz
L2hhc2hlcyB0byBhdCBsZWFzdCBDQSBrZXlzPyANCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBTb21l
IG9wZXJhdGlvbmFsIGNvbnN0cmFpbnRzIG1heSBsaW1pdCB3aGF0IGEgQ0EgY2FuIHNpZ24uDQo+
Pj4+Pj4+PiANCj4+Pj4+Pj4+IEFncmVlZC4gIA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJcyB0aGVy
ZSBwcmVjZWRlbnRzIGZvciByZXF1aXJpbmcgdGhpcyBTL01JTUUgdG8gYmUgc2lnbmVkIGJ5IGEg
Q0E/IA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gVGhpcyBjaGFuZ2UgaXMgY3JpdGljYWwgYW5kIHNo
b3VsZCBiZSB0aWVkIHRvIGEgZGVkaWNhdGVkIGtlcm5lbCBjb25maWcNCj4+Pj4+Pj4+PiAoZGlz
YWJsZWQgYnkgZGVmYXVsdCksIG90aGVyd2lzZSBleGlzdGluZyBzeXN0ZW1zIHVzaW5nIHRoaXMg
ZmVhdHVyZQ0KPj4+Pj4+Pj4+IHdpbGwgaGF2ZSB0aGVpciB0aHJlYXQgbW9kZWwgYXV0b21hdGlj
YWxseSBjaGFuZ2VkIHdpdGhvdXQgbm90aWNlLg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBUb2RheSB3
ZSBoYXZlIElOVEVHUklUWV9DQV9NQUNISU5FX0tFWVJJTkdfTUFYLiAgVGhpcyBjYW4gDQo+Pj4+
Pj4+PiBiZSBlbmFibGVkIHRvIGVuZm9yY2UgQ0EgcmVzdHJpY3Rpb25zIG9uIHRoZSBtYWNoaW5l
IGtleXJpbmcuICBNaW1pLCB3b3VsZCANCj4+Pj4+Pj4+IHRoaXMgYmUgYSBzdWl0YWJsZSBzb2x1
dGlvbiBmb3Igd2hhdCB5b3UgYXJlIGFmdGVyPw0KPj4+Pj4+PiANCj4+Pj4+Pj4gVGhlcmUgbmVl
ZHMgdG8gYmUgc29tZSBjb3JyZWxhdGlvbiBiZXR3ZWVuIHRoZSBmaWxlIGhhc2hlcyBiZWluZyBh
ZGRlZA0KPj4+Pj4+PiB0byB0aGUgYmxhY2tsaXN0IGFuZCB0aGUgY2VydGlmaWNhdGUgdGhhdCBz
aWduZWQgdGhlbS4gIFdpdGhvdXQgdGhhdA0KPj4+Pj4+PiBjb3JyZWxhdGlvbiwgYW55IGtleSBv
biB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjb3VsZCBhZGQgYW55DQo+Pj4+Pj4+IGZp
bGUgaGFzaGVzIGl0IHdhbnRzIHRvIHRoZSBibGFja2xpc3QuDQo+Pj4+Pj4gDQo+Pj4+Pj4gVG9k
YXkgYW55IGtleSBpbiB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZyBjYW4gYmUgdXNlZCB0
byB2YWxpZGF0ZSBhIA0KPj4+Pj4+IHNpZ25lZCBrZXJuZWwgbW9kdWxlLiAgQXQgYSBsYXRlciB0
aW1lLCBpZiBhIG5ldyBoYXNoIGlzIGFkZGVkIHRvIHRoZSBibGFja2xpc3QgDQo+Pj4+Pj4ga2V5
cmluZyB0byByZXZva2UgbG9hZGluZyBhIHNpZ25lZCBrZXJuZWwgbW9kdWxlLCAgdGhlIGFiaWxp
dHkgdG8gZG8gdGhlIA0KPj4+Pj4+IHJldm9jYXRpb24gd2l0aCB0aGlzIGFkZGl0aW9uYWwgY2hh
bmdlIHdvdWxkIGJlIG1vcmUgcmVzdHJpY3RpdmUgdGhhbiBsb2FkaW5nIA0KPj4+Pj4+IHRoZSBv
cmlnaW5hbCBtb2R1bGUuDQo+Pj4+PiANCj4+Pj4+IEEgcHVibGljIGtleSBvbiB0aGUgc2Vjb25k
YXJ5IGtleXJpbmcgaXMgdXNlZCB0byB2ZXJpZnkgY29kZSB0aGF0IGl0DQo+Pj4+PiBzaWduZWQs
IGJ1dCBkb2VzIG5vdCBpbXBhY3QgYW55IG90aGVyIGNvZGUuIEFsbG93aW5nIGFueSBwdWJsaWMg
a2V5IG9uDQo+Pj4+PiB0aGUgc2Vjb25kYXJ5IGtleXJpbmcgdG8gYmxhY2tsaXN0IGFueSBmaWxl
IGhhc2ggaXMgZ2l2aW5nIGl0IG1vcmUNCj4+Pj4+IHByaXZpbGVnZXMgdGhhbiBpdCBvcmlnaW5h
bGx5IGhhZC4NCj4+Pj4+IA0KPj4+Pj4gVGhpcyByZXF1aXJlbWVudCBpc24ndCBkaWZmZXJlbnQg
dGhhbiBob3cgQ2VydGlmaWNhdGUgUmV2b2NhdGlvbiBMaXN0DQo+Pj4+PiAoQ1JMKSB3b3JrLiAg
Tm90IGFueSBDQSBjYW4gcmV2b2tlIGEgY2VydGlmaWNhdGUuDQo+Pj4+IA0KPj4+PiBJbiBVRUZJ
IFNlY3VyZSBCb290IHdlIGhhdmUgdGhlIEZvcmJpZGRlbiBTaWduYXR1cmUgRGF0YWJhc2UgKERC
WCkuICANCj4+Pj4gUm9vdCBjYW4gdXBkYXRlIHRoZSBEQlggb24gYSBob3N0LiAgVGhlIHJlcXVp
cmVtZW50IHBsYWNlZCBvbiB1cGRhdGluZyANCj4+Pj4gaXQgaXMgdGhlIG5ldyBEQlggZW50cnkg
bXVzdCBiZSBzaWduZWQgYnkgYW55IGtleSBjb250YWluZWQgd2l0aGluIHRoZSANCj4+Pj4gS0VL
LiAgRm9sbG93aW5nIGEgcmVib290LCBhbGwgREJYIGVudHJpZXMgbG9hZCBpbnRvIHRoZSAuYmxh
Y2tsaXN0IGtleXJpbmcuICANCj4+Pj4gVGhlcmUgaXMgbm90IGEgcmVxdWlyZW1lbnQgc2ltaWxh
ciB0byBob3cgQ1JM4oCZcyB3b3JrIGhlcmUsIGFueSBLRUsga2V5IA0KPj4+PiBjYW4gYmUgdXNl
ZC4NCj4+Pj4gDQo+Pj4+IFdpdGggYXJjaGl0ZWN0dXJlcyBib290ZWQgdGhyb3VnaCBhIHNoaW0g
dGhlcmUgaXMgdGhlIE1PS1guICBTaW1pbGFyIHRvIA0KPj4+PiBEQlgsIE1PS1ggaGF2ZSB0aGUg
c2FtZSBjYXBhYmlsaXRpZXMsIGhvd2V2ZXIgdGhleSBkbyBub3QgbmVlZCB0byBiZSANCj4+Pj4g
c2lnbmVkIGJ5IGFueSBrZXksIHRoZSBtYWNoaW5lIG93bmVyIG11c3Qgc2hvdyB0aGV5IGhhdmUg
cGh5c2ljYWwgDQo+Pj4+IHByZXNlbmNlIChhbmQgcG90ZW50aWFsbHkgYSBNT0sgcGFzc3dvcmQp
IGZvciBpbmNsdXNpb24uICBBZ2FpbiB0aGVyZSANCj4+Pj4gaXMgbm90IGEgcmVxdWlyZW1lbnQg
c2ltaWxhciB0byBob3cgQ1JM4oCZcyB3b3JrIGhlcmUgZWl0aGVyLiAgVGhlIG1hY2hpbmUgDQo+
Pj4+IG93bmVyIGNhbiBkZWNpZGUgd2hhdCBpcyBpbmNsdWRlZC4NCj4+Pj4gDQo+Pj4+IFRvZGF5
IHdoZW4gYSBrZXJuZWwgaXMgYnVpbHQsIGFueSBudW1iZXIgb2Yga2V5cyBtYXkgYmUgaW5jbHVk
ZWQgd2l0aGluIA0KPj4+PiB0aGUgYnVpbHRpbiB0cnVzdGVkIGtleXJpbmcuICBUaGUga2V5cyBp
bmNsdWRlZCBpbiB0aGUga2VybmVsIG1heSBub3QgaGF2ZSANCj4+Pj4gYSBzaW5nbGUgdXNhZ2Ug
ZmllbGQgc2V0IG9yIHRoZSBDQSBiaXQgc2V0LiAgVGhlcmUgYXJlIG5vIHJlcXVpcmVtZW50cyBv
biANCj4+Pj4gaG93IHRoZXNlIGtleXMgZ2V0IHVzZWQgbGF0ZXIgb24uICBBbnkga2V5IGluIHRo
ZSBidWlsdGluIHRydXN0ZWQga2V5cmluZyANCj4+Pj4gY2FuIGJlIHVzZWQgdG8gc2lnbiBhIHJl
dm9jYXRpb24gdGhhdCBjYW4gYmUgYWRkZWQgdG8gdGhlIGJsYWNrbGlzdCBrZXlyaW5nLiAgDQo+
Pj4+IEFkZGl0aW9uYWxseSwgYW55IGtleSBpbiB0aGUgTU9LIGNhbiBiZSB1c2VkIHRvIHNpZ24g
dGhpcyBrZXJuZWwgYW5kIGl0IHdpbGwgDQo+Pj4+IGJvb3QuICBCZWZvcmUgYm9vdGluZyB0aGUg
a2VybmVsLCBNT0sga2V5cyBoYXZlIG1vcmUgcHJpdmlsZWdlcyB0aGFuIA0KPj4+PiBhZnRlciB0
aGUga2VybmVsIGlzIGJvb3RlZCBpbiBzb21lIGluc3RhbmNlcy4NCj4+Pj4gDQo+Pj4+IFRvZGF5
IE1PSyBrZXlzIGNhbiBiZSBsb2FkZWQgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiAgVGhlc2Ug
a2V5cyBnZXQgDQo+Pj4+IGxpbmtlZCB0byB0aGUgc2Vjb25kYXJ5IHRydXN0ZWQga2V5cmluZy4g
IEN1cnJlbnRseSBrZXkgdXNhZ2UgZW5mb3JjZW1lbnQNCj4+Pj4gaXMgYmVpbmcgYXBwbGllZCB0
byB0aGVzZSBrZXlzIGJlaGluZCBzb21lIEtjb25maWcgb3B0aW9ucy4gIEJ5IGRlZmF1bHQgDQo+
Pj4+IGFueXRoaW5nIGluIHRoZSBzZWNvbmRhcnkgaGFzIHRoZSBzYW1lIGNhcGFiaWxpdGllcyBh
cyB0aGUgYnVpbHRpbiB0cnVzdGVkIA0KPj4+PiBrZXlyaW5nLiAgV2hhdCBpcyBjaGFsbGVuZ2lu
ZyBoZXJlIHdpdGggdGhpcyByZXF1ZXN0IGlzIHRoZSBpbmNvbnNpc3RlbmN5IA0KPj4+PiBiZXR3
ZWVuIGhvdyBldmVyeXRoaW5nIGVsc2UgY3VycmVudGx5IHdvcmtzLiANCj4+Pj4gDQo+Pj4+IFJv
b3QgY2FuIG5vdCBhcmJpdHJhcmlseSBhZGQgdGhpbmdzIHRvIHRoZSBzZWNvbmRhcnkgdHJ1c3Rl
ZCBrZXlyaW5nLiAgVGhlc2UgDQo+Pj4+IGtleXMgbXVzdCBiZSBzaWduZWQgYnkgc29tZXRoaW5n
IGluIGVpdGhlciB0aGUgbWFjaGluZSBvciB0aGUgYnVpbHRpbi4gIEluIA0KPj4+PiB0aGlzIHRo
cmVhZCBbMV0sIEphcmtrbyBpcyBzYXlpbmcgQ0EgYmFzZWQgaW5mcmFzdHJ1Y3R1cmUgc2hvdWxk
IGJlIGEgcG9saWN5IA0KPj4+PiBkZWNpc2lvbiBub3QgdG8gYmUgZW5mb3JjZWQgYnkgdGhlIGtl
cm5lbC4gV291bGRu4oCZdCB0aGlzIGFwcGx5IGhlcmUgYXMgd2VsbD8NCj4+Pj4gDQo+Pj4+IDEu
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ1ZHVUZVRVFWQ0hTLjM3T0EyMFBORzlFVkJA
c3VwcGlsb3ZhaHZlcm8vDQo+Pj4gDQo+Pj4gTWlja2HDq2wgc2FpZCwgIlRoaXMgY2hhbmdlIGlz
IGNyaXRpY2FsIGFuZCBzaG91bGQgYmUgdGllZCB0byBhDQo+Pj4gZGVkaWNhdGVkIGtlcm5lbCBj
b25maWcNCj4+PiAoZGlzYWJsZWQgYnkgZGVmYXVsdCksIG90aGVyd2lzZSBleGlzdGluZyBzeXN0
ZW1zIHVzaW5nIHRoaXMgZmVhdHVyZQ0KPj4+IHdpbGwgaGF2ZSB0aGVpciB0aHJlYXQgbW9kZWwg
YXV0b21hdGljYWxseSBjaGFuZ2VkIHdpdGhvdXQgbm90aWNlLiINCj4+IA0KPj4gSSB3YXMgdGhp
bmtpbmcgaGUgbWVhbnQgaXQgaXMgY3JpdGljYWwgbm90IHRvIGNoYW5nZSB0aGUgY3VycmVudCBi
ZWhhdmlvcg0KPj4gYnkgbGltaXRpbmcgYmxhY2tsaXN0aW5nIHRvIG9ubHkgQ0Ega2V5cy4gIE5v
dCB0aGF0IGl0IHdhcyBjcml0aWNhbCB0byBhZGQNCj4+IENBIGVuZm9yY2VtZW50LiAgTWF5YmUg
TWlja2HDq2wgY2FuIGNvbW1lbnQ/DQo+IA0KPiBJIG1lYW50IHRoYXQgYXBwbHlpbmcgdGhpcyBw
YXRjaCBhcy1pcyBtYXkgY2hhbmdlIHRoZSB0aHJlYXQgbW9kZWwgdXNlZA0KPiBieSBzb21lIHVz
ZXJzLiBDdXJyZW50bHksIG9ubHkgc2lnbmVkIGhhc2hlcyB2b3VjaGVkIGJ5IHRoZSBidWlsdGlu
DQo+IHRydXN0ZWQga2V5cmluZyBhcmUgdmFsaWQuIElmIHdlIGV4dGVuZCB0aGlzIG1lY2hhbmlz
bSB0byB0aGUgc2Vjb25kYXJ5DQo+IHRydXN0ZWQga2V5cmluZyB3aXRob3V0IG5vdGljZSwgdGhp
cyBtZWFucyB0aGF0IG1vcmUgY2VydGlmaWNhdGVzIGNvdWxkDQo+IHZvdWNoIGJsYWNrbGlzdGVk
IGhhc2hlcywgd2hpY2ggbWF5IGluY2x1ZGUgc29tZSBjZXJ0aWZpY2F0ZXMgd2l0aCBhbg0KPiBp
bml0aWFsIGRpZmZlcmVudCB1c2FnZS4NCj4gDQo+IFNlZSBjb21taXQgNGRhOGY4YzhhMWUwICgi
ZG0gdmVyaXR5OiBBZGQgc3VwcG9ydCBmb3Igc2lnbmF0dXJlDQo+IHZlcmlmaWNhdGlvbiB3aXRo
IDJuZCBrZXlyaW5nIikgdGhhdCBhZGRzDQo+IENPTkZJR19ETV9WRVJJVFlfVkVSSUZZX1JPT1RI
QVNIX1NJR19TRUNPTkRBUllfS0VZUklORzoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjAxMDIzMTcwNTEyLjIwMTEyNC0xLW1pY0BkaWdpa29kLm5ldC8NCg0KVGhhbmtzIGZvciBj
bGFyaWZ5aW5nLiAgSeKAmWxsIGFkZCBzb21ldGhpbmcgc2ltaWxhciBpbiB2Mi4NCg0KPj4gDQo+
Pj4gQXMgYSBwb3NzaWJsZSBhbHRlcm5hdGl2ZSBJIHN1Z2dlc3RlZCBsaW1pdGluZyB3aGljaCBm
aWxlIGhhc2hlcyB0aGUNCj4+PiBjZXJ0cyBvbiB0aGUgc2Vjb25kYXJ5IChvciBtYWNoaW5lKSBr
ZXlyaW5nIGNvdWxkIGJsYWNrbGlzdC4NCj4+IA0KPj4gSeKAmW0gbm90IHN1cmUgSSBjb21wbGV0
ZWx5IHVuZGVyc3RhbmQgeW91ciBzdWdnZXN0aW9uIGhlcmUuDQo+PiBEbyB5b3UgbWVhbiwgdmVy
aWZ5IHRoZSBDQSBiaXQgaXMgc2V0IGZvciBzZWNvbmRhcnkga2V5cywgYnV0DQo+PiBpZ25vcmUg
dGhlIGJpdCBmb3IgYnVpbHRpbj8gIEFuZCB0aGVuIG9ubHkgdXNlIHRob3NlIGtleXMgdG8gYWRk
DQo+PiBoYXNoZXMgdG8gdGhlIGJsYWNrbGlzdCBrZXlyaW5nPyAgSWYgSSBoYXZlIHRoYXQgcmln
aHQsIHdoYXQgd291bGQgDQo+PiBiZSB0aGUganVzdGlmaWNhdGlvbiBmb3IgdGhlIGNoYW5nZSBi
YXNlZCBvbiBob3cgdGhpbmdzIGN1cnJlbnRseQ0KPj4gZ2V0IGluY2x1ZGVkIGluIHRoZSBibGFj
a2xpc3Qga2V5cmluZz8gIFRoYW5rcy4NCj4gDQo+IEknZCBsaWtlIHRvIGJlIGFibGUgdG8gc3Bl
Y2lmeSB3aGljaCBraW5kIG9mIGNlcnRpZmljYXRlIGNhbiB2b3VjaCBmb3INCj4gYmxhY2tsaXN0
aW5nIGhhc2hlcywgYW5kIGZvciBvdGhlciB1c2FnZXMsIGJ1dCBBRkFJSyB0aGlzIGlzIG5vdCB0
aGUNCj4gcGF0aCBMaW51eCBoYXMgZm9sbG93ZWQgKGUuZy4gdW5saWtlIFdpbmRvd3MpLiBXZSBv
bmx5IGhhdmUgdGhlIGtleXJpbmcNCj4gdG8gaWRlbnRpZnkgYW4gdXNhZ2UsIHdoaWNoIGlzIHVu
Zm9ydHVuYXRlLiBPbiB0aGUgb3RoZXIgc2lkZSwgdGhpcw0KPiBhcHByb2FjaCBsZXRzIHVzZXJz
IG1hbmFnZSB0aGVpciBjZXJ0aWZpY2F0ZXMgd2l0aG91dCBjb25zdHJhaW50LCB3aGljaA0KPiBp
cyBxdWl0ZSAodG9vPykgZmxleGlibGUuDQoNClllcywgaXQgaXMgdmVyeSBmbGV4aWJsZS4gV2hh
dCBJIGJlbGlldmUgTWltaSBpcyBhZnRlciBpcyBoYXZpbmcgYSB3YXkgdG8gDQp0cmFjayB3aGF0
IGNlcnQgYWN0dWFsbHkgdm91Y2hlZCBmb3IgZWFjaCBzcGVjaWZpYyBiaW5hcnkgaGFzaC4gIEJ1
dCB0aGlzDQppbmZvcm1hdGlvbiBpcyBub3QgdHJhY2tlZCwgcGx1cyBlbnRyaWVzIHdpdGhpbiBp
dCBjYW4gY29tZSBmcm9tIHZhcmlvdXMgDQpzb3VyY2VzIHRoYXQgYXJlIG5vdCBzaWduZWQgKGRi
eCwgbW9reCwgY29tcGlsZWQgaW4pLiAgQWxzbyBrZXkgdXNhZ2UgaXMgDQpiZWluZyBpZ25vcmVk
Lg0KDQo+IEEgY29tcGxlbWVudGFyeSBhcHByb2FjaCB3b3VsZCBiZSB0byBjcmVhdGUgYW4NCj4g
TFNNIChvciBhIGRlZGljYXRlZCBpbnRlcmZhY2UpIHRvIHRpZSBjZXJ0aWZpY2F0ZSBwcm9wZXJ0
aWVzIHRvIGEgc2V0IG9mDQo+IGtlcm5lbCB1c2FnZXMsIHdoaWxlIHN0aWxsIGxldHRpbmcgdXNl
cnMgY29uZmlndXJlIHRoZXNlIGNvbnN0cmFpbnRzLg0KDQpUaGF0IGlzIGFuIGludGVyZXN0aW5n
IGlkZWEuICBXb3VsZCB0aGUgb3RoZXIgc2VjdXJpdHkgbWFpbnRhaW5lcnMgYmUgaW4gDQpzdXBw
b3J0IG9mIHN1Y2ggYW4gYXBwcm9hY2g/ICBXb3VsZCBhIExTTSBiZSB0aGUgY29ycmVjdCBpbnRl
cmZhY2U/ICANClNvbWUgb2YgdGhlIHJlY2VudCB3b3JrIEkgaGF2ZSBkb25lIHdpdGggaW50cm9k
dWNpbmcga2V5IHVzYWdlIGFuZCBDQSANCmVuZm9yY2VtZW50IGlzIGRpZmZpY3VsdCBmb3IgYSBk
aXN0cm8gdG8gcGljayB1cCwgc2luY2UgdGhlc2UgY2hhbmdlcyBjYW4gYmUgDQp2aWV3ZWQgYXMg
YSByZWdyZXNzaW9uLiAgRWFjaCBlbmQtdXNlciBoYXMgZGlmZmVyZW50IHNpZ25pbmcgcHJvY2Vk
dXJlcyANCmFuZCBwb2xpY2llcywgc28gbWFraW5nIHNvbWV0aGluZyB3b3JrIGZvciBldmVyeW9u
ZSBpcyBkaWZmaWN1bHQuICBMZXR0aW5nIHRoZSANCnVzZXIgY29uZmlndXJlIHRoZXNlIGNvbnN0
cmFpbnRzIHdvdWxkIHNvbHZlIHRoaXMgcHJvYmxlbS4NCg0K
