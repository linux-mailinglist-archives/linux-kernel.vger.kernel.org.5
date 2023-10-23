Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6257D39FA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjJWOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjJWOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:44:59 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E72170F;
        Mon, 23 Oct 2023 07:43:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq1JtzULWcT/ubDnYJsx3DkQn6n8rDh2wvb0CW1MjBPwwrHz23Qs3ZVVGGuoj+jMPTj3hLFgLkx5dv3aUnEJeJhR0ETI/rWfiu5bTr5F4fy6c1ldz+jnRrDgaDRnUfpQtpyWrGWJH5Psh/ZCAU3e564BO3dyGXw5n+AVreSOYw5N1CgQxcr64Fa1rA4ucN49i5etjMHE4KI776s6HINmlEQKcQrZAhwZJ7jn9YtxlHdFZbsTEUgvlmxvsv9JlaaGtiovYNkKu5VPxXcpug7TYQ4skYvYDcAtKEJPm+TCC7jBySdd3J7VZVvIPCaY/t4H/n/FPj3y9hEDJ/IQwQ10eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjbrzRN5f3jnnNgQNiCeG7aWzBfwlPyMxXyeMU/idAE=;
 b=SdGXPUeeWOCp34wqQiK4cRSWHG2V6HY9cmA+A2ILiSZ1Cr7orENrpreuWg+QSugRPfA1ljM6eRwGAL58PcKh1jec6eTw/uSfVX2Hh5wQaVtWR9dlmTQQrroazM8z/AjGchEVu6YzGVrerzHNjgyfgn/qDZbd6Vma8hGlWID/xCiiVjR+zH/O1WA8g1V0tFdu9KtwyAlGDgjvBPCJ5p4tpWAuS2ox1ctPapfjivQEgW2KT5NzvU6QffMbxh/3nKxn2p2ddpQFCcoJ+Mt2J++jNGvisb9IGLFcYlRbP+A6zh1bkg8pl0RBbmQU3oThNWjztXNZo/atctZIr2JAN1rj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjbrzRN5f3jnnNgQNiCeG7aWzBfwlPyMxXyeMU/idAE=;
 b=AUeLk9O28ly4hZPyGdR6sZA/wWvRP1T00OC+ZxjJrrs7JsdtvNCE8p0aVqxiCSK5xtQPdUVHi0B+yX5aIxeLXnIy5LpyiNKIzmVHrku7Db5PcmtpsXppF+oKfhoakpwIId10gYT9Uux+/jrz7vC9fdiXkjAyaxh6QY+5bhozAH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 14:43:47 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::7e38:5c00:e469:bde%6]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 14:43:46 +0000
Message-ID: <df9dd82b-a385-382e-6906-13b22b9cd921@amd.com>
Date:   Mon, 23 Oct 2023 09:43:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] docs: rust: update Rust docs output path
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Akira Yokosawa <akiyks@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
References: <20231018160145.1017340-1-ojeda@kernel.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20231018160145.1017340-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::14) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f99adc-7383-4ac1-5158-08dbd3d67674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tY68+VRlm9uIr9Z1jSQXH4N6d5opnUKIQWro8LetlUl2yS1GJi4UVy6+wiNAYqKkjQixsu6uZjb47SqfhV1Re7vieyKM/2aSfwwTKOsneXoEQzffNWfXL70BRjJfZ+W7uXmgqj76VdOSMNddBVpEEm+3iWA7+0X34tKXBYLGOaDvUIgXxa+/QdoP+0Xeib35S6OQ8ojmeU9pqsYLdAksSnSLbJBrL5A31lvTG3BVFlR6Hk/UFAnkZEvQXrxq0pnpU1Nr2NA2XsNZyK+E+D/zWtDJukupza19yvuiWfLJ1chACGCT9uQeHY2oX4auv9pYTCfKXjqtsh5IOnJsmALt7XXl0xwk+cbq0kDCv0GrOnVQ+EP/RGp69Nawlfu3X+R0wcrcJw5+Rf1Kz2/0pfIiFHs8NAXAaMkjYf1fDvXeZHkQk3zqzZDym9t0JdHM3zceFcBy4Azr2rwE0e1Z2XbSOa1t+3ZrqTQDVw+YTA1ioTu+yzQfoFNt9vEIqEBCiKk11Tu+oR+eAXrvUBbxwDCoG07w1waImO32pHCDoBYGS4Y2WsdU/zF8GYaWPN0vmmPgk1Zriq1fp70BFICYx9O6+XFPhs2p21DzMYtFewI+NiWVMRWEhVWYDzqhjlimiRCWo9ReuK+pZkRkyhbCrycuuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(44832011)(8936002)(8676002)(41300700001)(2906002)(7416002)(15650500001)(5660300002)(53546011)(36756003)(6512007)(6506007)(83380400001)(2616005)(38100700002)(110136005)(66574015)(86362001)(66946007)(26005)(31696002)(66556008)(31686004)(6486002)(66476007)(54906003)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXlVTERmWjB5cnc2dm8wWjgyWjQwdlY4Q2N6bnZPTnV1cTk0dXdLcnphbUZC?=
 =?utf-8?B?OUxMM2N2TE1WUHh3MkFPUVc2b2wzUnFISmxDbHVGYzNwcDZxTnBxOVVqUGNI?=
 =?utf-8?B?VjZDTlR5MVJ4MEFhc2pTRFJWZnFjYmNyeVNmVi9OU2dacXQ5emEzY0lJZFhJ?=
 =?utf-8?B?blZGbXViaHkyVEJmakNlTUw5STJUd0YxYlBiWDBXaUZacEw3bll0RzQrbGhB?=
 =?utf-8?B?VXpCR3ljMWN5ZFErc2pHOTRqUEN5Smk2RmlLVWZhYUR4aHMvaXV3cVJ2QWpU?=
 =?utf-8?B?WC90azV2Qkh2c1RaTCtMcHVjSFEramZPS0h4eFNBaUZVMHNCcEVpdTBkU2Zx?=
 =?utf-8?B?VENNdGhjL1d0NU1nY2tUUjZtWCtpVUxKMGh0N0p4Slg0MlFsSjZ3L3p1Q0t4?=
 =?utf-8?B?eDJrMFBGN2h6T0JDNkplZkErZEhBVG9LWHJWeWdrK2R4QS9zM1V0QXhEZVpw?=
 =?utf-8?B?VlpyMXpUWFVkQjNPNjBTNGp6Q0tHQUFqcGZkOGUxSUx0YWhqVjNHWkZSdHV4?=
 =?utf-8?B?L2dMSEJWNE1aUEUyYSt1SEZRNE82d3IvTFh6U2thMEdCS1RtM3NsZ2FGSWZv?=
 =?utf-8?B?TStOMS8rSXRjLzlaM3Q5b0pFK1BpVEs4WkFjNGxxTjVycmx2MU1Dc2UxSGRz?=
 =?utf-8?B?bUxDYXFJWXY0elY0Wm95cC9RL1l5b1Q4QVdySjl2UEVYTWdaR0s2anZ5clha?=
 =?utf-8?B?LzJRZUE3NXlXQThnajVlVzdYQTV3ZGRQdWhaTk9JMWN0V3JOdGdOajJ3SGJ6?=
 =?utf-8?B?RUhuc2FYSFZpTTgyeFd0QnA2bUVxdzZkNnJZUmVWN0R6S281VzFDcWNvVEhm?=
 =?utf-8?B?WGhGdW1FUFNlQ2h6TXZpOVRWZHd1aE04aVgzbUxqNEEyT3RCaGpyZkpsQVRB?=
 =?utf-8?B?YXprbGgxSy9sWUJ1US95Rk9BMVZzblFrdkR6Z054emJndGpZaWt1Vk0rSHdP?=
 =?utf-8?B?K1U1MzE1Yk04WkZEaHFSQllvNldvb2VUZjVldEhKS2VQSThkQW9kR0lHdDdK?=
 =?utf-8?B?ZVFzaWFJMHRET2U1OXVpTlhFbGpTRXdIMlNVc01qSDdNbW10cG1FTTFYbE5W?=
 =?utf-8?B?WVoxeXdqZ2ZSdk9BbTZYL1hVYnBmeVZVeFRaK3BTa2pEZHkvVWM1VmplUkJR?=
 =?utf-8?B?UVB3UGxyTFFXUDR2T3ZPR1ZNdEh0SHNSdDRKUERTeEM5Y09Hd3dmcitWNEkx?=
 =?utf-8?B?V3VkYTdvQkRPT1VOb1FXTksvZEpwem1nN3g5R0hUS3NyMllPVUErN25yczBn?=
 =?utf-8?B?WnhkNUpMY2srVC9wVnozYnFUV2ozNmFHZnNud3hiOVBEV3JRRHFwRE16bldT?=
 =?utf-8?B?NERSYzVKVHNRcnRBYklKWktyUUVuMlpWVlpFVFJ4cStSYzQrd0RFQjNtQlMw?=
 =?utf-8?B?MGlCZFlWVHZ4cy9pZFIzL3hRUDE4bzJVenlUTmpVYTJSdytRUEt2RkQ3MUlJ?=
 =?utf-8?B?a2FZWEg3RVJWSWxudjVRQkx5UE9PZXREcEV4MEYrNGlEM3NBb3lQMms5M1Bl?=
 =?utf-8?B?M2MxejdudUhURlBTd1I3Uk1udE9sNStVb1NBN0o5d1R2Vkl0dXZlRXprS2s3?=
 =?utf-8?B?ZE1uMXRFQ2ZQYkdwQ3YwditFandYbnI0K2V1ZEU1bVFPMlZZVDVaTXFrOFBP?=
 =?utf-8?B?VndaQ2pnbjFtWTBhc05VT0RLYnNBWlVabVo3OXNKaHBzWkdQTm1rVTVEQnhZ?=
 =?utf-8?B?YzJPQUVwLzVSQ2lUblJVR2lIZVZsMG5jeEFNd3RpOStVU3YrOVpDT0FpQVdh?=
 =?utf-8?B?ZWtsSjNQQXN6dXBiZ05UM1ppYzhCeUxhL1ZJdHZaeVZaZzMvTmMxMlZ0Ujlv?=
 =?utf-8?B?aXZLSWNINDFoR1lEVjZHYjZDUmZrVHhTU0U3QXNCcUwrcTZKZDJHWXgyZlZk?=
 =?utf-8?B?ZTE5M2J1MWR6czJKUW1hVzBKZUtrVDZKeHIzMzhRQjgvTDdIMTBCNC9lRU1n?=
 =?utf-8?B?VHMzVEJUUXpCMjBLZzl0N3h3ZURUaXFCbnNHVmdybXZJQUUxTjcxMGFBT3RR?=
 =?utf-8?B?MTRsWmFOcUdvYkxja2FWd2Q0ZkE2dlBHY1huc1FWNEpEV1R6c3ZYazZ4MXRx?=
 =?utf-8?B?UlNXUTVKVGsxd3ZNWHNRMGgraUNURHdDdUEvYXQxdjYyNXRHUnBUQmVQZHhz?=
 =?utf-8?Q?hkf0qXrP4aBefD5GO0mWJCHHm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f99adc-7383-4ac1-5158-08dbd3d67674
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 14:43:46.8239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Xdt31Ay1qEzgnDJsOodXuTsxtktCBc5te3dmXDTrZBaHwBS/e3+LhtnFx469WVZQWb3uyZuK4qL+qtXI/Vrkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/23 11:01, Miguel Ojeda wrote:
> The Rust code documentation output path moved from `rust/doc` to
> `Documentation/output/rust/rustdoc`, thus update the old reference.
> 
> Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   Documentation/rust/general-information.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
> index 49029ee82e55..081397827a7e 100644
> --- a/Documentation/rust/general-information.rst
> +++ b/Documentation/rust/general-information.rst
> @@ -29,7 +29,7 @@ target with the same invocation used for compilation, e.g.::
>   
>   To read the docs locally in your web browser, run e.g.::
>   
> -	xdg-open rust/doc/kernel/index.html
> +	xdg-open Documentation/output/rust/rustdoc/kernel/index.html
>   
>   To learn about how to write the documentation, please see coding-guidelines.rst.
>   
> 
> base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa

Good catch!

Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
