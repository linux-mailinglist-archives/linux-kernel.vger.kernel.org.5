Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05997DC165
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjJ3UrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJ3Uq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:46:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EBDF;
        Mon, 30 Oct 2023 13:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698698812;
        bh=CpTdll+8XVH6r91t8HW1QM29SCZcmEjYvGOHhG+p4n8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Npu7eACCrxV4K8pPP/N0tTZUxX/RH74VmHBG2sFcmSU44BkNxjEFjs7b5GKSstz9K
         lTJTIa/vatadaGcHkD7EiR+r0fpfUJ/sfusr+hOqd2ydWc6rjMGXFlrYi7DtCE/4Ez
         DBrbSlIWYvNemJKH3WYrQbUL57HZAqLWpUg7Q6TfSxUNYcvRDKrLqHbYwMmM7r/Nrb
         v8+Z4Tgwhw4nmgUlLvELl2E6K7yFGOQP7Gs6nsheqH7RbUyP0kIjNYXKsn14WnXcHO
         8gileDbWPblxDvD0AWILYP/xEtDB04LbpTk9rVKKFx3U3F02g88mQ2kE3Etvu8NJpj
         U6mzfZ8dcBHzA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK50q4hySz4wc6;
        Tue, 31 Oct 2023 07:46:51 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 07:46:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20231031074649.3bdbec45@canb.auug.org.au>
In-Reply-To: <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
References: <20231027130320.69469330@canb.auug.org.au>
        <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
        <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com>
        <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aiy5N31_hmy5w4rYuRJ_1ME";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aiy5N31_hmy5w4rYuRJ_1ME
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, 30 Oct 2023 12:52:50 -0400 Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen <john.johansen@cano=
nical.com> wrote:
> >
> > is part of the Three basic syscalls series, the plan is still to have t=
hat
> > series bake in next for a full cycle? =20
>=20
> Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the LSM
> syscall patches and I expect the vast majority of these conflicts to
> disappear, although I'm sure we'll pick up some new ones with the rest
> of the v6.7-rcX cycle :)

These patches should not be in linux-next until after v6.7-rc1.
--=20
Cheers,
Stephen Rothwell

--Sig_/aiy5N31_hmy5w4rYuRJ_1ME
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAFjkACgkQAVBC80lX
0GyboAf/XupUfVXdKLvYrSCUgrEzBwzYxm90+mL6+/RD/KibOPbvIq0hLzt2rtFf
qukY435IlE0d9qTl0zlf2AjGjTlLcJq99h39PfJdjX7RvePVFbThlnnk1uyQl1rl
jmr5BJrEfB33mBg7v8q2v/dqTC7jXdHSeYbuYMwD9JDTuXY1MKOoYcD4FOw8jyiy
re6d2+6FpNj4rIm7raCAYYja62PkHRudcwpVgXHwVNRwxjSihC2y8b9vtU6MUqsh
ovqArLTSpdHvrFULpphUmRUuKNww/9Qf73OofVLiDZgLBsB3hzFXk8QWsLIM23X/
Km+nVuCW4kZ4tcLeLF88fLO8XWfh8A==
=gVFO
-----END PGP SIGNATURE-----

--Sig_/aiy5N31_hmy5w4rYuRJ_1ME--
