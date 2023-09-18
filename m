Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E227A4589
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbjIRJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240893AbjIRJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:07:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A15116;
        Mon, 18 Sep 2023 02:07:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-578638a736aso891115a12.0;
        Mon, 18 Sep 2023 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695028036; x=1695632836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4bWl3f5ebZl1xu2Y49OrTosVYswuHdbpSHUYRem6R0=;
        b=CcEJt1wDb/ToprH7a2QYwM0QYjjqRGVQEfMKMaNEc4Hl0H9z22EqjCQIGSpCVlq4M+
         kTyGDfJFtBrt3ViUX1lVcPTIKaOsoQxiTgyw8JrzuPK7GQIBJ3JCQy611zGI4WVcnWxP
         Qiqb2JBU6DFin+W/dMsV8dnQNO9HsCxrXXVEWWf7kKX20OTitIewHTJWIZt7K9f7C8uY
         hVhRFoLkhgzlIWfk2Qfg6tUBPvs+gw/p+OBcFQs+kij88NqaqZITT2xbJU65TZAa6cuT
         hRdMXepmGtpgyruVkK7OH4/12oESRIA9uCJWO7RwSb02LY6Tr0miI4ubh1wq3/kXkmyY
         5IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028036; x=1695632836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4bWl3f5ebZl1xu2Y49OrTosVYswuHdbpSHUYRem6R0=;
        b=iiR2FS3B9VaXrOflZuytSMcZ+LI3dtpNPYx8sqVJbOniGsAgJu3KgGEfH6KAsY2UYX
         aeSMMyOIs7x60o2yTTaykIxp/X4q581y4c2MnccVezxyn26myN/QH5S7yaHhXD57dOT8
         ZZcdGyJCapperQCGehZVq2Dx+Q8MO1j1026hyGE5cAAeDrllx/iwUwu2H+wp/3FdMgKK
         NBqwsAb+es8gOP6RH5GGCRUyad6R6bOgxQ/sfQp4LRgQjW0HHgv5n6njT1UDXkk8/ne2
         oQUptS8x+zXXwl+mCfC8cT/tLyCYKHchaKxZE7lgUhS00qJXM9y/Gzxf2kGmLXXeCNQ2
         R3eA==
X-Gm-Message-State: AOJu0YycE9DnoOFx8vPoa/ZU2Uica1Wva2HzFb9ENM/70h1jvWCMt1dJ
        z4y4f30YZO/0LdzWe+4DDKU=
X-Google-Smtp-Source: AGHT+IFNrDP+MZoBNKM88lVE3MSuM7qlz/+Hjm4sCf4Q9gVRluyvjVRRUPkH7dyju+PdgM90l+bV6g==
X-Received: by 2002:a05:6a20:1393:b0:154:90ba:70e with SMTP id hn19-20020a056a20139300b0015490ba070emr6829127pzc.48.1695028035684;
        Mon, 18 Sep 2023 02:07:15 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b006878cc942f1sm6762980pfn.54.2023.09.18.02.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:07:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 103029BCD21C; Mon, 18 Sep 2023 16:07:11 +0700 (WIB)
Date:   Mon, 18 Sep 2023 16:07:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Charles Han <hanchunchao@inspur.com>, djwong@kernel.org,
        dchinner@redhat.com, allison.henderson@oracle.com,
        bhelgaas@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: xfs: Remove duplicate 'the' in
 transaction sequence process
Message-ID: <ZQgTP8uQUNAnBmX9@debian.me>
References: <20230918074054.313204-1-hanchunchao@inspur.com>
 <ZQgEYU71YE6Jv38D@debian.me>
 <87ttrrc2yl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NHywu6YAwHJz5eyG"
Content-Disposition: inline
In-Reply-To: <87ttrrc2yl.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NHywu6YAwHJz5eyG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 02:14:58AM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > On Mon, Sep 18, 2023 at 03:40:54PM +0800, Charles Han wrote:
> >> Remove the repeated word "the" in comments.
> >
> > Patch title looks OK but in this case, the patch description should als=
o match.
> > Hint: there is no code comments in the doc below.
> >
> >>=20
> >> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> >> ---
> >>  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Do=
cumentation/filesystems/xfs-online-fsck-design.rst
> >> index 1625d1131093..a0678101a7d0 100644
> >> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> >> +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> >> @@ -1585,7 +1585,7 @@ The transaction sequence looks like this:
> >>  2. The second transaction contains a physical update to the free spac=
e btrees
> >>     of AG 3 to release the former BMBT block and a second physical upd=
ate to the
> >>     free space btrees of AG 7 to release the unmapped file space.
> >> -   Observe that the the physical updates are resequenced in the corre=
ct order
> >> +   Observe that the physical updates are resequenced in the correct o=
rder
> >>     when possible.
> >>     Attached to the transaction is a an extent free done (EFD) log ite=
m.
> >>     The EFD contains a pointer to the EFI logged in transaction #1 so =
that log
> >
> > Regardless, wait for one or few days before rerolling this patch with
> > reviews addressed. It allows other reviewers to catch up and review. Yo=
u can
> > also Cc: me if you'd like.
>=20
> Bagas, this is a patch removing an extra "the".  We do not need to make
> life this hard for such a simple fix.
>=20
> Charles, the patch is good enough, no need for a third version.
>=20
> (Next time, though, do wait before resubmitting a patch.  When you do,
> put a description of what changed below the "---" line.)

Thanks for the reminder!

--=20
An old man doll... just what I always wanted! - Clara

--NHywu6YAwHJz5eyG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQgTOwAKCRD2uYlJVVFO
o08bAQC2F1Tpy3iLd+nzrRF2ezl8Dbw9/8MjQPtYgX3ScNL6KQEAkTgm+MZcDGw3
8kzg6fqFKRwmDo9X0ehrtoNjtaMthAk=
=YlNw
-----END PGP SIGNATURE-----

--NHywu6YAwHJz5eyG--
