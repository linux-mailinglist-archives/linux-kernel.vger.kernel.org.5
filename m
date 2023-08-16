Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17DE77EB65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbjHPVGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346392AbjHPVGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18C2D40;
        Wed, 16 Aug 2023 14:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACA40616A3;
        Wed, 16 Aug 2023 21:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4825AC433C8;
        Wed, 16 Aug 2023 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692219972;
        bh=Xb7pm0n6yyoEFvbAuLhj1TSpNpGJMc8nq1OibOExQ3k=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=LRzOXaXHofk47tRk55Pt1dSyhmYmpYjoNFQ0rGiCF6CfXYRjvpcTX7guT/OxspwAg
         /rFBK0aOPvu3hZWT4k8w3wNZjkooGbTRt3Xb/jFIzydW7Kp2iXtQ6RcFS4Bm+ChIq4
         lLisSr2pdMK9AL1K3kafp2XkO8vH6iEMpfY4d4AMigVWITmftN9mHlGAnasCVFozUP
         cd491xExoZC07cT7RKMntRQXYfaWCiibLhY8uXpg+VZIazcC+ipceXb4aMd8uIWw4S
         QiWNnMikuNR01S2OURP2mUxmoppM0eVkaBHol5FHbcybdckKiynApD8uwLgLY0JQyn
         TAMbMehHP/oTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Aug 2023 00:06:09 +0300
Message-Id: <CUU9WXZGDDO2.2E7XP03ITLLLY@suppilovahvero>
To:     "Yue Haibing" <yuehaibing@huawei.com>, <dhowells@redhat.com>
Cc:     <keyrings@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] KEYS: Remove unused declarations
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230816131122.43240-1-yuehaibing@huawei.com>
In-Reply-To: <20230816131122.43240-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Aug 16, 2023 at 4:11 PM EEST, Yue Haibing wrote:
> These declarations are never implemented, remove it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/keys/dns_resolver-type.h | 4 ----
>  include/linux/key.h              | 3 ---
>  2 files changed, 7 deletions(-)
>
> diff --git a/include/keys/dns_resolver-type.h b/include/keys/dns_resolver=
-type.h
> index 218ca22fb056..1b89088a2837 100644
> --- a/include/keys/dns_resolver-type.h
> +++ b/include/keys/dns_resolver-type.h
> @@ -12,8 +12,4 @@
> =20
>  extern struct key_type key_type_dns_resolver;
> =20
> -extern int request_dns_resolver_key(const char *description,
> -				    const char *callout_info,
> -				    char **data);
> -
>  #endif /* _KEYS_DNS_RESOLVER_TYPE_H */
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 938d7ecfb495..f16deadebca9 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -436,9 +436,6 @@ extern key_ref_t keyring_search(key_ref_t keyring,
>  				const char *description,
>  				bool recurse);
> =20
> -extern int keyring_add_key(struct key *keyring,
> -			   struct key *key);
> -
>  extern int keyring_restrict(key_ref_t keyring, const char *type,
>  			    const char *restriction);
> =20
> --=20
> 2.34.1

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

David, can you pick this one?

BR, Jarkko
