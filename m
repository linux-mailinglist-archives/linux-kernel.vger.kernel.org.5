Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2A7FFE5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377120AbjK3WM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjK3WMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:12:55 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020110DC;
        Thu, 30 Nov 2023 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701382380;
        bh=LxAjoxq0681WQkXf0rZHFfVRJcZv7Fy/N757wKutH1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VMkiU1/+wsmtg9qXg39pxKjV6DMLjVU5gVEScKS43yDOJDl9WJ5cTqbmRGmo0tVRg
         VECQMX+DLPiYrR961piYMvRn9uVXop2leaJH3+/X5iNeSwgp3RAx0I/UtSHJa57sOK
         94isOmSB7tRVz4M8Cr4fmm3xJ8jWYtpCpDDo09vwlXR53dBA9Bfoy9dOeKLJe8whuk
         BXg+Nk8ggwt2WaLT1Zt+jgu3oBGILmUwx3HBneEFhi1ppuK86IuJ7ED53QC/8Aa1Jd
         MF1jSMgvUOk0wuIQCvQyxI26sjLRyPbIg+XNPcH/cBUDXx63tvGFLofVS8KoOZ0EWo
         lcNKPGVNucrTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sh9Rw0NwMz4xW3;
        Fri,  1 Dec 2023 09:12:59 +1100 (AEDT)
Date:   Fri, 1 Dec 2023 09:12:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20231201091257.02cb752f@canb.auug.org.au>
In-Reply-To: <20231129081704.f26fu3g2svnam7n5@CAB-WSD-L081021>
References: <20231129084547.79c27d63@canb.auug.org.au>
        <20231128144514.aa04099199dc13f52374e2b2@linux-foundation.org>
        <20231129081704.f26fu3g2svnam7n5@CAB-WSD-L081021>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UwtvgnCyWCO.XBbHbfHlb4_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UwtvgnCyWCO.XBbHbfHlb4_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Wed, 29 Nov 2023 11:17:04 +0300 Dmitry Rokosov <ddrokosov@salutedevices.=
com> wrote:
>
> On Tue, Nov 28, 2023 at 02:45:14PM -0800, Andrew Morton wrote:
> > On Wed, 29 Nov 2023 08:45:47 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> >  =20
> > > After merging the mm tree, today's linux-next build (x86_64 allmodcon=
fig)
> > > failed like this:
> > >=20
> > > make[5]: *** No rule to make target 'samples/cgroup/cgroup_event_list=
ener.c', needed by 'samples/cgroup/cgroup_event_listener'.  Stop.
> > >=20
> > > Caused by commit
> > >=20
> > >   fc2cf253aaec ("samples: introduce new samples subdir for cgroup")
> > >=20
> > > I have reverted that commit (and the following one) for today. =20
> >=20
> > Thanks, my rename detector broke.  Fixed. =20
>=20
> Sorry, I don't fully understand the situation. Is there any issue on my
> side?

No, Andrew was just saying that he missed the file move when applying
the patch to his tree and he has fixed it up now.
--=20
Cheers,
Stephen Rothwell

--Sig_/UwtvgnCyWCO.XBbHbfHlb4_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVpCOoACgkQAVBC80lX
0Gw9vQf+Jo89nL7Sn2LeMITGgzBnIiJQIlbYr9Y3lA8BTtq11TuTM3gGVKuJ8OLK
HzlP9fVTVz2whEe4rUKFZEUhVrTbTRddJT6gKA33JYpaf9uaN6uuHEd7tdPhHmP8
wI8E8eB56LyoOMJ8QvI0HcNPyDJYlo8a1rwbi96lFQISEC4qc+8Co4xylDu1FTBr
RBlpv2c2H9vQDGe/1a31M6Y3A8a4hNvkJbTPPAPsJmPwN+aC8WPm60ju8mSW6EgG
dVK2iqMllKQV0lKkjS/xfYjl1VvEupvjYx0PsB43c6kisGJ7LnO/Um1yupadQ65e
tfMPqZtKvye2kuv+Zag9DiAl5VIaLQ==
=1or6
-----END PGP SIGNATURE-----

--Sig_/UwtvgnCyWCO.XBbHbfHlb4_--
