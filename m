Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8769D7A3E0D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjIQVuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbjIQVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:50:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32306116;
        Sun, 17 Sep 2023 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694987393;
        bh=7yuAVmeItKypQ31E39DCP3H/7xXXfLhPSfpIFYsqqyM=;
        h=Date:From:To:Cc:Subject:From;
        b=qnrDZbAkdKePbzHvmJ3c/ryBc32dbuofVRnLHWlzQZMJ4xabb1CZUn8ZsNxAGoJ64
         RjnMBbj+UbjzFjcNuPvMhGmzW0sJSTDOfBCIulT2gvGq2tnpqfRlxP6XlB44gm55LL
         VzldNWlKJWp6rCeN7Ejs3jqkFwBnZPTb8ZVK1Xx/bm2khUozz2eyySjVirGfZQGhJ/
         HP3UZQWr3Sqye1psDvZ7FeSLWt/kNmTdfYpksy4NNh9A2YyK6V6Xhnnhvm6rmPOeu5
         wqJLzWpOZ3RPMxABg5Dpfg4tAn+vkx/9z/zwgPwO01nZbFr0VnAfpUbIL9Yj1ubtFG
         AIuB1W/WqfYig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RphRN6fvcz4wb1;
        Mon, 18 Sep 2023 07:49:52 +1000 (AEST)
Date:   Mon, 18 Sep 2023 07:49:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags needs some work in the perf-current tree
Message-ID: <20230918074952.7dbd75ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/79ATgXaTVYLut53jfqNulev";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/79ATgXaTVYLut53jfqNulev
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  927265904c8f ("perf pmu: Ensure all alias variables are initialized")

Fixes tag

  Fixes: 7b723dbb96e8 ("perf pmu: Be lazy about loading event info files

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

In commit

  89f492007445 ("perf jevents metric: Fix type of strcmp_cpuid_str")

Fixes tag

  Fixes: 9d5da30e4ae9 ("perf jevents: Add a new expression builtin

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, please keep
all the commit message tags together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/79ATgXaTVYLut53jfqNulev
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHdIAACgkQAVBC80lX
0GynoQf9ERTtP1w2Cqe/ydLFOEIjobFwcng+czDqn7078JSOILRRj9A5lEwbpVJ8
87hPmRkapgnMZV28ZjIvkDUc/18jyXIdbjhE0daatVg4Q+HTemdn19Tj0dJ7GTV7
Hbrtlt2d5UUMTTpIgbxmJgHFop3TcvERTBF9+h6DGL3SV8Qh5BGM0WMQg+VI/ogb
E1Bjdo/lyOJfEkP6oOJY+obRB3eGZwiq4Fk5gD0WnnLAONEbnn09+w3XH/N9swRa
1McHEGMzBgabPDyjqiY0npvDaCFg1P2ktkhfHCiITs9UZsiEyGxLpJbHFLr4EzEr
QlYk1x98ZyFtSHOOYYb64zAHzS4cNA==
=SDhg
-----END PGP SIGNATURE-----

--Sig_/79ATgXaTVYLut53jfqNulev--
