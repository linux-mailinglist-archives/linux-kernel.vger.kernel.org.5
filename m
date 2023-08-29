Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A9978C1E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjH2KCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjH2KBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:01:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49090E9;
        Tue, 29 Aug 2023 03:01:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T6igxk010790;
        Tue, 29 Aug 2023 10:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lwduSFW+2L/wK0+ox/Cql2AEuQYUUvu+PDnRKBCp7vo=;
 b=T7mpX+51pq5IpHhbxP7+uZQJh5l80y/mZJPJ+QGwAlk5r2gi636eb9EYB8ETtcsS8njA
 7c09JZJOEyApz3TaPpDTRvgX6DfgMTROj+AWuvCEy9khhbeDmFvlRUMgDSQITBSBpF9B
 wqbTmdQKPygv77PWiCo3Y8wwPtxrmoumd/FhVJIr4t3gHg3l8+6COVD3fd/6jq3USeK5
 sRAmOHjwt5m6BLyVAVNFOjlkXwdFfDNqgW3VoHTEVbqvRFTN+gsr+8Ttdd6hRUR/6xPx
 jrKDSy3DBT0WXTC3LvhCHASPGeSQJF6Kge9ADmFJkV7qguoF2w4RU79LL0YWVtXjeABo Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt4nbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 10:00:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37T94KKm036847;
        Tue, 29 Aug 2023 10:00:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6mmvcgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 10:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZjVWD+ADkO6Djynpf5/t3GOWuf9fhclD85GKwHwuo71I0UMlHNCOX8SvPHdnBwFgFbq/okO86O6b2KjwQp95Yu0i5wkuE3om8PGpFcMoKWOfMU/X1df4eRInSjDxAdkSVfGyzEmxWGME+UyMQr90vXNYAcBBgNN1I1QwyG22m44wQhXGdJh6OvFT6Wb6YE6j/ROLGYni2CUJTVMcVMSJl4rXSq0zRkdgbOKja0aJ+Njar4ky6DkkdqlNmMrV/h9kNqtE6Hska/STzEqekg/dAafADy32FSGldfLxZANNOB4M98twR9b5N1lCgASFLNfeR+cToDLVjr78a/pWfDnGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwduSFW+2L/wK0+ox/Cql2AEuQYUUvu+PDnRKBCp7vo=;
 b=KKcfhAbUubFzXIjwe/IZKhruc7We8TSJRE6qfPOhBa3BFofBA2tL/spcLqrcT7fFHg6gbaB7ih50w6kdZLnHdWeZCph/7D/Bts0L2GNPNalk3ChpS+h8+yZVR2U4YOo+yASWx7sKweBU43OYz+bZipJhbjFDm3euhwJllE5huMXqpnGqiHH84E3d5xrxLIOL7z+S1inur39NWnBUhIQHVPZ1rFUs7L2fPbvBuY/63TaFA+sIBHKUL9q/Q4/y6/MiblCP2jIDV2hOD8ylMLRcUdKjgQ1tB/dhi7oes4p9Q2HAddkAfrbI+I3eLHheA7nY28owDd5HjrQaPo84D3Nyyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwduSFW+2L/wK0+ox/Cql2AEuQYUUvu+PDnRKBCp7vo=;
 b=vacRDNIz4fU1bVI1r4G9TprL5OkYnblkUnCsBr75P0GeT9Z11+kaTX8409UoDsD1fXDBG8tmyNl4l3an1hkmLmOtVSa9GTDBcIJI2LGd909xki8hMfW01HCp/FOP4D3NUlNSIH9Z5mBy469xafPJxRlajPISNacFzULHqFluA7s=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by MW5PR10MB5714.namprd10.prod.outlook.com (2603:10b6:303:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 10:00:52 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::d7f3:3706:c034:bcbe]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::d7f3:3706:c034:bcbe%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 10:00:52 +0000
Message-ID: <e985d937-fa61-ea1f-b8bc-e476a199a82b@oracle.com>
Date:   Tue, 29 Aug 2023 15:30:38 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
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
References: <20230828101150.163430842@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0200.jpnprd01.prod.outlook.com
 (2603:1096:404:29::20) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|MW5PR10MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: ace0ea99-faec-4647-8125-08dba876d428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRh7ARcT1880JSfEh8ockDtCW96LtdXdts+0knt3ekv8Ye4XMJfu4KXa117vgLFjlAHyrgqvLsYnhQhoB0WUCZvEY6YyfMZXmxdSClp0kIvoImU5NN+F48RmfspO0ON8j4alaClXsI5R+OuNxZd9J6bZMpOvUyVxGknTUt8Kyacpm1WkriUNK28hsp2k5ACC23hGikBWiyybPiNg0/ovdKhu0o3zEaQTQCYpkvtjrN6MWrKDztKEVrvXvFiFJLAuiFIlzdBxmG8EWsVFa6fDIpqShlmT0BfUf0JvcXGa2MFMu/kUnaU+pgVGXHynMkMjlfZVaGUyp9JpH5ZAiQdWnzWTUqNhg+2dk14x/JLUNzywIGPOWzcG2t3YKP/ZRe7vwuUZtcaOwKQUbro9Ai/0+aKH0q9pmB4Jy586CybYn0XNaMXn6ses662Y/O54rQIBBqS3fAf5OmTBpIG9sf9S6pfayat3rJMPlBxlh4eRXfjvKzuCqnYnpIhhuvis6Ff6nSALvJwzD+ollSAazhnKKAyeD46K3wH17++GhkzumRt6tZMtwItgc40A2U00+Rmx7OINgZRItbWqN7l5jIcFMjcvIFF1nJ8V/lkJ7SSkVgn+WxBG/eYnEJ0z7DQxH4TPIRUhAzEF/d+x3uLcByOzWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(1800799009)(451199024)(186009)(6512007)(38100700002)(316002)(41300700001)(4326008)(7416002)(2906002)(31696002)(86362001)(4744005)(2616005)(107886003)(36756003)(26005)(5660300002)(8676002)(8936002)(6666004)(6506007)(966005)(6486002)(66556008)(66476007)(54906003)(53546011)(66946007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWMvei85c2FnN0FoUDlWQ3Babm92NDRYZXVjc1BaNmhzWlpMWXNhSWswYVRj?=
 =?utf-8?B?WDdZWWY2YWwwc0srOFE2b2hLb1ZhUllNMW1uZXl4eFZRbHdrdjdZTSt0Y3Vr?=
 =?utf-8?B?MlovNWo1cG80MHdSUHpGaEQ1WXVwTWpIZGZqS1FjNTlLUlBaNE15NFEwWTk5?=
 =?utf-8?B?cmFFSmM4cURWN0V2M0NScWh0VTBWWFdtNldRVU1uYmlMd1RMWjVUUExqVWhp?=
 =?utf-8?B?SzlyYWp1NUdlUXpzSm1IZlNwRlhsUHU0dlkydXMza0QyRUFHRVBUOXJLeS9K?=
 =?utf-8?B?VmhqdisyRWREMStBbDZZR3RJZytyMkx0UlF1Q2FMdFZ4K1hMcjVaZVVhVVhz?=
 =?utf-8?B?TENTRGNZWHpndW94SUpYMEcwYThQdEt0djVCWVVPNFFLV0N3aXdQN3QzenNK?=
 =?utf-8?B?UVY5Mm5HTlhESHhjVjlKRUxYa2l6ODdVMjFxTENQTC9HU1JvQTk1aVp0cEV2?=
 =?utf-8?B?OEEyQUdYbmJYZmppK0RRSW9MMFJDWHBaRnhLSmZpTDV5ejUyTENPajJWbWlr?=
 =?utf-8?B?TlRmYkRCNlY3ZkJseldKd1hCKzhLbFlBZGVNRno0M1VTa083ODl4dmxrUEJv?=
 =?utf-8?B?R1FaMGVDcDlHSkxUMU9vK1RvUzhOZDl4YlVHNXFSTFRUSmlGRzRSS3VtUDZY?=
 =?utf-8?B?amZIOUxGdHZWbFNkbTRuYUFqdWh3U3dSSTVJYjcwaElZUUhkQk5BblVaWkFL?=
 =?utf-8?B?Y0FhMmhpTkYxeUpaNFZzRFVpL3o2czBOZkVtYUx0MnJKcUQrZ1UyLzEvUVJu?=
 =?utf-8?B?U0dqNmNsckt0cUNkeDNvTVpMZlE3UzRTTkNXcUlyY1FldUZrbVVuUGFyYUh3?=
 =?utf-8?B?ZXlVeE05VDd6UjNOZkZBZnFKYTZ6N0JiaXV0Yy9LMm9IVml3R0FzK2d0ZHBE?=
 =?utf-8?B?ZEhwNjJTY0VaeHp6b0tvQ283cloxSEtIWExDd2lodjYxUCtMS1FhZzVvb0Qz?=
 =?utf-8?B?b0N2bUhwZFExUTdReUd1eE1pdURNeDZSRnZLV21xbDcrQVBqZEpFbUZUcmpa?=
 =?utf-8?B?bFJNamlZUEN1aEFLTi8zcXNaQmtBUU1HVjBTM0FKVTRPY0FQY0NCb0VSSHMy?=
 =?utf-8?B?cm05U2RjRk9mTnRmdHBzSDNIL1Uwd0RhRmppRmxJL3NLWUpmdklSUHVabC83?=
 =?utf-8?B?amExTWtMVkIzdFhvTjdRRkZJS1NTNFJYMWFUTWxTandKZ0s1c3FJS04zSmFk?=
 =?utf-8?B?cWFFVnBISHpxcExXMm9MY203SW9VTG9ZcTNQdTdpRkVRSzJGNWpERmJRdU15?=
 =?utf-8?B?ZC9SdTlCNWVHYWJQaTJPV2NVdGJJYTE3L3hHVHAxMzQ0Tk1VQVpySjNtMXFy?=
 =?utf-8?B?ZDA5cTFFbVBXVDRHVExCYUd1MlZKYmx0ZEtVR0gxMWxqc2hBS2lQaVpXWjFo?=
 =?utf-8?B?VDIzM2crYWhvaSsyK2h6TmMvTjErMFN0dUppZXYxQ2JZNGN0cnZJUVh2MU5D?=
 =?utf-8?B?RDRJa3IwZXU2bjZxbTA1UFpHQ3NkWVN0S3JmK0h2Wm04SncrRE1HTllkenB6?=
 =?utf-8?B?aTNrN1dEbGN5V2pJcHJxOVBQRFJiVWU1aSt6b09WYXVnaUVBNHV4SEZzUGJq?=
 =?utf-8?B?SDZtMlNpTDFGa29UYjh3UTVBMktqMEdIZXhUa0NPaitqc3VZb05sY2IyQ1Nz?=
 =?utf-8?B?eUZXYXZ4bHNjMGVrTllXTElGUEo1SU5PL1VTL0JjSDZZZUtRclhScmRJZDBy?=
 =?utf-8?B?bjlEMXFFdE9hTnJCTGdjbHFCdnNkdUd5YmtadVljYTBUSXh3NWluZkhTeWFE?=
 =?utf-8?B?b2k0MmszTkxxdzN5NXh2UVpSZ2dlNkpBOS9NTlR3eGRlbk5xQVc4NXAwRk1Q?=
 =?utf-8?B?WVE5djRLV2FqUDNHM3N5REgvT2ZETmVkSGk5dTZtRWM3bXRxVXZKQWRVazl3?=
 =?utf-8?B?aXlsdTNvakVkWG9SeWRTWmNQeHRlV3VGZ1Z4Y2ZOQnljM2RIOVdlNFhoYmgw?=
 =?utf-8?B?R3lISGJtS2ZFMmJRMDcxOXJsOWZ2eE1WbjQzd2dYTC8wMml0SGRSS3pBL2Fw?=
 =?utf-8?B?ZnorSVYrd0VwTzhPVXM4WGpRYit0MUw0ekUzMUpCYUYxMWNLWlRnQkY2cmpG?=
 =?utf-8?B?WkkyeTJMOGpDWEdRYXZ6OURFUDhmNGRKRklMaEN5SmlKb1pRZXRIZDFiNGVD?=
 =?utf-8?B?SDk4Mk14R3RRODRTMWgvNm81MDJkRWFTTEpJd2UrNjJaMEpycjAwM3F1Wmhv?=
 =?utf-8?Q?UICKZn8chsWwaLHwrzl4RRU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a0lrTEdNb2lWdU9GOU9sWHJCbk1aTFVKbkZpRFVuVHIrM280WHNLTHMwZFpy?=
 =?utf-8?B?cmowb1RWbHRJZEdWWUJIZHJ2MXJ2MW5OYmRpOGpERDRZREpHMjh6eGZKc2dS?=
 =?utf-8?B?UWtBTGVhN3pqa1drZ294c2dIMGRQelRGVzV0cFhDRTVOQmRpam8wWlJPK3Ba?=
 =?utf-8?B?cklwR0ZUWGFVdHJnUU04MUkzQndBbHQ2U1BwYlg5Sk1YM0hFZ3R3WjVoMHhk?=
 =?utf-8?B?UVo3aW5UTjdsRkJOZUdGZHhhVURCc0tRTTZQTFFNNGUrSy9nM1BnS3k3RlF0?=
 =?utf-8?B?VnhtZnVwdXFZRGZacGtaNDR1ZnNSNTdFbnVqWFV2NjFCR1RxejQ5T2kxQXUv?=
 =?utf-8?B?R2g3VVBWTXFSeWFUYlRsa1BzbHNVaVh4SGtqWjhvanY2YXNVb2Rndzh3dHhH?=
 =?utf-8?B?cEZPczMxYm84QkRvWTZTdmVMbUcyOHE5ZmExNENxSnR0OFhVTi8zaUlIYkox?=
 =?utf-8?B?QlNHRGNMM1V0MkUrL1YyVWh0QTJVcEhUc3diNVFiNDdpOTJJQ2Z3dlkwU2xN?=
 =?utf-8?B?Ty9oK3VsRUpMVW5UYVZ6UEhpN1oyK0NrdlkvcEdoZlZPdjEvR1hTLytuN3Rt?=
 =?utf-8?B?Y0FMQTYxTUdTOWMvMVgwanFuck9pWjJLRDhGZjhVOWpJRDJ6SWVjS090R1Nj?=
 =?utf-8?B?bTNwOWREaGJsdGhGeEdqR0xPd0s3ZVJnY2VQRWNCYUNGeVpXcUExd1dDMmRo?=
 =?utf-8?B?V0tGdmczYXp5UTRpUVRFRm11YnhOZFJ6ZVJDc0FEa1BlbWcwMTVyTDdLWUVl?=
 =?utf-8?B?MGxRaEJ1SXluZXE1WTRZeGtZWkhoUmZWWkUydFI5bEd0UGJMYmJPdGNKVTB6?=
 =?utf-8?B?U3hueE1KcHVzRytGQ0Uxdm1YeFNXZ1J0aWJjdWx2VW1DcVM2Q0ZCRVo0N1lp?=
 =?utf-8?B?L0xnOTlFTHRUMlkrUjdlM0FxS2lIUmxMZC8ySEJlNWVZTlJPNlV1QnJxNXB1?=
 =?utf-8?B?NC93YTBEbWVJUEI5ek5KNDdseExUVzhicGFDUUxjUHlEeEJCT04xVW9ZVGpF?=
 =?utf-8?B?RngxOUVwcFdsZXpJbjdaUDhmc1pWZEpjL0daRWxXZko0bXlncW8ycWJnYW5B?=
 =?utf-8?B?MjhFWjczcGNoZzlCbzFJRzZKUFBjOHYrLytwU215VEQ4aTZsNng1aVZhY2NT?=
 =?utf-8?B?RTBhMTZTWUF0NTlSWXRLa1pZMWN3dzAvUHN3d0ZzUWpLM0h6cmh3dW1Hc1M5?=
 =?utf-8?B?a3IweWNXenFEbkkxMUJLczdKdmNZYW1PS3lucXdwZjFzcWt2YXEzMWhtZklt?=
 =?utf-8?B?TGd3eFF2WVFOOElKRDFPQXJnVDRZV0djUEhNc0NGN01HY0ovM1RKWUhZVHkv?=
 =?utf-8?B?SnVYSnF3MWFsOEhESnJxM01WcmtUTG10d2twQ2t0YXRiSlVZWmIyNnVvZlNR?=
 =?utf-8?B?ejV5LzlGR3VBNFVCSXVXQ1pQRzA5b2NiVWdqNDZUeHZVbklBeXkzQU16WHhO?=
 =?utf-8?B?LzRnMTZOV0E4V2lYZU56SlJLQkpUcnN3S3VIV1FsSFhKbnRrdUcwUkJtRHhD?=
 =?utf-8?B?UVp2QkRwMDBYQndOeTBtbWI5aTdxQmlBK01rTnRFMVA1K2gxUXlET1JrVTND?=
 =?utf-8?Q?vx8ZsOfUn5GUmUCjubREiWSnvpWXBCPN/W6PT5VJHXgYYl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace0ea99-faec-4647-8125-08dba876d428
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 10:00:52.4797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utX6wD4GE7yUHTzzk9hHj7ce6NIs5oQRbX7ZRIEyeY0qUEqM9/xTGhFgFuix4wwoYOOCLHFgqGBRAYHLgj74uI372PfyxZXNB7j4MBpm6G7ka2a/8GBeW7RxRgZ2YNrN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=974 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290086
X-Proofpoint-ORIG-GUID: DPPrGbjfAGdfOQtt3RSn4oNFdptsHIKP
X-Proofpoint-GUID: DPPrGbjfAGdfOQtt3RSn4oNFdptsHIKP
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 28/08/23 3:43 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
