Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343AE7D789B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJYXcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:32:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5410133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:32:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PLOeuQ019309;
        Wed, 25 Oct 2023 23:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=2IhffpX4DbNKDZGZdS4Og4KGHB48lUQXPiYVmnX6cVbglpSx+m3ZKlZPnjTjitRG1lPB
 pfsYeBTxDYP0oTTTFK4L9YmQaeC6KeLJRbbWKM8hOjULuQW1DlZOxRoabd9vLzbC1ODx
 i1Kd3Tv/AMud4gL6yx8Snh6aG3ROKxabg1MLc1ZihqebxS0USLokHhouX4pWAQzTFvPL
 iQwQQIk79DNFKfm/OBnqrgutkhzMz3dlZvq9AYbaVwZOVpUJ86NlbOjWGj0JqcTg5SJp
 qOzqi19EsAAVLTFjrVksHpqbCAA8zZf5FH5413X51zX/dVqcuw0+K7dPpFH/iguPyvPX +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv68thhb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 23:32:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PM3OUh034681;
        Wed, 25 Oct 2023 23:32:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv537c73m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 23:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7HKfFW6l+pdr1Rpsl4j8REXh70bACg1g+k5kKtEAA0lzipfFxlEAaYwhxg0g7qx1K0w1iDkGhup/IfcfjgNHJUmY3xNEn9jE8sdmDdYxvELXWKSMwCD1sOZKbjlOdhwx9olmB3tDULJ12NNteyYWn7OlsBtBWfjMXJGYtahyb4D8SgtLZ7aGzjzTeRjfFIe1hxnIapoxffLT7MZPmKP+Lxcg+6qemAhegG3sscX2eT+z025HpThuZlS7DBxkT2dnDno/MTBUJRZzYOKJsYDMKazbRjewSUUiZQe3l7TUcRsb43eI6+w2DDKBro28YzrAJ77QL9hbco6MNtoIusW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=IJKGXHylzYq4L7aSiCwq8wWrOetPjb97D4FzxtGIGyb6JaQDtEWvNnMWIzg39LNZeUaOF4iJQDsj4UwGPB7TwdMi0Rb0OWzfkJ4SqEpxQc+kK95GYg/KfYAuoR2HIP57Vf9JeFOSMWYDy7DQBFSjDkevfJj7FZYvuUIOmOwbJSZdnHp1P2qco/4STFfkzYCv7RA2dSAhbhN7bBtmViTugReXcVkugG8o0+gdjVwI3yM2US3oILKZ63oABjuFw/MEyTeERFZ7WZthKxkc70eo1qtQIQOgbOOfgaMeTNKRYU2z67+chmc6QUyn4fgc0jz/WE/FNX+07TSHzNL5yfD5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eb4gEGeVhGoUWrvSAesL6CT7zK0okAqp5k1oj21eilM=;
 b=n542HWMAr0vU4UI7Xy2lMwzsaMRkLfhnXsBKA1qpv534Pr7p8vxJg2KpCwrz1CQ2gQNdC27ajeOKrj6pBjsaOO7eEsr3sWTqNgxNC+MsZVqz3sTqOUZebHUt1jBnuqG8iYL2FE+WAHdl70YnUJ5qjMxTHc/tu4Xa25KwCt6j2eI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY8PR10MB7291.namprd10.prod.outlook.com (2603:10b6:930:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 23:31:54 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 23:31:54 +0000
Message-ID: <d3f13f97-d5ae-4bf9-be9e-aed021fd7a7e@oracle.com>
Date:   Wed, 25 Oct 2023 16:31:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device
 reset
Content-Language: en-US
To:     Lei Yang <leiyang@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        eperezma@redhat.com, sgarzare@redhat.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
 <4d03661b-4289-46e7-8760-32a186783b73@oracle.com>
 <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
 <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
 <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY8PR10MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: f3071a7c-b271-4a8f-cd44-08dbd5b292a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/1qaQjwI3V5OJCa+3mwnXFsQVAUFyzdn75uFirxrEG29r4lu9afqKr78DP6306IdSN4YE0eWaGqSMzrGrXTAVwPZBrPxHZISab1kV9461pi6s2AbV8700Yxie1FGcKZ/TgHzU077pZO2e0TH07oIStGafPsHRBJWtS4G4iIVhs6rGrxOdcAsNzknTsR3DQEeqT7xmMDasE+REt2LgkodOZ72pWid1vNk6wSGMt2n1z0Hi/o8DtwpENjwtKIxzzskEVBam+jaxjkIxFBy2QybEkbnX0g0II211tKfPkMvNYZ7Ul+QAAGDOoQi5w/9TiWFADdvc4xC0pwbNx8/MH2ImXpxDe02a7z/A0JWsljmIzRCJDwIHBxh3be/rv2lT27qH1SBj/VRICvhcNvWP8bjCKwOoimHhVbOZ3nX52PAhgAytm869M6fg37Oey9LjJTKfgvhRCCpsFy7eZQ1VXkzMmV3dnQmVOl9QTA4+ryYJuXd4ZjCtQxap+Uj8Utxap4RmsOhsurxFCCP07ORrJpI9uaBOPN8H5zZsp6Os5pQmbedVjIq8ZFDxUmnJvQlY2m6P4fkPLLu5sMXRAAc1q6QnjD/CqrSX2csZ2jVp+PgTpbhQdH9iO+nX3JwLShA2X3DYqJMnhxZbF/eRuBKoMPn989+T+w3RNJVbRCtJdbRIfMr/p4GEJtG2WQaDxkSJJS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(31686004)(66899024)(38100700002)(86362001)(41300700001)(2906002)(66476007)(31696002)(36756003)(2616005)(5660300002)(8676002)(8936002)(4326008)(316002)(6506007)(478600001)(36916002)(66946007)(66556008)(6916009)(966005)(83380400001)(6512007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tml3dHNsZi9UcHh2OWhZc0JoNUlDODNwNGNzSUxsa3pqL3RMV2FTamlWbWFD?=
 =?utf-8?B?Uk5Kb01HaTdUWU1OeVFkOE9DOWhVem84WFdJL1k1VU40ZmZzT0Z2Zk1FakJr?=
 =?utf-8?B?b25UcjlydU4wRmp0ckdlUjdKWTVrQlRqMlVOQ1VIcDBaYUVEMUhSV3o1Yysr?=
 =?utf-8?B?dFhQNFhocUlvQkVrZzNWVFdWQkJNQU5BU0ZmM1NCQUJEZElrUDVhcTQxaU1C?=
 =?utf-8?B?MlM2eFpLNldpUEh4aUxWY2hYam12SXkwZm5oTVBCV3h4b2gvdDBzYjZYSmVh?=
 =?utf-8?B?Uk9YT0VCMm8wR2hTUm54eFRKejdDQStVVWJMMFFLTHpEdVNOUFVYSE5JWnRW?=
 =?utf-8?B?a2JTdWRuNTJuM21CUTRHQXV3VDg3UXBPMFlwaGoxZDNRanE3aHFia0tkbjNK?=
 =?utf-8?B?K3ZqSVlQUStNdXR1UjBHT0w2bk5oRWc0Nmdsb282Z05lOHFmQ0pzVFErUFhu?=
 =?utf-8?B?UDVQQitNcklXV3hYQmlvYVNPUlJnRW5NNDhuRWUxSEJCTGNIcTRjNlRac0lx?=
 =?utf-8?B?bmQyTjRYUk5SaEVkTUhBVS84QzcxZXd6cHl6ZTFpNE9temhqNjkwaFZ1RDRp?=
 =?utf-8?B?VVU0dHNabDU0dnFDc0tieGtCL0M4NXp3KzBLNW9IRHpMa1ZrejhubzBoOEcr?=
 =?utf-8?B?SjdMUE40U3lyUjdMNCt2SmhXZE9GVjV3bmRibzNWWmlBeG9wSnRwOUVwVVdv?=
 =?utf-8?B?MEQxNHNmOUp0ZThycE54MUw5a3BzNHliUFdFNGdvdit5VTVKWktTQUo1TmMr?=
 =?utf-8?B?M0ZOaU83TWI2UmlFY055RjhVOW5IQlh4UTF3dWg0ZmZrQVRVUWNjMXJoMDc1?=
 =?utf-8?B?UFJYWlY1ZHc4cW9IR2F6eXZ6czBTbjhBNzNzdFZrYjdBLy9HQTczUlBUWElQ?=
 =?utf-8?B?dHhscnRSdXlndE04SG5nd0c3cFRrMFNKemJ6Y1RuRlU0RXE3cmdIaEFmdXJn?=
 =?utf-8?B?K2kzc0xLQ3NZakVJdExjN1E4bkNFbHpTZXJkTHljcnhMTCtLTjFKTFNySHpV?=
 =?utf-8?B?WHo3Y3BNWS9VY2h6RkdqajFOR3IvMzdlR251eE5lYXpJZjBDalBudFBERTAr?=
 =?utf-8?B?VExyWmZiM3VpcG9laXhPdEpJWjNjc0xvelF5YnBGcCt3YzJVOG9ZeWpqT1hq?=
 =?utf-8?B?a2EzOEVseFJIZzg5elRTZUVWcjBoSjlwY3FoakFMV0IwYVk2UHdvUjJPRVA5?=
 =?utf-8?B?bU92aUYrQnd5L1lIKzV2UFJDcHpYelpzYjVEOTF0SytjVTlpcW9xK2tpVnVZ?=
 =?utf-8?B?bkxoOFU2d0xQdDUveS9rRnVFcTlsOGJySUZmampxVVZpQjhzendoN2hlQXRI?=
 =?utf-8?B?enhGbnZGN21ROE1XK0IwQjdLaGJlYjFBN0tiYjdrMGl0NEZDS2VyKzNaR3lY?=
 =?utf-8?B?TFhlTkpQem9GNURPMm53eGwzb01vQmxJdFplMVhEV04xU09RRDk2WFp0K0hC?=
 =?utf-8?B?Ky9uRWVvN0ljVGtjRDJVeTh4b2dLWnVOaWswNXdqdmlpVHgyMmtCNXdqNld6?=
 =?utf-8?B?M3dZV0I2TGphNk55VHBFdlh6N0F0djZqOVZFcGVkQkwybUE1d21uUUdFZ3Vu?=
 =?utf-8?B?NjhQMnlkcTFYRERVV0w3bTRVbys4ZXlscjVKd25aTlpoR04rQzZJZ21RS1Rw?=
 =?utf-8?B?bjB3UTlUdmNWQjFrUGxxeXBaUjEvdGNmd0pvdUhhVmI2RVdsNnczWkhmeC9T?=
 =?utf-8?B?M0N4alRmVktVSFFLZk9Xbkx6Q2x0MGkzMUpkTk9ITWFrTGRxYmZTSTJjOEpr?=
 =?utf-8?B?Mmh6amlBSnNPVVIzZjNZdHllQm1aWXJ1VUMzVWwzZ2R4TjlXRjZxRlFlV2pw?=
 =?utf-8?B?V3BVNlRmZ240MlIzbmZ1RWQ0bjdsaWhxSGtIQjhUR3FVNWV3bFFYUFlncVNL?=
 =?utf-8?B?VW1sR3VMWnlNWGw2Q1hqRVpOMStVQWlFNUpsOEppelFRWkJKNUFGOXRkQlky?=
 =?utf-8?B?SC9Eb2VNbURnM1dpL29aenp3YmdDNjcyV1ZScmhMOUg1cFZuMmhNU04wRTRy?=
 =?utf-8?B?VFZuakloWkQ5RHZIN2VPQzU4VkU0MnZFdUYzakZQNE4vMUNoUTJpbTVQendk?=
 =?utf-8?B?aU5FbHlzYjBCbFhKbFZnbDRIUFY0c2p3Q0lTWDNvR1lHaTVpVHdaWjI5L01N?=
 =?utf-8?Q?ty9jzoJYLt362KWP46cemicWh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 07a1de9ChPBXyY4nWyWlllHoTii9iHMEPQhBnTrtKUy4lDNCpQlqyfmuZC+Vv3f0dfpeuqoHS2esjwEABI+9jsc9ocWkj7K2BBxRpVSXbd48h6c7HavLbWkOtnlZp3ng9hOZkNCtzdU0lHpkClKbVMphAITaQOhfwQnxcNWDjYNq0CI/OP6Ykc8A4NWl7JGZjm7mnhUwjVg8IWTXOPpzIUeQhA+gg4jZWiwsPzREjNrxycl7W7mOYhv/k9cv217Ui1552qv2PXzEW2ejn2Zybrn2vO/W3vtTqZZOCgPwL/QhvEEwLzomLQsipawQO6cKVnL3ntNpocMQr3T9cnS65jbRqULU+GSgdE1iUuNeFnhZMZTaRe+gxzBqGZW9DU9lSBnE6ZShLbOOq/+L/fGBbEGp53n1VxOc7dsuU/2iMwLTbBQz7DLb3307lr47JyHPJMlb0gouCCu88ysXQzGe4yiOQgUzrj+vidGvj4hjLxlnIeTqmhE2NEsAKZ8u8nqNXsDBRTjMF8OUri19LxIwO9WYWdBOQQVDPa4SXLwtGwpIZ/vn5g3XCKc1q3g9O19Sm1AZuUPzOIiRweB+u5uGPD7RI1jALVs2bP9jxHjbM5QvBkZMnIFiHEd1zftnEwULuAoeZa6BDZErSLTA8ajEjaaCBwCtholGIifrNfVxjunZH2Wm6VabdEFllTO39cX/wEWEBOvIWRHzthFuHLdX4Eh97F1VdpydRkKbr7SEqQ5nMdC+YmX4GO+cPdgKjKBd1yWqYLM5S4/U1nhj0U3dsEaRvXaEBjuhQnPFYY4xZuWc7MdYWOPPugDCFXis+Bq6wFiV09AYU5KghlFLUx4WJQ8LniBTuwAFUrDCgi8oklDU4Sgj0w9D0WAvGdKWgOuG7I64IJFqJ50YlWqiEwoteA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3071a7c-b271-4a8f-cd44-08dbd5b292a5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 23:31:54.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wir8x9pdS92hlkTpjlWAqyAEBhah+uZoKbKr64JRT57MJkbUP3Sh3r6gKtnTyQMFFE7MyGlkowORaR2PkI7rZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_13,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250199
X-Proofpoint-ORIG-GUID: XN4WYDCnUptGb81WQpaWh0q006C8cAQA
X-Proofpoint-GUID: XN4WYDCnUptGb81WQpaWh0q006C8cAQA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang Lei,

Thanks for testing my patches and reporting! As for the issue, could you 
please try what I posted in:

https://lore.kernel.org/virtualization/1698275594-19204-1-git-send-email-si-wei.liu@oracle.com/

and let me know how it goes? Thank you very much!

Thanks,
-Siwei

On 10/25/2023 2:41 AM, Lei Yang wrote:
> On Wed, Oct 25, 2023 at 1:27 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> Hello Si-Wei
>> Thanks a lot for testing! Please be aware that there's a follow-up fix
>> for a potential oops in this v4 series:
>>
> The first, when I did not apply this patch [1], I will also hit this
> patch mentioned problem. After I applied this patch, this problem will
> no longer to hit again. But I hit another issues, about the error
> messages please review the attached file.
> [1] https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-email-si-wei.liu@oracle.com/
>
> My test steps:
> git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> cd  linux/
> b4 am 1697880319-4937-1-git-send-email-si-wei.liu@oracle.com
> b4 am 20231018171456.1624030-2-dtatulea@nvidia.com
> b4 am 1698102863-21122-1-git-send-email-si-wei.liu@oracle.com
> git am ./v4_20231018_dtatulea_vdpa_add_support_for_vq_descriptor_mappings.mbx
> git am ./v4_20231021_si_wei_liu_vdpa_decouple_reset_of_iotlb_mapping_from_device_reset.mbx
> git am ./20231023_si_wei_liu_vhost_vdpa_fix_null_pointer_deref_in__compat_vdpa_reset.mbx
> cp /boot/config-5.14.0-377.el9.x86_64 .config
> make -j 32
> make modules_install
> make install
>
> Thanks
>
> Lei
>> https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-email-si-wei.liu@oracle.com/
>>
>> Would be nice to have it applied for any tests.
>>
>> Thanks,
>> -Siwei
>>
>> On 10/23/2023 11:51 PM, Lei Yang wrote:
>>> QE tested this series v4 with regression testing on real nic, there is
>>> no new regression bug.
>>>
>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>>
>>> On Tue, Oct 24, 2023 at 6:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 10/22/2023 8:51 PM, Jason Wang wrote:
>>>>> Hi Si-Wei:
>>>>>
>>>>> On Sat, Oct 21, 2023 at 5:28 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> In order to reduce needlessly high setup and teardown cost
>>>>>> of iotlb mapping during live migration, it's crucial to
>>>>>> decouple the vhost-vdpa iotlb abstraction from the virtio
>>>>>> device life cycle, i.e. iotlb mappings should be left
>>>>>> intact across virtio device reset [1]. For it to work, the
>>>>>> on-chip IOMMU parent device could implement a separate
>>>>>> .reset_map() operation callback to restore 1:1 DMA mapping
>>>>>> without having to resort to the .reset() callback, the
>>>>>> latter of which is mainly used to reset virtio device state.
>>>>>> This new .reset_map() callback will be invoked only before
>>>>>> the vhost-vdpa driver is to be removed and detached from
>>>>>> the vdpa bus, such that other vdpa bus drivers, e.g.
>>>>>> virtio-vdpa, can start with 1:1 DMA mapping when they
>>>>>> are attached. For the context, those on-chip IOMMU parent
>>>>>> devices, create the 1:1 DMA mapping at vdpa device creation,
>>>>>> and they would implicitly destroy the 1:1 mapping when
>>>>>> the first .set_map or .dma_map callback is invoked.
>>>>>>
>>>>>> This patchset is rebased on top of the latest vhost tree.
>>>>>>
>>>>>> [1] Reducing vdpa migration downtime because of memory pin / maps
>>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>>>>>
>>>>>> ---
>>>>>> v4:
>>>>>> - Rework compatibility using new .compat_reset driver op
>>>>> I still think having a set_backend_feature()
>>>> This will overload backend features with the role of carrying over
>>>> compatibility quirks, which I tried to avoid from. While I think the
>>>> .compat_reset from the v4 code just works with the backend features
>>>> acknowledgement (and maybe others as well) to determine, but not
>>>> directly tie it to backend features itself. These two have different
>>>> implications in terms of requirement, scope and maintaining/deprecation,
>>>> better to cope with compat quirks in explicit and driver visible way.
>>>>
>>>>>     or reset_map(clean=true) might be better.
>>>> An explicit op might be marginally better in driver writer's point of
>>>> view. Compliant driver doesn't have to bother asserting clean_map never
>>>> be true so their code would never bother dealing with this case, as
>>>> explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map
>>>> during reset for older userspace":
>>>>
>>>> "
>>>>        The separation of .compat_reset from the regular .reset allows
>>>>        vhost-vdpa able to know which driver had broken behavior before, so it
>>>>        can apply the corresponding compatibility quirk to the individual
>>>> driver
>>>>        whenever needed.  Compared to overloading the existing .reset with
>>>>        flags, .compat_reset won't cause any extra burden to the implementation
>>>>        of every compliant driver.
>>>> "
>>>>
>>>>>     As it tries hard to not introduce new stuff on the bus.
>>>> Honestly I don't see substantial difference between these other than the
>>>> color. There's no single best solution that stands out among the 3. And
>>>> I assume you already noticed it from all the above 3 approaches will
>>>> have to go with backend features negotiation, that the 1st vdpa reset
>>>> before backend feature negotiation will use the compliant version of
>>>> .reset that doesn't clean up the map. While I don't think this nuance
>>>> matters much to existing older userspace apps, as the maps should
>>>> already get cleaned by previous process in vhost_vdpa_cleanup(), but if
>>>> bug-for-bug behavioral compatibility is what you want, module parameter
>>>> will be the single best answer.
>>>>
>>>> Regards,
>>>> -Siwei
>>>>
>>>>> But we can listen to others for sure.
>>>>>
>>>>> Thanks
>>>>>

