Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67F78294C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjHUMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHUMjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:39:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093691;
        Mon, 21 Aug 2023 05:39:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE664634F1;
        Mon, 21 Aug 2023 12:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09506C433CA;
        Mon, 21 Aug 2023 12:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692621578;
        bh=ThGC/sO87bFD4nt487A9IwSHUaAlcl9JdU8fg5K3Fto=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bIurPu1Wn3olYaKOjKCX+lIRmK8mh5l4nMcSMomSkdW8nnFEII2l83oyeprKZGEmK
         csW748HHGT2dwwZAyBH2habc6NdjSzo9wj7isP2HL0bCHR0TUMeAmfN6DXMUu/nDaf
         eunEaslNKPocssSfi7qtnzg4hNU13xeulBJ5A3js8p7FZ+t6fnZufnR6uaE+1dheTV
         UkktQRTNh/bQR/dRVvVZyrxGMubkN45/l8qp6g4t2GW5h3ryqWeO0q8IDhZA8MP6Mh
         W2tf5QKSTdiUZ3BtIwjORd/vf6NCoMyNURRpoZL6GEv3xS8ELnMDGRq80fDt2xQP4c
         pwlLxYjTeKxAQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc:     Wang Ming <machel@vivo.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v3] wifi: ath9k: Remove error checking for
 debugfs_create_dir()
References: <20230726110750.3925-1-machel@vivo.com> <87sf8tbr3a.fsf@toke.dk>
Date:   Mon, 21 Aug 2023 15:39:34 +0300
In-Reply-To: <87sf8tbr3a.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
        "Tue, 08 Aug 2023 15:28:57 +0200")
Message-ID: <87bkf0k1rt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk> writes:

> Wang Ming <machel@vivo.com> writes:
>
>> It is expected that most callers should _ignore_ the errors
>> return by debugfs_create_dir() in ath9k_htc_init_debug().
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
>> ---
>>  drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/ne=
t/wireless/ath/ath9k/htc_drv_debug.c
>> index b3ed65e5c4da..85ad45771b44 100644
>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
>> @@ -491,8 +491,6 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
>>=20=20
>>  	priv->debug.debugfs_phy =3D debugfs_create_dir(KBUILD_MODNAME,
>>  					     priv->hw->wiphy->debugfsdir);
>> -	if (!priv->debug.debugfs_phy)
>> -		return -ENOMEM;
>
> Hmm, so it's true that all the debugfs_create* functions deal correctly
> with the dir pointer being an error pointer, which means that it's
> possible to just ignore the return value of debugfs_create_dir() without
> anything breaking.

The comment in debugfs_create_dir() states:

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dent=
ry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

> However, it also seems kinda pointless to have all those calls if we
> know they're going to fail, so I prefer v1 of this patch that just
> fixed the IS_ERR check. No need to resend, we can just apply v1
> instead...

Because of the comment I'm leaning towards v3.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
