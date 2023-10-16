Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664B77CB3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjJPULN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjJPULK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:11:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D583
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:11:08 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GJONwP016965;
        Mon, 16 Oct 2023 20:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=xjyRHrgNcJ9ahZY2u+6icxRwcLYpB68Ct5nHHyFaHlLosFpJuC8DZojvKoDd1PhuQMtY
 D/7Mmqw9A3XSWCgoLJ4RcL6Wu7Ji9CyiSfw0XkqDi1aM9J5hk3XxGzmfzqGiNig2FM5E
 Leif0nIw5JY9Uq9PcQmEo2nELXCDrGIig+dvkmW2bX/SIlRyS9A5L+oBDrgXrUQuys5K
 EIIWYF/MpqAFormSO3JANrJkHva5Xs4PjIu01ojY7kgFOfb+7t8tkkM/Sa03z0XM182z
 gGREcUohzmChtNCTFBpm1iSQuJGtRI181C7ElqgPC4NrQD6nBvVrKPvOACiZccEiGsuu dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1bp07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:11:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GITtbx015354;
        Mon, 16 Oct 2023 20:10:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1e4bk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:10:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhxjRMLnLSI8ZZnhTZm+s+6EYfzPvjOQF7Cv+tuv0hjB7YNT7mfvGhvPrnFhTDwYuvzOd0wnFk27Y+Swsb+QId9EWEdQvlfYu+DO/OVdPvo6doPxd6WjY4f9OiGfx1S64v2JsPHeDw383DfWM0wKbRJxB/i/T/M2hjiphQfbOMkVJ+McdDxijN5NwZyL+KFlBRZXxeILAhnImzVzD9Xnu168I85gQ4NqqJaMCttJ2C0imLf6AUGDZu28kWCL4rvqwd67Rlj1HrexLAH9iCie/j+oAawLznKqsSJbxKHrDFvGH9cmXsvIK3omjFA/ZhaGEd4eDuCKNOonBT1B6QirqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=U4pT/Fey7X8IiYyj1/K45HQrvPsjJcD9TKQg6yz92/gzJfVZ1Qnz4qBIB4ottkaOa1O0xpmQ/KdFv5xZOL61No6d1X7SoSYSqEL4D/a8eEhlzHVeaccqgvF8/sD/1+7VcrqfCDvtAJQ0PM5LwE5+ghbPQB/0EleObj00lx+5ghiYecGBC/JJ2vwiY3JeGN2u5V41xxI+We1P88VWOY2aEkhOxdaOa7CIMp6heFaYI1vpmn3Av6tgDoY6x1OaL1TLysoJmI0I5zaPQtsaXIlBRO9/2rxtw8bFl8kbBuL2qiO9A00An7mDczPzANsPjmNEbk8X6z9q6mbvu/x6ncrg2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6oAcdQbLJvsSIohxME5ZUTi5eR7WXzqQcO5Ryi8h10Q=;
 b=qmJofEaXk/BE5lIwV6sHzD7prJMiK3PyruwT89Jf9tBrsGd+8UVtWO71fBmR1iwYyNyrq0dnsLP1s3mu83PKjr+FyLpMT49XzZcKc69bFjEciDR7DAs7+1Icm9947oLet318sqdYVQPlI9usH6X571SIhMjWQEA9OwLHEy6ca2s=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SA3PR10MB7070.namprd10.prod.outlook.com (2603:10b6:806:311::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 20:10:56 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:10:56 +0000
Message-ID: <aa1c177f-7d3f-4b66-8f0b-ab2c4bf40084@oracle.com>
Date:   Mon, 16 Oct 2023 13:10:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        dtatulea@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::12) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SA3PR10MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f23107e-bf8b-4677-69e0-08dbce8401d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVrcmmybOAfaj2X9OlLBdvaAuEZlbGrWps8PiHfENdm1XsGOMYbKIIlvwukf8NZ383DklZjJjzprqnAiisUbGrGEbuuwkM95/HQS2HiTER3fqyf5fX4xFBbJjO/AzR9S1cVwqYZOP9ID9YSOks9/ichXkSbfBJdvJhwwXq1IEgSSr5mc67LXX/hGqcD5DSc+U7JVRvKNsXsdr0TjCbkWv5kKmppEtDxAFFzSe05hp1TlgECXDD4QPiS4YbwBgdiY6EDCuvz+/ay3IH9DeMjwL9RzOy41f1l/xSOELPfMYkXsgeWjZxR0qGl/1+IPjnfRY+zxtNvO7ZcxQjgkTF34z09pZbT1hRLFF7CfQfMoKFfknHiLPSbhNGT7vIwmFM1ddumAk8OFJvg/Il702xH4coyCovGM4XDsHKo/v7i+Re4QxU9Sh7Yxh5KMtg9TrI+800WlVv2IJeu8+mFhpdfZeYhdr0mIqRTZ8/xvjj5JL//AKpeMVIKMW0VJcQzYv5fHF4QLoVBLjJs6G7UbG97nhVW3XRJR8J8ef3kf/Ve+0UKsZy9LLsS95mZ0GLrst4DTUPXbjhm+wIoZzNq23PHz8zWIOiv7LlSOGhi3sTGH5QOAXSHheEwBNA9mx9IhlOBQEkF/tDZ/PDHUB3bOJTeEyRaINDBNKkDla+jOQCEaSM7tMM9cVnESDmdy+XzPzlTGJXeKDFcRHlGvfgcHxTOuKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(83380400001)(6512007)(66476007)(66556008)(8676002)(4326008)(66946007)(8936002)(316002)(6916009)(6666004)(6506007)(53546011)(36916002)(966005)(5660300002)(41300700001)(478600001)(2906002)(6486002)(38100700002)(86362001)(31696002)(36756003)(31686004)(26005)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRaeDBEWGJYWkVzNG1WdnNRR0N1VWw2dlB4bjdNWktFdHZMMWgvTEtDa21Y?=
 =?utf-8?B?eWJWYTdvSy9RREhhR0d3REtiZVJmM0xlUUdKRlp3Y1ltcktXcWdLeW1zYmZk?=
 =?utf-8?B?R2g2aDcreHhpSmFhOXAxZWJXUlN2Y1pqUGhmVEJTQzluQmJDNWw1eDkyUXB0?=
 =?utf-8?B?M1phbEZucEQ4cUdVYkhBS2ViNGJvN0Y2NGhLb3o3ZlMyMFYyY0o0eEdOZ3Rq?=
 =?utf-8?B?bTlaY3ZFT3E4UUdEYTh0a3YwU2pYdnJBMi9kakZ5M2VnKzM4Vk1ENElYeW1s?=
 =?utf-8?B?Rjc1V3IrVEg3QTBncEo0TlNOMElRd291a1NkQ0xFdURqNE5WMjB6ZjZaaGtn?=
 =?utf-8?B?STJaN1VsQlk5NG82a3dZbTBxK3BTamhoYjYyWUdUYXNiWU9yc2w4cVRrT1RM?=
 =?utf-8?B?Y2tiM05VZnNnK0ZrYjk0U0xONlhtN0EvbFI4ZHdqbUFiR3hTTWx1R3VWUVNj?=
 =?utf-8?B?NzNraFVsNENtc3pSQTAwNk1lZWIwQzFBeGZ6bXQvL3lRWmR4Nnc5VjlJQXh2?=
 =?utf-8?B?emNlTFpQS3Fib2ZYcHE2RUsxemFCRnhMVVE5TldrVzJrNFZIdzA0RzE3ZGEw?=
 =?utf-8?B?UFNZdGkranN0NENEM0dnSHI5VHRWb0V0bU1ZN0FzU2RGWm1aakFuRHZ3N3Jv?=
 =?utf-8?B?T3BuYVVuaXpNZTNrdVZteW5IbGJZbmMvNi9zeVFscXBRczlmYTN0NjBFaHkr?=
 =?utf-8?B?bThWVThzYmszV1BnOTROMnZLajd5NHpBOFZzSlpLUThoaHVUOE9iNHM2bEpP?=
 =?utf-8?B?ZlREai9UVUpFWXQ2aDB3Z0JmUVlCb2lpcHNPd1ZkVkl4dGFHWGxlRDl0dlBy?=
 =?utf-8?B?Z2hZWko4YVBwTVRKQ2VTcW5DTDZ4aGdScGpNaFQvcmIxWTNBRGNxOS9Qa1ds?=
 =?utf-8?B?NTZWVUI2MlY5bktoYTVqc1A0VVZ6Ykl1Z25VZFJKVnZucmo5RTVQRWh6QnZr?=
 =?utf-8?B?LzE0RmZkTFJYdlhHQUl0L0twTDJ6RVVUMU8xYWwybGdZYzlpallhUCs1MFVz?=
 =?utf-8?B?ZVd3U2JYZUdzMklMRXBpcXhnSkZpalA1Q0ZUSjlFM2pRRE9ST3ZGMUIxUU9D?=
 =?utf-8?B?ODJJbkNnbm1rbE5MMExTR29CUkFTTStHanNVYW5xdzRHcmFxbmhxSEM4N0M5?=
 =?utf-8?B?TFc1ZFlzMVp1WXJZTXhaejJ0b2paaU5jNW8zMFZNeE1LK3NzQmw0WVFQVFhD?=
 =?utf-8?B?OTFQMlI4Mmx0eE96aHFCWXl6akV4TEF3TmJKWkppanhzbU5SY1krOVBOdVJu?=
 =?utf-8?B?dm5DbzdqdkRGRjRpQ2dFQTlBOWRpa0tvK3R6bjJXWmJqS1VtT1EvQnpZVHN0?=
 =?utf-8?B?UE1HWjlFZFE4cEsyTVJpcU4vWWRtNVlrdmo3WnBXeDBFZDR2ak40d2FkVUgv?=
 =?utf-8?B?RzNMQXJrM3Q2TjhIMlhVczdlaThLSUlIVGY0NkxPNlgzTXFRNUpDQzYzY1lj?=
 =?utf-8?B?RHNJR2VnNFhmMjlqTTZmNU85UTlDTTVyd0ZBY2YwQ2FkWFFuSTQ1ZUNpSXEv?=
 =?utf-8?B?dm5EckJPeVJCbFIwTE9naW5ycEcxcEFmWVdRYmF0aDBzbTROdW91WmdneFFV?=
 =?utf-8?B?dFN4N3hrZVNTU1BLOUlCbFJuWFdqbHBSMjZ3czFCNDJSS3M5VGF0OXoyK25q?=
 =?utf-8?B?YWFRaXdRVUdKeGFnMXVBUXlMa09HMUN5c1NHek9NMGVUNGpxS0xxYUtkdVA5?=
 =?utf-8?B?bmVpOXRudFkwSmtMTnFHdGlBTHRsV25LdTg3ZXVtY0wwNmFaa3lmMVVsTkxP?=
 =?utf-8?B?aFdZNnE0Qyt2YkJBNXFSNDE1REJwRFMxbnVkcmtKejJJN0h0VnRiaE1LZk5x?=
 =?utf-8?B?N09zbXZrRTkwT0l5VC9LYjduYkhWa3l2cWFTQ2pyRitjNEorUkFJQ2xFUHhO?=
 =?utf-8?B?Wm55UEtuV0xLSFprVlI3WEZNM211b1VhM1RyWEg2MzRjcDNTVG0rQndQeGk0?=
 =?utf-8?B?UXVyQzFKWmhHUklhNGFXTzZ1eEdLTThkM0E3aUdLamNZcUxYUXV1ejJIQ0Y5?=
 =?utf-8?B?VklUenJIaFNyK0d0SWhWSDRLN2cyNlZWRStjVU93VzZWZENXQXJ2V3JlNkZP?=
 =?utf-8?B?Ui9kbHFMSFlWbWhBR2MvQ1pNUCs2NTFaU3pBMGk2RVFSY3FFc0RhR3d0S2tj?=
 =?utf-8?Q?116ytV4xLtwJDx0HfMGzeYZqF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWlTVURMWU8zS1FCMFY4azh3WENXYUYrS1hVWGNReXBoUWhkNUFnSnJFQW5V?=
 =?utf-8?B?L3RpenYrZ2lqekVXaHV3RTlsbkVsdnB0RStKTEdlQ3JNb0FKc3M1V2Z2cEQx?=
 =?utf-8?B?dUVSVldiN1pjUEd3eUdneml1T0tncHdQN2hlbFZKaDB6QVh1QkwzcWRTelF4?=
 =?utf-8?B?Um90NVNlNDUvQTdQNndjcEVtdFVZR2w1cFVwK3dPM1VZd0tXM3BzajhzWFha?=
 =?utf-8?B?S3FmTkJCTEFMQ1dCaS9IWjA5L2ZWRmdlOTVSRk10TlE5Tm9WenlTK2dJNVZE?=
 =?utf-8?B?djdGVFBlUWJMUTNkZkgvQWZFbkp0RVRnVGV3KzRMK2EybEhYblgxc1g1OU51?=
 =?utf-8?B?UlpNVDNkeS9IZU5mTmhJWGRVNzVGdVczblE5Qy9aQ0hlSGJBb2NxcStvcWph?=
 =?utf-8?B?ZlpIQU1vMXZGMmZZTDZQaHlVazJSMzE4aHMxWGhSb2lLa2tVV2p5UTg1bWU3?=
 =?utf-8?B?TWlpZm81US9uZkJiU01BYXdLOGh6bmg2UldrWjI2WHZzOU1WbkhBUFA2eTZk?=
 =?utf-8?B?b082cDVQcXQzU2NyT0x0QUFyWkNZZEtZOXp2Z29jemw5UGNPZ0IyTENaUzhW?=
 =?utf-8?B?OG9jSHFJdHp3a1RFM2dWZVVoNnBnaENNK1ZZa2tpTzNtOHdiNkRoU2xtT1ln?=
 =?utf-8?B?YlVDWHlMMHVSOFI3UXUvb0dDaVJIVkxOREdmYzNTREVHNjZEK2RoRERmVEVz?=
 =?utf-8?B?NWhOR2c3N3M2N08yYlhOMG9SWkpiSHBFR1JwZ2hKUk9tZjdGdTNULzFLcCtD?=
 =?utf-8?B?Sit4c3ZpVVNFQkZINFVKMmhRemd4ZEM2amxYZWI4ZGoyYmhtZTZHSGlTM2ZQ?=
 =?utf-8?B?cDZ2d1FybVgrSFV5cU9QalJKaHZnWnZZM09XaG1HelFpL0VhUWxGTC9kZXlz?=
 =?utf-8?B?Y0k2WGJFRDNEL0JMWUY5c0RBaG9JeStkVVdwWXFhNjFxSFl0UDZ0OWpsOTJt?=
 =?utf-8?B?OGZpUWx3Q3czSVE2c1JFWmFVZGY3ak9iMDBHQWJhOWZ5VmR1eWg4c1dJRXor?=
 =?utf-8?B?Wk1MU0NrTjJtT0FVYUdjMytPbjZaendoM3NFckdwemJXZWhQbU5hWVMzWmow?=
 =?utf-8?B?Z0R2RVREME9yYXhKMGI1SzRFc0lnc3NPeHZ6ZnlXcTJ4M1lhTGdtcmxnbHQz?=
 =?utf-8?B?NytaSCtBSFVldUtjZ3hUeDdqTElRSlNua1U1Y1VUMnFsTmRkTWZFUmEvRkNN?=
 =?utf-8?B?M3RPZmU1dG1RTWI4YXdzSEdpZDU5MmRESy9jR3BDUDVWT2NRWmJlUDViZVNV?=
 =?utf-8?Q?IRAAlr86cIJT3ke?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f23107e-bf8b-4677-69e0-08dbce8401d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:10:56.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgvVEzwKMaDVhnPzPl2sEVVLLeSNeceDh9QxunJlwhUQN3amcO4AnpxcAKG+xVyZmlN7LVLGSw2++cZyz2axmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160176
X-Proofpoint-GUID: kp13-1G9Ecbm4iHamZRYyC-CT7lmKBI8
X-Proofpoint-ORIG-GUID: kp13-1G9Ecbm4iHamZRYyC-CT7lmKBI8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2023 11:32 PM, Jason Wang wrote:
> On Fri, Oct 13, 2023 at 3:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/12/2023 8:01 PM, Jason Wang wrote:
>>> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>>>> may need to restore iotlb mapping to the initial or default state
>>>> using the .reset_map op, as it's desirable for some parent devices
>>>> to solely manipulate mappings by its own, independent of virtio device
>>>> state. For instance, device reset does not cause mapping go away on
>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>>>> is going away, give them a chance to reset iotlb back to the initial
>>>> state in vhost_vdpa_cleanup().
>>>>
>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>> ---
>>>>    drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>>>    1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>> index 851535f..a3f8160 100644
>>>> --- a/drivers/vhost/vdpa.c
>>>> +++ b/drivers/vhost/vdpa.c
>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>>>           return vhost_vdpa_alloc_as(v, asid);
>>>>    }
>>>>
>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>>>> +{
>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>> +
>>>> +       if (ops->reset_map)
>>>> +               ops->reset_map(vdpa, asid);
>>>> +}
>>>> +
>>>>    static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>    {
>>>>           struct vhost_vdpa_as *as = asid_to_as(v, asid);
>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>
>>>>           hlist_del(&as->hash_link);
>>>>           vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>>>> +       /*
>>>> +        * Devices with vendor specific IOMMU may need to restore
>>>> +        * iotlb to the initial or default state which is not done
>>>> +        * through device reset, as the IOTLB mapping manipulation
>>>> +        * could be decoupled from the virtio device life cycle.
>>>> +        */
>>> Should we do this according to whether IOTLB_PRESIST is set?
>> Well, in theory this seems like so but it's unnecessary code change
>> actually, as that is the way how vDPA parent behind platform IOMMU works
>> today, and userspace doesn't break as of today. :)
> Well, this is one question I've ever asked before. You have explained
> that one of the reason that we don't break userspace is that they may
> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
Nope, it was the opposite. Maybe it was not clear enough, let me try 
once more - userspace CANNOT decouple IOTLB reset from vDPA reset today. 
This is because of bug/discrepancy in mlx5_vdap and vdpa_sim already 
breaking userspace's expectation, rendering the brokenness/inconsistency 
on vhost-vdpa mapping interface from behaving what it promised and 
should have done. Only with the IOTLB_PERSIST flag seen userspace can 
trust vhost-vdpa kernel interface *reliably* to decouple IOTLB reset 
from vDPA reset. Without seeing this flag, no matter how the code in 
QEMU was written, today's older userspace was never like to assume the 
mappings will *definitely* be cleared by vDPA reset. If any userspace 
implementation wants to get consistent behavior for all vDPA parent 
devices, it still has to *explicitly* clear all existing mappings by its 
own by sending bunch of unmap (iotlb invalidate) requests to vhost-vdpa 
kernel before resetting the vDPA backend.

In brief, userspace is already broken by kernel implementation today, 
and new userspace needs some device flag to know for sure if kernel bug 
has already been fixed; older userspace doesn't care about preserving 
the broken kernel behavior at all, regardless whether or not it wants to 
decouple IOTLB from vDPA reset.

>
>> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
>> it doesn't necessarily mean the iotlb will definitely be destroyed
>> across reset (think about the platform IOMMU case), so userspace today
>> is already tolerating enough with either good or bad IOMMU. This code of
>> not checking IOTLB_PERSIST being set is intentional, there's no point to
>> emulate bad IOMMU behavior even for older userspace (with improper
>> emulation to be done it would result in even worse performance).
> For two reasons:
>
> 1) backend features need acked by userspace this is by design
There's no breakage on this part. Backend feature IOTLB_PERSIST won't be 
set if userspace doesn't ack.
> 2) keep the odd behaviour seems to be more safe as we can't audit
> every userspace program
Definitely don't have to audit every userspace program, but I cannot 
think of a case where a sane userspace program can be broken. Can you 
elaborate one or two potential userspace usage that may break because of 
this? As said, platform IOMMU already did it this way.

Regards,
-Siwei
>
> Thanks
>
>> I think
>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
>> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>>
>> Thanks,
>> -Siwei
>>
>> [1]
>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
>> [2]
>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>>>    Otherwise
>>> we may break old userspace.
>>>
>>> Thanks
>>>
>>>> +       vhost_vdpa_reset_map(v, asid);
>>>>           kfree(as);
>>>>
>>>>           return 0;
>>>> --
>>>> 1.8.3.1
>>>>

