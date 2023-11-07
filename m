Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5F7E438D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjKGPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbjKGPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:34:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18A595;
        Tue,  7 Nov 2023 07:34:41 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7EWusP009566;
        Tue, 7 Nov 2023 15:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zMhsdDij6x3ZSYCK2wXDqZJEYI1fE4e/MZhjIMbvbBo=;
 b=gD6dfQbt46qnSUDoCwB9p3LoRBLVeCK0THpdx4ZbazULjJuwgC8XYGXoOLWd/fDZ7PGi
 rLt5raFsJAY2sVtALViz5/ljKpFVh+7RW8X4mBRLWZPATynUncAnr7al/BQfYocn7H/+
 o5mQJUiSBTkefnLJOy3545wwCHwQuUu7rgKqroQwFqEgvQO2CwPxBzncb0bGLqjoSHSn
 03XLssBxAkfID15qe1Oui22rvW+VmzN/pX1AZfxocyPeCBvWmxpJjriOnEXpnBylSwy8
 if/3yBl7J1s5q7/YgwILCx6kCb779F5KX9bLx1kyskpH+2h2XUFvc/L7NLa4U3SIyj1T hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5egvebq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:33:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7EZY9A026864;
        Tue, 7 Nov 2023 15:33:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd6yw8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:33:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsbQbSfdyNO83778J23POcjVT9IxBmLW2Vvt45q7RPrnbG4HAv7ORBIvrRyfr/Vl1+LX+cgquico/1ZpeRAtBf1EvXyITS0Mw4i5YthL8Iy/U+iBpLfI8HRmE7Wgn0XJMKTWIGZJkArfAtDteLblhrLewkxaCNC64WKTn97ycabNZXf6fXlkwFdk0a44WEj2rx/ghx2tpnxTixbkxtDdpG6sD/uwY4GTy3NxPJn9Go7j9DwcfEeIqbfm2X8ICWoBVkho+QbLssPwCoMvss3oXrG+nLQJ51NnOMVzyDCqN9CiUYNnfAo5CbLfrYDIYGDGjDlMJizHCTN1lCcrhF6ybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMhsdDij6x3ZSYCK2wXDqZJEYI1fE4e/MZhjIMbvbBo=;
 b=NfilmRPNpNmdUmnNIvqnPvFeRIMIlkgiokbheVbRk97l9JTxDEzG1B1885ROTLPgp4HCy1MfaP4bAOF2Say+HoiJIbd/oDu3MHYP7e7QprBOIKs+I4PS5gdY2xvHQm/m88WRehixyULlHgDwboOGlMXZFthJ9sVOLhAHh4FmvJWKfGXnqnYU1IDZ7TRHGChKCNqpdfiAtMRPdZ19aAYc+er4TRGVWNGHru1v/S7dKhMw8BUEzMPy5nh62h1v5Rfw1X50WfmrnEJOZbxCRqDtLdVyoGxHmXpQLFD6MnIAEX9RJWJx9NMqKrF6+6w4pMH7TtL0vN4Ba1NLg655bExkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMhsdDij6x3ZSYCK2wXDqZJEYI1fE4e/MZhjIMbvbBo=;
 b=a3WUGwCLmk2luVvAl1I6HD+6VBIkNmm/boHDS3ohM2XBAzgR7ZPLJt/Tzz+fNFnj2CcPS/hcUW2h0s+UbeMM9H2q46PeSxcPyBJuXVTrG0BrUu9gLC3lIacGraJoO8wqkM4Zyuzor7mz0Uc/DHQhNl7008TUvNS54Vv9aknUUtQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 15:33:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 15:33:53 +0000
Message-ID: <9b3f7dc9-11ac-4eb2-8d51-4fc6a34a8951@oracle.com>
Date:   Tue, 7 Nov 2023 21:03:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        mizhang@google.com
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231106130309.112650042@linuxfoundation.org>
 <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
In-Reply-To: <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BY5PR10MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7bdae8-a347-44a8-ebd5-08dbdfa6f2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qaNQ9ybG94kByVJsqjfdahS/ohY8R46fFeteC4Qdq1eMgPQmYO6ReYHbdqPQ5RQQ1KUUW+cYuB1ycp+vs2FRe2yeCwopaFXobKEVf6t/aJmXsokj38RrBm780eM2e9P/Z/Os81dFee29M9gmcLEr9ToU9O/YNiJvh4aqskDb48Xmwwb10k8go2Yhl3rg4UwQR4PePwah8sOk1MDxLEnIyvyrL2TBugPycoELQsKe1aAcs2rgy6UvDvFc8lNlb1tYysrNJyZmH/KnL8hIVV6S2BwZEs2NJy/bIdeYfyf+56K3FsnkhtKehSRoHZwPgkTHtw8DT2KTkiJYAri3prSZZ+87Lq3D1hNJrmGkY9l9v1HLUHlntm5qv4ebI+Gwi4sgkei1c271nN4Asr7iPTcOVhoyCad3PmvSEzgpPz/axG6+5TcpZVaz/EolWDNY3DFmfEUNUJJqvbA28yCfTUp39eD3ZFnHjWU4Of+BNAZCTOebn6GkxryywV7e27shiDs9kbmOY2y5oDAuZ2S4Q/v1hN31TBrADFwvIvYMBdZTJK3CPfE+fbWk2JjZf++Jm9Bj2rVHG9NKYZvvIlhaB4wnszQQmtmNKq1g8zOhoODlp2x9LTxwZZcdlv1z/bfW+FGfOMP0PXaoLJdvGx2/vlSqDAuZgavVJbsS2AOQF1A408+3OgHe0xXDRbOQJU/GZE32
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(53546011)(107886003)(316002)(66946007)(36756003)(6512007)(6506007)(26005)(2616005)(31696002)(110136005)(38100700002)(83380400001)(86362001)(66476007)(6486002)(966005)(478600001)(41300700001)(31686004)(8676002)(8936002)(4326008)(54906003)(66556008)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW5jbVU3T2FzeG9RSTRkZnJ1WS9jK3ZHdHIyZ3JwZDZNMVY5blRPQXhJUmRu?=
 =?utf-8?B?SlorQm5pSVpodjNGYWpkYWt0QUpwd3Q1NkdydkJpb1haTmdIY0U3Sis4Z2l2?=
 =?utf-8?B?VkdKcCtJTmtRbGVDWWU3L2FzN2lhaURhYmZXa2pUL1h2Ly9jeDd2eDBnSW0r?=
 =?utf-8?B?d1lRMkVoU1k1UWtscTBsU1lWMFg2RzY4cXhTTEVaWnVWdzJWZ21DcWVzbWVY?=
 =?utf-8?B?Z3JTcTdmQXBKelpJVUIrelZaTi9KWW5oRURpRnVaRENpcmdxeUs5SllncXMy?=
 =?utf-8?B?bTZNMWFhOGhjM1pqUFNsZ1B4emdJSGpRbUFRa2RleHoyZVZUODJ0aXZxWThD?=
 =?utf-8?B?ZGZhbXdldWQwSnpXc2w2UTc0eXZLMHdUVnIxVnNaT2lPS29TaUpuc1J6TVcr?=
 =?utf-8?B?dWFQQUU2VlNOMFVzekxOVDZHTUhSQ3Q2ekdJSXRTbjFaMDNVd3ZHWlY0c09w?=
 =?utf-8?B?T1ljbWpkNmRiSGc3MkFHYTR6bHJ4czdNeFRROWRPSlhJWXN1Rk1RTDMvK2NR?=
 =?utf-8?B?d1oxSWlhdVJIVldYdkFGZ25UeTZWSG1lSHlCMHdzSzRZYURYSDJjMXRiUUE5?=
 =?utf-8?B?NHExWDIyWDF4eWQxQzk1a3ljQTR6dFowNVY3VWlSVnU2VW8wS3E4YjI3Tkp3?=
 =?utf-8?B?VE1NY2NiZWxJN3lsUURmemlOTmtaanNCQXlBTnVDUExuYWFTcytQNlpJRTY5?=
 =?utf-8?B?UGQyY01vc2F5bFlhVzZtT0RtZVpsMVVpR0d4V0hMRjVNM29XY3NoMGNTdXBL?=
 =?utf-8?B?RXJ3VjZzSEtmbUE0Q2NRYjlZdXNWN3BrLzNTVHk4SEtBQkpGODJQazFEWFFE?=
 =?utf-8?B?aHJucXo4N1lrV3ZUWUQ1dW1UUVJRdUxGQlk1RzNiNWd4OWRaZUpla3FNQ2sy?=
 =?utf-8?B?S0xWTjU1RWoxS2NiRW10VzllNytNK1I0aFBaVjU4UnoxZzJuWFBvZ2h6US9R?=
 =?utf-8?B?RS9XbHdtYTZjWUNEbkhBaHkvMStXSUhqUHBINlRSTFVxMTZRaWJVWkdHT28v?=
 =?utf-8?B?ejNKeDNZWGdzeGVuWXVDdTA5VktTOHpxaGpNdmlkUEpSb2Zjb25sUWMvMWI5?=
 =?utf-8?B?RG4vRmt6K2NUdjB6bGEvUmJreThZd1RicmpCMUhBT2NvcDExbzArZWRWbjd1?=
 =?utf-8?B?cU9NakpKdVMwWHRIS0I3bjRPN1dRcWRLM2FpaDdsZURPS1RpdG9ZNksrdVNl?=
 =?utf-8?B?dlo4cE1vbHpPdFRlUUx2YjdDb2dFenNVL3ZDY0tId0VMWndzWEFSUHVMMldY?=
 =?utf-8?B?ZjZRYVU3ZXpLS2M3bVpXc2ZHck1NL2NOUlUvaFZFTFNLQkNldEw5ckhFbFRO?=
 =?utf-8?B?aTQ5OXJ0aElwME1ERS9IUXhoQ29Dbi9RTkZ5Tlo3K1lia2NMbTBsdzRTK1JQ?=
 =?utf-8?B?b0ZpTzhtOGdwTXJjOVJSbHpaOWxEZ3lTS0grQWhLQXRoZHBpOGtmVXhqYUFy?=
 =?utf-8?B?WTJEclZGYmNSSmpJWUVSM05hayt6SXhVV21TaW5HU21OelhqVmhyM3hoOVdQ?=
 =?utf-8?B?ZVVJUW0xVnlyNXZDelBmQ2FzVUxJWHVUMmZ3NTQ1cDQvZUVoNHUvWjBlUkJG?=
 =?utf-8?B?TTNkMWM2bEFVSFI4QllqbzlqL3duUzVMRUJROGZKNXczdThoaUhvNXBmY0lG?=
 =?utf-8?B?dU9INzJnTVZVSFlodXZOQjQ4ZWZxUW5uTEwvWDM4WVBGOUNveDJBbldBRmZk?=
 =?utf-8?B?S2VCandFM3BNUW5PMTZZb2R2UWx0U2Y2c3ZwNkFLOE5EeDhwYnNSMkRndEY1?=
 =?utf-8?B?SW8rK21EbGp3NjZsbDM1RGNza21DV2wwNzNneHhDVCtlUDY5UzJXbnk3Zzhv?=
 =?utf-8?B?QmxaMnNqd216OHhMRTZid2dZeWc0QjEzYi9BL253djIvb1pnKzBXY3VRcDFU?=
 =?utf-8?B?NWJSeisrNk1ac2JYVEF4T1lQZmo4eW1HUEhqTzFKcmdlY09TNEUvWkR6NVRx?=
 =?utf-8?B?M0tEbXl1UjUxYWNWZGJhWjZVTktoNDU3TFAwbXVMLzErdUlPeUxzYUZLZksz?=
 =?utf-8?B?VEFZblc1cDNDSCt0K3R5YUNUTWpKUjlVTXo4NHVGVUtZUm1JN1RKZUhLRTNi?=
 =?utf-8?B?MkNGYlJ4aVExbURiZTRXTDYyNWFNOHRWck9wMXE4cERLRjNpeXpOeGMrUVh1?=
 =?utf-8?B?SDlIUmIyK2VKSWJkdXlTVzhuWHRUaXlybG00dmhWZzM0RG1GckxQQ1FGYXFk?=
 =?utf-8?Q?aYoXybbXzvmaja2A/GFVmsU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U1dqcW9HazluVGt6SURmcWh3NGxjdDRBMVhqS2lIZDE3b2VRRnNrdDIxVzBh?=
 =?utf-8?B?REM1dTk2aGRqMkI0NEwreS85bWJ5NzRtSFFBeG1nbDJma1pBQk1MQnNRcWZi?=
 =?utf-8?B?akRSSFpKWENmMnIxZ0d6OUVUa0lYa0FYWE9ySVhoUGJnT1RqbXlqd3V6eTNH?=
 =?utf-8?B?SU53dmJRT2dxZXpEUnlwTkU5NXNnNmViQ3FxZmhwbC9EcXFaU1AyNWluUDZL?=
 =?utf-8?B?a3MrT3c2Y3NDOVFXZ0gxZC93Y2ovUi9qWFZYVWRtNjJNb05RQUFyNFluYXRE?=
 =?utf-8?B?Y3JJR0FCeWlud0lPQ3VNeDdjbk1JcHFjUXJGOUhOWVhyUGJIU21HdTRPOFRm?=
 =?utf-8?B?ZVBhZFozOHVZRXIxUlp0NE41cHFzbXBDVTJ1NXp2UlpMK1JyVzZOczl2S3A3?=
 =?utf-8?B?b3V6Q0VHUGV1UFVpZ0NBdExSKzNaS1BSYlpLNFN2SnI2c0J1ZDExUjZabFd4?=
 =?utf-8?B?N3NsQktTZlpSSTNaTmZINkpvSi9OSWhCRVZaQk51UXJjc0dmVC8wTjhwd2Iy?=
 =?utf-8?B?ajNWM0p1aUpmSmV0anhXV0ZacnYvV3BxZEtvWmI0ZnVhM0Jld1gxTUxzZ3J4?=
 =?utf-8?B?cGI0NUNIcVpjemFEUnVldko0cXNUNCtwTWs0Y1BmSnlURjF2WVZBdVJrS00w?=
 =?utf-8?B?TFdZZzZlZUExNHA4VTJ6bHpyTmYvbG1zL2lhZXRwL0Q2aGpEcW1YVjc4V0hi?=
 =?utf-8?B?K3o4dEpxY09wM1I5YXF1dXBkaDdyVTdtMlRIYTRWWjZvK3FJV3VGektkN3Vi?=
 =?utf-8?B?bXNIdFc2elRRWEh3RnQ2WWkwU01XVGFxMktYUHRtTWl3TUwwTC9XK2lkV0N0?=
 =?utf-8?B?ZFY2cVdzTFBac0l2UmtuYU1Ud3ZlaUFWZ29sTnBRdzd2dGNROW9NYVZQVC9k?=
 =?utf-8?B?d0RVT2laaFVhamV2Y0JERC9OaGNhSUtlRXNEZ1lINVI1UlJranpEd3BiM1Jv?=
 =?utf-8?B?TE1scXFraDBTeHN6UWgwbUdKbkJFaElIS2VHQ3o2OFdqYVB2RjBFN0JrYzVM?=
 =?utf-8?B?WDdwb2RacjV1b1pEaTkrSDdDSmtwM2ppMC8zRmVMUWtWdU9HalgwSFJOK3My?=
 =?utf-8?B?TkJXVythdmJKQVo2WEY5NEQ0WWxPcXJYNkNVTUZJeE5OL3R0cHhySFYya2R0?=
 =?utf-8?B?QVEwZ1BzZjR1YllhRFFidHdMMkUxbkQxZGRLYjB6VDVta3lxUzdwOWxPL0Uy?=
 =?utf-8?B?TytKd1FSUjV1VUplYlN2aHFGVVpRYW54WGZUVVFtQ0U0OG1PbEx2N2cyRjBh?=
 =?utf-8?B?dXpOSFBSMnlja2M2b1diYmdWRUFCN0lNQVlCSTYvSWRqVTVBdlorRDNVbkQy?=
 =?utf-8?B?TnB6MWQ1TmljZmJ2OS9FK3hpR20xdENZMTFxK0pmakNHUHdqcG1jYUFWUDNa?=
 =?utf-8?B?U2lua25tanZtTkdXSTk5UzJFKzVucDRWbUVEOVhFdmJIbGxtNzNZQUJaZVN6?=
 =?utf-8?B?MWFxb1c4N2VXSndCdElDTU9TSW9iZmlicVNqTXY0ZjdqY25xZjFTS1VCN0tk?=
 =?utf-8?B?VEhUNVNKUXVPc1RoT2lEek5SVSs0eHU0dFViNWZncE54c280eFZ5ZHFqNllB?=
 =?utf-8?B?QitoUEdKUkozQkVoWStPSjdVYTVmMUNkaFVyZ0E2OTNPdWMzOGZIUjRlMkpl?=
 =?utf-8?Q?xkqNrqYcQVyBWv+sfHc4YHOQDQ8pUiwW5JHhi4a46Zpk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7bdae8-a347-44a8-ebd5-08dbdfa6f2c3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:33:53.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38NsrrZ8HeCb4112oGQrv4Ygp2vAYGZTW7HEMolsDyRI4tq2jCBm+5KXqP9kEcQ1KDOfXMgJqL1CxojlxvOsWNDHtudprKe8HhN7G5nwLOz97am3BqaQTDqsaW/xVco6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4196
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_07,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070128
X-Proofpoint-GUID: sxduyBE9mGlyMulIvtaEO02MuReqgkge
X-Proofpoint-ORIG-GUID: sxduyBE9mGlyMulIvtaEO02MuReqgkge
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 06/11/23 8:24 pm, Harshit Mogalapalli wrote:
> Hello Greg,
> 
> On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.15.138 release.
>> There are 128 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
>> Anything received after that time might be too late.
>>
> 
> I am seeing a build failure with perf:
> 
> tools/perf/util/evlist.c: In function evlist__add_aux_dummy:
> tools/perf/util/evlist.c:266:31: error: implicit declaration of function 
> evlist__dummy_event; did you mean evlist__add_sb_eventâ€™? 
> [-Werror=implicit-function-declaration]
>    266 |         struct evsel *evsel = evlist__dummy_event(evlist);
>        |                               ^~~~~~~~~~~~~~~~~~~
>        |                               evlist__add_sb_event
> 
> 
> I think we should drop these three commits:
> 
> 20a5799cae7dc perf evlist: Avoid frequency mode for the dummy event
> 7de783c81c7e7 perf tools: Get rid of evlist__add_on_all_cpus()
> 141ce9207068e perf evlist: Add evlist__add_dummy_on_all_cpus()
> 

I have reverted these three commits locally and triggered the tests.

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> Backport was requested here:
> https://lore.kernel.org/stable/CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com/
> 
> 
> Thanks,
> Harshit
> 
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h

