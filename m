Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414597D59B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343902AbjJXR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXR1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 13:27:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE53133
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 10:27:37 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OHR96h008011;
        Tue, 24 Oct 2023 17:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=i75/UWfsjlOh0vJXh4uKwbSbyqg/lbbhmBAq0WlOiL8o0dpcjy/loWEu7x2jxuBo5L5E
 OtZSRsF5S51RHkMGgjNsD3Yhunryt0YFWUgvxcAtaZPZ6wqR8xMAhkpXbD+GkcYNzm7S
 aYeowi8/JVwk/rdHMRivKLjclhbeiFI1x/lt5iJvPtIYVWU5ZVXjf8JXH7r3p9tb+Hhc
 M60srZKnKahUj9yB7bAsAhp4+OOpiWe8QuUqhLMTsMf3t2dZIhxFm6XBadi92jaU30O/
 rm8SQ4b1PU3SF+MwikYNQ5cb//mJFE36X347lHT/Q8ys0tzVIMC4VFWVogS8YJeiwHAl cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5jbe1pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 17:27:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OH0ST5014155;
        Tue, 24 Oct 2023 17:27:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfjtwsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 17:27:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vaeemo1+iTXDM6iYi+a+xJjTLcm8Zu6MbL77t7iL/A7wQrupYcvz5t4mGY5hZg4ng6vrYM4jp+xDPWRq+BZqlbn6RK0iZajpFUManZ9cnhImSA2NuvLB2n7tDEqt1/tflMG4LvmOVQllHyQ2jvR/Njwl3s00dnBYrpAlbeYxw31xWDoPjTldgcGdC9ZwK5cKhxyN4ErSeFmWq58KYaDNVKQSgAmRO31B0vCzWsH+CKGyTPXTlH/74Bx8khRqhOWJOrfseNdQjz6uJ3jzxCNYaRJrhQmmwrRwJS/fUsBDFDWJy1yruDE7nsY4j60SKIWuuocxhRI8G25+bQFC3lfOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=bMShoVsgMDtHaAuNV0/UqMOBtuVDdGDZ4NlfpjZ1HM08/5y7nGfmuBNzyIZWRASN86xa0PMX4P0meux4pV2OYD0F6U+B/Qfk/yRABYKHQNGx824HhuM2wFYyHIRMWQbxtO1jVMTvHlnWo23AnedYfrzlyF+By2bagexgYyFY2eCIZ6Mjl9IBfF/JnomUAKCpSxa/Qpb1N91+b2UitgxsWQCocPwLSFRMK7GuxXBwJVPwUkSLzZRc9w9aYch0nKNdvJBiYsHtSn3L6RCi50HqZoA9zFlaZBsWZNvIhxMHPrs4jPNscrliRW+PxJodipLSy+DqbpKR62FqWRtRZeMlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ10P3zIuZisLoaveRHNnGUDtux4PE3YWfataqyyFBo=;
 b=PLFyPd9v3xyoxrk8k3et9JYxweQy5QNa6Dvg7h7ofcipn5D0mQTFPbXNa7wFnmkNZ/xxzed/0UuDnuPWcuF6TCF3Gz/0ihzz8j9+Uuqrcv0YDA+vX06tc4gd4qC7F3iiUr6bw5E2CDAsN/ufenF8sbszv6evI32EUbn7XfN3I+c=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 17:27:29 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::3942:c32c:7de0:d930%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 17:27:29 +0000
Message-ID: <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
Date:   Tue, 24 Oct 2023 10:27:23 -0700
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
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|PH0PR10MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: c7bc4028-6bdd-44cd-8e74-08dbd4b67f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRTzHhegye2klZzW74hh8jBU2fDgkyjUkZ2N3nhq8V55v8jWlcPEAR3VpGuXCkJsd3D1xIqBdbQhVXYKTTCdCb8HAD50xTPx7uOjooJGVAFhDzDQkS3kzQ9cVAh0SF4PNcbjlPKrW7GkC5CU9r7z/0+CCHzYt0GLSBu4SVh0PuS1d3gQgbgjjjQSBdhpB6xOCSTV6ATYnsKa3hTg3n12D78IJA/M5hy4HQinF0FoBB9ZJeS/IrgQ5Hzv8HtmKffxz5Vtgb1vj3Yv2GJ96fW6F0qYdIatm5my8Hl8yy5NVptWxke8CBYbU09UjaiV9Rw97dVaJKNYFD+U1Ifv56FAYfRQcifQImw9GLI/ofiFg8DSLWDUxPZViDlT0ab28Bpgg7pgWYSJpc9ryOBFr00P3VN+DeMPbFP53gjNbZAsJkKUKAbOF2Q075/a2MxRyrzMEj4aM8oqVbqLv0wAIFxn53GiiWptgWdDs5xqKD9jgQokmN+/4KmQVczmjid9h6NJ9OX+4fOvdTgfM+kmrB2dLGz5gLfOeuJIPZFlDcqyrPSKoZ1Wx88wYkV9z6atfInxYfwSew32LqY3F5PEqXgE7a1ZmnrtRNHDYTNZwKrWqWGqYa+3guoDe3Jf1u0W0ZJEum5PFfTb4Mmw4ujZnCJ8qPKrW2a8ceOHuQl7ywe46yk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(26005)(6512007)(2616005)(2906002)(316002)(66556008)(41300700001)(66476007)(4326008)(5660300002)(6916009)(8936002)(8676002)(36916002)(53546011)(6666004)(6506007)(6486002)(66946007)(478600001)(966005)(86362001)(38100700002)(31696002)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzE3TFNSNVlCQlBnUWxXcGRMdGZoOVRGMU9RZHA5VkdGR0lSRlZlZUs4T2Z4?=
 =?utf-8?B?U093OVpzTWVJWnFVN1JkYVRyL0gvWTVCcVlVL0VXVnJTTzZlWjRNZVdEWnNw?=
 =?utf-8?B?bE1aTzdsNjI5dS9WNFVVekNLWXhra3FGUjM5UFA3VjhSSW9EVk5Gb2ZTdGI3?=
 =?utf-8?B?Y1VLMmczNEpQWnJnZW5iNnJCaWhXT3pSbkwvVUhCMHdXTWV0c3NRWFFQNUZO?=
 =?utf-8?B?b05sNUdidnJ4dStVeUN0L0ZKN0VJWFVSWnl1NG5HZmRFYnhxdG9kNVl6SnF4?=
 =?utf-8?B?YUEzSEIxbzZ2YjY2cGZkYnJldkJScktMbVNueU5pdVNnMkJ2Rm5LTEtJc0xl?=
 =?utf-8?B?OG9GZCttTS9MK3hTNWRtcmVTMkl3VHQ1VGR1endUNlZhS0hRd3FoenV5Kzly?=
 =?utf-8?B?U0t0Z0hGU0lKUndaYzl2b2JMVEZiVXJCNHExVUQvSkowdUFkZWgzUjBDbFd6?=
 =?utf-8?B?bFhLUmJBekZUZUlLR3FxMWZvdjBlRHhCU1V0L1hVbTdsY0ZiWG9FaHlmSG5K?=
 =?utf-8?B?Slh0UGdlazA4RDBsVk95aHIwV1BqNHNpZVdMWmViMSt6UEFtQUc1TytqVElk?=
 =?utf-8?B?WkxEYnVNdW1sb0J6LzdJWHJQUzRja21LdXZRVW1jSE90dXRTUjlqUFNBOExq?=
 =?utf-8?B?VWY1ckJRczdxb2hVUEU0WFhUNyt5NEIwK21NOUlTak01SFBWa1oxcm5aRFJB?=
 =?utf-8?B?WmlxOHZxaE5ackNmTHhZaHNIV2J4YnFHQTdhTDFWbDhoU2RiSFZzaGNjUWM5?=
 =?utf-8?B?Z3gxN0JBa0JaVU12UmthcmRRTUhwdm9ySkRtZURvbGtSZThHMldDTEROQ1Vi?=
 =?utf-8?B?OGNFN3F4c0dsTGxLSDRSR0xqQzdrMzg1UXNxVlM1OWh3c1l5M0owN0VpVzgx?=
 =?utf-8?B?U2t4MnBOaUhqZUVNMlhSRGduQjJlUHNreFYvamt0eVpPZFRoT3kyNTJkaDNE?=
 =?utf-8?B?aEcrWDRjWi9XczA1NWNRcloxeFlEUGJLcjNnNDM5M0w5ZW1aY1ppUlFPdUJz?=
 =?utf-8?B?VG1pOWZOdXhGdXhWazVIS3RJUllxK0xCTkVpVWdaWWhkbzZuWXpCUElZMTc3?=
 =?utf-8?B?WE5Zd0RwcVVNNHdVc0tYNFc3SC9lWERQNDBXa0pDOTFOS2Z3TzBtd2g5UW1y?=
 =?utf-8?B?L2p6endGMEc0YjNjaHQyd3grR1ZzVGRTeXd3MFBKUC9EMWxaRG91NmlvM0da?=
 =?utf-8?B?VVBrQXBXeXZDUTdCV01NQjk5SjAxbDV6RjBRUlE0WFRPcGYwRjdxV3dGUUZP?=
 =?utf-8?B?NVFNcDI0RWhOUDdXV1Boa1Z3ZmVyTEFZWEppck5jN2UxTkJzZjg2bGNDLytT?=
 =?utf-8?B?bmp0RlBCazBZc09Ca3RNVm5sSnA0YlllOFh6WmVwRWIrTzJGVmhyZUFjdXpT?=
 =?utf-8?B?UVgyRlRKanNhN0ErWEFoOGdhdmJjT2VWY0dWNmJHejUyR1ZmU1JUcm5jbDhU?=
 =?utf-8?B?S1lybGVWLzlqOW5uVnYxMkZsQnZLWVJ2SmpsKzZyanRZTUkwaFJURGFMKzM3?=
 =?utf-8?B?WW5GbzBNQVhnSWJwSjRWakVrTnVFb2lManB6ellNK0MzVW1zTlQxWUhMUDkw?=
 =?utf-8?B?TmRZQ09ObW9XS01aM0tnK3BJS1RjLzlTSmVxZWs2M1UvTnVTalk1bk9qV2hE?=
 =?utf-8?B?ZW9XV0xiSmIrOVpzMXlqTVB0YmFKcnpkTnpGUVB0Vk4rNE5ZdG5LemdEUml5?=
 =?utf-8?B?UndIKzl4THZCZ1ZmSENEZCthWU9qY0x5emVFUHFZZk1kaWx3NE5DSWEvUWFU?=
 =?utf-8?B?UWk4alVGWVdQV0dxckRUYUdldll4TlNWSlJUY1plVHdhTlJ3OXE5SFg3bHVH?=
 =?utf-8?B?UDhmOVhueTZZU0dCYzBQK1cxelIyS2JZazYvZCtaOGtqRzZVWGlqUThYL0Vl?=
 =?utf-8?B?aUp0NGRPSkhJWmF1Y255dzFJZmlpNjBvMkZZVUZ5MGVNVzNLY3g3ZGVXV3Zt?=
 =?utf-8?B?aDhIaHZpSng4TXFGQ0VvM09TNEc3aG9yS3lsbDBtZGRqTWFkS09RSkdxTzZO?=
 =?utf-8?B?b1ZIdHJ2dXhjQmg4MDZUbWJiTmRxY21zWVViaGFPQnFob2hqdDZhZ3lnMnRq?=
 =?utf-8?B?T2U5RUlmSHlYaFpXSkxlQ2tjL3R1TEYrR3RrTFRCcFNFS2RYdkdyTDJJV0wv?=
 =?utf-8?Q?zJ9YBVBUOS+uv3uLzITUZrg2H?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mN5xipHj1RVOQjckVmcXAIsyRX+2WEYIqw6TYVueIecfP4vhmQ+5FWsCq5HCDRbPzAlwrlJLbglnLmb7RDqReWVtF1Mx5VJrROxZrM9ndlVtN+UMyxDPTP7sFbjDVMCKyxtSsrO4NHjfd3pIbNJpb7VuFredW3xvmUBajKcUhpzd5UvXRD46DmW49ZTZc1uhEDlSWjscWFmQSf8U04DvJQse9Z3uuEHopIOp/S6fku7W1Uqn4eiYhGG8zjpgk6HpJXONMfww9KVosreXvVJZPELF8wbeX+r+h5bRys5YIaspJrUfO+LB+XHSO+y0qgl1v4po1NtupczSh/2XO/L5r7WEVRDu7thNRSc8kThGHP7fJ8SeZ+S4PwI/7rzgjGrJgCuMIwY+YayR0I1tBvyDfbkIq6PnBxOU6WOnNWqLeYADpFCPaIprg0ix+1OjC29tp2fOLrupJxp0wgpdkBDBP1cG8CvDeIjqD6z/Td5r+I1gmOIXJOnOZrmTMNpyA7AbaSHL7t1I2mWjj1sJEREdgJwEehb3vUXyxVRNlxMZTzC4X0fsoxFFH4zN7EJ8Jh2pLJCsBBXn0a+mIuCb92+6wUVn63q8hZjiuvDl2nFad/9wiDrfxDS32ZkRUErWLBd47tpH1cyZpUQrgUIL1edYI26Uekf15tRPWcDOo5/QkqotDGheG1zYE4KaBfnTzI+lkMlH84QYOI+F1U8JNiWcBwHB8UtfWrDTG3QvTJQku9PlJe2m4UxxugW4CZddPL9sducfvPw8J9uxWH0cGGmFmoeNJ7WOoDEJjUhMHMRmRdoL9Rkw9LCi59qUxCr1Hv0M6YEXhJ/tLUNqD4Ra+F8PPhwDzNfRqr4QNXAiZI0QYjoIOfzYy8H6ZFYDNNJy3DG89PXYwe7XFqKqKRcplUGSBA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bc4028-6bdd-44cd-8e74-08dbd4b67f2a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:27:28.8135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+eWVP2Upvg1MhfaIhmYP81fqASvcNSkH3Pkgc/BtBEOdLEfgfycUo+yHHw39iko1uDw2/Mxa51QbKFJkJJXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_17,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240149
X-Proofpoint-GUID: Z0IMQNs5FYbqC8j_1X19yuN1j2PeGBn1
X-Proofpoint-ORIG-GUID: Z0IMQNs5FYbqC8j_1X19yuN1j2PeGBn1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot for testing! Please be aware that there's a follow-up fix 
for a potential oops in this v4 series:

https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-email-si-wei.liu@oracle.com/

Would be nice to have it applied for any tests.

Thanks,
-Siwei

On 10/23/2023 11:51 PM, Lei Yang wrote:
> QE tested this series v4 with regression testing on real nic, there is
> no new regression bug.
>
> Tested-by: Lei Yang <leiyang@redhat.com>
>
> On Tue, Oct 24, 2023 at 6:02 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 10/22/2023 8:51 PM, Jason Wang wrote:
>>> Hi Si-Wei:
>>>
>>> On Sat, Oct 21, 2023 at 5:28 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>> In order to reduce needlessly high setup and teardown cost
>>>> of iotlb mapping during live migration, it's crucial to
>>>> decouple the vhost-vdpa iotlb abstraction from the virtio
>>>> device life cycle, i.e. iotlb mappings should be left
>>>> intact across virtio device reset [1]. For it to work, the
>>>> on-chip IOMMU parent device could implement a separate
>>>> .reset_map() operation callback to restore 1:1 DMA mapping
>>>> without having to resort to the .reset() callback, the
>>>> latter of which is mainly used to reset virtio device state.
>>>> This new .reset_map() callback will be invoked only before
>>>> the vhost-vdpa driver is to be removed and detached from
>>>> the vdpa bus, such that other vdpa bus drivers, e.g.
>>>> virtio-vdpa, can start with 1:1 DMA mapping when they
>>>> are attached. For the context, those on-chip IOMMU parent
>>>> devices, create the 1:1 DMA mapping at vdpa device creation,
>>>> and they would implicitly destroy the 1:1 mapping when
>>>> the first .set_map or .dma_map callback is invoked.
>>>>
>>>> This patchset is rebased on top of the latest vhost tree.
>>>>
>>>> [1] Reducing vdpa migration downtime because of memory pin / maps
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
>>>>
>>>> ---
>>>> v4:
>>>> - Rework compatibility using new .compat_reset driver op
>>> I still think having a set_backend_feature()
>> This will overload backend features with the role of carrying over
>> compatibility quirks, which I tried to avoid from. While I think the
>> .compat_reset from the v4 code just works with the backend features
>> acknowledgement (and maybe others as well) to determine, but not
>> directly tie it to backend features itself. These two have different
>> implications in terms of requirement, scope and maintaining/deprecation,
>> better to cope with compat quirks in explicit and driver visible way.
>>
>>>    or reset_map(clean=true) might be better.
>> An explicit op might be marginally better in driver writer's point of
>> view. Compliant driver doesn't have to bother asserting clean_map never
>> be true so their code would never bother dealing with this case, as
>> explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map
>> during reset for older userspace":
>>
>> "
>>       The separation of .compat_reset from the regular .reset allows
>>       vhost-vdpa able to know which driver had broken behavior before, so it
>>       can apply the corresponding compatibility quirk to the individual
>> driver
>>       whenever needed.  Compared to overloading the existing .reset with
>>       flags, .compat_reset won't cause any extra burden to the implementation
>>       of every compliant driver.
>> "
>>
>>>    As it tries hard to not introduce new stuff on the bus.
>> Honestly I don't see substantial difference between these other than the
>> color. There's no single best solution that stands out among the 3. And
>> I assume you already noticed it from all the above 3 approaches will
>> have to go with backend features negotiation, that the 1st vdpa reset
>> before backend feature negotiation will use the compliant version of
>> .reset that doesn't clean up the map. While I don't think this nuance
>> matters much to existing older userspace apps, as the maps should
>> already get cleaned by previous process in vhost_vdpa_cleanup(), but if
>> bug-for-bug behavioral compatibility is what you want, module parameter
>> will be the single best answer.
>>
>> Regards,
>> -Siwei
>>
>>> But we can listen to others for sure.
>>>
>>> Thanks
>>>

