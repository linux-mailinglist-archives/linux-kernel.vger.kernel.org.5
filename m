Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72DE7AC1B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjIWMLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 08:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjIWMLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 08:11:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6119A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 05:10:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38N9fWYI032553;
        Sat, 23 Sep 2023 12:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wfi/WuRNd/pTJqWT2UiQc95nR4Brb8yKTDQysv7VygQ=;
 b=TlO54pW2j9fGzozlk5fyxWU89WtZk/QzSPKA3bxgm6Mr24wCHHEGKvB/eVX1iqoe/KoS
 Buc1zPw1Ir2LbKNQhFNIQUEPcUyeuG3tFhao9qATSkSiDXRzEwddZEcX9ast2YVhXL0J
 jdlrHc28iDl7R6CzgpqBlMdW4csBgqahC7U51rNrUsiXdZjI11eu0bDaTYOiPGjUhnKe
 0+YtIdiR8kJz6EHm1MiRrJKroessGD02roAdMEa3Rtu0HJNfsHpz3EI+hh4ayDljOsG5
 lbxDX5LXqLEbupcmgFJZAjD+5KjJUyFGHv81f8jQ6S1mITYkzUn20B7g2UF3LKgNmljU LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmu90np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Sep 2023 12:10:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38N9Ec3m003253;
        Sat, 23 Sep 2023 12:10:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf2qd8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Sep 2023 12:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvVY+iB2vi0t0Z6j81s6lf7BJ+qB12xMCOwukOdZ2REhqLpbdGtaa55DLUV4i0wOL6g5Ii4przBu0rHcfAZLEokATzuXBbnvhv6dSEjE8GKfIvHL/nv8XCp0/Qxb4qP4zQeItbCthe+V2fziZr34BJf6VMCBN73G8tgQJSpwfcSrauhtgXpiw3PR1obMUhfGlH5VRFVzUuo0+rs7y/X9J+nV2Q7jefVKfNUXv7ixdYSWxTG5fMyh7c/NF9yv8nejMajTIWQIyAyqbeUaWpn7EjigPmHHQfbGvgOsiMZMTyUoiA/w9dJjOhMLAAfXJd8aAtl9HCkSJ1ugJzlbUD5d4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wfi/WuRNd/pTJqWT2UiQc95nR4Brb8yKTDQysv7VygQ=;
 b=lRgr054nus52k1XcZW2Y2yrZ0BGBxKs64fwSE7vLiZQzgMB2cREBYhomViWI5xVmWj+JE3yYUL6BWwHzGinypWhpwDBfamctJmWIe+iPQ2BelU4w4o5jfQWKidtBaZ8WJ3PllMaW5HtgGaPFKxzUaiT96FkxIc/WNf3pFTEknhVPdL+eQYPTjmLrayGBtRkO6DvL25jCz5bHDqbDhTcnifd2d6bs5jy5+Zeic+r0IDCySO+k4r99Yak8pFIxYnV2v7ZCDr1+ylf5h9+jmHJ23uvzMIbjnn023i4OG+7D3JeJvcFc7yDrdqX5KoPE6WQAbUdEma4xd4yVxOY3uBSNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wfi/WuRNd/pTJqWT2UiQc95nR4Brb8yKTDQysv7VygQ=;
 b=ClFfZ8XsdDzDxssEBJmH14eesdXBg3v3qRAtQszVe6F5hqZVCPlaxDDERa/wGVo6+6aV8RZQFSoScsAcOUyJVQmb3SD/YgKp9S+Pi60Q1z75NCCUf4p4V+8DJr01eeZBPup9xjZlVImZxSDqiDs+jt+FUiCu23IDNL9mA3MSojE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 12:10:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Sat, 23 Sep 2023
 12:10:45 +0000
Message-ID: <8515c858-4be8-fbd6-7868-c8bfb5492f83@oracle.com>
Date:   Sat, 23 Sep 2023 07:10:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Crash: add lock to serialize crash hotplug handling
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, vschneid@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230922235446.260966-1-bhe@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230922235446.260966-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0295.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::8) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c882b1f-1394-4f6d-cb17-08dbbc2e1d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eXhuicZ4ERUCUREgd3vItUvGK6/DKBo6pPn+m8y3iYy89WMuRgNctgxUyiCcBqgt60+j6KZHcaV9r6kQDPmSdnos/igqa3CAJcJnfSJyok2XoLKXVkn5rFGPe+SfLbE4yOoyebBVlJmmUClaPrF2cQri6rtWEqPwPJqwCUNoCykc/NYJrzrE15FG59M4nWfHPRcoV7quxWjGfEObeDkFaHvCpfo8QIiIk2plCTWssTvXoqRmI/cse9d3z1wDPLpPDDmf0lzidUxLlS50QratqDWBTp8R+SgPvoKJ65ns+hqT9k7MH9mL0l3ZikdzS5tv2kCgaISNoRKS1Xm+MvhvuqQ6KdznJj4SCaxuDDiWD/sH9gzod/Vs8UsTBQ+IVuJiOANtIxXY2FFNQRAzqiGsEM+hagK7QTQW5ckf+tOML+AzeaSZNo9uOSaI8I7cX8jZLJIrqovSaxofFXvlwPSx7CsYFKxrXOJ5BV5yTifUGutOPMdXnZVK6+WQPOmIOCMF6g6R8gHbGavQVqNX77ohDuFp1Wx1zaX8zOGQbKWRvRG/OrMqGVJcyTP/J9QVBFvWqjTyVK8K71OLkjuL9ledYUZ9hwVJjdWJUHc/lY0z6eb2YbibLFpyomCaV+GE1PejV0+ZoMrzOyDfnC/wzg7NXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(53546011)(8936002)(8676002)(4326008)(31686004)(316002)(5660300002)(478600001)(6666004)(2906002)(2616005)(6486002)(6506007)(66556008)(66476007)(66946007)(6512007)(26005)(41300700001)(83380400001)(107886003)(38100700002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1WSGRCWm9NM3c3UHA5QlZIbkttT2dnY3ZTZ3VlMEF5MUhaMm9mNnBrcFFV?=
 =?utf-8?B?Y0JrK2UwZnlrQ2M3NG5hT3RrMnpERjUva0xNaGdudGJlUW9id0RUNlhrazd6?=
 =?utf-8?B?T0tYMUpYV2lMWlNrTzlYQzJVRHRkeUg2TEdDeE16WU1rQUZyRkFKaXdWcG5S?=
 =?utf-8?B?WTFyeDFPdTJsUjUwWDdZcEZCenVtSnpQRGt5YzlHZS8ySGdLWGJyZmdFclB2?=
 =?utf-8?B?Zm9kOTFnQ2w4SkJTTDBReFo4QmFEMkRSYWRqVU1ZZ3hrakFDT3ZQd3JVWTFT?=
 =?utf-8?B?VUtSRVh6cERlUUgrUjYwTUlJN1dSTVBYcENxRi92dUJoTHdCOXc5R2ZjY1A1?=
 =?utf-8?B?Ry9XTmgzU2FsbFVCQ2RDNUlxRVZuUithRTFmL01pekg1Mk40SUZ0MUZ1VS9F?=
 =?utf-8?B?bFBvLzltSU5hY2ZuZXlmendDWTJ5ZnFNV2QzNEU0bkZJUXhVb1M5ajFRUFRH?=
 =?utf-8?B?bU92VE1nbEZlWE8yell2MVFxTCtDeTZ6NTNISnY3dStobVhWbCtWazNzOFJF?=
 =?utf-8?B?V2dNTWlFTURaSDZLNVAyeEFZZ1QwaTVBalpjdUdxNzE5WXhiM1U1M2hxUVdW?=
 =?utf-8?B?Qmd3NHY0NEpxeVQxd0o3Y3JFMC9RV25NcWs5dHFqM2FQNldwRW1mcmVNQVNv?=
 =?utf-8?B?MVBZMXAyTUo4UG83NHMzWXZLU1NYMUVoK1MrUmJ3RzltZmFnYzY5OUNQbWIx?=
 =?utf-8?B?M2ZGdHJqZWwzWXZPZVhpRW53ZHVRT2hVc3pxTi9tSjlTUDYxbVY3RGdnMVBV?=
 =?utf-8?B?NVVKQSsraXlXaWVDV1Rqa3ZqNU55bkdPN2d0ak1LaHd4WXExQkRFaTZnVkl6?=
 =?utf-8?B?OHlvemhnQUhORGVmTDBDbW5zcWVBT3JzMXJaTjN6ajZOU2V6RzIxT2tGMFBZ?=
 =?utf-8?B?bWxjSkkzMC9lNGRBN2M4dlZVdHpVL3hLei9tYzlNdkp5K011cjRpSWc3emFy?=
 =?utf-8?B?ZUwrZjg2SzIvZjFORmdQM3piY25rbmFXSnNGemMwY0doUkFZUzMxMUx1ajVt?=
 =?utf-8?B?ZUIzaWlYM29nZXk3RkEzY0tVRkdIV1hZZjg5ck9EOUhWckRjTkF2WUt4Ynpp?=
 =?utf-8?B?emRIWDhaSnhia1FXeEt0U0VyWHB6YmY5WjJyckFra3JJdVpKRG9HdDhIcExx?=
 =?utf-8?B?NkYwS0FMNk9UelA5SHNxV3ZNMjlEUjlWY3dHV2s1SCtubkNOeVJUbU9nOFdr?=
 =?utf-8?B?aXErSndEVHBxazVNU2s2OXYyd1FibDA3ZFRSanlzY1ZETWlMdU1KemQrM0FE?=
 =?utf-8?B?QUFla3JRSVAvRmpkdnlTZW0yeUYyYjVaejJpTmxQbkRIampzc0dTbjhUbTdO?=
 =?utf-8?B?WFNpdlVTU0RPZ1pQN1NweG5Sa29JWjF3R2tOWDBMYm4zSVNaSmRTUVVobm5y?=
 =?utf-8?B?R0J3WkdnRmRBZkd4N1FZQ0lpVVJKSmdWcnpOWkxqTWZycnBGRCt1Tk1UOXAz?=
 =?utf-8?B?cFA2S0p1RWJIRXZCUDJaemEvVGpka0lZcGw4WHVtZktnYlk3RlRJVHY1RHBC?=
 =?utf-8?B?QmlONXlyUit1LzZ6ZVhMWkhCNWV6WFRDb0o1WWJwSXJNaVVSdnVMZUNOUEZm?=
 =?utf-8?B?cW81ZExEdUhuUE8wTnRwbHVVQXZxZFBHYUxHVjloSklaOU5nWXZXK05rbW9s?=
 =?utf-8?B?ZVR4YnNOLzVCQ2tiNXo1eE14S0V3ZHBQNHBWbHVNcEhpUWxzaEEvSVNYSlJX?=
 =?utf-8?B?bnpNMS9PVFhHT2NSMFo1OERUa0NKQTMrSWJZSk1zVzdveFBJMmprcUpYK0xh?=
 =?utf-8?B?eEdESDdtdWNkZGJNUnl6RXY0TEFwNXp5enZ3MFU3QTBvcGc3ejByd29POWNI?=
 =?utf-8?B?U0todE9nU25NVkV4VEFyQ1JVMTFWd3pHZ0JrbGxYaXdvTmxWY1ZEc0R6cDNM?=
 =?utf-8?B?YW15QmVwNVh2dkE3aXM3ZTNkQ0V5amtQNHk5dm0rajc1OFlKNlkzR0ZzU1NV?=
 =?utf-8?B?RlRpVXN1MEdaelFGUjBMbTJXS2VidjB2WWp3dlFYUGpvZGROdUFWUUpwUzQ5?=
 =?utf-8?B?cW95Ky9UaE5PdUN0bzBnR2RrRjN6RTltSkVjR0hjS3lmcEsrdnpodm5NWDc0?=
 =?utf-8?B?ejM4eTkzb05ER1c5N0pFejZpYVB3MndCVTk3ckJRZ1h5MzNPUXVqa3JuMW54?=
 =?utf-8?B?VXA1QUd3cE9qWTJuNmJGN3JQbDRTM3FQbU96SkhIenJsSjBWZ2VxcEdlajNy?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bWVTL2tQMjhib0xVOGtuSk9wSjNsRjVIZDZmN3ByajFMOTRHTm5VQkl0eFZQ?=
 =?utf-8?B?d3RScDd1eXlzM2hQaFVnZDBxRFZBT210d0FvY2tpaWxjcUFITlZSTFJxaXUz?=
 =?utf-8?B?S2gvSGxSZFI2QlhFWEsrNEdDV0h5OHBMekVSbHMwZERxVGNsaGNiZ29HTmlL?=
 =?utf-8?B?VWxoUTc5TGlRTmt6dzhxNkQrSzN4d3haQ3pZb1p1YWxOaW9hNDdwbkRCT1RL?=
 =?utf-8?B?Mmw0QXB2b1J0MnU5cnpiWVVsUHA4eHpZRFlkMjFNQWRvVDJnS2RIbEoyR0FH?=
 =?utf-8?B?VnQ3V1pqSlprNUhjNGZKamJ3dForc00yK3JYUzlTUjMrcVNSa1dhMzBWZEcx?=
 =?utf-8?B?bUR3eFFGSUVBMjhlM2h6a25hT1JmUnlURXNsa0QrcERsMVZHYUZTWllHcXQ2?=
 =?utf-8?B?TnFLcTVDKzNMZXN3R0xFbXdhU3J0MFlKdlZiUEpiMk9UUU5CaFVTeVNOdGli?=
 =?utf-8?B?MmF6NnFlZ1ZhWm85K3ZrTGxLN0U3d3pxS3RURFozN0tNdzhjVm5sNmRGVEVC?=
 =?utf-8?B?N3d0b0FVZzhQd25kZCthZ1dpeExCZ2tHV2NvZnRtMXB6MUpyZ1ZEZWhrSFpi?=
 =?utf-8?B?SE1WS2dsaXRZZUxFazVKTHpLRzRsNFJjaW5Ub0dkcGZUeW9XOHkxNGlGSVhv?=
 =?utf-8?B?WlhkdUQ4T1B1dUp6WGR0ZHFLNEl3Wnd4SnArNnBsS1I3czlFZ1BQQVRRcSt5?=
 =?utf-8?B?enB2UHhZTXNhL3laRVI0ZWpIQ0VLYXl0NDJLNWpMc2pPNzAzV3VyQStwUFBT?=
 =?utf-8?B?cC8wd05WT2FKdUxDdnIxVVd1QXE3eDJjSFNZWkw0Ny9yNUtmMEIycEloZkc1?=
 =?utf-8?B?cnRTcnhHaGp4K2RpZmsxTC9WZzZEM2RaNzNXRGZIYVZGQm1zQ3NwWTg3RllO?=
 =?utf-8?B?ck54TXRmR1Q4UmFYK0VXM2piSHNTZDhQN29UTkltNjJBaUJpNVZmenY3OE10?=
 =?utf-8?B?WmVoTC9jMzJnN3dzeHR4TnpNNnc1dFp3Z0tkd29mb2txMUg3SGUxNzFjMkZk?=
 =?utf-8?B?UFJEZTBGOUp5b2IrSHFFb3RJdGtUTWJhKzkwL2VuY1ovUmZhTWRMV1VHczlO?=
 =?utf-8?B?YmY3WldJaDFZMjVWMUlwaXBkN3VzZW5abmhaLzJTTHovUGIxdHUzV3hnZEFm?=
 =?utf-8?B?MTZqSXhjUHR0N3E1MlB6cmdWU3V1WVlMMi8xKzdiQk9EemZoMnIyZXVDTE5Q?=
 =?utf-8?B?Tmptc2gwMWdtKzRsVlB4Y1huZWY3MzMvNWxXMVVLZjNOa21SK1FORy85NmQv?=
 =?utf-8?Q?UACKr2H36jRaYRj?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c882b1f-1394-4f6d-cb17-08dbbc2e1d46
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 12:10:45.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3il8tz+rRPN2fVmVsuDGiteXzpcLzMOK8ncsVO2/hbajWVj5DAQGV7g++fZe1MW71Lc4o9ryzgA8lV3oB2rWn+j8etJAvuKzPdNTB/5iuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-23_09,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309230101
X-Proofpoint-GUID: hZUkjomhNPxaOOgaGfXhxV5H9A3nBp55
X-Proofpoint-ORIG-GUID: hZUkjomhNPxaOOgaGfXhxV5H9A3nBp55
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 18:54, Baoquan He wrote:
> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many momery hotplug event are notified in a short period.
> They failed because failing to take __kexec_lock.
> 
> =======
> [   78.714569] Fallback order for Node 0: 0
> [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> [   78.717133] Policy zone: Normal
> [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   80.056643] PEFILE: Unsigned PE binary
> =======
> 
> The memory hotplug events are notified very quickly and very many,
> while the handling of crash hotplug is much slower relatively. So the
> atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> serialization of crash hotplug handling.
> 
> Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> hotplug handling specifically. This doesn't impact the usage of
> __kexec_lock.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>   kernel/crash_core.c     |  3 +++
>   kernel/kexec_core.c     |  1 +
>   kernel/kexec_internal.h | 11 +++++++++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 03a7932cde0a..e8851724a530 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -783,9 +783,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   {
>   	struct kimage *image;
>   
> +	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		crash_hotplug_unlock();
>   		return;
>   	}
>   
> @@ -852,6 +854,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   out:
>   	/* Release lock now that update complete */
>   	kexec_unlock();
> +	crash_hotplug_unlock();
>   }
>   

The crash_check_update_elfcorehdr() also has kexec_trylock() and needs similar treatment.

>   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9dc728982d79..b95a73f35d9a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -48,6 +48,7 @@
>   #include "kexec_internal.h"
>   
>   atomic_t __kexec_lock = ATOMIC_INIT(0);
> +DEFINE_MUTEX(__crash_hotplug_lock);
>   
>   /* Flag to indicate we are going to kexec a new kernel */
>   bool kexec_in_progress = false;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 74da1409cd14..1db31625ef20 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -28,6 +28,17 @@ static inline void kexec_unlock(void)
>   	atomic_set_release(&__kexec_lock, 0);
>   }
>   
> +/*
> + * Different than kexec/kdump loading/unloading/crash or kexec jumping/shrinking
> + * which usually rarely happen, there will be many crash hotplug events notified
> + * during one short period, e.g one memory board is hot added and memory regions
> + * are online. So mutex lock  __crash_hotplug_lock is used to serialize the crash
> + * hotplug handling specificially.
> + * */
> +extern struct mutex __crash_hotplug_lock;
> +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> +
>   #ifdef CONFIG_KEXEC_FILE
>   #include <linux/purgatory.h>
>   void kimage_file_post_load_cleanup(struct kimage *image);

The new content for kexec_internal.h and kexec_core.c could/should probably be
moved into crash_core.c, within the CONFIG_CRASH_HOTPLUG?

eric
