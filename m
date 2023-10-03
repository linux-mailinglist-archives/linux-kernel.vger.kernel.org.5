Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563427B7521
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjJCXhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbjJCXg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:36:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D361C4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:36:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4N5k004021;
        Tue, 3 Oct 2023 23:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MqbFCNu6RUTnO3Dy6lHzmlygQxC/mM3Cb1a+SVhH7PI=;
 b=Ar5VQMvfF6bg29d3nTi5rs5UO3NsNkLwND4IIZWMEjX96hLjcGP/bWHncJc+hAZfdvIU
 0SzsGuqWYAuBqWEtFp8NToj0n1pijuzdHvDuIik6rrGJqv8eBheY/UOM4uhE3WFLvNnP
 oM/tA80ZI2M8Ulx+RaAsIncZKvqVltvrKiGpUv7/ism6bmy+phf2uPIMP66BxRfvtSdl
 VOu7Ra6iE2yWee07zPUhv/D4VJ1aSXaR0a5cqzMA8Sz7E/alMMkzaVVBp7u32aPV4LAd
 pNXSco6llxdrhGp0AUxyxsU1L8ccNa1UK7g6YhrMOnaPVSGokzIE1rCxfjHRISSjozmu sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9udwkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:36:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393MUgxw002877;
        Tue, 3 Oct 2023 23:36:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46rwjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktxWKUzB3R/bMZSMUZdy1+DnMP9zSNGLDu4xRnzLgeAwAztQIBAhuLKM2VlKUaQET9Kak/2r03VsX7jzzueBDWAIsGWIJQMruTY6KxNOGT7NuinnI8gFxlo+3PLae8rW40WZWa0+XVI+rqHWphL2ALEptKkLRx7xaEIqyl6TnFzZsZxx00oQYHeBhSx/bvKFKMPSNGCfKULW8af/eCDagGgcPaA3FyZ0wBR3oWNN4uvsNdn17KNUV20LUBCbCWG81hPhVUcBitRU/2s2vUUyWyeJtOL00INViNK8HU9hHZFmfUqSqXIhRtKeWb97Fr9g0REHoWfXmgMTxFjzHRLCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqbFCNu6RUTnO3Dy6lHzmlygQxC/mM3Cb1a+SVhH7PI=;
 b=NVl/09trrZY7WCnGQ2w6QbzhKqm532ELBxt9klqtm6nuZErMFJupCgTZtGgiPZHlZz6F6kH1A+nvkdJ4v7GJldlhFbi+uWjriMlJav0McFmnjR3pMFeikKBLjCu9FmakKwvFkvewLLzpMdF586dLK8u1iNhHx2ziiqj2Nn2rHrTndsz6sNLYU+g2wUzIufvoDSqdY35x5PS/yKTGjzaq9ViV6c1ccadLa/RuOPbVQVlcOz6vGBxAi1B7zkiarRwMQCkMtTz46k9qkAsnPPTYkxPO3+zob4g1CFGzsqD+XflxijIsunLmxHso/NeyjcNam5ls9NUpJUuwma30IWjnPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqbFCNu6RUTnO3Dy6lHzmlygQxC/mM3Cb1a+SVhH7PI=;
 b=WtB8JgehyArQ6KJaykdpUqpHn/rgPhbi8JnTm/UcDsXsifCkRulWno7n9GfjtjxbsARg95pVccnIz2BheLMKflSkuOOqEL7GV79xW/IiVHq0bc3o8Rz5r3AesXlgq7Nim00ODBPAP5nrlyrSYDVqMdAHYvu3szKUse+OSgHep3Q=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DM4PR10MB5967.namprd10.prod.outlook.com (2603:10b6:8:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 23:36:29 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Tue, 3 Oct 2023
 23:36:28 +0000
Message-ID: <5d03f98a-262e-441c-812e-8257d66680c5@oracle.com>
Date:   Tue, 3 Oct 2023 18:36:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/jfs: Add checking for out-of-bounds index in binary
 search in xtSearch
Content-Language: en-US
To:     Juntong Deng <juntong.deng@outlook.com>, cuigaosheng1@huawei.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com
References: <VI1P193MB0752266E3E55B2D918F8E43799C4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <VI1P193MB0752266E3E55B2D918F8E43799C4A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:610:59::35) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DM4PR10MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5a6e30-32cb-4752-9be2-08dbc4699104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bCt5UWYxazF6RFlWMVBQZklJdWZYeGQ5VFlBVTlFSDF1QmRTOFAwQ1N2Nmlx?=
 =?utf-8?B?ZzBLUnlyaHVCOTgwVXlZY2drQThBaWwxVjhxRDZKUW5LSStla0lSSkhuM1dX?=
 =?utf-8?B?NmhGS2FuSnAwYm93MkdQalZTK3hacnRRTkJ0aXZEbjNLZ0xUVU1CeEVlMCtY?=
 =?utf-8?B?QVBycTl3Z01ZU1BFaDkxMmYycVo5Ymp0b1VIWVBiTlZSeWtRdXRCbzl5OHJs?=
 =?utf-8?B?VlhEQXFJdXdqTlJiYTZSMTdyMHdOZUorZGlkSHk5Q28wM3luMHI5anYvRFZB?=
 =?utf-8?B?TEhkVGhqdHZXK3JHV3YrNTN1eUw3RERDdDdIVTd3dGl6OVo5Z01SeVRlSzJU?=
 =?utf-8?B?WUlZamVxRU1RQWszN3RidDh6eXJPYm9CNlBZM3pCMi9uMzk3OHRmUWp5cTlB?=
 =?utf-8?B?dnZENmxoSi9XdUVDNkFjd2VsNTVSS0w1ZGI0bGg2N0NDaWJJck1lT3Jvd3JP?=
 =?utf-8?B?em1DNHNkT3l5MTdaelNWbzFmcUdlMlJxN2s5cHk4SXl6MExvbGcvempHR2Vz?=
 =?utf-8?B?SnBhMzIyd1Y3RVBDQUlBbWpBRElhNjYzZVMySXRSRURSVjlOQzA2NXhZaW52?=
 =?utf-8?B?K3c2dzZwaFNYNjdmT3lvQmtQY2xNVDVFT1J0bTdxREpOMWlORElaa2F2K0tl?=
 =?utf-8?B?Z3A0WTUxQXJqa1V2TlY5N1hRekVwYVFsVzM3WTBOZjllNy9kYy9LcmorSFlC?=
 =?utf-8?B?R2pEZGd0aC9FQi9GL1ZDSi9uZUp4bU9LV3o4QmNhUEF6cXptcWJhNTU2ZUhY?=
 =?utf-8?B?cXhBRlY0MDJxUXcyZ1drM2lnWDBWM1Btelp3RXZsMU56MFdzQzlFTGpobisy?=
 =?utf-8?B?VTMwRE92SzhURzJyRnZSaTNBRjNXR2YvbkNmSUI4QlJKSlNhRXMvbm84NERJ?=
 =?utf-8?B?YzYxd1hlTmdhMHlKc3ovY1FqanV4VmpEL1Z4UHpiQlRxdXBHUzZkeXJlcU10?=
 =?utf-8?B?Mm8rQlhWYUxzeWZPU21WQ0ZmUS9WYVdrU2FwdTVJbWhnM2NJMVVRNGt1WlZY?=
 =?utf-8?B?OEdJb3VQY0w1MDhLQTJvcUlVcjU5dHFMMm5NNlNDMDVVdHd4MnZ2bklsQ2cy?=
 =?utf-8?B?bkJvc005anN0SmxqTTB5MkNnWjBsUmxlUGxZYTVTL3B6a1hjamh6R0JWS250?=
 =?utf-8?B?Nk5xUGNQSE54VU9ic3lNaDd3VHdScFFBZ3ZyTEJDdjdoMEx4TFZ1T3EyU01E?=
 =?utf-8?B?YTFKSlUvVUxXWjk1VlBsd1YxTGVhMVViZytZdks4dDF1Sm1xWUo2NityOXBF?=
 =?utf-8?B?dHpRRU9ETXU0dU5vZTcrbktHTkx3eXByeFBQeWN0Tnd4SFI0WkV3bXNqdGdu?=
 =?utf-8?B?TGhBdGhhbFdjR0IyQm9rVEhlaEI4eng2RExwZHk1SkNQbHJSMkh3aTJXL29W?=
 =?utf-8?B?cFVpajRUYjJ4bk14eXVodlJ2Ym1ZZDBXRWpZTE1tb2xNUldpUWY3d2tSbG5H?=
 =?utf-8?Q?JuHr3XvF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(6512007)(2616005)(6506007)(38100700002)(6666004)(316002)(45080400002)(66946007)(66556008)(478600001)(86362001)(31696002)(966005)(83380400001)(6486002)(26005)(66476007)(41300700001)(44832011)(36756003)(5660300002)(8936002)(4326008)(8676002)(31686004)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW94Qi81R3pucFc3ZjErQ1Z1RU5wTVB5dFVJM1NGdjZtN01sZ2xDV29oUkFs?=
 =?utf-8?B?RFByYmRodjZlWFR0RWF2bitmRmpFa0NIVU8yaXVhSzdMaXhCNGh5UUtQRytv?=
 =?utf-8?B?bEhrQUlGc3A3OEtMY2pQRFV3MXpXd1loU25Hai9zc2xGWHVHN3lUSGMyQ21z?=
 =?utf-8?B?SW9CVnEwSTZnUkMycThlSnpZNmFhYU9UUE5ZSUkvVCtLSzgyMXg4UDBCS2Rm?=
 =?utf-8?B?aitHVk5FSlI0bTBkYU1sSnFpTncvS0tPdVhPVDRGSklra2dHNFhNMWxsa05t?=
 =?utf-8?B?L0hyMDFwQzcvOGg4N2ZDR2psNkVnalFvY1lPVzZqayszT2pvYzIzVFFoanJo?=
 =?utf-8?B?cFBrNS9RQXpET28wVDRxZGNWRjBzMG9VN1ZhV0hNOHRtallJVWVpYmVzdHRu?=
 =?utf-8?B?eG9BZndRd3F0VGtrVDZ6WFIvSWhJRWdaZ1VuWGcrZ0t3K2lLVExPOWk1WGJi?=
 =?utf-8?B?RHJ2WmlkL28rQTdKb3ZLNUtqeDBUNWZnZmw4cHR4VFVTUWwxOW4rZWQ0M2My?=
 =?utf-8?B?anN0YkUxWklkcGZaMzI0ZVV4Q0dZWVNma01kaWtOYjUwbXRyNVdGcjh1TC9L?=
 =?utf-8?B?N1BiMmlrRFhsUFYzeVRVR01iZ3hHVDBZWDBVWEUxZHlySnlQdGFkdjh2SzFq?=
 =?utf-8?B?bTN6cUxIdDJGcUhSQU9TeGRRRlpIWjVHM2MrM3Q0OFBlQlBnNGl3aTVwVEJE?=
 =?utf-8?B?N1NibVNnRllheXNhYmJ1UXhtOERuSGFaM2gwZXE1c1ZSSVlHdGQvNW8yRm5h?=
 =?utf-8?B?WUZiSUVVWFMvUTg2U0pacm5wblRhd3p4a29hdHdjNngzREdJNUN6VlpwbEZV?=
 =?utf-8?B?Y0s3MzlsY250cTc0Zjh6WXpkQlczeFFRNXNHZXBqVWxwWnZraU4rSktLWWpW?=
 =?utf-8?B?TXhvK2hxdUhCaUh2aXo2SWtTZTBVRkRPeUxNWnB1aHY5OFpCeUZmeVJHQnVV?=
 =?utf-8?B?SndPV2V0ZllUNGNBcDl0QVBnaCtFeGhLUnR4Y0J0cXU5aDh0THIyZDFxbUlD?=
 =?utf-8?B?dDRLLzhBVWpJWWY1ejRwRGZQclUxSi9DbVVZOXo0TEszVXkrOGFaRDdtNnVs?=
 =?utf-8?B?L25hLzZtRWtHdDdyYy9QOGZXUVBRczVDQk5xRjFLTmhPRlY3RnlxY0s3UlQ2?=
 =?utf-8?B?OFZob08vN3JKVTlOZzRpZ0J0S3ozMFdKWXNUTkpNcWhUVVhITEdLYm1YN2E1?=
 =?utf-8?B?TEFoMDhEQXI3NWFReGJjWE9Sck9nT1RkWDRKVzlhNnU3NUlUUGRiMTJYSTYw?=
 =?utf-8?B?cDVnT3N2YlQ2dXJaWVkyQ2lIKyt4cnpmRnhuRTlLcStTNnZXaGdkbVQwMW5q?=
 =?utf-8?B?WW9tazByc2FFVHViUCtCY1hhYTFDT29IaHJZRzd3c3o2NXNYTEFZMjlEQUto?=
 =?utf-8?B?em9Fb1ZXM2FzbmQyOGxmVVQ3MmlReWovVkdZK0k2Yk5odHlLUko4Y0dYZC9o?=
 =?utf-8?B?R2VjdGZNL09JaWZDTUNJMWYxTE9FU2s5NWZkV3RMcERxbUUvSmZFd0FMUWg3?=
 =?utf-8?B?MWdlZWdjZ2VLbUhLM0lmMVNUblFkZzdIK0NWdFBzS0ozcVEyaDlUemRMQ2xC?=
 =?utf-8?B?ZU1jSHo3WHhuMzh6UTNBVDRZNVhuQ2NVS0l4YnNFU1QxeUJKSGtxdHJ6N3c2?=
 =?utf-8?B?ZjVzaGdPbFJXOUJvdkVjU2FYOXZTWFlCL1hXUFFqQzQ0Qm91RjJXLzVseG55?=
 =?utf-8?B?Mms2TnAxdUQramRxOGdLQmVRNEFwTjBwMDBJWkpPYVlFV0N5b3YzTGhueGs1?=
 =?utf-8?B?N2U5NmZZR2x5VDJ4T05VdFdGVDI3RTB5MDdvVDE4L3ZEOUtQWm1nSUQraWFI?=
 =?utf-8?B?d0JQa1ppUVZnU2FJcUpzb1ZPN2tjT3dla3o0M01zbm91c0I1OFMyWjYxRzg1?=
 =?utf-8?B?emZzc3BTNWJHRW90bDViTmhZWE5JeXEvWUh2T0ZxMTVQNStNV3FYYnp1Q1Az?=
 =?utf-8?B?VGxha1lCc2NHR25HOCtSVjBCNDhVa05GRGJBM3hJRjZoWXNBcnI1NDNjZGgz?=
 =?utf-8?B?TlJOZExTNGNrUXJjL2NUUUxPMkZta3c1U0UrNGN2WW1DeVhYUyttOUl0QnFa?=
 =?utf-8?B?Q0hCWXQvWjI5ODNyc2tGc0daRTB1VkRTTkh3elhlSG9GTVdZWUp3WVBuVFhy?=
 =?utf-8?B?czNRcVJtdmlwU3ltQkxaUHA5UXZ2Z2JqL1Zidm41dTVtajRKRmxNTk9qMXhJ?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SjNlcE5DcnVMUTNGNUhhZ2VrWThoSHJ1YUhmVzI2UjJEUldMcStQOHJrQk9L?=
 =?utf-8?B?MUJuNVhBaEhlcVdYMUNzSEVuRDIwUlNkendkYjhXWHBlaTlNWE1tOGVsREMz?=
 =?utf-8?B?VTk3Z0NhbHh1UWZPbVBFNzhxa0J5RzB4RElNWjlYRDhvaUZxSFR6bCtkSjE3?=
 =?utf-8?B?Y2FtZjhySGpTK080YlA1Y2x5cFB1ZHMxeFJhTzVGa21wdTBhVWc2aG00QlBu?=
 =?utf-8?B?ZC9kczc1ZkF1TWVMZnlHNnhjdFJVOTB4c2J6b2JpWEVYcld6eHZOODVNa09v?=
 =?utf-8?B?NFlWZ0JCNGs5dmN0ZXZ6YkZnMEZPT3RGSWk0UGl6Z1dpT2xNWDdWZ25TNld2?=
 =?utf-8?B?SHBCUll1SVdXTFI4cjZONmJUa3RDcm1VSUJqMEpMZXp2d2JnNGtQMjRNdEcr?=
 =?utf-8?B?dDJqVVEyNnBlcWVNNjRZTytMWTlNOENLZnJ1Q2d3VVNWYm1BbllEYnUyWHUv?=
 =?utf-8?B?djRHYUErS2J1WllPRjhNTWRrbWhkVHFZSmVDSDFZcVhqU3FINloyR0NzNnFi?=
 =?utf-8?B?Qjg3ejRtR0hXQ2lSOXBVcFo1aGs3Zy95YTNOWFk3Y1ExM3ovYUwwL0xXWlY0?=
 =?utf-8?B?ZUk4TzQwZ1RLdjdLTnRFd2dBeVZXcWlLT1VOd2tqMzZpMnhobE1CTWpYaEpJ?=
 =?utf-8?B?U1RCTlJ3S2pxc2ZSTUxZZ1FuUEF2V3E3MW9kMDJzRmwvN1c4V3VyRloyaU9E?=
 =?utf-8?B?Mm1naVNlS0F4L21DNHB1bS9aNGR0cjlYRVdaekg4Z2cxcWV4UHZlVG96U0RM?=
 =?utf-8?B?VGI1ckNSZE5iZ2dPRWxIRDltSXhRRnNrTk9mM281Uk5IRDZyT2VETG1TQU9x?=
 =?utf-8?B?MDFHWVE5QkZFS0NzN1FJNFB1U29FNkJObTNkL1dCdllJVFkrOVp1WjBqM2pk?=
 =?utf-8?B?RmJFckVLeHpGdHBVMWJBVTBoSXN0VkFucG1PRFdpdzdrVjVwTEMvZW5Vdkx4?=
 =?utf-8?B?SUhvOThGU0hpd0R4eUNZd3EyZ2Jhb2NTV296a3YxREpmRk1sMXF2RisxTUNr?=
 =?utf-8?B?OUowUlNiVXlDY1diMzFuNHlQZzVib21XUVM5RzR5bUV6Q09ZOGtLampKZTlq?=
 =?utf-8?B?VytsMU0rbUVlT1I2TjBsZXpMZklyWTMrZlhkbzUvUVpmcjN6TkJHd0l3VGFF?=
 =?utf-8?B?dHR1Q29SMWdBT0NLaUtVaWZQYWozZWxob1dlS1BocDFRSXZLYkx0dHVJRmsy?=
 =?utf-8?B?NTYwMzQ0bHA4NWRPQVZpMmRFOVd4NG15a0FWSThOWGJlOE9oVld2VUtFUFU4?=
 =?utf-8?B?d3JYZjZBekxmQkxhL0Mva01WUkM1cEZkRjYxSzZJcEo2eTZXeXVGeHovWk1E?=
 =?utf-8?B?NkVSZG50bSt1RjEvUVJWZkF6Y3MyQzJCaC9IQzBENWhpdW0zSm9oa0NDSk9U?=
 =?utf-8?B?UllHZzVTMDdPckE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5a6e30-32cb-4752-9be2-08dbc4699104
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:36:28.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcOoLajzcZrMgNt9Ys1DYQveoRp76OpLJTRuHco9Cu6e1Xt1wQKh2o7Pbv2J7M4SRwjaHK/7tov29oJBv8R3x9tdKf6uhhKdNqbM17WcsF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5967
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=862 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030179
X-Proofpoint-ORIG-GUID: 94y23-3zhyE3okwzNFc7ZGfj0xI6Ud30
X-Proofpoint-GUID: 94y23-3zhyE3okwzNFc7ZGfj0xI6Ud30
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 5:49AM, Juntong Deng wrote:
> There is currently no out-of-bounds check for the index in a binary
> search, which may cause errors.
> 
> The following is related bug reported by Syzbot:
> 
> UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:360:4
> index 18 is out of range for type 'xad_t [18]'
> 
> Checking if the index exceeds the size of the xad array can solve
> this bug.

This won't work for the same reason I talk about here:
https://sourceforge.net/p/jfs/mailman/message/40826617/

The xad array can be either XTROOTMAXSLOT or XTPAGEMAXSLOT entries long 
and it is declared with the smaller number since it's included in the 
inode. I will fix the declarations so that we can use the larger number 
without triggering code checkers.

Thanks,
Shaggy

> 
> Reported-by: syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>   fs/jfs/jfs_xtree.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
> index 2d304cee884c..6b55bb1e4089 100644
> --- a/fs/jfs/jfs_xtree.c
> +++ b/fs/jfs/jfs_xtree.c
> @@ -356,6 +356,8 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
>   		 */
>   		for (base = XTENTRYSTART; lim; lim >>= 1) {
>   			index = base + (lim >> 1);
> +			if (index >= XTROOTMAXSLOT)
> +				break;
>   
>   			XT_CMP(cmp, xoff, &p->xad[index], t64);
>   			if (cmp == 0) {
