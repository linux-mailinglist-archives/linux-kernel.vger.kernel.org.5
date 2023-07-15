Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7F75495F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGOOfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:35:15 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2135.outbound.protection.outlook.com [40.107.10.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA2530D8;
        Sat, 15 Jul 2023 07:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7iM0mlmyfYI1s9XvQgWQOwDoaor3edQcgW9nAppX5oP9BEGslsxNvGwthv6fznBi9IdTMhzKjMKBaOx2qlqpE3+ol8QVcNmUnhGPmIE45mVs71gjQmUuk8MPhMa1l5BHmfdj9pQP1MHngcPx2+ccVFwc4DtKC/zrtm7K1TvhQFycgkg6rb659sjCTWuU3h+UWs1tJhbqK9xqwWml2uY70WDwoipr7Vq0sFxr4MfZtzMu09N3uq2R6n1gqBjGVo7BgdqamR+cMS6cCXufn0JzRqZB042JCUHu0RA0MK2MOF+JWN4KbMlvkmbkNM2xq5SLhP1fUIc4C0BZZUs59bfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/YU58dVboyHe/jGXIbLrQut4hMLj8oZ6yTH3zIOtXw=;
 b=I2sTVLGlHDesuDQs72mNoz/1qfTapoW7pLvZPEzf8HyK/20L/czlar2ie0tWotxxJqnuLUqQHCYg+QMgIRX442SFyfOlp9rDDIb+ql9RXpBgAS6p/iXS+qWal6MHrx0gLIzFSKReUywQ7nGwhKrIrOTgmsiWj65h3NuARauNR5wdWnGxjDmttdVovE42AWkPDcGQHzGYtnyID1cXDcgsJB+u2OgBBlfFM/zxxznrr7FlQZjq+5e2fqCuyC1aWfGEzyg4NnZ0s1E95rKHjXoK9zaiTac4Odq1lT2rQQDpVz8PEw5kzhpUGp6s2ySLuI/ZgkxBunfXrlX5+PydvOdE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/YU58dVboyHe/jGXIbLrQut4hMLj8oZ6yTH3zIOtXw=;
 b=UBPi3rC7EUYZQvju5VBpLVtYE+8VghpvXlc6cT0aE+ZfVfLt5mDRGPNRvYHrrVBt9WXPSjcwaHEp6lUtYjH8GgxLMJMEgxpqC1GWaDUoAP72KQK3cVy38ihdD6QE6JjZNrKc0dbm0qd//MG6M2WiUNewLOO6DShMAEgnLe8jhl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO0P265MB5842.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 14:35:11 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::25e2:a08b:cd9c:c3c9%3]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 14:35:11 +0000
Date:   Sat, 15 Jul 2023 15:35:09 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH RFC 03/11] rust: Use absolute paths to build Rust
 objects
Message-ID: <20230715153509.64a7ac38.gary@garyguo.net>
In-Reply-To: <20230714-classless_lockdep-v1-3-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
        <20230714-classless_lockdep-v1-3-229b9671ce31@asahilina.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO0P265MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: f53e94cc-63fe-4d0a-8343-08db8540b1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTJZDqSaN9yX2sU6PXHA8BqywBBp0YoPZq0Re6GpUS1AJAAAQy++UYrkVwkUMhT3IeP2tO8Hi7XG+2jZRbQBHt6W/b/Qt+AKhDAbPk4IivnNMLXx5Su0pPQB2g7leHwpCnFK7AvrZHqb/m7fYcoTkUI+zkGPt59pGbC9jyQkLVW/HaWvhpfL77jVHvPh19x6TQAFeYtsGouu/jwSa3h+QEzIJ+D8CfLRBGUxiawaTYc7kmo9K0R84zmnEI6ifJ4ONrzHjKuduj0Ka1DiA0Ts4Ah23GBp2QVWwS2gGYZXReZXGIdGNUrZvOw6Egr7KtfhO4znDrzgJgFm751vny0hITR5oZadrvRkHlCy5VP3VlvmxJcejslRhmk4SBzGg+VbOELUBVUQeYbC0Bq9268iQ6N69g5GXjZ3H38haMrHhwIULjjKncUeJDE3TGbdayxJMQ1CbAJZgLScXg6hbEdvZdBeRszAfZQCZ0Z8y9ywRZh85JigHOySpNugkznfDWx9Mbc0YHkao2TKHAIuwmpQe/vPJp/SigAvwR1lwAOomn/jmkB3Rn2nnSRw/WLRFBmM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(39830400003)(346002)(451199021)(26005)(6506007)(38100700002)(1076003)(54906003)(478600001)(7416002)(5660300002)(8676002)(8936002)(4326008)(66946007)(66476007)(6916009)(66556008)(6486002)(6512007)(86362001)(41300700001)(316002)(2616005)(186003)(36756003)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+NJB46rFLuZ/TPxksnVNgs1DL6DXOCKdc5XrxNFjmdSL+LWgZlZdpYFSDEg?=
 =?us-ascii?Q?7C/BOGo8hSzkTXMeCptunTDH9AZgUB2w7mk0cDHkwkW9x3ip9h+vWBWEBuzd?=
 =?us-ascii?Q?fzr2P5o0b8A7IZZARPzHs3OoitWeQtJo/da0nfZDjmBXP4Pa8T2F6wFkFXq0?=
 =?us-ascii?Q?pEDgWDnftJZfX6UdxdFM+Xl9qR239PZ9P3vgdgGyEeFlA1Th359whiZo5Yf5?=
 =?us-ascii?Q?mENJZkLiZPi/3tBaRs7rYykbHl6Ar5EVb27HOm8sQ35O8mPceMThOgFBiNmB?=
 =?us-ascii?Q?XUr2ssfbBlYr+TsXJFY/gfUubweLAr/fVpZnA7J3Q2v2DbZ7hPQ8XJR8TqX+?=
 =?us-ascii?Q?eqYO5nD2/zlAE18uAdkX89DzIoMbW5dzwIBB9C/rqaHLk++m3GkjXLlTaPVD?=
 =?us-ascii?Q?aTSdvs8pFQxL6GTP+tThbnKK2EetLZ29hxqhxD4keHunVsbBTITbjj+e29jE?=
 =?us-ascii?Q?593vdgmyMvE+bQAExgFzek4gITMiDLFXw4JlXWtKuDpbUf9PGW8JNXE1KZz3?=
 =?us-ascii?Q?wkKJYxNwNl9PEV02MPjhgQ6ygxeDshKTNLyXreSmUE/JLokQGuEmtN4gjyOi?=
 =?us-ascii?Q?YVheH7dGcnmgT0Qg7QTGckyy1Qxug0SvhCBMyZt1Or5bN8wx2oYmsoh/W+FM?=
 =?us-ascii?Q?Q+TMq6JWk1Bm/YtNYNlzR10qLdYmooOjREUrnDmddxthYMngr8Iqjl2K5bIw?=
 =?us-ascii?Q?/nFL9yct/qrRQKdDcpnGdrIEmzbD6ZcW9mHxm+qFhCtisOSBVllwT57bjcQx?=
 =?us-ascii?Q?Ab4ccdugXcKrmz9uJsdpZ9VaaDqsWEsctHNmA157Ycw4V245Na05oWGKTHzZ?=
 =?us-ascii?Q?jZKVQ8C5LZsFN+wXni5ylVKrobj0K5smmEWHsquLFUDF1dxPsHC+qV8fq/AN?=
 =?us-ascii?Q?8t4D1HPWJFNKEC6UcjFXQcs9E9zfJYdvwqusK+qKpcOBX1DX9ixCT+v/VNy6?=
 =?us-ascii?Q?vTiDKE1wpjJhzYCxOCmxpynr9cTdjs2TegiDdRKXpIHvCzNePnmwter5QIBE?=
 =?us-ascii?Q?If0eFWjB9xOdhyIAf23fEFPC5+pwynbr8WaC3FiaeXh4T914Dqa5VYbBll7J?=
 =?us-ascii?Q?kTpfsvZlvqn18V4F3cFSWaxxWaOoANfi/L5bxQxCJG9c1iMfdtj+TbYnshIr?=
 =?us-ascii?Q?bqUGpR25AWgJx6T0L67EsKUSVKjaqY0FUCrgQOYIT/Xx1sCxdWhDajJqkX+x?=
 =?us-ascii?Q?sPJAIkrgPiFvTeO0TXr/ywDz7r6OjaBw51rJ67HgQ9E+XOk6PV5PzE9YhbMF?=
 =?us-ascii?Q?cuSNiLa35kfWRZjdJvh9F+HsPojsvsXhDXuSSoD7zp1f6OHZSsGariGVTi5g?=
 =?us-ascii?Q?JjogQL8OR5WKUQSrGiboiQ+4YxGSk6/xsHbYU0N8mxguNG6kxPA4tt5h6bHa?=
 =?us-ascii?Q?qf1yU8Bpw8igCWYZIEdEmrej8ht3ZpeiaqHdKu9wgju8v0bgtD48vg9nM+Od?=
 =?us-ascii?Q?C0ujE04LtBv+clHI3i98289CUXEtyoiHaG/61GOxtGiDPVO38gIc4QgpVZ3V?=
 =?us-ascii?Q?a0a8/PXpC1lMxYE9Gt04bDcs087yeNArS+PznA7GQHF3q6JWad2X6WWKIK1L?=
 =?us-ascii?Q?EbczJNB9BW2el+pWje5eRHuI2LsQZYr1wKyf58Nj?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f53e94cc-63fe-4d0a-8343-08db8540b1e4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 14:35:11.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y01ISNgsZ2JbwHNKsu7OEflRkBejkGY2FXy12/xDwpz1Dnj2fOWiz3QiZlTWixeEWSqYkZLyrQRiiFrEF4EWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 18:13:55 +0900
Asahi Lina <lina@asahilina.net> wrote:

> We want to use caller_location to uniquely identify callsites, to
> automatically create lockdep classes without macros. The location
> filename in local code uses the relative path passed to the compiler,
> but if that code is generic and instantiated from another crate, the
> path becomes absolute.
> 
> To make this work and keep the paths consistent, always pass an absolute
> path to the compiler. Then the Location path is always identical
> regardless of how the code is being compiled.

I wonder if this can have some reproducible build implications. We
probably also need to use remap-path-prefix?

> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/Makefile          | 2 +-
>  scripts/Makefile.build | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 7c9d9f11aec5..552f023099c8 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -369,7 +369,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
>  		--emit=dep-info=$(depfile) --emit=obj=$@ \
>  		--emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \
>  		--crate-type rlib -L$(objtree)/$(obj) \
> -		--crate-name $(patsubst %.o,%,$(notdir $@)) $< \
> +		--crate-name $(patsubst %.o,%,$(notdir $@)) $(abspath $<) \
>  	$(if $(rustc_objcopy),;$(OBJCOPY) $(rustc_objcopy) $@)
>  
>  rust-analyzer:
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6413342a03f4..c925b90ebd80 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -283,27 +283,27 @@ rust_common_cmd = \
>  # would not match each other.
>  
>  quiet_cmd_rustc_o_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $<
> +      cmd_rustc_o_rs = $(rust_common_cmd) --emit=obj=$@ $(abspath $<)
>  
>  $(obj)/%.o: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_o_rs)
>  
>  quiet_cmd_rustc_rsi_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
>        cmd_rustc_rsi_rs = \
> -	$(rust_common_cmd) -Zunpretty=expanded $< >$@; \
> +	$(rust_common_cmd) -Zunpretty=expanded $(abspath $<) >$@; \
>  	command -v $(RUSTFMT) >/dev/null && $(RUSTFMT) $@
>  
>  $(obj)/%.rsi: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_rsi_rs)
>  
>  quiet_cmd_rustc_s_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $<
> +      cmd_rustc_s_rs = $(rust_common_cmd) --emit=asm=$@ $(abspath $<)
>  
>  $(obj)/%.s: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_s_rs)
>  
>  quiet_cmd_rustc_ll_rs = $(RUSTC_OR_CLIPPY_QUIET) $(quiet_modtag) $@
> -      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $<
> +      cmd_rustc_ll_rs = $(rust_common_cmd) --emit=llvm-ir=$@ $(abspath $<)
>  
>  $(obj)/%.ll: $(src)/%.rs FORCE
>  	$(call if_changed_dep,rustc_ll_rs)
> 

