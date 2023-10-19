Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6227CEF6F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjJSFyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJSFye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:54:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D4B182;
        Wed, 18 Oct 2023 22:54:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J3TtEg013623;
        Thu, 19 Oct 2023 05:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ozZWJFMjVdzRY/0s5/5Iz6anIUyMZqXOX7FEI4P/Ib4=;
 b=fJqIQpnzvOuKHmqo6f0h0nRKA4AJiFkJTdg8PZVEeSYNb0O4t/oygaTz1Kypmp2kpcBE
 +99GJkoMTnaH08b7GR8zqxoTUoTqi+RsZx1riHfmX8COwoJy7owNuEET7sCeTP4wxoax
 29IJcn8GLAMX1vjLKYeBv9srPSSm4XhtsY95k7ZOaJ3Dis/Y4zHYHqtPsDLr8sU3eajr
 oWcSnLHDz8lzpHXP9erv2dto02Ru90mVJFs4PHAY+ol1IUSjBHrhLBnocam7JpXHskwF
 1DHOYdummOrpdxvnLtB742vQy72MH6joRay+AKmuEIbxftXdyBx2zH/XKKVCqjwwpWhX 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jsem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 05:53:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J47bPq040652;
        Thu, 19 Oct 2023 05:53:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypqxpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 05:53:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2WPcI5YvUTgx4S2syMwiYdmu9m/HYwOSZpj3sJGaA+6AeYbU4CHhV20tPjzBopGkqb8XN6V02czrog2Mc367elgWvhPyrwJKmtLsj6RVwjBCDrqOI5upMFWyDL5JX3EU3w5eRZ3V1JvnqLW4X0I7C6uUuimziZ9uC7nHhMjUHwoMM8R7sCRXAtkGryJ+uC3egeZikcZfGN29n/o8Z5zquRmsy5Rc1oj534B6Rz9ZzSHrBwp5Ka3NP5FCtZvuo0UXXvQvmNAmfg6dDqMLZPTgX8lCzlBs3APBkxWjM6oiTvJnBNtA7Nv9NGyLOGxnz8v8kZ8FEoFOAwacCQCU3tpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozZWJFMjVdzRY/0s5/5Iz6anIUyMZqXOX7FEI4P/Ib4=;
 b=Hcma0ZcelZazJWimDvgi7ztOPuGmBfEu5pdVzaU1gts0czHPmBoCM2xN0NniHJM7LmAJVV1ZOiSBC/BGg3H5xc+Krb8qo3cuIBnJh+ZjvHRPWVjZAx3kwm1UDYLVmSZA/RTKGEBdJeiquRZMD+LdTJB7kXgj5EHU4Q6roa5kwptnKCHzXj367WsTNizukmzDgA/MAjRV95X97gODYd3GUKZWvnHyoiGkF840u3XBEEc+Dbbl/CT89aEa7x5NbnMPTq5GOG8KQ/4OgORNvnO1DYH8Oxs8tTGlT5yygfpcHUNRcmUDSYO63GE1nUswuoX6RgjtpwZ0iT8Io7WiEvCyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozZWJFMjVdzRY/0s5/5Iz6anIUyMZqXOX7FEI4P/Ib4=;
 b=yhidoCEyyqlvgba1k5mM0Pdn8aCiRrFnS7kXVgpLvqOekVzSv0+L4ELHfxSIF0RFBHTUJHSrw3TRpjAzOAAED5hDcIXfrvuEcWKbSF2zCZrqZu6W7/gv6Ioqjz5+a841/7Z+p1Aa3ZmfqjGiKiDH58mbw/61ZUkdPSphxAn3zg8=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 05:53:48 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::f3f5:8ec9:ab84:281a]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::f3f5:8ec9:ab84:281a%6]) with mapi id 15.20.6886.039; Thu, 19 Oct 2023
 05:53:48 +0000
Message-ID: <e84c8a2b-58d4-454a-aef7-ed62427b589a@oracle.com>
Date:   Thu, 19 Oct 2023 11:23:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2023101655-throng-rickety-ff79@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|SA2PR10MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 30976e45-1fd9-4a6b-4e29-08dbd067c321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnEEgXFfp5ByrliHISMFbMOWxp+cuDH8i/VzVAFv2TwoQnyrM16UlA6r0T/ZzJ/qYE5+AOEuVokSbMkDaYf3N+MvvziQCISG44xlEFnfsm4PleDrNe6WL9g/kkYNwjLcu0hM2h0340JubaxDC8SX88VWp119jN8fb3ozbeT09d1AoCOFwdjwA022XhWNo0ukLT/+ZOYNsOCnCVivNGMOuBKdtQV+ItsXhZHn/kDy1U+adoAbJrCjpdVNlQOVGPVX5EpAvZoI07lA6QQowT24Rzz+LIAA55ea76yoFnleVsIMAPKnkAqgKKlpXzmfBbnmpfzhLJYkOIews7kWZbPVOGMvnZON/TqzLZBSH5miCQVa0quGLW9YFkjASmHcUq6szwbtuWkUg7xVLSD0D40iw8WlSUsoMvyPM6ob0tfS+5yu+BEFdsV1/tVfbAjMHlb7OazdvmEYwTTGthmhlEI6tB3+ZFFakSZ0p6Amr7JMT244rWq/ig5bl9CnG0mWjNs3N0s9A7LDcNjQ/aVlsFJEo4Lre4+rlK0610BUmpFhpokVrexRP/f+HQsubGo3RpOXzOgdEEWd9epjZDIOwCb3PaUeSDcEqvEWXD1jK8U/4yvnXg7svARnaIxZVp66HsVfE8nKhGzp/gYdUAhRKxsJ9gdWYVTbC1HSYbJ33K5E4AvbfW/9xUzPdrDJyqA077JY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(7416002)(41300700001)(31696002)(5660300002)(8676002)(2906002)(86362001)(36756003)(8936002)(4326008)(38100700002)(6506007)(26005)(2616005)(6666004)(83380400001)(6512007)(966005)(31686004)(6486002)(66556008)(53546011)(66476007)(6916009)(66946007)(478600001)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU1GM25GRXI3MHk1OFFEQzc3b2JNeE9tcDZsdDBKaFJISXo3THZZYTY0UzV0?=
 =?utf-8?B?bzZwbzVRQjM4NUtLT094OHEyRGRWajErMGtoMDZubjZhWVh4TkY3YzR1OEdQ?=
 =?utf-8?B?LzhSajEzM1ZNWGtLY29aWWRoNUZrRUdzV0RSTWFkTWpTMy9ZM1Q5WGdPTnZU?=
 =?utf-8?B?Qlo4YlNaNWFIalJUd3lVdzJueEx0aHNGWUhoUjhGeEVmUFZQbWhWdFZRcEtP?=
 =?utf-8?B?QmErSE5Pc05MRW1JMTZoZmU4cnhiOGRSNWxDZDd6YlBPRTNwMFI2NUhsWm1X?=
 =?utf-8?B?M3VwU0dhQzdsR2dwc09ma0lPaDVRTTFKNEwrQmJyaXkrV1ZINDhIZ0VOeUVt?=
 =?utf-8?B?V2ZQK0dwbjc3b1FDV0doTWZYdzl3SVJIK1RiSVlVTFpzL1lVeFhEMGhvNGU4?=
 =?utf-8?B?ZzE2NGNTa0o3ME5lMm5QaWpRVThFdUs3S1BXalFjTmlHZWE2b0RoSysveXZJ?=
 =?utf-8?B?LzNOV0ErZmtDaDlEU25WUFplK0pKcG9UVUdkakZoRlpVQjl5dG4zdWxoMjkw?=
 =?utf-8?B?aUdzM2RuVGdDdzdQQW5TSzVaYTJsUWhtVXJzdWhzaStyRVlBbnVubDEvaWJH?=
 =?utf-8?B?Yzg5dE5qSnZnRXppcFp3NTVqdzRmOHFMazd3RHhrOUErQTRQSWZnUXQ4aUxq?=
 =?utf-8?B?YW1xNEZTY1EzVnlqanJ6UnFYY3FGdzhYZ3h1MHJ1SEo4anVtcWpHRzRtYWRq?=
 =?utf-8?B?VHlWZEUrUU8xWmhmWE1sLzcvRlhlc0lvdVEvNkZaTzJNOUdObjU0bWp5OHhD?=
 =?utf-8?B?SFhSNGIwSGFpTmdSaDZMR2FMZERoV3RxNERpS3NzOGxGVHo5K2t2NEYzS2Vx?=
 =?utf-8?B?bnc3RHhlYjNwVE5zMmZZYkZEVmdmY0hLbkpVVndkY29FZEdlQ2c1Ymd6ZWdJ?=
 =?utf-8?B?TXFEQVgxaU9iS2dNK2RvcVJodFhZQW9hVmFDSTc2eVcrRDZhNjZHc1gyRXh5?=
 =?utf-8?B?Mis5NGgwakxsZSszdTNUdEdLSTdRWGVrKys3U2Y1YmQ2YncvNGFOWTZ2ZFlQ?=
 =?utf-8?B?K01SOEt0VGdodFBaVFoxdjZBZnU5STRiRWZvMGJKNnpuSlEyUDBSM0FyejdE?=
 =?utf-8?B?bW8yZnlxMzNrU0JBMEcxSENaNER6UGJsRm9YNWVYWUlJa0FvTnJBZ0lTOVR4?=
 =?utf-8?B?eDZSSnJ4QVJSWmxrYWdsOHhWbTZxZkpwUzAxcmVhSXJZa2U1RkpEaE5MaVM3?=
 =?utf-8?B?ZS96eWRnUXRDaVFKOE95dk5ZenpySWtpZHdFcWtwTWhieGtvQVNnbXB5b1dN?=
 =?utf-8?B?S3g4VUV3OWRTbFJZZDBqdDhOMGZ1aGNzZUdKTXdNRzlCcUlrV1daaERJdGNt?=
 =?utf-8?B?RWIyY01TRGZpUFhtMkVwcjdnbTJONGNraFhVVFo3WS9ydjFKYXZRbnBkN24x?=
 =?utf-8?B?eWFTYWh0N1YwR1lDQVh0SUhJMkFXTzVyblhpeG1oZTZFMGdrUWo2WXhHUHk2?=
 =?utf-8?B?RUN5OFB2QVllZk81WmhCODloWHV3dXBvT1l4eG1ETU03NldxdU1HQWZzcFh6?=
 =?utf-8?B?NXViS1A1Wm95UkdBN25JMHp5SjdBN3RhdWFMWEU0RjE1VFU2V1gvWG5lVmJH?=
 =?utf-8?B?RUlVWGlkOVkwMk52aExNRDlRd3BMYjJ1YStYS3NFSmtSNGl4MW93N0t1ZUkx?=
 =?utf-8?B?VXNuRENwbGlEalc0L2JRUWlBeER0Q0RHcE9lMTdSZmNsSkY1SU1OenArbTVZ?=
 =?utf-8?B?cWRUZ1crWXZRVStJSklhVEhaMFpVYjJjM0pBREQ5aHJmSW81UUdPMDAvK1d1?=
 =?utf-8?B?RTVaVjZuRmkwb0hHa01xRVE2bExRczZDSy9sVGJ1L0dBTlFkRFB3NGg2bVFw?=
 =?utf-8?B?aFd5dlE4N0hGbExtOEVJdFdmcHhMQjJqSGd4VGtESmNLRnA1cUp4ZFUyOVky?=
 =?utf-8?B?NFl6cGx3TkQwWVQrcFNoMlV2aWNsM1YxRnZNc0pRUzFZL2J1YjFZNXVpdnZX?=
 =?utf-8?B?MjJ4U0Z0K3J0RFFIOFZZZUlwNTRCSlBxQTVickNsTEU5QUo0NjBOTDNVTHhK?=
 =?utf-8?B?UzQ0RWkxM0x3cDVYTERJQXJCcC9DSVN5WkJSMXRMWG94dXUwVTdNZGRKbmpZ?=
 =?utf-8?B?cGx0YnZScXBScXNES2ZzRnpWNFpKdWQzeU03Um5ZanVxbnpIUXhxUkdGWDFQ?=
 =?utf-8?B?TFRrWHQyOVBWTVNsWFIwZytZekxFVzJSWno2bC85T3h4WFRrZTJacTY2VzRn?=
 =?utf-8?Q?XYyWcCSzLdtTHqav97e3rYY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TDJaWlpZNTBRaWQ5TmswWTZCQWpxTi8xNndUS2xrSk9EVGpUMWZwZVlHM1B6?=
 =?utf-8?B?VjFUQm92eDZ3TjgzYng1K1NLcGtzekxHMC9kRHZndmlzbkZNeHNpR3FvSmRp?=
 =?utf-8?B?d3Q5MzlibytxRlkvSDBRL1JrTjUvLzZScm9EeG9GRVVDbkMwQlNMNDFWKzF4?=
 =?utf-8?B?QmNjYzF5cmltZEZER1FBaWJFMTNoMGpOcUtkQUdrWjNYNmVycC9OVG00UU9I?=
 =?utf-8?B?azhMaFZ1WVhvaGdLNWt2Z0hqbXVLd3dyc3VFYTlkVk53M3hId2ZXM2N4TTV1?=
 =?utf-8?B?c2Q5Nm9EaWY2bDRJN2lHZ1YvcnhUSHppOTZPVlpWY2lJL1EvWi9nVVRmVHZ1?=
 =?utf-8?B?NktWSUhjdWJEZ2tJSncwZ1puZHI0cDJGWUtRNFRHcWpTcnBIMnh1ejVuaHo1?=
 =?utf-8?B?U1FJYlF3YmVicnpoM0lUd1VvSDFsNlQrVENsSFpTVyt6TXZvSE9OcGdmcjVV?=
 =?utf-8?B?c0VscndZWjBYWmw3akhNMS9tT3J6clJkRXhNajcwN0NrQTNVM0M1a0NHcGUx?=
 =?utf-8?B?VktJZkk4S25ad0MvenRLWHVFK0RZR2s4emRSdjdBdmtWU0pJVXRGdENtaDdN?=
 =?utf-8?B?WFFaQk5RcjMvbWQ2QWg5ejlpTlZsYkpVb2lqR1ZrV0FrTFllQTZycUVRQVg3?=
 =?utf-8?B?a1N6QVU2emZodlpBUHJ5WmJaWUJwMUxmeTJlbjVFV2YwYmtGT0VnR3Q1WTV1?=
 =?utf-8?B?QUE4RTB3OXpZZDFuR2dXckhVSzVpUTJwSjJSdm1DaTBHd3dvVGJvUTJWelhi?=
 =?utf-8?B?dlRRZFpacEk2Rkk1THFuWVBFTXJVZUt1b2VPQXZ1VDZQdk5rTnhiT1praEJ0?=
 =?utf-8?B?aS9seE1TYTd4UEZPR3FscDhJSmZ4MW5SUkVpWlZ1d1A4WktqRVFRTnZyaEti?=
 =?utf-8?B?N1Y3L3FsQWtrSU9oMFYvdlVzQ3FncDFRSi9kV29OektDVDFuMlBxTTlQQ0Q1?=
 =?utf-8?B?Y0N3YUMzZlZJVlU0V3dRU1U3eFB2ZE9RQmhDOUtCNGl6QXJNRDJpL1BkWm1Z?=
 =?utf-8?B?UFl2a0gxM1dmRGdRd0NXYWZBaWZsblVuL1ZLbGxsMHBVOVNKL3k2cDdJTWJy?=
 =?utf-8?B?SFA2T2dpZVk3U2t5ZWFuMDQ1QlFQWlNHMy90Tm5iM0UwZU1BRklVaS9RbU9q?=
 =?utf-8?B?U2NhUFBaZ1UyOGV3d2t1VzFlbkR6ZEZlZklSRm5pbEt4K3JiMFZISm5kd0Np?=
 =?utf-8?B?YlM3L3ozZzRPSlFXOTJFM0YvRTFHSU5meW5wWEk2d044SXlpa2xqdTdsaGNM?=
 =?utf-8?B?MGFXaWUxTnpLRXF2V0I3UXo2ODJXbHdoRng5OFhUK2lja1hhMzlYWU13Rlhx?=
 =?utf-8?B?Z1N1ZXA4U1JOb0VlYjREN0tPcGxNbHhyQWZKR0F5bjBiTTh3cGUxK1phY1lW?=
 =?utf-8?B?SFZZK1EvdE5oL1F0dWZUL2tpejFsSjJLNGhyRXgzNGtETVhoUGIrTUlQbzF1?=
 =?utf-8?B?NzhuSFp1QWlyK1dIaHZuS1E4c2VQMEh3UTg4aUliWUtDZzBDTU9CWCtYdVBh?=
 =?utf-8?B?dy9hR1NCM2dGVjZOeUpkTTZoakREQTJrNWN6NjhLckN3WlBsd0pyTWlYZXhv?=
 =?utf-8?Q?jn61nmpQOtrN4GLlm1JjyWH5wnWbnttguYVHZ7SySHSPZR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30976e45-1fd9-4a6b-4e29-08dbd067c321
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 05:53:48.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypz97sZG2v9VdORS7LXkK4i+26y19rHkFWpaI5S9AlZbjPCN9kP3xC7eJzP6D3+eeqSq1Wgbx0UWTjCxdDqYjBZ/DkEwpygpcPr3JpVxCvJTP11SyIkYoOpvvdSaCsWN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_04,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190051
X-Proofpoint-GUID: EthVs5BUd5kHUr8LCEq2pgnw-MSvj-Uj
X-Proofpoint-ORIG-GUID: EthVs5BUd5kHUr8LCEq2pgnw-MSvj-Uj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 16/10/23 10:28 pm, Greg Kroah-Hartman wrote:
> On Mon, Oct 16, 2023 at 09:23:36PM +0530, Harshit Mogalapalli wrote:
>> Hi Greg,
>>
>> On 16/10/23 8:44 pm, Greg Kroah-Hartman wrote:
>>> On Mon, Oct 16, 2023 at 07:06:20PM +0530, Harshit Mogalapalli wrote:
>>>> Hi Greg,
>>>>
>>>> On 16/10/23 2:09 pm, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 5.15.136 release.
>>>>> There are 102 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>
>>>> I am seeing a build failure while compiling tools/perf/
>>>>
>>>> In file included from tests/genelf.c:14:
>>>> tests/../util/genelf.h:5:10: fatal error: linux/math.h: No such file or
>>>> directory
>>>>    5 | #include <linux/math.h>
>>>>    | ^~~~~~~~~~~~~~
>>>> compilation terminated.
>>>>
>>>> Patch 43 in this series is causing this.
>>>
>>
>> Sorry for the confusion.
>>
>>> What is patch 43?
>>
>> It is patch 42/102 in this series
>>
>> https://lore.kernel.org/stable/2023101641-resource-scalding-3e1d@gregkh/T/#m70a2a03b6204085af187184af911570681e744f5
>>
>> Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
>>
>>
>>>
>>>> Why is this not reproducible upstream ?
>>>>
>>>> Vegard bisected the commit which makes it not reproducible upstream and this
>>>> commit is missing in 5.15.y:
>>>> Commit: d6e6a27d960f ("tools: Fix math.h breakage")
>>>>
>>>> Backport request for this was made here:
>>>> https://lore.kernel.org/all/CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com/
>>>
>>> And that commit is in this patch series, so are you sure that was
>>> correct?
>>>
>>
>> Cause for this build issue:
>> Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
>>
>> And this issue is not in upstream due to presence of commit d6e6a27d960f
>> ("tools: Fix math.h breakage") in upstream but not in 5.15.y
> 
> Ok, I'll go drop the patch entirely, I can't even get perf to build at
> all for me on 5.15, which is why I've given up on it even mattering
> anymore :(

Thanks,

After reverting this patch locally, no problems seen on x86_64 and 
aarch64 for this rc.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Regards,
Harshit

> 
> thanks,
> 
> greg k-h

