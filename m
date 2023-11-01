Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE47DDA89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376998AbjKABOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjKABOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:14:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC63F5;
        Tue, 31 Oct 2023 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698801280;
        bh=tGmJG3EnV1bi5eFYNVwQL8EbCbu5u6g5uta9lEO8vqU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z2nULhb9FtJJSHBT6JzBWQuBpoiUfMF6p9PqzHcBou+fut/Gn3Php5czmd+ARqq0f
         e4/8uFZPfcBUJX09IMxngtIMYq+RtSjaVQKjo2k05KVSOlhp9qb8W1aBuUqbT00viT
         j+BbklZgsJn1vZyiUboP6u+uHGKuBm2udHr1UAe080zFbrlxc3ZrUN249gTHGwslWw
         VtRQj78EJzDDTGsrg95fUztLh0mDhEV0xqgk1/cwWBLKrvj+//GFe6Bh2r//UbtScV
         c0qk7w9lnNgZWuQwdzVcPx6+iEaFtPzeb8SsPLIWiYNhGQCgu+4Wiq7YnT1zrgFeKU
         tcNFefIYBL+0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKpvM5MQCz4x1v;
        Wed,  1 Nov 2023 12:14:39 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 12:14:39 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20231101121439.3244f4a4@canb.auug.org.au>
In-Reply-To: <20231101005307.2udx7kqicf3rba3h@moria.home.lan>
References: <20230912120429.7852428f@canb.auug.org.au>
        <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
        <20230913093553.4290421e@canb.auug.org.au>
        <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
        <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
        <20230914083145.17c2e7de@canb.auug.org.au>
        <20231101113222.13e7edc2@canb.auug.org.au>
        <20231101005307.2udx7kqicf3rba3h@moria.home.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7lRzxnOl19usRKr.v2UWEf3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7lRzxnOl19usRKr.v2UWEf3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Tue, 31 Oct 2023 20:53:07 -0400 Kent Overstreet <kent.overstreet@linux.d=
ev> wrote:
>=20
> Is/was there a procedure for me here?

You should have mentioned it in your pull request to Linus (in case he
merged Andrew's tree first (I don't know if you did).  And presumably
Andrew will mention it in his pull request to Linus.

--=20
Cheers,
Stephen Rothwell

--Sig_/7lRzxnOl19usRKr.v2UWEf3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBpn8ACgkQAVBC80lX
0GxovQgApeCpxTizsO7qMX5oqiC73sGzLrwo8IRnhnrw/JrRyHN/vuFK6MyMZfUG
EebtMR4V3N6srzi0iKvIv06Wcrh6Jz/kEJf1faAzPKsvlr0+B1Cdx2Ij2LaGVEuU
ud4DoBEAKp+MyxRJchO4F/4A1X4d79ZWfxsA1YWu/PQp4KauQQlKFkLKvCeYxbg8
iATJedf3Q1jaopqmIt3zeato8jdel7gisywUSBzjy2S2hfkZfdXH6+wx3XsNCb/1
6yGBS63RqulDvT5wayEyVy4F8DEwaUfdNXQSqMPcQedH0hZIYOJaz3csyLgnGwUY
oHPjyCbOeLRJ7rohQ3RwQFTPh66imA==
=Kjn/
-----END PGP SIGNATURE-----

--Sig_/7lRzxnOl19usRKr.v2UWEf3--
