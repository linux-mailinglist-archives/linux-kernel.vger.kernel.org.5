Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1077EE81D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjKPUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjKPUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:09:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD23A5;
        Thu, 16 Nov 2023 12:09:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGJ4Bth014409;
        Thu, 16 Nov 2023 20:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cTRrCp3xBY8UhYj0lL2Z8UMOXApG8jhJ6cu6zqCICvk=;
 b=h2ypUjfxh+iHfDc459lxU4lz3tZOBYAWic6ttxxnocUc2OlFiJZ73vrGDa4cVY1to02E
 LluFqskYcyVj6W7mw8t8q0biEnBICOAn1QWZgRWl0Vn8+d3YAs8XX7V0fuYLWaeLGhqn
 xfDu/3DP3HB1C8eQ3Cp1CI0vOHzH/Lyr8+rdtgIO/YHi8QLfJgdwnH+WUjIozrLQ3mNJ
 LWMsJiGCuIjYRotQsAiPzLDYd+EWCMI4tPwXhVKVMJU//9emgE5lu5cnl5XcSIB8GwV9
 +9E2udozCyPRmDi4JHRVnugbcpR6Ifg9VMW5B1Hyda5xBtzttu0JoIKig0W/V4Hedxut 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qdbvfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 20:09:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGJMuEw020933;
        Thu, 16 Nov 2023 20:08:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj670uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 20:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHHP7elGSOtLAiqZMBX4NtN+Zamk+rzYrh4oiC8hWVaqd38H8y8H7dJIErYdoUmNUTKRDJRR93yf7CkoNsfcoeVW+1ose7Z2d3IZBK9V4B+IsKNvhbj5pHZxVMq4wD+DbyZr+NGj0xIUgxgiN9mEcod+JVV4mEKXTWoar1UPY7AvOxO0OFCLmjyOmzICu7XG4DIXk1AfLLc2VVnrljOGrnyzGXYxF5xAUWAkkZDh6e2aGJYIjRVFh9Z8pG5fsGoUqmJoouREUwbRBWrwOgF44j0VhDtpyZA2iYfEGeDiyfIw/M0Ew6E5/CdEfmijIo1QqfMPVejYykdPmL6K5MiWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTRrCp3xBY8UhYj0lL2Z8UMOXApG8jhJ6cu6zqCICvk=;
 b=itY9TSUrNl2Fr9zhTnt+5lyrU20Qni+WoKOPGQc7X+DFACKmHNEu/IesS6Q4q/W0PIpRWjQu90YoECi9NqEfuA/7Dj7gyQHPlr3rg9MDPOJNevgzruFJetkwa6oMEfwqnGMv3B6sq1ogblHR/NLKWjEfMHFF92+QDrlkot3f2Y8riRLRjoiSGHbthWxjmbHdUIv391FredLKn1eOo3EJ9hnT8Zp3HtW+brdXobWcVPQbVUssI/5RyCndTaUt4NY2SCiU6SWUpjPfieZATGx0PzZmYGGQzxZu7dhfwXNmygx+odKJ9yOK5BK7x6HIDLqz6yLAVQR5fRSlDRA1X/Jhpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTRrCp3xBY8UhYj0lL2Z8UMOXApG8jhJ6cu6zqCICvk=;
 b=xdCa+HUFXKNm3udWmJ5yKnXw9dUgAx7+V8AQdsLw8fpwea1VulTxT+KGM9wXgS40wuGqksX9xdqAm2C7V634tUIdPSxw2A/7bnHNk21/03KxIp39uc3LpBLnzcTEiYjMts5IRihKFIpYk/atOUh/RRhcooQM/mzt0HuJMpEQcE0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB5688.namprd10.prod.outlook.com (2603:10b6:806:23e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 16 Nov
 2023 20:08:17 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 20:08:17 +0000
Message-ID: <9bf73a6d-f20c-48b1-8e36-eff7fac444e5@oracle.com>
Date:   Fri, 17 Nov 2023 01:38:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/45] 4.14.330-rc1 review
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
References: <20231115191419.641552204@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231115191419.641552204@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0212.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: 360e5005-3e35-4071-d61b-08dbe6dfc52d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElKeiZ6sqIdMuE9VWMBH8pPlR/EnMBCaBFkl/E0w9Gdw2LUBXHmYnNP9x9RcdC3glGrZEzzGgDNFDJ/dtDWpIDdHW6dxutViuZyu0XhB4BHOqjnIejAbk+8Lsk9hvkj9GYnnrY1Y7dEoqljymhU8G3ciTjae2UiuMQVUbUC+IyUC99JmuGABLPNxgo9tmHiPn7OE3uiIqPmXSVRScNCNVkuL55DCyvlJSfD0BhEkUO9gLuG/yKeYEpCsqXumYK+EOrkurdgIQqlYbLytf3hvLUwlhbJ8dQLs2bLFqTgZLgp/oKgWG5AM3nQbK2Jb0Fo41geEFs3goWo1K4VPtrqQNNqnKLhpdRNP86eCVsfXY6sAoWSUU61C5PNfQMn+Lo1tau//ksGNmh21UcQ7JQuNSB56fai7/JWPDR5OquWUpVdRwffn7809F5bkEcJu9Mvt1FT6Dmu3ybR2EEpNpLhZ+lR9iRMldJ3yJoM309ELYT3/MyJ/ZB8fpvThCTxRb/8hXwHxi2xIoP2gDA4nPGX5SOvBRS2DT8wdVV9pGKpjtw9SFH9iloy0l6PJKe7vPfzxbbN7T+iOw6xNHlPn9I9u7GBYMhcVw2t/zDDLJVByqIqW7MUXlSjo/ZsNUbFyQi88LEt8JKlecJwaQRV/bBRlOAirGbAnIYy1gjkB24O1/6nEI7LMTJvUfMHwdeRTdDb9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(66946007)(31686004)(966005)(6486002)(6512007)(38100700002)(478600001)(6506007)(107886003)(53546011)(2616005)(26005)(6666004)(36756003)(86362001)(31696002)(66556008)(66476007)(4326008)(8676002)(316002)(41300700001)(5660300002)(4744005)(2906002)(54906003)(8936002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pzZnlrcC92Z1RWVUtBNk01VXJzbm56bmxxTHJJT2c3dmlvb1ZQQ1F2Smsw?=
 =?utf-8?B?UVVSc0YvUGZ0cC9zdDBweFRhNnhVZUNGOUJnUXN6WXpBNk1tYWRPN0FTckxE?=
 =?utf-8?B?alIrZ0NhV3RzRUVqdWxCUG90aHVOK285blNVMDBXbTJVN1E1alQzMGpnV2Mw?=
 =?utf-8?B?aFRoMnhxUzIxNHQwOUJiNzVZaHY2c0I1NnpWeVhsdzAvK0U2STVWY2o4U2hr?=
 =?utf-8?B?WG5HVUdpOG1MVklubk05dkxkV0duWHllTDhNOXFxa0txR1J4ajMrakg2VGxV?=
 =?utf-8?B?ZnM5SHhpb05xK2g0UitsZTM2UU9lZjhxUDV4eExlK2F5NGtydCt4UWcvZW5r?=
 =?utf-8?B?Qy81b3lwZWh3N2NicnNmRjRNYzB1L2NocllsT1oyT1ZYWndIQ2pBTktBSUJ2?=
 =?utf-8?B?VG9PVGcydml4blJrRUhBVk5RdnFobGEweHJIbW9PUGxBcW55VEVrLy9lY0tP?=
 =?utf-8?B?YUpFNGY2VzRpd1pZU21pTi9oMndoa24vYWRuYmZ3ZUtnUEVON0NQN1FLcGky?=
 =?utf-8?B?M1VIT1d2RTAxaVovWHpiS3Y4aW9ja01DdVNXaDdjSnRHL3JBVkVmZVN2dzNS?=
 =?utf-8?B?S29EdzBQRmxISzZmcE5IOXRxaEFCV01JcXNlVXM4NHl6cW1DdlJxdVJ0eFhr?=
 =?utf-8?B?K29kekJ2U2FOQ0wwSlNRallaeG9CRHdaa3pxK29rN2NpR09qYTRBSGNvN2Jn?=
 =?utf-8?B?ekQxeHV5b1dvTi84eUJVdkJERzFpUXNBRFltSm5Ec0lrODVoU1Q0bUxKdWpC?=
 =?utf-8?B?UjQ3SEVyZGlGb2diM3FKZEJaM0NIc2E4TUdjOUV5SjBFZG43T1pFT04wUmd2?=
 =?utf-8?B?N1YrUjNsYVVyWWZzZE05OWIwanRlS2tDNjVvUCtBMEs5endBM3BLckdHdDZ3?=
 =?utf-8?B?VFNGaU92dTB5WTV0eGNiOXd4aVB0RWRHK3pDWHVOYjVWV2I1dzhHZ1plR3Fq?=
 =?utf-8?B?clhBSThtbnVkeHBvZXU3TjRETEZ2TVg1Q2ZrenlPYmtKSmthaHBXaVVFNUNL?=
 =?utf-8?B?aERRNmQ5Zm10RDFlanFubU5yalhzMjVHdzJDSUw3UkQweW4rcm5QSnhyWjRN?=
 =?utf-8?B?Z3dxK2tCbEFJZUpPRUYwYjVhNXppbHJLMlJ0dlVNM3VMdDM2akpmTm1rR3FW?=
 =?utf-8?B?eExHVjdNd1lMc1Uyc2NJU2MwWmwrWHVpSVloMkhLZWU2TVoycnZsNE5sQTRi?=
 =?utf-8?B?dGtObllJMjAwTUpqOW03ak9nQXN2cEhjV1AzSVp1aWdzRTFOaGlWMVRkSUtj?=
 =?utf-8?B?Y01QcUNzdlpTNkRHcGRxeVdkN0JHZTVLNEx0b1JsdnFmVTQ5U3REUzJjdXFQ?=
 =?utf-8?B?My81WU1WbEFGZmY5K2FmQzBVbkhTVnhpVXlNZ3FKaUZaUTd1ZEo2SGl0R0l3?=
 =?utf-8?B?NFI1S2hEOXZqclFYMGhNaWgxc21keU90SU50djJER3BJOXFacm9ldkY2SGZx?=
 =?utf-8?B?Yytqeng5ZllLRkhuWUlKOXNpOWE2Q1paUFNSSGMzV0F0b2t5WWpKTFpoeVFU?=
 =?utf-8?B?V3BsTXJtNTMwbjlJUGhOTmF4ZWNVZWNlK2NZRG1ST2M4VGZFTUR1YU1JUWFC?=
 =?utf-8?B?UkVzUEx5SnQ2RVVMOWVqWnMrMjRxVk13dWcxY1QrQ3F1Qlh6dCtOS3VaZEs1?=
 =?utf-8?B?aVRPdnRSclJqUkhTQnhyY2lhVFRlY1BraW56QlVjMlI3RFkrakVNTFhLRTlu?=
 =?utf-8?B?d016SmtlVFR0S3Z1QXltaEFHdE9xUkI2dFZQVTArYUZhMEtuYldUMkRNL1dJ?=
 =?utf-8?B?QmFSRlR4UlhGMGJWU0EySDdQdVZCN1ZSZy9VdTFvZWU0dlVRdnoyQWgvSU9n?=
 =?utf-8?B?YURpY3RpMVR5eWl6SFl2M1FCTTd1T1Y2TTRDN05WQ2w2dUtZNFlocEdmZ0gy?=
 =?utf-8?B?eHJSbVlBcUM1MXRjWkpJRmVkQUliTmozcTJuQXRGU1h4SkNUSlJQRjMrUEx1?=
 =?utf-8?B?bUUyYXRhY2U4aDhrdVF0T2p4blZHRUtBbDhKejd5bHVHRWZ2dDRrcjNYelZZ?=
 =?utf-8?B?MDNmcGpiaWFzMi9FMFV2MWdqYmdwK2hqZ2xvTmJYT0NkSEpxMDJuRGxiZC8w?=
 =?utf-8?B?b0RsZUJPMk9VZkxtZEJtMTdsWDBDRXY3eVNyeU54UEZwVkFCaWhWazBYTjJW?=
 =?utf-8?B?SC9SY0Y3YnRxR0N5VkQvQ2RYdE8ya2Q1bmE3SnFqMjFPVXh4N0lCWFJmRmNt?=
 =?utf-8?Q?Uric0ikU7Rh8du0ZgicImMQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NGhmdzVob3UwbHR1eHFkQldpWVU0VGlKemRsNWV0dEJVeDdnVWtrNGJMcXBl?=
 =?utf-8?B?NFcySnNISmwwSWIxQXRCWE5TcG9Mdm42RFBiLzdKeXU0LzNUZVlxekFSNk9Q?=
 =?utf-8?B?SUNvZGM4aDdoVTlVeGo2M0x1MzBvZVUxa3l0a0tVWmVTQWdFeVN4dXlYQzE3?=
 =?utf-8?B?eDRqa0ZvQ2Vpa3hYWERTN0FrRDBQREVidnQ3NU1zYmptOHNaV2ljYUs3d0sy?=
 =?utf-8?B?WmI1UUNXTnJ5bzhjWWdlS0g4bzc3UmNQR1gyTjk4aUYwOGl1VERFS1BpTEg0?=
 =?utf-8?B?dTBoWmQ0VnY1N25TaVIyUk9mTW5mOERhdDI2TzduVWNGL0RJSkVaUDlxakRl?=
 =?utf-8?B?MjFQK0w3M0NMdDRzQ3FQYUtQamFLWTdtZzFyQzV4TitCU1hUazVTYXVEQmxN?=
 =?utf-8?B?Q2JZcEFxdFBmb0RhTU91djlOQUxwVlJwcnpOUnJodXEwWmZHUE1YWktrRmRB?=
 =?utf-8?B?ckNlYnl6ZEg4L1RXazN2eGxxcW96cWY4Q0JIRUxaZUhPMUFZOS9IcTFhSWtK?=
 =?utf-8?B?WEpua1J2RFB6eUw0c21SeVVpNGxBWUZwTGlabXo2aWpVb1BWNmFtWXBmeFhz?=
 =?utf-8?B?YWFLOUs2aklSZHV6RGQra2cvdFhVWVhuMWEzVTVsa1p6QUJlM1NKWHl5Rmxp?=
 =?utf-8?B?WUlxUFVaajhUK1RXYkJVL0NxSEhqamNCZWlwZ0VYMU9zaHpjVkxPbGFtaGJP?=
 =?utf-8?B?Y1dRRkxLTHJXczB2bitKaXpjdWs4TnZGWStXMlZYNzA2L1Q5WU01d3BKcnVy?=
 =?utf-8?B?ai9LUjdneU5XUElkNjF1MnlPSlU1YVNjVGtPdlRSTTJZN0prdHcvOHc2WWRa?=
 =?utf-8?B?ZjRxang1aW01cnlMUVFtbEtBdUhyMU93Mmg2NmNWUklIQmVxak0xbTZIN0ts?=
 =?utf-8?B?SHZsYi9pWkpJL09HZ04vNFNzMXl3WXcxKzhYdmFVQXp0VjRpR0lBV0N1c1FE?=
 =?utf-8?B?RzFJcWtGRjVIWTdzSzl0eUgxR0kxUFNyZmpSczBHT1hoUWtFVFZTV0l4R0tx?=
 =?utf-8?B?YzdXL0JTOWlGN1k4UUVPUll1K2xrTnhHRlFLVlZWeG1kR3NOMnpIazFUQnVq?=
 =?utf-8?B?N0g2akRuaXVvNVQ1SlptSjhBWEM2Z3NwTHY2MHlIR01lVVk1Qlo1dUw1YjNa?=
 =?utf-8?B?Z3BCUWJBZTlmU2YvbWtnanNVY2xJaFRjN3RuQkVHc0xFWG9aSUd2N2lxWFo4?=
 =?utf-8?B?L2RxRkVmb0M4d3V2UlhvRk1rbFU1RTZQeFR2aHh4b3FlYU1vdk5zSWxUNXI4?=
 =?utf-8?B?MWVPam41TXdVTGM3WnUvWFJTbXlXSldMRHl0b1ZMemk1bFRyZUNBOW92VThu?=
 =?utf-8?B?WC9JeExVeFBpVEFPMW4zc1oxZW9zb3E3Z2h6bGU2cnFwUHk0UUZaZTY4V01R?=
 =?utf-8?B?K09rc2RmdjZTNHZRMURyQkZMZWtjY3ZNRi9GZklkSzhORkE4SWZoWjBtbmFX?=
 =?utf-8?B?TjZJSWVnSEFPbWhHa0IzTTZyN0FCNGsvNmtwbUtLTk1RcUZIY1lCN3dtSlU1?=
 =?utf-8?B?UDlyYUJpdmxLbXVJTlZEZUJIQjJuTlU5T1puREo4MnZKU1hmWTU4ODdEL1Fl?=
 =?utf-8?Q?V94+EFOyvZTh2J/rIX/LJ8EL2fVIxfooIkH6VDqyBlwrHe?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360e5005-3e35-4071-d61b-08dbe6dfc52d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 20:08:17.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2nfDWTBsoYDxwTe2s9dZrOimQfEu62OsXY7ZGcmrIIj6xKTt9d5M63WxVovEAYHiX0Q9Bmm8qCulyhzDl2ZKuXZsBv7XrUGswvGic499vsJQti1/Fgw5bSdx9Yh8/uI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_21,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160158
X-Proofpoint-ORIG-GUID: PO0lqnzWxxRbeV1o2SamqWyiBqNd3fiT
X-Proofpoint-GUID: PO0lqnzWxxRbeV1o2SamqWyiBqNd3fiT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 16/11/23 1:02 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.330 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.330-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
