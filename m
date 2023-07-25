Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC7D760CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjGYIVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGYIVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:21:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB9E5C;
        Tue, 25 Jul 2023 01:21:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oU2n008377;
        Tue, 25 Jul 2023 08:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=RK/W3Sl5LYf11baQrHp8hJUc6Cnbe001ciLL/q8oKW8=;
 b=XAFo/DW8zESIu/fK3tmTbm1IN/LqrEcfRY0tlmL2Mm4EGqMxOkglOCoISCXXnDclkG37
 yfXwzY/A7Ac3qWYzhM1lijLF/0jo6Mk0mmA7XRoHAT6RIF3eEEvVpIv/b8c3V01OUGgD
 HO2ejRB704AkNnpLbnJFjuzzaAtMBYBiSrxn/ChQeAf4v95Jy3tpsr8wiMwnM+iWEcF2
 4rLIB370wsCGXMnjcdQ6mL8AcoiSGsja4FQ0pn9vj/LVoCov3/pd0C8z6f4HxA40p3vN
 Z8CdyBEdKr3V7ddfYb0UIfW7bV+QL9xh/DZ5JEQgqarvyOXOxsfl4n2L5Qlvlj1pWF1f LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d4j8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 08:20:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7S8A3035392;
        Tue, 25 Jul 2023 08:20:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4ew55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 08:20:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeKm7qbCxe66qj6K7E6o8ZvTJ5Qd6D2C0YhHz2UyOGAAgS7w4/rHzFmjQCMbjXKswfhCJ4V0FT4hrDGirR6vh/iKSy1wedLRTn9Pg2SJcyhRUO3ekwxLvTlPt0N86mkYaht6PqkzbM6we6yiOfhKETOMOX4zHUpJec7SP+xScp9dFpv15qpqKZQ1AKBW6lUNu/Jkl5XReM6KDwLJsNgEzo94gfD+Cgyt2apdxnYaTdkLKimhYdtc2hNOvpSVQ3smhTukPgU/csgSj0Ts2gtFE3qFd/4Ub9t/yPrOpZLX3kQ00XhuNvOqVIMSb3f4j4E13gve3y4wezjXtHqDJS55DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK/W3Sl5LYf11baQrHp8hJUc6Cnbe001ciLL/q8oKW8=;
 b=edV7fVHDXutI1Uam0IDgp58Ox+Ze3vT1mbnV8Bd10nyYqT7PuKgRX7c5TCc2gTiBgPr2+rTeyU+ur8tfnZbivbP8BwZnFNxUeN+10S49jmP27NdNobWnveh9NlY52lNVog68WfthOk6EXaJgd2/1dwUAIH6bRy0PATs2obR8nzJoCR78ivo+nzkHmozbYqSLOwXwiHRnMg0heXfA1cDkIS1D0ciAI81HrtNL0/deKIoQ5BEVGaJOcHNvK0GRtgIXiZYRunrWsZGGEUkCugxKllcIx3z6IqUcqDhtMlJZNcGY1Gt0R48kdOky4+O3T6RzF1J42kb03QuyQvZpqPOD8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK/W3Sl5LYf11baQrHp8hJUc6Cnbe001ciLL/q8oKW8=;
 b=NVIMSGNwY+UsIpJM/UwaIF+Bqf2morwu/Io/FKo3BCNj8tX7qat2zONL7BNuD3STUIMZWR2pLTv8a4qFHK4bGiaCMjYfFsQu8wK/M/rS1gy9FaAR6Eghl8iJR2eay5N5pWMqtHwexgYsODnCe6l6rFCESws5WaIrvqtlY/JhYOs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:20:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 08:20:36 +0000
Message-ID: <4c20d8fd-b478-5b0a-0558-3b59dead0751@oracle.com>
Date:   Tue, 25 Jul 2023 09:20:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/4] perf metric: Event "Compat" value supports
 matching multiple identifiers
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690100513-61165-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690100513-61165-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0532.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da487d2-2440-4407-29c5-08db8ce805b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzggqbT2GG3yY5DPpj/LGphDN1qoX1NcTU3aYgPEs9yvF6RqvFmwE5G++ycl1Q1aAPbAdLXeB/kidBSVm4YS3dQd7KCw9rC/qZuS5r62KgD8xgtrqEbijN6gEIB2xO3FFCd0h2QRbnb/SOnDxNLL5cdHcX4fBevNMfLkaMgIW79Uj5mBtUieGIL+C/p7t4EXaW3mON3TqAllGWm2D7BWrZJv/YeqLLClJ9YM10zsKIfcsUjYSTb2qWFfRvBxPorP+WSeXp7DaH8iaxG7rcvXkSVVkrSvqXRlikGdbcOdrnDHylnLuowTyaUduredY90LhJG25M/8Ohhu7yBrScKFBuWAmGudqBHovOMhpLqapjsWfvx+JihjeDWpH2yakW9qz8lx83/PhoH/40qroAv09rjcA+coLcU65DJUmUNBNahyT7bPv9W92RG/u9hwChjppLUmi2g6TWjC6fRacBQaN7QPmRmnbEgsEOXjpX+sBGAVEovaTOctFucyEIyKCgo9to1to/FQbot1ZzQSzc32jx8vREgams8RJLYkde8JFGtXYNcLlnCL0uvVGFPJ7GscuSqAw4nwYZiRP7mUd6QKy5D25zlUqtAMsamIbpOGtwSJtnsWqn3OArmVn2wnchJEChxg0zjYX/Y9oH2/BmCZUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(31686004)(186003)(6506007)(26005)(2906002)(86362001)(31696002)(7416002)(36756003)(8936002)(8676002)(478600001)(54906003)(110136005)(6512007)(6486002)(6666004)(36916002)(38100700002)(4326008)(41300700001)(5660300002)(316002)(66556008)(66476007)(66946007)(53546011)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkRrWjdUNmpjcTR2OE51V1NQMDUxRjRkVXROdGhqekRDVkl5ZmkrVGxWdFlE?=
 =?utf-8?B?Z2F2V0lIWkphZ0Rud2dTT0ViS1BmYlZMOFJWVStwem1ieDFCYWhpb3RRYVc5?=
 =?utf-8?B?bmhaTnV5REZrWnoxMHZLamp6S2RnS1h1YVIweE1jRzRVcGJZdnV5Wmc2ZzhU?=
 =?utf-8?B?dkFRR2ZqN1dQYnVvSFVqL1lBVENSYmxpVFFpSFVzbkpWNS9QSDlYTlZYKzJF?=
 =?utf-8?B?clBNbzNCd0IwREg3SjZHWDRSbFhMTXQ5ZE9UTlp6UjZrbzNzZzQ1NnJkTWRi?=
 =?utf-8?B?SDRBajNpbXVneGkva3FQSG1jWmFaK0QyZnkwZHlCaVRKb2NsV0NPNkphWFVx?=
 =?utf-8?B?L2JzQmVoK0cyOTJWTXAydVlLdjROMlVkK0gwdXhMYkVrZ05jZHdOTFV4Y2dh?=
 =?utf-8?B?QnJFdmg0NmJKL3AvZVFjTTRyd01DR3NOM2xFQnMzNG1DL09hRTNVSTBzb1pp?=
 =?utf-8?B?N2dnVVRSWWM1ZVVKc3h4aGlFTS9TRHFNVXdvQURCS0NvQ2Rad0wyeW1UOVQw?=
 =?utf-8?B?ZGhUUURKeWRxc2ovY1R1QVFRNGVyS0VIMXdPZ09SaVJoWmdGcWwvVktETm5F?=
 =?utf-8?B?T1FJZ1RmRDN3VUZMekVVckZzN0sxZTNpaEdMbi8rcXlSSkEvRk16aG9UZlB1?=
 =?utf-8?B?TXQrU05lSEI0VURmd2dxSWNNbzRMdzQyRG1xOVdES0VPWUlXMHpua2NXN01U?=
 =?utf-8?B?MlR0WjRiSzJxTGdMYjhPZGNaSUZwcDBHKzdxVmJBWVRrWndaeGNWSVBSWFNL?=
 =?utf-8?B?czZUUDl3T0pkN2YyMFRoN1YreE8rNVNVeUo5NmpPQ2E1bTBRUkZZcWk4VmQ4?=
 =?utf-8?B?UzFpcjhsY1pJcmY1RVc3VjYxTXBKUkFMc3NTTmdvZi9XZzJmd0FoTVpsNThZ?=
 =?utf-8?B?SEhNNDdKKytRMkR2WjBFSWNPWXZVd1BhMjQycmI2MGtPSXl3V3NPc0RyWmd3?=
 =?utf-8?B?VXJzU1hiQVYwazFGb1lOLzRBN3JtL1JmQzA5dEsrYm9Gekg4ZFN1Qml3aVZl?=
 =?utf-8?B?WGhDODhSRTZrOEpWRVN5TWU4ZWZxa0hHYzhnSzgxdXd0L1l5MEs5Um0zUkZC?=
 =?utf-8?B?MFY5QTh0OWZKT2l6MlRxdW1WNlNwTnJKTTZ4eUFKS0ZSTERKV3kvS3ZVSk90?=
 =?utf-8?B?eHlXRE52Ris4dENxbWRyMy9CNlNTaVJRUnVGZGdXZ25SKzVLSno2U1ZmMzQ2?=
 =?utf-8?B?ZjlBTGdjQXp4dEZhVTlXY29GN1JkckpXKy9xTEZzZFlZYTEvdmJaRVBBaGdK?=
 =?utf-8?B?WkRFdjU4MU1DazRGTXc0YUdTNmlhekhDTldBQlVoSTlyVXVDZGZWUlliMncw?=
 =?utf-8?B?YW5rWkF2djkxd0JpRDFQOE8wZHVVVXdVVzFCb0ZJa2lDYmxLYW9uYmlkeUxQ?=
 =?utf-8?B?WHBvaEZqWEk5OHRjZjJIZ2xCWWxpazRicVRabnNzRm1xT0p5YkpBalI2c05M?=
 =?utf-8?B?RWIxZmRSQ0NrMTN1dk13SnYra2Ewb2dZK3dqRmVHMGxrdnBZaVlpd2pVanpP?=
 =?utf-8?B?MW5GY0lDdmFSZEc2YjNjdUJRZy82SEpIN05MWTZpVmprUE5Rdi84cTF5YzVW?=
 =?utf-8?B?V1RndFlhS1BucU91WUlVOFJ5UnB4bVJqU0tXOHBldy9pZjVyM0JHcjBmWUFL?=
 =?utf-8?B?RzFVMUxoOHFQazZtdVcwVXIwOWNuQXIwOHowaS9HTm9Wa3pYcWlXQVFnMHNi?=
 =?utf-8?B?eEphNHByS0RjOEE3bWJaV2ZYalZDNEFaS0liYzg4cTdubTNuYjRMeG9OMTZy?=
 =?utf-8?B?RGw5R0c4empDYjBQZXlFWXcyTGlhWHEwbE5mVTZqcEdhNVFkUHZlSHh6YVVJ?=
 =?utf-8?B?UjZvNW5TZ1k3c0Y2dzJmVHdUQjVNWHEyaWZDdTBnZWF0MmNzbTY3cmlLcitl?=
 =?utf-8?B?M3RKZnpMOXlFVzhwS3NVUjN3cGwvdkpZTERrakM5V2ZDb2NGb2tubkhvTVFv?=
 =?utf-8?B?aWdacFc5UGVwYjJ1bGNMRkhMSkhDM2UyQ0tHdWNLVkNJK2NaY1lTVW9MMXlt?=
 =?utf-8?B?VG1hcXlsSnRBY3JIbndYVHBDRDFDbkVibnIxbWI2TEg4MWQ2cVBaRjJ4eTBS?=
 =?utf-8?B?U2tzRC9jcTh1VVBjc0p4K0xCaDI5VDhGd2M0QXNaOUtyU3ZtOXYwRkViRFdU?=
 =?utf-8?Q?RtZixTAXaD4NkGLzhld2oj6NE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Wkl5TG44YVNaRzNMVW9lSWFlL3pFSnFVU0tDNVFQZVFrbzlWTVU1Yk81WE4z?=
 =?utf-8?B?TDRVamIwMnF4Q1BKSURaSFBjTWhwODlOaXV2L1dDc01YZTFON1JGZElTblVt?=
 =?utf-8?B?R3J6Yk9kUERzaUYrWk51VTE4TUV6OExHYnIwNjNvN2tMRlNILy9PUUdUQmRu?=
 =?utf-8?B?blNXclNVc3hJSUtBTGI3WXUrVDRoUGVOOHo5VWc3UDVOZmdmckQySzBXckZZ?=
 =?utf-8?B?SWh6RG44NmIvRllQVFNXLytPbE84L2M1TnhKNmpveW0rd0lzWk5XQ1diL2JR?=
 =?utf-8?B?VWlSU0dEbE5vWGJzVXFFK1JLK1BtV3AzRWo1cksrMjRqd1krMmdLQTB0NXcw?=
 =?utf-8?B?eVN1eEVEZmtRUnY5QmgxQVU4Y0cvT2hPTi9GZ2hVclFXNkxyK0xmclp2WGd3?=
 =?utf-8?B?OWtrZ2NzbXBQQU91bkp1MTF6UGVzNlRMVnZiOGJMWEduTTVEZ1lEeDdhSFF6?=
 =?utf-8?B?ZkpiZHFOcVQ1dXhWaXkxTlN0eFJLNjVMLy9udG5seTVXdFFyd05pbUZKR2F4?=
 =?utf-8?B?UG5OYjNZVG5BSEVGNkpJV3A0QWFZeHhZcGZKNytuc2RNYk5JZGc0cU9GMU9z?=
 =?utf-8?B?Rk9kenVqWGFPRjJ2bW5OeDJ0aVJWdmNuNXZHd0lKenJUV2VRanBkZlhGMnV4?=
 =?utf-8?B?T3BPY3orZjl3TFFkNVhPY0tKT1locUk1dDVKbXdkZko1Uk1IdVRCcVFQNFly?=
 =?utf-8?B?ai9SWlk1TEpQZjJJRHU0VkorVmJ6VWY3dEFOV1RCR3FNREIrQ0RmUXFCcVhK?=
 =?utf-8?B?R2VwMnlrR3JmYUp3c2FYUmNYQ21RZHR4VmZVcmRWcGh2VzBnWFE1djlZOFZQ?=
 =?utf-8?B?ZTg3clZ4dlMyY2NTdE9JYmd3YTI2OCs0UDdEY2dGUmVySHR1QmJEcTZQbkR5?=
 =?utf-8?B?eitDZ0t4K24rOUh2RHovNlUrWDN2KzRWNVdQYXU1M1VlOXFnUzJZWWhLSlZl?=
 =?utf-8?B?RVhDL0RwSmcvc2xGdDlqWWs4WjVtRFI1eUZIWFVGZUFLbDBnaGtYbXExOWsw?=
 =?utf-8?B?UGgrM2xqalhIbmRwSHhWMkVVM3cxZkNBMzJrSFNlaitYbWt1T3BFR2VFTjlv?=
 =?utf-8?B?VWtPQ2t2ZDArbEV3QjNlZUtrMFgzZXRHU21WUTdTVGVjREIzbnA2ZUw1dGc1?=
 =?utf-8?B?Zzh1QjJUdzBGMFZtNXMyejF3WVpLTUR5WTU3eitmcXJnajN5ZVZabzZhdHNB?=
 =?utf-8?B?S1RzbXpOZGlJZmJ3UkpXN016NzlVOTdwWFBib25mSGJxRjJudHR1bEh1OHU4?=
 =?utf-8?B?MEtJZGZYS2ZUQTBuWDNXQWExMGxFVGFhK3pnZGhjeTczU3dDbmtVcjMwM2Jr?=
 =?utf-8?B?Y2M1SkZJZzdaQXZDWWsvanBDTnBGSzZLeFZUMzBYVVZUMWtZLyt4Ni9lSWFh?=
 =?utf-8?B?TmZYdG5iNmdHaHlscnRFZE0wTktpc1J2U2dZQlVGdW04RGRtb0tHZHhiVnlj?=
 =?utf-8?B?VkpPcVpXUCtwMDJGaWF5NVpCRWV6NHVwbmVndEVqNXNIQVhHcGVoOFBKV1R2?=
 =?utf-8?Q?xvexXg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da487d2-2440-4407-29c5-08db8ce805b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:20:36.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3S+t5IDN+p+wcei5Zjr09HIKNc+QdLnn2oBmgzL6s8mf770enF2WIhv++RI7Ao4e9EwjTPYC9eudGcKMNymrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250073
X-Proofpoint-ORIG-GUID: _2Kawaw3ojXwn1tiPFbBtu6OI-kCqVL8
X-Proofpoint-GUID: _2Kawaw3ojXwn1tiPFbBtu6OI-kCqVL8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2023 09:21, Jing Zhang wrote:
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
> 
> The same PMU driver has different PMU identifiers due to different hardware
> versions and types, but they may have some common PMU event/metric. Since a
> Compat value can only match one identifier, when adding the same event
> alias and metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
> 
> So let "Compat" value supports matching multiple identifiers. For example,
> the Compat value {abcde;123*} can match the PMU identifier "abcde" and the
> the PMU identifier with the prefix "123", where "*" is a wildcard.
> Tokens in Unit field are delimited by ';' with no spaces.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   tools/perf/util/metricgroup.c | 27 ++++++++++++++++++++++++++-

Why only support for metrics? Why not support for regular events 
aliases? I would have expected pmu_add_sys_aliases_iter_fn() to have 
been updated for this.

On the basis that we will support regular events aliases, we need perf 
tool self-test cases for this in tools/perf/test/pmu-events.c (I think 
that pmu-events.c would be the most appropriate file)

Thanks,
John

