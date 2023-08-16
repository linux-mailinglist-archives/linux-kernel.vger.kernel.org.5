Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECBE77E274
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjHPNWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbjHPNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4E2D7C;
        Wed, 16 Aug 2023 06:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8B38623F2;
        Wed, 16 Aug 2023 13:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF727C433CC;
        Wed, 16 Aug 2023 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692192072;
        bh=c/AsJKAYiK5cfA/yUi+poAFIxx8uFMOtFJmdzHpvbwo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HtAoShS/lD/Ofpby+Kted1LjwTR0aBZUKkEcBnXJ7JGY3pzWvun/p1qDzQCixu4zX
         mrTd8ALIl/Ocm3RP6QADu3MkEJX6oT5xmTI8fJsrujmC3rr9dGbmrEugnW3edhOm6e
         NLvHUhPmB3eXYjC4ncqIsTcDHyElZPS9DbTOVO4dykm4CB7oBDkrCuMyQOt623cLIz
         URHKIuR9HJkFfLCjCm/MFBVd4EOYO/NMx4r7cFxfQL6E++jHjc3zvelMMoEbVbO6Xf
         UxWSQlhV/1UDy+IObCU5d1NyO4IbCapUP6mA/f5iB5GMnM/mrxH2Oi7v4yun0bUkQy
         3acbAXtuXejVg==
Date:   Wed, 16 Aug 2023 15:21:08 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nils Tonnaett <ntonnatt@ccrma.Stanford.EDU>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: Re: [PATCH v2] HID: apple: Add "Hailuck" to the list of non-apple
 keyboards
In-Reply-To: <20230815201959.17569-1-ntonnatt@ccrma.stanford.edu>
Message-ID: <nycvar.YFH.7.76.2308161521020.14207@cbobk.fhfr.pm>
References: <20230811202932.30413-1-ntonnatt@ccrma.stanford.edu> <20230815201959.17569-1-ntonnatt@ccrma.stanford.edu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2023, Nils Tonnaett wrote:

> Powzan keyboards KB750 and KB770 identify as
> "Hailuck Co.,Ltd USB Keyboard". Adding "Hailuck" to the list
> of non-apple keyboards fixes function keys for these models.
> 
> Signed-off-by: Nils Tonnaett <ntonnatt@ccrma.stanford.edu>
> ---
> V1 -> V2:
> 	- Start commit message subject with HID: apple: instead of hid:
> 	- Comma terminate last member of array
> 
>  drivers/hid/hid-apple.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index d7b932925730..3ca45975c686 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -343,7 +343,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
>  	{ "SONiX USB DEVICE" },
>  	{ "Keychron" },
>  	{ "AONE" },
> -	{ "GANSS" }
> +	{ "GANSS" },
> +	{ "Hailuck" },
>  };

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

