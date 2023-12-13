Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70873812048
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442660AbjLMUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjLMUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:55:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CAD9C;
        Wed, 13 Dec 2023 12:55:19 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKNkF6018555;
        Wed, 13 Dec 2023 20:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fXQ+QlsDMCUWQTWfQSNHnkQdRUw79xtGRMUDYEDgMIM=;
 b=M4P0L9voxmQDWh4QTLPzMl92haiQkxjlpqzRZP9eeQmbynIH0NHErNv82mjOrYM9MmYG
 jHt8Ot1V3zmSMJk1xCXqFMAyEu+WFe1sEv6ZNvA+aEhE2pqNcB2kLcQj2ZQYyFQea3U0
 W8Y2X2Z7v8OLzxp26mRSGydnAXZitjeSRrmM1EUT+GHp4LIvWauzM/q65tjNBKtJNH5G
 zxbQw6X7BS+AhL/rohEbMGmLMW0RmE0nhG1nuClzx4CmYoC4PZ9oe5ZtWxIzAEJDF4jc
 iW9zRsF04z7S9hUAIvQ+K57BkvcGRXOZUSpi2kMJWUHbm6zlxZy5xSsba3d/amhrSxTU wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrqnhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 20:54:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKDj38008303;
        Wed, 13 Dec 2023 20:54:51 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8wsfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 20:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcFYFIVZXrARNz63B6f01J429yl4JPNyG34ldyi0onm/NWtUjvN/7x6B1qvVE/qdaBZSY1Y3/7o4YJ+++sKJfkw4roJHR46CoYz5jqpMsAzFW33KzFXdt+jamtB9Sh+tlsSsTtcCvsOX+f4t1B2EHB+5fJCwbM2ByfB2lEJHcxebiijYVKLJ38wde9CwIdIeXKx2avWAP2T2szxwrWKulnseSN6J6O8ToUmGPLwxMgMo1bGRA8nSgf7SzRYCfcltyjgiIQF/Pdsg4MxD2oS981WcIWewIGrz+XXxKqex6HRIXYuMSYAjhkinw3V0lBaYgNbxP2FEGZjWa0Kf8g6LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXQ+QlsDMCUWQTWfQSNHnkQdRUw79xtGRMUDYEDgMIM=;
 b=G2yCUBVdfCyA24ct8L1DILJ+taFpYlxTXKI22KqZKzq1Zog4EX5rWVxmxVqnRwHkHS/RPhtxTfdiOzUI2aedcIxSv3APVlxh5FzblO8J6crsbkbaIz+AuxHPidUh5KAMtiMtKwBVSvJyfn8ZBobhBZuOAjFzEa28BIK0OKAWLmxhjjFFt5xPxSxUj3a57P5pR4E4+2kMWsGVD7tNfD+LfKr1GtjaFp+x1N5RmLlZr4PgVlHiXneQHAspPNOnJ4CkTphkDjgoYbDP7ouZmDYwvTAK5ub90DD5sQXh7O8uYkOj8xQiba5LkVMFIgWdScOkbc9iz7g1VSauzhmBd3JAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXQ+QlsDMCUWQTWfQSNHnkQdRUw79xtGRMUDYEDgMIM=;
 b=tD32vKmkbRH13tUB9Imxx8rrGu7BBY5VDdHZrvYh3AajB0W8DegFicK0yfo6zBfEmh9EjijI1H87eo39f4SQ8ps4Le0F822iEONUKBuWwYPea7Rem5nw1P+cmydzLKMJA//mL0wSsPE/Uf7iWbwQoq/Gxrxat+g7xOlIf4wE/wk=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA2PR10MB4457.namprd10.prod.outlook.com (2603:10b6:806:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 20:54:49 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 20:54:49 +0000
Message-ID: <e74820a9-31cf-29dd-cb69-5e091b1545ef@oracle.com>
Date:   Wed, 13 Dec 2023 12:54:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.6.y] maple_tree: do not preallocate nodes for slot
 stores
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        stable@vger.kernel.org
References: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA2PR10MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fdf9115-c6a6-448b-0773-08dbfc1dbee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNq8bzL6vYIOxRp6Y7Laz5yXBsOaYhTlHtmPSAjhhvtant2NWS0Wz3cLRbnce3h4YZ0BXGJL9gqKU1GPSDfnIIqfMcSwPhsJka0zt75Xib7i6rwdiSrmcJWkhPQFL+hsSKcSC17v9kj/BWE4bAUYsZikcHWHu08vwsaZodmhCXyEd4ZIDtkANqnkSpRteSvm5rZYnQQKU1E9w8Q50Ae4CFHgjjlHIvXD1VBNZpPrhu2Yb33wpnZ9atHq8mn5A5nw5s0CNPkIxQVyUOoty8ZgekgKWWik2nzKCZjQ/591XRJSAIAtSXDOVJX4e4u+uXog+TYeGKFXUE6izKwjiYSDZ3QQ+tGqtDHK25/opKydOVi/ea7scxEJDjcgq7aM7pvUv5mcsM9Tklg1Rx6ETwqpo6+7SsN9HY9Qux2hV8Z7EZcfz1ygFfevWdbgdI877dynTNTAlbyG111C1S0xmhYwz/XxakWRU10q9ZmvX3bInihiFyF2ZSnM/cMwmQ9aL7mI5IBic+szkI9ZeTHbOapLOKMRDD7WEefHP7fAzpEERmrnVkavQRKuxu0WBG/uK+m9OlcTlLD2jCnCawRTv7qO9hRkC2Ex+KQoUx6B6RmdL5qH7JqHUTTHzmOMVYSfM6Fe4YoqtOHEWd0Xfg6iyNI5SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(2616005)(6666004)(6512007)(6506007)(31696002)(86362001)(36756003)(38100700002)(5660300002)(4326008)(8936002)(8676002)(44832011)(966005)(83380400001)(66476007)(66556008)(66946007)(41300700001)(2906002)(478600001)(316002)(6486002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xlbGN2ZjhLdlNqczg5VzhnQzNLUlJPK2haLzJnaUtpeHEvVkdlbVBMMjAr?=
 =?utf-8?B?d1B1V3ZJRGF6L1Rjak8ydXN6eW5uekMvNHhrMjZ4RjgwOWN1MUhqQk5KYlg5?=
 =?utf-8?B?RWJzYlNENkc3VWFKNmhlR0djUzl0aVloZHRJWkZ6M1FwcWU5Ukd2UG02SCth?=
 =?utf-8?B?c2lYcnZ1OHV0dXpYS0lnaWhTWGtEODlVOS9sVFFpQWlkR0F6ZFJ0NVNLSVJ0?=
 =?utf-8?B?UkhXQVF0M1ZtdVFlUzdTamRZYTZ0UXNwMk1HL3NjUDVQZ2VLZzBFbmp5S2F3?=
 =?utf-8?B?MnV3MEx5VHU0Z05KOUxtNjFPaGpqQTdNdzN2SHlaQXY1b0NTcDNubythOXl1?=
 =?utf-8?B?QXhKcXNHYWlxOTRBVWk2Z0hFN20vb3d6T0Rpd254OW5XcVMyTHFmMEEzY1NH?=
 =?utf-8?B?WTQ3K0NKQWdHdmd0UHNkNUtGaDVYc3lhVHNsazBCT201ZEVLazczRU1xR1oz?=
 =?utf-8?B?SnFDaDhPdWgwNTAyeDlMU01pYU4rbjJ3MjBraWhncmtmNkhqQk13SnQyZitl?=
 =?utf-8?B?TndzTzdEOFBOVjY0M3dlUHJ3blVDZld4TWJNQkRyMjFXL2xIT1BobUZYRmFu?=
 =?utf-8?B?eGFPQnZmeHRhaVVHamNBTDR0b1U3ZGhudm5rd2xZakdKWWNReFQzVmF0S1ZE?=
 =?utf-8?B?RTVOZ2NjdkI2VEZkNVdmODJ6Y3hQUGt6YUZmNnBOZTVXN1JyV001Vk9mVFBx?=
 =?utf-8?B?L0dlQngwd2RiQks4cHlnNGFBNFlkRHNLTldPbitNblVsaW9sR05MUjQvcWhQ?=
 =?utf-8?B?YUFzOTU4cU1NYjB6Ylp2UndGSW10cEVBZUxDZWtSa3NKdEtkUHRwU2hkNGpW?=
 =?utf-8?B?RzVFekNGWjdRTUFYUHFzTElLYXp3cUJ1aEdjMEd4UDNVVk1FT1lyNGZiYVQx?=
 =?utf-8?B?WGxJSW5nS29BRUk4S2xISkNJd1hYNm5BT1pvQjl1VytXdHlwOEpDNkJ3Sjhm?=
 =?utf-8?B?bjZoQWlUQ2lZeTZORDVWVEZTdkJtSkZ3Y1poWmhaYW1ITFpuVVNBYUliV1Vi?=
 =?utf-8?B?aFNnUjh5U00wbWRqYXdnSEdpNG93M0hwdlBCdHJPaU8yT1ZWWTZ4ZHJyWnpr?=
 =?utf-8?B?QWdLYmM3VnhXYXBxWXVXeFYzN0c4RlhCanZrSzlaYVNaTFNiRTcvWk0xWU9U?=
 =?utf-8?B?QWo4bDJvM3VPa1duV1Y3a1QyNWEwL2JlMDd0TXhJK3NmenlkVmYraHpVenQ0?=
 =?utf-8?B?OFRhY2U2WGNzYW82R3FaOWZlbzhibVFaM2o1b3JZQysyQlpWMldvVFBuS3FH?=
 =?utf-8?B?bnUyYm5NblRucU0xNkRrNkRiYzljQ2dLMTNKVDd1cFBHdDlDTkQ0YWdPeXly?=
 =?utf-8?B?NkM0OUo2bEtKdjFyckFYRkROb3IzcHRSdmQ1ZENEUFQ2aENETVM1c2pOb0pw?=
 =?utf-8?B?cGh2TENuNi9zQVdabEprREQrV0tYNVJWRzNiSERzRTRBQnJ4WXA5b3lwN3Qz?=
 =?utf-8?B?VEtDOEdBZzlWemNwTlV2Y20vNWJmTUlWa1oyNmV1L2ZBd1Q2eHluQmhWSjlG?=
 =?utf-8?B?bGgwc3hCZkM4dkpUTXZDVTczRkNiUVN4MUxocWlCdkxadFBXRm9UcDR1RGkv?=
 =?utf-8?B?RDJUZUR3WjdqdW1pZEtBOVVDbHRHMHdvUkxhcDBlcEUzbWFKZ2g4bVpKWlVG?=
 =?utf-8?B?ekdjRjhxenJkSFE3WngzTG1MdlNGdUhLZzNQWEpELytmaEg5dG9EM25zanFT?=
 =?utf-8?B?MU9TMlNBQkUxOHN2MGYrKzA5RVRqQ3FmOURvdUdkUm56VFY0WG1Zc3JZQ0l1?=
 =?utf-8?B?OTVnc3FPQ3NmSEpQcTUydFdYcStZdW9vS1UzUXJPSjBwaGlLMlZRTlV6dVpr?=
 =?utf-8?B?a0l4Tk12YjZsV0g3S0FIS0MxY3R5WmxIbys5TkwzRGJLd1lxR3FGSWFYUmtV?=
 =?utf-8?B?TUZ0c3lGU2VoRlFQeHRGMnl4bmFra3hiUWVtdnFiTnNWdTlhdWh6ZlBYNlg0?=
 =?utf-8?B?TkhJWWhYWEcrRXI4cURTeEVuMjdKVXBpaVNCYjJJY2loMFlYdXJPbllsWjRI?=
 =?utf-8?B?cUUzd1lRdFRGR2VBMjNHQWhPSXJXSjRqYWpCRS90elQyNnJBYWNJbVhxd1lp?=
 =?utf-8?B?QVB2Q0ZXY1p6Qmo4Zmh2QytUMEh0SUdLZURmVWQyTjV6WGRtbXpmQ2d5bzZt?=
 =?utf-8?B?KzdZcjNYY3hVN1ppYnl2Rnp2KzcrSXkrSVRwTUVlQWI2Q1N3dDNpK0EyR3N2?=
 =?utf-8?Q?yvDQIktT6IUmY5JLuntAkS4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qTodoQ4YVOLV6D12pVNRp8UsIuzTNA6a+SW+sP8ag9q9dAV53Biy5saW9xQAVq6EtDJaqm7I5Ih1Kl9RAWWSet4ARR3tDDNYbZUFrL8WLeP6jEdv0IO9hXq9x60TOjlRTK8RJA3kVureB6+x11Sig+51CIUC11muhlPAfWU9i6M0YF3qxlr7eMhDI0W1XY0abu3Ekb3nItPQ4awXUdFgeM0U5mVYkym9SYNGUh9s0VzVytw7uGjp4/+Nh3Vpmf3eqtaa4p0hQv2XUK1tT4iVU9aXG3peQK223Ek6l06ZY6ulzw8Nh8Dny7x01va3Z9AsXoajjSkeSPCUmGvtYfEz5X5F5GuAwqpCFSSbgx+mowT70VItZ3PSe2HYrbgLpL2+agcZeN0mkeeptPRgd1vYCI8p2P2UnkdF7hu/P1CkDofSYxyyyDZ/NEPsv/+bLWzjUlLwk5xQ7HSMpD79RH9gl7BcaKTWATrcPtSLbPxtymXz9bnll1/fglRWpbSBiJIg0yshyQEwFy0DC9yeckr3UZMSrIF3q1Rx0BkoyDj8iAo4XtKB13pCC5A7zAtHTPqd7Et+c7rBg+yhzXQX5bWtzz5sSXTmxWxHV18q+lFZAUQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdf9115-c6a6-448b-0773-08dbfc1dbee8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 20:54:49.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ez1VZ+A/2+tXTprnscRGz7RrAshIUWIfYlJlxodwMKgU7L+DHBC4U9G98lsH+QNzbx+5fM9/mEKfJFBUnmwtKPkf8qZd/lHIR5Fj9d1lMqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130148
X-Proofpoint-GUID: 70mWRTI2Jo2QYiuKsxw4PqRgds3bYHy3
X-Proofpoint-ORIG-GUID: 70mWRTI2Jo2QYiuKsxw4PqRgds3bYHy3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 11:52 AM, Sidhartha Kumar wrote:
> mas_preallocate() defaults to requesting 1 node for preallocation and then
> ,depending on the type of store, will update the request variable. There
> isn't a check for a slot store type, so slot stores are preallocating the
> default 1 node. Slot stores do not require any additional nodes, so add a
> check for the slot store case that will bypass node_count_gfp(). Update
> the tests to reflect that slot stores do not require allocations.
> 
> User visible effects of this bug include increased memory usage from the
> unneeded node that was allocated.
> 
> Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> This is a modified backport as the patch to fix this in upstream does not
> apply to 6.6 because the node_end field was moved from the ma_wr_state to
> the ma_state after 6.6.
  Please disregard this patch, the upstream fix[1] does actually apply correctly 
to the 6.6 stable branch.

Sorry for the noise,
Sid

[1] 
https://lore.kernel.org/linux-mm/20231213205058.386589-1-sidhartha.kumar@oracle.com/T/#u



>   lib/maple_tree.c                 | 6 ++++++
>   tools/testing/radix-tree/maple.c | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922f..5950d0c0e0f69 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5501,6 +5501,12 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>   
>   	mas_wr_end_piv(&wr_mas);
>   	node_size = mas_wr_new_end(&wr_mas);
> +
> +	/* Slot store, does not require additional nodes */
> +	if ((node_size == wr_mas.node_end) && ((!mt_in_rcu(mas->tree))
> +		|| (wr_mas.offset_end - mas->offset == 1)))
> +		return 0;
> +
>   	if (node_size >= mt_slots[wr_mas.type]) {
>   		/* Split, worst case for now. */
>   		request = 1 + mas_mt_height(mas) * 2;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index e5da1cad70baf..76a8990bb14e8 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35538,7 +35538,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>   	allocated = mas_allocated(&mas);
>   	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1);
> +	MT_BUG_ON(mt, allocated != 0);
>   	mas_store_prealloc(&mas, ptr);
>   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>   

