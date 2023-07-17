Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A23756925
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjGQQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGQQ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:39 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C610D1;
        Mon, 17 Jul 2023 09:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToeNraJ94HFjsOfEESjAeqhhWgqZXNhmG95I+Y8Ml6SS2gT2tPmyZ8yVOPoJueJbUr2VyaKBuE6L0OTQgvNAeRIBilSpqNIByIxjQix7vNPCDf1gn0Gpdjfd4TZavimJSkxvbrYorncQUIi6lEoLmVN8EOqWGvUCMkhEvjPXKacfKPGx+rio4hHIaq4Ud7x/czajRv9CnpkoFIOLKgXk+CvfJHIb3B71j3m08cB2tgZU1vuPcRecDzfzTv7soAdvu/vB6Ijcdbry1LmdrH8oOOsyPx8M7lh+hO1nqx0kYWniXgexQthmtQF/AtAUm8RUlqZyeC9HVsFkEPnlD5iIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGHwpEkJm3q+ihhXI+YdwWC6CrP/XtLCzDRkdPRW64I=;
 b=GLRTOFm++jGqoAfDXU12Y+qM26gAkGxbyKi1CkOkDr+GMNIZ2MxJyCI9TOSWlOJDsTDa7rtAojv8Ew4vyPs491HXz8RhHQdUhfILL2r2hU9Rsz5k6P1PCMcbWj7jxKa9MDWjUtsR5ATvNbKrP4UFf9EGLT6J3xWDSYQFBg7hIhsZDOyyqDEMRDKycM3oDioxCg+pmd3ZiRBu7e4mrnSekAEtR62AFoMsEBpbgfHllOv/cxCY1UH1IuMN0+ulhKBoyAqLdfTpmVc9+aXA0kRd1n8FwZGj55uZkbauoJg5Eo8GRRKtse26z+RzzcRXaN3dTyT/UAnHP5DOIykYfY+nCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGHwpEkJm3q+ihhXI+YdwWC6CrP/XtLCzDRkdPRW64I=;
 b=GxcACyA00tJ8hdjrcAwR6QqPotG2N3Vb17mEFj1SopiVdaeJfeFE8Y9acw7XfJxCo82i+Nkvcn+fFZWnoQo7zB6YaFSgLMDv2ExCVAdbIx05Wkrn+XCQbESktDHJaFbG4cIuKUsXgKWBUr73ITu+3yLnixkDrrmgr5O5Dzfxf38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 16:29:29 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:29:29 +0000
Message-ID: <49925549-f8ee-163e-9115-6cfd3de73e83@amd.com>
Date:   Mon, 17 Jul 2023 11:29:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/2] docs: Integrate rustdoc into Rust documentation
Content-Language: en-US
To:     corbet@lwn.net, ojeda@kernel.org
Cc:     jani.nikula@linux.intel.com, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230717151624.3470714-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0078.namprd06.prod.outlook.com
 (2603:10b6:5:336::11) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e5d7fc-49f4-4783-ba92-08db86e2fe63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5Is07dG5WpPTYgLXzavDiu+0oBB0FkDL8ZQx9TDOh8TPe+vXryIcgSmMnz1RxWvX7J9t7tAnSGt6rSH9QeVKSDodcmAHoYzR30HBvmR8II71e8tyVFMT7wclMrqCw/zcQHqCY0iPBXTJm1tVmV/Fr7CTlqgbhfLkFjb2Z/HMY7bKmQrQB7hvaww2nAeFsV6zaUTX8FVBDB2hs8YPe9sIASBnU3VQHQZZ1y6mt6RM8YDzt8E0DtX9T/ByvT7Jr/a9PlM//CdGGOndCdTbYZSmKsRghRdBtUU7howbBpDv2z2v/HyMz3GkW3PNkmaOoVx6u+6XmnOapP09TiFeuU+2m73caGrgjQLvW0VMtVt1UygPi+3hB3hj7vWqVgCegUTfTU9Z/+fTEGR0dKizxEAQPTvk8mLx/cBVpOJ5UtHqGbILq5Uv1fJcQ9mvb2OV7/2o5SxNTZKY87Affzq5zSQV+82QjawIktNjrZ6tu6SC3q90S9jLCbofbKYX3g2Wf+48oEsCRuj5n5bli5a2Gk4jWOXYKlWLjhWJQFgZlpnUIjQVJ03ge5d2aSb1Z94eubtfCjA1O4Xo5D8uaWCI3IgDpIPrJRCfO4W55803zDXSCtrDeGVgYDOaElxqFjmE2yJvsLpirrgKW3mIdmGd5sAdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(31686004)(31696002)(86362001)(2906002)(36756003)(44832011)(966005)(6512007)(186003)(83380400001)(6506007)(53546011)(26005)(38100700002)(6486002)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZCb2JqQ2x6RTFFNHhYNGdRWVozOXg4VkhzeE83WGdrck9VT2ROL1hITnhI?=
 =?utf-8?B?eHhLNEdiVGUzWjJpVGdrSWczQ0Y4elhUdysvdnY1Y2RtQm0xNTZwTVhCcENB?=
 =?utf-8?B?TjFFT2hrcDBWcnJlZ25sRTRSVGNOVEtxdXNMTi9zeEhJdjJSSWN2VGFzYWlq?=
 =?utf-8?B?ejhXVmhUdmw0cXdIcTFjK1RObjNMU3VUc0R6WnVZWHNLcUlTMkpxTzMyUUV0?=
 =?utf-8?B?MXpGYVI5QmJQL0xXR3FjazZxVyt3bm9oQUZ0NGZEOW9wZGlFc0RCMC9NWFZV?=
 =?utf-8?B?QTNTSFpDdGxTQzR2WVhnL1IzdVdKb29MQjIxayswV2U2N0FxSnFpeHVhbUpn?=
 =?utf-8?B?R25pU0NqZnBSa09YQ1JGZmp1MThrWERadXFMa2VOTHNkUzQ0VkkweTZoOE1v?=
 =?utf-8?B?cmc5MXd4clRYckQ1SyttQVpwQ1BIVFpBZ0dJYnpIeFhmbDJ3TnNRNkVQSTRV?=
 =?utf-8?B?ZE1mMjRobTVsQ0JLZWhON0Z1d1Axa1NGOXZIakl6NWtMZFBTNTRvb2tZbm94?=
 =?utf-8?B?UnFBM24yRUw3Z3Yxb1ZDVUZpOU9aOHhkSDRKdThXVEM2TFUrMlg3VDM1RWdu?=
 =?utf-8?B?aFZaVkd0ZlloUVhhd05aYTU3cnpWcllKd2pvUm1leVBoQ1VSaUgrMFVCWHEr?=
 =?utf-8?B?bit4bHZKc0cwWGY0bmg4a0d5eWFmWlRhRkdHcVFiUkRFM21yNmhDcmRnQXZL?=
 =?utf-8?B?MmkzZXpxNGErS2NpMjRhRlU5MTIzNnA1dGZwa1NsdVdNeitxWmc1eWxmUnVL?=
 =?utf-8?B?azFNazRKZkh3MXprdUxMYnlNZVV0aVdRS3ZIaU9kRFBGVWZjRklhaS9WbmVG?=
 =?utf-8?B?ZFprckRmMm9JZXplcW1QVTVrV0hXZ0Z5Sy9xSFpwZDUwMXdpRHZySHJGZnlw?=
 =?utf-8?B?akdFbk4ydWdLU0lVMThBM2JXVi9kVHU0YzVQR3N1eGNXUEFRa1lNblBTYzJx?=
 =?utf-8?B?K1h5NmpCQVZmVmpYOWFCV0FKMTNqdjF6YVBsNDVaa1duYU1XK09jdmM4S2lL?=
 =?utf-8?B?cjdSSTdFK0tXb29ENHJCeld2QXIzNVpYcllMYTlRVnR6RmlLZVFCLzVXS2Fm?=
 =?utf-8?B?OWQwaitNVVpOWWliQVRaRndTVkFlb2djQloyWkozYlZ6T3YzaHBvOTBFc2Rk?=
 =?utf-8?B?di93WVZVTUZ0aHBVUmpneFdvV0pCeUhJRWVzQVdsL3RaeG4rZVc0OEZDTmpt?=
 =?utf-8?B?ZkJKRHNxV2NqWTBxTWlRQTE4bmp6QjZxeWc0NkVBNHd4eWFTYW1PWDB1eFd3?=
 =?utf-8?B?Snk3SlkrV2ptd1c0aUZad2p5dnlmSHozYVhzU2Z2eFlNd01ObVVNWUJyNkpt?=
 =?utf-8?B?SzQ0M3ZLd3dmMDloWCsxV05ZWFNPSGY1STRTVytPZmo1dFM3RGVRL0VXaXll?=
 =?utf-8?B?aEx4ZFZXUFQrdEM5c1ZOSTZ4T0kvaG5uZUF5Ty9iRnlxVjVTeFBaK3dOdmVO?=
 =?utf-8?B?UjNkaDFnbFdKOTh5bTJOamdObEp0SEFmcitEUWJsNDhOWEdjV1EzMmFaY2g5?=
 =?utf-8?B?bi9FWk1ndlZ3c3l1TmhZWlpRQXUzVFpMeW9JRUhMaXZKQldWcGRwdVV6MWZM?=
 =?utf-8?B?OGFrLzNRaUppNGZiMzlXVFNzMGVSeEVlTVp4ZjRnb1VselBDU3lxc3B5ZG82?=
 =?utf-8?B?aWJwT1BVZ2xJUkR3b2pxVlVqbGVJU05xcEZHdExtenJSYzNTRytCZmpKWEhq?=
 =?utf-8?B?VzRFZ3ZJQ0F2QTJRUi9HN2xWMmVIc01MK0xIcnkyQUZSbnk3QzhXcGl1d3lE?=
 =?utf-8?B?MWlGM3g1U1haQUlURjlORzdlTS90SkgwQ2t1ZWtBMzJXaFFYMnh3czg0THBN?=
 =?utf-8?B?SStqKzJwMUl4OVIwY0NTbmZFSU8yNWo1bUVuSVRFSFNWL1NhTmp2MzFpSklU?=
 =?utf-8?B?SE5La1M4NTA0OXdXQ0xZaGQ2MjNBekZTRHhDYklRQXpKOWtNQ1M3elBIM2Y5?=
 =?utf-8?B?SXVOTmtFQWp4VlMrSzl3VVBOV3JId3d4Um1BNGNRaWliN1B2SFYzUnFDWWFt?=
 =?utf-8?B?cm9uNzBRZUZ1LzA5SzNSYndKSmF2RjdVUzFqWUk4M3orYzEzRGJnK01XdkxB?=
 =?utf-8?B?VjlBNFc5QmI3VnRuV21ieWJyNndpanhLeUF4TlhEVS9FRG9PV1o2ZWZzb0N3?=
 =?utf-8?Q?umBA8Kdl4/8eEGBHfOh0tp89I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e5d7fc-49f4-4783-ba92-08db86e2fe63
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:29:29.3996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEZZRYMUNcZVu9aRVHOqETzUDdHUaPWXz5CRl0cDwDdA4vM2BCu4LeSi+QAdLZJA+xzROGNzDidDFGrq1kvVRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 10:16, Carlos Bilbao wrote:
> Include HTML output generated with rustdoc into the Linux kernel
> documentation on Rust.

Please, note that you can directly test the case in which .config is
not present by running `make htmldocs`. However, to test the case in which
CONFIG_RUST !=y, it is not enough to include a .config; you need to let the
kernel compile for a few seconds first. In other words, until the
compilation process is initiated (using `make`), the build system does not
parse the configuration file or use the defined options.

> 
> Carlos Bilbao:
>   docs: Move rustdoc output, cross-reference it
>   docs: Integrate rustdoc generation into htmldocs
> 
> ---
> V6 is https://lore.kernel.org/lkml/20230127165728.119507-1-carlos.bilbao@amd.com/
> Changes since V6:
>   - Skip Rust document generation entirely if .config doesn't exist.
> 
> Changes since V5:
>   - Continue executing htmldocs even if rustdoc fails.
> 
> Changes since V4:
>   - Limit rustdoc note only to html outputs.
> 
> Changes since V3:
>   - Added Reviewed-Bys from Akira Yokosawa.
>   - PATCH 1/2: Avoid error 404 adding tag `rustdoc` for Sphinx.
>   - PATCH 1/2: Don't use "here" as link text, describe destination instead.
>   - PATCH 2/2: Check CONFIG_RUST in a way that allows us to skip generation.
>   - PATCH 2/2: Reoder Sphinx runs so they complete even if rustdoc fails.
> 
> Changes since V2:
>   - Split v2 into two-patch series.
>   - Add "only:: html" directive in Documentation/rust/index.rst reference
> 
> Changes since V1:
>   - Work on top of v6.1-rc1.
>   - Don't use rustdoc.rst, instead add link to Documentation/rust/index.rst.
>   - In Documentation/Makefile, replace @make rustdoc for $(Q)$(MAKE) rustdoc.
>   - Don't do LLVM=1 for all rustdoc generation within `make htmldocs`.
>   - Add spaces on definition of RUSTDOC_OUTPUT, for consistency.
> 
> ---
>   Documentation/Makefile       | 20 ++++++++++++++++++++
>   Documentation/rust/index.rst |  8 ++++++++
>   rust/Makefile                | 15 +++++++++------
>   3 files changed, 37 insertions(+), 6 deletions(-)
> 

Thanks,
Carlos
