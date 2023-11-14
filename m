Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E37EAA16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjKNF1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNF1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:27:32 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5FD94;
        Mon, 13 Nov 2023 21:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699939644;
        bh=KqMsgNgO17ZacvxiaVZedETTEZKyqTW9lX2Nm4HZj9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PAnHpdm74uSR4yGDJCrZA29fsP/CQxj2/zNqrnA2gOC+opmgyowwGVVbDuJABEjs7
         kT0IDwmr/nVre1U8m5KjxTqQpHWKQy2DLEPA8y5Z1ITpcVKv2TRbXhBFPWlaDkdxtS
         1SiYou95nxfp8gqYz4MCOvNscl6fzROBoiE6SqJ3W4I2iV8aty/dCt14eITrln4pgG
         FuoTGmAVBhgidKz2stewxyzWcK1BxOKBcBwyFOD+EuxkxAoXxI2cfO61/q7tTzvnuN
         fmoScJmlCqy1jYvXwtux7HW/zjQhkBBlpHt4RzQXF1cQa0h0g0lLvlf62l4AQsA1Q9
         NKsslgfpmobZA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STvv01Rz1z4wd1;
        Tue, 14 Nov 2023 16:27:23 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 16:27:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 6.7-rc1)
Message-ID: <20231114162723.5b214e12@canb.auug.org.au>
In-Reply-To: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
References: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aOCZ72E+gONMnuP3gBC2y4=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aOCZ72E+gONMnuP3gBC2y4=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20231030 was the first linux-next after
the merge window opened.)

Commits in v6.7-rc1 (relative to v6.6):            15418
Commits in next-20231030:                          14883
Commits with the same SHA1:                        14247
Commits with the same patch_id:                      287 (1)
Commits with the same subject line:                   12 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20231030:     14546 94%

Some breakdown of the list of extra commits (relative to next-20231030)
in -rc1:

Top ten first word of commit summary:

    197 drm
     67 bcachefs
     54 pinctrl
     49 riscv
     40 xfs
     28 fbdev
     24 net
     17 s390
     14 ceph
     14 asoc

Top ten authors:

     70 bartosz.golaszewski@linaro.org
     64 kent.overstreet@linux.dev
     44 bskeggs@redhat.com
     39 geert+renesas@glider.be
     31 djwong@kernel.org
     28 u.kleine-koenig@pengutronix.de
     14 masahiroy@kernel.org
     12 sprasad@microsoft.com
     12 rostedt@goodmis.org
     12 cleger@rivosinc.com

Top ten commiters:

    107 alexander.deucher@amd.com
     70 kent.overstreet@linux.dev
     70 bartosz.golaszewski@linaro.org
     60 palmer@rivosinc.com
     49 airlied@redhat.com
     41 geert+renesas@glider.be
     37 djwong@kernel.org
     31 deller@gmx.de
     27 stfrench@microsoft.com
     23 kuba@kernel.org

There are also 337 commits in next-20231030 that didn't make it into
v6.7-rc1.

Top ten first word of commit summary:

     57 arm64
     47 drm
     46 kvm
     14 x86
     14 mm
     12 arm
     10 iio
     10 coresight-tpdm
      9 soc
      9 lsm

Top ten authors:

     25 jouni.hogander@intel.com
     23 seanjc@google.com
     13 ubizjak@gmail.com
     13 quic_taozha@quicinc.com
     11 casey@schaufler-ca.com
      9 stephan@gerhold.net
      9 binbin.wu@linux.intel.com
      8 leitao@debian.org
      8 chao.p.peng@linux.intel.com
      7 arnd@arndb.de

Top ten commiters:

     60 andersson@kernel.org
     47 seanjc@google.com
     29 suzuki.poulose@arm.com
     25 jouni.hogander@intel.com
     19 akpm@linux-foundation.org
     14 jonathan.cameron@huawei.com
     13 paul@paul-moore.com
     13 mingo@kernel.org
      8 paulmck@kernel.org
      8 michal.simek@amd.com

--=20
Cheers,
Stephen Rothwell

--Sig_/aOCZ72E+gONMnuP3gBC2y4=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVTBTsACgkQAVBC80lX
0GzazAf9GVnHWQKsim1xZ5ODQWwAHjHVwv/jkooWJEX7XPVpaFpKlEXBo6Ab4vs4
3+2DBiwrYMccZ/wKlV6cuWS7+KK8pKqudT6DCaRWLJo653gqQqWQpZES+xBgAMvZ
yb0FvBwSmUx5GoCCERlb2AudhzWANuX86sKKAMzNu8HILGGSbPv6ko6qPAy7Syci
/4A2f6KSYWZSqzjTa/Fwrzsh2r4Q72COIjE5cmaadEzmT2cxMtfCiaL5MDHzG/pn
TOSR8cZHk1LmnpCzwmsVW/sLhQplG6mPey90AxFwd+QMJl592CYZx4b/XwY/gQRe
k78JgPWDtVAG6/x7rLv7tYKWdMKloA==
=aC8e
-----END PGP SIGNATURE-----

--Sig_/aOCZ72E+gONMnuP3gBC2y4=--
