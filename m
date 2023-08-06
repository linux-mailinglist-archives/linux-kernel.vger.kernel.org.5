Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD80E771600
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjHFQCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:02:10 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2103.outbound.protection.outlook.com [40.107.10.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D437D1B3;
        Sun,  6 Aug 2023 09:02:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJRrATqXXuzOCJTSgUGZfOFWUxqW9ujHpe/DB0+QfWzBRf51PQL6rSYreBwj5JlTcpsP0FWRw6jcFLeN4khjCOR0q3xj4rHh4KsdIEDIwloB/DlgZefEwo6NnlNf3hqw4E+UhHuG8HS8oJuOtpu210nGYScooSCxUFJ1O3Hr/TiwppKtmvRk7QXheKh1EKGR5XKxK9CIUSM+mW4g7OqNZ8PX77aflMz3yy/M4pbDSS9pdlfwyQm392rYnLCPkJyUxRklcyBsZWjoL76Lw+h4QsD3lfLKCb9xALU6kZ/ut3tK93LFTcBzC/n522LfoPT5XLn8umeEK3etB+9VB1fCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRxnszlglnpxQochLqr4Wcx+0G7pLJijkhC0/QtTqQo=;
 b=hjx87sK5zAjuob1mnr+CRH7ABUs63NfXTX8e976HnFc85C5y8xzEm6yPDusMQqfHPwn2z5Wyt5yObGLKY4U4b4mnITDaxGT57qziLvwYmjtXFZS8wKPl2t2yMKJzqt+AASWV82Ay5z+pCYQ58SJYXlXNI76kk3a2V3geWWU7JavNpnxhIzGKGBFx/H3AtvYRQy9umCH2nfLwe8fCTI4Cbqqy98E8SoTV6uG8dtsGUDiLzdoI03f4mAilUuWzqIlkjQiVRY2NPAYm89GDvyhnFCN6xRDQlIxkVLcNMoz3VsgWRX0HQVjvB4qAPWG4HZjjiQotOg3RyKYBfla3DAEqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRxnszlglnpxQochLqr4Wcx+0G7pLJijkhC0/QtTqQo=;
 b=dLX0aQmJtpy4BKjO0BJn8PJnKyV8sB9AqCaOWNsnHg1pT4T98Me2fDGtjfLwnQXo/15lAiDf9HSLy2iyVNak9saJHUf6gq1zO983Otp+ntP96fHY/ORB8K1K8hD7tUZiJ3hMwVS1r561OyAIwulrjvN+H80WXsxUEXxddpXzKuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB6503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Sun, 6 Aug
 2023 16:02:03 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 16:02:03 +0000
Date:   Sun, 6 Aug 2023 17:02:01 +0100
From:   Gary Guo <gary@garyguo.net>
To:     "Qingsong Chen" <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        "=?UTF-8?B?55Sw5rSq5Lqu?=" <tate.thl@antgroup.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        "=?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Sergio =?UTF-8?B?R29uesOhbGV6?= Collado" <sergio.collado@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2] rust: macros: vtable: fix `HAS_*` redefinition
 (`gen_const_name`)
Message-ID: <20230806170201.0bfd0843.gary@garyguo.net>
In-Reply-To: <20230803140926.205974-1-changxian.cqs@antgroup.com>
References: <20230803140926.205974-1-changxian.cqs@antgroup.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0305.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b85205-f308-466f-92eb-08db969679a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCMKwFqeoHFZBq/OfImkkE8sczKjewY/RcdJzdS5kjzVp/LeSdiRw/8AzsI2M2fNWx2cSk05d7LbJ5YOGk7TK2F/xv8eMTGYcOW43aoK/HX8U0YFT2gt3lesG/uiHs9DzyTDLH6GI/SHAmMI97RlFKlRY/yasAbFNUXrYhpkOvAsbjH56OWHrqt+zQmckUZbhkPWs5Xl8lD9DddJEKNmu88MdGAUTaT6n3Ssf0G9i2KcOUWpYJ37b8aXoaAGsrEirbSiHIuqLPeXnFifTztzLyZJDeOYjNi6ee0GQLbB+xviQo17VtBUS+N3iYRtzIGyLo3yMRkQYcEdB0RXZDyhLZyyNtUJB53MePGP06eQTjIc7c42p8sYoQz8y0CecMkr4B+kcNPkugqsidQ65SUWkfyAB+w7An/UwjSyFyqJE0ouHf5aNr1oJJjvPqq6l8vbiYpUiICMKlryWhUpJpSkDpmywsBZVG4lmXbichWxS4DRCXfURwDlHt429mdy3BaVpQ6HU49cFqrT1nqixweBQIJy9TJ/en+qEAiOHuATxTa07Za8zMDbFiOMB8Oj8cMX6EBugpEtDQ2sWPN4zRA6npfXtrZdC0b74B39QXyLOcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(366004)(136003)(346002)(376002)(451199021)(186006)(1800799003)(2616005)(36756003)(4326008)(6512007)(316002)(6916009)(86362001)(478600001)(54906003)(38100700002)(66946007)(6486002)(66556008)(66476007)(6506007)(41300700001)(1076003)(26005)(8676002)(8936002)(2906002)(7416002)(83380400001)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sk50AvktAyBnRIkTx/FWj3gtyCLktKMciVccpCQwa/HtQqyAwmrENjbqbsDt?=
 =?us-ascii?Q?wkTxTILYfTMZDDh8D3FdIcC057TYirpOURxx83fpqNDy6RpQIhEibdL8tVgN?=
 =?us-ascii?Q?hR1HgL8npJhXX1WtveVkGQBJZxX9slNb1OxwipuuJM545SsfaOGu378pMFE6?=
 =?us-ascii?Q?WzwToD3nmnOgEHkU7l+4IKQTOX7Eaywk9BapyIm/jbyVpUyQj+qBi6CEVXE0?=
 =?us-ascii?Q?7HhfCgzISJ+L+GJysWumDXlJqGb9EqAvqorrLoEi9F+OWsE686DsnsoPzqwm?=
 =?us-ascii?Q?mEStbVmio+tzczdgRw9ylAGj9tFNktdbxIKD8P8uGJ0mW5LS/+XIUc8DAErN?=
 =?us-ascii?Q?T5Ums58cCrj2ATP6hf/ZhgfFvgOcraK5+cZuAR0RTdJe8CumzprH+eISomeA?=
 =?us-ascii?Q?KqHTIOVlzC5MEMx5C8V+lEZK22JWVp2wAceZ3Px8kzE3Qqd21tTYTUM7gMMu?=
 =?us-ascii?Q?3DSaMbAxeUiCFbBVeYQ3zJHDR1bp6414yhBx/XA+LbmHkec6dBK2C3YaSV9O?=
 =?us-ascii?Q?KebN4M6K3h43SD44r5Gg0QP6R4GSLcKddJyAvGrlzuZsltBKN2dKmhtsbDwS?=
 =?us-ascii?Q?ddeMbFryuO7BjTxPLzRgowLsMwQjtZ6XfLnvbI59veXUqmlaZvP9o6npbovL?=
 =?us-ascii?Q?67Jzp3GPHKnnAr83aObt56aa/sZ0PQfbBalvwV+U93CuB81v6kHygVaaHmvf?=
 =?us-ascii?Q?AUx5EMOJ34UNHHlSICqmmQ5sPUGg18H5qn3GCwArM0H0TrrqemwDTRYpRkqd?=
 =?us-ascii?Q?qeXVHbGim/Q/JAAccM0yHWx2lz+eBjEVh25l6udoHhXpiuHkWqNcJgPHRfc9?=
 =?us-ascii?Q?zRENRZCvdGjZG/4wOIYT5dnJjas77nexnqBPIbzC6VAXQflTDTb2rgNY3E4l?=
 =?us-ascii?Q?P1+LTEPM3U4Eey9xOcBH90rK+c4aLwByZHlw8cCKyBFD5zc1LWoGld3RUxYc?=
 =?us-ascii?Q?VsTlMkD69uJheHj7do481UCZ5c7wZDNgiVckkLYBbyfKCzNn8WlDYykA8iHN?=
 =?us-ascii?Q?UwuU45P9PK/V/HyPAFPZ7Ix6tdNPkdiMr0pW+aHCvqXvoDJH0uPXKsMCNJ3e?=
 =?us-ascii?Q?Uftb5sFuiIv7j2bUb3N2WVDNiFm/+khSCYgTULaRz1THBZ5xleS9Cy2kZKp/?=
 =?us-ascii?Q?FiLyARKedoRaYRVpStvzGVhpoXmF7ZzOmHntm7TU58ZAa7w1siyUIO8kAc3z?=
 =?us-ascii?Q?YIAJ/eMtmy1QARBTOabvEU8W1sYEUma2AwhDSvjnBFnb//Zgl8ry7+IK+j81?=
 =?us-ascii?Q?Gck1lbqKHB+0FHWnjKor0183YNYhVrd+rKRpJoItZL371sELS54mjaa7w7Vn?=
 =?us-ascii?Q?5HwBw5gbMdZUauQmychq3S5pel1UcyYV1wFB4mYfA3xU6+MyE41hfh3Fxfsl?=
 =?us-ascii?Q?TXlu5TuRSVAc5O6VAAYanai0J0Y8SuldlwLO+IpvurdXaJXjwBiYTDjJx16s?=
 =?us-ascii?Q?od0SmjYihUU2CRdmZRhA+hAIzRod/uhcTZ0FQ8Byo+lv3tyZ6nR5iFJAcbs1?=
 =?us-ascii?Q?yYc6cQPdi7qWR8vIt/NkwWDSvWVHiVfL0yzpwFEDLHBssq1LEC96uHOiWA4w?=
 =?us-ascii?Q?DlVAiFLYapl2FmaVTWML8I+EAffRYbeow6yUVOoq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b85205-f308-466f-92eb-08db969679a3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:02:03.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahMmhomygJW3hAutGb7zZ92TdStailCvmiqoHVTCbwLQX1owSLn8Ti3oGcFPNT+XwMctHeek+0zd3zP6ZVOQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 22:09:23 +0800
"Qingsong Chen" <changxian.cqs@antgroup.com> wrote:

> If we define the same function name twice in a trait (using `#[cfg]`),
> the `vtable` macro will redefine its `gen_const_name`, e.g. this will
> define `HAS_BAR` twice:
> 
> ```rust
>     #[vtable]
>     pub trait Foo {
>         #[cfg(CONFIG_X)]
>         fn bar();
> 
>         #[cfg(not(CONFIG_X))]
>         fn bar(x: usize);
>     }
> ```
> 
> Changelog:
> ----------
> v1 -> v2:
> - Use `BTreeSet` and existing `consts` as suggested by Alice and Gary.
> - Reword commit messages as suggested by Miguel.
> ====================
> 
> Fixes: b44becc5ee80 ("rust: macros: add `#[vtable]` proc macro")
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
>  rust/macros/vtable.rs | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index 34d5e7fb5768..8a1baedcc280 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
> -use std::collections::HashSet;
> +use std::collections::BTreeSet;
>  use std::fmt::Write;
>  
>  pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
> @@ -28,7 +28,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>  
>      let mut body_it = body.stream().into_iter();
>      let mut functions = Vec::new();
> -    let mut consts = HashSet::new();
> +    let mut consts = BTreeSet::new();

I don't think this is actually necessary because `consts` is never
iterated on.

>      while let Some(token) = body_it.next() {
>          match token {
>              TokenTree::Ident(ident) if ident.to_string() == "fn" => {
> @@ -74,6 +74,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream {
>                  const {gen_const_name}: bool = false;",
>              )
>              .unwrap();
> +            consts.insert(gen_const_name);
>          }
>      } else {
>          const_items = "const USE_VTABLE_ATTR: () = ();".to_owned();

