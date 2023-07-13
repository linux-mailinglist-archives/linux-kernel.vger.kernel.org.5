Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A6C752D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjGMWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjGMWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:43:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D10A271C;
        Thu, 13 Jul 2023 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689288216;
        bh=YKPzlX2R8COAP5RMUzg5J3q6eRSaE2mc3OEvn7rvUCA=;
        h=Date:From:To:Cc:Subject:From;
        b=PBJLRIkF14YM+I9b4OYBQEBlwG0+zKWhJRCJaJ5N7+CzXBSLRMsg5N2ulGTIwwpmc
         fiAKw8s4PZY71hQ626fBBMmWAYiHK/09txc+QS0bZxbHycAOLvRlgaF8tnd8mQGknw
         tR2weKXPgwGqakFGFveambM/LYQW1v2ts29vO677DkQsjQ8Huceqgji6+9bkkLBhuq
         rtwukV89d1x9uZPMiOox5rLsyKnmc5uZzBcD2SO+nvIElGz/+JYXLIqOZXv6+cVZM1
         NlZHCgSMAwSwaFLe8ibIpjxqOO0lYtnu6JgHIiSiyieIVChSfvia2wmu8K99PjTGsD
         TG3aW2YiFQZEA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R28lr3tCxz4wqX;
        Fri, 14 Jul 2023 08:43:36 +1000 (AEST)
Date:   Fri, 14 Jul 2023 08:43:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the ext4 tree
Message-ID: <20230714084334.23413801@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F=foJ6nyxGPbLcbBWhhZnQL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F=foJ6nyxGPbLcbBWhhZnQL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  7c79210b15ef ("ext4: fix off by one issue in ext4_mb_choose_next_group_be=
st_avail()")

Fixes tag

  Fixes: 331122aa930 ("ext4: Add allocation criteria 1.5 (CR1_5)")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/F=foJ6nyxGPbLcbBWhhZnQL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSwfhYACgkQAVBC80lX
0GyQhgf/QZ3DBK6l3cdQxuOt9Nvo7uPGC9G+eVAAj3BPsL6fEwPBAhDr4jH3hKjy
V79jizut1rXENPI31PH85WKI5eGH0yTdf+XNJmsxUqOWeVsaMiSWqqfWR7BW5Q0Q
7TiEx3numSLEq6rS5+FKo+sNgvHsj8LI8pIAOHZffGfr8Atl8uYRfIJwSbN/QyPV
jOu6vsQM7F6Oe5lV/fWGJ+9E8bBg0O5iAKXiR3tD48PJtS4+YXOfTEl8c68/QFxK
U1iuJJEiSLTaiDfYyFMOparDJjVWbCO7W94mHytPOJ0sgl8ReYSS/dlfKZeVmTuf
SaIkULe0HUo/3Q71Ow8OTEujOjo0ww==
=rs4/
-----END PGP SIGNATURE-----

--Sig_/F=foJ6nyxGPbLcbBWhhZnQL--
