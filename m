Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6F77E7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbjHPRnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjHPRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:43:33 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2135.outbound.protection.outlook.com [40.107.11.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5C272C;
        Wed, 16 Aug 2023 10:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONCD0a7oqCIkkX0/wBNOGw6RycRq6FYJ2xQOCLgB0+wWQ4DjwRaopt14dCGbZe8bYCx0s6+LC/ObfNrUrteciCOJ6swgp1VTXiZncBj4l6Qf33X09XKpYNlnSUF4EO+eJytNSp7GsislAk+gDks3NaYzRaPnyJZ2rVmS5wHchYNkZeKyx/BAz79rwiyj46hqD7asLDepU4WyhcVHe+lzaxbPq3TBy5nGsW5+wykfUkf+NS2okuHXR0O7GEV97lytFHsDvv9T3wfC3vUBaXU4WAeWNaoutxgJP7F3bzmjEl0bglFnDv3f9Tra+DaME4CgNEEi8ZJDzwIVB2U00RqLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFDSMvjptutU4+zeceh6fJuTjEt7MWcIHAX2nkji6tY=;
 b=OkA1j99QVYtbv4An49oVWQG18BWVXPhis0ZMG84TTa/jFVj1VmvPchI/Y4fZUFg2I02fyd3EEONElzHMn6TXormULJeXSdqliFu1ynBL8YLG/ltZ0HJcXTexnPIpeXMjaiDQJ+bgByxLE5JWMucGwf2BzbBhItW7pnQdJV09LH9X4nja8z+uC0j2cgiTuE8Xa1vUYEwzbzdJhlptoQI9xTF7VPQ2PuPhBpgedJyfQuLJOXQFAtdjOpc5BfgLFae4r0Dtqb0IxBKXSsKBuvc3T0DEQ4CA5Y2X2vsMPUZ4WcXodD+IgMzgVHYFuwQKjac7gAZCjg5lgmrBRsgsBwUvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFDSMvjptutU4+zeceh6fJuTjEt7MWcIHAX2nkji6tY=;
 b=Yp8kuYvlCm78B/raADWECWKFqYpKE9HqYmN+YH7SDGtZNoGbC3J0ugztK96hPn7kH0TozSMpLGuD9CRnZryWmQg3mUqR56KBgEvaKEb4P7PfEmXdlG7D1jm+1sxNyJp+btPA4Pg8Lk84IV8rj6nG75Aei9MrxbN3tOzEBAT6zEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB5275.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:43:26 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 17:43:26 +0000
Date:   Wed, 16 Aug 2023 18:43:24 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Benno Lossin <benno.lossin@proton.me>,
        Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 08/13] rust: init: Add functions to create array
 initializers
Message-ID: <20230816184324.41a91d73.gary@garyguo.net>
In-Reply-To: <20230814084602.25699-9-benno.lossin@proton.me>
References: <20230814084602.25699-1-benno.lossin@proton.me>
        <20230814084602.25699-9-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0174.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB5275:EE_
X-MS-Office365-Filtering-Correlation-Id: c0af7908-ad23-416c-c323-08db9e804b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZa2r08K5xomz8yRBREww2uk7W0K/S710itN4Wuq1AoSvEV8I2jzWuR/dA4J50m04bRwgfytVjVB76fW585ys7XEx/N32AifD3iSorixiXWKUDNcqBGvyDx8gkCjEJoHGy4TwBdWi2getSYcCVxcPnDBkhXUCPWqZ9adF84KmIvbvW0JBxMOvQnrlguI3EBTinX5TF5Lzs/BSFoX3JeZ7mU6IFpOYjBeZ/y9ZqibaVWM1fVlK4n7RufaOzGo5M/dONFdvh4aQe8mxZcaVWNg51MfvPZe12ZlqlM8zgIymiZX+5FIyb0nS/jllmxgcyxvLNx0D6ds5b0CPWAF0vnIbGPvfAlvfA9mmjM3URl4a0yV1TrQmN3Uku6TOBE8wWnIENEBYw7wwsHVV3NaIeXoOtUXe4Kp8OxElwE5oAVo/8MFbVtjh0kPU3Jsbe/lfk8/OQJY6xI48NjjJcDmBfhUA12wYtfzwr+T56UKJU+8SIDx2/Oz0FjxuTg0rXwiIPJkETHbDlbcpPTjCSnmhppZcj/FuvrNXgCUslIQKNq8tXtt71jhqfCgy2Fia/2pYYOg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39830400003)(396003)(346002)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(6506007)(36756003)(6486002)(2616005)(1076003)(6512007)(26005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(110136005)(8676002)(8936002)(4326008)(66574015)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRVQW5CZTc3MnUyR1ZRT05WQTlkckRpbjRlNERqbWIya2Y1WENvd3cxSXZm?=
 =?utf-8?B?ZW81NG1BQ0ROTEFFb2tlVGdFOEZPbXkzWUVueHk0U1E3RWxPOHIwbE1KTE9T?=
 =?utf-8?B?b2t1NHhMSENJQlgzV1RGNnJSZTBxa2xIa1hzalRwdG1mei8zRnkxOVFpdGlS?=
 =?utf-8?B?K1NYYjgrekxGZ2syckNpemJrazBjVmQxNVA3dFF1NEFESGI0VUNmVHFycXhL?=
 =?utf-8?B?WFJvSGRVc28vNUZRZW5KRXRiQjlFa1JLOHVrMWxyYmJPUHBRQmpSN1JsQTZK?=
 =?utf-8?B?a0tNTkp2bEpVd3ZzZlpEV2Y5N3B1MUJCQ1NFMXNQakFxYkZLYnJNQXlRbUFT?=
 =?utf-8?B?cHlyTTNVaEw2NzZOUEFlTGFHMnQrbnpjQ0F3UmU4b2xZS2RsRVB2YkxmT2c5?=
 =?utf-8?B?UDFQQ3ZpRXgzeG1UU0tOalcwWjZtNUxFTkNEN2JFbCtTd2kxZGZBc0pYRTEr?=
 =?utf-8?B?SGt4NzBFRFI5UVpTWWhRSHdUbXpTT1VUVTVKcmNnMExhZFRhNUlmdEFrOVM3?=
 =?utf-8?B?d1U1Wjk2NEZua3NZcVRmOXovWktKS3l2ejRrUy9VaUVHd2VMaTdDY2lGR0xX?=
 =?utf-8?B?c1lUOTlVNW1UMXZUVEdmK2sxd2dZaWltdWxETURBK3ZVbWxnQjFTQk52WGtk?=
 =?utf-8?B?RGlxN25YN3ZtNXowVjFUSGVCMUFqR0E2VmxFRG5sRU9BNUFBanZQMEE2Vkxn?=
 =?utf-8?B?ZnJpZElUUFh3VEtqMjBSeENCeWFKRXRFVFkzamQxQ3RqczN3RHVNVjNlRnox?=
 =?utf-8?B?Sm5GOEtFM0g3a09oMjV0eE9jUnVaRFZhM2ZjNWExV3JFOFFyaEM1Si9RVHcv?=
 =?utf-8?B?cmFldmdGTjIzd2N2alF0UHBadUFXQ04wOTM1Z1luelByQmhaaUJLT3BGRFdw?=
 =?utf-8?B?em91NnZjM1JJOGVrVHhKVU5UdC82aVRvRERudU14aklEOGphNHh5QVVSK0xK?=
 =?utf-8?B?TlJ3VmVTazFxY0NpMFJsWGJYTloyZm5jeFJwNG03WmwxQkhHYUNlRjlyZDdh?=
 =?utf-8?B?eENUbzdUb0JhWUR4eVU2N0xmeHFncFdpWlpMOXFIaXJZS0tqcTNyczlDVW5J?=
 =?utf-8?B?Q3hTTWcwRHE0Z3I1VVNwL1NYSWg5KytobFdNTVl2bmt1U1Vsa214NkdoYTBN?=
 =?utf-8?B?aGJyQlNwOCtOZWVvMFFxczJHOWhqWHpVRUZtR2psb0FxMCtoTnpyRmFDUVhQ?=
 =?utf-8?B?Z0lqWFJJZ25ER0lkQjNoTEJSTm56NGhodWloOGRZaktPM0JsdTJYc3ZwL3NJ?=
 =?utf-8?B?NERnNUZvejFwSERQWEpDbTRnY2ZZcjZKc09OZFZnSCtJd3k1d0dYKzNwNkpW?=
 =?utf-8?B?eEFLeTNiQzhTL25XNVZQc2dXRDYxOXFLOFhObXdUTVN2QWorV0E5OG1sL2V6?=
 =?utf-8?B?T0lXd0FDQitvMSsvMjhVcUtPUFY5QVFTTEc2ODJVUXJqbFJ4Y3duZzV1ZTBr?=
 =?utf-8?B?ZVdhZTNRRnpFeXI0Tk85cDZ0SHp5MXVEd3YzTmM5R1pHeDdHbWdYMjhEeHVW?=
 =?utf-8?B?S2JyRDRJckV2YjROb3RTcnZpRlpTN01iSlc2czdLbXdyNlZEOExEdGI5YnNq?=
 =?utf-8?B?K0xQektYZXZRYm9oc1JsL1lwVVQxenpjUU8wcE9zWWVMMkc5L0I2Mjc5VktN?=
 =?utf-8?B?cWVVc1Rvenkvamozck5JTEZuYmx6VzlURllGblpOYTF4S2JIS1RuQUVueHA3?=
 =?utf-8?B?VlQvTGFkYlVqeHliVVFvVWlmSDdIa3F4Wk1OR1d2YUdMaUVyY1VvWlF4cmFB?=
 =?utf-8?B?LzlKekFkK3lmVHZwQjQyYjVIWm52T25jS0pya0J6Q0pyaEJBM0NGL3hrVnZB?=
 =?utf-8?B?TGFYT29FTkwxMFZwb29xdGpXK1RNNTNaem5QNnd6RjUvQ1lrQXdkQnRhZmEw?=
 =?utf-8?B?aWtoS3ZyWmprLy93LzFzWGZZMHhHZVA2aE5qY1M4QzBLN2J5alkveFBLQTQw?=
 =?utf-8?B?NzNXckdWdHVreXZJQ3d4VnNtVktLOWlmcHFPZmhIZVdkT3Bxa3JPR2ZLUUZp?=
 =?utf-8?B?ODFvY1lwdDI0S2FaRnRITzhWTVMzcWlzdkVxYk10WVdLZnJUYm5qd0ZpMnA4?=
 =?utf-8?B?SmhWVmQ3NCtUVVNhbVFMOFdVVDhyNW9QbzkzZHoyMjV2bVVkN0cwOXlOSEtk?=
 =?utf-8?Q?E7B3Th8wkSWvt0N9v389JA4Z+?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c0af7908-ad23-416c-c323-08db9e804b7b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:43:26.3770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfiNuclwTycImrTZ2FfRJUq3yybuWSF0GUDg2R9M82auUf45lsWdebXT2M3raIj+E6UVarTACFixHa6wrCW9cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB5275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 08:47:15 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
> take a function that generates initializers for `T` from usize, the added
> functions then return an initializer for `[T; N]` where every element is
> initialized by an element returned from the generator function.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v3 -> v4:
> - changed example size from 1_000_000_000 to 1_000,
> - made functions unwind-safe by using a ScopeGuard,
> - added Reviewed-by from Martin.
>=20
> v2 -> v3:
> - changed doctest: instead of printing the array, assert the length,
> - added Reviewed-by's from Alice.
>=20
> v1 -> v2:
> - fix warnings and errors in doctests,
> - replace dropping loop with `drop_in_place` and `slice_from_raw_parts_mu=
t`
>   inside of `{pin_}init_array_from_fn` functions.
>=20
>  rust/kernel/init.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 460f808ebf84..b54f32017d00 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -212,6 +212,7 @@
>  use crate::{
>      error::{self, Error},
>      sync::UniqueArc,
> +    types::ScopeGuard,
>  };
>  use alloc::boxed::Box;
>  use core::{
> @@ -875,6 +876,93 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E=
> {
>      unsafe { init_from_closure(|_| Ok(())) }
>  }
> =20
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{error::Error, init::init_array_from_fn};
> +/// let array: Box<[usize; 1_000]>=3D Box::init::<Error>(init_array_from=
_fn(|i| i)).unwrap();
> +/// assert_eq!(array.len(), 1_000);
> +/// ```
> +pub fn init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl Init<[T; N], E>
> +where
> +    I: Init<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        // Counts the number of initialized elements and when dropped dr=
ops that many elements from
> +        // `slot`.
> +        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
> +            // We now free every element that has been initialized befor=
e:
> +            // SAFETY: The loop initialized exactly the values from 0..i=
 and since we
> +            // return `Err` below, the caller will consider the memory a=
t `slot` as
> +            // uninitialized.
> +            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(sl=
ot, i)) };
> +        });
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__init`
> +            // requirements.
> +            unsafe { init.__init(ptr) }?;
> +            *init_count +=3D 1;
> +        }
> +        init_count.dismiss();
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { init_from_closure(init) }
> +}
> +
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{sync::{Arc, Mutex}, init::pin_init_array_from_fn, new_m=
utex};
> +/// let array: Arc<[Mutex<usize>; 1_000]>=3D
> +///     Arc::pin_init(pin_init_array_from_fn(|i| new_mutex!(i))).unwrap(=
);
> +/// assert_eq!(array.len(), 1_000);
> +/// ```
> +pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl PinInit<[T; N], E>
> +where
> +    I: PinInit<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        // Counts the number of initialized elements and when dropped dr=
ops that many elements from
> +        // `slot`.
> +        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
> +            // We now free every element that has been initialized befor=
e:
> +            // SAFETY: The loop initialized exactly the values from 0..i=
 and since we
> +            // return `Err` below, the caller will consider the memory a=
t `slot` as
> +            // uninitialized.
> +            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(sl=
ot, i)) };
> +        });
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__init`
> +            // requirements.
> +            unsafe { init.__pinned_init(ptr) }?;
> +            *init_count +=3D 1;
> +        }
> +        init_count.dismiss();
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { pin_init_from_closure(init) }
> +}
> +

I wonder instead of two nearly identical function, whether this could
be a single type that returns a struct which is Init if the initializer
is (would need patch 11).

>  // SAFETY: Every type can be initialized by-value.
>  unsafe impl<T, E> Init<T, E> for T {
>      unsafe fn __init(self, slot: *mut T) -> Result<(), E> {

