Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81579D0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjILMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjILMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:20:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53210D7;
        Tue, 12 Sep 2023 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694521208;
        bh=NoGm9c3v+U8wsl8P9h6xAQFKKJWLtJxj8xuOOdJ2Dtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XUszmvfUB8C8kXg60197lrP2yNoT1Ln2kB1nmcM0a2sy9l8JZHJX1za41dWrOwpUw
         sVl3CFwdls4z+3MnnATzDpmdl3X/8lJVxBfyGZVbrUXtkkVTiumezHbynxeumORv5C
         Q0Dhi2EMZ0CHyzdOnQs+Sz3all4feSEVS1ax12CHT5ay/7ClNSbh94BJwxQEFIkHyX
         Ql+VcWU2yo6B8dPxS3sWF9iW5AtvM+YmpfzbNoFyq6hEYdeaOsj+VWmF5sLh+6Hg7W
         V0xjgWtAqY7R0hss3fJrGe6zfuO6M2xgeVv/ic+KTa+YBHFxzUA0gggAJvKbSDjydy
         hFHSSUN8aIQWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlN2J4WMxz4wxn;
        Tue, 12 Sep 2023 22:20:08 +1000 (AEST)
Date:   Tue, 12 Sep 2023 22:20:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the btrfs tree
Message-ID: <20230912222006.5a7cab3d@canb.auug.org.au>
In-Reply-To: <20230912112011.GB20408@suse.cz>
References: <20230912104646.3a9140f7@canb.auug.org.au>
        <20230912112011.GB20408@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=g9AZZNSacE3e09z/GKJU_4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=g9AZZNSacE3e09z/GKJU_4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 12 Sep 2023 13:20:11 +0200 David Sterba <dsterba@suse.cz> wrote:
>=20
> I tried 12 and 13, no warnings on x86_64, however the report is on
> powerpc. If this is on a big endian host it could be a valid warning, we
> have an optmization where the on-disk format endianity matches CPU
> (little endian) then the structures btrfs_disk_key and btrfs_key are
> equivalent and no coversion is needed.
>=20
> There were some changes that might be related and newly added to
> for-next so we don't have any other reference point, I'll take a look.

This is indeed a big endian build (big endian cross build on a little
endian host).  I also did *not* get these warnings on my x86_64 build.

--=20
Cheers,
Stephen Rothwell

--Sig_/=g9AZZNSacE3e09z/GKJU_4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUAV3YACgkQAVBC80lX
0GxLkwf7BzxZyn431bY5mQGxunM4EMftPDuWAIHsSPBtelxG+Hb7tAzWJbleqDso
VkErXNY1ACTbZVk457EyK5uVKkGBRAbLXp0X8x72iBEJOfASEzf9LDy+o+eYtAmM
R86CNqkFyrUEMBz9UMcsSE7/LU668p1ny0tOtxo31qqWf7EcdemrLWrU/n4z+2TH
tQGhA5ZjrVl5CG2ISdq36ZFlvhMxr5lE5HomZC/McCAgZ9vSU+sb3gNdXVRTPbAM
W6Uat44TjWe+vbs48fDACI29tjg1E8YSeeBmHWrhAE6TOg1l8Bv5GN35ePPcFE4g
bA9vK6/2YTll8cCXPnM50KtPR0WzWA==
=ziop
-----END PGP SIGNATURE-----

--Sig_/=g9AZZNSacE3e09z/GKJU_4--
