Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A016771604
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHFQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 12:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHFQIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 12:08:36 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2104.outbound.protection.outlook.com [40.107.11.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFDE3;
        Sun,  6 Aug 2023 09:08:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H101jh0Cg5t7fodFjiTAiAkdoZUI1/pDDpDlm8Yg++yf1dS/yuH5nBoWUAVVZGrnCgvZVhWk0Y2Nw0ZYQ8fQQYZj2fsp7kK73+duRsdOxe/rfAh3Fvk56BzTr/IJSki/XcRt8AoMVg3JlnqAIl6fxhwl092th+4hCawJ25Ui5hLMJlFRGz+3BiWWClBSBhdFn1K7+sEiLaTXf3IibP7jWcoQ2XqjLRSd1P7+F075SU8l/CKCACxTgSkm/Ys15QBZDB2/XcjF0Sb22hDR6c3WhXZms2EJlEXslmeDRvfvTOQF+qS+l56E9a7ZYXZAbefK7Dys4kl/Tc9sllgMMbVyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrvnwlFJONDxRLUhBQpYxbq4soQDO1YYq6E9MwD4XOw=;
 b=PdP9L8Bt8qnsd6yetsFUcEjPrDXLIfpOdQG1Wlw8eFqLqXXgeXpDZ5DiyAxkvPB0zsO5qNj3Nu4IQdvLJ8tgZArHQ2UZFzDaO+Ha8tDsb9vZSZyDg0LH6wgu6Ip5PPJi6xVNshZpM8rxQZhuV5Esslqw+SDawauZpcGiWJUItRYTMPRQYtY1Ad9eyuFDANOmwRyZwH44l+GNmPdHyPO0rbPLtR3zEluLAnhrvJF+9qIfLY2UnFNdFj+Uh3LhlKPUGAl1HLrzH2dL/ddUQEQYVG9OfXxZUWUIlNHHRDREHADXKGl1WJbvqoozgJ4aVt91ywpD0x4M7cDNgk+dhRHfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrvnwlFJONDxRLUhBQpYxbq4soQDO1YYq6E9MwD4XOw=;
 b=ML9pk8VQYsrszN09HntfARbqLrrvKEC6XnAQKv+O9rnb8//aFfyV8pql0xTYt3e3D9n2NwhQZcgzTQeiazHA/CkDO2nQsOrBn+Xx74sh0/bFL5Z2PkHuJTG6AhYW8IQuJfuw3kHWsUZfKFSiAYAf29suIOkWBIU0i89Ss4Zt948=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB2368.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 16:08:33 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6d3e:8fe2:6cdb:6d3f%5]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 16:08:33 +0000
Date:   Sun, 6 Aug 2023 17:08:31 +0100
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
Subject: Re: [PATCH v3 10/13] rust: init: implement `Zeroable` for
 `UnsafeCell<T>` and `Opaque<T>`
Message-ID: <20230806170831.5d9f73a5.gary@garyguo.net>
In-Reply-To: <20230729090838.225225-11-benno.lossin@proton.me>
References: <20230729090838.225225-1-benno.lossin@proton.me>
        <20230729090838.225225-11-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::20) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB2368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e317a14-a2fa-4355-14ae-08db96976210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qoj8nMX4QjG744jXiJzCMcDItZhH3K+F8lcVG3qbuN395907yt6PXMuRI0NRxmE/y7scJGwZXqlXkeZqK0zv9knVr2DdemCvHLS4yJJaM6IzhL6uJYHU+ut2ShGSjlQoRAWSIAPY22pE7SUDHFD/T5rOiSFrQ5j7foKOrF8n8XfjUCjEcI81ou1ELwpw4/bu844aNdXLk082zjTfpg4JwRrhdG3ZLY0w3WW6LpmhwDvC8oUds6coWYCpvAV5yA2zO89juZYyR3m4lWkQd3263vAEEfs4/yXyl/wjWKCAsdVJDNXraCq+BMRJ2X2HoiM6pixeyggtDH9896KAuUbS1HHox8uSGmKbzBZJTOFukfvODxiZtFvJN4zLH+K5AYgZAYfNIu+rJQ6S9QsyWYQymVKiCBy9xvACet2y504zj091h7Ye1kR+AnWO/IhkoSMLvMs0IMkxrhNtJJLMQSN28/hEIoz9x7Hb+wPFKe0aZP9QSLjR0u2k/SONh/RLTydPegpj4eP7oTtU2guKPGTN0mxs8YRt/6PssO9Ohh31RFPZbNmnKTlhlNKopaHYp3HGaIrHbeajma2D//0pMX2acrVown3ul57YhqMCUwxdgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(39830400003)(396003)(136003)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(7416002)(8936002)(8676002)(2616005)(478600001)(6916009)(86362001)(316002)(6506007)(54906003)(38100700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(36756003)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izpx6nlYfS7p81zgiGweXHDk20dzDd9QDVzhoEQfmemUrON8QPOXjder8Sqa?=
 =?us-ascii?Q?wxDHcAyYrluMBaSrlkBzZQc9NCJV4phPgRhxZppA7XjcFK7ySKnmR1qOXliB?=
 =?us-ascii?Q?ofRvHFp+64J8zsQC1vE4Gv8zJcBEMiXLsSYZ5+Boq2F2mdzaPW359OMznxKr?=
 =?us-ascii?Q?DDJeNSVxo1c10eBpkJoGP+ePRvp3Gj6ycVR5m2DfgwoVnYmhSNf0U49S2Cf/?=
 =?us-ascii?Q?o0r4fub+RPZh05jYTN9Pty87HkV39JiSUh68cKF8wrBQK0MMKqmnio/R9JxB?=
 =?us-ascii?Q?faKcYisW8e7AruK9PzZrFmdtlW1g95iK2UIFCINDw5crrm7sJqBpdton31UG?=
 =?us-ascii?Q?Quk0oBU9s+jYFxYoNP+IJhYi6kpsl4gMaxuDCz1f+rL1t7HIIkRgpbsyn2op?=
 =?us-ascii?Q?6xRemihfJcYYDfelzLx029+PvyujZZ4m4OVk/+Trzj9QFw8NX7gu4XfBN2bF?=
 =?us-ascii?Q?ilMMbxolOYLysqJkRYy0YSb3oCz1d9n2UGe0pi0dxt9mmVAe7ih+5QLadhj0?=
 =?us-ascii?Q?DQhEzQYX4eVkEtyU21ne2c5LAQLBIcUuUFs0SHk7+6hCGvfDQueYST0UwQTm?=
 =?us-ascii?Q?md+kSk/MFjNRQRp47G3KzJtxPSZT2HNBHWGyAojCDPyri1+IWg3ou7kpoBP/?=
 =?us-ascii?Q?XSxZLQII3nyaXxcxqKolylGQs3r9IWzOgHOvtz8TiSE3H+fN6w2rFyTYaHA2?=
 =?us-ascii?Q?MvrxKbkFkccbcqJHib6onB+/iScxvjWvU2X62kRkgGtXQWULjpOUgk8aSmOw?=
 =?us-ascii?Q?7qxAzd74YXUrw02mBfj3ewGz5zdoDay8KO/U+XZOlRH1MCWwhk1QaT+PAK2B?=
 =?us-ascii?Q?HZnUZE6zuyzjiywGkZweX8ViIMFBWsn+IMQdFuGykZeOIvHl4Nm3PZmVtS4F?=
 =?us-ascii?Q?Pf/xqKI6W2BqeC9XF3hwyuUqtqvMsA9puTuyiywf8diWqLD8xkjxLb+jx6Gu?=
 =?us-ascii?Q?ER8J0viGfFTrMJ3T1csiQLo5WQLZjCmGnHgCKeSR9KJKKqfSpeBYcGeHFx8i?=
 =?us-ascii?Q?8RG6RjVaNgdl+irWn55NtA1X2DDovGqU79U+m3pcYyAazg5LWE+vBi9C96V/?=
 =?us-ascii?Q?qWyTS3NonkCcA5xLHp2pCwtupdlHsHkKLsDd5kfbsTPH20ollM4h7+tRsVze?=
 =?us-ascii?Q?QtoRJu1PixmbiAY4Ke/iy0a12wDB4VDf7y/wR7H2ePFMvvBZv8KN8SNVpBmN?=
 =?us-ascii?Q?Z90c496uJdIvp8+c7z6jDvLsEXu1JmNRgP0EuV3VjLPHaxam/EGR2G/1O/lW?=
 =?us-ascii?Q?r6WP/InWoMn56AUsHCdiRJKBMLVYzeMz3dkBjuXg7j6vaEfRXSN2UJUxSp34?=
 =?us-ascii?Q?6X7Vm3NmFx5l6oVr5r4qDsSRP+SCbLY+BgiHoz1DapwZjtPfdlVa8VGdVB15?=
 =?us-ascii?Q?uCqm8mueE6jtXLSFRvOS3JvgRcNQTkj3wHF9wA+fkIV4uZBz+TAo2QQHQiM9?=
 =?us-ascii?Q?RBnNd/AeNrIBTpDTXUdeQe9CdGa8gY4DnGrIBCDBxbcTNJK6n7yQEabDvGY5?=
 =?us-ascii?Q?HLb8Oayc1A7OPf6Ae+1Do1/Z62JKGo9voaGo8baGkHQI9gUdm8Sk7nvof13z?=
 =?us-ascii?Q?Pad2v45yKhI329Qs1njJI7JoW19MeR66wjpnqCj6?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e317a14-a2fa-4355-14ae-08db96976210
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 16:08:33.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5MBn7Obh85So8ekn4QXNozpUy3WX2BtCvkW+KURJGrh+6gXJcnMQx/T5c7G4n7BBjtp5z7afF2KRHWcmAdpGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 09:10:19 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> `UnsafeCell<T>` and `T` have the same layout so if `T` is `Zeroable`
> then so should `UnsafeCell<T>` be. This allows using the derive macro
> for `Zeroable` on types that contain an `UnsafeCell<T>`.
> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a valid
> bit pattern for that type.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> v2 -> v3:
> - also implement Zeroable for `UnsafeCell<T>` when `T: Zeroable`,
> - use `impl_zeroable!` instead of `derive(Zeroable)`.
> 
>  rust/kernel/init.rs | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index af96d4acc26b..06ecab4901f2 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -212,10 +212,12 @@
>  use crate::{
>      error::{self, Error},
>      sync::UniqueArc,
> +    types::Opaque,
>  };
>  use alloc::boxed::Box;
>  use core::{
>      alloc::AllocError,
> +    cell::UnsafeCell,
>      convert::Infallible,
>      marker::PhantomData,
>      mem::MaybeUninit,
> @@ -1157,6 +1159,11 @@ macro_rules! impl_zeroable {
>  
>      // SAFETY: Type is allowed to take any value, including all zeros.
>      {<T>} MaybeUninit<T>,
> +    // SAFETY: Type is allowed to take any value, including all zeros.
> +    {<T>} Opaque<T>,
> +
> +    // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
> +    {<T: ?Sized + Zeroable>} UnsafeCell<T>,
>  
>      // SAFETY: All zeros is equivalent to `None` (option layout optimization guarantee).
>      Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZeroU64>,

