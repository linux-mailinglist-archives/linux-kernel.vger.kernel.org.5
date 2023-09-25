Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239D07ACD27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjIYAlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjIYAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:40:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B423E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:40:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38ONXS9V003219;
        Mon, 25 Sep 2023 00:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=hUi9rqsgyrFpUsuTjrjUN67rT69VL6+3c1OK3NOCsJk=;
 b=r9sx7XZgS4Guue+avXbviewCIL1ZYpEI1PPdXG/6YPN2Po8rKemTz1y/QHVnpbPdB53N
 FZi16Um+xXXrMtkgeOKsXoKfg8MrHNSs+t4yiHB4DBQfrwqvCRd4NmMT3/i0s2ui+fms
 JB49VPyPLDhtxuezI6+8Xz1Lr0hID8DdrVk3n9MPFAcxi1WH5BzVb/r77naN9/cCJ/i3
 UFWHE7Kxrivgeaiu3aDPOHztemb/bdf7DmcoCV8BFHAzlZ+zgKVw/X2KwpedFWgub2lL
 T1bBoS8B0xZm2qmTO0XRpMag9KidzKKEufSxbih3Y0Tze7cz6sT5py0GnlKsRx7bTzMl cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pee2eqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ON73XQ017957;
        Mon, 25 Sep 2023 00:40:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9uhdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMHKPi6/ioX9bR3PWB7BDNW18PFbGkDiTjupTuZYmv2grhpKzEqXzrWH1H3yqA8YQ6JqMKrYYqPU8jgovulFHc0TUqZzZi1VW9E1ckW5rHRaQDNz6f0KInwoIYQYmYVpTTL6dYkv7rS1bMjGSqlSO8JT4DahhI0nWdIkDEPPhJ2sAhGdTzGTlcnL8NUr6IRk5uxJSVjtXQKZCN4Tw4kW6VdojHHEjEGhVpRwhk+7UxnQZqLmkA7/mxI2AM5mx8gJ9COdAeGk8RH14EV7Zw2VutmbqZIZLlj81f2ZAwlpphZzSusFWKDieFIQYUc/DJU+AandC8w3Tc9Sk2ArNw08LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUi9rqsgyrFpUsuTjrjUN67rT69VL6+3c1OK3NOCsJk=;
 b=O8y3xfCfX5PwC4caDdq3Awzf+VqFhJnGu9+igOri4clUF+5n53gQHTyvO8yh6xSoC7ebdhzg+aKV70n7Gs8v5JXFLKzScFOhCZlK3c+24ztIAW2HgZUgKk+EB5tg9Gffl+aa8AN+1PPVU6tFmEGmYdeJFjSUcdkvLuTt5IvvBgNTeP4nUkMcJYipHi2JBE3xB/LT7WpwgKsj8oEOBfV0zZnFZCk9nwu5lsNEzlT8KNorAmPpt/G7j0lisQ4D9NIFAqC32yNMtC5olECNxAOqysWx1Ci/L5x6Mi2kcKE6/31zR2g4hzccNJNjzUrBto4BRs7Wg/nozAsjNoeUvAFJbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUi9rqsgyrFpUsuTjrjUN67rT69VL6+3c1OK3NOCsJk=;
 b=IqQts+Qi12Y+V/dFgfRBJPr8F5cVZHI1QRGkMIAA8kuMul5BFpf3YkeGmQnBsutCxZedH757EJ8dZl+AEbgCKd10mgR8tB2dKWT/LC/HLBfdye/TxERDoXK0lEPAceP2C2oKLLD6hiZGEoO1X9x7kcQBFyAcDjeqklI0DnL38lE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7819.namprd10.prod.outlook.com (2603:10b6:408:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:39:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:39:59 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 0/8] Batch hugetlb vmemmap modification operations
Date:   Sun, 24 Sep 2023 17:39:44 -0700
Message-ID: <20230925003953.142620-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: c40de6b6-c052-4624-d1d3-08dbbd5ff242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vqFqnP2piyC0zVlWKJQjcRzIcwl0jJgZCwC1cSVbiM0M0kkrvsXGKpRmmmo9K8utR0HumBwTQwNYhtJ6wHJHJUX/07yPSTBLXs5vcghaRWv6L7kliKvKB45F9HiKcoLeJTdDME/ZEx0xZsJ5A2FEnrUGiHqIHStKt7T6h89WktJy7oKgS/HlG7rPImQSkgiXB/SBFjbsxWISZfabhDep+l1J8j7WtuIG/paI7I4qRVOSQT1rluQsG/1HxyoTTj4g8NUUOHJZWL01Ze1dihY9d+9R6qsiGl4YvqaPy6OtlYjkjD7wNnB9Y2T6/HdqtZVmntvHH7CBgubC9u6osmDYSSjII5ikZfmO5MZ0xsUdMGA6p9NBSeCqjkTO89ghbATR5lVcf/LxVDvcrOenwPtblRJ+rNIpzFl5E66tM3sRJD11DsS10MkvLajkNRvXZBrxOA4ZPYOnoWlivUVo5gT7O5m5gH0e3TCkerxnxEYCOowoy4jeM4yunOs+ObDfeN3+qg4Gx+/mC/SBLnhEsxYt9gT4gHaTcI0LBKc9RY+Gq+snyoweNOoCWPFSUQ/svPOz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(66899024)(2906002)(478600001)(6486002)(36756003)(6666004)(26005)(1076003)(107886003)(38100700002)(83380400001)(6506007)(6512007)(2616005)(86362001)(41300700001)(4326008)(8676002)(8936002)(316002)(44832011)(5660300002)(66946007)(7416002)(66556008)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnEzTHdCY2h1S3o5Z3J1RzR1ZHJYdTViMUFTMmJpUlBVRnAwbEhwdnhNMnVY?=
 =?utf-8?B?M2prR2FwcVpMNFJGc3Q3ekVpbjRRVWlEaXVjdmw5RVFkcFVURzhvZ05MWmQ1?=
 =?utf-8?B?K3kzWlNWUEtWRHZLaWFTcEY2SXAvS2ZZcUZoOHZMOFFWdnRHbFhUcUZadFZp?=
 =?utf-8?B?SFU3SzM4U3VwLzVTT3pLajl3TmlNMEpFZlFXM0hSMlR1MlRqY0JSMEw0bVVD?=
 =?utf-8?B?LzJPQlNpczJBU0hGTmg2OGVjRmJKdENJMGVnL2Fucm9aK0txZ3MwREF0VXN1?=
 =?utf-8?B?aG1IRHpOVEhXUDVqSnprcnBiOGhRcnlqOHoxdklKclkxVnlCSlRlNHBUbEIr?=
 =?utf-8?B?UUlySi9mZFlad1pVVi9VcDJ4WW9Id0dVYnNndWtsTXFyclJOdEQ1ZmdrNGhC?=
 =?utf-8?B?c1hQcFZBVERvRjRSK005Z1pleGRubzBhSEJoWi81TDNJOFl6OVVSem1wZE1t?=
 =?utf-8?B?TGFudmNneHZ6UEJaWEw2TkNSZ2JVdWgxbnYzdWRuNkNaMTllazJSYlpEeTVz?=
 =?utf-8?B?dVFNeFRrYzFwS3BhZmhSSHZGWXBvT1NLRDlyMGc1M280Y0VhaHV1TFdhU2tV?=
 =?utf-8?B?SUJzelk2emZYdmJXOU1TMHRZR0V6dkplZVk2TnNvdngrNXRrZDBZbmRkT29D?=
 =?utf-8?B?VnA5ZjFUR2VndmRCTHhRK3NvMmJPa1p2YkdidXNwSS8yUjFyRnZqbTliVWR4?=
 =?utf-8?B?ekxvSW14OWo2K3FQRTc1L0VaL3UvK2tXZ0JZL2w1MU9MMHdpUUMwNjNiNENY?=
 =?utf-8?B?ZzB3WEwzUThTajNJelY3ZTJGbU9CZm5ac2JWZDdMQmQ2N2RWN0ZnZmdzQVZU?=
 =?utf-8?B?N3lMVCsrUzN0S1dIcHhnVHdJRFovcEpuMzBFUVM5SkFWdGIyRldkVXZ0MFV2?=
 =?utf-8?B?d24rWUhCL2tXdUR6WDlsaHZ5U21SQlhLRzg5Q3ZieThjKzdRZ0dicVpmV0lw?=
 =?utf-8?B?ZHJkN1YvWHUyckVIUWsxaHVwYktucm03R1lWb2dkQ3o1a1NoeDdaNjJyQ3R5?=
 =?utf-8?B?V3NlMVdGRktsMHJsNHFoZGxQN3R4amkvUnE3QmJ4MlY1SWwyVlJ1NEpYbnNZ?=
 =?utf-8?B?cDM1TFl2Rllsa2Jhck5FT2dlQUIvcWZyR1hka0ZvTEdCQ1NpazNIVjdGOTFm?=
 =?utf-8?B?di9ma1NvYmRENVlUbGlKejhTMUdsSDJVc3MvSm52aEhuOGZDRjFuNXN6SXZ6?=
 =?utf-8?B?dCsydFV2N080VnEwYmF2RzlJa25yaXZPdm0yNmZnL3o4OFBVZEZkV01RZnFB?=
 =?utf-8?B?Sk5YYVRjcTJuWmZ0K0FLeTB3aGFFOVhNYkxiU2JzWnYxQ0hxV2p5Zis4NHpD?=
 =?utf-8?B?RVRVUHp3eExFY3RVMHR1VnA5R0VDVVdSVEhCekJhUHJvTHlCR2Q2Q1lJdnRm?=
 =?utf-8?B?Y2lmZUJOc2JqVjhjeU1PbHBhbEpEQVdnK095YUgzSVR3em54TnRGTnNING5L?=
 =?utf-8?B?djlicWRiQlFxSFpiVGJMR0JzZGNKR0x4c0RJY2huSHRqNUdTRXo3d2V2QjBZ?=
 =?utf-8?B?OHFnUFFOeVpmTC9HWTJranp6R3ZMcTBCcUY1aS9Mekhyc1RCelVaNDRINytG?=
 =?utf-8?B?aU1CZ1BnZWN5SkZJUXpvMHJTbTA2UFNrR0YzdXdWTzVpNElaQmpHTndtZlJI?=
 =?utf-8?B?RkZDckRHejhFTWRNendkNjl6ODFhZnNlVzBxMmlTUEpXNDRQY0c0N1RDbzVn?=
 =?utf-8?B?QTNwdUdtUjVGQUc3WlA3UWlwbVQ1QkxPTG5LTmhBa3hhM3paZUF5OHU4TnNa?=
 =?utf-8?B?TllVMkh4RDN1WnIxRmxrMVNHOTlidlFEUFB6ZWQ5TzNkd25nZVNyY25maHUx?=
 =?utf-8?B?SWZXM29ZdnR3aTA1d2I2alBiNjZMckpla3B2S1lFZ1d0OFNFOENvR2RWQ1RO?=
 =?utf-8?B?ZHBwL2tEejVnQjR1Y0owcHVpdCtzbTR0YXNnY01IT05qZksxdytsQkVaOFRF?=
 =?utf-8?B?bDFFdnczR3JRZTZNb096L1h2a3gyOTY3VkgvQmtDcGx0RGdjN08ySEhBQzJ3?=
 =?utf-8?B?MXA2STJkQWNYSS9pZlp6MFAzQkd1RlI5enlZb3JTMzFZTXpmV01nS2ZnRktQ?=
 =?utf-8?B?Vkg4N0Q0dWs2NEhtMWkzRDFEbjJjblMwTHJxeHlnVFFJQ2FOcVhsYTJ3Ympk?=
 =?utf-8?Q?Ff/SqUKz0GptfT88C5OosJD2V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VkpRNmVLVkpGQkczK2ZUc3BsL20weFRqcHQ2ZDdzb1dHcUpNQ0RyOFdFbUxw?=
 =?utf-8?B?emxBelFQNUZKZndjbDlBUDd1Ym0xbG5nZVJtM3Z2bjllNkZFUmQyRjVadHFH?=
 =?utf-8?B?WXcybzVNems0NUFGdjVDOVdMTGVNcVI2L1VhWEJYVjQ4a0laZ0JlVEhxK3NU?=
 =?utf-8?B?MGo0eVdGNmtuOUJZaGRqZ1NqR1hPMW0zVU9DelZiYmNsTmsrYlJyWjRjQ0dw?=
 =?utf-8?B?YzE5OStnWjVUU2tiQ1diMDFvWkxoQVU2ZHdPbE9yUCtUTGk0Z3NKRHd4Q0RY?=
 =?utf-8?B?RklVeVJLZDZmaFhXZS94aUJFLzJXL1k1dmFhb2loTU0xRXJGcm80NDlUa0Yy?=
 =?utf-8?B?YjloL1JXa2pmZkVQUTIrV05BNFBYb3RQOHd3dHBucnErd2orRGlrUXJRbktv?=
 =?utf-8?B?VDJNVzJtTjVNSlA1akxtTzcyOGs1VGFvZC8wbTRiZkVYS3hSajMyM3lSQUF6?=
 =?utf-8?B?K2c3bXdHTHZBcExYRFBOY1pOVUN1WExhQkZhVHVlSFJEYmNGU3pjWkI4QURG?=
 =?utf-8?B?NSsxNnpFVkZsLzZuYTZVazMxMlkrQzZiaUloMG1EWVVnSkd1cERFZTJYTUp3?=
 =?utf-8?B?ZTZRWHp2OE5tdG5TNDFxdjQxbmlIdkowQXYwMUNsNTlJMXFVNVMrcGZ5Wjkv?=
 =?utf-8?B?ekNiWnVyOTdCZGl5QUFGdTVNak94Yys2Sk41cmVTQkY5bmtSOUpMU21Dd2hF?=
 =?utf-8?B?SHZtRnpsdXZJUFpyRldPcm1FbDYxQWVNcUoyeFZ1QzFad3picUZzN2tXazRa?=
 =?utf-8?B?WWp4M3JOc2NDVTVXV0psUjlMUndGK28vK0RSams4eG1XcEU5Y2VUV01VV01U?=
 =?utf-8?B?QjlyRHVKRHhvR0t3VDJrWkhOdG9zWTVnZ05mUW5jd0dFMzBNUEVpcDRsdWVu?=
 =?utf-8?B?L3VLTUJKTEJRUTBvWDl4dHlhTVQrank3RlREOERZNGNjb3g3dTJqSmVBclVo?=
 =?utf-8?B?Rlp0NWQyRnBoajA4NmNSVGxvN3ZqSzd1NUk5ZWluREtJVVNJSEVJeXI1aDdB?=
 =?utf-8?B?VmN2Tm8zcFNpd1lnUHVQdVJNYmRUbFA4aVVNdzM0ZWloa0svcFFLNEVlWjNG?=
 =?utf-8?B?Z0N1cTBNekFmejhmQkM3c0ZlcGNJbEo0aUhlTzNsTWxGTVBTRGpRRDJFUXFX?=
 =?utf-8?B?WSt2WjBKdnd1RUFXM2IxM3hERjRvaURWZC9obmx1RDRyOTE5cDkvQXllSHhE?=
 =?utf-8?B?NnRYSFRpVE5IYnBrd1ptb3VQVllCMHJHbjZiM0RBeS95VXNCa210VGgyZXd0?=
 =?utf-8?B?Q3E4RlNyUWFVOXNFdXVSUjlUUVg2ek4xbVRwL3FDbkpUSWc3N2ZXd3hqTTV2?=
 =?utf-8?B?UWNGVnZSVDU4VFhGWllIN2FEcEpzR0RmS0FOSmc2RkJoSXhSVzZUM2hNdGhO?=
 =?utf-8?B?cE42eGh1WGkvcjJCSWJFYXdmaGhreUlUVkhvUHR6dWxKUmlreUxyNnd3aG1s?=
 =?utf-8?B?aTRKLytBNktRYVNvb3orMlhaU2YwSXFOcE1FaUpTcmtzSERFbVFzR3dYVmhv?=
 =?utf-8?Q?RtpUMLH43jtE0a5CuAy5BI21Ef5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40de6b6-c052-4624-d1d3-08dbbd5ff242
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:39:59.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V89xsqZHlxWSiLuK5KcEKPCoc1hAQhP0f6awkvEIMDQKyjhdsRpQyzMh6FL3d1tljy5clllzecJ+iVZLZfmlmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-ORIG-GUID: eqoNmtwbZfbM0vwnia-gyx0IV9f0RQOh
X-Proofpoint-GUID: eqoNmtwbZfbM0vwnia-gyx0IV9f0RQOh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb vmemmap optimization was introduced, the overhead of enabling
the option was measured as described in commit 426e5c429d16 [1].  The summary
states that allocating a hugetlb page should be ~2x slower with optimization
and freeing a hugetlb page should be ~2-3x slower.  Such overhead was deemed
an acceptable trade off for the memory savings obtained by freeing vmemmap
pages.

It was recently reported that the overhead associated with enabling vmemmap
optimization could be as high as 190x for hugetlb page allocations.
Yes, 190x!  Some actual numbers from other environments are:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.119s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.477s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m28.973s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m36.748s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.463s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m2.931s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    2m27.609s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    2m29.924s

In the VM environment, the slowdown of enabling hugetlb vmemmap optimization
resulted in allocation times being 61x slower.

A quick profile showed that the vast majority of this overhead was due to
TLB flushing.  Each time we modify the kernel pagetable we need to flush
the TLB.  For each hugetlb that is optimized, there could be potentially
two TLB flushes performed.  One for the vmemmap pages associated with the
hugetlb page, and potentially another one if the vmemmap pages are mapped
at the PMD level and must be split.  The TLB flushes required for the kernel
pagetable, result in a broadcast IPI with each CPU having to flush a range
of pages, or do a global flush if a threshold is exceeded.  So, the flush
time increases with the number of CPUs.  In addition, in virtual environments
the broadcast IPI can’t be accelerated by hypervisor hardware and leads to
traps that need to wakeup/IPI all vCPUs which is very expensive.  Because of
this the slowdown in virtual environments is even worse than bare metal as
the number of vCPUS/CPUs is increased.

The following series attempts to reduce amount of time spent in TLB flushing.
The idea is to batch the vmemmap modification operations for multiple hugetlb
pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
flushes for each batch of pages.  One flush after splitting pages mapped at
the PMD level, and another after remapping vmemmap associated with all
hugetlb pages.  Results of such batching are as follows:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.719s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.245s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m7.267s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m13.199s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.715s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m3.186s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m4.799s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m5.273s

With batching, results are back in the 2-3x slowdown range.

This series is based on mm-unstable (September 24)

Changes v4 -> v5:
- patch 3 comment style updated, unnecessary INIT_LIST_HEAD
- patch 4 updated hugetlb_vmemmap_restore_folios to pass back number of
  restored folios in non-error case.  In addition, routine passes back
  list of folios with vmemmmap.  Naming more consistent.
- patch 5 remover over optimization and added Muchun RB
- patch 6 break and early return in ENOMEM case.  Updated comments.
  Added Muchun RB.
- patch 7 Updated comments about splitting failure.  Added Muchun RB.
- patch 8 Made comments consistent.

Changes v3 -> v4:
- Rebased on mm-unstable and dropped requisite patches.
- patch 2 updated to take bootmem vmemmap initialization into account
- patch 3 more changes for bootmem hugetlb pages.  added routine
  prep_and_add_bootmem_folios.
- patch 5 in hugetlb_vmemmap_optimize_folios on ENOMEM check for
  list_empty before freeing and retry.  This is more important in
  subsequent patch where we flush_tlb_all after ENOMEM.

Changes v2 -> v3:
- patch 5 was part of an earlier series that was not picked up.  It is
  included here as it helps with batching optimizations.
- patch 6 hugetlb_vmemmap_restore_folios is changed from type void to
  returning an error code as well as an additional output parameter providing
  the number folios for which vmemmap was actually restored.  The caller can
  then be more intelligent about processing the list.
- patch 9 eliminate local list in vmemmap_restore_pte.  The routine
  hugetlb_vmemmap_optimize_folios checks for ENOMEM and frees accumulated
  vmemmap pages while processing the list.
- patch 10 introduce flags field to struct vmemmap_remap_walk and
  VMEMMAP_SPLIT_NO_TLB_FLUSH for not flushing during pass to split PMDs.
- patch 11 rename flag VMEMMAP_REMAP_NO_TLB_FLUSH and pass in from callers.

Changes v1 -> v2:
- patch 5 now takes into account the requirement that only compound
  pages with hugetlb flag set can be passed to vmemmmap routines.  This
  involved separating the 'prep' of hugetlb pages even further.  The code
  dealing with bootmem allocations was also modified so that batching is
  possible.  Adding a 'batch' of hugetlb pages to their respective free
  lists is now done in one lock cycle.
- patch 7 added description of routine hugetlb_vmemmap_restore_folios
  (Muchun).
- patch 8 rename bulk_pages to vmemmap_pages and let caller be responsible
  for freeing (Muchun)
- patch 9 use 'walk->remap_pte' to determine if a split only operation
  is being performed (Muchun).  Removed unused variable and
  hugetlb_optimize_vmemmap_key (Muchun).
- Patch 10 pass 'flags variable' instead of bool to indicate behavior and
  allow for future expansion (Muchun).  Single flag VMEMMAP_NO_TLB_FLUSH.
  Provide detailed comment about the need to keep old and new vmemmap pages
  in sync (Muchun).
- Patch 11 pass flag variable as in patch 10 (Muchun).

Joao Martins (2):
  hugetlb: batch PMD split for bulk vmemmap dedup
  hugetlb: batch TLB flushes when freeing vmemmap

Mike Kravetz (6):
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 300 ++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 273 +++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  15 +++
 3 files changed, 505 insertions(+), 83 deletions(-)

-- 
2.41.0

