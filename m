Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905EC7D5808
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjJXQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjJXQWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:22:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D31FF6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:21:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OCK2mO019831;
        Tue, 24 Oct 2023 16:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=TyAKOZttVQ3VT8AylQeAptZm45adWkM5vrWEX/jWerI3Dv5gtaL0HtSgRxCAKyDC7tE0
 R57xrlgejiG0d6xSegKYI4njuZZPddBenelJCeDAE59/di1XyBgDQoB+esftvHia6HZd
 oL/IDBbvLd/iJTlIMvaNqlNw8VKKI59ySCq+P99q/z9ZUap1eqjGXdfGNGIPuTg3/jxh
 WUUiTrOVZ9HrGxDIO99cB+wz6VcwR/TMLRFTVLE1Ki1oqacgWNnqqSY4JPi07UIwjcfi
 9V3uKp8C3P3vt01YNFM5EFwPF3r2j2vEdgOjq5txuk6gCbqh6FVDHSF0a3qMsCgXdhj+ Vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbdw4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:21:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OGIWW4001520;
        Tue, 24 Oct 2023 16:21:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53bxvpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 16:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TexqB0NtlHof5wpAlFSzgrh1MVhRVj2+l/kwte2uDGJQPjkUP5MfmDm2vcpfJZr2hk/ndS25ydTQoK6feHpJreHfDqZExRzDM3FpkzRA+/ri2RN0MiLJYRpYjaz9L4Si8eS0A6FO2QrEX6bBLLGWAfvRbkv0IF8FPHGnWImrJb6GLUIHz9GIwvZUp4PSqO6Nm4GBR0aZciBU0bD4PawrRwngbB+9lUybm08uaXH3SdODSKXFUsGMeDqXl6AfLzAB/WTXh+YFQ0yPZHq61mU9xiLyCRK5Byjd5BM9mze9Q7W0bc3DmnhzU4ItSnsmDwbqY3r0LUixgqjkXcs3fDvUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=GYECR5wejXnnDCnpMDCMpnL4a+mZ9S2UneL3sBhktEm2DokM9zaNDCNeyZqmOnNjvMMsog5n0NUGqhGDpYMILTxR4Ng6nIg34GGCO1ZmKyNUJZex2MENyzgfJsVMLKW7yHCK2S/32nDeCBAY3yfkzb5rt56VQiz+sb9xSyLpFpWuqGVi6jLg9D3lAj5n8J5lWYy1WQJyIP/1OeAXRM230jiogtwhQUCNuU8HDVvQ4ysqrT9hOGv8umUTEdghbF/Z2gJOQ9yDc6SQL3yb9mp4GykC/W+UEglo24pT9oBnlugrZt0IGPi/yU1Ri5XHX1N9fXNCZmgrjJvcJFQzDnhq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUW+5lLOwVU0El0YEsYLrQyI51GIhLcF3ur87ekoV70=;
 b=m8gogac8yKtf3MxozjOEJuD2NckwpPIO5z8PRvKm6K8QgxExk8kcjUDIYYMp5CVNxC1PPO89o/4lceTHaOIJggB5R/4PaXoBNCxj6XFF/SnTI/IH6xqS7KlXQ0In3WPXe3rIXiS0zBj1T9+Mc/QLGiHB9r9ixK1BgevxUtuDa4I=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7153.namprd10.prod.outlook.com (2603:10b6:8:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:21:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 16:21:33 +0000
Message-ID: <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
Date:   Tue, 24 Oct 2023 09:21:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, sgarzare@redhat.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0013.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::26) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffa268-27ee-43c4-ee2b-08dbd4ad4960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+Msk3gGoZp/e0UgBMRm5TrgtrCXQ+OVv/DxXBHdpOxv1hhVWe+lYueNzv5w/GR+zom8cmL0kFkjBYue17Hb1Y+3sweKkiAZMhxosvjJ0A59UwaJnoSta9SXgzOw0iaNnKdUqc8BBaIp0TwSj7cZltsYBdQHpQksx/w5HA662AmR/+WYyo58zjMLqtTO/uSaRHL7iQhU9NBELBIps0+GDewHmiEucZ2Qw2iMHlmuVIMhRItms0OIhfTAba1aKraWLvqUWiloct3rIpo+NbqWBewrDcKPdisaV0EdrvDrkDDmvwGg2d0+FryD+twgWQHsaTOLhAe2KIAsEZwmIHv7HRlBIlU3QPLEsA/Zwk6TKUmiRIwtRecYo8y7gRAyd3cjhu0Vos/wjnURgIyX/dCbXTF7qgMaJLNpyfBHeQYNWwp+dMI2G8Z/Q34k4u/T3B2qoQfCUwiec05LEOcVxb39fiDGYp9okc7nFtHQxFcfWyRQXhCC+UMhyIlmcpQnxBcpRNcL9yzAdREyNyI8RvW9nbkNKruelWH7a6WfuJC8C12FDUdbnq5EODbUeNMCGUJ1aqWM3Q28W0vNymdITrLBArqtqzvjfWGVqiuOWf9xgBWGNNVVs3bs4lS7hwvo/ZKWL8jvc1aj9O/hYaY2fVUF2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6506007)(36916002)(5660300002)(6666004)(41300700001)(26005)(2906002)(83380400001)(36756003)(2616005)(38100700002)(86362001)(31696002)(6512007)(478600001)(316002)(66556008)(66476007)(66946007)(6916009)(6486002)(31686004)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVcwL2RNYnZKbUswY3BuZG5sYmhOa2wyeXBTMHJ3RW9QSUdsZDdNQkpLMWJW?=
 =?utf-8?B?NDFIeUkvT2U0R0pidDFKVGVSYnRHdzZUK1F2clJmNWpMNnJFT0hiUVU3NmZz?=
 =?utf-8?B?VVZIcHV6Q3RPUVFUeklYWWNlTUFTVDhMMWZObUZ3SWgwVVlDK3dSVkdKbDJM?=
 =?utf-8?B?ejMxVWtUeXBLSWFYc1lORmZuZWlPcU9mNHJxS3Rydi9Jb2Y0bzNnYTNwY0RR?=
 =?utf-8?B?N3Z0bElPdGc1OW1xYURpRk5jSFcvRUJPcnV6WWc3Wk5SVkJGTDh5eVJlRFM1?=
 =?utf-8?B?ajRHY3FWRSszV2JYWGVHQUs3ellwZ1JtRytSeVdCRjB6eXpKeGwzanh2SjEz?=
 =?utf-8?B?TEVpdkoraVlZcy82WTRkOE9wZXROc2ZzUTM0MGNad3Q2ekhzaCs3bE1yV1VS?=
 =?utf-8?B?dEcwRkVCazZQYjgva1kyUkF4RFVJSG5TZXVyaGs3MnozWVdPVTE4d1NJa1Jk?=
 =?utf-8?B?WlAwdzcwRTRMUjdVLytwR29IK21UUzg2anpFQ1FRbktEdkh0S0dQQXFmeC9m?=
 =?utf-8?B?TDFqY0p2MjBoZkZOdkxoaXNWenNOZVVlb0ljY2E0YnlWUTJmQXR2bUIwQlp0?=
 =?utf-8?B?anBjUERqZXBLd2VlYWZwS0w5S1NYMlo3SUNsNys4dkFKU0dVdU5OSEFUZm1E?=
 =?utf-8?B?VUxOZmpra0hQVHlFMzFrb3FxdWZBdEViWGFZSTZqdmQ0NDRFNHF5RE1wQTZV?=
 =?utf-8?B?MDdEY2VRaUpEY0RRVWl2L0N5VnZFbkppanJzNlNOcFQ0MEtsRUcwS0l6TDVZ?=
 =?utf-8?B?ZTByUkM2Z09EbkdUZ2tFU0l6V2dxK2Vhd2tvbjh1ZDNJL0JCeDUrTE1YK2VH?=
 =?utf-8?B?RDQ2N0JOWVhsRmh0WHR2b1IzQWFCR3lsWTRWRUtmcEZzOURJTlljUy9ob0Rs?=
 =?utf-8?B?cktOaWt5WityWDZlTXI5TVhHaEZaaTdnOFZxOG1sMEtwMk9pV3VaRXVHcmhL?=
 =?utf-8?B?S2NQR09QZCtybG9IY1B3ZVN2UmVPWHNZOHR5MjI5NnFQMDNxUjN5UWFkYzA4?=
 =?utf-8?B?L21LbUxMYzgwVmZBdWRxbnVYZ3VPSVNtRTJFaEUySDVwWDNHeVFkWlFtdWI0?=
 =?utf-8?B?Z0dVUmRpRHNoeXM2NDA0MXV3cDRncHIvcUpJZzhYV0NFb3RFNHptbmVhTWhx?=
 =?utf-8?B?eGhxZXFUM1YvZGd6dFRBeHVoNjlSVXR6cEJGM3hLZ2h2OHJqNktVT3Y5akNX?=
 =?utf-8?B?R1ZubjNNSUpCVEEwc3NSUmJDMGhhaWsxR1h2ZWRJQjBMRGtpZXRoNDNKa1ZQ?=
 =?utf-8?B?VHA4WXhHQkczTmkwcFN4TTVKU05idk9XbWFPbnBFRmc1SjJBN0xpajZjL3Qy?=
 =?utf-8?B?WnZFWEd1ZEZrSytiYTdFY2YyUWpRQkF3cXQ5c3AvS2Z5SkZUWlhqTFZJVXFC?=
 =?utf-8?B?S1YwVmdpblAxV25qR1ZwcUlPc2dBeCtWRFlLWEVCbkoxbThXaDFXMWV1WXYz?=
 =?utf-8?B?dEhlOTN0VmRxdmpRV3Q3QXAySUNibE1sRXZsS2Q3Uk1OL1IwVEtDNUZ1RmJt?=
 =?utf-8?B?clA1MjRIQmNka3VHbjFmMnBOc29yaElDVGNVT2Z2LzErNUFSRk1IUWVzcVVK?=
 =?utf-8?B?VzlhZlpRelVERm0xYUlUd2VDWGh0Q0xmQWFWWkE0UjhhaktaUFZsVFQxZHlW?=
 =?utf-8?B?Yzlsc3VhdTJ2eEtXcy9tMlJKcHpiZFpEU1NzY1BmQ1Z0UjNBSzJXWFJvcVNG?=
 =?utf-8?B?Mlo2eHF2VTFWNmU1T3lCRFplcHRmSEtVVXNSdDF6T3ZsSmxRM0FoTXN4U29k?=
 =?utf-8?B?M0FiN0M2bjZ5UjQ4cFdYTXVJQzUxUE1TL01tbEUrWXZDUVpLZ0duSHNZcExz?=
 =?utf-8?B?OHFmd1d3OTRFdUFLZERsUDhGMXdtN0RYR3Rtb1JvOXZHTEZQcVlJZWNjZWRS?=
 =?utf-8?B?Y25SMVJzcHlGeHJHNE1oMmNTNG9VU1QwTXJtTUxpUjMyNFdCSXMraW5FcGVQ?=
 =?utf-8?B?MHhzTVVwb2dDekhBK3hwb1RVdU9kN0tsKzJla0QvMlNJdVdMMzNRMDFYbWZu?=
 =?utf-8?B?NXJoL3RFTXBzTmxsVlFWcTY1b05MNFNYeXF5Y3dLeVBWNGVNNUZhSEE2RWtR?=
 =?utf-8?B?dHVJbUg1aElkRjE0S0Z3d2JSeFVUeHZtTnMzUGl3ZXZ0bXVrYmdURHNFWkZ2?=
 =?utf-8?Q?1C2XvSQ0OCiIuHpFDKDBYUqOj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p5oOrRQelP6zKRveE7vmGV3oSmmv5PV329jUzczu/mr5nVb2tGNl3HJYtMdW/9/PaXWsIwORip9JyeAaQ3ZtGuJP8ptF5bjXV86i84vVuZoAU4w6TeIj7vK1itIfWnfxwoyn8L9mlWbNZW9HZk6D1p/9hdANcyj0py5iPbbl5nlhrpOT2CJfqgYUWEF6+QhZlcOXMI4t+2mDdlQqeS3h31o4w5nAtv/4Z5T2kYngEntAJEg4XRA0Dhn1Orkt4TlaRD8NGGmlo9RHCgSUe+aY1onmaSLY/SdmxC9ocSV2sz+XJPEzqmJLnNYhhh9C7NTcrYUi7ea+BTK26075NzOvs6cZ6Z8nT8MpTfrA5nu8BS1zUJKqtCo2U3YaYuIXh/EycCHtavtHtAODQbCY085OPJuGtUFA6E8zxlWMU8/4Dwa0SqIgCVVdZuWaLxUgJCxE+o40y6fgzCMlOHyhvCb3tdBFXnDo1KQVTDrain/OKIJEfRpbQmwCwS469dtQ86/wLMqtQvFX5b2XtwO40AcklnG7EZzrtBoS5RwIn+eNtl4T1sPxSAbT4jhboRvhTOBvnIt2OVQdCicQIuZY5K0+bAYHvct4cFDPLlOo9ZwLTw0BiamgBfbBIG4S3WOPm1Ooz7cqAf5PT3NP6cyX5idoIdS1OcbtUTY2ojXThzUtvIGpqBTIMf6pPhO3dLdPKtiotjShtJPz+FS4hnQzVd0qnH+IsJ6i7L9l7LYNVmx1kBHjmvjgxYpi4nPudZkpjvm0fs60dSUK24/xsSHAMG1McZRXYt5/Zl3eOpEqGt5gfModZYhzcLjOcAgdtocdv76aTEr330BTpa2Xk5HZ27hQwo0Iht+x6bZUYih6kv6YKJ/WphwvCctUt0xj9Y8fOpBsP6wEwnPS7q38GZ94QijD1g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffa268-27ee-43c4-ee2b-08dbd4ad4960
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:21:33.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIN8RU2P3auSSvZpL+nhUZk8m5dbF6rBJkbh+2Ix8mYmqnbIUW12IYDwHFa5HpVlEPDx8U9XAaFwVrx30q9vRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7153
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_16,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240141
X-Proofpoint-GUID: tlyQZ8tdL3Gf1YxfLf4ft-Dt9aF8ReQd
X-Proofpoint-ORIG-GUID: tlyQZ8tdL3Gf1YxfLf4ft-Dt9aF8ReQd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2023 10:45 PM, Jason Wang wrote:
> On Sat, Oct 21, 2023 at 5:28 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Using .compat_reset op from the previous patch, the buggy .reset
>> behaviour can be kept as-is on older userspace apps, which don't ack the
>> IOTLB_PERSIST backend feature. As this compatibility quirk is limited to
>> those drivers that used to be buggy in the past, it won't affect change
>> the behaviour or affect ABI on the setups with API compliant driver.
>>
>> The separation of .compat_reset from the regular .reset allows
>> vhost-vdpa able to know which driver had broken behaviour before, so it
>> can apply the corresponding compatibility quirk to the individual driver
>> whenever needed.  Compared to overloading the existing .reset with
>> flags, .compat_reset won't cause any extra burden to the implementation
>> of every compliant driver.
>>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>> ---
>>   drivers/vhost/vdpa.c         | 17 +++++++++++++----
>>   drivers/virtio/virtio_vdpa.c |  2 +-
>>   include/linux/vdpa.h         |  7 +++++--
>>   3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index acc7c74ba7d6..9ce40003793b 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -227,13 +227,22 @@ static void vhost_vdpa_unsetup_vq_irq(struct vhost_vdpa *v, u16 qid)
>>          irq_bypass_unregister_producer(&vq->call_ctx.producer);
>>   }
>>
>> -static int vhost_vdpa_reset(struct vhost_vdpa *v)
>> +static int _compat_vdpa_reset(struct vhost_vdpa *v)
>>   {
>>          struct vdpa_device *vdpa = v->vdpa;
>> +       u32 flags = 0;
>>
>> -       v->in_batch = 0;
>> +       flags |= !vhost_backend_has_feature(v->vdev.vqs[0],
>> +                                           VHOST_BACKEND_F_IOTLB_PERSIST) ?
>> +                VDPA_RESET_F_CLEAN_MAP : 0;
>> +
>> +       return vdpa_reset(vdpa, flags);
>> +}
>>
>> -       return vdpa_reset(vdpa);
>> +static int vhost_vdpa_reset(struct vhost_vdpa *v)
>> +{
>> +       v->in_batch = 0;
>> +       return _compat_vdpa_reset(v);
>>   }
>>
>>   static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
>> @@ -312,7 +321,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>>                          vhost_vdpa_unsetup_vq_irq(v, i);
>>
>>          if (status == 0) {
>> -               ret = vdpa_reset(vdpa);
>> +               ret = _compat_vdpa_reset(v);
>>                  if (ret)
>>                          return ret;
>>          } else
>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>> index 06ce6d8c2e00..8d63e5923d24 100644
>> --- a/drivers/virtio/virtio_vdpa.c
>> +++ b/drivers/virtio/virtio_vdpa.c
>> @@ -100,7 +100,7 @@ static void virtio_vdpa_reset(struct virtio_device *vdev)
>>   {
>>          struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>>
>> -       vdpa_reset(vdpa);
>> +       vdpa_reset(vdpa, 0);
>>   }
>>
>>   static bool virtio_vdpa_notify(struct virtqueue *vq)
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index 6b8cbf75712d..db15ac07f8a6 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -519,14 +519,17 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>>          return vdev->dma_dev;
>>   }
>>
>> -static inline int vdpa_reset(struct vdpa_device *vdev)
>> +static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
>>   {
>>          const struct vdpa_config_ops *ops = vdev->config;
>>          int ret;
>>
>>          down_write(&vdev->cf_lock);
>>          vdev->features_valid = false;
>> -       ret = ops->reset(vdev);
>> +       if (ops->compat_reset && flags)
>> +               ret = ops->compat_reset(vdev, flags);
>> +       else
>> +               ret = ops->reset(vdev);
> Instead of inventing a new API that carries the flags. Tweak the
> existing one seems to be simpler and better?
Well, as indicated in the commit message, this allows vhost-vdpa be able 
to know which driver had broken behavior before, so it
can apply the corresponding compatibility quirk to the individual driver 
when it's really necessary. If sending all flags unconditionally down to 
every driver, it's hard for driver writers to distinguish which are 
compatibility quirks that they can safely ignore and which are feature 
flags that are encouraged to implement. In that sense, gating features 
from being polluted by compatibility quirks with an implicit op would be 
better.

Regards,
-Siwei
>
> As compat_reset(vdev, 0) == reset(vdev)
>
> Then you don't need the switch in the parent as well
>
> +static int vdpasim_reset(struct vdpa_device *vdpa)
> +{
> +       return vdpasim_compat_reset(vdpa, 0);
> +}
>
> Thanks
>
>
>>          up_write(&vdev->cf_lock);
>>          return ret;
>>   }
>> --
>> 2.39.3
>>

