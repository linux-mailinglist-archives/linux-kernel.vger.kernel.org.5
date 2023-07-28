Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C237675E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjG1S4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjG1S4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:56:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E10136;
        Fri, 28 Jul 2023 11:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20A72621D8;
        Fri, 28 Jul 2023 18:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB12C433C7;
        Fri, 28 Jul 2023 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690570559;
        bh=kI1goGCrLoOL8qtgWRb7MFq8HMKUcy/Bz1v8hFNZkbw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=XwEjnXvrwD3Qg6ntVE8VWD+Wn0n0VcXPKPvdK9tVh06Cb4Vmio1wwyLzxcJkKLW8K
         HrHrrihALkuvm/VY6+HVl+7/S3/durGm8XPutadLplRp4Jm+8dhvSnUXa0FSgLYcfl
         CrlJ1ZcFSKNYXIIy6ZiouX/iYLPVtr8TtFwxkjGijwoOFfQIoKJ6dJf0udg2Fqvnxe
         V8LxzD2SHi/LokzKU1WL18DlVbP4/7HuG5hGvJ2av12Mc3NvMYe1EpXPA0RWDVqZqU
         L+9XXHSaKWTeXhkHebUpvv1ehxHIcFJYxd4MQhmbI6Fbv30KT8sVQNEtqWqejwqiue
         p4TLaL67z9Q/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 18:55:56 +0000
Message-Id: <CUE18VURE744.1E29WQ8EU666G@seitikki>
Cc:     <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] keys: Remove unused extern declarations
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "YueHaibing" <yuehaibing@huawei.com>, <dhowells@redhat.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
X-Mailer: aerc 0.14.0
References: <20230724144717.23660-1-yuehaibing@huawei.com>
In-Reply-To: <20230724144717.23660-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 24, 2023 at 2:47 PM UTC, YueHaibing wrote:
> Since commit b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> iterate_over_keyring() is never used, so can be removed.
>
> And commit b5f545c880a2 ("[PATCH] keys: Permit running process to instant=
iate keys")
> left behind keyring_search_instkey().
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Please use the fixes tag properly.

> ---
> v2: Also remove keyring_search_instkey()
> ---
>  security/keys/internal.h | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 3c1e7122076b..471cf36dedc0 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -109,13 +109,6 @@ extern void __key_link_end(struct key *keyring,
>  extern key_ref_t find_key_to_update(key_ref_t keyring_ref,
>  				    const struct keyring_index_key *index_key);
> =20
> -extern struct key *keyring_search_instkey(struct key *keyring,
> -					  key_serial_t target_id);
> -
> -extern int iterate_over_keyring(const struct key *keyring,
> -				int (*func)(const struct key *key, void *data),
> -				void *data);
> -
>  struct keyring_search_context {
>  	struct keyring_index_key index_key;
>  	const struct cred	*cred;
> --=20
> 2.34.1


BR, Jarkko
