Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0667B7170
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbjJCTBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbjJCTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:01:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5981DAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:01:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4Jpc013141;
        Tue, 3 Oct 2023 19:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/jR1LXBDziXhzwnZgH5H8BRWg2qAeMu+sKiYU/0Tfo4=;
 b=gcUS1wVty/MNX87z7bQbhOuahM0bmgJSwTl6TF6Se865cLG+Y4I4tR7K/rjh4w0gBE7g
 fAb9VzwSequCatLgawfcIXGWgeUti41nJbx+IMwmozMfVaBlmcI5NIFgdCIQ7GijQRhL
 DlEuhD480wNmQd3kHTy7a+4TbbYx3Me3x4xzmELwCIETTvUV3096vx67pBAplI9zVMbw
 jszQ88Xt10zAWmmGTy8xkJvrP76M4eomibfuJo9kfP0kvCJYIPnQqI7yK+XA4/hdzDL5
 5/dmIx9r0Ek7z+UgUjv576UD89dRz2kYuH7Q4sT73g6LtlwHfrDykY1x3Y5+qB45jbFb SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3edgf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 19:01:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393IXWrF000483;
        Tue, 3 Oct 2023 19:01:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46e2s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 19:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0pTgcZfqXpzKU3XUC/pI22V/dso3G7WKJme3SDE1cUUG0JPPUB5tn4dZMRBM8JpwfUkFDPSh9WucMvIN0fCxFdxuYLJvoMegFhI/Mi0AakwOcIXeUgSxVexhM1QDMnxQ2XvQvke2rhvJMJvGxiJvlUVmVJJI3MaeIfLL0jHxQ5SmkoCmoHuopTH7byHYXVzlybvaz6MluKRqJ3E8XqGzbHBv3aiwZXy5unx990CXjnL3oztxzqE3rwBIZrm8mrTtj4/tGp/RyqxJq7AyxerFMAs4ZxJDSXcZWRitwVjlgpDVlQtvQrRPJ0Es3/70+kJuaGMHeaT5cNWgHhWx+x+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jR1LXBDziXhzwnZgH5H8BRWg2qAeMu+sKiYU/0Tfo4=;
 b=OLPG2VoUme/CYZylrW3hNpKn55ZhAdu7DQy9MpZhp3NyKZew+Spm6kmMKXz0GIyIGuJyhpWqMDsJolpUCkQ1JMJ/OfubF2z5jj7d04FmvUABmyv+TNy59EmVAndwLskWJLpVZTLSKcBy8JxBwhNMZEa7klvhm8ybHvxEiOipFRRvf1l4MaFalH2e2xpxDweLCGiW2rAW9SC0Uy64z+1HUflkAzMB65nLo59MmbAupirVXcpJAD3Febml8iidg2Rv7xUHA2hX+Z5YXe3ywtY4XHiI7Ib3dWJNozMNOOBoWRnAk7J+Q+MZ+YSQJxCJF0UTXr000dG8kdbbddaXC43S9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jR1LXBDziXhzwnZgH5H8BRWg2qAeMu+sKiYU/0Tfo4=;
 b=EjOeN0OwiJQcm1TaLlLhDp2NOdOY/DUMucalfeA0jPmcloaRi3vyJ1eQtP94SCM6mT5xYeM04G7FFX6q8R/3ne/SiebYMBSFLfx/g5UaaMCjopfB08DZtfzpC+gHAfi8eoCbll0q9nQ8hZUkRAs21rpwMSR1n8utQ0F8Q6hs7a4=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ0PR10MB5549.namprd10.prod.outlook.com (2603:10b6:a03:3d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 19:01:09 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Tue, 3 Oct 2023
 19:01:06 +0000
Message-ID: <15dd5828-c820-4d6b-bd1d-ada227582e6a@oracle.com>
Date:   Tue, 3 Oct 2023 14:01:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230922120341.10805-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230922120341.10805-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:610:52::25) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ0PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: 3795c465-1e35-4c03-69e7-08dbc44318b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0ExNmg4aTR3TTVNMkVGQjM4VTEzbzZxSzNoRnJ0aWt1VDBCWUJRWDcvdEZa?=
 =?utf-8?B?U1VjTVVycGxpN1B1NDdEUjdmVXdRZ2hnUVplVURZQituODNuMjUzY1MzVCtr?=
 =?utf-8?B?OFcyQnpQWUZ2VHBLMzZpeTRycTI2SDhQNE93bzYwajZ3ajNkTHIyU0hnQTU1?=
 =?utf-8?B?aDdPM25nMFJhdDFsSGZUWmpUYU1tUEpOVnJwME42TkdGUndhd1o5RTRZS0ND?=
 =?utf-8?B?dXRYM0I3SytyajZva1hLMDkxYXNjVmwyZitKQjB6Um9tSi9RcTdlRFVrUE1C?=
 =?utf-8?B?aTJEU0lLcGtoYXNybWFONzlQV3BZakI1LytLQjFGWWZGLzN1MzY1VjFiSGhN?=
 =?utf-8?B?ODhFQlkrcHNiL2p0QjJ6WThaai9yeDVwRFovdVltVzFNWjRjYjloYzFlVWha?=
 =?utf-8?B?dXJMbDFTUDd0OFlGZUJRcWhYdzM3eUVFc2lEanViQXUyVXBQMC9pdWQ0amFO?=
 =?utf-8?B?Y3FwK1ZJV0hiYlQ5SDZFV0Y3cXZldVdCNG1zWHE5ejZ2RTZZRWY2NTdpRzFz?=
 =?utf-8?B?L2lZSFJxY3NGbDFpRXUyVEpUd2hBdDVaY0lrZ2FDTTNvQTBPVVlNaVdDaDFh?=
 =?utf-8?B?bEZjbHhybE04clR5S3FEK0J4cW4xN09oWmd1TXlJRGNsTS9Rc0VMQ25Xemd1?=
 =?utf-8?B?Rm40RDNJdHZFdWtFOERvUFA0WnRJZ0ZLdXJtVzd2ZTJYYk9UNVBLNFlsZTd1?=
 =?utf-8?B?UW1WUU9VcjRETlF5VlhYZXJ4YnB1eUVBM3FJZ25ZYmg3U3ZsRys0VWEwUFZo?=
 =?utf-8?B?dnZKS0VMUHhjL0t5a2xuRU5wU0IwdkdSOURBRlZHRFlIY2E1YSsvM3ZtN09Y?=
 =?utf-8?B?OVBsc0cycjJPTjJiamdtK2FMb0NabSs2bGFGNDNpcnJVZzVudCt4WVoxMy9m?=
 =?utf-8?B?NzZ4dGY0eEtXcVRJT2txNHJXdnFUSW9DTHJrWDg0ODc2UkZkNnZmWVJHc3NJ?=
 =?utf-8?B?STE4T2QvSHMyazJNMDluZGQ1Y2ZhbEFScEU3NnQ1T0xPZkJ2WVlxaEEvSENx?=
 =?utf-8?B?MW5mRkorYXI3UjB5M2FDU0c2eWRIUmx2UjM3dTJ3dWZXdkRZaGVGUHFiNHZ6?=
 =?utf-8?B?MlFqQW83eEUvRHJjK2pGRG8xVTliRXN2cWttVFpycUJjLzBDUEJWZDVUUEVn?=
 =?utf-8?B?K0wzMEMrSDcxWjF1OGQ1K012NUN0TUJ5YzJlY2hmV29kZk9PVWJ4QkVmYllT?=
 =?utf-8?B?Zno4NC94YkJSYVZPUndueDBzYi9GVnZPSGp5cnAreWJYQ0xPTzdKQjIrUkJM?=
 =?utf-8?B?R2lCRTZkaVgzOElSTHFvdmtrbXhENkR0SlByZUNET3g1Uk1rZFJYeDJBMzc5?=
 =?utf-8?Q?On44InZ4xC5V8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(44832011)(5660300002)(8676002)(2906002)(86362001)(31686004)(31696002)(6666004)(41300700001)(83380400001)(6916009)(316002)(26005)(38100700002)(66946007)(8936002)(4326008)(66476007)(6512007)(6486002)(6506007)(2616005)(36756003)(966005)(478600001)(66556008)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdyRHRYNmdobjRMbzF4b0tSNkptWGpuajk1QW9NeEoxeWdzUTNSQmQwVklQ?=
 =?utf-8?B?YzIvTTN0NmJSbFd1M0FmelF6Zi9hR2VuaGpTNXROZ1JMZHIyL3ROTjRIN3FH?=
 =?utf-8?B?bXF0L294ZXN0MDdXYXEvd1NNUS9lZy9NU0hoc2ZlMVR3NTgwYUVHZHVud1Jh?=
 =?utf-8?B?K0JWWThhTzNCZUErM29GTG1nVkxKY0VZdjA4NmhLeXBOZ3RhOTZjTDM4SW8y?=
 =?utf-8?B?SXByektPZEozdXBrZlY4ZFRDL0RicUQvazN4S1ZxS2dJb3dOU3hjVlpDakU3?=
 =?utf-8?B?Z0JTcW1sRStMcVNuaDBJd2VVbE5KNDI3a2lUMjI2NGJtdjhaclVIREYyb1hD?=
 =?utf-8?B?UUp5VzFlQ2QzMWFYc29ldmNURVF2VDh6Ky83R1crcTFjNUlQOVBmN1hGSzhz?=
 =?utf-8?B?RnJhRnl0S0JGbENRZ04vaFdvYjg2QkdtMVdIY09COGpTM2s0aWQzZ2hQa2VR?=
 =?utf-8?B?VE1rdlMrdnlHVDBJTEp0UlE0L2JHWTlrcVhQcHlGRGR3TnNaa1N2TDFId2h1?=
 =?utf-8?B?bTA2Z1N1VlM2MkpJNGszTUs2THRoeTFqd3ArUjlraW4xZjluOWpSTVBOQVlw?=
 =?utf-8?B?U0s1YlUyekFWeXJ3bTZHQ1BaRVNYbkNBUDcyVmtGaS8vYmg1VUlaUENpcUMy?=
 =?utf-8?B?bmNobnowSXY0QWNRV2JWSTlkTmNJTlRZM1k3c3lUT09nTG1SSjVXeHkzZ0lw?=
 =?utf-8?B?aHhKMUZ6UCtOdEI0anRZYURuK0xibko5R2hDaDYxbHVNUzgxY0cranlwUXd4?=
 =?utf-8?B?S1NRUUVmRnFRbVQzY3UrUUJEL2srdUxhOXBLQUdVWUc0eG9DSHVidFJscmJG?=
 =?utf-8?B?UEpPL2hZdW9yblNYNzRFTytDVkdtWEVkMkVhS0JzZFpvd1N1UWowNlNVQ2FM?=
 =?utf-8?B?Y0NEaUFnaVhVUkc2S2VOTi8ydkFvQ1dUeGd5K3lYZG5EbkVJQWdrSWhWTVhM?=
 =?utf-8?B?OVFRNXNGd0s2UE1LWE5zNUVNZmUzcGVoQ2s0aENtK0g4ZVJCZUpLTTZMMit6?=
 =?utf-8?B?MlIvbWRDQmVBN2xqK2YyVjZST1J3YnJEVzI3NG4wd0s2ZUFydUpHcjVtTHpQ?=
 =?utf-8?B?eWQyZFpaOTJtZ2h0a0d0elc2NWxldFE3VTNCMThmWkVIRVRTWGx6OGpuaVhQ?=
 =?utf-8?B?R2J1RzU2UGV5S1JtTHFLNzVFNFRHbms0YkdjRVRucFhUd2hWRlBvMTkyaEpw?=
 =?utf-8?B?dDViSTN6YVhPdklSdk1KaUswaXZWaEhkVWE5T2pEa3NCTlppUnR5MEY4amE1?=
 =?utf-8?B?TEtkaXBJRytKN1FnVm9ZdUVwZjcrVWZHaWJSOXhrdjAveHozeEc1Ly9nU0Q2?=
 =?utf-8?B?N216cHpyL3lxMGIvUUYzeGs2T0lCNnlySFVJT1hFMWVCaWxuZEdQQ1hJWU5T?=
 =?utf-8?B?bVNUd1ZyKy80MmJydjd2c1BLNndySFJHTFBUS1ovL2IzM1o1ZW54WVl3L3BT?=
 =?utf-8?B?RFU4Q0ZuZUo0YnB3cHIzWnNISU4rMCt6aEg4YkRkbjREYm5UYnNWamkxMnRC?=
 =?utf-8?B?SmJ2NDZldTM5bW9zN0ZtYkVwa1NIQlpzaDlwUTdXeTJYUHNNblNiVEFUK1VE?=
 =?utf-8?B?MnVOMzloWVU1WkxXL3R2YVFNNVdDZC9OdThUTUxJQlQvSklJc3hhMEFTMC9R?=
 =?utf-8?B?QTIzRmMvVDQzZWh3azB4UUtTeU5RTGRDblpQVHVKM01XUzA3VjhXYXIwSXNR?=
 =?utf-8?B?ZVhWQXpZakpRSDdiSUYyTVd1eXBCclRoQXpWL0hLbWVlQkhjNytLaXNUTkww?=
 =?utf-8?B?dG41NmwvQ1lJaHRUSTZkUHVVcGtoU0R1ZFZ0VS83UFRqUzZNblpFUWJzRVBs?=
 =?utf-8?B?U0puemJmZ0E0M0Y2T1FJakdlMXlZdEE0RTRWR3Z0RlZiWU1jMFNmOStybUJv?=
 =?utf-8?B?TmtFdnFmNGR6Y3NFUmRORUFHZ3ZzTEhWR1U3UVc0aDRGK3BCWTQ5dXVzcXht?=
 =?utf-8?B?QmFiN0FBUHVtSUh2dmd5Ulhuc1RCRjhVREZrZ0NNeGF5aHU1ZXVmK3hsdXBk?=
 =?utf-8?B?aDFWeTYvT0x5WE5NQlk0S2hnMEpqbjk3QXVsNDNVeDQvSkpsV3dYbVlUaVFl?=
 =?utf-8?B?YkRWdHlJc1pURFN0NHNIU3djTmRWTmFTNmxkZXdyZW13RGJManFMQXJBbTI5?=
 =?utf-8?B?ZkNCS2lxNmZHSXo2bVMxbnZ5cnZBV0JWYmJqaHlLMFhWSnFQWXJEY1NvZ1F2?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZWEzdWZlZHAzRGEwVVdWN2ppQzVXTUJuNlIrcjdqRG96Nk5pZnpEV2JXU3ZJ?=
 =?utf-8?B?QnJ4ZE14YndQOEhBb2tqSDA4S2dyU25IOGhFelhhMjJnY2dZK2ZCT1diSjUz?=
 =?utf-8?B?dG15WmJ0dEdJUE5IVS9seSthVWhYd3VKeGU2ZHJhbG1Mbi96L3NwUk5zREFi?=
 =?utf-8?B?b3NmdThoWmdGQlNoaStzQnc0SVVUNWhPRWhQa0tVQld5MlB2TFBCL1ZuWkpm?=
 =?utf-8?B?RDJUeXJsU1JnSWM5SFNveWtVdzJadHNCZG1RVHNaTHVHczRwRW5tVjdWL0hQ?=
 =?utf-8?B?Y25PYkxuVDBGZzhzNmIvQkNzcnYvQnEvZXVORktsNWY1eVpTMUpaMGNzMk51?=
 =?utf-8?B?RUlXQ1BWZTVEZ0ZMcDM0OXBoRk1kV2RqVmw5U0J2aGxQdU9ac0dmc3dRTDJE?=
 =?utf-8?B?Z25mT0J0ZXRFV3pDanRMZXRQQjZCNG9LWFhFUGJYZjE4RHVkalpJNk9iWUlW?=
 =?utf-8?B?U3hYSE5PYWhhd1JoWDVCU1NldVhXanhNc05lbXZyM1NNTGp3YlRrT1RTRDhO?=
 =?utf-8?B?d2dMRVFrV3VyWkFTMldLOHlOM2orWFJBTmVSMUwva2FUVHltZmVROXROMnNW?=
 =?utf-8?B?NXdpYm9XMmczNDUra3RueEJ6V3FYY1l4aEYzL08wTzFLdUk0WjFrWDI3V0pC?=
 =?utf-8?B?SVVYWFhpOU5OcjBnc2ZRZUM2bE1BYXErT2ZZV3lOWjBIUDN0ZHNxRU12ZHVJ?=
 =?utf-8?B?QjIvZG11RjdsWkZxTzlHeXhJb3NjRkxsYjNJN1pjam5lcTJxd1NvaDAvNVFq?=
 =?utf-8?B?S2QzaUVFYXo1SFBGY0VoVDRneHN0NDY5VVM5UzUwdzloVldmRXl1T2h5czhG?=
 =?utf-8?B?R2YyN2hrQ09ReTRsM0RoeVJCMlZ2L1lzaEpnMTBHeGU4Tlp6RCtHK1pqcFZP?=
 =?utf-8?B?bmlQam9NU0ZTSGNjMXlsTisvQVBuTFU0cjJqbkNOV1ovL0VzSXV0RUY0ejYz?=
 =?utf-8?B?dGJGbm93Z2Uzc2Vud1FBRU9ORitVU0JCcHRHQUw1dFZieDY1Qlc2QjhQUHdF?=
 =?utf-8?B?dE1aL2lTUTJNTVAwWXdjNTFya01rcGJOdmtIRG5uQ3BycVMrNjVmN0xvbUdH?=
 =?utf-8?B?bWk3N25jakcvVi9TRmkzWC9RMStUQVpVTTBXWTZNRjN6WE11bjhGeWJOTFBT?=
 =?utf-8?B?NDluMWtSN2VBK1Vab20xMTU2bGhtYnlNSXA4aEU0NHNDTzVwTzJtK3RGZ1lW?=
 =?utf-8?B?cWtDNXROLzh3THRyczJUR2RETFNjMlhyZ1FMRGdzQWJheG5taUlEWWc3TDk0?=
 =?utf-8?B?Q0VyeCtHR1o0aGtWSW1oa0dQMEFhU01hRVhUQU5kNndYTmhkTmNCT1dsREZr?=
 =?utf-8?Q?BEhAnfzzyXF5M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3795c465-1e35-4c03-69e7-08dbc44318b6
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 19:01:06.1116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opxt1Dl2yeqTGEFBALQbo7xhY02jYVRlO6isVmjeHq1CtFm9U3rbZ1aac4op4nHCALFC2VFgw1CotUYdxwXvWliDJ56Q5JULPPOP6YSeWV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_16,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=865 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030142
X-Proofpoint-ORIG-GUID: lcymveUZlEQk96yawZtJaKjCeOigOCtU
X-Proofpoint-GUID: lcymveUZlEQk96yawZtJaKjCeOigOCtU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/23 7:03AM, Manas Ghandat wrote:
> Currently while searching for dmtree_t for sufficient free blocks there
> is an array out of bounds while getting element in tp->dm_stree. To add
> the required check for out of bound we first need to determine the type
> of dmtree. Thus added an extra parameter to dbFindLeaf so that the type
> of tree can be determined and the required check can be applied.

This would work, but the new argument "type" isn't descriptive. I'd 
prefer it was a bool such as is_ctl or something like that. The 
alternative would be to define two different values with descriptive 
names and use them rather than 0 and 1.

Thanks,
Shaggy

> 
> Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
> V1 -> V2: Updated dbFindLeaf function.
> 
>   fs/jfs/jfs_dmap.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a14a0f18a4c4..cee5164c4879 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -87,7 +87,7 @@ static int dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno,
>   static int dbExtend(struct inode *ip, s64 blkno, s64 nblocks, s64 addnblocks);
>   static int dbFindBits(u32 word, int l2nb);
>   static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno);
> -static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx);
> +static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type);
>   static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   		      int nblocks);
>   static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
> @@ -1709,7 +1709,7 @@ static int dbFindCtl(struct bmap * bmp, int l2nb, int level, s64 * blkno)
>   		 * dbFindLeaf() returns the index of the leaf at which
>   		 * free space was found.
>   		 */
> -		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx);
> +		rc = dbFindLeaf((dmtree_t *) dcp, l2nb, &leafidx, 0);
>   
>   		/* release the buffer.
>   		 */
> @@ -1956,7 +1956,7 @@ dbAllocDmapLev(struct bmap * bmp,
>   	 * free space.  if sufficient free space is found, dbFindLeaf()
>   	 * returns the index of the leaf at which free space was found.
>   	 */
> -	if (dbFindLeaf((dmtree_t *) & dp->tree, l2nb, &leafidx))
> +	if (dbFindLeaf((dmtree_t *) &dp->tree, l2nb, &leafidx, 1))
>   		return -ENOSPC;
>   
>   	if (leafidx < 0)
> @@ -2920,14 +2920,18 @@ static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
>    *	leafidx	- return pointer to be set to the index of the leaf
>    *		  describing at least l2nb free blocks if sufficient
>    *		  free blocks are found.
> + *	type	- type of dmtree
>    *
>    * RETURN VALUES:
>    *	0	- success
>    *	-ENOSPC	- insufficient free blocks.
>    */
> -static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
> +static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, int type)
>   {
>   	int ti, n = 0, k, x = 0;
> +	int max_size;
> +
> +	max_size = type ? TREESIZE : CTLTREESIZE;
>   
>   	/* first check the root of the tree to see if there is
>   	 * sufficient free space.
> @@ -2948,6 +2952,8 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
>   			/* sufficient free space found.  move to the next
>   			 * level (or quit if this is the last level).
>   			 */
> +			if (x + n > max_size)
> +				return -ENOSPC;
>   			if (l2nb <= tp->dmt_stree[x + n])
>   				break;
>   		}
