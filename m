Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6980D789047
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjHYVQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjHYVPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:15:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94E211E;
        Fri, 25 Aug 2023 14:15:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEUJY026840;
        Fri, 25 Aug 2023 21:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fmjmL4SHMcgbs8nv5733Kr2m2UUfstqUWUFN6HQ60JE=;
 b=E9YO9Jwb/3MP0opTSPwBE43h0wTA3N7QyhLtOhj62IOPRMgo7WkejQXXPLDlLZNllqHY
 f0et/ZYaGRtFkc6Ofm86Q6GarHXAc8ndeX1ZKkII/3Wa4OoZNfOogeQWdPdOzpzJ08Ts
 trIbdgLHfnNVik8s/4Mj23P2IT7zHuxQsl5OeaqAdlY0Oj+7EcCKbY8iAkp7wEDMncH6
 m6/aYJE24ufdqj/0lf2SpfLuGfEWqU1jZ48OBVaV8byncKFvBbEWHe1kF+uPJVatz0lJ
 baD3uGcu1fI3eBK6QaAF1oWR12jxg7TUu8eCHndmqpre246D7X6BMfxSKD66k6KSBV6m Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yty8ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:15:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PKv20f033276;
        Fri, 25 Aug 2023 21:15:39 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yycg8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muw/DqucItyAKr63SQZsrH/vAd+7k1h6YuoKDG1Wb6FQEw3DwSWvZxkZcGkHfYt3JEg2NZ2GpxGOj/CW9ugI/JueEULDzE0F4Wl6C1WSWuLQKETtig4rZIiE2BaQHthIYBbbGJxzwD4c9oV8GfkvO9ai4BFt1WFxIGHpNGy03korps2hnSY8VBG5AQdXg51/kXkAZSreY9NHB6QmXW4DfCqn2iT02MN9+4Atwpo4Cn6LWLy7ncGZ+1cOPPS+jbsswoWxK88Ht5fal4sEug0WFuJWbX1OUcd2t7GSs/zCbKD/I52/pIbUcZrss2V8bW6pUFVu8/F4CAdzjJdVjP1yJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmjmL4SHMcgbs8nv5733Kr2m2UUfstqUWUFN6HQ60JE=;
 b=ceOL/u8GYPhtffE9renitB/r94lxS+HgqbpFGauL1Xj7kMwMJ7oFzPp+qTileIooaOgyQZ19Skn3m+CkU4JoALrLOMPR1bZSPpfpH34emd3uGep7rLOeiItXDXUhGg84YF7dTLbF09mZAt/FWqPggov1xgTONcv7gdb7M90ts+ZvtwwlMg2F46woJdio+wL7+Bf3Egsj82AslXP6/+6GbJu3RiF7sJyidrso7n9xsZvhNpOKr6Sp44Msc/8i0701a9/D0ZKszbObfXWR/MZ/9O974qeLpeSDxRd3hLbKleK1BTINwMv4qTtuVcRKv1TAPUE7b7GO7SpMyp9b9w2aiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmjmL4SHMcgbs8nv5733Kr2m2UUfstqUWUFN6HQ60JE=;
 b=UnHcfHXfQjGwWSjn7IcGm1C/n9i5Yc8NKNKVT8oi/eqjli7ews84oQ36H/J4ohAVfwn9nUrVsELgx9tZbhwg8BFcd89ewWq8qHOzMfHBYN2D6vNKTiRrdzLf9b5H3BgATFYs4tK9RzvrmF2PRYr5P7b5VCFqXgO2Eedi5ljdrT0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA3PR10MB7071.namprd10.prod.outlook.com (2603:10b6:806:319::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 21:15:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.034; Fri, 25 Aug 2023
 21:15:36 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fnic: Replace sgreset tag with max_tag_id
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msyezuvm.fsf@ca-mkp.ca.oracle.com>
References: <20230817182146.229059-1-kartilak@cisco.com>
Date:   Fri, 25 Aug 2023 17:15:34 -0400
In-Reply-To: <20230817182146.229059-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Thu, 17 Aug 2023 11:21:46 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA3PR10MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: f484ff32-4945-4fde-1dbf-08dba5b06cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AW2PAaqy3x2RSpc7UUMRwcaPXSNjPoUIMRUFbNU8b3j+0q4dfMEHmQipXg7ShcNr3OshO9GJKFy/J+F39czb5qmUOvbKonYDiOTJNMYE7D+XHT2Hgzi/fNqR1D/cr1JzHDgf70Ba3RNzbjZ/Cdn6PUIeqJK6trNuAj2IbwZMwVGVjd/UaO70BJK4lhOWVEnjzLU/MD7II7enxdLQSBLblwHmaYSCIn2aqDGJ1K4D1KQK5hgcNE9oD3a8zeEZBf52D4FjWs8W6JvIqT92awxjih3QImPQTUlUTh9KBnhaCASuLcAZdRBEARdt1gIwoTeKI7TIWpXY0RmUOr17vcnxBKJuj+dbuIb+po3WCFtmyoupdWfvQp1H0vPuKgoo+VkT2/fGhn+f/X6z9d+fU0nlJdoCykeS56T7iUrJGLIuzAOznivgJJYXV/7SqW9C3E0TBFah5tJufQyKkzhRjF6BDSgRI9CmxDy/dqJIs2YHGXwUSD8sg3zE/8kcOAN6kR/7WPiK5gs2wJTzewFXi7i76OqNP4sirwDhXqTF79FKRo9PIcmIveSvqxJ9+nIZIo/e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(7416002)(83380400001)(6512007)(26005)(478600001)(5660300002)(4744005)(2906002)(8936002)(4326008)(8676002)(6486002)(38100700002)(66946007)(66556008)(6916009)(86362001)(66476007)(41300700001)(6506007)(36916002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmZDbf2m8NQ0FzZ5cd+a0bsfeR32hMh+lBCVsRj4881a2ZK5H6KsafOQ0uDI?=
 =?us-ascii?Q?wc+XA6qn7hjmMGR4uXV0JfCuxnItNSdPQnnvGFGN+iGay0dX+RRyo5pUOxmy?=
 =?us-ascii?Q?OJhaf7wewrTswmqBeJw2U8MrdcNwnU4eAmmcyjAn1B7noz+JU7CuNvwNx3iP?=
 =?us-ascii?Q?zxu0HDZsi/NaxU+adkb4DRoVn/MWSRIG9+XoEv8J33zZi/41iW6DwDt01LFn?=
 =?us-ascii?Q?gkgiJsrvcCBMeYE6mUUKseL3fodPTEJemsboJTRXJTGbZs+GDDHFg2YLt6JO?=
 =?us-ascii?Q?rpTsGwC1uSFJ1WsF5i5Viu7OKN8DsMdk5KjJCsKxSEOwI11pXF3Jux3BnRIo?=
 =?us-ascii?Q?hIQJ5Ue4rC9h+2lAXAVM3HSdeefuQh6lRStUH7IgK6MFj5Wg19rn9p12LMGy?=
 =?us-ascii?Q?tFGNV93hvSTZAXCwfRKxUn6dy/YQv3Zpm7Ue4IvPJZNgkFltZ+vtRLomj50b?=
 =?us-ascii?Q?p5fdhTHMNtA+k3BJa39GasghSSXFEG4srB9XPTaRc+AZUQiyGrnRgj9hvmeW?=
 =?us-ascii?Q?59ELBm+v6MPap8f1jJwLOd32+1SFNohv5xbl4IlNQK3IhFZjMBAduEmrCZwf?=
 =?us-ascii?Q?uHll3QwR4t3DabYxh2gfFqlr5sUuSOB9EXLOgmKebY/BwYyR25Wds4GYc/XZ?=
 =?us-ascii?Q?eQLx/BqxqnlTybkwoDipqql2nrN6i40phT6Iq/dSRD2HcDOETjbQS2fsijef?=
 =?us-ascii?Q?V8AwcY+BYaFLmW86ZomiUqurTJz4hTNJrWmEjgE96cNKLN+zgSqo6gZ3ytGB?=
 =?us-ascii?Q?MH3g9Ud7Jx/SYzjGDW/M/Dj2RD0l1rhyj1rcq9iF8rYBLTjcH4SrevLLia2Z?=
 =?us-ascii?Q?zmSqcTRImjM1U4FrapCNsiitI1th/zpJg66k7ZtocpJZBwc3Ii90sx7ex9+P?=
 =?us-ascii?Q?sUyumdWUV8rXnGvMRFqfd3X2uuhnrRTAzpe0AMttoUTRBDvXpe7aZjKvZLye?=
 =?us-ascii?Q?9aDUEFtyyX1pXQxEMVxwE37GZhChTYErJVsosx07x8eIRW4NCNhV1igWXFfw?=
 =?us-ascii?Q?rLVonPywJnoMVX9VRbQzeLge3UD6BajEabQhPM34At5zETwsiSFN7LV5MugS?=
 =?us-ascii?Q?i2nlOVfbypNSlUqIYWZOL1jhc44KXZDJ21QZJpVj8Hhi1AHC+teeu7uW57MN?=
 =?us-ascii?Q?0f40zzewbg+J3Sjo6Nc5klcGHodjDKV5m5CQXWm4rxkF687+Q9qhmCjM3Bm8?=
 =?us-ascii?Q?+lVcok0pr56OmxYn3HjhFvgH+iDNFIEd+8E+DbOfFdE5nai/10oBftij16aT?=
 =?us-ascii?Q?retK2z4TrgN8JtZtP+ERJEKuRqL+HaHbqbEW0VzCG8rRpy69i3cFgpV1rM6m?=
 =?us-ascii?Q?MxSEa//378WW4Jqccu4Psc7nDoSutdrM2kq1AvSgs4W4KJPp3dbj/rPoUvwy?=
 =?us-ascii?Q?1oUqBGKUoZHyN2U6oYq8uQx5Y+y/IIo8BwqXCNJXEzH6hhPD08ybXhUD0Qnt?=
 =?us-ascii?Q?II7S6MrtdsHrwRjEuk4wByq3FIV/TrSpijJnh410MA3auBOEzanFd2CFg7j4?=
 =?us-ascii?Q?/ERlxTUvGNAAlh9MJDwEPu79zz8zMFtfD087cEQHaGJHHoB/3v+iu9jwAO3R?=
 =?us-ascii?Q?XHjrX1dk447Tq0MVAGG+ALicIDoElVb5HDNZIaOcMDLZkXKJioTpEU5sAZf8?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5CY/qWOipGjMy/4izk/mmnXx1kt6tKRC8NPcO8n7v63tJ+l1qydeU3gHf8SQRoytiGlLdl61HFUWE5ImYImmrLOMpa7zrLvYm6zlL5cUUgP+yNcTZyXyCDLVvApIQ/rsJKOG6MboahLSMA/tuh7R/ZKHsuateHoQNeE/kma25T5eXpAmrZ0yag7npdnt2CNkauZuZw8AukhHos8tBDNGlCf9Kh4FfE7L1G8Es9vZbALugNeP2LCMFWGyQIxp9JB1W0+CFgWieW100GXJ2ZzB7Gs9rva1HqPxv6ivWb+B56FWkCDgq/qsIt05bYQxw4MqRA1iXmPGnFbgW+gXUI+wk5CM/fVEOFwSaZ+2IAqtusJyFuzFDsfuxpKtdCUYB5pGg4h4XBwaZnDJe4WNdICG+Q+ddVGGcYYOjN+itimx9JkMv5gpjSstsOrLWDdR6fwSoHOcYyJyADZCCaN4v6+6jzvm/Kz3QlmK0F8OpMazDwzL5m6DdxAxbrx18tlQ+Uya9txwyRotb27s5hA7VszqO900NmlcY//i37PYebObYgmZgcY7v4wymtBIcjtYqjThZWh+oN4ZtDZ1Uze4FmZ5rPZO1kop9I3FqQ18MmP7d6HahWJ/D+T4SOEB1zMYvSFNCaFEreKGu42pcFU9f+B4Iw0ACfa5SCpDYQ2YvI7zvdPfWWabWfldoIix92y4MNLxyF1jWeU7dHsGvcKH+z3HkzEHtDsBYGD5/Wl8/hA1TafcOV1pCD+5f3sTEkhOT9oXkvQEu7kClohoHnw1NoGlSz3k4XmcIaxm7WYMqALtf8w2+uvXcqmRmfqFy3AXiwyluF5ud2I8jEXI3Zg0HvXiFw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f484ff32-4945-4fde-1dbf-08dba5b06cf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 21:15:36.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHf4vdeaALmI9lbi0J7AJmQV+PpNJnz5ujybxkQoma/a00aiukLRWkZMEBv0DeVuGaMIe6loMbrtnGDvNJMPUEhCWVanT7gFRXbdqZBqeYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=521 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250190
X-Proofpoint-ORIG-GUID: L5bvEkmxHTXK1Bjtyx3oKgZl5fqhybbr
X-Proofpoint-GUID: L5bvEkmxHTXK1Bjtyx3oKgZl5fqhybbr
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> sgreset is issued with a scsi command pointer. The device reset code
> assumes that it was issued on a hardware queue, and calls block
> multiqueue layer. However, the assumption is broken, and there is no
> hardware queue associated with the sgreset, and this leads to a crash
> due to a null pointer exception.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
