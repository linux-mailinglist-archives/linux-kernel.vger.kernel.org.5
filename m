Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5901780EE32
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjLLN64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjLLN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:58:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65BDED;
        Tue, 12 Dec 2023 05:58:59 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDimRP007195;
        Tue, 12 Dec 2023 13:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=p+oesurPQ/v0oGKHcY0quys1VFYjhD+si/r3sQ8d8Pk=;
 b=L1te3NG0jQpYMgXGryLSb94N2xTDVM7LjqQ47Q/XKd8R1s4oLy9sH881TTf+sxpPkS9C
 RfBQaeM05OgVDiGD7wxImO0iQH5mhYXimA/Tcl0AcKSxhDVTNJBe3xdQ/lFrEXHAufVa
 6JrIYAKCx0qUJaKYiY0DVjOD6cfARVbJnZHAljfR3raiNP0D/TmSQL+4/pvgiDF/iOvR
 vjhSjh87fAhXG3PG6cHNmQPPobrP6NLPUDMNykNKPDk0EXHarvn4s7sOuwH4VM7B5Ogp
 ivZsAqoI7ke41MFfDNzb0p+XEz9c7kPEODPSrX4epEY7XC+s5SBFuxxF4X9Coa1RTEoy qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kxvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 13:58:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCCWQhn012796;
        Tue, 12 Dec 2023 13:58:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6m8s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 13:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+nWVPRcH+mgHwRnnqqWQ2YI8hzJZvh54h0AkHe1OjZCEXZIEIJ3IfohV2BY0WeEaYmZYXfUZ+Mvx4Ig6oTr5Bu2b8ZEq/cbX6fuDSEVywhcuBGfKxIhVOKLfF1384viWHnYfyEZ2gAWR12ELPkZpOU/Y6e4QLNczj1reBIzZ+zM+GQ/Q6cWeOktMZUn6Cb/b+yO3LC8HrMmK8OLbqv6OhhkZKnto9akMUnBHfoo06hTSIMLfMXz+0y99th07Pf2XxP6lIdab6wL+Au6W2OmkcV6iTex/LkU4KnOpBECGkGpTIQ/Qk9x89XnyucEfY6YyMCgK3jEjfIfbwk+K07DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+oesurPQ/v0oGKHcY0quys1VFYjhD+si/r3sQ8d8Pk=;
 b=GpVUXMbjeEdRCS2FWHsFoYFnI5a3Hmk/DKpICp/kbNnej7aeiQmzdnPzpP9r6UcTUhiyYO8ghZM3fuWbBqkeTqr1yoVCAWnzTM6/1ceUL4XqNuy102e4ZbYptDebs8eOk3xe1VitWR7cRCEc0V2On5sr+tvpk5mHcEwXJVy9re/PCFAd6SGZIdyWbUL0OsSpwGnpYkFHdc0EqWz9eGbTfHczDZM3MQlyMi+CrIYFDNnq9XuCN0MPoS45kVD8cPzlF3/89KU7EQlPP2W0/wuofGrpvHKfYHIQMjf85CyqmLoWcFV8eLr9j2OUDCD020TV7d45vvrb2KBtDXquwFYT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+oesurPQ/v0oGKHcY0quys1VFYjhD+si/r3sQ8d8Pk=;
 b=lqIBgU0U7KlcmwEI5T3d93Pg8xzJnxoDYO96KQkoXF+eS2zPZg6VdjZMYxPRgLKwcj3Ta96+TlecNmgTdx5xrtXpkpL9rBaC/yZUbdDU2xDWiKY0ucc99izarpkClePssHKTKv9L5YSIqEddkXXnsfeK4unqojp6xvlEsXxoPEU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV8PR10MB7824.namprd10.prod.outlook.com (2603:10b6:408:1e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 13:58:23 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 13:58:23 +0000
Message-ID: <a31ad820-4054-40db-8aef-aa78106e0243@oracle.com>
Date:   Tue, 12 Dec 2023 19:28:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/24] 4.14.333-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231212120146.831816822@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231212120146.831816822@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV8PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0069a274-313c-442e-339a-08dbfb1a67e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYPom9Qde9Ln6vAtOrzcqTFmq2+spYOQe8T3wooQHo47FushkAu5KE5zGMheZGhXCrrmo9LCEjVUjCJXssz6JDQ/ooYuEYv7K8BDWumMru2sLvF5yNijraFzMvelAIVI7srnlWQvH9DURPk0YY4ER+RSHFoDsseQAFmHAz+zkI48o9X/AxR2+eKUg9mh87LQ/ogWcYHGThnpfGJ8EyN2BYfGtnyvXz7WQpesbvNR1yHMgxwUOVv4y04CjYgZQwOrOKPQmt2EcLkCALyZjvJkpepyW6DV29Cjbuqn/6GbzO54SPFNQp7NVnAdxsL/JTH1ShVl731h8OMS2419iw5scLzCBnVMf0WqYGWN4Br5HjpIpEfo+yj59fwP3iZXAGxwrWf8sUJZR83VH7m8F8pZjCCHJHF+XLhHVsw36g9z2Wipy7AhGR/JQr2Eqe/GHspJ9PF9bgn3WInulRKO0FP/Qo3lngo+OJmKBRN6/HiMX/hq0F23ZLC9i/7+ZiIFaL8QLVn3P0NtQqwsOEf91tsMLeZNHTDLTKekrjc4vnETpdUi005QIABA/AHN6lBAFfCmYdRhRBxiXqDglZdokqVJW6z70kpU62M0dGSzn3ei8AhzGFNPpnAJgLKpHP/nnvWB+e3nmzQ6iKYp5zFZT5MpPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(5660300002)(4744005)(4326008)(8676002)(8936002)(7416002)(2906002)(316002)(66476007)(54906003)(66556008)(66946007)(53546011)(966005)(6486002)(2616005)(107886003)(41300700001)(6512007)(478600001)(36756003)(6666004)(26005)(6506007)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?by9KYUhkTVFCSFh4cW1vNHlHTzRYQ081SFpxR1M3b0o1R2pwZit0Q1pLYk11?=
 =?utf-8?B?K2hVNWZGMVJXQkxnYjh3cTNHSlVKUkZZakFZVTk4NlRHSEFCL3pJTWhSSTZY?=
 =?utf-8?B?TG8rSVN4TTROd3lsRWRxaGhQQWR1dk5CZ3BZNHpVckRWMjBLWWtoOVF5WVIv?=
 =?utf-8?B?WDM2aGJVZHlMUGluM3dWdkZSbXlwRWYzSjdibGlxTVF3ZityUXFDZng3QlM4?=
 =?utf-8?B?WmtocDIycDg1RTg3UzZEcng3cWVNa1RsdEk1TnF3RU1CMXphSUppZE9GVk9Q?=
 =?utf-8?B?UjkwLzNaYzRFampRZ2FvcjZka1BmTS9nNkluQ1ZoV3dHRDB3eUxIeXJNT3VZ?=
 =?utf-8?B?UDZZcGkwOUx4bGJlejh3bUludlRLQjlTZThXQU80RzFxaFpreFVSS0FaTXRP?=
 =?utf-8?B?SjdXWnBydXNHVWpOZnA3dENneDhvTmlKcm1vZWxkY3ZjbHRVaGxHQ0JNTHMv?=
 =?utf-8?B?UmlNdGxDanozTFlmUEJNbkVzcDdkeDlOZE9mVXc5MFdLRjJBVlkvekd6VW43?=
 =?utf-8?B?ZGdPUkhmNW5iRmoraWlaRUlHOE0xb0g3MXg4UTFiaEVyS2tUaU5KdHFxY1lT?=
 =?utf-8?B?NUh5a1luRGY2QW5ZQXpZZmlZa3RlUFliVGx2RkMyczlmQVJXN2dKY2FDdjJR?=
 =?utf-8?B?b1pJWDlDRk9EL3VZM0dlR3BCWGgrUGt0UTNvVnRJQWNxdXVvNjFsZ0tVL2lr?=
 =?utf-8?B?OGdWeU40dlVLa2tmQkFhaC9XK3U0Y1VWM002cEpCMUJFbVU2VVZIcHNFd2hI?=
 =?utf-8?B?M2NQTVFSZlVoMElqSTExcGZla21RUWJpVGtCYVd1RTU0cjB0N3dXVHVqZ2FI?=
 =?utf-8?B?bWwyS3F3Z1FaL2YyM3A5QStZODJrUVZkTG1rUFdVSWZWTWl4Y3lnaXdva21i?=
 =?utf-8?B?enhWc1RKeUVYV3Y0WWt6RWpvM1kvb0U5Q040Q1Q2eklpRENmbk9zK1FNMkx3?=
 =?utf-8?B?M2FjOGZHQTJHeUZ6MWJyUndlbElxelFHSjNUUHlpQU5TMHFNazIzOEJOVkp5?=
 =?utf-8?B?bkdsM3V6SnFPcGx4WE1MeW1GbllWc1ZzYlN0OGtpOEZFM3JLL3dlUjMrUkpC?=
 =?utf-8?B?Y29rYlFseXB6VWRDVFVMcDVicXNGeTlpNDgyU1U1a1ZZY3JySWVCbzVRMG5l?=
 =?utf-8?B?WXJwd2NYQnBBOHNQSzJ3QU1zQkVRRlpHZ1FubG1nZ0NCeUNjNHdpZXgxaXlL?=
 =?utf-8?B?VjdIbkZBdDZtK3lmZDArS01QcmI2VUhNZjRBa0I0MUg1b2pjcWhrSTl6VlVE?=
 =?utf-8?B?Z3VhYlROWXB0MTlPNjJOUVNaSDYra2Y4Y1NhcmpXMkN2dnFoazR6c3diSEJC?=
 =?utf-8?B?Y1h0d1lVNVFBSG5DU1pDb1RLWCttY3pVOHh1b01Gd0JMa0dCenpDTXZqYVZq?=
 =?utf-8?B?WkxraFpJTjQ4ZmtKNUdyRHd1RFZ6Q1ExeXpoSDUycjU5ZmNVbWlST3c0RUVj?=
 =?utf-8?B?NUtqbHordlZCbWF6WU93NGlObmtpdmtxK1ZtdldkVVF3Y3lmaUZITktWQnAy?=
 =?utf-8?B?RTBBcUswZGNhbm5ac21FZDhmNmVTRWdnQnZaSDZhNmVFUlRsYjZnRDVJS2FD?=
 =?utf-8?B?L3R6cXRCVVl6MStIZWMrREpJa0lHVkJzazFtaC9aMkUrZkdaa1o3WGQrMnA5?=
 =?utf-8?B?YWNXdjg2YUtaL3hNT1NaQTJqdDhmZWFpWGxNdE9CZWJlZ294cWUvV2FXd05D?=
 =?utf-8?B?TVAwN2UzVjd0dkxTdHY4c1U3aVBpSmdNUXVGN2wwMWVXRnNDNC9KRHNwQmtj?=
 =?utf-8?B?akNKMW90blR1T0N6YytHTnlLSDZnc3g1TlhKOXcwWUU3M0pQTXhNYmtCaVl3?=
 =?utf-8?B?NHVyT05uVmdPRmpvUWlVc054TVZPeU1KRlZCSVF6TzJMUzBoR0VqRTlvYUky?=
 =?utf-8?B?Z2NEMVhDTk5qaGREb2ZaNGpBbWc0MENuZjVYRmNYN2Z5SWJubGFYcVd1dk5C?=
 =?utf-8?B?YnBoWmlwNlljam1XRHo5THdIOHlEa0hIVXFhbUJoTU1CVzVzR0NkSTRYOWZN?=
 =?utf-8?B?UDdBdTdRVlJFc0I2YnVmdEU1ZkRFZzA2T2xGUUZGbDFPK3BRbnB4dmVyRlNz?=
 =?utf-8?B?OTVKTjZiVFk5UXFtcHUvY01xVk16L0lzSzkxb1BUTGt6cmpNc0t4Y2FENkx4?=
 =?utf-8?B?bVhBa05OekhUTFF6MDkwdHdraW9XYTEwSXl5M0Nic3hlMWVpMGNFSUZJYTBm?=
 =?utf-8?Q?9tPL7A0txdDepPMX9XT5UwA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UW1lUThGSG5mbEQyZXR3Y2FlWldJeFZsNVhPRVpFdE5TazFGK1l3Y0lPaVNt?=
 =?utf-8?B?dXY2bmtROHpmWG12UW54K00yYjUyMVVadzVEQ3E0ZVk3WWJBSW4xREdmWERr?=
 =?utf-8?B?SG5ScTdPdFpVaDJUYXlwN1RrenNPWjloL25YR0REMUZ0eUtybC9iSTlMcWwr?=
 =?utf-8?B?bE8rdllaeW1NSUo0SHRocVhQSTgrbWZ4aGlycG1LMWtkVXpJK1dpTHpxTGlG?=
 =?utf-8?B?ZU5xY1RWZVZNUjJFWU5UWlRNSjVCSmlkcEJEaDBUR2dJNHBJWmd2THhiUm5x?=
 =?utf-8?B?QU00UEEwcDF1RGViMjEvckFtQjVTMnppNmIzRzR6akFsaUZybElrZE45eGJ1?=
 =?utf-8?B?WlgrYWRQbkNiTjRwVUl5MmNTWlo4dXluSXdnMDIvaTB4bWhQVFIzanFINFE5?=
 =?utf-8?B?cEwxL2xhL3NxRzRsM3FFOU9ULzBYeXkvcXRwWmkxdFdoVDJPT0FOSUZZSmJz?=
 =?utf-8?B?VjdXaGRDSjFlN0Fnci84dWxLcVlwRC9YS09YaEFGdmRXbFovekZDL0FBVXhi?=
 =?utf-8?B?T241QXJGOERzTzZ2dTJyWHd5WllTMks2RC9BS00xRERJU3lhVUx0YXo3NUxh?=
 =?utf-8?B?TzVVcUIrbFNxT0R4TFRySEs0bWtoeGhpWmJFUjRyU21TYVdBcUVyVDdVODA5?=
 =?utf-8?B?MmFtSE9iSGlybThSN3JGRTBKQnY5c1J1WDZOb0ZNV2NJSEVLL1FsM3hhOXkr?=
 =?utf-8?B?UWpycGhURk9WODNQSXp5Ykpkd0hIbjF6dnRmZUNOczBORExoOXMrbkpzb0tT?=
 =?utf-8?B?d3NOTUhrUnJoUGpFeGRRMVAwWVpTT1c2R3g5UVVvUUtSampuRWpWMDRGNGtw?=
 =?utf-8?B?ZTVJZ0hsMW05NzhseDlEcTFWdE1NTmFNODdnZmtCOXorYVBlOTNOZDJKN2tQ?=
 =?utf-8?B?ank5dzl1dU5RRWw3ZFE4WTJpT1I0RTVNclZJbCtKVDhuZHBkOGxKL3g2aGdY?=
 =?utf-8?B?UEFmQWRJMVhCSGxmQmtmZDZIT2twNTNScWJ1Vm02U3o5ekdQYmZteVVsRkZH?=
 =?utf-8?B?ejhMM0N2ZXVvY3ZqbzlqaVNuMVpCTU5rWjFKZnhjUEo3MEo1Z010d1lUd3Ry?=
 =?utf-8?B?N1BGZkhiNEU3aisrUzZTUHdNYW9ETTF2OXA4Y3pNN29rWXcrRzZWZTZ1YU1t?=
 =?utf-8?B?aWhnV0hpTTUxeTdzSlluV0FZTjdCY3cydERZem5CS0V3UHRYWjJnOW12UjVa?=
 =?utf-8?B?dGk1ckFWU3FldHdNbGpsc2tUUGpmcXRNVUlET01SbjdSYThZL3pLMWdmc1lm?=
 =?utf-8?B?YUpEQjY5ZHJER1NOSWlYT3d3OUpndDNjRFNJMmUvWkgyOWFUbkdxbDRGcDE1?=
 =?utf-8?B?TUJrRTJsUCtNOCtwdDV6UEdvV2pTZldiaFoxYXlpZ1hXTVZtOVRZMDBxMTFB?=
 =?utf-8?B?M2xqa3plNllIU0hNczFXaloyK1ZXN2toMFR6M1c0L3hnbmhTWUM0S2pRRzNN?=
 =?utf-8?B?VmFKVkJQckgzZkxjZXNTajlQZzVCQ2NnakFuc2t0YzI2MlRabXkrc1VLWVVw?=
 =?utf-8?B?Y0h2dG1IaWxlWEdlc0xPVGVkaWhPZjJRRnZiL0Mxdi9PeFRvTmZkRkF3WlIz?=
 =?utf-8?Q?m81Sosoj8PTIywuBl2Tf7Zry1NuBwSYOQDGTC4CmJiwFtR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0069a274-313c-442e-339a-08dbfb1a67e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 13:58:23.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXTlr8GCLGgaPSSw/Jm+ja7jm3YcvBhTuzcCJ8crVPLKQpc9w6NpfRoOxnHRVw0KbaI8D8wLVzuqK4VW3XHyTPUYc6YIBaXzT3iMNs01DgZN2Un2a7Lr0lTqU09jIIMq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_07,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120107
X-Proofpoint-ORIG-GUID: 2QuojJGlIJ1LGFRjqfoy49o2GzjT16OL
X-Proofpoint-GUID: 2QuojJGlIJ1LGFRjqfoy49o2GzjT16OL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/12/23 5:35 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.333-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
