Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776F57A82F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbjITNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjITNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:09:55 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0C91;
        Wed, 20 Sep 2023 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695215383; x=1695474583;
        bh=1/ognkvnJyYWtYywfOcPV37GXLJ6vuPInK4WDRo+5cQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=g9YP8RcvSUzdbzIMTu7NXlEkDhPHnWKAh6KqYDOT0+aY9dMWJyWKFZxzS28rByVzn
         Rpq4R81pkARUKO23467PQsoyM1rt0PsR1p62kiusv9S5zPvrp8RuQk363gxG4MLeYU
         UihMLa5jtT3XAJ2eC5H+OzFwUlI+Ei/1lyn75LJVzfk0vW6ifuZL5cmyU3xcH4UC62
         yAhcOV6U3MV7+mHh93jzSlFulKKWHZCnotN6LHixIKQzGHcehFbCh9vYQAGKXCE0QA
         QBy4FNTpkaWO8xIk/vIEv55K4ii+D6oUdj20lovjiE2MpnJ2JloOIpPSY5D7wVN/YG
         SVKajWspgW1hQ==
Date:   Wed, 20 Sep 2023 13:09:36 +0000
To:     Manmohan Shukla <manmshuk@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: error: Markdown style nit
Message-ID: <79a526ee-9773-13ad-d36c-4ee1072b115d@proton.me>
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
References: <20230906204857.85619-1-manmshuk@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.23 22:48, Manmohan Shukla wrote:
> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
>=20
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
> ---
>   rust/kernel/error.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..6233021daa8a 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -133,7 +133,7 @@ pub fn to_errno(self) -> core::ffi::c_int {
>       /// Returns the error encoded as a pointer.
>       #[allow(dead_code)]
>       pub(crate) fn to_ptr<T>(self) -> *mut T {
> -        // SAFETY: self.0 is a valid error due to its invariant.
> +        // SAFETY: `self.0` is a valid error due to its invariant.
>           unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>       }
>=20
> --
> 2.34.1

Reviewed-by: Benno Lossin <benno.lossin@proton.me>


