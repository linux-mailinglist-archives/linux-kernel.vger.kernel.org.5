Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5187D3044
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjJWKnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjJWKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:43:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F547D70;
        Mon, 23 Oct 2023 03:43:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N6j92e029445;
        Mon, 23 Oct 2023 10:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E//YI20wi059nIaWaq5mnVi1Idx8Syx4D+i2gEriTyg=;
 b=yYbhA5zY0ifVTpTVzrnLPbFhpbk9AXYbkdavwPdgCHkQkJXKD6w5qOL1ksmGVHepCF8h
 ubHAD7XEI/BtIzqTNdXCbIp0wNiiesGKll75HpY/a22WTtH4Kl6Xls+IchO76N0sgQ5U
 Jz9rSI3EVleu+lwg2Oo3yqcETcthoFYEDHMd633HsUMKNn8+UpzBM0dgK8H5jHBgpIxR
 V/TPRjAePOBfwzKXesQ94v9E5n6TgwvFaQrktOVlh41VjWxdOyL3IpqJxlL/yqvoPqBW
 Qs4660DarN3f4P9csLI6qRLWYEaZiQKxRlbciWOhSYHueU3C2s5GzBffp2AeBc5SShV2 ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbauh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 10:43:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39N9L584031089;
        Mon, 23 Oct 2023 10:43:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53aa46w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 10:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJpoArxev3sbBz4Qpt/8J8lGHEOJzl6+zvmoTOOGsq303XdnBwQX7KK60B4QRsA+NNAjMFkkPdj4ZgQlcfkBV5J7pvHv7XgZZnLkI+cdfBOM1ndl5Cx40Lw8cbvxnoOCC9Aml4I1k5OrRTvwukAmjgw6ZQ2cPVjcRxa0ufA1+wVNzzVkmqFIfzVe8FpK7rJBcgOrzUUXwJpXszJEqwHm/D3vn6cesGLCArhqEl4LL3cJHzVhfKUlqblKWncNmrWA9ciy/APDeg4pIzMYYjqokE2oa94MGJ3BJpP4IDHch5XXWJBXipE8Ku5ze6lVrlGx10ubOFEwduPj5f5iqCEaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E//YI20wi059nIaWaq5mnVi1Idx8Syx4D+i2gEriTyg=;
 b=UoOx3CuZAa4/rQ9oI2sEyCB/p/rrTywlKG0GLIXqNVskAr16eEvFkYiFagdTWeMp6PX/h6pHLkqXLa84MOkMdnTaJ2OofcMJQyFTUcljKlu2CutKvo0El6iaucoERoTiuGKRnm8XxJQsdJYbrKxoXWjCTE1EiwHc2S6Z6SMTSpKhOY+Lj0yMsSwl4zFh7EqF4qgWASrIHFqf8GQJKagKclen6+Lva/oZ0Rs1yjoOK8BnpSrTsOBHW74BHF3wgnnsXzsOfLX8dTxIdW/jNKlu8LYJiah4Hh6EtngPb10+IeYg+2iUAgKq3aqCoKl0hhwlCo1/vmMPiUbScFPnejx9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E//YI20wi059nIaWaq5mnVi1Idx8Syx4D+i2gEriTyg=;
 b=ZmL+jcLTpMj1XJZZouO1Q0unkeB+FCSMlfZ++rOBdoYG+HGiuAcJ/pQShE0eFz09nHRbrTQhHCUDqgjBW+eXdnJAqOgvYK0sn40PdUez0lLLgw6H5dPATBvgGEy6DuDc1f4kzwaFAKpoEwU3w1Q8fvMJrttUGWiGkWSetm1aGuU=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA0PR10MB6770.namprd10.prod.outlook.com (2603:10b6:208:43d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 10:43:14 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 10:43:14 +0000
Message-ID: <15de3f3c-17f6-4fe3-8e22-8e7e7361ed3e@oracle.com>
Date:   Mon, 23 Oct 2023 11:43:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the iommufd tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231023164721.1cb43dd6@canb.auug.org.au>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231023164721.1cb43dd6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA0PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: c02d6572-5905-4033-10bb-08dbd3b4dc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PajNDyZZGkfeB5GDLPdhfAlQ9AUnomBJh9M7VNc91fA6wnvzu5Gzjl1zaAUmdJPgikyQHl+F5/EhLrzWEIkEUrofESahXyuhypw1Fm/IG3bypeH1Z9z5WFk6uBhzqmdk5kp89xGxBSaYDb9+eQ/E9v41dgu0LeYGnFS/BIMW2tQ1yU3i3mcKw8nGi6iYfvtzGcYSExrY1Lfdo+MFsYmU/veSSaeLL9WmpJl/xfR3zo0mlzuFFULim11b4qw4ZANw/HLk9zRNiXtfOpXXrY2ZyDHTt95lEPwYI32QAj/hpYFTdGnlFhc+1Gjz/Txp3CHv4Uwl/goTaSbZ5WNVnQ4IxP+NokNNYYIWCS8usqsKAtA5MkN+JqHwypIbx1GW/CRdOFYUAyADi4ZEzj1XscCwHRwff4sJ2/hMhqxbJaKD7E2xnyR3LudEDD5KKi4NtY/R982AlLBc6eGP11SiGre/AbpT2e6yKfK/VXzMwXJme/Fn0WHJ1Wzi8Wx8vpcPR/3hliZOGSqUEPaciKEInOIcIb59Ve2LmjqDqeHY6GxWpYOKQn5tpJgXqj+zZG2/AA0Vdp1l49Fx3NKe9LBoKCqN51KQoeLrc9R9koQhUZzcbkABE68ck84oohCe0c+T4b/OHLdNCMElvRGs6E/YP6X2uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(54906003)(316002)(66946007)(66476007)(66556008)(38100700002)(6506007)(2616005)(110136005)(478600001)(6666004)(6512007)(6486002)(53546011)(83380400001)(4326008)(41300700001)(36756003)(31696002)(86362001)(5660300002)(8936002)(8676002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFwR3FNNE5CTENPRXdBZVZMVERpSFVkbUxlZ1EvZVoybHBMdExYOVBTQ3py?=
 =?utf-8?B?QUVSeE1pMncwY3c1Z2trYTdTMEhZSEhwOFRudzI3SlRBWTZGWnp0UzB5Uk9l?=
 =?utf-8?B?L3ZuczFOaEFKVzdwYWZKdTBGOHlMaGNoQm9Na24rVmt0WHgyMG1DVk5iN0hq?=
 =?utf-8?B?ZHpnc3lSZU1lbVZkbDZqM1NiSlFZekw4TEdCdEJVTHdCcC9YWEh5SG52TU5P?=
 =?utf-8?B?ZkFXQXYrTFBRT1pIMVJGcnJXZW1xaVNDV29FaWwvWDg0RTZ5MURuVmI4b2Zu?=
 =?utf-8?B?bFU0Uk5uK3hXeFBWRXhJL1BkNFZsMmZNL25tRDk4VDVxREJFeXQxOE1MZHlP?=
 =?utf-8?B?Nk5jRGlMcExVaC9WQkc4ckdNZ09aTWhsc1ZPb2xsVFZaVjhUNWhJdndzVlVY?=
 =?utf-8?B?cmU2YzVRUjZsTGEwd0sya1l3RkNRMmUveEN4YVZmcFVVRGpFa1RlbnpvZzZU?=
 =?utf-8?B?Z1U3RUFTUlJ3U1dXaEtLUExNR016Z2Rhc0dSbnkzSU9KcTcrTkYxQllQMllz?=
 =?utf-8?B?aXZPMS81dGMxUUZFM2lBOWcrMDVSWWFkc0hzWjFkRS90OHJTT2lwVHhuU3RJ?=
 =?utf-8?B?SUVKb1VBcFJSMXlFZFl3d2FZSkx5dVhWS2RxYTZrV0hvdU8yUUtaWEFvYWJq?=
 =?utf-8?B?dTBMdCtOblEwOTI0ZUVFZ0N5VWFrSHl1UjZ4dktEZFd6Vm1CNy93R0w2Y2Js?=
 =?utf-8?B?ckhnUlZsRVA0ayt2S1ZFY1Z1RWFDcTBDbkFtYTIzdVQ3UUtNbkxDTlpuaGNL?=
 =?utf-8?B?eGh6cDRWeTVtdk16NkhhL042TFJ1VS9UaTVwNjVjSHh2b1NRQ1BqSW5PZFo0?=
 =?utf-8?B?TStIR3JqSEs5QUNmWng5QjVnREFnbUloRGhEd1YwZDM5WWFjTCtBUDRPdUlI?=
 =?utf-8?B?eEQyOXNZa2Ftd2gwSDJhT3ZBMjVoSWdONWNwdWhoaVVBSEJHS3k4eXJIUkxk?=
 =?utf-8?B?RDlUbDA1VlRpdFdsbW5OY1VjMVYwaDRvUVdqVGExMWtRM0pHN1pNVlRUYkpU?=
 =?utf-8?B?aDF5TDlNbnhvTkd0b1dQaXBkYWlYSU5RbzB3bE1TVWs1MUxseXBPdjBIdHZD?=
 =?utf-8?B?TVBTc2RDQXpvQ0kzMktVTUZwS0NuV2tTY05rQm1GNGtkcGlMS2JrdVN1Mk5G?=
 =?utf-8?B?cFRBOHFSY3dGbjlmbUZQSlVrRmo0US9EbzdSMVBXQnV5amFYSUNoeUZOQ0lM?=
 =?utf-8?B?OWk3OGx5bXBHVGpKTWVhb29icmk2eDkrR1lHVE03OXUyQWpqVXVnQVB3b09w?=
 =?utf-8?B?Z3VqQnEyTnNDaVdjWVRFQnRwZjhoV01ZUDNLdXZ6UThTbWVOcWdyaEY4YzdO?=
 =?utf-8?B?UHZVM2tCY1RBeWxlSlJEbEU5MjB3bm9lZFNtWllzcjJrUHFQRUVLYWpZQTQ0?=
 =?utf-8?B?Q08rQlgzWlVZUXl2L0RUckVCR0tNR0ZBNzJPcW9ieWluT052bnpkaDc4WTJi?=
 =?utf-8?B?OHFXM3N2c0FJT0ZlNC9kYWI4QTFPcU9XbmQvTGp2OExGS2xnM3M0UHlJcU9C?=
 =?utf-8?B?bEZqR3o2Wll5MGg1d0RKQlBYS1VCM2hBUnRCL3VUYWRCMHJ1bVNJQTlUOEgx?=
 =?utf-8?B?c0IvTmxobE5LYWw5QXV1V2Q5dFljNEtJUlJvZC96eTFTNnhVMExPdnhoOGFt?=
 =?utf-8?B?Z1Z4bmNMMnFacEt4UkFjT1YwRGlDRTN6M0dIRFhlVkVZVEdXNm1HNlNLQjF5?=
 =?utf-8?B?dXFpN21ZZEUrQnN5dHVEZ01OQXljb0oxSm9rdzZTbDlvM1phVXZNY1ZtTTN4?=
 =?utf-8?B?Y3RaMUY4RW53VXU3WUZwaHFRWFc4Nm45c2ZrcTRHWmhtSlE0MDRvc0pKdGFa?=
 =?utf-8?B?NldVcWFLRzZPV2dYVEJpZTY2c2VoY3RtdzFnVk5rb0pIWnlzRHRUV09uOFhq?=
 =?utf-8?B?V2ZBajAzK2xpN0p6NWN3L0JWR1dlQSs0Z2NMcElmR2owWm50YWFBeGpySlRz?=
 =?utf-8?B?TUxDWXZtbURtU0lMdGU0SjVJaVBmV0RHOUZQc0hQYTg2dzdqQzZOR2NwZmFr?=
 =?utf-8?B?WkpINU5iaGVPS2c0OWdZaTEwc2x1NWRTOXVMR2pIQmdFdzc3WmQyV2lmOERM?=
 =?utf-8?B?VVVjci9GRW4xTXFHbTNQRnVkMldXd0h0NDVlV1JRUXNzakQ1aW9TaVdwOHZB?=
 =?utf-8?B?RXBSaTVvbFNqM2hyR3dVK2hxL0IreXVrVGh6Z0NueHliTVVFWW1QQzBuWEJQ?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jECmDiyBFlT7rwuXhItjZDXFUuea7kqvT5s7Ufg5wPL3HWYgVCYxFpuRl1icRlhOCJoh9O4TlBTixKCJPRmCwdNjJ1Nb3faSN61GtaWlsn0QtAApl0u1EA0I/sNAeylSUAK5VTuMBYpCchqWhGsCAvuZufrOe6FUV2XSQQPBR/hfekmDK2QURnpeOWVGJhnJLJxxxQIF2l185zF4HjAbS8YdTMzFG6Sogu91Ruo8wX4EpEriEL/kVW3B+sZPLqs9Of9KvMfwZcUIBhfJGLBzU7WcBY/KyC+/5vottBp8tIF/0VA2ZchF9pvnmOev/F0wGJmo9o1OL1etK7j3i3pCuiRRI+d9e3F5ClXWxAIZtDvZUXxyCa5XqR13UJLEHNr6R5gnPvWWmWfbNjHwJpVZRYuHL7gsqg3/8kl6YSyTkQBXJm/jXoHimO8GU2R/xC4dJKVJqYD2/OH7wstOh/CRQJ2a5Ff0jerW0pwV9dkmiBEcIJaTZbLwaXX9ETO31u4O0OIQ30oeTXazq5SmLyXq+BfqmwBaGUPGXQbJnv54Gm9Yla9+EQgwl99onmmPOAwkPajyqSSMdo4hNaZUzTI8WTBzt3L3i+W0idAXOu10rP/enPF7TiTDbsZtH9Sy1LdXi8gYT+222qmPx1uArnt3+Va3YLOK2YJbwzw15zDK9nPYfPtxK5g5ua5iauLL5+YiG6zmulDmbIywHsfrpDU1j+O54Uw0C0b/aT/EbqR1tfWCDPih1unXcGUAD6Kuf1UVDdUpPwaxm/8dmd0OoGAKWpuE8KOJydFeKkkJLjUJnQQA2naCp9RU4hbs0CqmJTWWUFAedQNzqzvogULqFEwRmFMB58ixgYTw85XhxOX5JOs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02d6572-5905-4033-10bb-08dbd3b4dc2e
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 10:43:14.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbuGSDTUUm34HmfmcNL5Q9JikUDtga4/T6BZa4RUa/6xCmLqSFaot4G7gKpDwJWl7/7uhy5ocL+wbybc9ez9lUmvY3xV4T7bairJzHKirGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_09,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230093
X-Proofpoint-GUID: 8irlhWr-_oZs8LHP7xUUvsApIUz5FJPZ
X-Proofpoint-ORIG-GUID: 8irlhWr-_oZs8LHP7xUUvsApIUz5FJPZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 06:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the iommufd tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> include/uapi/linux/iommufd.h:433: warning: expecting prototype for enum iommufd_hw_info_capabilities. Prototype was for enum iommufd_hw_capabilities instead
> include/uapi/linux/iommufd.h:497: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_set_dirty_tracking'
> include/uapi/linux/iommufd.h:512: warning: expecting prototype for enum iommufd_get_dirty_bitmap_flags. Prototype was for enum iommufd_hwpt_get_dirty_bitmap_flags instead
> include/uapi/linux/iommufd.h:542: warning: Function parameter or member '__reserved' not described in 'iommu_hwpt_get_dirty_bitmap'
> 
Thanks

I've fixed these warnings in the offending patches below; for the next version.

> Introduced by commits
> 
>   f87900f25050 ("iommufd: Add a flag to skip clearing of IOPTE dirty")
>   d2b3a545cdcc ("iommufd: Add capabilities to IOMMU_GET_HW_INFO")
>   1337d793ea25 ("iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP")
>   ccccda6d18bd ("iommufd: Add IOMMU_HWPT_SET_DIRTY_TRACKING")
> 
