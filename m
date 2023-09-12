Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DB79C63B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjILFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjILFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:20:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB0CAA;
        Mon, 11 Sep 2023 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694496031;
        bh=+xkJr+CmA7a/d2m5J6ydfZHXgjiYhoMI8QnLO2rsFJI=;
        h=Date:From:To:Cc:Subject:From;
        b=e/Q1xk07McO5t0AHnB13JZrKi580sHeJJbaHTuS8u9HxTeKxjM2OrXZbFVRNNahfJ
         RyWDgdBchyaM1bXk+CNdGv3VZ+MqyhqQRn07rdkJx3B9blhrf8LLrodhb0A0Qt3lBN
         eRn791bdJrEwQKmh1zPJJtUssYFlXWpiNjJXfJoIfKBzLWgwdXNLgKxrc828qldpMS
         8yrf3vN5jLFLCVg0cCyVqhknlrA0vqvmwCjw+mQgRuwFK3L6Y85wT4dEZSDv+dulxK
         QRARjSSN8VajDQZAHd1LCi5ayEkTM8PqczMR3b3mTczYyKOtDquttJrvdm/ssdobdO
         EcQQjqT7BLexw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlBk72Y1mz4wbP;
        Tue, 12 Sep 2023 15:20:31 +1000 (AEST)
Date:   Tue, 12 Sep 2023 15:20:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230912152030.34e9ac3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8uLy2YzkXHC/794/6JN9_eO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8uLy2YzkXHC/794/6JN9_eO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

kernel/kthread.c:726: warning: Function parameter or member 'k' not describ=
ed in 'kthread_stop_put'

Introduced by commit

  ae89b54018aa ("kthread: add kthread_stop_put")

--=20
Cheers,
Stephen Rothwell

--Sig_/8uLy2YzkXHC/794/6JN9_eO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/9R4ACgkQAVBC80lX
0Gzv5Qf+MdDVcIr9SkAhvcAPQtdcr5dojsYK4Uhdm8D9XnUf7eGBi02shnJJBaUC
fBwZZ56rQLqTGsGEE8W4QAPJT4Il9DBsqu/wxs3/5wMj+NMqketQEpCx5NC0/vmw
iUv9fRxCO8XoUnxwYCIJyl3rNZWBQoJr/raGVbjgFGZEMnGr5+hBxdmHaO/khJiV
kdNBuRsmjIcQTu1LMt3XG7NjGLktZR4HqKLAjhbdmQH+xTrKQudf4o3p7scckCPa
f4qT6Xb/G1c3teGAHnqcJhP8zPOSsLasXDDoFxfyoUIpYPwKeNiQoKN6fH+tTxeQ
aik7ikWtrmaXCkqiOi3VS3mIFPtpHA==
=3J/j
-----END PGP SIGNATURE-----

--Sig_/8uLy2YzkXHC/794/6JN9_eO--
