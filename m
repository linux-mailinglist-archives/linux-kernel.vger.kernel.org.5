Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4768F7D4EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjJXLYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjJXLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:24:35 -0400
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2107.outbound.protection.outlook.com [40.107.121.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B6CFE;
        Tue, 24 Oct 2023 04:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSFlsNgXW24MJ9h4eXD97sM5v9fCwvUgod8lLGu837V11MGVUbIDDetqdcpa/MPDSxpt3InNWR1AG+wZA3zGwJA/VL6yNH3eNGulzxAm2hHv/TUUQCXqniVsR0XQU7vM1CR/Crfp9/OAbO5JafVZ2EdLwJaoXL7HVTGvSOtI0mRHMtKJbDj2LLtkl4JY/ndcWp2ed/p/dD4o656CBm1tZavZGYl/Oz5ta0ipBp/OA40FFWHrwb1gEnH3JeV5mIQhSabnHJA33DeBlKoeulysy99nGv5vJGstKW4bV/wdvBNWgCxgXxj18OGWRu4/Ww/0GnfpeGOu6+xnvyhqkmFTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAYQfY9DfQeZ8+GcppYXBrRnxAoSBIwx+Tv5+6g1exw=;
 b=HDYG8XkruusyVbFv3GEclEnjne0zfr45KgQjHuATJ/lYPZfmC3fXIO/BeN0zvzh6y7j1mw8KHudzIyL1InFuzBmLEILTta9HkFAWTSisqiDazR2eBhq+WPBmubx+5lbPeNU+YWH2vpKWf7LuV0ofN+KKizb2T82D8KurpdHZa8KKl1VjO7CDL2qNJ1bL5bNzWoKdgtGiB1KPpDSyepNN808HmbI3lS6ABuHD0CwEDvE/hzsbOSbSeY6Mc9Ll889HlIf4xSUlTK7zRvOKHv22kCI9rHsW+v7n05ht7ia3AJYQkr1j8dE9JVUR/yHsKO+7WSAZzK+Ha5gLajnX0nnNaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAYQfY9DfQeZ8+GcppYXBrRnxAoSBIwx+Tv5+6g1exw=;
 b=pNm7UBDP22PVGUxhdF1z3zl8mX1wTjT2dqqYwOkeBjq+7f5uuw3eGcLHqNXWNTX0R5JDP0FO8DhBt90YrQSPD2EpHqUNR+3zQYp6Y9G52jKXc02XAAyYsIhnFpo8ZXSTjeUfzx7IU6CUER8+Af5gDTsHogDqQ289xPmSH47Wt2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:15f::14)
 by LO2P265MB5856.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 11:24:26 +0000
Received: from CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6af2:36f2:4aa:6e43]) by CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6af2:36f2:4aa:6e43%6]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 11:24:26 +0000
Date:   Tue, 24 Oct 2023 12:24:23 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Message-ID: <20231024122423.383ea1bb@eugeo>
In-Reply-To: <20231019171540.259173-1-benno.lossin@proton.me>
References: <20231019171540.259173-1-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:15f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB5186:EE_|LO2P265MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfa16f7-801d-4c23-8906-08dbd483c7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bazps4AwFhuUCDJKizZXT4XtxXjuCcmyJbfUEY6x83F0dWtztGFUHeiASkkGW2lIpCh1QW769f35/DfanlcYvuTo0fe/CzpwXFkGj3cS+jkPCubf6XXXEvAzOdxSLLBLMR0bbvlUNFpSccxVybYT0h07cwo/fdbw56WWjWnhZ9WwTXeMBFrygkRixBLPbPk77t13vh88A+IwONS5nxW/PWGeEgSzGn8tyFHGl9z95pSCMaZlqcB0HZhnEVgPUrv5V8kpVc4UHqEXPhVZRvjKzR/gLZMPWqGDdzbgBTU6pUI9vxEAsesHdXjwwaoyRyV+DCt5CIDRTEgRThFyhTZDm2aALIc+ZAjvW81QTGkupZQlFszfnqDTVb+yg0J2PHM3oL5oChKNbZIFkiulVXv9kDSmp9c09xKRZ7DrXs6w6tnhpUW/beFaEm/oSqionUAmxiyWDfjUO7Krh6F2BFMLrOVkNiEdZwBzfV/WnCXrCQHSuX7kPTSeoWOPODIIMxFRFRdTHeWF7K4pscjgeM+QVa6rlZ69xlX2K2U0LubrZZu2z9zPnqp8SOwSz0LuSmoW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(396003)(39830400003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(7416002)(54906003)(316002)(6916009)(6512007)(86362001)(66946007)(9686003)(66556008)(66476007)(38100700002)(6506007)(33716001)(6666004)(6486002)(478600001)(83380400001)(4326008)(1076003)(26005)(41300700001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xfI0cZQHHSzsuVgW3dFACN2KL0nMs8cxlxUi1gvqkUq41m9+Wi9KV/hbfDc4?=
 =?us-ascii?Q?UBKhLHFQCRtM9FLwhf/84tFrwBL/VLpIvpGydHCnLerNvkm4c1T4EvERd7I9?=
 =?us-ascii?Q?03r44JAvNXvpRH8gezH0a0M89nObTGDhz3KxfCvmb1/8kzDJgk/S+XYXwUaS?=
 =?us-ascii?Q?m418fz0ftjIbghWKVk/8nQhuHXndXpzGdVYwK0+G8/zFnro34Cku4Jlo/172?=
 =?us-ascii?Q?AJdNKLmi82YQ2owgWFqRaLCp3dbc0x7rYCsslhAqKEmTkOSJJYB+KrqiGxd8?=
 =?us-ascii?Q?HxU1gFtXZxyinHz3KXb2vW0SvzowPyOFzcON9ku9IhzV8s6D1gMuIJgbNeag?=
 =?us-ascii?Q?UYDqWXsNJiADhpk3/hcHt1Or1kWuJb4C+KTX64qRIcXBdSQZLO8MIZxpYlkj?=
 =?us-ascii?Q?cxlI4NRyk2cWn9HSYGLw5uZq29/vyrh4cFsx0e492qdLqVcEmKO3P/+h8Plc?=
 =?us-ascii?Q?jYUGLfNHRF6+UnTtF7lGcNJcI8thRoq3bvdxSjDlx4iQ1r2E4+xJPzQ5bKmZ?=
 =?us-ascii?Q?6Hc6+83X7O+4fSJg4AVUtTSRnWJ11UNoPj5oIDUkWZA1+2RI0ib6uzmpKHz2?=
 =?us-ascii?Q?WJ4dI4tq4ofQafhyevdTSX/jKan5Jx3FdHAPqZEuZcDCTYfr9+ox7+J1ouJw?=
 =?us-ascii?Q?E9DQqyB4w1nY5ekJD2ZW1H/w/GKXqAXA6xJKHo1lHkVN71qURXDpQqTCGZEl?=
 =?us-ascii?Q?IGJ3H65nX0ly8oI/vTiMTjtXBy67yOBd+U4UsI5kD4rD3hmESNqZOD+8GAYK?=
 =?us-ascii?Q?8VK5KU5YZnhL4iFwtFrd/rzkZ11/Tbwvhu8OSV0BGPSON6WQLhX/a9iG8Eg7?=
 =?us-ascii?Q?o6zMn0eBn26vcwTonnvEIN0FOr9BXOuTup4ajmLzql5mU7HA/gfa5mp9VD2e?=
 =?us-ascii?Q?AD9a0VqGp9VTg9LebW4qhluEz4dZ5gZplz9Ts149+PVfXBEI6vOlSuI+qFqr?=
 =?us-ascii?Q?R2wmLeMx2Nhdv0S0xd9/Md9vHBEHD0Wv0cmQkJA7/epRAD63ihfNKFVtttdb?=
 =?us-ascii?Q?mxZHkuvpyJOz8TLibPJQocj7JSLJmlcF0P4o/SDKCzvyYhfBTXfHjmg9WI+4?=
 =?us-ascii?Q?OqMzIJ3ViHQDPfIEM1j64SpBHha98W6/b1Ck0SZErAxq5mYqlhb/iVwFupce?=
 =?us-ascii?Q?8vT//V5AWIOfBt2vG/0dWRtlIyq/iIeljIDX1xmMFX1ZUCV0biV/+X9G3oew?=
 =?us-ascii?Q?IfZfEeS2GloWBHFmsWQC4D6MwUaHV/j2u9opvz8bn9QjpWc5w4ScrMm06OZ9?=
 =?us-ascii?Q?KngG9q9EPGo652Lm6XoPghuGX1+tZ2HSLudUDGZat71/qQkV3ZYhbeRTnMM+?=
 =?us-ascii?Q?nNzdwL0tm6Pk6oBvqrGt9ufHqwOt5LYhVP6TQo8T+ngowDVORGLV8wZX8A0E?=
 =?us-ascii?Q?kBAbOhzUWmXUWfsUE1scR7EoLZnYU4gOjaaz0oz4moIJZ9gX5HpzxmCxErYi?=
 =?us-ascii?Q?V+0NXzGb7cu8GcLRdPRNo2eI1XlTejdsmxYFSa8mBlIdK07Pauv4DHGgdVoz?=
 =?us-ascii?Q?SOhbFPjSjS4dWCA68/5SWYrEl/K4glQBwuvo4cFTx/rDIYRxEm8ESaSu94jH?=
 =?us-ascii?Q?+1YQSPJ6tvcz4bVebORjwJVpIurES3sCMM0fMTBq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfa16f7-801d-4c23-8906-08dbd483c7b5
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5186.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:24:26.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN5IsK7zRWTyC5+JcBQVJdr7EytR67QVdhtBKUsfrZIwrIiKmMoWV/IPTtCimMmBnMN4HxS2WQskcQ3P1dV7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5856
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 17:15:53 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v1 -> v2:
> - removed imperative mode in the paragraph describing optional
>   functions.
> 
>  rust/kernel/error.rs |  4 ++++
>  rust/macros/lib.rs   | 32 ++++++++++++++++++++++++--------
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..1373cde025ef 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -335,3 +335,7 @@ pub(crate) fn from_result<T, F>(f: F) -> T
>          Err(e) => T::from(e.to_errno() as i16),
>      }
>  }
> +
> +/// Error message for calling a default function of a [`#[vtable]`](macros::vtable) trait.
> +pub const VTABLE_DEFAULT_ERROR: &str =
> +    "This function must not be called, see the #[vtable] documentation.";
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c42105c2ff96..daf1ef8baa62 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// implementation could just return `Error::EINVAL`); Linux typically use C
>  /// `NULL` pointers to represent these functions.
>  ///
> -/// This attribute is intended to close the gap. Traits can be declared and
> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associated constant
> -/// will be generated for each method in the trait, indicating if the implementor
> -/// has overridden a method.
> +/// This attribute closes that gap. A trait can be annotated with the `#[vtable]` attribute.
> +/// Implementers of the trait will then also have to annotate the trait with `#[vtable]`. This
> +/// attribute generates a `HAS_*` associated constant bool for each method in the trait that is set
> +/// to true if the implementer has overridden the associated method.
> +///
> +/// For a function to be optional, it must have a default implementation. But this default
> +/// implementation will never be executed, since these functions are exclusively called from
> +/// callbacks from the C side. This is because the vtable will have a `NULL` entry and the C side
> +/// will execute the default behavior. Since it is not maintainable to replicate the default
> +/// behavior in Rust, the default implementation should be:
> +///
> +/// ```compile_fail
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
> +/// kernel::build_error(VTABLE_DEFAULT_ERROR)

Note that `build_error` function is considered impl detail and is
hidden. This should use the macro version instead:

kernel::build_error!(VTABLE_DEFAULT_ERROR)

Actually, the string here provides little use other than documentation,
since the string provided to build_error is only visible in const eval,
so this you might just omit that and write

kernel::build_error!()

> +/// ```
> +///
> +/// note that you might need to import [`kernel::error::VTABLE_DEFAULT_ERROR`].
>  ///
> -/// This attribute is not needed if all methods are required.
> +/// This macro should not be used when all function are required.
>  ///
>  /// # Examples
>  ///
>  /// ```ignore
> +/// # use kernel::error::VTABLE_DEFAULT_ERROR;
>  /// use kernel::prelude::*;
>  ///
>  /// // Declares a `#[vtable]` trait
>  /// #[vtable]
> -/// pub trait Operations: Send + Sync + Sized {
> +/// pub trait Operations {
>  ///     fn foo(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  ///
>  ///     fn bar(&self) -> Result<()> {
> -///         Err(EINVAL)
> +///         kernel::build_error(VTABLE_DEFAULT_ERROR)
>  ///     }
>  /// }
>  ///
> @@ -125,6 +139,8 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// assert_eq!(<Foo as Operations>::HAS_FOO, true);
>  /// assert_eq!(<Foo as Operations>::HAS_BAR, false);
>  /// ```
> +///
> +/// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VTABLE_DEFAULT_ERROR.html
>  #[proc_macro_attribute]
>  pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>      vtable::vtable(attr, ts)
> 
> base-commit: a7135d10754760f0c038497b44c2c2f2b0fb5651

