Return-Path: <linux-kernel+bounces-10462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A22EF81D4AB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190F41F224DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBB4DF63;
	Sat, 23 Dec 2023 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WjFeoT/V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2118.outbound.protection.outlook.com [40.107.121.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BBDDDA1;
	Sat, 23 Dec 2023 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9PA6l0D3Q6MfhwOUKbts9xE60M0KZFJ753qFpgNAwan14blC7c5BbPcHrSgNGetNcpAxxcMsLA6jDefDJZohA0s94HaJoigubRGeWl3XX5C+QK2urGDJIg/DnwI77nDSv/EwxL/ud7fsKEM25duWdaxw1pkEtI1ldTmFB9NSHxgbcHFKLV2eoIxbzeFv29CVcT2GQTzt3W2+X6UqWJgR6Ef7t8EFHehDvGCcz9odT+K91E2GWC4nNAcl80npRo32EqZ7Id00pYDC8tKzely8EuJQ56GmR2ihN7WdJ+ZXuQDOxcJBEO7XwlM7l2CQ15xEhWL7aTcVobaGhYsnjPeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrbG7KztoKKkS/GczNeJDOV6ofuyR6zoMFibWXyoltQ=;
 b=nqIH7OIQFbd47Lmax04uTB+ki4ptP+EQbW2alj2mBLbYmD2sv+2IYvA8lR/UaFvSNxXH9Mtj607lNGQBUJkaoVWKLxXAr9e14h603mXHMeUdVy6x3UBpcQTml+BwX7U3WFdzxOR08pxMsVagLI8f2ii6y+6PpQ8mjuGl10w0T8GrzWkFlY7LiUy3fn+5NLAGiNZAvjAnQjX2v/Zon2D9T+26v9iQMLnAncVQCBV9jncnvdsWoAHT/ivUyfiD0Crqqio3zk2UhWOX2OZMF4AXXRBnge3g4vZJUPUryCdTIWOz2cQ0RIx3ubFsuy/8Cj5i4n/sCjS7evR7OFjlPXg4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrbG7KztoKKkS/GczNeJDOV6ofuyR6zoMFibWXyoltQ=;
 b=WjFeoT/VXKzeJYNbK8uFx0UcqNicNRW/WUYy+zW9d9oXUdVpoXtNCyHP2z0SvFj+UlzuocH+BZDZSKFgCd4FHxwhN1HdmXNf+ATKr/8BR/Siwg5sFeTst1u04baWdXk5H5kLKqpzOWOMH7goA7Wt9V3hq6O1xiKJbXItY6NPGrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB1908.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:49::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 14:41:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ec07:aa7e:ffbc:ba47%4]) with mapi id 15.20.7113.023; Sat, 23 Dec 2023
 14:41:16 +0000
Date: Sat, 23 Dec 2023 14:41:10 +0000
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, Sumera Priyadarsini
 <sylphrenadin@gmail.com>, Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
 Asahi Lina <lina@asahilina.net>, Martin Rodriguez Reboredo
 <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: macros: add `decl_generics` to
 `parse_generics()`
Message-ID: <20231223144110.346766ed.gary@garyguo.net>
In-Reply-To: <20231213220447.3613500-1-benno.lossin@proton.me>
References: <20231213220447.3613500-1-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB1908:EE_
X-MS-Office365-Filtering-Correlation-Id: b3541770-a872-49f7-9072-08dc03c537bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	czwph+PG1b5E55I4MgCHX4t9CIm9Ncet/NEuONYXYj1cpFt4B7X19T3emjTk+BgZF7pnskUrirMKAbVgXqzNCKsRYdjH4gyozDKo6WWsKcRbEMH7BTku0s+cPOVXIg3Iaw436yfRyJ9lBAU6JapSKy3BxvFpojhvYTSXKUHiBeb8lsw/L5VnSxdMctTk13wvjSEfPeWFh1U3w/l97U3lX586qXwmSOchvXztJZpCeiWNgULlP+A4iOgyiEs2Z3VpnNxtzIwcsSLHQEtOBktLFg9jT7fd7uh4jFo/Lhwfgzyxzkvn4ksCemdCRza1xZWdlvEICRPeDoKm3FtlGO3E11iNX4PszddUygRHMQs8n36N/90D67riGDgj/dGt0vl9m2ku5w262kJP3jUsmE6OUtwvHb7v8Z9tKzd64OBxvLOFBkCCNPhkDt73kTCVhjp6GCuPrUiuU/0BqXy6+e0CBORpBaCePD7+fhJL+wQxZnwZ0taFXUU++nJufaULuDepUI8U/Xtp70cewPUvmtssCj7PHwKb9kACYhPuVCA3SEaDj2NgxwaBFW4nzUYk6AG3zdFtGDE9S0toVAbeZqiSeKCZFcZdMeZnwoNE7p+AMeo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(136003)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(86362001)(66476007)(6486002)(6666004)(66556008)(478600001)(6916009)(66946007)(54906003)(316002)(6506007)(6512007)(2616005)(1076003)(8936002)(8676002)(4326008)(38100700002)(2906002)(7416002)(5660300002)(36756003)(83380400001)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Db0Q7T8SN4do8yThcfCvb6+IdcRCufwVqmY1siMXfWEoGBzUpb2xf+teuoZ1?=
 =?us-ascii?Q?MDextqciPYY2bILZYsytknI9/ySGaiZRPucaRD7ZGVJIr+Xza4vYHjTL7Ank?=
 =?us-ascii?Q?1qpT9SWk8lojX3IUYA7QoIZauUK7ulL++6XOqqWmrt7jHL03XRkW+rkxsxZe?=
 =?us-ascii?Q?5Aws1dWZ9WCNaMBg4L6ZaUMUsiJv82IIcWMyXpX+kEguhRyFAWPqx0Wp+QVx?=
 =?us-ascii?Q?RUCLVlqHWvl/30JNpIY7bJtn3NBMdXoA/nw/t/4bWRaPcP87ea70kuDGFyBo?=
 =?us-ascii?Q?QMxAphgdjEJr99DP7oi8W3kHM3Kp1395oQSnL39BWuGnbzz0VlfFa9hxZNuA?=
 =?us-ascii?Q?jnL28QlEKB5LP/wlKk2yvT1e8ZxGvzM1taHYctMadWUIj1UhU7vrx1hRGHjN?=
 =?us-ascii?Q?ngcphwUQzuKOd8Xx6AQjA91LJCHY7J5UjUC0N9JAO9yOdXf3CSIoVD8ENqvJ?=
 =?us-ascii?Q?ekuDTg1SRq650JubmiD0VyrIWXMmAgSgTdMe0yzu7ClNNdqKu6eVsTgoq+Fi?=
 =?us-ascii?Q?lcLU+gRqAdsiE3AA/t76leB8d9N/7cHQhqpwJZyu8J9K+OuVb7tFuNKimb9L?=
 =?us-ascii?Q?N5WURUC45bW3/N2cQMYJ+HG074RdGryvqTkuwcLk8+m+33hDaD8dAIlluWl0?=
 =?us-ascii?Q?5hTHmIBobMn6Z9ncWDc00pEOMIoPFKvu009MYFqQQWajSmo5wM8fvN/a/MrL?=
 =?us-ascii?Q?2xls4+IM6NtaLv9sl9c7ADEZR9ruwQxTSvqYtGRNbWYmRbNY7z78dg+fwIjG?=
 =?us-ascii?Q?11lWSFIxpk1Ma35ApqBlI0K7JXLolUszdibniCzJYeT+5VJhUdBePMUp20oI?=
 =?us-ascii?Q?eNu8s33ldII2bijQet0ctgfsBjCzhrR6/xZpTk0GxNjPAvQSpmzA/Wn0WZrK?=
 =?us-ascii?Q?gt9FdolkZrZ/lmi2NsGQr9foxrR0hfRZvgD3WYz6hqrQSbmj3IG+Agf58ZV8?=
 =?us-ascii?Q?wd7o5Yf3Gj7bkhTan2MUnuK6WOrz8pETxnJLJxV5v/xRbIJ87ToKoNM0mceZ?=
 =?us-ascii?Q?krO79aTQdJ4VUhaZoIIbbp22CTwGNsJy1xMaIlGjlCkDteP72D44c94O8SaQ?=
 =?us-ascii?Q?i9art8Ac8gAOSh8Osjpu0TEGoa0W9evbP/CFNB3dYK/NGvhIMuJFRCLgowAt?=
 =?us-ascii?Q?wO494/ONv0mnnpcTsnum2FkF2W3csJ70mv21BPMckGaWFDUMHHqjkEeQV220?=
 =?us-ascii?Q?9zp9DL5Yoc1rGXZ9S5rWZDq3/peFFUkjoOhEE4cepQB2mqFMchSaR7f38xJf?=
 =?us-ascii?Q?x5eKzOXcfkE2qzeO9zWTBfN92dX8c9jhK0cG+otENewHl8zqqjFfk9m1JUbq?=
 =?us-ascii?Q?c/Q8P+vDMQ8otmcedy2do4s1gA8eDt6D1aSyEINRjSDq//rOmCKHtJgd7itm?=
 =?us-ascii?Q?/nPPw91DsCwEOK9LFqsgOqms4XKqHg4nMylO5/LAFGUl1HELSR0Hmv+ApY5+?=
 =?us-ascii?Q?kOHrUWlSLzLjJXS88T9vXZEK0OAW1fP/W0+Yo6VbbRv05gl+refqr3hOBn1j?=
 =?us-ascii?Q?mAHr2OeuhJU4lMODNBt/f1WjzxJmSdtDpUH+cnmIVPuDUsvFyjUsTUDfnL0Z?=
 =?us-ascii?Q?anJQu2HVA9US/WOJkuz9eY9J85f+7FE38I9JvFeaBG0VkToy9CqRuDmbk4TS?=
 =?us-ascii?Q?dEZ55o1UuQlQq44yBsvxxzFX7RzErBuepjoGJb5cCv8n?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b3541770-a872-49f7-9072-08dc03c537bc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 14:41:15.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bH7DRsU/Al1b7Gzu6+/vWIMDT8iflkb6qYIBtPuGBjFK05kWOEYaWc2y6qwH3PHpFiU3fmqTxuCT08eVafPYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1908

The logic looks good to me, some nits:

> +/// Parsed generics.
> +///
> +/// See the field documentation for an explanation what each of the fields represents.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore
> +/// # let input = todo!();
> +/// let (Generics { decl_generics, impl_generics, ty_generics }, rest) = parse_generics(input);
> +/// quote! {
> +///     struct Foo<$($decl_generics)*> {
> +///         // ...
> +///     }
> +///
> +///     impl<$impl_generics> Foo<$ty_generics> {
> +///         fn foo() {
> +///             // ...
> +///         }
> +///     }
> +/// }
> +/// ```
>  pub(crate) struct Generics {
> +    /// The generics with bounds and default values (e.g. `T: Clone, const N: usize = 0`).
> +    ///
> +    /// Use this on type definitions e.g. `struct Foo<$decl_generics> ...` (or `union`/`enum`).
> +    pub(crate) decl_generics: Vec<TokenTree>,
> +    /// The generics with bounds (e.g. `T: Clone, const N: usize`).
> +    ///
> +    /// Use this on `impl` blocks e.g. `impl<$impl_generics> Trait for ...`.
>      pub(crate) impl_generics: Vec<TokenTree>,
> +    /// The generics without bounds and without default values (e.g. `T, N`).
> +    ///
> +    /// Use this when you use the type that is declared with these generics e.g.
> +    /// `Foo<$ty_generics>`.
>      pub(crate) ty_generics: Vec<TokenTree>,
>  }
>  
> @@ -81,6 +113,8 @@ pub(crate) struct Generics {
>  pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
>      // `impl_generics`, the declared generics with their bounds.
>      let mut impl_generics = vec![];
> +    // The generics with bounds and default values.
> +    let mut decl_generics = vec![];

It'll be great if the order if the same as the declaration in struct
above.

>      // Only the names of the generics, without any bounds.
>      let mut ty_generics = vec![];
>      // Tokens not related to the generics e.g. the `where` token and definition.
> @@ -90,10 +124,17 @@ pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
>      let mut toks = input.into_iter();
>      // If we are at the beginning of a generic parameter.
>      let mut at_start = true;
> -    for tt in &mut toks {
> +    let mut skip_until_comma = false;
> +    while let Some(tt) = toks.next() {
> +        if nesting == 1 && matches!(&tt, TokenTree::Punct(p) if p.as_char() == '>') {
> +            // Found the end of the generics.
> +            break;
> +        } else if nesting >= 1 {
> +            decl_generics.push(tt.clone());
> +        }
>          match tt.clone() {
>              TokenTree::Punct(p) if p.as_char() == '<' => {
> -                if nesting >= 1 {
> +                if nesting >= 1 && !skip_until_comma {
>                      // This is inside of the generics and part of some bound.
>                      impl_generics.push(tt);
>                  }
> @@ -105,49 +146,70 @@ pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
>                      break;
>                  } else {
>                      nesting -= 1;
> -                    if nesting >= 1 {
> +                    if nesting >= 1 && !skip_until_comma {
>                          // We are still inside of the generics and part of some bound.
>                          impl_generics.push(tt);
>                      }
> -                    if nesting == 0 {
> -                        break;
> -                    }
>                  }
>              }
> -            tt => {
> +            TokenTree::Punct(p) if skip_until_comma && p.as_char() == ',' => {
>                  if nesting == 1 {
> -                    // Here depending on the token, it might be a generic variable name.
> -                    match &tt {
> -                        // Ignore const.
> -                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> -                        TokenTree::Ident(_) if at_start => {
> -                            ty_generics.push(tt.clone());
> -                            // We also already push the `,` token, this makes it easier to append
> -                            // generics.
> -                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> -                            at_start = false;
> -                        }
> -                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> -                        // Lifetimes begin with `'`.
> -                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> -                            ty_generics.push(tt.clone());
> -                        }
> -                        _ => {}
> -                    }
> +                    impl_generics.push(TokenTree::Punct(p.clone()));
> +                    ty_generics.push(TokenTree::Punct(p));

This could just be

	impl_generics.push(tt.clone());
	ty_generics.push(tt);

?

> +                    skip_until_comma = false;
>                  }
> -                if nesting >= 1 {
> -                    impl_generics.push(tt);
> -                } else if nesting == 0 {
> +            }
> +            tt if !skip_until_comma => {
> +                match nesting {
>                      // If we haven't entered the generics yet, we still want to keep these tokens.
> -                    rest.push(tt);
> +                    0 => rest.push(tt),
> +                    1 => {
> +                        // Here depending on the token, it might be a generic variable name.
> +                        match tt {
> +                            TokenTree::Ident(i) if at_start && i.to_string() == "const" => {
> +                                let Some(name) = toks.next() else {
> +                                    // Parsing error.
> +                                    break;
> +                                };
> +                                impl_generics.push(TokenTree::Ident(i));

Similar, this could just be push tt.

> +                                impl_generics.push(name.clone());
> +                                ty_generics.push(name.clone());
> +                                decl_generics.push(name);
> +                                at_start = false;
> +                            }
> +                            tt @ TokenTree::Ident(_) if at_start => {
> +                                impl_generics.push(tt.clone());
> +                                ty_generics.push(tt);
> +                                at_start = false;
> +                            }
> +                            TokenTree::Punct(p) if p.as_char() == ',' => {
> +                                impl_generics.push(TokenTree::Punct(p.clone()));
> +                                ty_generics.push(TokenTree::Punct(p));
> +                                at_start = true;
> +                            }

I am not sure why the ident above uses tt, but this spells thing all
out.

> +                            // Lifetimes begin with `'`.
> +                            TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> +                                ty_generics.push(TokenTree::Punct(p.clone()));
> +                                impl_generics.push(TokenTree::Punct(p));
> +                            }

ditto

> +                            // Generics can have default values, we skip these.
> +                            TokenTree::Punct(p) if p.as_char() == '=' => {
> +                                skip_until_comma = true;
> +                            }
> +                            tt => impl_generics.push(tt),
> +                        }
> +                    }
> +                    _ => impl_generics.push(tt),
>                  }
>              }
> +            _ => {}
>          }
>      }
>      rest.extend(toks);
>      (
>          Generics {
>              impl_generics,
> +            decl_generics,
>              ty_generics,
>          },
>          rest,
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> index 6d58cfda9872..022e68e9720d 100644
> --- a/rust/macros/pin_data.rs
> +++ b/rust/macros/pin_data.rs
> @@ -10,6 +10,7 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>      let (
>          Generics {
>              impl_generics,
> +            decl_generics: _,
>              ty_generics,
>          },
>          rest,
> diff --git a/rust/macros/zeroable.rs b/rust/macros/zeroable.rs
> index 0d605c46ab3b..cfee2cec18d5 100644
> --- a/rust/macros/zeroable.rs
> +++ b/rust/macros/zeroable.rs
> @@ -7,6 +7,7 @@ pub(crate) fn derive(input: TokenStream) -> TokenStream {
>      let (
>          Generics {
>              impl_generics,
> +            decl_generics: _,
>              ty_generics,
>          },
>          mut rest,
> 
> base-commit: d9857c16cfc6bce7764e1b79956c6a028f97f4d0


