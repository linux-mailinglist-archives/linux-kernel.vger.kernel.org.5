Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349D6803504
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344250AbjLDNds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:33:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D152B2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:33:53 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DUeaT029480;
        Mon, 4 Dec 2023 13:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SRwMhwuEEER4AJQfQwP5HScE1yn7GepKUPvFiJPmXIE=;
 b=gLGPiuozM/gdlISkJOE39BMIYdJOcAVqAXFfo5Xnjaa84jeGfiYFinP4TbKMaCkzA3Jk
 O4+0ecvRiX6fmLliXw/3U+8mb2jC8FKNe8DjjUMQa0dPS14bci6pX/3EVbJfih7EI8HV
 6eeJZIDeWg0lbIL5MzlrIBXH5dKIH10fKLjfiuHgJKxE70YYQY+dCubcL9GZoxEsUSpa
 hJiKhrIhc6T9X3ejb7gTny8Z83qCd2ble4XKlrEUqJ114H34o7RCWpO97fYsbpgqno9s
 jG8m9rTyLWtvQ4A9u5Qyo5Ywb3J9OvaW/Tp4Ku0q6uqWuB2Q+Vm65uOBPS+P6qudDVU5 AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usf0pr2wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:33:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Bmx4Y014733;
        Mon, 4 Dec 2023 13:33:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15rtrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:33:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBSt/WYfVs6SQUREYfYyXBvNctnU+IgSWryi0ouS52H56XlnLnA1h9uRKIEL4Sj6p8B37dXwriqwUh/FJ3Xk7CCvPw2mu5r7nzs6JbhSkkmoQeDkXTdAs4EruJibZBWe+bE55u3EOuZc8WWiSGxaR2BTDJ3letamgHQcvPW8XOyWzj0Q4cz/YhSPdl6a6b4z9ChWE4UcbKYTq/Ks/IReuH1oME82JvrOGj2TkxtW1JHPv6bbEChBwbw7IUWRrdhSfMqn8a8ivUG1VjeC0UlJDq/1vEfNefhnpCtyEk+Fz+lEvuO1+62jzaW3WYB2/WXnZ0YAGrwgrTq9oYPQakPD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRwMhwuEEER4AJQfQwP5HScE1yn7GepKUPvFiJPmXIE=;
 b=n9dufB1fG4vRmdSbG5tmrvqXOvnWbbz6VdSeUUQVbElhDCOF6xqGgOsRvPA7sDth2m1SgXD1fULPLxX/uwqTaYRL9kfXL0wm5y4Lv9nwKvgbAKEgIHw9qUOy9rWefrFn2h8i9n1ZIqBKSpP38pERXr+PajLeL2/BcSRco+OqcNT2n9F3+uDYbSjm6UV8eknoKMliTqVBWvReV9qHzJs6pi/Vg5t86XGCtYIk1v1MU7IxHJfYyrnUR2aLN+IvQ8mY+ownri+tt4LOAeP5Dk3BOyDMzVu50FdhQ+QbjzUXb6wBM2EOxQ3Q83wFG1GKUuAg9nOKUF/wNT32HAnH4bSJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRwMhwuEEER4AJQfQwP5HScE1yn7GepKUPvFiJPmXIE=;
 b=E6btnMNwyqw/1kg/ruKj65AMaf/o511xj8HvYapzNEx8J9kIwtvxoew3qzlX/HJe1sDcooAGA3ILR0iLdmWV/HjTqGD3ZsB3kbRnDm2oPc7KwNCNtZZA3J/EGRahyCJppws5fx5TwEaL4gZca5/gdF7Vdfu8Qqg1OMeV/Kc7QTo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 13:33:26 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 13:33:25 +0000
Message-ID: <22981f62-5c57-41c4-8ed2-a11b7b93d062@oracle.com>
Date:   Mon, 4 Dec 2023 08:33:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] vdpa/mlx5: preserve CVQ vringh index
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
References: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1699014387-194368-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|BLAPR10MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 291c99b8-6e63-43d7-fcf4-08dbf4cd97b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyudS3Q4TgVNSc8wdDXBBpxyByYQ7ZAT/03MAWGa9qnSnPF2bUxVKrOmVBrKUwcYhoJdM5dFl88PRoOwWWNsfa/iP+16NWIJfiEt6qNysex1d4xUr1q7eu2mYQ0qXrllq5kg0GEUr0mG5O9Z/JSSnlm+Q7q2LfAvJIaouqC98EprIlJUwfRokUqV5fCjOUZB9mbJ1uRz7oRN0mnhhRfEvl7TgIwMPWt+4a979dClBhwpxvTBSvGpvkdRG/GbgsF9jjbkAV4V9Kr0AlkCb5nlAvnkXXgbIycoJMeGVRB0hnyYG+N7u/egRrLj7kxhTNwCF0I0aea6ieKZOR3UJZdubbWb3G+EEc3vZ6HG6W8qRKvsms0FLZMOOUEOcmR4D+M9JTe5R7QF0xFkjuvUqr5w3OmmcpMsPukSDSEg3CkH7UjsUQbbaWDgs8950DsVKRPYKJXA8ADQHirgZXmKxbbTP8zYceX2QqFTXvr8e4J25sunmjBTzoYrgf3UqO158AeMMSWeFN5UIRcRDsbrBmrcZB3ohz1EVq9N1+UQ2K6S3gJNroxR1ampjwmvlEMplmuvDHKqbzOgE5u0g+R9cKPI3qOkN4szFm9eDLUFqkyN3c+BJCX8G0kQ2+8BQ7T9y1RjP1JRz0yafsrL0qNfNcc69Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(54906003)(66946007)(316002)(478600001)(6486002)(6666004)(38100700002)(5660300002)(36756003)(41300700001)(2906002)(31696002)(44832011)(86362001)(4326008)(8676002)(8936002)(31686004)(2616005)(83380400001)(26005)(66574015)(6512007)(53546011)(36916002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1Z3Q0wwdnA3SnBQVTh6SUVZOE1MYzA1S2x0UHh1RXIyVlhZaFFCUW8wTlpY?=
 =?utf-8?B?K1g0MHFUYzdNZ0I3bmJoSXg0REg3ZWdGQnNINHFQSnM3cVd1d250MXJBL1o2?=
 =?utf-8?B?bG1yK3J0U0wwdVdrU3U4MXdOallGYTZuL2E0M3BuZEc2VDR1ZFgzTTQwNFpO?=
 =?utf-8?B?ZzEvMVVXSzNYUEwvajRWeldpcG94SGp6NHNPQkNsRzRGbjZIN0xrVHFzUGhR?=
 =?utf-8?B?MWVYbC9iQWtQVGtmUGtKQWZVOXE1eWZkUFZsMFZUZWRmd2UzMG1wTGtoUzFh?=
 =?utf-8?B?clZxRFVpanFNM28xT0FLdERwcDkxbG9sdDEreG9JWExlbFlXV08wZUM1cTY2?=
 =?utf-8?B?alNOYSt5RDJUSG50WkM4NXplejRCemd1ZVQwS0Q0emg3ZEcwWXAzMkhnRGZy?=
 =?utf-8?B?ZXM4Zk1VTitrQUt1OVl4djZmblZzSlozQ3RjMUtQUDhyL1JOYzN2d3FMWmhW?=
 =?utf-8?B?aGlwS0ljSFBUZ3ptSXJNVnR3eFI4dDF2RFRoWGxGejZ6cE9iQ3V2MjRyV0RG?=
 =?utf-8?B?WDl3bUkvcmhDZzZmbnZ4VEcydWx3bS9McVg1amFsTnN4YktoSFFwWkNycThE?=
 =?utf-8?B?U0dpVlF0SVFFajZId2cxWmQ4cVM1MFhTaEttLzhIbG1nS1FHT3dlVllrREQr?=
 =?utf-8?B?UnRESjVMUUF0L2czQkhBdmFkZVRXMjNlVEVVa2hJN3RSS1NBT1lGbDNnVGwv?=
 =?utf-8?B?c3N1aENWeS92NzZZV0tqb21XQlN0UHEydGxzUzBvSytBR1RzcGxYODJsemZy?=
 =?utf-8?B?Ynh6SGtTdWEydWxaZmxqbjJjSlppOVUyR3ZDc2VDaFg1aExySEFicWUzOWp0?=
 =?utf-8?B?SU1TSjBlR0ZWUE91Nk05S2w5QzJBYUM4NldDU3hEVGRWV29iV3lNVWZHRHVQ?=
 =?utf-8?B?NnVucHlac0kwZ09TNFdBdWwxL3hkcUFTYzA4dWo3RC8zQTN5MnczU0hZV05T?=
 =?utf-8?B?Z1RiREo4RHpCaXpON1Z1Ujg4TGp6dk9TcHJNbHpncXRVWGtWbGx6QWliWDRI?=
 =?utf-8?B?V3BBdGM1amFFYzlBU0s1c3AydTV1akE0bEd4Qkc0VUYrVXNTK1ByQ0NaWkFP?=
 =?utf-8?B?OC9LWkpjZkx5TE85a0NLQ1hCL3VZZFFyNE91V3hhQ2xHRDRrcFlZelFOWGxu?=
 =?utf-8?B?Q2p0akZGYVhMdmF6LzFIaWpDcCtMN3RVTW1LSTFtSFNmYVRueG9qdWFoK3hs?=
 =?utf-8?B?Q1F4N2wyaGNnUlI4eEh5TWVoSURxTjNnZkZzb1FTQVYzTVBBb1l4eFJWTzhp?=
 =?utf-8?B?MCt4djcyblg3YXZmY3V0TGxRZmZ6SmN6cSsrR0d3S25VQTVIWGYrN0Y1QjdQ?=
 =?utf-8?B?TmFoamhNQWc2RWxOR0pGMXBFVW5jdzU3QmVhR1hhd1h5bjF6WmRacGxYNmJm?=
 =?utf-8?B?SVI1cjZmb2thTVF0VHVHeFExRzZiRkREeHlBRGd5My9vbVNHRWRGaW5TS2lz?=
 =?utf-8?B?Z28rQmlyUlY1OWRSM1g0UDhlMWVyN1d5L2pRbEtHR0cvMlN3QmVHN3p0Q3d0?=
 =?utf-8?B?c21wc212RzNaK1A5ZlZ5cGxidTQzcWxXNXh6MzNCQzJEME5vK3FpZXdhV2FH?=
 =?utf-8?B?YWMrcVpWV2o1ZWlhUjVmdEpQd3dxMHh6V28wVUVSSERnM3ZZeHZweHhLRy9Y?=
 =?utf-8?B?UjY0TmF6QlN1VkxlajBpcDRSUGd5czlwY1NJMnVpK0pkRHNHMDRQQ0laYm1K?=
 =?utf-8?B?Umc0YXh5U3cyWHRyUXgwMGUzRWQ1UnhOTzF1Z25nRVl5emx5RDhxMHY0UE5s?=
 =?utf-8?B?cjNKNm1YTzQ5cjVEdExZS1dWNVRGS1puTStzenZiZjkzMjhvb3JwNytnNkps?=
 =?utf-8?B?S0FxaFNGNzVZZ2o0UVJCTHREbTV4ZGNRR3VCekRiOFRFaC8xT0VUd0dXREph?=
 =?utf-8?B?eVBRWU9sK1gvWW1DalJNalNVeCtvamc4Y2dncEdNcnZFZXVucmJUWXNzbmtF?=
 =?utf-8?B?WXNJUE5TMVNPNTBabTRvdGkwalNxV3pUNTZzK3crZHErakV4YnhrMmpnTlRP?=
 =?utf-8?B?VVFKQThKZ2hmV05GR0hlUWJjRDZvazVlWE4xVkRSYlZqZC8zSWJUcU52OGFz?=
 =?utf-8?B?TUY4Qkh3bmZwWGRYMWtKTWxjZ1c4aGs1d1owL3N4YWJFRnpTTmtEdUg2WEVz?=
 =?utf-8?B?Y3RRT1RSTm1RbElWQVpqNlFBUWV0M3gzQ3ZNRm9sTDNvZU1DQnFkckVYQktM?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dktSTEpyRGhzbUExTGM3T1FkeHdhR2RaZ1gxbnZRZlc0U2k1T1FvN0VWVEZx?=
 =?utf-8?B?eXg4aDFPUmNTeTdqK2xzbzZKUzVXT2RnRTVURklLWW9qUTZRMDBpR2orbmQy?=
 =?utf-8?B?Y2U4eHdSL01BZmdNbmE3aGVqTkdNZWN4NUJqSFpQSmsydzhORTd0M1YzUjdz?=
 =?utf-8?B?cTNPalp5MU90VFpyMDZuK1RZRkJYMXdhRElhWURBdHBrL3N1WE9kOWNDVm5r?=
 =?utf-8?B?ZEFlbWVvZytPZ09jZ1J1OEZCVS9ucDdqQzNoTW9ibUhDaVYrUmxPczE0RHM0?=
 =?utf-8?B?M3RxbGtKUzAzYTNCaktlb3M0MEFWZFg3QzRVaGc3ZGdFZjB1bWNFMCtzU1dE?=
 =?utf-8?B?THJEaVp6OFdzUHBKOElIWGVZeWI4MlJ2bGdHV3hSZFFoeU1ZYlc5WWxNalF4?=
 =?utf-8?B?aEtZcEgvTENQYXZlM3MxT3lvOUVVcnFweGZVK3UxY2J3alJhaGpxdG5qb0U1?=
 =?utf-8?B?eWVIWHI2bm5BR2s4YkRPRGl0ZEYxWkFSYnA1SS93SUZhSHFaQkFreEI2cmpn?=
 =?utf-8?B?TXAxaEFCQnREVnJnS2tLbVcrN0o5bWY5THhqQ1BrQk15T0pScEY0R09kNEx2?=
 =?utf-8?B?ekxKRkNiRThGT05LL0hDVVQxQitTOE9lN1hVMU1BeklzTUllQnpQWEN6Z1dW?=
 =?utf-8?B?dzJXc0NuZnZtUzlzRi9HSTA2MkRvWjJYaEJuZXJJbEppVnBjcXl4ZnFIMUNN?=
 =?utf-8?B?YUdvSnVxRTNCREsxSlZxUmdCUHNyYm1kbU5zQ25oTzJXS28wS0M0WXVOWVgr?=
 =?utf-8?B?R2hPKzE2bHBtamZEMGdZRVduNjZ6QkJlR2wxREFQUytPUVczY0hKTmJqMTh3?=
 =?utf-8?B?L09LZm5XSTIvcDl1LzhNWXRGOTViVEpTZk9CNDZ2VXNJZ0djZDgzbWhWV3Zx?=
 =?utf-8?B?MDhmZVZBWWxiWWk3MU01R2MxZURrOGE4WjRBTUhJZXZjQ20yUFJwY202b0hN?=
 =?utf-8?B?emhQVUo4N085STNJK1B1WDVKNFJLWGRiM1o4MVB1bjNKd1o2VW5tTlJBU1Fp?=
 =?utf-8?B?SjUxK3BHTzBGYzlsVGpqbEZOVmNUeEpMK0VGYTcyUVpaRTAxUGlqYTZSazZ2?=
 =?utf-8?B?ODNNV1NKNGJBdTlnSTBWYStDRG56V0EvU3dyMmFEMDFRRDhLMldURVZUR25Q?=
 =?utf-8?B?a2d0cHZrR3dRbnY5aU9MOURjbHRzN2RyTjg0bFZTQWR4c1gxdTByM2pQeFFB?=
 =?utf-8?B?SmNaZHV3bThFVEhUTGZyb1pKcnpTNnJMUGZGY0hkM01zaVNBY1BwK1lPWHZx?=
 =?utf-8?Q?ssCQKzbgkJN+28M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291c99b8-6e63-43d7-fcf4-08dbf4cd97b5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:33:25.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fO0KTfneDYl2Fqmrzqz54pXcumMdicTaJxNZbJp1ejggQCJIL85A9PSJctsfDKpf7GZg6H1O8r1AYKkXHMdFyMSRkgIktTYYw9/iUb6XQII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040102
X-Proofpoint-ORIG-GUID: jZUmIk7MO51UaMDkwU6CnN9JKWzZ7bPU
X-Proofpoint-GUID: jZUmIk7MO51UaMDkwU6CnN9JKWzZ7bPU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What's the decision here, pull it, or do not fix it?

- Steve

On 11/3/2023 8:26 AM, Steve Sistare wrote:
> mlx5_vdpa does not preserve userland's view of vring base for the control
> queue in the following sequence:
> 
> ioctl VHOST_SET_VRING_BASE
> ioctl VHOST_VDPA_SET_STATUS VIRTIO_CONFIG_S_DRIVER_OK
>   mlx5_vdpa_set_status()
>     setup_cvq_vring()
>       vringh_init_iotlb()
>         vringh_init_kern()
>           vrh->last_avail_idx = 0;
> ioctl VHOST_GET_VRING_BASE
> 
> To fix, restore the value of cvq->vring.last_avail_idx after calling
> vringh_init_iotlb.
> 
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 946488b8989f..ca972af3c89a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2795,13 +2795,18 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>  	struct mlx5_control_vq *cvq = &mvdev->cvq;
>  	int err = 0;
>  
> -	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
> +	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)) {
> +		u16 idx = cvq->vring.last_avail_idx;
> +
>  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
>  					MLX5_CVQ_MAX_ENT, false,
>  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
>  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
>  					(struct vring_used *)(uintptr_t)cvq->device_addr);
>  
> +		if (!err)
> +			cvq->vring.last_avail_idx = cvq->vring.last_used_idx = idx;
> +	}
>  	return err;
>  }
>  
