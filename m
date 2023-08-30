Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8D78DF67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbjH3Tbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245728AbjH3QEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:04:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1141E19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:03:59 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iNCh008408;
        Wed, 30 Aug 2023 16:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ypu164bfFfueaE2jWcrhdsVg9oAMCNNJu2RKAhn8Rc0=;
 b=3RbDDgV+kcMP15gVHC4rqlxNFLXtvbVpPzdBRqWlWLlT4+dpG86OLkxlZaS4sFdnofqB
 6acWPVvClGWoS0rwIt3Xbgo6CyG76PMe6B2Ngbti3htsYcmpxvmFoC9l0XjMDeVnUlSK
 5mgv++cZl038fDueEh2M21Gj+hYg/Sqab5tFJuL5JeqEdCH6bkkUbDsMQZHiZdWhmXn1
 CnujQvI3QbHjdPxX51mvtxTuf7zSr1XPcUohfoqqs7rUBHzPD+zYrmgomcLFwBFNfB/J
 wEw45f1TRFYYxySlJ83s42C7Eq0eW7hk6Lx5JhWMy5IeVbzlSwlELNJU8q14fGmLe6NG uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9fk7s6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 16:03:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UFA7Sf032724;
        Wed, 30 Aug 2023 16:03:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dq7x1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 16:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdXFU4Rp9bn/cmvQeFv1gMuYolb8jcPFO9LOG96S08aYnf8t7zvmUHj8lOXSfSeljSNjwMaWiiWda6Trp4xdGtiX9sW+9RX+w2Ec+7qvoPD1pSDTAzvkFplN8izvAci9jtijmNH6ZdE6/puAHaOGwJtj6gqcWrQRzwlx1Tsm5/uDaK4X+fG00viR4CKS2h1u5G9ZCGy5EA18He+2x+VbdmVpittKIGRBYb9h8nkdQPGBvg3n2tQkIcfvxELfqDNuJujo34oh/Bo+2/VUyzef8sqIB8h/bDEDLyXicg2H6HO/QCh5dyEiRbAK/BhSc9nZLkVssZn4Z++vq+InPYTRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypu164bfFfueaE2jWcrhdsVg9oAMCNNJu2RKAhn8Rc0=;
 b=c6sACmVGOCs7sVcMqQCY6sP9MEU2+c4UV4QzDOv5SCAtoGQadrtGuifOvwLivbwE9QicqLeQBxiqAAUcUH9jLwDz3akrwQWwpdnWc6SZzw/+rx4Q5ETMXqUvmts7OQh2UpkxIXD48fbt7n36Mijzq4mCln93H6V4GcasfkE7FdL1AWNy2nK0jzrEhZSMykNwaI2cp0z1Ues0s5scvoMEKy5+3aykBpTayUl7KxrIySAagN9Bn8AYt1O43LrbtNv8GPQQaniL24tj1BRK27fAnaXHkCxenqLyqPWxyYnPna5j8b9ZUPGuQPyoLqvpu2DhFttAaF9fduNexbiGiLx+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypu164bfFfueaE2jWcrhdsVg9oAMCNNJu2RKAhn8Rc0=;
 b=qbMimyw2Nax83uJd6XyAAPBgab0pxCiJbSjjII3M0Jd5w3g8iTruI/S5SLjzYVUrIIubR4Ip3+jPwPUHgMut0D4ML8veORpn/25fFKKIxBMSYhGHdyR3liGpIRyKw7SdV6+I2W5NHCQ4Ni0aRsi1Mi47zXp6u6FgjUYpgfkiP3o=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB5251.namprd10.prod.outlook.com (2603:10b6:208:332::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 16:03:10 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 16:03:10 +0000
Message-ID: <254b1ef9-376f-a47b-ee54-ea34b40b3f72@oracle.com>
Date:   Wed, 30 Aug 2023 17:03:03 +0100
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
 <20230825190436.55045-11-mike.kravetz@oracle.com>
 <e769f96e-cd03-0530-da7a-35d9de03edfc@linux.dev>
 <e20692b8-ae64-b2e9-4177-062bf0c937ba@oracle.com>
In-Reply-To: <e20692b8-ae64-b2e9-4177-062bf0c937ba@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB5251:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a30dc1-4ebe-4cf8-a24d-08dba9729b22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9ixuHtS/ah+mPWYm7gcsCLUN/EAakXiuO9NO26Ve4RcIAz0u7lrCRm4NAh9b/EfT94MsIJ5gmy6yywb52+zLw9fLkgiwx18ztk/qjdTGM9Yi3wCWu4CtdjoSScl/m5ezC01pwrUitmXnsM8owm8h3wor4YEyVRkLNe0YOhlokjdARWwqOdKIHXfji/paKvsumssnh0QhuVr/JZbQZY244IcnlFRQeK07WPLGPDbCDieDqUI+JJoBF+rgQVDkRCenkyg59C9O6CbbGosACFTG4F7vO9888Jvko5S42KafjpYt09YQbr6Pm9JwX3KjmIDvKEsuQlkG6wNUv+/ji+hcczPs1L895iMqi/u5k/3o3U/7wD9Y8nz1m0+E8X9UaMcWsPb7h86g6mmf8u4yt3HAQWNlkNBMN3cLWCMsgfVHTZP7SMkWhpLBN7qZnpKXRvaHN85rtM+IrV3kzFds4cGdCbbaHZzbNmBMzjPg19d6jI2osfE3NmpgPlQfkLOKf3vcr2MVdqwP4WsvQcHB9ohiylfNtid3bhPVaP78djVbH1ie/6jrPOAWH3D2RGgt4hfCPyUrtENVjYrG7m+c0ZMXBGogzlAPji3jn6Jg5SH3rOD/3mcX48Uyr2ExR1Vgt1xKc6LjhDyhddGIrCTqKle/Wfe0FWmL0dQDuAPYwhzwF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(41300700001)(6636002)(4326008)(7416002)(31696002)(2906002)(2616005)(86362001)(8676002)(5660300002)(83380400001)(36756003)(26005)(8936002)(6666004)(66476007)(66946007)(66556008)(6506007)(6486002)(54906003)(53546011)(110136005)(478600001)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHl0V2p1QTl0OE1XeXNFeGxIdTE3RkJaV0dzVllzaDBOejVVaW53dHpmMlJU?=
 =?utf-8?B?S2JkeTVwREp3ZXBRVHI2SkxqT0p2Q1Y3NE9Zb09VYmVJdGhJRlcxYnFSVzcv?=
 =?utf-8?B?NXhTcnFLdXNTYXppR3ZVYlFIM1NzOWdhWVc4Rkl1Sy9jaVJKRlk1bjN2YjJL?=
 =?utf-8?B?MDhWYkZCdUJTNWtMc2o0clRFazNLRjk5eGRGTDE3VVduYU12RHFpc3Z3aW9H?=
 =?utf-8?B?S0gzSnArS2hOR0MvM2poNDNVaXl4NWVoNXluQTI4TTU1RDlEWFRBdjlpdUtT?=
 =?utf-8?B?OVhMNTI3cUIwNmluSjc3VTZ3bWZGSmdLVlFVbW40T2ljL1hNZmw5ZkhQUmlm?=
 =?utf-8?B?THhtV2Fsd3R0Z09YcS9uOGVDUzVCeHAyMk5iVzkvUlRHNVJhRU5CTlkwWWMv?=
 =?utf-8?B?eFFzSTdYNXIyZnBwZ0I5TUZIeStPcS8zQUpXUFAyV3lTeHFaR3dicWU1c2du?=
 =?utf-8?B?Nkk5SzdLMGpPZzBJMGlNQU85eWJSOXBvN3Y2MEtDbjBtc2I0aWkxTHN4UmxU?=
 =?utf-8?B?WWxKSXdvSUJ1VXJKUzQweTJoNElSSUR0NmZsbTBGa2NRekc1ajY0T1NOS1Jy?=
 =?utf-8?B?Rm8wRE1qdExnN2JIa0Vpb2tXVmEzUExuNTJueUtZMDJzRTFiVml0QTFIajAv?=
 =?utf-8?B?d3VvTXBTRVpxZXlxUHd5Yy9RWlgyOTRyVjRRaEJjenM5bHlvK3duVHpZeWZ4?=
 =?utf-8?B?QXZiTGRUN1hvRTQvSk9mdVFqdUpKRmJWempGNEZTZ3AwQlB2b1l2ZTdYVE1i?=
 =?utf-8?B?RlpuU0lFdUROSkhzVjVDcnBTR1JKVExkQzVNbk52ZGVOZEZ5QTBrbEQrdzE4?=
 =?utf-8?B?QUV5SUFzRjU5MHhRZjc3K05WSkJMK3d3WHpvM0Z0SzR5WnNNbm5DbXQrc1Aw?=
 =?utf-8?B?a3daYjZtQXdtOXNjRTFkRTRCa0FYZEthQXNMZVJ3ZW1sSTZYakFHSmhRdnlj?=
 =?utf-8?B?V3czbUEvNGZTUUlYc0lkbW5DRlRUZWp3VDlQeTU0ZzVVZ3FwOWViY1BCYkxs?=
 =?utf-8?B?TDFoYmQvY3ZOcTVjS2h2R3ZUSHlMNklmdFlqNEw4SXZUU3NBMDc3T0VsQjRT?=
 =?utf-8?B?ZmtQLzRta1V6Yy8vUU5aYXdLdHNQS1NLNC9IZVdEL3Baa3pNMVVwOU9tMSty?=
 =?utf-8?B?L0d0Nkswd0Y0NWxUS0pSNWsvNXFhdGNhT0dBVEFRU3V6ajNEME1hYTR4SXp1?=
 =?utf-8?B?a3Npakh6di9oeTRWVVNHN2JDVlJBUVNpYzBLQk9hUjRkY0ljUmZldnF0enBW?=
 =?utf-8?B?UmJwWW5sN2lmVHhMR01jLy8rdzliSXMrTUg2RjVvMVl1cmkyYVhVc1RoS2Jz?=
 =?utf-8?B?MU9kUEtVYXZlRGRCUCtsSnhmNzkrUzdvVTdmYmppU1RnNy9zWkNveGVwTDlQ?=
 =?utf-8?B?UW14UUpVM09UcCtOWTlpZlowOVBZNVBDc2lpSzc0c21kVmhDRmM4bGpROHFP?=
 =?utf-8?B?N3poVE0wQXlQMmJxOHByYy85MlJrN1VxaGdrdVVKbkVMVFNpUC9yOU9ETHVG?=
 =?utf-8?B?TmlGb3JkcE1zaHd5WFNDUzZtd3V1dWhNOXg4b3ZNb2daMC80VkFiNzlBZmli?=
 =?utf-8?B?UFdOazJtZWJQb240VzVNaVkrWFNSOEVHRTYyQmxvTS9SRDcvQWcxdkhsSDJ5?=
 =?utf-8?B?Z05Ja0RQbFg5clNZN0pXaWxRL1BDUVFGS2lIZUhIUXVaZE5HTzl4QWdiRUlQ?=
 =?utf-8?B?NVArcVAyZUJLb0xVZzFtcU9JY0V2a0Nlb0pRSEhubWVwZHNOLytUK1d2a2VB?=
 =?utf-8?B?QjROU3V3cWJXMXZocEVBaXE4eTJ5c05mK1pHL1IraXFnSWZHbDFxT1BPS091?=
 =?utf-8?B?V0hYUWN6akV3TlBhcGw3TUcyaFFwNUxEMXdaeWJJNUVraldmazdHTXJaaUlv?=
 =?utf-8?B?MVJqdmhxZUZBU3ozVFlKK1UvS1dGSTM4T1ZxTE1ndGM0NVFUd0JFdkdtV0Rp?=
 =?utf-8?B?VEhydFdsMkFBa3BROVJEQUVRaGlEeGZoZjA2UDZwWm9yRXZxVXN6Z25CVEJD?=
 =?utf-8?B?dVRzSTNSUi9UcVN0SmNPN2liMmViZG92QlhSVDFRV1dTSUN6N0dYUFZzbHF5?=
 =?utf-8?B?ajZOWkpBM3ZFdkVTQWd5Tk42UVF4aGNteFlaamQ3dWcwWEpjcjVSdGdwNmdL?=
 =?utf-8?B?clJ4VnpqK3E2YVRQTk5zU0JnVGhJckVuWDRRTXFmUUJlNGdjUjhmRk54Vnp5?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WlR5NlFGNk4xWlVocDduZEQ1WWp5SmpHTVZUNlpRR0tnYUFNdjFickhRbVYw?=
 =?utf-8?B?b2hhVDZ2akFxWTdBbE93UHJ1eG1hUzJsZ2JneUtPZjBhcnljVlpjMUdHd3hY?=
 =?utf-8?B?RThHelBlMmt4SjdTQ3VYemYraWZBQWNScXVNR04yV0hDNUxnbXVSc0VFd3l2?=
 =?utf-8?B?VTlXZkdGOXZhU0xJL2lWRW5GWGd0b2pyK2ZPWDFPc0pLOWNkQVhvY2RpZS91?=
 =?utf-8?B?bnBWN1cvTkV4ajlobWdPU1RDdDg5aTl6ME1DQ0pieTVqbUFrT29rZjZNT29R?=
 =?utf-8?B?dnF5RW5RZWIvNkl4TDJCR0c2dDhid3d5dFJ4MjlZVkYxZDVDMEJtMWFZZXB6?=
 =?utf-8?B?SGIxc3VacDVhMzBoTWdSWUNQSWEzN3dJc1ZKQTBsbTBmdWlDZ1E1bmtZNWRx?=
 =?utf-8?B?WDV3aWpZRzNSeVFvSGhrV2Q4Y0N0MXI3ZjNwMC9wSXJLblN6THlaa1hpNEJa?=
 =?utf-8?B?ZmJOdUpmQkdST0p2RlhLN25JVUc1N0JSN0VlWmVWV2o0WlpuVDV1eENrTzNr?=
 =?utf-8?B?WklFRnlmVjI4OUJ0Njc5K2d0TTVEMnE3ZDRsbFM5QWtFY1lQM29reUdKT3Yv?=
 =?utf-8?B?OW5ZTzQ0VTFTamYweGMvVnZ3TEJnZGtIQlNiaEpiU0FRa1JjMGZvNm9NZWlW?=
 =?utf-8?B?NWh3dGtsRzBOTDhRSzMrcU4rTHRWQVBnZ1BHVmlpM1VGbVJQNHhYY1VPUFAv?=
 =?utf-8?B?MVl3ci90emdjZUNHUVRZRy9iOFUrYUg2cDdnOHBPeHRZTHQ2ZWk5YUdxUVJL?=
 =?utf-8?B?NXdCNHdNeURldWhLcm5KN1lmMHp1R0Ryc3Y3UGhOSmdPc0ZHZ3lVR1EwZjFu?=
 =?utf-8?B?dmhkbE9YcjJiZjRLVnlPT1ZWb1E2NjNKVmR1biswZnJvTkcvUjRIY1g4Uk1r?=
 =?utf-8?B?SUhkR0FqUExPTlJJNm16NUJnNEJRdDNKcGtQR0hEYm1ZRTFMaXlJNnQza1hO?=
 =?utf-8?B?RElvaEFYWEY3dVFuZ0o4dmUxb25lMUFQbFRsa0JlNW44WmY1eXFJWThqNHlB?=
 =?utf-8?B?M1pCZGdzOHdFL1FpNXVCVGtJYzd1dmlBWXNtOS9iZGw0MzdaVHJRbVJsc1Uw?=
 =?utf-8?B?d2pjclp0TUN4TDhiV3ppSnQ2TXg2L0ZuK0ZOYm15dzgxeDlxSkZaaEYzaDlK?=
 =?utf-8?B?VzFqdnRiSzNoY1NNUVZkMklYMkw3TnNSOFRodGkzVXhpaUdRQUFqUkJlbm8v?=
 =?utf-8?B?Yis4Z05jdlRsb3VFN3cvaGdZalV2UkVxN3VNa1ZIdVphUkJlM2FiWjFJcXZw?=
 =?utf-8?B?UEY2NzNBVU1JVEY4Q0tHWmZ2alFKYXNEMmhIMnMva1BRN21lZksrM0wzUjhk?=
 =?utf-8?B?TUcyREN4akJqQ3BqWEgzc0c2S3Q4STFsVThYZ1B0ZEJSTzlDWmhHd0NMQUdH?=
 =?utf-8?B?ZVFEbGtualpIcEI2NnJvd2lmbmNxV0UyYlFEV3VLeS9Vb1B4dCtSNVZkcXpq?=
 =?utf-8?B?Ynl3VG1lRFlsWUthV05ndGRsUUZtTG4vRisvQjI2QjVjcHZHSWl1VmczeWJ6?=
 =?utf-8?Q?f8XPFS2D8IiGmhBtpZacx6pC5xe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a30dc1-4ebe-4cf8-a24d-08dba9729b22
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 16:03:09.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQhRegbUlQ9SDIIJcO95F31VcOnSg22h6gj8LozI36IgEONDeFUyHlnn5WReczsSkCpiVzyUQcmOtv7l8MoWrmZO5v2IkYTeEaeOLqR2h2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300149
X-Proofpoint-GUID: OmEm40ooXoIxnfZ7dG51Su2oZc6pf4lT
X-Proofpoint-ORIG-GUID: OmEm40ooXoIxnfZ7dG51Su2oZc6pf4lT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 12:13, Joao Martins wrote:
> On 30/08/2023 09:09, Muchun Song wrote:
>> On 2023/8/26 03:04, Mike Kravetz wrote:
>>> +
>>> +        /*
>>> +         * We are only splitting, not remapping the hugetlb vmemmap
>>> +         * pages.
>>> +         */
>>> +        if (bulk)
>>> +            continue;
>>
>> Actually, we don not need a flag to detect this situation, you could
>> use "!@walk->remap_pte" to determine whether we should go into the
>> next level traversal of the page table. ->remap_pte is used to traverse
>> the pte entry, so it make senses to continue to the next pmd entry if
>> it is NULL.
>>
> 
> Yeap, great suggestion.
> 
>>> +
>>>           vmemmap_pte_range(pmd, addr, next, walk);
>>>       } while (pmd++, addr = next, addr != end);
>>>   @@ -197,7 +211,8 @@ static int vmemmap_remap_range(unsigned long start,
>>> unsigned long end,
>>>               return ret;
>>>       } while (pgd++, addr = next, addr != end);
>>>   -    flush_tlb_kernel_range(start, end);
>>> +    if (!(walk->flags & VMEMMAP_REMAP_ONLY_SPLIT))
>>> +        flush_tlb_kernel_range(start, end);
>>
>> This could be:
>>
>>     if (walk->remap_pte)
>>         flush_tlb_kernel_range(start, end);
>>
> Yeap.
> 

Quite correction: This stays as is, except with a flag rename. That is because
this is actual flush that we intend to batch in the next patch. And while the
PMD split could just use !walk->remap_pte, the next patch would just need to
test NO_TLB_FLUSH flag. Meaning we endup anyways just testing for this
to-be-consolidated flag
