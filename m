Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE57C680A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjJLI15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjJLI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:27:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C590
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajWeqdMiDZis8lo7QPO62Cl8rgEAXe6/ckAAak3dyZxYOh6egS+EwumZA88ulV4IM7TjPKjLsfzZxp0u28Ks6ILxZrFfAzmAt/vKrqhAopCAuewMp5WOLvQhOANMtFLG0GvmFDlLVlRni4yVATG4Wkdkn6JKhGUfOEJcHvtJe/m8A5t7B1OMzLVQn5x1Q8wuZjEODI98WmR7c0/U04nwpb7CqEtTWVIJS7mFVy9OkMYVH/Yn+PA67m/HJZig7fbQYw38y1B5NWYWzoIplLv8FemR6aS5G/d4Cde5Oc9eeUYMRldHngHs4O9ktk0Jx9+b0h8wKjHSJTVFNTQvhG2+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEYgTEOhCog3VEeOf5Uadoa4L9kATEleBzhDKsmf60A=;
 b=jNkzZSJHQNZE31eBp+VzcL6NjJ/S+8DtnxbpXYqHF99FYTdVhXgHfT8sASXXiZFJ8Myh/p6dOD/wWxJpLBZ3D/UL7s67OVAEC+mvOEm5dYb8jfSOn+1qJHgKKiuAii+3hIPPkuhZQTwsYnOW4T9KhmXYKC+gXXynGGgjS8hnmdATkC9AMPXEvw79WLPh+uU8UzxFz0KBxaVW2Aplp54xGMh/gXSr2gpPbZulnHJ1hRrzydOO3LKH7birDeHfnoNaPoXiX+QlY0/NqZXPupzjKEdblzhYEqqovLlfCJL2PkxqMr1lLJ4yBkwxo/h7uuKTXfis0OcGeCSaAOQyC+guJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEYgTEOhCog3VEeOf5Uadoa4L9kATEleBzhDKsmf60A=;
 b=gzt6xazaWp039D1M6fHlVvf2dwiGGSRJOb7wWfG7zU7GySUY9ljy0TFlKnLS5pK51K+TZupIANcI63q17b/tJaK7HXllHRYW17b8TJgX44nGvA87BNrLOGSGmUuDpZbNME/4ZRwpt2pPz13Z2dkwlp3cBAz962EK6pF3f9QoWII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Thu, 12 Oct 2023 08:27:50 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::93cc:c27:4af6:b78c%2]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 08:27:50 +0000
Message-ID: <81b4e3b6-a9eb-ff29-efe7-94ec2fb47c18@amd.com>
Date:   Thu, 12 Oct 2023 13:57:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v4 01/14] virt: sev-guest: Use AES GCM crypto library
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        thomas.lendacky@amd.com, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230814055222.1056404-1-nikunj@amd.com>
 <20230814055222.1056404-2-nikunj@amd.com>
 <20231011185607.GVZSbvx8rJ8DXPqYfg@fat_crate.local>
 <3b484a1a-e6dc-3b73-ba1d-72fd6ba38ebe@amd.com>
 <20231012074539.GCZSekIxe9KM1lG9eC@fat_crate.local>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20231012074539.GCZSekIxe9KM1lG9eC@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM6PR12MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7fbdbf-c1f1-4d72-c88b-08dbcafd1ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXfRhcxBzNmhSPUbsfpCvXnsslsV+NF2mLZvl5AMl1Ap3lW0QeljTTL67Z9t6cGyDNKPbDpgsFEh3jW4E6okq+1nwH8onugbdxJLsi5mptxBcvB08FUa2C8YE+Vw46Xq53nYsYJhiyZ7wyCC7zQdeFrSIGJ7SWqetApeFnTIY4YJsBjUgXOaXw5Z8tXdtF0XZZ1rfnWiBeMdk8MnAUoRV3XYowtEB5kMf2vGns2/06MNUet+u3D5gMGuNv+ayw+mG2BxWlUH6gfVCu6pQrhFArBS/pDMkzyiTCthbE1Ht2OBzoI4Ts4qCGG6rgzlxJYnAfTq3P3CRyIBbJyBiy3FkreyD+ct+1wiNhiF2qYNI1FAbg0AOHY7h/VoY156hTPUtSYXuUb9QbJ0JTqASknKIDXCxTACE5MFcQRL+qn84HPaCkhwvvXnHsD/wIADzCqJrI8/sjD6x2SNfAOTvU4G4Di7+OKxkh0pzbyotVKPtLsZFOzma2ZdRORMEP0/kYY8Rlu/5Xw73/mrZUO0uHy2WMHd5K8QUSX6BxW48cNvqJVWCUihYPHOF4QjJy8pa0NkWR7GJtv2znf2VTb5mw+KSIAipi+g2L26ZglQgDf6zYk3B99xo57aoLVNj99Ikz6DmooYNq1nihXhbF6ck+k6CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(2616005)(53546011)(6506007)(41300700001)(316002)(478600001)(3450700001)(4744005)(2906002)(5660300002)(8676002)(66556008)(6486002)(6916009)(66946007)(4326008)(8936002)(26005)(36756003)(31696002)(66476007)(38100700002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpUdTlOeEhnOXpwa2RWSkd0MkpOUFlST1VDL0hqZ2ZsWmZ4QlhQa0ZRMVpy?=
 =?utf-8?B?ZWV6QzB6dHZUTnFXMC9jcmlhWkVxQnRHOFgwVU0wNFpnL0hVK2NkaCtVbS9D?=
 =?utf-8?B?YkdNQWhkUmgzNlNrQVo4cHZxS1hUWHlWVmdxanNqUk5RT0VZd2VsSVNoUlh5?=
 =?utf-8?B?UTBiNkxOTWw4Y3FLbFc1OVZmdy9RMEc4L0xScmZTY1pPOXB3dkZlM2UvUXJK?=
 =?utf-8?B?d28vQm13ZTNoaVBFaDFFVUk1VzBJQlUvNVlxYWFuY1N4MnZ1TVBEOG5GQ3Zr?=
 =?utf-8?B?RW1DbjRUOHBHdC9GNmY1SFQ0UEpKbjBRc2QvWWRYTnE5Y3JsUzhneUs0c1VH?=
 =?utf-8?B?eS9IWG1PSlUvZkVhWnppYXZlaWhzSXkwNWJTMERtNVJHbmRXdTJCOFpyb2Q1?=
 =?utf-8?B?SDRybWs3MDU1Z21iQ1ZMbUNPQ0dEcHQ3cTl1S2pVKy9yamxaVVBMUXNtZkhP?=
 =?utf-8?B?eU5KNGEwd05UenJzcGlobkxycm5WWnhvUTlvWHhCZUF2emQvcVYwL2drM2xr?=
 =?utf-8?B?VjRmQUJkWnZOektrYldvNWVkZ29lZ2VaWDkyY21XVmV3dGVyZUN6TU5mcDdk?=
 =?utf-8?B?K3I1SVkrYW04SWFKcmNTT1VIUmxPOEhrY3dCLytkT0hrVEIzaWZ0VUNBbTJl?=
 =?utf-8?B?S0MyVU9uamZqbkEwNUlrbzJ2by95WFJuVTFiVVp2aFFQa3A1QzV0cGNwOUY5?=
 =?utf-8?B?cEgyUXUwd1JKOFhEcXBPUUZER0lQSnpvbHBUOWtpb0E2bkFoMEdYUWI1L3BV?=
 =?utf-8?B?V1ErY1EyRlhFRm82cjR5a2EyZUFtSEhCYjFqaUlGNi9wT2hkWTB2Y08vb0pi?=
 =?utf-8?B?c2x1eFQyTVBtd0pNTjhWRkFFRFYwanoxMW1KckhrNWp4RTU5c05LclhHV1lQ?=
 =?utf-8?B?aS9tRDdDS0F1MnRYL2VDbVlpUlpEOGQxbm04OXNkQTNkelpaYTVPT1pDZW1O?=
 =?utf-8?B?NzRUMm01aThwaFdqOExpb0dtdUZVSUJNYXVUc0ZIdk5SV0ZaNStEUUVoNGpT?=
 =?utf-8?B?UjJ6ZkJIRDdQUHFBYVZaY2FBOGgyamc5Z2hsNkgrZXM3UEppWWs0TkpqKytR?=
 =?utf-8?B?SjdXclRGaEtrbWExTGVyVGVZdDltUGM3VHJiUTJUOHdxZmNFaDJpSDhETjg3?=
 =?utf-8?B?a3RTVFNKOFFsRGhCUEllb1pwZDkxSG9VTUdCQlNHU2hOVVZwNUdjbVhTem9l?=
 =?utf-8?B?a2djbkYrd3J2dDJiakx4R3h2akRyajQzUWtYWFQ3ODhoaUVOenhzM1d0TEpy?=
 =?utf-8?B?cXl2VWNzK2tVVXh0WVAyZDk4NFVCWWt1TWZiRmZSbjZvdXZpNnFzQmRyL082?=
 =?utf-8?B?c3lDNms5UzZ0Q0pFd2EvZGpMK1dleWYrYW9FdG8yUGpBVTlJRkRUeFFBZ3Ba?=
 =?utf-8?B?c01kM0VCQWNIaVBGSUFBUjZRVDJVNExIZEw5SVlZVUVvcGtTdjUyNHJHWmVX?=
 =?utf-8?B?eVFCOEI1ZjRyWFY4NjVqMERkUldlUlg1aVV1d1hLS3pRN043VU1tU1hrRG9o?=
 =?utf-8?B?MEZSVTdlc1FkL2F6L2pMMUxHbVlqK1Z3NXVhenZQTmQ2RysvNDlGYTZkYWFu?=
 =?utf-8?B?R1Ryd2pMMVRPREVpTWdpUVZpcXZCTlRZT2tzNm1JbC9MUitPSkxBcU5IWXVO?=
 =?utf-8?B?ZGVtaHBld3RjN3dLdXJMWVAyMThqSG9hSDZPc2hEUG5KTDVicHpLTlFmQzdm?=
 =?utf-8?B?ejBwR2RCcy9STlVWekI4M1YzaEN5OUppV21OWW5vL1lvWDZvNUtucFdFV0xL?=
 =?utf-8?B?VlBDWHh4dEVSaWFZVW5aOEM2QWpDWXUvMFBINXZReWRHNllpSlVtOFJYZVUz?=
 =?utf-8?B?TGkyalgwdlI3REwyZWN2L0dWbC93TnMrakVKMmdvTGtudzJPeTRjZ055YnRZ?=
 =?utf-8?B?ZHBoR2tnWDcraVd6NVZZV2lHWG9za3cvRFh2cWROOUZpTEJnaTJ6eUZmb0dJ?=
 =?utf-8?B?QnMvTGY1Rks1OXpXaC9PN3QrQTJUcjZ6UDk5UFNpUEJyNEVENzhNMTlzUThJ?=
 =?utf-8?B?SGJNQ0E0SUZwdkh5blYzUTE4K2RBckpBYjlsaDI4RjUyU216OWFEVHMvRy8r?=
 =?utf-8?B?Z3ZLTkcxdnRpd2xvU21nU1ZYN1NxZlBHZytJTkppVUYvSnhDMXI5U2Y0SGhE?=
 =?utf-8?Q?KNw8/62VPOrHzcN5/dwg5Empi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7fbdbf-c1f1-4d72-c88b-08dbcafd1ed4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:27:49.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ypnhg1pFpBFMj5nXvmPq7aV2P2rTd9BAZ51z97ycO7zQ2rI/J8mhmKIBt1LD1dgu8xZ/V81scKPiB/ZemTi0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2023 1:15 PM, Borislav Petkov wrote:
> On Thu, Oct 12, 2023 at 10:10:43AM +0530, Nikunj A. Dadhania wrote:> 
>> static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>> {
>> 	return snp_dev->ctx->authsize;
>> }
> 
> Or simply not use a one-liner function at all.

Sure, this is what I meant when I said "I can drop the helper" earlier.

Thanks
Nikunj

