Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A357A5C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjISI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjISI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:28:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8CA116
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:28:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6TLL4007941;
        Tue, 19 Sep 2023 08:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=DZdKL0VVc41h7O8wmoguBaOa8xrrTvsiwN14sEra10A=;
 b=2UylhGjI+/zCQU6RE5s0Tl73oi/XxWM+q0+6OiQMJ36jEMrpBfGn3FwjDfxfLYj2QRBH
 RQ6L9IibBnfoRHfGO/NarkTOuwGtZAuVW5JXeK3Pl1ym/iOQ+8q3Hh01/yiIhk2Ni04K
 OaD7L/MCBsYL9CJxXycMAGh3vPS0wC+0oJ5E9w3u8gEQIv62bEEg+ET7q61qGv72+V7z
 oB0285IlMc87XZ5eIGgF++IEw/t0oeOXhi82GqHEIQQUVxgP8cvjvAa7dBC8rc5vS724
 xsAg5C6ExeMrzpV69KZWMmQwOYCCGLEDMCWY9/8wlBVpZL/+KQRWS22gQr88b94EkVQN fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wum97x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:27:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J7huJM015971;
        Tue, 19 Sep 2023 08:27:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t537et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhSGJfb7686Y4UtgnCfMnmiHBJu5cYPZ43dm0ng4vBS3BcPZmSy3enDgYFiY7lJ0vWbXtBq9RCkKCx7zN4wAdvdZ9EJlC4BRoZbzZ4RqPhYUcqPBAaGa1bDEVEWgS74E4QsZ8NzigMUtwB5pCrhKs1CWghDznhaHwWSEa/Oz+dclCgQPaihX0R0lC7cNLluQaKdeB2cGc9qK2cf0UyiB3mlBoLGYSuwtFPaXBJMnhJq6RSJGFJw5ve83KtmAeub858xu3P7mK8fab34CcHMeT2HSTAtevREDHRLw2frhksxAfFG9Bf7KfnZj7QEbwnbpx5s2DlRTXW6I0ir1CkFu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZdKL0VVc41h7O8wmoguBaOa8xrrTvsiwN14sEra10A=;
 b=Ntco373zhfoat7oD9a+PG/Am7INApMzPi4UQJqL5sTP4P3UP/lq3QtW3nKfHyd7bBW4Rqe+9QchI4oo1h68oHBTC9QzsMhy8nLdeoJE2+0jtMAWZ6IRyCvgBc3A4zwVltXw1wOqLZwaFU8algH4/HRLPkdK8/zDiLFEwsitb6DnXd2+2atN+qPCCindNMA/HdCog9Ek2WwFCnNyTgIwAAY5ctYO/rw8ZUBg4i+mVLvUROp7Tlt2Y6SqoNKEX04Ng/KlXOTmvaHrdE4oa2+BfdzMtjel/LNCCv+dgFz4/VemoB8NYu8G1gR0E1+x4eZQSz2jtZDvaytBJ2bIY7O+ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZdKL0VVc41h7O8wmoguBaOa8xrrTvsiwN14sEra10A=;
 b=NOqgdcRfHH+XqT0/ZqCMn86Ic5yEb1ENtoirG59j1jmp2yVo1VKrUMcy4sAKpXgsWi3aZYNb1mHdT/dRJl5VY66Z8KRorkrbDBeMIYogYJigMcrVHi6nELP4FOGxtd1fWwqiYBG/rX2EEWEYeYQkEKSjwffHc2/GLLdWJLquE5Q=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 08:27:03 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:27:03 +0000
Message-ID: <d8ca9ff5-3160-49a1-947a-de4998887dce@oracle.com>
Date:   Tue, 19 Sep 2023 09:26:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0114.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::21) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e933bff-d750-4a1f-3d21-08dbb8ea336f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5cPofcMhwH5XwhkmSqxg5yK0oUkGP8v6ZNHtgD+lOOttU6/7XgbH9dSE2VBFTCnphqKWg2vLl+fQG7UbNtWMTEjx6J6X9KRCZ4PXWCiaBtz69DHzHrA4rajSqjf99D4tNJZ8m4lwVj1jQokxm1CZAzAhI1kDRHqu4bAnOQ/50nnMKfBHHlt0+pmGQ1WQN5DKL1+sN9QcisLFUkOIEUzWHwkeDTkcfkOQaVJzCo2KBCJsCOlsGFcR7suAsO231M61ptSaoZg7X1BeyX0aW29AdMBjLD4bOcSZhcIdroP2QeAzhLXxcNU2AOy+e2Sd6+EKMrTHPHaCQvT90gJZGgnygdQqWo259sW06K0iYkE5ZrIkKFuhvrFGEEH1Yooiq33vDHqmnvEwDIOOEyjJRHe0963A57vnAbx8t9z+ddyNbZmq/FTJsmkj1JUWWFX1N+waFOmNcRA77NspSMHyyWMlEQR6roHauy5QiVQf8g9eDwQ0JVuLIVKZ00exqaUt3aCr/cx2q5sPfscHht7RXGTUG4j8OEa5ZvU79dvAEB7YT2PUZsk2jMBU3EOr0Bx3OYVlZzi2IGXkEzEDPX1lfCpcqM5ckH8SkFxuKOMHmcr5Vrn3f3NUWwph9lxx8GJ/oXvicZmyWsCsw6srPJNZe2rjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(186009)(1800799009)(451199024)(2616005)(26005)(6506007)(6486002)(53546011)(6512007)(31696002)(36756003)(86362001)(38100700002)(83380400001)(5660300002)(478600001)(7416002)(41300700001)(31686004)(66476007)(66556008)(8676002)(66946007)(110136005)(6636002)(8936002)(4326008)(54906003)(6666004)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEhPUDh6bVl2U0FYWjNIdkEwUlNIc0wzQmN1MDc3bHBUaHprLzZ2SVNpbjNV?=
 =?utf-8?B?ajVuZ0NQT0ozNHlJUVd0bGM1V0hyV05mNjFpTnA3ekZQamJwbFlrMjBUSzJs?=
 =?utf-8?B?TW9Yd1gzK1pGcFJKMCtIYk9EN1ovYXk3K1NEZ0djVkRrdFp5S3phYytGZGpJ?=
 =?utf-8?B?UUlFNG1YditkZU5CMTI1eFN5bXpweFA1MDgxbDRrZ0VtY0hTUlZoUkJXZG15?=
 =?utf-8?B?RTJxcWJCMEIzR0JWUXcyNUN6V2JsblpTNnJTY2lsVkRhcHQ4bTNwVmg1S1Vv?=
 =?utf-8?B?c1h3akV6M2hJY1hSaU9oQlN0RWEzdGZXSG1iREwzeXdlVlF0aGxMYlkxOGsw?=
 =?utf-8?B?RUh5YlJPTHVCd3lEaFNnQlZUMnZRUktEMWd3WEdGOEErVWlhVG9oaTlMa3p0?=
 =?utf-8?B?eUtiZ2IvV29GQkdHWndKZmNSRDViS09hZUcwaG42Y0VwNDkwTEZHN3Nkc3B6?=
 =?utf-8?B?SG9ZUHg1WU9VRUFCL21mTlNodk52azRmWS9JeDN1WXI1d2R0R2IvaUtaNTg2?=
 =?utf-8?B?d2pwbGpBRFBLT1BNUldMWENoUzY3c0pnK3Y2c1JwdmxNWUx5SUhMWUR6ZTZG?=
 =?utf-8?B?NmNuVHplbkZTakE5a3RoUzNoR0VCZWhHS2ZFbFAxcDRWd3hjY3BZbk9JVmdq?=
 =?utf-8?B?YWgzbzNFVG1scUIva1ZETEs2eTNpd1h5RHlaQzM5cC9yWlBja054YkVYN1dD?=
 =?utf-8?B?ZnJqR3ptbldmUlFwa2ppakJRd1hLRjYvR0ZMSXU2YVNwbFN0OEVLSmdlMTV1?=
 =?utf-8?B?L0hYNUtJSzgxNDUxOW5oWHBrZkJUOUpxRXFKNDBubnFSUHc3TWc3NndybTJ6?=
 =?utf-8?B?cFNNSHk2STR6MDdweU5ndmhDc2JCL2dSTjlqMjRLdDZJN0RmcXh2SlZWUGx3?=
 =?utf-8?B?aHRDeE5QUndtcTkzVUNOVmNGSVgxZHFDNkpxMmlMMklvUi92dEhsd3lrOGlk?=
 =?utf-8?B?UXFVRkZCR2kyYUw5UlRpbElabXBTQW5lT0NkbWlrRUxBWWtDcUd3QzJDWk5m?=
 =?utf-8?B?WEk4dWdiVnVMWUxvRWwvcmFodTlDeDJ6S2E4WEY4bjF1YjB1dWphekovL05x?=
 =?utf-8?B?VWpnWXBXTXVENGNiSjlqZERJZjNhVlg5L2NRMGJOcVptTnNmQlljeVd4dStN?=
 =?utf-8?B?MXdIZDdSdGhiUGxKVTZZVWtoWmNnRG85YUZ0V21LMDEvbnF2QytHb2hCYVow?=
 =?utf-8?B?WGZMNGJnTFh6cmxxOUR2eEdzSTYrbXhMamdTZ3A5ekVYTDg2Tmo5aHNGZmo5?=
 =?utf-8?B?OVpxeDhjWFpPdVhVcldHSDVzcWpUSlNoYjg4OFdLQkNVaDMwa1Y0RGVwcUpU?=
 =?utf-8?B?Wnh3Sno5MFllQVY3dFBpNFlWd3NlQlY4V2FCU3VZYnkyVjI2QWFsWDJEcHox?=
 =?utf-8?B?NzBUaUQ5cTJKdWNPL3hBUG9QNzZiM1huZ1RBbkd3UURRZDBIWUVoaG1mQ0ht?=
 =?utf-8?B?S09oWlRrYkczdzU1RFFaWWtTOWtTZWd5TUNnekI3bXdsaTJXNGV2aFVSc1J4?=
 =?utf-8?B?WStsMU40L1pHbzRyZVBBSUhBM045MkdQTlM1Q2hWUHdHUEhGaDc3bmdxcXNS?=
 =?utf-8?B?SUNCTnRhSVJody9sN0RpMm1jS1ZUUkI5Q0VJZGE5cG1Gb1BNaGJJQTFyUFRq?=
 =?utf-8?B?Uk5zSTREbGJXaFdyTDA4M1NTQXJjQm5OQUlPZ2QxTHlJRUFlRC9ZOGJnRVcv?=
 =?utf-8?B?TlZSbjRjLzlwQXNCOXpUbDFOMzZTR1krZW4zRlFCY0t0ZHNoV1BWa2ptUUFn?=
 =?utf-8?B?MWZIcElQTXFveHVNVFRIckpzdU9TdXM1bXRHT1ZLRkU1ckhXQ3ZYQTZrOU5i?=
 =?utf-8?B?N2VNZ0tjQzNPVllFTlZLeS9SSzB3MjZhV01acXFjMUFJR3hLK3cxRjhxQVFI?=
 =?utf-8?B?MjhaM2ZiaWxEYjZBcnhLdWFXZlFvTUY0eU56bzlXdzM1Sld0d2xZYkllV3ZD?=
 =?utf-8?B?YmFRZWQrb1RJV25ubjNSUXFjZkZTTGNPWERVK1Zjbks3bWpQdWFxSDJKMGVD?=
 =?utf-8?B?eXpXZFV4YU04VjFseWJmcHMydVlOc2JscTFKY0lYeXY1YXJaelJrOE9RdVlC?=
 =?utf-8?B?S0IvejlJVzJ4a1VFclo1akx1NjFEQUFKcXpCUE1KOTdHRkQ3TWtIeWZZL1Yw?=
 =?utf-8?B?RVdQRHpWb20wMlpwYkg0Y2J1S2JUclJ3VHdRTGFmNUVPTTVMNitWOEhNWTFz?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aWJtTzlHaUQ5b2ZhZGFKUUY4cEk1LytoRnA1QjNSRTR3WkovZmRKa2hpMTJV?=
 =?utf-8?B?TExMT1pXTGwxQWh4RkkvbE1RMU53dWw5WnJ3M3U2Q0lkT1JRZ05DWWx2b0N0?=
 =?utf-8?B?d0ltVUIxdWF0UjBESE1SdU9zVWZCMUhPQ2djQisvWC9aak5Ma3IyMFZkMnkw?=
 =?utf-8?B?ZEFaU3piUkpnT2tVVGIwMmw4S21uOGsxN05yRzlCTmlKSkRLeTFranc3dlBB?=
 =?utf-8?B?QWhUT0g5ZlV5NEdTMmxxMFN4a0ZwNTZDR2tjMW5ja3FhVjBtOE12VzhYd0VO?=
 =?utf-8?B?OWk5WFMwdWNYQjdHdThOclhVL1U2QXlMLzJydWRNWnBvRUtFTWJvSnZ2dFNP?=
 =?utf-8?B?dGc5dllJWDhXRnUxNzhGWlladVljQW5HTjdJWjZNV21VU2xOa0lRQWhBVmJ0?=
 =?utf-8?B?S2pKZmg0eHhwc1pMNWUxUlpQeXRSQ2ovYjlWL1h2cjJSeUkxcFNOZFYxMS9B?=
 =?utf-8?B?Z0xOaTVzaGJWTUNwMVRyVHpDR2xQWWprOUFUSlp5U0tQNEtoL3Q5UXdhcSt0?=
 =?utf-8?B?eEJ5a0JtamxPZklaVUNYSitacDJUTEFWWmxTa0taR2hvNjRZUUtTQ00vcElD?=
 =?utf-8?B?ZHJYZ3VXSWg3SXFlWWxUd3Rsaks4eUljUi9MVWZIQkRpd0t5K1k3bEVqOWYr?=
 =?utf-8?B?b05MTnE2TFdEeGdVL2hENC9GRkttWFdQWXpLZzJFMGNMZnQvVHNzbVdWTVlZ?=
 =?utf-8?B?Yy9rdCtvRnhVaThyWWx2ZXVVRXVIaXZrMERBVGVCZ1J4WFF1QjZGVzR4T0gw?=
 =?utf-8?B?L0hCQkNsQzZFOUY0OGpUcUR2Q3lxa1BaZmRhTm91NnVHczVGOFRZaHZneCtp?=
 =?utf-8?B?WHpqL3RjSnFZQXBsSnR0SkJvclorNEEwL1hoOEZCUXg0VzgrYmZrdWJJc2R0?=
 =?utf-8?B?aFhORHJnRFN3UXZVaXdHMlEyb1hEZTEvSVJmL1RqUE8yUlE1S2ZXZjlzUlFC?=
 =?utf-8?B?MlVWV1hTOER6eTcyWllvWk5ua3ZjbnpYaG9PTldlSXNiWkNNeHZ0dmVwRjh4?=
 =?utf-8?B?UFFEaEZUQjlseENkcGNyd0Z6eDBHOUlYa1NrTkNLSGZWdWdIWXFiQkRLbGlp?=
 =?utf-8?B?djRQTlluTnp5cVk1dFFLNmFJSVdsNSs2QmUvcWRwSm1OMWx2TFJvdmFOUW1K?=
 =?utf-8?B?QUR6ME1ScWIvUHhRT0QwUTFUa0lqeVZ4dzl0TkFCbVlMTG45aTJJOSsxS2Fk?=
 =?utf-8?B?S1NRUm5NeWpyUlUxNEtRSS9jUy9NeWtwOVAzU2EzMm15TWtCcUVmLzgvb212?=
 =?utf-8?B?R21kUWk4OXNWRHdkYW84MmU2LzQ5VXNYanhDelRxQUR3cElDS2d0aWF6Wk4v?=
 =?utf-8?B?aXpjSk14NmNZYTBVTTBycXAxeUE2YitMWHVmdVNGTDUrY2NRVkV6NCtHeEpI?=
 =?utf-8?B?RC81MS9meGRyQWIxZlV1MFNFNXBZZk9JaEFGOEtNZUk2NVRxWi85ZGhBYXdU?=
 =?utf-8?B?VkQzcDZOR0c3VkVsTzNZMXdaNDAxaVRQeEFtYlBIM2pKVGR3MVhndjI5N1BJ?=
 =?utf-8?Q?pLZMvb9dJsiN1iUfw+A2hbSGvXp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e933bff-d750-4a1f-3d21-08dbb8ea336f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:27:03.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6Eqz0JwyLfSyjyKCUJoFNbU6OauEgOHzYYX482rosQJLjPq2eDkJklI/AjHzOTQNQkDLLEM45lQNeZBio12gWqHfamCWIz/yvsDzE7pFRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190070
X-Proofpoint-GUID: Jw1PMmaeKrcuaBrpJIEfyYlT4077gE26
X-Proofpoint-ORIG-GUID: Jw1PMmaeKrcuaBrpJIEfyYlT4077gE26
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 07:42, Muchun Song wrote:
> On 2023/9/19 07:01, Mike Kravetz wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>> belonging to a range of pages in order to perform only 1 (global) TLB
>> flush.
>>
>> Add a flags field to the walker and pass whether it's a bulk allocation
>> or just a single page to decide to remap. First value
>> (VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
>> flush when we split the PMD.
>>
>> Rebased and updated by Mike Kravetz
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 75 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index 147ed15bcae4..e8bc2f7567db 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -27,6 +27,7 @@
>>    * @reuse_addr:        the virtual address of the @reuse_page page.
>>    * @vmemmap_pages:    the list head of the vmemmap pages that can be freed
>>    *            or is mapped from.
>> + * @flags:        used to modify behavior in bulk operations
> 
> Better to describe it as "used to modify behavior in vmemmap page table walking
> operations"
> 
OK

>>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
>> *folio_list)
>>   {
>>       struct folio *folio;
>>       LIST_HEAD(vmemmap_pages);
>>   +    list_for_each_entry(folio, folio_list, lru)
>> +        hugetlb_vmemmap_split(h, &folio->page);
>> +
>> +    flush_tlb_all();
>> +
>>       list_for_each_entry(folio, folio_list, lru) {
>>           int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>>                                   &vmemmap_pages);
> 
> This is unlikely to be failed since the page table allocation
> is moved to the above 

> (Note that the head vmemmap page allocation
> is not mandatory). 

Good point that I almost forgot

> So we should handle the error case in the above
> splitting operation.

But back to the previous discussion in v2... the thinking was that /some/ PMDs
got split, and say could allow some PTE remapping to occur and free some pages
back (each page allows 6 more splits worst case). Then the next
__hugetlb_vmemmap_optimize() will have to split PMD pages again for those
hugepages that failed the batch PMD split (as we only defer the PTE remap tlb
flush in this stage).

Unless this isn't something worth handling

	Joao
