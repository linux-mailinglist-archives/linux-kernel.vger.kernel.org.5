Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B643779B57F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242716AbjIKV2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbjIKNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:25:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA512A;
        Mon, 11 Sep 2023 06:25:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso8328345ad.0;
        Mon, 11 Sep 2023 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694438710; x=1695043510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYHU7Pr5BT6VuKyWwYsKCnfhHtSEOeezKltwZKlqIuc=;
        b=mPsR1l7BC+ezfDzPVIAZIxB74/sJctQAd/5Jzl83wtPC1k2qaJRhAqgZfan96zOB/k
         xO0orfueKBGHJIr3mH2yLpnbJK7BkFDl98tee2UgyqHwed7UPLovO0R3vLICgy7LaCSn
         RG2G1voHutkYR0sbsTwTWka3zzELDEHN0/DcNtN5kcg6DibWium9F8go+CWxlhndoM/l
         ErCSzO9r2A+lwDjdKuTFWhE4KbuK2cmSNLTuvNZ+ZsWDqy7vkSabUrUxsc74K1M808r5
         cMe/XzmsuwgcLHYym+4l1yrS0prjrUhN8G3SpEIxNNr6Y6htVYHUF47l3CC6ZU+Ooh7c
         D9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438710; x=1695043510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYHU7Pr5BT6VuKyWwYsKCnfhHtSEOeezKltwZKlqIuc=;
        b=wxlCzYYa08rNLa+lRefiwsSihlo1RqtnwH7CWm+Hd8oOg6XI8UOWKberGe5qkLLmlD
         G2p0LMycnEhTjdoxDaEJUtjRjzhTnhsf8cMPmu1f1QKVQrBlEfg+FX3lBjcoTTwOmzBc
         XC436+xyDmyzhI2F63rq+ARzrTXr1b2gLGs7lA10ILkxY26vHP+poWQxv0f1/RJ4LLFk
         nd3DiLZFg/EzZ/3LzmyrnmfmAw4hwBf+/JZCi/khYv2HGBy4US73UDqtrD+iw1M8r2qR
         41SxseSLqXGOoeLhvAmAUiO5TLRigk39j7Uwhwd9ip9Ka7Daxc2i+axdmVr6JxkhgEls
         ikGA==
X-Gm-Message-State: AOJu0YwjkbimchyKEsoidykSyZfrio4kXylBPwRPLk6i44PGMAgSjjl+
        nnoDqiddpLyRDNcLKYJ+N/M=
X-Google-Smtp-Source: AGHT+IEJEL7EHKSeeQ7nq+bwwXxX1Oa8Pfic+9143Y1UPQHFbmXr9cdymEVXn43t1L8MasQzFBMDhg==
X-Received: by 2002:a17:902:b18c:b0:1b2:1b22:196 with SMTP id s12-20020a170902b18c00b001b21b220196mr7887196plr.48.1694438709821;
        Mon, 11 Sep 2023 06:25:09 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b001c3c68747a3sm885152plh.260.2023.09.11.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:25:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9B2CF83061A0; Mon, 11 Sep 2023 20:25:03 +0700 (WIB)
Date:   Mon, 11 Sep 2023 20:25:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Hugh Dickins <hughd@google.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RCU <rcu@vger.kernel.org>
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <ZP8VL77rs0Pejgo6@debian.me>
References: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/mcgnXAVZFgB+P+T"
Content-Disposition: inline
In-Reply-To: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/mcgnXAVZFgB+P+T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 03, 2023 at 08:34:44AM +0700, Bagas Sanjaya wrote:
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217864
>=20

As requested by the reporter,

#regzbot dup-of: https://lore.kernel.org/lkml/5011708f-b0ae-2853-0f87-a3b59=
845a2cc@gmail.com/

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--/mcgnXAVZFgB+P+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZP8VKQAKCRD2uYlJVVFO
o+5dAQD3M3npMQfvuZUrqvb2a+tpF6PCUeIXRjjKL6786yTJcwEAuQQTsAsPnR4z
ZgRXKw8JbrZf6fHwI6+q1dMyw6TSlwk=
=Y/X5
-----END PGP SIGNATURE-----

--/mcgnXAVZFgB+P+T--
