Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF237EDECA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjKPKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjKPKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:47:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C19D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bb+YnPR0Ak6sjFkz+Te95MixKks6egg5pT2+Fb1Tf1tcQ6vU/wqNUPlxxiv29vXAW+LeX7572aF9PJj+yNhCtToy8zsdfT+72GAZ4XLtxH6WkUT6bHK4PoHBkfxvUJw0T6lQyyEll2lxIVacBlSgOmp0xVnuNE4GPPBo8+yPEsQsd4YdJdUgu/KXxVBMMwkLti8kznW+8kGDBElNIrecdirQG8Pn3I6Tg0L/w7wOZIpzmQRc6iXHbQhdRbnRGfQiKFmfHlU1DreQai+WHzIfxICj4XO+dk44iu3bfYNQxpA3c7TpiqakmPR+Ia3SiqWBHaKX8fma9thezKNByUevWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64jHuSjnqvuMxBqpqvu/IYhjQW3wtTlnhkinFFIc0Cg=;
 b=kfY4MkzntAeSjIxKCg+1l4CaZwcNnAWyVAYducfdWmOZ3Bdr7vvYEsnXwmFYSeeZOcT6tVOl0TGNJVkgdeRjow5YfMvp6uYwcxf3uge3knOTLhmOXue0ZGmqNj6GPg24sYHKmqitgD8O+0T1HlkTgatF8jpqupbirlweG1nI4+l99N4PsDSvT6+UifgB0bs6HhQPanY2eqgTmpAG7VEcd5eR2YgELFSg95NJz2bsteNnwA+Qxko0sjuYGBVPmtBgaWTwHXpvue8rN2po7rFBMdjsUL1MX23ZnqnKts3xoiKlXG92uZrp9gdQj628S58habqFxeBV0X5sd5jWKqx0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64jHuSjnqvuMxBqpqvu/IYhjQW3wtTlnhkinFFIc0Cg=;
 b=HtZc1TdvGp1cgJKQRft7+UxlPQDiGJ/LsOduzx04ihnbnwj32ZAMvoVMjJZxHecX6DpB7G3CDch4QpcWOZEyxZDpnEGnetu18QbNe3E/5i7WMH3oWf5lBGmqKQWrB6TELGY2LbJFiUFGnE8kQnFOdCdzIZ7YjgAXCCdYXtjaDsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 10:47:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::ca80:8f1c:c11:ded3%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 10:47:04 +0000
Message-ID: <99ef9596-d4f8-49e2-acbe-ed7486310f84@amd.com>
Date:   Thu, 16 Nov 2023 11:46:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Content-Language: en-US
To:     "Lee, Alvin" <Alvin.Lee2@amd.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c04d712-e61a-44f2-bfa7-08dbe6915e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oryzVaNQqd5PYDsnV/7Yvvz9657vZGCwhYNUCejFHqBfbGn8kpndOJF2OwyJdl1yL6rFKZQOHWBTrqW64gGScM+4RqbAOOy+WpANMkzqFGQfnJyuUZIJ4PURlUrc9Uc2ivYvJAFqQMWemDVrAk9aOm4aCe9l1Z1G5oikEwMPIuuddNrl12Yj99+kN04VWGfdNrJUxjA9+F49juOWTezfrGD8uQ7X4mQgG2RzJt0JV1hmZ8OwS2QihEU4UWVqkpMUp7npEEkCvFHCtzSaFvjLmtkPsJg8FlFAiguuLxq+bJ+kAU6yy6E95mkz+JEPPJjUZ1G1suKhJjJL4+E6MWS48K6cPyK6vBjWyZg2YaEDXZhPJAWfL7zcVhD2MnYSm1ISASE2P5qwtHDAfWFrma6jlz1a7Gd4jDKzv1TgdP+R8JWZ2n1KnDqd/gvDxxcQMdrTP8Vgp/UxrCXIoEVBLAbkaWzCE+9b3tTM5ITOWB4o7f6S4Zc0NcxfYkZZ/DPYf6EBL3UCyYHOuXWyFv8qHvjBKLMAJGr+f+s7rl06lvHeuiJ6uHCtFUSLn8WJkSmnpVXFSeZem7AmLmbWNM+7/vRB8gWa8Q3ya/l2YeECwhFZm27dy1PLMQYD0mIy70AZAB83M06f/h2spfSfC8YFrSm61tJRJchCEsaMb/qeLwsDCvrdTyijSX5D+G6aloEavh6F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(66946007)(2616005)(6512007)(83380400001)(26005)(478600001)(6486002)(36756003)(41300700001)(31696002)(2906002)(5660300002)(8936002)(6862004)(4744005)(4326008)(86362001)(8676002)(37006003)(6636002)(54906003)(316002)(66556008)(66476007)(6666004)(6506007)(53546011)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNGRUpHRXhnK1l5b3Q0a0dpTG1DVkRvS2pDWmo4eTZwU2dlTjlxMENjcXJP?=
 =?utf-8?B?WUpWSE9tL2M4dXBsOC9hcmd6a3RSZ2FXT1djcFhOQmdQN1JoYTcwN0dScmMz?=
 =?utf-8?B?ZU14VTdGTVFFUHJnVVF6Vm5PVmpDSGtlWnF2bnppTXY1NEN5aGMrSitmRnFu?=
 =?utf-8?B?ZGdiOW82MFdVa1p3amExbUlpVDlvNWhQME4xTEdJV201NjJFRXpJUHhNaU1P?=
 =?utf-8?B?SWI3Q05TWUF4QVV5Wk96R09zblVRb2pTMkNuUnNKenhKY0tOU2RtS1lFYXFY?=
 =?utf-8?B?ZVhsR1lUMXpTakRNSEt0MWVaQkY3SGhNcDIxSmNYNVM1K2h3RVVXc2NPenBC?=
 =?utf-8?B?bXFCNkpmZVdjUjlhN2VGaGxqbEUvKzd5MG5CMnh4MXdqeXZvMGVuaW1jMFNn?=
 =?utf-8?B?MzJvcisyZk41YThYeDFuMkNwUU5RTlgyT1NJSm9kYWJWWDFLMXJBRVlza1FH?=
 =?utf-8?B?RGZYdkpVVzBIcG1zT2NCZmFIZ2JkcEp1L0EyTDFxbjFYNmRUV3dZUDVnN1ZB?=
 =?utf-8?B?dFhVb1dXdkhzbmdTVVJsQ2U0SlJ0WUhMdFQwNDY3L1QyOTF6Nk1yZDloak1a?=
 =?utf-8?B?YkhuNE9tWWZTTVYram5CM2RQWlVoMTBPelZ5cjJkcVl0cFQ1TVRjOU43RW5D?=
 =?utf-8?B?WDJaeHZRdmJZd2VCRTlMOG5mbkZxMXZYRng0ZGFkcGdHaXU1NkhGK205Zit0?=
 =?utf-8?B?aW5MaHp1TVJYY1AySnRDSDdRQXM0UnNRTmxETU5sZndvd2g3LzlWRU1xRGsz?=
 =?utf-8?B?S1hkbmhjdFg1ZjdjSkdqSGc3K25sUnNGUTM2citZMEhLc3J3bFNSekF0b2xs?=
 =?utf-8?B?cTd3cHdwN3hVdm82emlac0VVZC9mSzVWNUJ4Y0hVS0NKbXNndjVUb0RhMSty?=
 =?utf-8?B?STFkcEwzelVZQWFiU2k5RWtUczhOMU96SlFwSGNFM3ovT2hTdFFpTXcxV01D?=
 =?utf-8?B?NTI1RHp5N2xRRWZtRFpyRjJJUHhkbHpUYStINjhHazBjeG9kRjliL21ZQy9w?=
 =?utf-8?B?UDJCVUxwbVVIR3VBNjJONGFwNU1uR3NMclFNM3JIaEVQZ3R0a3VCcmp5YVVv?=
 =?utf-8?B?K1JjZ0FXR2dTVFVoK0gyKzl6U04vSUFncGpVZGR4cFBtSlZoOC9YNGhxTW9q?=
 =?utf-8?B?dnJBdXFJeVdGRFFORjFoNlAzRGZ4RmFuQTBqMDdGYVRXLzlCdU02ZTJiRVdQ?=
 =?utf-8?B?WjZuOURKMmpNYkVLcXNQb1MrN2l0VlB5Rm00TGY5bnRFRDNYWnZzYzd4blZX?=
 =?utf-8?B?bE5QbFR6ZWRhcXR4M1UvMVJQVE16TjdiT01KaUFubzhHMXA4aG9hZ21aQldi?=
 =?utf-8?B?OHFXSWpUclN1Ry9OZ01HaWFxelZYWlllY0VjcldqdU1saHk4UnlGZmdLb1hH?=
 =?utf-8?B?b0liZFQ5RGtzMlkva0hXQTNxRmlpVkV6MHo2WUh0anN0OXJkb2VoK0Z3Y1pS?=
 =?utf-8?B?UjY2cWJGSFkwUGd4b05GRVAxQXRJNTA4RjcwK003SlNPeVJ3UDJXS2tYa2sv?=
 =?utf-8?B?bVdkYkwvRnQ4eFJRZW5YUGJuNXZOcGlscGVrK3EvV3BMV0h5V0w0MmZXczdk?=
 =?utf-8?B?Wk5rUlMySmFmcGpmR1M0L2twdUVjbXJaWUFocEYvc1FEVk9SdGdYbmVqVm1u?=
 =?utf-8?B?dzBGcTFzM1ovTGVvUTA0eWtLY1g0b0RHZVhUTm9KeGt0cUVrWXJjS1JaTlIv?=
 =?utf-8?B?eGJEcVlKZWV2TVR6RFhsU2QycjN3T2xERXpjeWZ3RWlBZVlBcnhMb3JLRUNC?=
 =?utf-8?B?S2pUOEVhUGd4d3BHa0JvNjZ4MHZGNXUvSXByd2dWY3l1b2E0YTFybThCZHhw?=
 =?utf-8?B?d24xWEo0NUJXMCsrWWo2OGJrbWc0aWNRMUxVS2FGMTlUZUJUcXdRNURmNW5B?=
 =?utf-8?B?NVdlRGpTU05XU2hsVW1sTE9OZGlralB4b0xTaFRBWWk0QlNZeVlCaVdKd3Ju?=
 =?utf-8?B?NnRMcnZCeVlUSVRwVnhVMGJRSzlmTGxwZFFPYnRQTFlPejBsZFJvSldnR216?=
 =?utf-8?B?eDNaaEs4Q2NxR1daY2VEVjVEeG1VVERxeGRNYmdMY2VEU1ZqaGNxTUxhRUdJ?=
 =?utf-8?B?MTZJenk2MHJ5NFFhQzRYQjZ0VVQxcDJ3OUtKRTIrSmROQWFrSkJNbnFlcDkv?=
 =?utf-8?Q?QkU+wmoIYMEcEE7kQxBQVcQPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c04d712-e61a-44f2-bfa7-08dbe6915e66
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 10:47:03.7399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xv9Mp5NINXGaRLWAyz/wI+dZECmQN0qugHQFAr9Eq6ZmS1AkgSsWzN6wH5XWjhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 15.11.23 um 21:08 schrieb Mikhail Gavrilov:
> On Wed, Nov 15, 2023 at 11:39 PM Lee, Alvin <Alvin.Lee2@amd.com> wrote:
>> This change has a DMCUB dependency - are you able to update your DMCUB version as well?
>>
> I can confirm this issue was gone after updating firmware.
>
> ❯ dmesg | grep DMUB
> [   11.496679] [drm] Loading DMUB firmware via PSP: version=0x07002300
> [   12.000314] [drm] DMUB hardware initialized: version=0x07002300
>

Mhm, that's a quite ugly problem.

The driver is supposed to work with older firmware as well or at least 
issue a warning and provide a reasonable fallback.

How are we going to handle this?

Thanks,
Christian.
