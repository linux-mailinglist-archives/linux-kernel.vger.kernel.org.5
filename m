Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA8755F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGQJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGQJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:25:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED911715
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:25:00 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H6xPwr026695;
        Mon, 17 Jul 2023 09:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8VI7+BCkji77YFWoZDlwavtvn1irziW3+xDoAVqBhYs=;
 b=2CBhkjOz/EeGzMglp0+b0jrpjkjWZ+nU3o+fOzUXqjSQgv3HGYA/szDr82JSmlfWVght
 1So5szDuA5cHKMoL1E4eG8Nbkc2R9kwHsyb8CJ4KP1yjacHcBHQtjfABSUYBW6BaGF1t
 F6dKd7cwvCE6SQnRpfAjJYB0+KiOYLQVYPpVCEc1H5GNf+9pL4PRVqylN9L9I5RDi2wX
 xUkeBTKzuDawjP2JRkyQuHfoRGdiKb+cMbj2HKIUosRAgFswZJOLXRIC+BFGi9WzxmaS
 N5u74skxLNmy9IO565VG00Gq8UQ9p3H8vw+OdUCyHQgGrqqh5ziD/2gOVVNckhtmkhUW Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89t9n6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 09:24:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36H8sI4Z038301;
        Mon, 17 Jul 2023 09:24:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3chf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 09:24:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6BReyfXvh2ajK9G7AAAvc8RDg5TPdAmc9vcuR421ByzWlUfnagtBKpO4oyXDtkSXXP2kcFyy9CgjaAI0+FTR6GrSUwH0zFfrFMKi6qfNhB62IQLen9QAGCSQrgXZ4ZRyxLRgb1remvj5xMqZhHW8ellF3v9QcbsbUDRQX3V3npzugCt7RCi8e8/ouoKCoAQyrngdMXZEhEDCaWNGqHsffFEaR0QtTGvuii2BBaynl8TaJ5nDKZz+rwdcQwYFEwwkD4hS+GRVisdR23+GDmEvrLcX94DFlns3N6HvB4Xi4uwPUMB8kh3HJnmGm8DBEIrKPB3N0D4dA1eA/ekgjcWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VI7+BCkji77YFWoZDlwavtvn1irziW3+xDoAVqBhYs=;
 b=gK8MWMT1OBLcmNDCfJm+Ob9MXtun5edJ8BvZYSZRGUZxLF6fcEfGYdfYCmYJU97l11X5Oj+TPKzbMRD88/HHSMIWsmJZbuWaYda92/HhIj9F5PkSihHmXat3DDRbYcO2A8Gq7xu7J27p81UOJhfRWP8mt9IkcllU5FwVMBl4zz9p246+1XFKC74yNg1iJDxuo8fpiljT7E7HPpHcVhq9lAljSIpuZEXVaBTxKyDnQfMf1Bl7Hyecq3GlMLJfqon5N/f9/YIecAsuUL2f8VCaUA4ws0Ad9q9z3kYrzXW9B4oPiNiYsC6t82waw+Nj3xAlzt/TNBNql3fp2Tf+RxnrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VI7+BCkji77YFWoZDlwavtvn1irziW3+xDoAVqBhYs=;
 b=qNFOP+diqnxUcJueSYGBs46qqqSZ5kzqJd0lyg/YWnC9Jg5l5LsrTjVJma0D/u/j/83k9BSSfdee+Sx9VXuIUalS+JUMkob2wWskSyLTdBFr5xgc+k8IjnIONHI+WyLCxcV78M58ziltTnkpvEhFVzQ84mrz34aIFmLYx80jDr0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5141.namprd10.prod.outlook.com (2603:10b6:408:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 09:24:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:24:42 +0000
Message-ID: <d7f707a9-945a-bee5-2de7-dd1ff09a79e2@oracle.com>
Date:   Mon, 17 Jul 2023 10:24:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
To:     Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <ZLFXD0WNDTCU5fHp@8bytes.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZLFXD0WNDTCU5fHp@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0381.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c2aa36-c04f-4d28-7036-08db86a7a6d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYNGLj1ffPZzZFDEPzRTPi8odFScp4z8UC9TZtBeoAgHlfN3ZZyRpqxjqDrjNr7oA+zB1/cRM9bfcvs/3U8ELpEvlHDcldTamEYQYctoD0XoufPbNt3QrhiZHMtcUEwxWm9yMopBLESr3L7uZU+twQK41DwtI9GrCxDSAq/e9HLgJf1+pr1y+8n4EUV/MkRF92lYOd0vYivjm8A6jZtQPP0ohHpWw7ZLqZnxqDQ1WXaFJBSlUuQBZWyZ9O0X75IJJyia5JIepgkVqXmiyhXwwe8bnfmDi+ZDHyeEO5ykKhXkWVCjqdwwLb8ofhA6HLSX2GLtqjuyVutWhDk88M7i+Be6e90i29IQo8tpmV4Rn8VnDBHGowO8Y0H1wqcLmGkKWJ2j0ehVbmU0LAhb7qooNlQO8YRUvFdsvpCAx5mQbi6PgMa+gypwPZ+hphfNOT/pm9ye2wZuxFcATiPnfPCr9hhyQ+2BI3CucPg1uqQ5mjjIzoI7t54K+C2OEwDlFy3KJqvdrO+pyuDhbSFlvXFeFWlrorhNoyFPiMXeITG3X8NOugeupAGWISXUe++auVACY8VcroYw86cfRX/utsya3h866TWxm/Rq833yIOjWUQNXN88TH4sS3SEyALEdJbGMkL0DFj4dZwHhTuI2VfOHIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(316002)(41300700001)(83380400001)(53546011)(31686004)(186003)(6512007)(2616005)(6506007)(26005)(36916002)(6486002)(478600001)(110136005)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(31696002)(8676002)(5660300002)(8936002)(4744005)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THpmRURTMlhCOFU1bm1peWRoQ2U4WXJiM0hXWW9POGxXbDlRcFVZaTdFeDhj?=
 =?utf-8?B?SEdCWkdDdXpRd2J4QUlzZFpPc0tBVlNyRHFWWTlIKzZUQXFhNERzaHNxdHp2?=
 =?utf-8?B?Y2MwVFF5U210NU9tcmIzUXFLZDVXdE9UUUx4R3lXK05GZlRnaW9Ob3RXdmlQ?=
 =?utf-8?B?eDFUcUdFMG53NUp4SU5KWHFWNFArVVpPZFFabTlGWXNzZWNCV25KSUtwZGJu?=
 =?utf-8?B?MUlTZndoTWVwR09xamF0ZDBZV1UzNGhtQ25XcndmQTZkOElnUW1FZ1pZWFhu?=
 =?utf-8?B?WTVkTkUyb1M3UmlVL2FOQ3VralNpV25TY0FXYmdkK0VDNHptK0RESW9hWG1X?=
 =?utf-8?B?NllleUJyYk5tZnlqa2JCZk05SFhBK3NydkFyT25sdGdFTXlZSnd3N2laYWhB?=
 =?utf-8?B?MWVIYVpiZDZXV0lXQU12eXBjNWRheEF4YWx2NFhPWXZ2RVh1clJ2UnhwZHpT?=
 =?utf-8?B?UThZam4wQ1BPcE9sVWtuZ1JUZ085V3ZLMkRGaE11L3RUVFJUMnRMNzh1d0VV?=
 =?utf-8?B?WGplendac3BXWk1NWHFHeThTbFhoVGppZWlST3N6c2lSTUhvdElVMnQxYTEv?=
 =?utf-8?B?TzRkcDBwRE9va2VuVnliUVJYZktlL2ZuQmZMM3k1MVFjWndYUk9HYkRjLzNp?=
 =?utf-8?B?aWlnUVBtWHcwb3orUFhKK0JLWlI2TkFmZ2dVRHFHZmRrd3Zuc0Q4TDRManBR?=
 =?utf-8?B?YkMyNEFUOUtuQi9RSFBobjdLY29yOE9UMmk0RGhNaWpuRUVEZDdHVUM1QTFL?=
 =?utf-8?B?OG9odERDVFNQdVJmQ01kZGM4dTZPUWcrem1ZSGdna0JScjViRWpFajlZV3pQ?=
 =?utf-8?B?enJFd3pBaVpWVlFwTHA0RmJqeVBtbTNlR29uakllNEZUb1BMMjBHcE1MdDVn?=
 =?utf-8?B?MmN3cENVaXI3WmhUcnhDZERTU2laOEhRaVMrUVYzNStscEZWQ0hXN2plQmRU?=
 =?utf-8?B?UlUxMi81RHRCWWFXZGpVSXM2TEdITkk2T3owQkJmWGRiUVoxZVd4OEpCTkp3?=
 =?utf-8?B?T0I5V2c3SjRkajdIL21pZ0tEY0hDMVdIYlB6b20rREVTZXhzUDdwSUoxUXdp?=
 =?utf-8?B?OG1CWjJOV2F2N2ZXcG5ncGlkUkhUU1pwdGFjckNSSUJOdTZYTDhjUFdYT29H?=
 =?utf-8?B?bTIxSEd6Q3Q3SmdXaWJ5Z3IwQ2x4OURMRnlzd2pLVDlUR3lJVDJvU1RzalYz?=
 =?utf-8?B?RzJyTEs1UC92VmpEd1pJMVdxTkJNWTlWQjJKRGhUMGxNMFExby9XdDlHN0ZN?=
 =?utf-8?B?YmFXMGM2dUI5SmdJVElOZWN4Vjd1Y3V6eHB3VklKL3hzNXhjNkxaNEg3SW1v?=
 =?utf-8?B?S3FCK0kvK3dBb0RFTm12RzVyUGhLUk5aeWZzTjdXNXAwMFMyUll4TFN2dHVR?=
 =?utf-8?B?YjRkN0QxUTlaWEFYa09NdXJ4cUM0RG4zTFBJbzBBSHY4bGhyc1NiWnlNZUFo?=
 =?utf-8?B?UUx6Uk5NNFMwMkNCTWxYREtpYzdlbTloQ1VMMHFIblM5R3VJMTJaSEJFb0tj?=
 =?utf-8?B?RFVzR0RiL1h1STF6T3V3ZTNZT2ZZcGdiSjZGMUNaeXpBazdwaUd3R214d2k0?=
 =?utf-8?B?YWZORUwvYlFqclZkSW5PWkZ4V3ZkUldoR1NKMjhKS0JjQk15ZXFKZmZveTJi?=
 =?utf-8?B?czZPVUs4ZzNIWEhYQkhUN0xTSmV3Q25UQy9RT3k5a1MzazBNbm9KOXNKZS92?=
 =?utf-8?B?WkJxOWJaVWpnNUdocXdYWml2M1NUdzdZNmlQQWt3Y0cxOE9nUTdmSS9QNTVy?=
 =?utf-8?B?aWFOSkNjdFhSVVpsZEtpVlE4UCt5N1I4OHdqdE9hSU5VWXdYOUg5MEdKWTZJ?=
 =?utf-8?B?ZndtYlpDejFkU3BTa29odGRtLytER2d5RXpCQ3dHRVo3OUh5N3Y1d1pIM0lo?=
 =?utf-8?B?bUg1azFVN3hxZC8zYWM4NGNSdnA4N28xeGlLaEpIVGR2aFlPY3d4aUpLUHJY?=
 =?utf-8?B?NEZ2ODlONnoxNC8wVEo5eFJ5NTZuRFRqREQyNjNFYW9najdFNy9nK0d1YXZP?=
 =?utf-8?B?T2lYZnpDK3dCU0h3aDF1WTVnRVFpdGtXdTVscjdDZWFIeW91QXBpelA3aHJH?=
 =?utf-8?B?cjVYVTB0WU13N3VDMEdGSXdqTzlvUEhVQnIwZ3dySXFTR0NUOWVkWFVmWFpS?=
 =?utf-8?Q?M7XFrs7I+gxvE9Yv37pdy352D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WU9EUGo4YURwYzFMTU02Ym9vQXZxRk4xT3RLNVhxcHhCTlJHM3p0Y3ozaTEz?=
 =?utf-8?B?OHZFQkdWYVR2TFhGd3N2Ulp3Z0N4Sk5tQmgvY0l1cHY2Y3BjTUIzdUxaSUd6?=
 =?utf-8?B?M05NbHVGSHZ0UVlIUUdkcFJIYm9PeENHUXZPd2poeDJsYS9PVDdXazJaeFlh?=
 =?utf-8?B?MDZ1TVBBL2xrR1lQSEpQN1FkN2FKcDlydW5mekdDdndMU28xTmZMY25UdGlI?=
 =?utf-8?B?Z095dXBQTCsvWmNYZG1CdXZUM1lDMjA4RnhveUJCalBUcTUwUEV1aEx0Slk3?=
 =?utf-8?B?RXg4UjFzQTEzYXY0Vy9mR0tnWVpVOGNEbmtkck1BbFZSWFc3ditVRmhmUHlj?=
 =?utf-8?B?VXlxWHBVSmt3cU5SN0JiaCtWQW1TOWpWQ29VMmdBa2s4U2crNjBIYnlqc1Ir?=
 =?utf-8?B?SWVKblc0TEQ0b3MxSVp5Nnp0eGs3TU9Od3hjNEF3cXdUcmNwRkptWnNaVTRn?=
 =?utf-8?B?TERoNC9YV2NJSHhycFpzR29Gc1k3T0RCMCtxSzZ5QlZEZGkxODhjd01RTWRN?=
 =?utf-8?B?azR2Ty93S2Vld05LSUtwSS9YelgxNFU4T3lUOGMwNERBUllQYkFaVVVzOTh2?=
 =?utf-8?B?czN1RDRyVnFENTlNNzkweFNJT0lrSW9nNkgybzE2S2pZVUd2UEN4M3BPeHZN?=
 =?utf-8?B?SkRONmlucjQ2VDBDOHZVc0hEZ29GZnlyVnQ1TVg0RjB1dFZ5M1VyOHc5dXRx?=
 =?utf-8?B?MEI4aEFHV0hKNmJjRjhiTCtaTmJnS2I3Vnk0c1J1WXdxTVU5andzaUFIWWlo?=
 =?utf-8?B?YlFubCtRSXhSdW4vSldqUjZISGZGWXZ6a2JzOWhEY0hrL2FyMTA5OVZFYVdX?=
 =?utf-8?B?NnZ3Q1pCZjNYU1lFZUtvM0dRbHV4MWIyaVpTeXlDK09kUkExQnBOM0xwWFUr?=
 =?utf-8?B?c3Rha0gxSG9kVStsZnh0WXNod3QrRnNPRlVmY05mbFFqcXdRU1JIOEVIazkz?=
 =?utf-8?B?RzN4MWpDMWxuSXdJOWROMzBSclZjU0hEL00yb1pIWXVSWkprbExmWXV2SjFD?=
 =?utf-8?B?TW1qRjk1bk1WTW1aUWtGekdjREFlQk12aW9SOFZnRXBBZUh0ZEQvSUk3MmVn?=
 =?utf-8?B?Q09xVUNQY3A1dFAydUdObEl0VmJXVnE0a2xkQzU4UWZGSy9HVTkwQ0lnSU1R?=
 =?utf-8?B?cTZvQjJQMzlpZXZTU3FEdU1ZRnVzQXNPZ1JQTFRZY2xOMlZyWXpLaG5PaWRx?=
 =?utf-8?B?WEl1TkY3c3ZoOFhYNi9xeXd3bmZJL1BYM3FMOERTQVJPVTBZYW1VMnM3ZmV4?=
 =?utf-8?Q?B00loAE4Y0a4gJc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c2aa36-c04f-4d28-7036-08db86a7a6d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:24:42.1638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+jb7CZwfRwzXMcpq3RiEuVYMJxD6GTvJPD7wNppF7/wCYcaFhLU4pdar/HUpR/ZX0Bi3+UQ0xh8EdKEise3HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_07,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=980
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170085
X-Proofpoint-ORIG-GUID: cCEd_FwXIgrLtimxLGWG5Bs1HjpcLfyd
X-Proofpoint-GUID: cCEd_FwXIgrLtimxLGWG5Bs1HjpcLfyd
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 15:09, Joerg Roedel wrote:
> On Thu, Apr 13, 2023 at 02:40:25PM +0100, Robin Murphy wrote:
>> To that end, implement a flag to refine the SAC business into a
>> per-device policy that can automatically get itself out of the way if
>> and when it stops being useful.
> It is summer time and it may be the heat, but I am in a brave mood and
> decided to give this a shoot. I applied it to the core branch and will
> push it to linux-next for testing.

Cool.

@Robin, I think that you sent an incremental change to this original 
patch in this same thread. The issue which it solved was that we saw 
dev_notice() logs many times. I glanced at linux-next and Joerg does not 
seem to have included that.

Thanks,
John
