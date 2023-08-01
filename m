Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6200276C14A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHAX6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHAX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:58:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED0170D;
        Tue,  1 Aug 2023 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690934277;
        bh=s2OphzX3FC4hHbn6jvL3dhRLmxSFgBzeN0VfrCfvvLo=;
        h=Date:From:To:Cc:Subject:From;
        b=qOJrB5odAGap9RUuMQ1sX/S9np9MjNYqJpiUMZlZyUbFbKUtxPF97y2DeJyVmuVoc
         rh9oo4hUOvctI6qmdITuLsFkDbMv19ji+hXXFllIi+ZOuIDyZrV0Qoc87TNa905obe
         7fQX3ZfQ6Sfu1UK2Ubh7p3JlK3X3Hmy1J7/3TVqzeJIyGsXtfnxsDa3DA/FMl3eb3H
         vnor+msXLjg9GkP7RZITtSJMV0XRhssstOB6nbZvomvJWyThemKo3xiWE8X21H9GTY
         R8YaS01AX5NIk8g9ObXdSEp7ccWG5JyzT824eylA8XTsdbLPqGbWtq5qqRdcmAZ0x6
         5T62/I2KpaUxw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFsVs2b7Hz4yGD;
        Wed,  2 Aug 2023 09:57:57 +1000 (AEST)
Date:   Wed, 2 Aug 2023 09:57:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the perf tree
Message-ID: <20230802095745.1738fcf7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9td/SOxaKAkSoCy9xHzNbdN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9td/SOxaKAkSoCy9xHzNbdN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the perf tree, today's linux-next build (native perf)
produced this warning:

/bin/sh: 1: Syntax error: redirection unexpected

Maybe introduced by commit

  4d3a5f09fef1 ("tools build: Add 3-component logical version comparators")

i.e. what happens if the make "shell" command uses /bin/sh for the
"version-*"  invocations ... they use "<<<" redirection that is bash
specific.

--=20
Cheers,
Stephen Rothwell

--Sig_/9td/SOxaKAkSoCy9xHzNbdN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTJm/kACgkQAVBC80lX
0GzgzAf/c03jGgZeS1wGP6BLlZ1+rezBl1tGWlGls/huvU25zid/pGbjv2tYFb6b
mOC4zDIajgg2cfku4x67ntnrzLGakd/mUjfHr/Wc7nR1osX5iDlBIGyIrdP3Q44O
axkB+tqMCNsfuBH8X7g80PRFfJ39ncnvJnJMA5nXmTvnyADNsIi45KyUMcnyCE8Q
g/5MS2mXUywOOFQ2CZIFLi4x5IpzwgNasHczqDeCHZYhwAy1Z7svAPsdii+qyjKs
R0HFpE2KWMWNAPCu2a3or3qQ5MY5knlg7XGDqk/2Rc6+yZgmmveGAfPiAa0HRtHz
f99CM3DmZ9cGBCuaKk2xNQ/ovVupSg==
=M8OY
-----END PGP SIGNATURE-----

--Sig_/9td/SOxaKAkSoCy9xHzNbdN--
