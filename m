Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0457CEE14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjJSCcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9089B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IInBg9013656;
        Thu, 19 Oct 2023 02:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=qOkbEny/iw4L9gnmc4DHbpV54PxWK9BmenSUQUQNoKo=;
 b=UtxYQkhURkKifd1pGDvOW1xVDemKXOd9kI5oRb7mt0QrFnqFDF2jeCNsQr6btBycpx7z
 Ik3MXHvwLT6zVBBn1Ek2k9oib2sp23ZWtVdCEAkifa/OyzbuC+Ml013OiveTiP7VSF20
 ktc2juTRVX2uMJMKA/HMeT28LJWYRqlY9bIN6ahi2ZYMc8yzWI38VgxFt9fQWEX2GYFW
 I5dC7xtn6ncVyWTxPtGYlNTVULdpo7x5Zb+PNm0tjadQxWpbulYg2maLcNf6yoEwTejr
 kcWm6WkXcfqR2fgPfdeXHn+JL63Np9hvb9FJikYiiYvw0crpu1B8vQeOiR+PGNykxDt2 ZQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1d167t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1C4rs009668;
        Thu, 19 Oct 2023 02:31:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0q30bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkCaw5QQHHsBDZlwh5V2oWtdwK5SyJBXSSdHCQactbsJXEk4naosc4Xh9Ww7pC+aYb1wSQOuKVdo8pJ/UOTbm3p3GYP2yz9IVMME0YPPPHi3DbxcXhheSzc+CTgqI4MqT7sFGqPPjA3W623ngyAEaJzhYuzcH8iX7jOI9AxelE8ZPG9ZDyjK0KlzVE+qs8X8BQirkWH5NTFl8im0BwXIQiCWswqFQpnLYQV5FLBJriqqP/7ND/FjtY3kOAGGAongdI57y6rOhJaH2bya/q9hNKBzSY0sYGlYvnsHqIWZECCgsYKdIxqs5Poydt6RRmsfWPbpEl+ptOs4WydPm1XrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOkbEny/iw4L9gnmc4DHbpV54PxWK9BmenSUQUQNoKo=;
 b=Dkbpydj9SYWGODaJMr2iId3qy8ak8LfVFkn6YG6VJSdECRrMGQWpj6WgB3hduEO8BpAMACW5Aubb1hV1VcsDZSR5ybULcC503DspFmjW6uvYkC8zHvZlXeDUFBUz+mmzCnZZ451lXo+Pmdm6GkMACDMCkoWU5biHqAnH4F/7otEr2f5CzuNOpsihPuUuH1kpsx+BHcElT/GrTysGzZ+Yg42wBSzY3lecQc7Xavo01tMCGdOJ6dewQkwh7je1cGtUAuK+Ls0pyjpLN3AIdrqXbbICt1wGTBJ4sqyST5ZOlv1ADTsYVFvYqOxCYRBi36/OyPvzpomkH9obJDFawPuJxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOkbEny/iw4L9gnmc4DHbpV54PxWK9BmenSUQUQNoKo=;
 b=iailQI9ru+kWH6iTrozO/kX201lDmmkF3bV+l3X3a1gqQfI7kcGXKgL5yA0Bd3MgqBupjTReXRuw9RVAwfXfEqE5x8X1bkDz529OsVil+5NWvNngFS4kXURxWSBDzCLxiYJlrEGkL963kHScMmWONmM5BLl75R2wGF0da39JUto=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:17 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 0/8] Batch hugetlb vmemmap modification operations
Date:   Wed, 18 Oct 2023 19:31:02 -0700
Message-ID: <20231019023113.345257-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: ce87bbd8-aee7-4633-2e88-08dbd04b7918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6eFSPZCDC1ztunzJ6+BxGIRTO3vLJrio+XUMOMHxRZums1lfW/+LulgqaypUv7WwWPBYmnvmKiNsAmGIHOy9ODflo25/e8w46eEV5IAmhH6ysFsbMkZ3Wr9A5rkShAimQlhoMp5C8e9H4D5x4loeGUptiGNa4tXSJKCNokyu4mid8YxU1Y7jvjwkh5oRMfpkZxRLOciyeRjsXgh/4arsRSRUnDmrZRGHposbMFVoHEjfP+sXDTYkv3JGFuhInOxRRJpqofpgB+B6yY+xzBHS7R4JltOKqgPSl41ayq6+ror/YYi+2E5WABSa243/bIiu3rVgsiq5AgnegwClnXNhUgyBPHfGwmwmKD9kxIHrHDZrZWAZhiF4st42HAc3dS810H1ERnrCmiyB76CmjWLosZLkG5buvJ5Waiyzen3WQILnUtVLt1Tm1i4bGdgH1IRFg/ekkutfLf/Id8QYG8TbAcafc2k+dDfgqHldEWt1Xw/cJCNkh7hsqs/kB+VdKSsuruY8yyd72EYEbREQ9Mn1FiQmibyodNPVPOAelDrz3Dwtk6U7+2Lhw5tx/MOAbmi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blU2TmtRamJtTi9ici9SWm82Q0NxelYxcktqYlo3TEx2ZEJZek9saGJ0MVNo?=
 =?utf-8?B?dm5jaFNHNU8xMFo5VUtrNzJ5aUtrYUJXRWRZK1lnNzlPL2FpYVEyYklzcEF3?=
 =?utf-8?B?aVlYNnBZVEpqRWZBdUtycTRwdk1mVDliYVNUQWZhUVZIVks4aE04dUNBLzJS?=
 =?utf-8?B?ZVVXTzh4NHg1aU9TMklQR0J0K2U3d09uWlBIWFc5KzRuem5OR3J6bkx4Tlpy?=
 =?utf-8?B?V1BnYWp2WUsvSmUxam0zMDdRVDRJOEEvdUZPZitqRXZRMlprMkdoZ0Rqd0pz?=
 =?utf-8?B?cVJ4OXVzSXFvQ1lBUm82cU9qakQvVVovZ1RUa0htSnhIbW16UDFQN2tSbXlx?=
 =?utf-8?B?SjhaNmxQSDZYRjY3bUFSeGJvR1AwT29NVHd2cWxpS1hQdHNnT1dMYTJ5RTlo?=
 =?utf-8?B?cFBqeFk3dTZHRVJOSGN4cHV6cmp0VUtoZkVGWjBCbm8reG0yRS9WYlZqYTBK?=
 =?utf-8?B?VWhtL0hwVm80dXprT09Rb1ZZSXE3RTNIK0ZvSHRKTk1VNDBtTml1UHhTcEha?=
 =?utf-8?B?eEZDSktLNlhyTks0TUpFdUFieTZPK1RRcUV4UVB2d0ZUZi9mNzYrZHpJUGxE?=
 =?utf-8?B?U1M1RG9BQ3EzelViVjFaaUlMcnhxd0pUbWNqK2pWekV4VTQxcDV1c1phNS9J?=
 =?utf-8?B?dWtUaWdIY1dJTGJoeWpMd29hbWQyNjl2NGNyZFdJc2JJRDN4bVhJa0tKcFlr?=
 =?utf-8?B?bVhFS3RuWko3SDMyL1QxYTJPcVJqQW91NUtyblpzcnpFOWs3UE82VjR1SFFO?=
 =?utf-8?B?bHQvbmE1Y0lvWlE5VE1LaHN0aGxuYzNwWVlIMjB2UnZxTnk4dEpmMmJEYkRP?=
 =?utf-8?B?ZnR5OXZiK1FwQlFCL1ZmNFNHajVKRFNKUmhpNi9tQVA0WXQ3SE9jS1FlMS9I?=
 =?utf-8?B?UVQ3UHorOERJVEVNOFpleDQ4L2lXc25Mb1BCcTZjc1B0MXcrOVFRZHlnV3A1?=
 =?utf-8?B?dFRjM2paaXNJeWd3OWZZMUwwaHliSzJHNDhjQmkvS2FaU3YvdnBkTUJPNkdy?=
 =?utf-8?B?YVk3V3BNa1pROCtQcm5MQ3VldGo3cVVzaEFwY1p5WER5Mzd4dnF1bGlkTnlt?=
 =?utf-8?B?NjJHZVRsNjh3dnhFbUk2bjgwdGxGTDZadTdURkZaVnh0dlQxekV5czJ4aXVD?=
 =?utf-8?B?cnlab1dxL0Fmc0VEdDF6WXFHdzZRRXVyRlBaM3lPcERlUWNQWFNGTSs0QVEw?=
 =?utf-8?B?QUJNcnd0S3d6cEkzOVQ1TzlCcGVIZDRtOTNqeEw1ZzFEN0w0eTN4ODZwOU5B?=
 =?utf-8?B?UEJERHBqLy9ZSi9sV1VTQ0Jjcmd6aG9lc3piWmtXZXRZNm5nSkYrZC9iNkhx?=
 =?utf-8?B?UVlQc3F3SDRNWU5DOUJEUFZoS3NOVTBRUkt5MnlXNmN3V2NPYjY4UlpZU0hu?=
 =?utf-8?B?M2RQMFN0ZHFHNi9Lek5iYno3UWV1Z01pMFkvejErUFFma0JtRWhhUVB0ZWFX?=
 =?utf-8?B?RUVNa0FkZW9DcW5nNGdpbDBSTXhER1E2UGxTZDJSaU1ZZzcvVGRiajZNQlUx?=
 =?utf-8?B?bEdEeTMyKzZNUnMrQXdTamUrODZvS1JtckZKbHVhUXJzdGFIYWVnOGEvOHNi?=
 =?utf-8?B?NEM1K2FMUkdnUDFSN1J3UUdDVHBkZGlEckhPMHBpMi9XSERaNnljcENucFEy?=
 =?utf-8?B?NnlUWEJMdDRuVWpBWis2UEd1SFV4a2dLUkFRL1ZMWmZSSVFydEN1cVdEWHRv?=
 =?utf-8?B?NTFUbjZ4Wnl0RDFaOUp3ejhNZ0V6eC9tTVdNL0dnNDZvYklnWmN6enhrSTFY?=
 =?utf-8?B?SHl4czNTK2F0TEFFR3hiREsyZS9oWGJhN1V6Kzg5V1k4SGdlOEViVThicE90?=
 =?utf-8?B?ZTM1WkpDNmpjckhPa1l0QnZqemdFSDJRZ3lNdTZISFhmVmhiamZvdm9BKzlp?=
 =?utf-8?B?ZjVscmZnaHVSMGpHeHpOVGZKOGpka1owNUp5UGhkNElBeVArTkUrZ2dmTXJp?=
 =?utf-8?B?ZmJXMnBzcmQ5L08wK0tlMndoUUlndGR6a09YSG5oai9jblJ0Y0szdzJQK1JL?=
 =?utf-8?B?dUwrLytMYjJkNzVMK2J1Z2x1QTRpNUhWNnNKdDg2ZUZ5dnlmLzd6cXlKTklD?=
 =?utf-8?B?QmpvZVFzYlczZldZbVhZUDZnSXd3VkdnS1hvb2dFaHVOQ0RZempOZjZhWmtl?=
 =?utf-8?B?UTlhZzVZSlljdHE1VjBWaHltMXVscGsyTXdwRzY3ZlVHTDl5NThieTMzYThT?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEFLTWRHQm5mcnlFSDR5aXZ0a2k1TFhuem15QWwrZmIyTmhLMGQ1ZWNyZ0c1?=
 =?utf-8?B?QXN6MmVFSk5DTnNVTVJSeE8vZG96S01HVnNPSFhyVkJ1amVLRmF6dVMweUdz?=
 =?utf-8?B?MURpeWZEc1Znb0M1U3VsMnV4NnNFVnhBL09MSmpIbE9LYzE0WEJ6d044R25Y?=
 =?utf-8?B?RWNJVVpIOHQyTHRqOWUra2Z4SnU4dFhJSlB6YTEzN2syNHFZbDVSMFJvYWor?=
 =?utf-8?B?Z2w2dlpBdDVEcHJueWYxMDFmNjgwWmNrTjcvSHhOY2QycmY3dlRneUE4WnRX?=
 =?utf-8?B?NU1JaDJIVFFtMWZhRkhud2pXcU5HOXRJQ2VDV3Mrci9yeVhWYkdEaFFTbnR6?=
 =?utf-8?B?OGZxVCtLb3ozM0NzVTBCOW1nWnh5Ri92czMyQ0JPWTJHMmNGdklhZnhueFpq?=
 =?utf-8?B?VURqVWxhL3ZLbkZRRUs1WjZISHFsYlM2R0dRWUdDckxhazV5VVcyRmVUNk5i?=
 =?utf-8?B?b01aamxaV281VXFVbzNvbnEzNHh2SEplQ3BJZUlVVnJlZkNoemF1cDhQTnRG?=
 =?utf-8?B?akpqamh1VDVoSStqVVNoNXAwUWd3TG11dEJFNGZla0wwUHZpVWdLNjFsODRW?=
 =?utf-8?B?THpVUiticytmMXpiZzBYbDVRQVRFVVF6a3VjK0VlZ1BuK2h4Ym00SjdUUCtS?=
 =?utf-8?B?L2dOaHhTeU92UXNyS040NWQ4SmdReXJBb0ZjWE5QZVJadDZGdVBGaFp6L3JS?=
 =?utf-8?B?cjMvOFJWZGNwNmdyZURLbTJiSk5EUjRhZ1FRaDhLSEM0cnBuQk8ySHk2VHlq?=
 =?utf-8?B?WGlwc1FKV3ZVRnBvUE1VeldNaGc3aGhYcXpQcVV6TmxEUUJrN3pycGY0UnBB?=
 =?utf-8?B?SmZyV1pSM01wU254aG10Wmp0MVhxYm5LWkxhMDJnSUZveXpPZlFaaXJvZkdD?=
 =?utf-8?B?YUdqM3k0TzVyLzhQR0NFYjNxWEdPTFdpTmZOTjBESmNiUkNtSjNMZStSZzRP?=
 =?utf-8?B?RzgwN0lFb0x2SkZTSEcxRFFDYTRtMDRnTC9xZlcwMzFrME1TdWdQdVExaVZY?=
 =?utf-8?B?YmFmdTJUUHFRZFZObVVTSjA0bm9RdXhtTU9BVnY4ai9WczBGbFpFYUNDOXdW?=
 =?utf-8?B?anlCY3VSNUpmSzZwek5rSDRiU0xLL0VaZnVDNUM1Z3ZyRzVuT3FEdGVNMHRS?=
 =?utf-8?B?aDlheDBHUGpCWFZKSnZVQjlxKzRUUjc1Z3RMa2NaR3RhTkRlczVQTU03Zm9M?=
 =?utf-8?B?dGxkclpLS1h0OW9yMFZNTnNkei9LbkwxVWpmOGF4WHphREFFV1ByRU1OQ05W?=
 =?utf-8?B?b0t0R0g1eU8zL0cwNjNZdVoxUmdWQ1V4SWhTOHhqYjFhR3VWbVJKb3A1bitP?=
 =?utf-8?B?QWV5VXhNRGRVbkRnb2w2VFJ4YTFQMmFmQmNSZWhITkFldm84WSsxL1RITmNQ?=
 =?utf-8?B?eXVvVTlaOUI4Rkx5bG9NcUE5L3I2cnI2RXJnTC9CSHJkN1c1MWNmZ0JXMkkr?=
 =?utf-8?B?eXBIdlF5cG5jK1ZUbGtlbDg4Q2xzcElmM3BtcnZuZzh2V1JGaEUxVXlxeEdT?=
 =?utf-8?B?WVdMYWF6RlVXWDFSZkUyRzFmZEw0SjI3d0xNa0RBcGl3cTNVSkc5amYzNWdT?=
 =?utf-8?Q?sGnj1NHdL+w5Yq76Cx0oTcSJbnS1fwG8e6tWk1bZ694xqz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce87bbd8-aee7-4633-2e88-08dbd04b7918
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:17.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbd5kuvZ+I33nztJSeWC9P61lMrQFWQA+cemkqGbhTHu3fiLvmjgs1UilJLfvdMUvv6QSFVLIsQ7XX2ttWdffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: yK-Cknw7Toika0T0jfalQ7EAGDPtn4MU
X-Proofpoint-ORIG-GUID: yK-Cknw7Toika0T0jfalQ7EAGDPtn4MU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

This series is based on mm-stable (October 18)

Changed v7 -> v8:
- patch 2 initialized h in gather_bootmem_prealloc so clang would not
  cause loop to be executed when entry condition false.
- patch 2 changed locking in prep_and_add_allocated_folios to take into
  account that IRQs may be disabled.
- patch 3 same locking changes for patch 2 above for
  prep_and_add_bootmem_folios
- Removed Muchun RBs from patches although they are much the same

Changes v6 -> v7:
- Fixed hugetlb_vmemmap_restore_folios stub for the
  !CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP case
- Added Muchun RB for patches 4 and 8

Changes v5 -> v6:
- patch 4 in bulk_vmemmap_restore_error remove folio from list before
  calling add_hugetlb_folio.
- Added Muchun RB for patches 2 and 3

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

 mm/hugetlb.c         | 303 ++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 273 ++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  16 +++
 3 files changed, 509 insertions(+), 83 deletions(-)

-- 
2.41.0

