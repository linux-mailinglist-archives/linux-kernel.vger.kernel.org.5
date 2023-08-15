Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0428D77C546
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjHOBoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjHOBoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:44:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A164D19BF;
        Mon, 14 Aug 2023 18:43:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOp76015286;
        Tue, 15 Aug 2023 01:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9Mrjw55c+f43ZLbAakPOJFAoZYZDvZsNdQpWKHOKVFs=;
 b=J1Gq73PS4r178a2jzpzGd8ynCyrhuPNaWdz6SsPvhZvF0oN7bE9Mx2R51j4Yly9MR6lO
 Ql6Lg5adcTZr2E8SxaXNyqkToEX0HpLFyrynfvQ4ne9HMtDB67AR+TqpzroX+RdLEEBp
 5U8Urna75WWztWYzjZjflQtNmaK3tihc3YY77Ubr/dKuRK24c6S90iIKo+9L6QFU5atO
 qAsB49elYJC2gsDlTKqL0zT7RkiqrcYdsOEzwQpVlauWXNuUQRSQn9yqduFKZO4q8B9+
 elvD3AN+VcXxgRpTK7FaWVPy1uSYlTTbsFmfxr5M447WKZjdoX1i2jSNsTYUHQFOEGw2 yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwkw21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:42:56 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENBdxC027490;
        Tue, 15 Aug 2023 01:42:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rk9e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0YY7SIszIxzLxIiNJMkP/aZ2KsFACjaIT+ujFCKb6UHq4fCeAzcRNYyzZGYC8wQgBc6HixbKKVye2RqdVCObaaYjhjc7KAuHhx18aW+kMLV2K6PsNAF/kYiQjY5OTlvAhckT78Cy42ZdmBhLFMAxxI7UZP8+ckG3SNxWOLRX6VgadQPQuQ8f7JzuiM42509I82wjUPsxFou0d9Zj7VHm0HiMO+8FzOadSEC/ETW/vQ2vEKLk1Y5v1RubpvS/o/ihPLvNdgW6XOB25v8LBSd4TpeWSXY3c3laVaajGuVfVGiNm+YW47JnA6KFfmipkuRZgiytOg/geQRfCXAAbPWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Mrjw55c+f43ZLbAakPOJFAoZYZDvZsNdQpWKHOKVFs=;
 b=dJjWugQblP8rfyPJ/p24C8MlTNAD40jTw7zKE41KvgluHN9ChESSmJ7VpQpLAfsEJ1R9OIR/3N+E3VfCmC4jXwzB4ZCEnVZx3SZnyQC9XpWtNhiKd6TV9Fu60sZy46+Ybh5aMY670xwx/5607bg+jf4iFOzwmUMKKmIh3+4hGTsji8mxhRJXXKV1Ec/CkbIUS4FnPovnWOnQ1NZrCUs+M+A6WNPqgwuJxwQ1qFcgHlYHxplD6YbKqYzbfL8QTuB2ucbXzimVtWphcM2eXKyYaM9YqSqLlPQUjUP639/ZELZZArRBHwPXBzRAR8Hb5HudPYMYPJjbPbYG/aEhovAadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Mrjw55c+f43ZLbAakPOJFAoZYZDvZsNdQpWKHOKVFs=;
 b=GAaoKzIAebZKgEnlBPZ1arRaC6dGOPjPWOLS/fOAVtyWCzjaYqQjyl32CQ9koPRNyGNk3lTCvaDmLAdvK9C0/fKdynrTZU1nhdtUZy/JLsv46lH4eaIrcChf5bvjNd/QV9NCqNhH/Kz9o0kewoPukOS5x9r9JpjaAEmQO761+88=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB4672.namprd10.prod.outlook.com (2603:10b6:a03:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 01:42:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:42:53 +0000
Message-ID: <d0cccf43-7420-4208-9851-47c7e8b87f0e@oracle.com>
Date:   Tue, 15 Aug 2023 07:12:33 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/89] 5.15.127-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230813211710.787645394@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB4672:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf14740-9cae-4d92-5450-08db9d30f12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6+3lJLrciIApb9nLC/hg81E6LBvYiG2cPr63RVrJqTRX9JrB6o/snI/J0rrgPKAYkEI1WNcclXdSk5+jdcLk0pcu6CFGUADd7Vend2JMzO0usofTsRknyzzezFSbCiLdzSawsE+/KGunUX3OTZWlxHaFSlOpMvNL96i8/Ott+rjgXb9qsmFT+CgnPn9fdGmWw3iBVLxcZwoOlDlkD+DDq/+Ws+mQjfBoVkimmL3ezjp88U47YbaZUmxuZzSv9y7MhIpWSemXtg8hfjJsewM8LSg2HAMowxCa8kxqYaVzY6umUutBxN3h+n1ZDKkc9OFzLL6UMyF0MMf+q5FZKAfnfNcYKAHUJ22kEM7mDwsTwLCxBPmZJHbTgSNMaUgzkYVk6QM3jmdRGzDzHediw/f0hahAvZoRIxLcr4FR7zO0lCVjpsXNTfHbxZdO+X6vN1adL1H4VqqC5ccrI9OS35C7OMQ8b/7YaAVuEoLGb9G7RL3awjjm18tWytZSlVcuokV8hN4mKxkoORh6lHvK88S3XSotMPr8rWUo2cB7iHml5buT86BzrI8flVoxpdDp6nyBbZH3GASTgz9oBWJJGqN24y1i2TRncvmN0NJEtpAEf5PCJpT3pxaP9SvZ/WIb4m04ENKvWr/3whuzOOtoKnaXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799006)(186006)(451199021)(107886003)(53546011)(26005)(6506007)(41300700001)(8936002)(66556008)(66476007)(66946007)(316002)(8676002)(6512007)(966005)(31686004)(2616005)(6486002)(478600001)(6666004)(38100700002)(54906003)(31696002)(36756003)(4744005)(86362001)(4326008)(5660300002)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWlkMkNUSWZYSVJibG9uWVY3dXdscmpDQTB6aURsc0lyc3VnZVdHMWpoQnFM?=
 =?utf-8?B?RjVKUnpHQmVMZjViSEpKMFZoUXVqbnFna0g1dG1uQzd3VFdKY2hjbUQ5bHlo?=
 =?utf-8?B?VUZ6Si9NU1MxaExMYnAwL2MrMDVOV2dVUGJoZ0NjbDBSZzZuaXFuNlFUMjVX?=
 =?utf-8?B?bERMdGpjN3BTaFhkeWJFUkp5UUV0QWlMS3NDTTRTQmFTY1ByYnkwVzI0TkJ0?=
 =?utf-8?B?NzYwNUdoZWZiQ3FxbGNNTDBGeXBKaDk5U3dnaWFQVS90M0dEblNHTVoyc3M0?=
 =?utf-8?B?ZExxTmFpdTJxa3RBNlVSdmVOalNXMjVHZHJ3Sm5md29KWHNTdFhuN3BnbUZj?=
 =?utf-8?B?SzhVd01DQWo2bjkwOWVSUEowY2JBWFNQblppeitrbTJJdFBWKzhrMzhndHVj?=
 =?utf-8?B?dFhtV25WSk1BVVJTNGJVUkQ1b1JRaEtGNWRBZTVPZVBpSkV4V1pQNWM3VEMx?=
 =?utf-8?B?elk5NVdQWGNyemliWW91MkVJVFFZNDkvWE1KcStKejdaRDhVTFdad1B1elFI?=
 =?utf-8?B?ZFdRbHNZNThFSkhIUUF1aG1NWlBxajF6ekhVdDhCNzRpQkFSVll4KzNsbHFt?=
 =?utf-8?B?VWs0SUFoaUJpTHl0WUV0SWpKck0xMkgyblNEVkVmV1B3WlNkUHpadWVBbUs2?=
 =?utf-8?B?R2VPUGhKb2pJZ1ZLcWhLVUlHdGZCL2ZWQjQyQnVhQWt1Zy8ybjRlcXNnb2dw?=
 =?utf-8?B?Sm5zTlBLdjhPcWhwOHhvTVFiSkdkcHdHL1pKYXdYWjFWWS9DRkd4ZHdHNW9Q?=
 =?utf-8?B?TzVYYitGNHhpdi9jcFRvb1BRR0t1UitKT2szYnZ5Q28rb1lsbmNzemhPZjc0?=
 =?utf-8?B?Wk9YS1dlTlZpR2NyYkFDbiswRm5Ld0Z5U0lHb2xkUDl4a0lkdEh4Q3NYVnpY?=
 =?utf-8?B?emVrcFlVb1BUZ3FRbHJVNHdXZFh6di8vUm1CZVFjTUxjZVZNNmdKWWhjbVlm?=
 =?utf-8?B?SzZoOThXbDdFWVp5ZmF6ZHVzS0tqSWlMelMwWHhIay9kRkd4bWFURHI5Z2Vt?=
 =?utf-8?B?cmVLOWI1enlrWVBPUXdEYzJBVjlnQmVHcDJZRWx4VS9ZR1JGSm1mek9FQmxM?=
 =?utf-8?B?WExYeFQwa05jbVFPeHcwSmRvdlNER05aY3RIMzlWUU1JOHhBR3JWTmsxQTFS?=
 =?utf-8?B?VENUblVXY2d2YjJJK1FaYWlGdlhNdVpKWU5ZaVRSNGxmNUR3OHJ0dyt2b0hW?=
 =?utf-8?B?S25HQ1NvSUMzdVJEU3Y5RjI5WEYwL3NsUDVMZWVYUnVJVVliUDdZVzIyRSt2?=
 =?utf-8?B?MFF5MTVlV2NkNHZBdVgyRkJua1hjN1RBMkhqVUltL0UvZE5FVVFuSlZkRjVM?=
 =?utf-8?B?bDNrdVREOC95ZjlZbFVmSzhoM21nRFFDT2ptL2dreWtmUzUwczlBSmRjcFpI?=
 =?utf-8?B?Rkh0UlhBbHRFZnYwNlF5Ry8yNWpQYzFkS0pQUWtGckIwd0pNY2JDenVtNGtV?=
 =?utf-8?B?S1htMEovZ1ZHRFlrOU1iVkZxQjJhdmppU3hSSnpwL2pKaTV3azJRZDR2WUtt?=
 =?utf-8?B?L1N4SUUrMmIrRFBhcUk1QytMT3J1SEdEc2NGZXlhdHdPc3VTSnQvRk1NSjI5?=
 =?utf-8?B?by9jSWFUOEFINGdNSFBnd2pjVFJVWi9zWTVSZnVhSER1WDcxWHduWmZnZjRC?=
 =?utf-8?B?ODdNUUIvaHdSZVdiZlYyTVpocWhmdFF5VHRMSmFyam56aGM1ZjhJZXVUYnlw?=
 =?utf-8?B?K3lDaUQ5SlA1SzJzNW1ubGNuMFRvRkVJYksybExKMGx0L3U4NG1pM3pwVTZv?=
 =?utf-8?B?akFFZVJuUjZ1eGxMZlprQmdJZFlNdmhvV2tmdjAxMXRBNEZsTTJrVEpPNTBR?=
 =?utf-8?B?Y0FLSkxQckdCWE1mbTBqL1o1cUpOZm9qZmhWcEc3YlByU1k3ZXd5NUdMeGg1?=
 =?utf-8?B?Mmx5MklLL0VDMTFYbWJ2bHBNcjFONFFJT3dZVzRWL1Awdk5KUmJQTWRQd1V4?=
 =?utf-8?B?VkNxV2FmRUxwNWFTVDBhU2g1QjdoMlV5TkZldzNGRC8zbFNFakxWbzBXaC9i?=
 =?utf-8?B?c3pwQUdhV3lDdmZoaHRxVjZUZlNXZEkvVTdvdFJpZ3Z1b2NUNHlUQzg0d3Nn?=
 =?utf-8?B?Yld2S09ZaVEwdHRydkIzNXNFQ0Njd3BtYlNyaDRFUnAxUHNxWjlMTVlEYVkr?=
 =?utf-8?B?dzMvSm5zVlVmNkMrK0czcmdVV1JRYURuamxPemZyNnk3bjlGTU9qQVQzVnVr?=
 =?utf-8?Q?H03uaWlcEv3fYfhuC9aGKJQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QzBScUtEdjFrQWFyclVEYWU3R1lYcFlLTVdGN3M0dkNrTENwVmorZTFYd0NO?=
 =?utf-8?B?czFySWFvSDVOckxnamU3R0RieDVrcTkrNzMrRlp6dW5SRHZYenNyTEtxbEF4?=
 =?utf-8?B?S2QwekwrYmt2alZtRDlKNlgzZGx4OUtjRjJJZlp5V05ZUEVNNDF2eFh0cjBO?=
 =?utf-8?B?dVRLWW8yUnNYY2o0SmtJMnB6a1BmaFlXNFlBVGNVTEVtOVo0QkJISlZLaisw?=
 =?utf-8?B?UWJyUVlvSmhXNm5uTmtxSUkraHNCdnVQTXRoWHZkMkRFWnVhUFFVVWROZTdv?=
 =?utf-8?B?M1NxUFExVXRGb1grcVFGK3U3MGphTXRCZ3RjQ09JMkd3U1RQT2RyblVvSzBr?=
 =?utf-8?B?Q2lzVFZteldlVnk5eGRzRFVoTkkzd1dzVit5U0g0M0tzZElyZ2lwQkVwcDZk?=
 =?utf-8?B?TFVpWnRTbERGT1JZcDF0aFZ1QURYOCtVQ0tRU2JCdnVwZmYzdkdHd1RJcWRh?=
 =?utf-8?B?RjlWTlhoYkp4WTU1dlREdjd5TDk0UmxZSlZOdk9NMFlPUFExY21IampPZWdD?=
 =?utf-8?B?NzlMY0I3bXFwYkluc0srUjNEU2FHMjlEb0xIa3ZlVDVzMWJwbjJzOTJ0VEgx?=
 =?utf-8?B?MW4xUE1sbG0yN3phK01Bb2xvcVF2WGVsN1NMbkR2NUdlWDcvd2Q4MzA3Y1o0?=
 =?utf-8?B?U0YzT1FTalZXSWNYMm03eDlYUmN5ejZQRFVqc1VPY2RjcTA0NEt5UzhWczk1?=
 =?utf-8?B?eUEwNUNqWVZOdVVxZ2lrV3pubDJ4Z3VwSUFpMlh2czRSclFSblQySWZYOE1u?=
 =?utf-8?B?UFNZaEdKM2s0SHlvdWFyeUNHV0J2UGYvVGNPK3kyZWFLQXhKUHQ4cFZaSTA0?=
 =?utf-8?B?Nk5pV3ZpOW9rT3NIeTFydUdZaHVidmN4UVNFeFM1SVg4V2ZwenZuVTg3M2Ro?=
 =?utf-8?B?NnJXalMyRUFRTEZoYlkzV1J6eXRCc3JIREVzTnRZZGt4NStSbWRPNXV5SlVj?=
 =?utf-8?B?QUNheW13cVhNd3RvaXlyVml0NjdNN29NdGFucHZRTW53eFRkVUR5NGU1dDhL?=
 =?utf-8?B?ZDVqZ0pyY2s3SFlvWlIxdnRwWTh1ZHlkOTlxdVAxQWs3QlBoT1h0MldNNjBy?=
 =?utf-8?B?V3pjODV0UjY1ck5VakFrL2FiM25SVDJzT3NhaU5xQVdIWDJTcmpOaGkzeWJ2?=
 =?utf-8?B?Ykx6Wkd6cTNOc01zVHd3eVRKVm9ZcDFsYnlraHFFT1ZTT2h2NDBOclNEeGdp?=
 =?utf-8?B?VDRmQm9wSml1Qktpd0draEJXQWw3UVFPWlQ4V0gzbEdNV3Q0ZUZGdUtBaCtI?=
 =?utf-8?B?ZVlleVFJd3Mzc1U2dEsrbjF0dkt6OW1Jcm5jWk5IeGZMYmllSlQ4OUtIM3Fq?=
 =?utf-8?B?Y3J6RC9tS1IvTEd0NWVhVVFOcDlBbDAwWG4rY0U5WnVXR3phRkVZbkJYMWhG?=
 =?utf-8?B?UGlLK0xPdTVZUW5lVGFDYkFxbXFZeWJzeWxIK0tiNWxMSVdLNHlrMDNpTmNv?=
 =?utf-8?B?NHB5OE5BN3hQR3VWSnhoMkpsK29GOFFEbTlVL1NZRHBKVG1MK09ZU25qMkRC?=
 =?utf-8?B?cG5QdXVuUSt6aHBxRStFNUY0RFJyOCtWRGdIZmtaaU04cU5Jd1NKcmZ1RjhH?=
 =?utf-8?Q?AmFZ72SdH+9Rj6KnP/ALZ89AE2FYxd2SaxmVJfQbUan+JB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf14740-9cae-4d92-5450-08db9d30f12d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:42:53.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RluzZ9RTajEzN0FgLfgwfv5t4eXtbNSUxFF+BTrmwqCuCjMmgf1ljB9Ow8g551syW8fo0cy8RFuDvvqs/9Ejoy8Ac3kh2EgMbf3OskhWN3wcJfWPLt8m9WdtC+kjFlEB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=974 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150013
X-Proofpoint-ORIG-GUID: 6e3tgweBm8Skjxa6ilmg6DiDwWwV8NLt
X-Proofpoint-GUID: 6e3tgweBm8Skjxa6ilmg6DiDwWwV8NLt
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 14/08/23 2:48 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.127 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
Ve
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.127-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
