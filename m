Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A9D75E09B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjGWJKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:10:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E712D;
        Sun, 23 Jul 2023 02:10:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36N6v2aU003381;
        Sun, 23 Jul 2023 09:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/imr3Y499FOQd8u+neTqVTfr7IkaCKPkCWUu/FjQfgY=;
 b=HjyFtRlWQRdaDCVe6Dcdg8yU0Uxn7MBSMqGnNGIGtcs7/qqz8FyOyKdyHR7U4Yom/LBg
 YNtp0M68WRluoNjdwocwlNiOBhdrMm9A1plJBbDK/90NHEfYw6wWI8oUR/g6CcXR/Vc5
 epRBUI9BXGQLEM3O172hRb+PhlaNbOvibKe7RrNgiGSc9EzkpXvoMm5vBfb1zCN0sjbP
 zdfCvKLVXb/g98CHsrmdQMmWO7gzuH64hpjrDP7cJ0RgpxKFUEEnQok+Apsgj+knEL+e
 eqDcjI0XSFyHWixBSdkycQqJN1wVM8OfM/eV0g3zBhJpaihb3sZsK9wiJJ1O9BUUlXEK kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuh3ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 09:09:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36N5Vww3028693;
        Sun, 23 Jul 2023 09:09:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j2myu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 09:09:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gib3ESbeL38y3sGL9V2+C/5t7iJmkQ1Z1p7WrVcFGr/pEmIofv2wkPxVYTeX7Bmige8AKgWznr4LgHM1ysR1owzC0vDaFitaIk7SuosOS9z7qyNRlIDAPTN4knUrmBkLiVbDG1aLqiIGvSgepj8HK92u3IavjmnWESg4Zx8vCzkIVE0Tw+gHjDecshPEWvPkK5sYeFU5J0mQLKSTie66Ey2wNqqFioEd+/NRefZ6Kh3pjkQhjBgys4l0vvoLCwxMlOgktc6p1zkKInLJoBxU7DfDDR/Zp37T74ebqlYL6UQO0CPlT4jaPJ9wzpVyEiLT+OyeNHoR6QsljTbe3YcVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/imr3Y499FOQd8u+neTqVTfr7IkaCKPkCWUu/FjQfgY=;
 b=JdgIl1CiJo86lfvbQXLGiQDDE5/RDnpTqOJVV8AD4bkNpoCibha2uO/1ogI+43nhVGbbe3Cz0fmYF942A39om1sYsLuwGJhNScH1QA3ZAPKxU/yiEub1qN8sl+SA4Zi6YZDTjSwEB9VvKn7KrHJjkElrHGmPXZ1zexFjWFpxM71q2x39drSDJGMY8D+b9m2P3X202hRkcAkF1Lrtv9SfatjDkNH++P3ARoNBSn3KadkInKekpPhgHwI5kALU8hrGXXz4y/L9iP7oY8+yoo9R8bkyALrCOTulHNs2jj6MWFMCZhoczqRUjjo0Ri1j6enJidbB6B1Et5pkPxSjA+ENZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/imr3Y499FOQd8u+neTqVTfr7IkaCKPkCWUu/FjQfgY=;
 b=C6Ft+mBraE85TheoueJWKN2o/+xVlJ7thluZnEXnslDiluWpLrLc4W/IlVmioYyc0FR5nIlbOCrtSwIJj8R670sN7609sKHVEcPAyj6hEMT4Gggz+rjqpWREx1wj2RZltB81riVEup0SiX75htYBsQ5f717uMVXm4GDg9VkglbY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CO6PR10MB5554.namprd10.prod.outlook.com (2603:10b6:303:141::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sun, 23 Jul
 2023 09:09:19 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 09:09:19 +0000
Message-ID: <f0064586-bf08-3062-3150-7ac93616aab0@oracle.com>
Date:   Sun, 23 Jul 2023 14:39:05 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/532] 5.15.121-rc1 review
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
References: <20230721160614.695323302@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CO6PR10MB5554:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbede95-8abd-4567-17c1-08db8b5c7f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9lOIyEk9NtNamhXvfPD9PZ3MU/RcdxQeTLEPVSf4ngwKxjcKGAPjOjHyeFlfPc4cDxUEiNguttwp/FwqzPwEDRROSCcUCQsXhkrWp9MRg6amOGIg3OEoknPFPmZ4Ogf5nvXDXXxPzxZUBkYM8o890ZQVoNwh9MN+DkXn3gfEFWXhcZP7mbmB8cKWKBwhGRKqts7DAx1yHmTfjlVipJuu/gaYortzJYcLgQKer6R7nOLfgh05j5mqBsd8pceX7lMposRtLuJVApQoj/DFTtKharpxmzKgpHUlu8T4Sz/ctGnrUl86hsMbEdfL2u1HpTX6nGeDxg87f4d6OQ4BLKFzK7Fd1o0hC5ubwo5vhLm1ggLpwS5Sy/2LnEqVyiwdK9ZtOk/V/AGgoau6cdywylJ7evzDQ5Llq5QB3bQCiuwPi4fG0tyjgk2PyEzdPpeQuvr6bShLgkLZMpp8XZFY1+s7sxgLPofXkmOkvADITdFX1joapQ03AdlM5Nw7S8PtFP2MnwlhPScXbJiErgTkUst8e0RDJB1zphNArWUuSWu7Zgp6qRhHh2hAHbXwB6vmQ/nV+FY5M7u+ec0bZef1WKUsX2dgpeZFMNr43Lnj8tInJIFQ5WmxVRm0seuqtq8Q6vyjwc/nTfLoLfbcN46H0CbaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(38100700002)(36756003)(86362001)(31696002)(54906003)(4744005)(478600001)(2906002)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(966005)(31686004)(8936002)(5660300002)(7416002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(53546011)(107886003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm4rM1JtbDZPQ2xGaGJIVlBXVG8wMDY5eHBOTWc3VFhJQU9zbElja3o0cHVI?=
 =?utf-8?B?YWtKVEZvVFlNdk8zTTdoT2x5UWJXS3JiOVBXVGE0OGdvTi8zL2ZMUGdWcnMw?=
 =?utf-8?B?UnEwTGhhdmE2ZVZxWTM0dEErK1VNZlNreWZHMVpEN1l4dFc2MFE0UVNRUXBG?=
 =?utf-8?B?VTFTMkkzbms0VFlOSGxQRW9CdS8wVTFPaG9yaGc2ZWN6TyswV2wwemw5enAx?=
 =?utf-8?B?bVpSNTFyV0VZVVc2TDZ2NEMzSFdXTHdmNVNzbm91aUJoWFlQTGxVbFdkWWtP?=
 =?utf-8?B?R05XVVNKQkVjZW4yRytHeXJISlhQeHJqTHFGK1RiblQyWUtMNnpZdmVkZTI1?=
 =?utf-8?B?SkVTY0dEOGU5ckVMYUtiT1VkL3I5cXUwYng5Unh2ejBkZzJXS1hxV2FnSkY2?=
 =?utf-8?B?R3FTT3NpaVRVdHdqaGdURW9oMEUyM1lwV2JXOU95QnNaOCszU3F3M1QvNmxH?=
 =?utf-8?B?ZnhDNllHb3Qva3NTTEc2RHJaWFd2U3hFcllpWmVMbWYwc1RRelVtSlk3bzRL?=
 =?utf-8?B?b0UxS0VGbkVpUkdOcmo5cjJvY25TeHBLMUdTMEhETlpzTzRyWFVTVmlRV29O?=
 =?utf-8?B?cEt5b21sNTFXSWR3ZHI5N3kyeENQRXdwMVhDUkNPVVk5cHVvcytGeGZoMDZC?=
 =?utf-8?B?TXJPeXdxNC90NmVFWHl3WnowMlJ6NjlIV0N3ZFZqSTNpNEZVVTN2cUJrbktz?=
 =?utf-8?B?ci9mMVZ6VWtoOUphZWVCQnJEWnRieGl1T1kyQXlqa0F0MmpmWnBCUlRBTWFV?=
 =?utf-8?B?SkVuMkZBa2lzUXVkTkw5Qlh4dStPL2tYcVhOVjQrU0ZOenhuNmhWaXRveWNz?=
 =?utf-8?B?WCtPenVCYWVMQVhIOFlxdjVLT3VSNXMrQUlhN3JjK2VhRDFtK1VFMk9jNVdB?=
 =?utf-8?B?am9VQjBjejVHRFFnRk12cVpIZkk3TnduMUY5dTFNdkUxWEl2b3RtdUhiSFVm?=
 =?utf-8?B?dFlFTHJOM0NlZjlkekxrb2Nkd3RJVGV6TmtvQndXZS9PNkVCTTVWenZoeU5W?=
 =?utf-8?B?WmVNWEVMYlV4L0VkY2RObXlEZXF6RTgzOVJTcUg4KzBURjdoRjhRZDVFWHUz?=
 =?utf-8?B?OGJLMm1SdnFNTk5wckZNNm5HZ2d1U0RTalVLS3BDbWNzd0FWZVF2WDRPNEZX?=
 =?utf-8?B?eit6c1ZkMklpQWs2TXkxRWl3VDhLZmFJS1NWL3I2SG5jSVZOL2YzVFlFM1N4?=
 =?utf-8?B?aHdHQ0xmN0dHNzkwZldwVUhReUttMDRCZ2lzL0w1bnJodEJOeERQNlp5YnZB?=
 =?utf-8?B?bGo2QkJ1RHBTakJSaTBtQXJlMEx6MjhaRWNoczlUMHB0QlpTYTVpd0crS05h?=
 =?utf-8?B?aE9ZZXVDa0lDV0liUWc2Wm1OczdHOXNFeVllcXowWEtoZmIxNzk5UFh1Ukdz?=
 =?utf-8?B?Q2Z2QVJBZHdNWnJZaTNDZEFhUitRdW1wV0E1SFBveUplQ3hsZ3VhOFUvVDJi?=
 =?utf-8?B?NnNpczd3SHBNbGZkVXNQeWNQUDE4RXlId3BkYmE0dFBlM3RqMUdITHpxMGNh?=
 =?utf-8?B?SjRScGwwSmZjd0hETWw3QVNjOGFEdlFMTkhNLzNMWHdJNkx5SUx2Y0tpM3Zi?=
 =?utf-8?B?REJtcE5OZmpRcytkdm5ESWh0bXB5STlDVy9RTUE4RkEyMmMvUllIM1NrY3ZH?=
 =?utf-8?B?TDJOUVd2ZHFiQ0lQNThFdFdQWWlsdXViNDExNzJGU0Y2YkZzUjREanF5b0gw?=
 =?utf-8?B?eHVCUmtPYzFSM2RiM3JlS1d6QnZYK25hNllKc0gxOUxyMHN0eHlMU09jTTNh?=
 =?utf-8?B?aE5mL0pidk9tZEYydDNUZlg0b1VJSGVCY1VHNXBhMnBYbzhWSzdueXY1OW1W?=
 =?utf-8?B?WlZhVHVZSGptSjlFNXFlQklCQVdwM2RId2ZkdWV3elJqQUVFNTRCbmNKWU9F?=
 =?utf-8?B?dEVwKzQ0dWovbE1BcSt6dE5nLzhLRmtRRFhCeTdMU2Fpck1UM1VxQTdLM3B4?=
 =?utf-8?B?K1ROSEdVcStpQnlidnFwaW1uWmFHdWF1K0Z6b0htL0c3eW42MC92ZklSamg3?=
 =?utf-8?B?K2x3R2NIMVhrZGROQ0hNMWlVakpjWVZTYjQxRWY2cmNSdVBwQkthdGNlWTdS?=
 =?utf-8?B?SkJPRGJocVVnM05iTHRRc1VRRjZZdFZmOFdYK2s5Ky9nRUZxOWx3bjA4bXlM?=
 =?utf-8?B?dXZWWkNvMGN1MXZuRVBteWNmWUNqUmsyd3lJM3AxVDlLR1JWYkZucy81R25x?=
 =?utf-8?Q?fLR7kLe/s37Sejaig4JAtsg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFJOeEtVVHBZWTV2eU5tK0tVa3pObk1SRFBtWC9EL08yNkdNT1c5ODZkMTlY?=
 =?utf-8?B?TVZGdHpYOXZ6OEY2b1cyMG5jWmY3YWdKUmNVY3BsS0tGYUdJN1piUzNHRHdY?=
 =?utf-8?B?SUQyOTkxbEFlOEpmdlZSRCtla0tiOWMybVpOd1pJVG5CU3BOdk94amc4K3lZ?=
 =?utf-8?B?OE5PMmtDSDNkSGk1OXNXMnArd3JRR201YUF4aG4vNmZhSFVleVVjV0tWVkd6?=
 =?utf-8?B?WU1zWmU0Q25pbnF1a2pmeWVlWWloeEVNajQxSjQ4bmpGWGJtdUdQUWtQTVBv?=
 =?utf-8?B?TzFNVEt3UVpnMGRiSEFPUlB2WXMwUTFiODFCNGsrcXdzQkc2WmR0Qk1Ya1c1?=
 =?utf-8?B?Nm1JcERhQU1DSDlZSkp0YThjMjVONFJQRzNlVVRvYzNrd2IvQlZPeVhJNFF0?=
 =?utf-8?B?TXVDV01VN05iVFpEd3BMRzMxSUt0bzQ5b0xUQW8vSDIvUkVOZVI3UHVKanNI?=
 =?utf-8?B?R2NrN2x2UUFJU2I3N0tDMm45MGllTE5obzlZRnZoM1cxRWt4dmE4WFZuUklM?=
 =?utf-8?B?bjRHMVpuL0hOdElQaGVBZlJ6bUxTK1JVUUVIYWdZc2lzMWxkWHNVOVBjVWxm?=
 =?utf-8?B?amFQOVpMeE5LbWtOcnVMQWVJZHZIL2l5TmNMQjB4WklqSzlNb1E3R3ltZ1Q3?=
 =?utf-8?B?QTJVLzRnMjkvVkZFZTZKQkJVVnBBNFV0Y3c4ZGNnYXQrb3NxVFFNdTMwQnNp?=
 =?utf-8?B?RmlTZjJxTXN1NVNDbXRvcGp1MjJyWm85RTVMcjllNkZmQjRYdGpuVW1ja3la?=
 =?utf-8?B?em1nc083RmZRWkd0Slg0T2JEbGNuNXloQWwvdnlXQzJTWndBai90ZTRPZTJi?=
 =?utf-8?B?cHBBa0NZcUVST3JrOU8zNE5qOE5UYmo0Z1RtcVNrQy9neXRBUkgwdFJadTJv?=
 =?utf-8?B?T2Vwa05hYmlXYVViUTVqQjRHRm5ZRWZCamltcWtXUzJ6TC9vL0w4djdkTUlx?=
 =?utf-8?B?b3ZVcENvcmFuY2pQZmZnZzh6K3ljaUFrbkxCV0dRZWRIeHovVTdYdHR0MVFw?=
 =?utf-8?B?dzZMZWExdXprd3YrS2g5TWw4aWdySEdBU3NleVR0R1I2bGx2K0JzQk16WS9U?=
 =?utf-8?B?OVFhVVExRCtjSHhidmZ6S3ZmKzdpZzN6cG1WYTlHTnoyanhBcXF6bXpHWWtz?=
 =?utf-8?B?VzZDWTl5R3QwRGRUYnlHaURwYXBTek5sZkV0OWlEbFhPelNNK3d0WXk4RGQz?=
 =?utf-8?B?M3NqR3VNM0ZCbHlxcUNNZUF6UTc4SHFuU0xnMGRGaFFIOGp0RTZjTHovdnNQ?=
 =?utf-8?B?eWhzWVVWdk9rOU91OVEvK0RDMWNhOCt2Z1UzcVlMS21rUk1CNll4UEoyMlE5?=
 =?utf-8?B?WExOOS91M3hVWFJVVXFVUXRpVUlHcWVNYjVyc3ZuMUpGSUlncHVzcWxYZWw5?=
 =?utf-8?B?c1QyRHZmaEMzK1BHdjdBbW9xd29yZ2tZcDE4UVBQVGpGMUN5R1B2VHdibEx6?=
 =?utf-8?B?YmR4WE1yR29OWXZjTUwyMUtpUlkwdG9nVjNmbmhtNjh5NWtMaXhseURqZlc2?=
 =?utf-8?B?dllVOHRrbjRUL3kyVXZQUlNVQnFZdHl2UDd3VTZIeEpTeDJYUzFhL3F2dWRZ?=
 =?utf-8?Q?BRU0b97Gai0hovs4B74pJ72ydcX6F04ipnF60z6OEL+bkN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbede95-8abd-4567-17c1-08db8b5c7f27
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 09:09:19.2943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yv6jBWCoNSd/BSfCRWM2xBD2t7CV/YiqppEsJ/PlsR0RM10UczIm71ivkta6w6PlYsHqGGiCMx5oSQ+vWWDNHZ886Bu8tQ2ihuLvBIgZAph89ONvJ/+tHgypLdA4mlSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_02,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=979 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230083
X-Proofpoint-ORIG-GUID: 2yiQK2A3kjv0bleysNJuUOjygFFHuNQs
X-Proofpoint-GUID: 2yiQK2A3kjv0bleysNJuUOjygFFHuNQs
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 21/07/23 9:28 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.121 release.
> There are 532 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:40 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
