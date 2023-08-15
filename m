Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5950F77C548
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjHOBoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjHOBoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:44:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9134C3;
        Mon, 14 Aug 2023 18:44:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOJ32012995;
        Tue, 15 Aug 2023 01:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kzp1eoz7kGuto1BUfB5xadpi+wcTde3Dd+IfJesxu9k=;
 b=stIF18yvlcLRMZ/rGzSrv5Sl7smWPI5BusL7BLXrbnvmMoWHPZBzAiYFIEJUV14S9auX
 rtwCEd8JE3/2vXuE6ubspqBgOL8lJyKjwED/VG0bVkTOzlovlCsNneFGpLvjknoWKFWB
 vj7GLZCoF8TEm3+oh3vAV8UnffPCD+GSuI+eT5wzcvIZ5MaPx6plxERt49qU9f/GAVaR
 idS0encEAz4lKIqTLZGld6cIxNU0HzH4sMnL+OcoT/YguspMI/b2cFii6ypF27Rc2ZKt
 EkXDnu6vrL8bn8kMhrSsXFl3yOfR4v63QO3tlVAkH8JKG7RwUe2HQ+aUaJ8eJhX+wLOF Qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c3shb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:43:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ENSHFv019946;
        Tue, 15 Aug 2023 01:43:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3uuhb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 01:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/4HqOJQgTJw/JZCCmDvxCs/u2JLSAw5oGVXL2v0wUTcq+nGoX2dIRpEsdjqfKNv3hDIn1OByAn70JlPJ+FDZDmYNb9jEXfU0TV7C3iXImbivDQ/lLodIvySDCuS4Dzv1Jbmiqgo4f4QY53cfprcGhuIl2Urf3dV8UdEohLhFiHzuGGlgPXngbF1j9e/ffpFDbYKFxO/O6W/qVZkRPOAgZrPTwF+/Dd77WPeVnPidDpdE1uXKREdcznuWDGN7IESabAYvb9J1LAwexLGcCy4jS9FFbCjGvrr79hMW3LwhmFykAkfqfkeZqPwsVpjpf2FNnvYWwRHRc63DvCh4GZ+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzp1eoz7kGuto1BUfB5xadpi+wcTde3Dd+IfJesxu9k=;
 b=Z4um5NksQDEg5D1JsbhMDVqixXrYCbf6DkGJkWBCGRRhKgzgaV/DSyG33V0TkoPA5mZSpvpuKRRaDNza+rng2Ihd2LBvihX5xgaxZLOdixCw7PTOzP5UYDEZcXDMJtdwq4EF/IT3ATv6Dabc5viBKEQAx5rx3VwzHBdhhjeMT1X/ocM1ezEntXcnL2ur9LQRU8vuYaUybg7k3ar81JzwzDlBYdmh2MKHVn3buCuEAXiolYsMCGfQ6Mhn9rIM6Rt43ziOlmA8b1abUO7kJPE0dChUqMvpNeOlVYBxUJ/8CjHvYDhotbzXFOTzQltPIwl2TLj5NNd6KkLjjX+VBhGKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzp1eoz7kGuto1BUfB5xadpi+wcTde3Dd+IfJesxu9k=;
 b=fhQ+Fo7XND9PeAdHqGgEAj+jWr2vEJs25KtvJedIfmAPSXVnppxx3GG7FjqmwKXOWGR73jOR92qMP7z9SZJBgxzIHog7e1Msxcnd5PBK2q0rI5+/mIDXbT4/8fomse0tVMLcqU8+N6XfcCl8w/3UsV4IvEx1TPK56z2otGJuBKM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CH2PR10MB4136.namprd10.prod.outlook.com (2603:10b6:610:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 01:43:32 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 01:43:31 +0000
Message-ID: <4738663d-338b-2458-02a7-39171fdea1c1@oracle.com>
Date:   Tue, 15 Aug 2023 07:13:15 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 00/39] 5.4.254-rc1 review
Content-Language: en-US
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
References: <20230813211704.796906808@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CH2PR10MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: 397f11b7-c409-42e9-edb0-08db9d3107e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhS7PW3MQ0xSWe2O5cbDG6JmoN4+hmHnSwRIy21YLqnX0purEoGfXD1wSRHWA13WfGPV/562wM1cK0RhEIeComXHLudrEI+j1IBygj4phsJ5LVh4RCrEWcB0FPLgyAOXZqu7h6lovYBp8FW0/1+cnPSSER06GJzB6qbKWTeTxVnXdvV5w79WkisBSb59CxT5hf5B869PrDn7zA7ZYimSwf8dwSwTT+RcAwTKtRsGb89fCCARrnDE242mC4YcxdqZRgqRIIKjMB8jD8FXaF5DVk7aO1/s9gTXJ+TF3iSihDWtvA+ZbGzsRvju+wgZ1QSmowguuGDwbslr3xmhHyOgGVEmxIQNZYKaYVRsu3rHijf4McdftrRdtFw2MWGRubRICtFj425V0WuwEIrJCZqIWi8+M0pfsZI+a+X2P0aEVCNl8ECHl2nbbvtZWqWU345/BQmY4zrjPPe1alZM2+kG16gxfE0WR/ehlyHnBBDOe30KhphMY8oTKe8aXcx9LUZ110asdJqIsWvNTUapsMpIMcPVBfe0Ey0GpEVyul3xwmNyKSUwzaQGMRoD/At7jcGs7TJ7lshonnLE4TfE99vL/GoqaVrFL6EFYpU04R3BFZ02nBaTtFvSYPIcmsYOpKNDJtMORuuBfceK9Dn+7BhSIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(366004)(136003)(39860400002)(1800799006)(186006)(451199021)(6486002)(6666004)(53546011)(6512007)(6506007)(478600001)(966005)(107886003)(2616005)(2906002)(4744005)(26005)(7416002)(54906003)(66556008)(41300700001)(316002)(66476007)(66946007)(5660300002)(8936002)(8676002)(4326008)(31696002)(38100700002)(36756003)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eldsbU5iVnFoY082dHl6N3hBWU5zTDlpeUtPN3MrYzRockxjKzA3OTZzRHNk?=
 =?utf-8?B?ZFp3UlRhdTBIRi9PdGxpRmhjdnREb2x4TXZ4TjkwbG41QkVlQ2ZRMFhqYUpx?=
 =?utf-8?B?RkJLY1pXdWxJR0pNb0todTZIVUkxbncxNmI1eDhDdWJhV1NzcmllYVlvdzJl?=
 =?utf-8?B?SkxOaHZOWWRuQmxkblBhSk1vVDZmblp6ejE3VWZCYWp2cXNyNmV5ZEhQMnMy?=
 =?utf-8?B?Yy9TODQwRnYzaGF0NDkyS0cvdFJyL0Ywek1hOTNlbWxNdU9qcmc3S01Jc0xz?=
 =?utf-8?B?L3k0UzNCaDRmTXA3cC9DL1FjRnlpejdNK3hBdFJpaFE3L0tOYW93OHBZbzJs?=
 =?utf-8?B?SDAxb1hFTWcxY08rdlpCLzNDWDJlbjZ1SC9hVDJlRWYvYkdYYUttZkJjZ0l3?=
 =?utf-8?B?U0tYK2RmZFYzSTNwTW4wdVJ2d2xIMWFnYW5sMkpuZjdNTWVlNU9TWm5OVmVa?=
 =?utf-8?B?UUVFd0hFa1hHRDVCQUZleGxWUDk1ZlhWTktGT3E5RHJ0UDNmTFNQd3NZN3dH?=
 =?utf-8?B?NXVwL25FTm95ZFpENHdUbGx5Rmw3OEFrTGR1N05FZEs2SmM1TjdEZXY0a0JD?=
 =?utf-8?B?TGpMMmpQNkVpY2JNcnpMTWVlYTNZL1gxOHA1aTBHUU02NEZxb3JsL1JRU0FC?=
 =?utf-8?B?NW9IdmJ0SW1wbTVnL2prRjZUZ0VmZkVpS1RrdzJPK0JIbjZvQ0NOZUM2TnBS?=
 =?utf-8?B?bzBWYzJkVHdwRHJmMXJWbzZzTDdGWDNLVG1rUHBWWEFWUjdiQnZmditaQjhC?=
 =?utf-8?B?MUI3SkttS3B4UjM2dGVhZzhjWGc3ZDgwQ0RlQ0V4SlUvaW8rN0RHNkJKTUZw?=
 =?utf-8?B?UUNNZnozTFVLZ1hzUUtCTHlFSFZleUxhcnFVTmQzb05iN0V6U3pNdTdmSi8z?=
 =?utf-8?B?cXZmRUVYWW9HRzVHdEhUR1MzamlNRWNjYVhBclpDdFZBdkpyUG9vdWRIUGpn?=
 =?utf-8?B?VG00cFJZbHNOalBqY2ZHbk9iTnFIb2tFZmNLdkxSQVFJTWUrSEgxZGJLd3pV?=
 =?utf-8?B?MGNuamQwVElrUk12Q2ZIcEtJY2N2eUEvenhySVI2cDQ5bnVwc1FCemJzTU4z?=
 =?utf-8?B?aGk4ZzFnNzVGUHBFZHNtT2NjZnRtR3oyd25sSmg2Slh5R1N1L1FJQWcwQ3Bz?=
 =?utf-8?B?dEFPcnd4dFBVN2xiNzF1Q1lkNkl3cHZFYTdsVTV1Zno2TWxKaklGSU1pVy9n?=
 =?utf-8?B?TzBTNWFDaVBOTUorWTdMK0xSVVpJdHpmS243cHVBK3BIbmxJMEh4YUtFMXd5?=
 =?utf-8?B?VnhCdThsWWJvd0FoRjNUYjNNVEJzM0hiVnNWUmdXS0pEbzdhbDBteGlSdTkz?=
 =?utf-8?B?MkRYdlJlSFhIb0JiVGZqNndpbHhHYlp3Vm11Mi9yK09TclhTby81alAxVlpJ?=
 =?utf-8?B?WnFLdk9tSVJhT1poRnJkdFRRL2JPU0Z3ZDNqYThybnFzU3JrbWNycjZWWGY5?=
 =?utf-8?B?ZzdVZnRzQWdUbjU2dlBKUlovUGJ4enR4SXZ4d1VTZDdUZ0Z6bld0UlRPUzkv?=
 =?utf-8?B?N3RtNitJd1BJRk5SV0RZSWhTaDZOVjRDRXdIQklzY1U3WVVhdGJsemtFV3NF?=
 =?utf-8?B?M01FZ29EazMveW1KbDI3bUZUMm9SUGVzNm12dDJaK0NleDNNUlM0WlR3L1dN?=
 =?utf-8?B?Y3pIeW1CWFdta3JSRll2dXB4ZUpUNlFDRzQxN2p3bXJ0TURPdTRJTDFhL2VV?=
 =?utf-8?B?MHFhdVJPWjhiS2FPUFhrY3FBdmpnRmxwQ29Ia1VmeFI4d0pzNDJ4WCtxMEp4?=
 =?utf-8?B?T2JjS0lScThUTWhxcGx5SWpGUllyaDNGWHZBazMreDUrdWlBdVVwUitON29a?=
 =?utf-8?B?QzhGWGZTSllGWEgyc0NzVStJN3pXcm1keWExTDNmMkJKK2lzbGdUV0Q3elhl?=
 =?utf-8?B?em9wRzdISTM4dyt1WmVVZkxzMzNLNzZhYVRzVk5LaHFXNzVzeE8waDg4NVVN?=
 =?utf-8?B?bm1EV1RpdzhFeUdiQTlwd0dPTjVYQVFSMU52bTlVYmVYcUtHMXF3azJQcUVH?=
 =?utf-8?B?NGxyV3BqTnZvZ3ltT2o1clludEl6UFlPZHVnV0xDTHdPRzJ3MXpFenZ4SERZ?=
 =?utf-8?B?R2N6bEFxYWcvYlNVbWl5RlJld2MzSFh1cDYzUEtaWit0cVhKaTJPWlowbmkz?=
 =?utf-8?B?WU5vYk0xUzBIYnhiQWpwOE53YXgrSUpwNFJIeGtFSEkyQ2p4SEorazNOelox?=
 =?utf-8?Q?4hX5EJ1N2HGGw2dGjDnyt6U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXY2c3pCVFhRNnFIQ2FjVHV0MUpMQkdmVldQQXgyMUthVjNxSnNnOHJiQWJs?=
 =?utf-8?B?enBCVWxDWE9xdjNsV2drK05iRUF2NmdHM3Z5YlA4L3dGeGFOVkQ0emxoeEhN?=
 =?utf-8?B?ZkZFSFRJRkhaalBLNlYyVWJWblBZejIxRmpoNVJoZHhPR2k4bm1DYnRPbVRp?=
 =?utf-8?B?YnZpOUpBUnB1dXU5SEZQdTlHQjFoUVdEYS8zaHNiWmxUVXdXNURUZ2VWbUtS?=
 =?utf-8?B?ajVPRXcrY1haanRNK3NHalpIdm1IaWNkNlAwUGREU0pWNzF1aWZOOHl1MkZi?=
 =?utf-8?B?bGU0Vk9tUFVyUDRBM0dzL1hwNEVJR2dES2pNdklWbUg1Z3IvTlMwRThQU0li?=
 =?utf-8?B?cWlBN3RFVkcyUmUzNUYwNzFYSXI5S3M2eSt2TVBGWksrYjZuUGhCNUk2NCtS?=
 =?utf-8?B?bEtUMDBkSHE1Zm12MUI0VitGT2VhL1ZXK2tYajl4bkVmcld4YXlwZVR1MlNj?=
 =?utf-8?B?TUt6UVBzTEdPRm1DUVRCaE9EM0JyRkVsUWpGU2dRc2VuN3BRK2czeWFOM1lB?=
 =?utf-8?B?QWJQU3RZUTVzdktCbGZBbzVyeDd4RFJTb0t0N1hCMWZtOTRoMnJNbjBBNHNs?=
 =?utf-8?B?eXRNeXdCeER2anBIdVZlcDdJdnNvLzNNaEFpL2xISE4zK1FBTzZONnN6VVBv?=
 =?utf-8?B?MkJMNm8wWU5SWXVaZUU0TjNrVS9DZkVIN1ZjSXZEUmJjUGZDOW9Wc2s0dmRW?=
 =?utf-8?B?UGQxRlhmc0ZVQXNBVlZzaGpINWNxMlpHTWRzUDBMUmk1ZE5Qb2VlZi9WV0ZR?=
 =?utf-8?B?RTVCYWJ2ZE90MlFldHJ1d2Qxbm9UYk1hMS9QYTFWeTJrK3QrY2tTK3pDeVo3?=
 =?utf-8?B?UG16ajh2amxiaEVBS29vdEh3am12Tk9VRGd4WjBTeEo3U0VqQWt0cGxWRXJQ?=
 =?utf-8?B?dW5NamxCK0REd3FtSGhvVmNGV3RCUVpva2RXYzBnRUxhSTV0RXp2bk4ybjRS?=
 =?utf-8?B?YXo4MGtVUU1vMkFZZGxWN0hSdkM0U2ZRQjMzWHJFRWFpQXhETmE1OGs1U3RY?=
 =?utf-8?B?WnFFRDhCalZQblpPNHlFVTc5VjVLaUcrSUs1NFUzSDFNdDA5R2tneStua2Q3?=
 =?utf-8?B?bGFhNmZYVkppMDlESnZLVXJ3OVl1NzdFM2VXbjBZVFRJaVVEWE0wVDdyVDcr?=
 =?utf-8?B?ZHc3Ui9oNjFWaWpYV1ZuZ2RKSkVMcmxnQWg2b1kwczM4S3pONG4wVVV3Q3Ew?=
 =?utf-8?B?OHBnMVdSS3VuT2lOeVI0YkQ4bE1RWHRBM3ZPQnprTmtCRGFxZk1WV1RuZHcy?=
 =?utf-8?B?UVh1VHRJOWxPamtqS0dhWGdITUIrZ1J4aXlRR2FvTXp6aCtIQ2VZc2RQQzVL?=
 =?utf-8?B?R3pPZWR0OUZBWXNqVnVubmRsVTkxWktMTUJBOUNiMG9tMXU1MXptdUd1UzRC?=
 =?utf-8?B?UDZkazZMTjlMSnp3WjVob3ZncXFTdW5vdWxIRlNTRGROWEZtdWFjZkhZQzUy?=
 =?utf-8?B?M2R4ZWdCZFRBR3JlQXNUaDlWaGtmKzN0bFg3c2RxZkN4UWx5SUJhQ2ZVdlYy?=
 =?utf-8?B?RXJHVjFES09QUGlWUFY2UDczZ3hjRHQxT2N2UGtjUlRXVE1OR0RBd1VWYVNI?=
 =?utf-8?Q?wffxSUFBaIgpIa6swf8Bf2bU+LoXWVo1EjA9Vk8fXj0o2x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397f11b7-c409-42e9-edb0-08db9d3107e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 01:43:31.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP3Vj4QhY9npCwBrMho1Hth3OethdmM2f5E3Q5UDndp8wPjHz2tlsMyYN9Kvpj/UVWM/zCGD9SSjrPfPQH1gpPdyJ2vHVZsxYrf5kjUKx8hHcH4s3Jh6hQBWExtVFAof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_01,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=974
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150013
X-Proofpoint-GUID: 785y5_oN2Ye57rZ5mpt3CZATOsTL1RwM
X-Proofpoint-ORIG-GUID: 785y5_oN2Ye57rZ5mpt3CZATOsTL1RwM
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

On 14/08/23 2:49 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.254 release.
> There are 39 patches in this series, all will be posted as a response
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
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.254-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
