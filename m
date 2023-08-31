Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942FF78F62E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbjHaXfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHaXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:35:12 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C5FE50
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:35:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c0bae4da38so9186275ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693524908; x=1694129708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnTD/qfGQeY3JaNKKwV4/Zlh7IqE1aYYBA1ehh6D7Qc=;
        b=Y0xah0OfRT3anvwxi0YzK7gYSzbBAtkWqxKFSBAMbb1H0AjWDAszbBD3SZFWn++odw
         gsa6AzR9UByV4vJZez8+SV+ONhijVHqNbiqPH9qgPzkiQMKa/2O6vcp3FQwqBgsPmmkv
         B3IQMqhraeUWECAxKb2I+H8sXM+FHiTI3cIPpd85DODeUp9ooUh2kpnAI2IE4+205Eof
         Qg1xey4R3+3lMlJH2c8KAgkanLJ+0bcnBmFZ2EIJFIT6+rCMRZrKnnhmIhXIzS377jd/
         tMwTeJMkB7zgbsEQR5wHPUsISJlC2y4+D+0xhz6xslqkSud/ujK0y0FmsmVfutEhHfLI
         rTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693524908; x=1694129708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnTD/qfGQeY3JaNKKwV4/Zlh7IqE1aYYBA1ehh6D7Qc=;
        b=Z6DEgWnWWJ+VV+H8ccCTlbsVmEyEXjnhB/CcIh/5k1k1expBHo429z4lCpdDV0Lpr6
         J3bKKyuTuIlsfu4tpTuJtt0m1uLu0lvEFr6IO5KiDOjHSrrVTroEVNNbs4n/yFbsxo/e
         wYe//nopHE8f/yhAg0dZdgb/9k9LV4glZJZwFM7/DZvwY2E1QrUNX27vVETrdT3neX4f
         otl71vEidE6sbBd5JQX6bYm+rKSkDU+BrY+k+ncMFyAkH5HnWlfCx3kwPZQRRoIuhjjf
         5hZ2ZItuLrbai5WD+fhnMQgk19bVgt3AwFLBWf9osYHDZMB/eOucengZl8a57LznOp8G
         wy2A==
X-Gm-Message-State: AOJu0Yy1ixb//jMFrROSoQu/CGN4HSUoAB2KHzINQJd13qeqeTuJorri
        sp1gAXM93Pr/TL3r1T1HFKY=
X-Google-Smtp-Source: AGHT+IGYqIzeQcTECd6RWQ3/nUs34nuB/uwnMzaLAFrYR0FQl+uuLqF7+fr+to3m67HnSu9xRiztrg==
X-Received: by 2002:a17:902:ab54:b0:1b8:8682:62fb with SMTP id ij20-20020a170902ab5400b001b8868262fbmr1039627plb.4.1693524908500;
        Thu, 31 Aug 2023 16:35:08 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001bde6fa0a39sm1749096plb.167.2023.08.31.16.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 16:35:08 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B9FC381A1A74; Fri,  1 Sep 2023 06:35:04 +0700 (WIB)
Date:   Fri, 1 Sep 2023 06:35:04 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: 6.6/regression/bisected - after commit
 a349d72fd9efc87c8fd1d16d3164752d84a7275b system stopped booting
Message-ID: <ZPEjqA46OO6Rr8RN@debian.me>
References: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YlrlQSBP360Gwvyd"
Content-Disposition: inline
In-Reply-To: <CABXGCsNi8Tiv5zUPNXr6UJw6qV1VdaBEfGqEAMkkXE3QPvZuAQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YlrlQSBP360Gwvyd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 03:45:28AM +0500, Mikhail Gavrilov wrote:
> Hi,
> next release cycle, and another regression.
> Yesterday after another kernel update in Fedora Rawhide system stopped bo=
oting.
> Today thanks to git bisect, I found out that this is a commit:
>=20
> =E2=9D=AF git bisect bad
> a349d72fd9efc87c8fd1d16d3164752d84a7275b is the first bad commit
> commit a349d72fd9efc87c8fd1d16d3164752d84a7275b
> Author: Hugh Dickins <hughd@google.com>
> Date:   Tue Jul 11 21:30:40 2023 -0700
>=20
>     mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
>=20
>     Patch series "mm: free retracted page table by RCU", v3.
>=20
>     Some mmap_lock avoidance i.e.  latency reduction.  Initially just for=
 the
>     case of collapsing shmem or file pages to THPs: the usefulness of
>     MADV_COLLAPSE on shmem is being limited by that mmap_write_lock it
>     currently requires.
>=20
>     Likely to be relied upon later in other contexts e.g.  freeing of emp=
ty
>     page tables (but that's not work I'm doing).  mmap_write_lock avoidan=
ce
>     when collapsing to anon THPs?  Perhaps, but again that's not work I've
>     done: a quick attempt was not as easy as the shmem/file case.
>=20
>     These changes (though of course not these exact patches) have been in
>     Google's data centre kernel for three years now: we do rely upon them.
>=20
>=20
>     This patch (of 13):
>=20
>     Before putting them to use (several commits later), add rcu_read_lock=
() to
>     pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
>     separate commit, since it risks exposing imbalances: prior commits ha=
ve
>     fixed all the known imbalances, but we may find some have been missed.
>=20
>     Link: https://lkml.kernel.org/r/7cd843a9-aa80-14f-5eb2-33427363c20@go=
ogle.com
>     Link: https://lkml.kernel.org/r/d3b01da5-2a6-833c-6681-67a3e024a16f@g=
oogle.com
>     Signed-off-by: Hugh Dickins <hughd@google.com>
> <long cc list omitted>...
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>=20
>  include/linux/pgtable.h | 4 ++--
>  mm/pgtable-generic.c    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> It looks like the hang happens so early that when booting into a
> working kernel and running "journalctl -b -1" I see in the console the
> log of the previous kernel which was booted before the problematic
> kernel.
> Therefore, I apologize that I can't provide the kernel logs.
> I can provides only photos when backtrace appears on my monitor:
> Here we waiting: https://ibb.co/5xmm0BH
> And then I see backtrace: https://ibb.co/TLLGFNP
>=20
> Unfortunately I can't revert commit
> a349d72fd9efc87c8fd1d16d3164752d84a7275b for testing more fresh builds
> because of conflicts.
>=20
> My hardware: https://linux-hardware.org/?probe=3Ddd5735f315
> I also attached kernel build config and full bisect log.
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: a349d72fd9efc8
#regzbot title: rcu_read_{lock,unlock}() causes unbootable system with back=
trace

--=20
An old man doll... just what I always wanted! - Clara

--YlrlQSBP360Gwvyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZPEjogAKCRD2uYlJVVFO
o3dwAP9Mvs2XVvCKGsLeMpZkFeVo271NAUlejx1tpCkRufzuqAD/cHTFPuH2Lrz+
VZSQQkes8U+rX0p0LUA/E/DCx4UsiAo=
=pMfl
-----END PGP SIGNATURE-----

--YlrlQSBP360Gwvyd--
