Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A007DE44D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjKAP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjKAP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:57:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F8E4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:57:35 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1AsDjA011467;
        Wed, 1 Nov 2023 15:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7Z7xhvMhc2TrFaZLkyhkGd0i6HOQI+bNexvE3KRaQp0=;
 b=FTP4BfSyWlboxG1PNnlCePC0uXJ8x6nOkNUKBn9THqKQOyM34jCQL1ppgADyVi+CYE4G
 Bkr230GZkFK3PKKQv7NR+suXZr52QXvFHhNxJcpXcet/UUbW2vivKMYGtU25pCp4XPfm
 iQLhmUCFJ5C06nsngHqwHqUhOwN0B+DgiggictATUewzAPNAWOmOWuS47QqLtnWAsTWe
 Cd+B9Wda0VGTQzw7jJNAOa7HJSFQPo1VUd2IA3yQuqu4RlIi43kEpjDrxBSc7q32pl4p
 YcdjNnL57oj8cjvnHw3iy7bnvPUvdjp9GXOVrMvJO3/n/U61rI+rrmLj6w+GXaJWHZgu 7w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b7ma4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:57:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1EpD0U001105;
        Wed, 1 Nov 2023 15:57:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7jy01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnofiMtLuhiZWOTF+9gLnvAom9SydQJVacHmBmEWi0pjpgS4QSyyQzYEhbGHDVdTgoTTNal9aBUq6Bipn+KjsvkQbESSSENZAGSsPg4J5a6jqwE278M1tIJZAtccUutHHUCGeYTs5+cC7JZNtPaQyREIm4tHMb4gmfaWOrIX25C3vD5BBtpGzTWYUH8ahmzhhJNhhGCqnfb2gk8eBf4VCJTNAgol6NA/MfnXoRHELs65/xnXiCcOYstkFSaQfE3S6Inm5fnFxIjyd70edzjQyN6j4eMVbrpIJ12P/0Rteb0kSocKVnuyIALc5siP8Fs5i8POu1lI5fgwodDXajLD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Z7xhvMhc2TrFaZLkyhkGd0i6HOQI+bNexvE3KRaQp0=;
 b=d2TCdixpPiyGsKASD5v4ELAOZN3xQWqTgJmGNNZ8ZqRrEOJ0zIaDiUvNcpROQ0hbivhoLJlRro/D/oq1LGAzv4o2avDnh5rYVecUU+5vDNDROOSZ9/cCmDYEFq2Z30jw6GrQ1J2Yhjxlx1iWWsuV1yxvCJX7VrJdz6DZl1rAfW2Zou/goUTplmfwEmALmuVQQoEEgBQ8K7ndBwHzPxsx7Sv6RiJxMp7hf3yhPztuRgTuJUj6oxJ+bQT3vOu+84rgGCjAVhjqX/d5fhbQuENG+zdJhwiSMdisDztnz481QAgJafvJ87jM0nZH+EENB/mFN0xmF5o6399wSF0hdULO+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z7xhvMhc2TrFaZLkyhkGd0i6HOQI+bNexvE3KRaQp0=;
 b=Z3AIEH8MEReNDZHm87jWBEBNB/7i2aFwkYUkgDkaUsXKGBMlUiqKPFDGNIS2CkNlpCnJ7Z1dzTBzQzZtoSYVNBaRmantz9osO8VTmX+0pnqUQ019ilyorxfxyy+XIjkZFs48owhLqKFimUrG4lq7rXSHKSvshaVe7DFZmSLGF0g=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB6148.namprd10.prod.outlook.com (2603:10b6:208:3a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:57:21 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 15:57:21 +0000
Message-ID: <52cb0342-eb53-4e47-b7ea-410de02897fd@oracle.com>
Date:   Wed, 1 Nov 2023 10:57:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231011143937.31996-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:610:b3::31) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: cf694dfc-6e69-49c4-87cf-08dbdaf33b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sK7Ko7mfIrdmSBa8m68lc/5qPMvt3eAbWsAfLtXtH1twYkg4TT/52S6oTRo8SsP0USpNBdSxaL9a1dHsO9/PObCPl8Uy4zMUgYwIoW9O++Y00ud3oSbRQPG/+cZSD9npXuMXZ1ZQAo5qrmhHpWSFS/e2oQYWMjs5684H4HKz5qkazj+Htuiig5oOyU5nV3mrHYeHQ4lWwkG1x8tosCrcVvnYZxK8qJhKlkSDwuZ4RXZWzGQo65IxeZm0LlL3geumupWcK6Ip7hrSHnnOEEzz1aH/I2hi7b++fczcCiYXKewrJ0YSHs3EY7X5JfvmBNmX43/SYjgUkJ7SmorCfg8Wf4zBabNZa2EYx/PaaQaKDp0rfz0jg9BFLCtmmf4ZUsX3lsIICAb+V23txt6E2ym3E4pt6UZbqC+pHzRg8ZhlXCR33dQMF3DKZi1/OHdRkv+gd7F3ORCcaisQoLaEPzON7JGM2nLrGEcLJgUSgjuC1OQDmHXF5DVHzPT3gz3QdSXFQz3dSLeIZO/ZEFUCidvMVeMPaDd2XjFshn2iBCjeZbT96vgknLUJF525Y/rNsVrFj92PHsLH8ourYiwsF/evYu30QanQGvIKQCezVYZgDKPcw7yF2bov48f1PQ4z4jQcYIAGDPy+wkZpynrMsw1mLajLevYdAkrUrySvfV3lwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(5660300002)(36756003)(2906002)(86362001)(41300700001)(31696002)(26005)(31686004)(2616005)(316002)(6916009)(66556008)(66946007)(66476007)(6506007)(478600001)(966005)(6486002)(6512007)(44832011)(8676002)(4326008)(8936002)(83380400001)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eElVdk1GYWNaeUNNVlh6RFRGRks2RHllQzZmSksrSUlVZDVFVlVtbGQ0ZzRQ?=
 =?utf-8?B?NldwUXQwVWVELy82dXJ4a2YzelM0angzd0NqcDhKOXpzYitJY3RPeTR2dnZV?=
 =?utf-8?B?VzZ4NjlsY1B6SWUyQVNJU0o1M05McGVKSHlhK2lNWSt1T3FkV0RJQWhlaG11?=
 =?utf-8?B?aWd5clhPWEtXMjIrcWR1Q1BxQWFLT3J0cVo2NmF0QnJ3c0VRc1R1RmNrUnlF?=
 =?utf-8?B?a2crU1hxZ0R6R1FyT1ZtWUNZRHNFZkNXdHhwTVJUeWNwN2RyNStqUHoxS2l2?=
 =?utf-8?B?ajBYdlNNVGVwZ2EyK3doY05aZ3FPaFoydEtwd1RLTlZscDVLM0ZpTk40TU5T?=
 =?utf-8?B?Q0lSQ3lWUjlEeFJ5anpmSlFuMDdvUnVZVDViTDVzRzI5a2tLTjlPdUxHekpC?=
 =?utf-8?B?V2Z6eUVLWnNvcjh6aWFGVEtMTFdSOEc1U2g3TTh3UHN2VS9qcFVDR2tLWU1H?=
 =?utf-8?B?eTJuNXdRSXpXYUE2eVg5L21kU2x6QWNwaWR5VE5lckU4ZFJSRTNpdW5GcEZl?=
 =?utf-8?B?aitnbWFmRm1teEVxTTYvYUkrNDRnUzArZ3o2STdYejR1ak0wcWgzRlpUbHFV?=
 =?utf-8?B?WW9HdW1BOEZRTU9NODRadFEzdytRSFBqVm5ub21jc3VTTFJiOXFVQjJ0R2RI?=
 =?utf-8?B?TjQzOGlraldVNlhSK2xhZnNQTFRCK3VTRFY4ZEk1VVA5ZDhqRE0veGlUc1JR?=
 =?utf-8?B?eUVzQlNBaUt6b2RyWEZvcmhtenZMNlRNbVBuTlAzQ2pQNE56c2p6OVpXVmpY?=
 =?utf-8?B?ZTEwZDRPaE13c05aaDJzbFhtUWJsZlZjTjF4dEFZcElWRVl0cm5qMkJER1dO?=
 =?utf-8?B?MXJvZ3p4dkp4NkZQcnFNRm5SZFpqVTd3SzJQMnYvZU9lRWEvZUF4NWlVSzBI?=
 =?utf-8?B?U3U0bThOWk9FVk10RytXczVBNTFxekk5Z0oxd211STgweVd5MTFtckhHYktP?=
 =?utf-8?B?UlgvMDlPRUhkcFFPV2FobmI3SlIyVmxuaTc1MitTdjBKUEFNY1g3MXBLNGsz?=
 =?utf-8?B?dmtUcVE5eTZNelpuTUlLSXg5RXhEbkJRUzMzWlVod1h3L1VLK2h0QjlqYkdN?=
 =?utf-8?B?QkhXV0g5aDRkSkFsaU5XSG9ibkVMV201TU1oMmRIUWFxc1E2Zk1Lb0ZXeW9L?=
 =?utf-8?B?blFKcU56OGhFZmMwZTJYRzR2Z09CZ1dRc0p6N2VBeTNpSWdwSlhGZjBzMjdN?=
 =?utf-8?B?aFpHekQ2cXg2djd0a3pkMzYyQWZkRzhBM3A4SG9nR1RaUGNJZ0xKMHYwcm5D?=
 =?utf-8?B?cmFDUm5wVmdGc3ZZd3IxZmEvL3V1Zk94TmdFMStmYTdWb1lBT3VuckpxMW5u?=
 =?utf-8?B?R3JuVFFGQWw2emloU1lDMjh0ZzM0eUJQMDlzdWxtcG5ESXgyOUxUeFRDbzBT?=
 =?utf-8?B?dElxYzVSZnBHb2ZnU2c0VWhQTTFyTkpKakZudm80SzgxL3ZJM0hIVCtLZEx3?=
 =?utf-8?B?M1d2bU54SlpNd01QcjRYMFFvalh2Y1hxN3h2U0FoUUxaTnNCcFJrdFE2ZDRh?=
 =?utf-8?B?V0Y3UCt0Ui8rU01NcFhFdm1hbkFFM1FmUmVSdkI1N3J5Z3BMYm8xYi9Xc1Jn?=
 =?utf-8?B?WUVGSXZzNXY0cGVTSzNSbER0djNrSDUwSDFnRThzODZTdTBTQnhsbWVYUGJt?=
 =?utf-8?B?OFc3c0RsY1ZIMFAxYWNKMms3K1dtRks0UUpyOWJydmhvVUVLVENjU0dqNVVj?=
 =?utf-8?B?cmF2VUpiK2x6RWJlc04rMitFczc4V3lUcEorWXE0RWREL0xObEtvakNEV2F6?=
 =?utf-8?B?U3BnL0UzWG5hMXNhSVNSNXlYaFQ5ZytDZUFJdllWMEhmT0VOVCt4Ujk5UzE5?=
 =?utf-8?B?M3BhdWFzVkF4aFIyVklkWXdEclNRK1cvOFFRbWZSNEtzaE96eGN0bDBYVlcr?=
 =?utf-8?B?WDBZUFdXUXhSdmZCTEpZYU9DbGkySVVXVkdOZ0tGZGdlSUdDcTJhdzUzWjBL?=
 =?utf-8?B?MTlWa2NQaW1mOVR4UDJpdk43eTh4MmRxRTE5cFN1dHdENnlmcmlGOC9KZ3VQ?=
 =?utf-8?B?TlEvMFZadzMwdGk3VFcxODNSTkFkbHNuaW0rL3BRS3NpZ3FaRHlvaWFkZTdD?=
 =?utf-8?B?bUdCeGxHc1ErVlRyd0J4Ty9oL290ZEkzbmViNTBTb0pqaE94ZWtRdEgzVzMx?=
 =?utf-8?B?TDhWUmZSZjdqeERpWnZwNlAyTnhzdE1IZVZhMTVIUXZ2TXFXMDkrSW5xK1cx?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZitOSWFpUk1BdnJvcWk3Si9OYkcyTHU4VjhlUkkyMTQwQ0V1Z0NOL1A5QzE1?=
 =?utf-8?B?TndPRFlINjZtSjAreXRSeHUrT09ya2paRVFjaGFqZkNHK21SeTNzVEEzaCtm?=
 =?utf-8?B?VHFLNGcyZjJ6aDlmdWVWcVFxZmRmTGYvaDllUHhjNEdkblJpb3hUVTlBbHJX?=
 =?utf-8?B?NlRkRVVKd0RMTzlZOERyWENaR1IrVERCdmNXaEZZajUyWGdCdkpFUUNKTFcv?=
 =?utf-8?B?NlB3VDFmeG1tVTFFT2xuTSs5MXVNOFBDekI0akpHNnhvOGJDeFluVGVudFM0?=
 =?utf-8?B?aEM2NytqVm5tTlh1NCsxN29wb29WLzJTaU9XSUlzMTlOd2orK2FMbVpCZlhG?=
 =?utf-8?B?a0FOcG53VFcxc3ZMWW9KNzdJRlhtTFFrUm5NS0RUbmRGTXI4ZmRVWVoxQ1g4?=
 =?utf-8?B?dXpDRmN3NE52ckNIYWlTbElGQUlIZUxzWU9HeXkycDVCRHRwYWR0eDZ0SjN2?=
 =?utf-8?B?dDlhNldzOUFkc1lGcW9WdWs2TCtwYnhFdGg2aDE5YmJXaXR3dzR4YzlkeTlJ?=
 =?utf-8?B?bXMrZDBrU2ZUMTNieWxuUUJDK3JwaVlHanRGRTA0MURXY1JyZ2E2OWFpWWNr?=
 =?utf-8?B?R0QxenZnSC9LOHUzS1FMZ04waTVudEhxd3pSWWMvWTNlbzQ5TGE4OUZKekZn?=
 =?utf-8?B?N0NldEtObHNZdWZGdlRpbDFUR2h4WDZTaEJFQzc3dHFJUlBraEhTaEwxbTBI?=
 =?utf-8?B?QmJseWh6Tm1zYmY2a0t5MitOZ01zYjk4Uk9HdXI4NE1xNi90OGpxTElwbFBp?=
 =?utf-8?B?aVNjUk9oOTV6UlZmandJUTlodVB2c3dnb3JWOEhSdjJXTGpwY1cyM2ZCMGFM?=
 =?utf-8?B?ZUpiSWpJNnZkazBxZ2JOblhaUjB2TkF3V2ZSeTg0MkxrMjNHN3I1TFQ3ZHkr?=
 =?utf-8?B?aTVNSEszbGNsY20wQmVqNnkweTZtTGgzTnBpa2FHS0R3bjU1cDlBV3RiMzNh?=
 =?utf-8?B?eUYwY2RwSXFHMjNLQUUwR2RpUnVNS1B3N3dud1doSTQzQ2hmVTRVU0hTZi9o?=
 =?utf-8?B?R2U3Ukl5d1UwUzNpSXpHM0o4RUhtWndXTDI4bFZZL2RGNGZIdzZpcnYyTEhk?=
 =?utf-8?B?ZHRSYzdxaGRDdkxJVGYwbjBkUjVwdU9EbzdRcTV4WkxPeWNNVVh2VHpaRDQv?=
 =?utf-8?B?T1ZQTGFHODZKQ2VzZVVFNVdRZ2tVWmx3Z1VrRUZwQ1ArR3IveENsVDVIelVj?=
 =?utf-8?B?VUVUYmpOd3Q3b1lhcGF1Y0hQS3ZHS21aWVRiZ2hJb054MFJpTmY5SVFDcjdR?=
 =?utf-8?B?bUpXdjdEMGZOaEkzWUt5MTZDeVNIQVo3MWF3OUZ4cVdFWVd4QmoydWdRQ25Y?=
 =?utf-8?Q?M34r5nMzMpw68=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf694dfc-6e69-49c4-87cf-08dbdaf33b77
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:57:21.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPuSU+CpZlzjbb0ZqaNlzkK0zARaWgobusAUqWr1AShxv0s1erPCzcXccCL1uxh6Yvb+V/2kjIj/mvM5JLfmiv5oomQ0Pw2N0zChmeSGkrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_14,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=803 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010129
X-Proofpoint-GUID: ttSt4htgru9yYfaCxP5mSDPghOGbVMxl
X-Proofpoint-ORIG-GUID: ttSt4htgru9yYfaCxP5mSDPghOGbVMxl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 9:39AM, Manas Ghandat wrote:
> Currently while joining the leaf in a buddy system there is shift out
> of bound error in calculation of BUDSIZE. Added the required check
> to the BUDSIZE and fixed the documentation as well.

Looks good.

Thanks,
Shaggy

> 
> Reported-by: syzbot+411debe54d318eaed386@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=411debe54d318eaed386
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 6b838d3ae7c2..baa97bda1c7a 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2730,7 +2730,9 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>    *	leafno	- the number of the leaf to be updated.
>    *	newval	- the new value for the leaf.
>    *
> - * RETURN VALUES: none
> + * RETURN VALUES:
> + *  0		- success
> + *	-EIO	- i/o error
>    */
>   static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   {
> @@ -2757,6 +2759,10 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   		 * get the buddy size (number of words covered) of
>   		 * the new value.
>   		 */
> +
> +		if ((newval - tp->dmt_budmin) > BUDMIN)
> +			return -EIO;
> +
>   		budsz = BUDSIZE(newval, tp->dmt_budmin);
>   
>   		/* try to join.
