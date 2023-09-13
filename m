Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F22579F4D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjIMWTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjIMWTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:19:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9E919A0;
        Wed, 13 Sep 2023 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694643554;
        bh=zLywpBXGPVjbMPp/0mEgBcEgMQCavtFgVgs4YNmeboQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kxzJhbH1+28KFnuIyD0+hA0t5IgqfMR06PjSVd7E3LfFAnNu1EkaktoyihADutvG4
         uOuXO0xDpd1GHYOTuyn0djgunqNDUiK8rlL+7xqghDxV7rWkko5VKINEJtkTMcNaNI
         84yY3mrOnek7UV643Dy9BZ7OnT3o2twYuXbOi9jpFVH3Or4dXloUmPCQ0CJo9fhuMW
         FK3+LvJP2pVa94TGOKyszXptJ3KAgwQfTYgVelWFOfiUfjeMqny7H3iRSQAxuNvtLL
         OM//u3h/FKqrceui/SNciBouBnD6Rlk+iVo8ZOPPaWbFmVxfvUDMpkdVbXLfqd9+V1
         0iBiw16UjCprg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmFH55Zglz4wxl;
        Thu, 14 Sep 2023 08:19:13 +1000 (AEST)
Date:   Thu, 14 Sep 2023 08:19:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: linux-next: boot warning from the bpf-next tree
Message-ID: <20230914081912.33b30cc8@canb.auug.org.au>
In-Reply-To: <64f1f578-17e7-a8a8-12f2-6a1a0d98a4af@huaweicloud.com>
References: <20230913133436.0eeec4cb@canb.auug.org.au>
        <20230913145919.6060ae61@canb.auug.org.au>
        <64f1f578-17e7-a8a8-12f2-6a1a0d98a4af@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/orKwvZW7.iPNQ9_UONq7tER";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/orKwvZW7.iPNQ9_UONq7tER
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Hou,

On Wed, 13 Sep 2023 15:56:04 +0800 Hou Tao <houtao@huaweicloud.com> wrote:
>
> Yes. The warning is due to the checking added in commit c93047255202
> ("bpf: Ensure unit_size is matched with slab cache object size").
> Considering that bpf-next has not merged the patch-set yet, should I
> post a patch to bpf tree to fix it ? A fix patch is attached which can
> fix the warning in my local setup.

I will apply your patch as a merge resolution for the bpf-next tree
merge until something better is done.   Please make sure to let me know
if it is not longer needed (in case it is not obvious).
--=20
Cheers,
Stephen Rothwell

--Sig_/orKwvZW7.iPNQ9_UONq7tER
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCNWAACgkQAVBC80lX
0GwuOQf+KWBTqY7eObPbFTZBSZSSIanAEyD/PV0bdtfB9zxa74+OE5mutDSDTYEv
6Pf72Z1PNxdZzhOdufqE/XVx7rXfy9vIp++vkE7+Uz1J21f5Ilfn7gbbsTYu6N9u
9RG+JENpbroJtRT/LLyRerXT+q7Q5fyBcB/kL5B3CfOataLF9usI7sv/hifhPu8U
I0CnAV3SsUVDD2gqOtI16maGXhabtHM/Hzl+vRz53oX9Z+bMcSwSJ2GGDkV7WHKi
XYq7BjlrllIOXPxLtacWpTB/HADKoLierClCWeDXc0K1otS9ZMy7D7+UD2Db4clc
T5u+IhRq0Y7NPQQ0DtRXVd4gLVjt9w==
=PvI8
-----END PGP SIGNATURE-----

--Sig_/orKwvZW7.iPNQ9_UONq7tER--
