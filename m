Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B5A7B0B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjI0R1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjI0R1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:27:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F3BA1;
        Wed, 27 Sep 2023 10:27:13 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGxFCf029692;
        Wed, 27 Sep 2023 17:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=CSWmWvFRRy5/TadhLD6gEzDJ3Vf4jovoIAzeZmFrk6o=;
 b=MLlV7Mhc8C8qXQmDT3aW6BAAk+dndDEAksn3hBUFir7zSrycDFEU4Mn2FaIoMPIETiu7
 RFY6/g0g+tbbh59rb8wucSFHS9n43Um8D3e7ll02H8aVPwhCOhLpPATTOh2Kfv2dA0Wq
 5woSWLgeOS8BlHYPLXs0c56tJU9NmU4Y/sr5JVYI9kq5cOlMZ1qrPplCuBFcdM04ObKv
 hYXB9Acg6IzlV1XqxXYXw2fdnhYiu3R3afO5a8dkGaxL5HTJPOtMHsnZV49nIRYp/ZQs
 MoARpu9jwTQziLrBGARBoUkIB2vPy9beYMSc0Hxu9Yib2BySzGWxNpIn2V4tWqpj5eS/ mA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dj9c0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 17:26:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RGSKaP030594;
        Wed, 27 Sep 2023 17:26:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf86v18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 17:26:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iShMWxNZa2j0rrHWA1rlUoyKURNLqHC0N8qu4MGzFx7cP5UeFnmL1D5dE3R6ANPTyutQIVQwxInKSWdlh7C6KSI4oRWgTNhNv5zVdAdqp2KsFYYF6pjaagRGSDwvCBxsIuOs+KEbfY20nrsA3ZOHHpckipIgn4FoUdzkdrttXNGt3DBO62UhdMaKw46KFG+ZyqKfgB2DG2IBcmvMwwSx7qq6VfbI4xHdeEHnffWNnp9OQsOcnHE+mp2oJI6xOO8Jyqc38PmaVhV35/tGhMYmV81fK++tcPUmQZnub89heaa/vffku26dvehAqMNhsiSZEU9k3ky2utYofTvm2QkdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSWmWvFRRy5/TadhLD6gEzDJ3Vf4jovoIAzeZmFrk6o=;
 b=Tr5QLQOXZzTd6oYRFZe3kHy7Y9Ww7faSlXP2+pJoXd/OzGq8ulx49c7Y3Yz/p4nGlZCgdDXurWZKd3YDPfqfSqbgPO+xDt2KDn4OOSBmp9J/YGgXgZAwW1syd5/ORIiBfrixMBC7BXwLrykF/1H6txYBuL37s58uovivaih3fS95Q1kvzV8sXETm7osuhVNcvp/FDTem9sIW3bwsjO42QKCGWh+8uSvM0Z3nhCty3YYbpN/B63qavWHDkYXEVMhL00qyTgwy9F7uq3DS5DjPpm3n+LylabnNcfKzhwsOR7RcsEAmi6AqAe5Lwn6E9dOMXWCuypllGaQAjoA22p14Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSWmWvFRRy5/TadhLD6gEzDJ3Vf4jovoIAzeZmFrk6o=;
 b=hs+NaFYXbTZZ18srqNu4ExdfOgReVtnRBo6VbFzkZcN+FSf4rzIAYtMvqPfnHwR+GzOeTlAXjxfhfmI/qv8T01ObYSKa2xjoT8yu23SIih4H4x5hYYzQvTROT2UosSHhnE4XuSaAT4HpTYC1v40K4oqGX5TILzFW5BHnyNFJduQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN7PR10MB6497.namprd10.prod.outlook.com (2603:10b6:806:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 17:26:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 17:26:52 +0000
Date:   Wed, 27 Sep 2023 13:26:49 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-ID: <20230927172649.tivg3yxtmzo3fzjb@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
 <20230927101410.920fd8a88d2453f5c530aff3@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927101410.920fd8a88d2453f5c530aff3@linux-foundation.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1P288CA0030.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::43)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SN7PR10MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: ca92908d-4915-4f3b-ebd9-08dbbf7ef069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lG2D1OvA5PKnYN3Vll4mUSbyGpAsiSgbG4MilNzaj+rQmM81ujEaiGaIbQuYD1U8d83H9cyk/xzviVsobSlFEN7JdYrSocCueM2Ws3acorfoV0SljsAWzrLtHit011of97ttiNupP94Xk26fvvSte1Fdd7Fm0LiJOEGoR2lCrdwOWmKscxvZvAxkrz/yX4H8jvqnesqR+AJ7MxR60qAZxj3PpwaNQ51fO+cjEndLozZWNLnEmGdMWCo1uE7cWx6c+DgQQH+GCqMXJ7Zwj79hOA2Y/SVBL+5YICqTgKcJ9MQ32BTeeysrshGmr1QlgZRTKVrYHcKQAVnNbYmjurR6xZRRsKuEHvB7k3HwsMcYyhCIFCnx3vX9csFgxQCYyMEo6yeL0P1ZEY52QZi6MebKn43gM8bHOXnGpfHeIp7ocr/23w3eUTvfLATK0cZjns+TC8zbFoTfyWkEdLCmCZdhXV/VZhKDwuIF0Ju6P7zo5qNQ92m/KqSy38WIxFqUnkZLuXKz4+HKOsQ1m50gmTKuStqXHYlIQgmvdaNxl/lcxTU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799009)(2906002)(54906003)(6916009)(41300700001)(316002)(4326008)(66556008)(7416002)(66476007)(66946007)(6512007)(8936002)(9686003)(8676002)(478600001)(26005)(6666004)(6486002)(5660300002)(38100700002)(6506007)(83380400001)(1076003)(966005)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sj74MaJT+TX5xSwPfj9+mGc6W0zQEkMzq6zwew9aILx3j8uZVrbM1YpS1R7o?=
 =?us-ascii?Q?sj+9DP+NvYsxUdkDc4Y0d/v1SQquq1h3WwAciNcgg3Wxe8WlWpKUUKrTCvp0?=
 =?us-ascii?Q?9xy+Dq1hl4qV0MtAh6SWcL9E008hbJFr8u24JTEZXva2Hz1FAxwJhAkpbxkr?=
 =?us-ascii?Q?QH+H8wshq1t3todllstC7jXrGHYRhQEIE2gqc24/RKgQZ0tGLZ9dLnqHRDm2?=
 =?us-ascii?Q?bYDJ/fh0/sxOIzZtp3cLJWf7NNkO3NxweWStn1GEGQB4wrUrzhjIMF8g5S1j?=
 =?us-ascii?Q?nVDfVV5xJtxWHB2hCy+lrI+3sAkxxwxUV2dKogPijbOwr25+vSg3IWIPEUTA?=
 =?us-ascii?Q?pbAInb4g4Fym8WwxhyRp4U5BUnJU/DRgU2u/3yEroaoA2PMSlSqvX504+Weo?=
 =?us-ascii?Q?hDBgzAXM0+d34rPOdjZ/fezw4bYYE8xivmk8O/UWlnUS7W/J0cXdRXpWTkOj?=
 =?us-ascii?Q?i4V6zxdnS6tA4fxlCcLjpCoVc+1R2mgOktFKmILrjFjjaFzPU8a7Q0LVWPT9?=
 =?us-ascii?Q?1hOGoX/3oiSkquL2iK8S7KusA7G9XfZzfBuvujWYc2MMuEyPJRlukEt5NucW?=
 =?us-ascii?Q?Ow3Hqz/E/jrC8icni0kY51OQuKeYyVKsRWPUpLLs9GMyrb7xCWarE+tdxY8O?=
 =?us-ascii?Q?nTEkAOYHaN7hC3l8EbCvYRu1aPHI+DXggwizSme+MQBw4O2o2E3ux0ki+XFG?=
 =?us-ascii?Q?GGtImyYbhF2x72+9sQ+1HiF8gfHrDS3qJVoVTFfv1OVV6Xura9U2TiRtVcmj?=
 =?us-ascii?Q?XtSSvm5vwviakFRfHEgotnQKCkNDkg8gmB5RGRwlvqqxDQZ9duOFepDmUE1b?=
 =?us-ascii?Q?nVVRUs+rrxZMcC8Jq6FKyHm+5hH5TVYAw2wh2N7OGjxnHWinvoyWbVgbqA9K?=
 =?us-ascii?Q?dtiRnp1pxbPtH3+PgE3ybR7v0uGx+VanIhevBRR3ojCD4ySeemH9jy3mDlg4?=
 =?us-ascii?Q?KagT3XOObtEJUsI+/tmOOZDYySEEkbYNYspnuAw719DgKKL00cBbXluzbcBg?=
 =?us-ascii?Q?N8Vo+c26rvrse8f+0+W+qobjI/VYO1ivlX9bkcuPG2ni4VIu1FDbLKITk9Zt?=
 =?us-ascii?Q?uASpf3k4y+CzmLn2vytSySBbBzMfPhENPlxayY8QjVdrBIQq6atgeXsTam/m?=
 =?us-ascii?Q?TQMqG7QnOwizcBlv49/Rsr4KDM9pPdHGqX5bFPTWNONenJFmTwrPvVeKRirD?=
 =?us-ascii?Q?3ns0UTI5prU7eiwAxVYsILrQ4pBImIFLRDwvCFtWpf5CUjmiXVhFvSMKlrb7?=
 =?us-ascii?Q?NrpEqwa/y1q0TATE9U60m73dxCjRxz7c4ITsUngt3qP4nUKUdMw6ymW+WYkd?=
 =?us-ascii?Q?ygbTFUmEOoR20nptO2Og/JNEGtWfLlv+UScAqYbDl2ZSkxZHIE4RAQbCnP07?=
 =?us-ascii?Q?gCKGhq1kFXLtHE/e+KMU+PdUpRuTe1NudYM5vJwhP7FW2vmAJwdNTM6Ys9WA?=
 =?us-ascii?Q?3SlIoAWYqNre/bq/+fQKjHGSwutmjF8cZs5ZvTnQ4eF5HCKg7B3pHqLr9/I/?=
 =?us-ascii?Q?05ZWrtt5IsRsVjE2GjTfplIvqpPUv17hmgkzJX9/zEITgPRx9ryhTVOpnD6D?=
 =?us-ascii?Q?TVcatrN9xhYF9UWxlFvDozBhQspvH4siMQWW3odc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+2jXIG5qFwPhUmIpeQsPIgINyMFc7L8zUBy3dUdQw1KVpDPzDLhbzb1ezWXO?=
 =?us-ascii?Q?LpRXD0GcDADf3y/xLFOo8zdIb5tKKpI7g1xoKF+2KWvCEuvVL/a2zMgxP59z?=
 =?us-ascii?Q?ckvqku5LMiXnNy35pvZ1DuzDTlgpdfDCpvIqy4/nCpEEoJNKLjEizEpjRB3I?=
 =?us-ascii?Q?8nUtmab/YzPcJPApxw0djsjfPNyGBcjShobXYbWZiHukIACN/i+0XvgEz4UU?=
 =?us-ascii?Q?gcZNc5rhbpe6P83zZ4xo3/spB+p8bfifQVb4x08e57A37DMNNYzUcBHkF3cN?=
 =?us-ascii?Q?Sj3ngShIB8e+j4SrGOVZLcrxc1C9B5BPGX6x6i6eq8V3w05nZFBMAhSvFb6G?=
 =?us-ascii?Q?fHarEPRsaHcw36jnm0GrMq5toxGsXkv1Y46B9M6mEHH7G1JtY27DyxWxEJgP?=
 =?us-ascii?Q?N5vTEOOpfPBAI646GS/KhFyR0rj7V10OEh3p31EEWC6r9UxipUYfjTB9tzIO?=
 =?us-ascii?Q?h7lGqzBYfCEbRjP8a5dkKwEIxzRsErMMqG4xB/1jRFGyOeIOBZ4B3fnihwmd?=
 =?us-ascii?Q?QNHYOa/lStyZZrHeNCdGMx8rDbXybJnGsdzor+WEKcHECc9kxyE/4gTxERcL?=
 =?us-ascii?Q?1HtD9qilgpPYfJXbx6dKlei4B3I/tptWyBZyr/eHQSuMo5aLFByKw5LGztXB?=
 =?us-ascii?Q?eD7aXjyYHTmnpwqzIqALmqM0h47UN6hjBXZXEbQ/SGkGiXf6I9XmlPz+eLMX?=
 =?us-ascii?Q?R8deSlELmmI9tT/fd5Y5DfyIf2RJT0JVfNav2gX7wpof4gkkwlotRjHWynIO?=
 =?us-ascii?Q?iZlBw9YSE7gTeuNR7TsYM8Bt7MXok4MTSMdO6F7B0TbblMwC0W24SA90XVnX?=
 =?us-ascii?Q?qScHhzCIb5t7QWZue3wJB+PEtsrZtprhkw9ED+0qDGls4qfumzfFR44qoT7p?=
 =?us-ascii?Q?I76bHRbxd4orn83z8qaTGhaCob1SZDDA8fCYlmCbVon+4dJHpocJhHqL7j0b?=
 =?us-ascii?Q?NQL8IU9fa73QbDy/ObpEETH3bAWOQ9ToKYgCGypHT+jT+gB9tQBazvbFc77j?=
 =?us-ascii?Q?wSOW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca92908d-4915-4f3b-ebd9-08dbbf7ef069
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 17:26:52.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZnFzdwZXuFbOELonLKbSSII9UjfjolUr/BfLxJeOPgaNecwE2YC4WeuXfwrcINTz5mORl07FPA9z2dxuvqW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6497
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_12,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=834 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270147
X-Proofpoint-GUID: tynl9o7HUn8IE12PzOo5OFvjjLRuWyOC
X-Proofpoint-ORIG-GUID: tynl9o7HUn8IE12PzOo5OFvjjLRuWyOC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230927 13:14]:
> On Wed, 27 Sep 2023 12:07:44 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > When merging of the previous VMA fails after the vma iterator has been
> > moved to the previous entry, the vma iterator must be advanced to ensure
> > the caller takes the correct action on the next vma iterator event.  Fix
> > this by adding a vma_next() call to the error path.
> > 
> > Users may experience higher CPU usage, most likely in very low memory
> > situations.
> 
> Looking through this thread:
> 
> > Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
> 
> I'm seeing no indication that the effect is CPU consumption?  Jann is
> excpecting bogus oom-killing?

His testing injected a bogus oom, but since the vma iterator may get
stuck in a "I can merge! oh, I'm out of memory" loop due to the
vma_merge() called with the same VMA in this loop, I would expect it to
be increased CPU usage when almost out of memory until a task is killed.
I don't think he expected a bogus OOM since we are using GFP_KERNEL
during mm/internal.h:vma_iter_prealloc() calls.

