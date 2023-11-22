Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0DA7F479D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjKVNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbjKVNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:21:14 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602810C;
        Wed, 22 Nov 2023 05:21:08 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5c206572eedso3927008a12.0;
        Wed, 22 Nov 2023 05:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700659267; x=1701264067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8KuAtq2wuwd7uRsWWYBZ0mULd3F8IzS2XEFfePOf2ZA=;
        b=iqnMr9O5eVF1I2OBbzzZQB3o8C2yqjNcIX86HXScm39WdL3nJa7KgKQJuY1YEvJ9JM
         nlMm+0CyV7UmXiKKdFQ0JI1dUkvDMuMLJf0J3WuMiiC287v4PjTk/4GFfJc6+nmgukPp
         ssOVNxY2xmQhL1hAeR2r1HhXOQNg266gNcXo0yibmsm5y545585iQ5qaHnYmjRCM2s1O
         BM852pTUWrpVsF/H8wDb98JUpHxB4+JL5e6AXz/qeDGJ5y7aUBxnDar3AGi0MENrKGX2
         AeZG/g1gN2MF5RRHNvm+6XPF9PWQ73Qt6prAs1KfeNAw4oSQqkMHgp8B01LR6t2kCDSg
         sd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700659267; x=1701264067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KuAtq2wuwd7uRsWWYBZ0mULd3F8IzS2XEFfePOf2ZA=;
        b=gE6s2qrxQfgpRoARGE3m3VVZLI2xQJ6H6tu7KoUy6AUiD/ktmYC4Z/Ng8yP1R0Wia3
         7c+G7YV4TgAPIKdBHljFVGmXWWMegWzLBcLJyYYCTbRUx9JAY6zrf5Uy6kKbH8x5B06K
         UDb5iL2W1p6MyXGKmzcmqbh1535g1USfN1j/dT/U3k+F2MgS117MCmEIuxi4OiX2t32A
         vLNf4oS8ZgewwxDEOjdHqYWUJxBUbN0S0cWLCvjUSH3C+bWLIp2A1eVvEU0KmQ6Ojp1s
         STflksjIP6YFbxuBhFWgAmxdJQhKQyv6TldNG0+L9PkUdXCuo9A6EKD/DHmAqNHN2W3/
         NsGQ==
X-Gm-Message-State: AOJu0YyH/0tGWrUAdVwgWOfU8YKMKcnxja/Go5/EoQY+LoMHXL80zkRd
        jACcYBLuQicwGO2luI6MF/E=
X-Google-Smtp-Source: AGHT+IHMJmWJO62QizpKqXBJpkRvDmAKFCnqM9s6SVoAVqZ+23esDzGNsZhTZ+8ts5QHY0nOg2jcBQ==
X-Received: by 2002:a05:6a21:3288:b0:186:736f:7798 with SMTP id yt8-20020a056a21328800b00186736f7798mr2447858pzb.11.1700659267413;
        Wed, 22 Nov 2023 05:21:07 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7858e000000b006cbb71186f7sm4008491pfn.29.2023.11.22.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:21:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 1EB3210207134; Wed, 22 Nov 2023 20:21:04 +0700 (WIB)
Date:   Wed, 22 Nov 2023 20:21:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Arnas <arnasz616@gmail.com>
Subject: Re: Fwd: [Regression] S3 Sleep Mode failures since Linux 6.x on Dell
 Inspiron 15 5593
Message-ID: <ZV4AP1GY3fHAxmtx@archie.me>
References: <585dcc9e-7e72-473a-98ec-4f06018d542f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LKCzLPBSKEZk9tIu"
Content-Disposition: inline
In-Reply-To: <585dcc9e-7e72-473a-98ec-4f06018d542f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LKCzLPBSKEZk9tIu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 07:25:48AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > I'm having some weird issues with sleep mode on any 6.x Linux kernel ve=
rsion - it's a toss-up when I close the lid as to whether it will sleep pro=
perly or not - when it fails, the screen will lock, but it will not actuall=
y enter S3 sleep - it just blanks the screen, but the laptop stays on (and =
fan does too).
> >=20
> > Opening the lid after a failed sleep attempt turns on the screen instan=
taneously, and it doesn't even need to reconnect to WiFi - this doesn't hap=
pen when actually resuming from sleep, it takes a couple seconds for the sc=
reen to come on, and it then needs to reconnect the network.
> >=20
> > Following the failed attempt to enter sleep mode (closing the lid), the=
 following entries appear in the system log -
> >=20
> > arkiron kernel: ACPI Error: Thread 3233415168 cannot release Mutex [ECM=
X] acquired by thread 3268191936 (20221020/exmutex-378)
> > arkiron kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 du=
e to previous error (AE_AML_NOT_OWNER) (20221020/psparse-529)
> > arkiron kernel: Non-boot CPUs are not disabled
> >=20
> > Now, the "Non-boot CPUs are not disabled" line stands out the most to m=
e here, because successful sleep attempts won't have this line in the log.
> >=20
> > After the failed attempt above to sleep, I now close the lid again, and=
 it seemingly goes to sleep successfully. After checking the log following =
this, I find two new error lines in the log -
> >=20
> > arkiron kernel: ACPI Error: Thread 3233415168 cannot release Mutex [ECM=
X] acquired by thread 3268191936 (20221020/exmutex-378)
> > arkiron kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.ECDV._Q66 du=
e to previous error (AE_AML_NOT_OWNER) (20221020/psparse-529)
> >=20
> > Note that this time the CPU line is missing, as expected for a successf=
ul sleep attempt.
> >=20
> > This happens on both latest stable Linux kernel 6.5 as well as the late=
st Linux LTS 6.1 kernel. The last kernel that this didn't happen on was Lin=
ux LTS 5.15 (any version), which is what I was running up until the Linux L=
TS 6.1 upgrade. At that point I tried switching back to mainline (6.5) to s=
ee if it would fix sleep issues, but it didn't help. Downgrading to Linux L=
TS 5.15 did fix the sleep issues and the laptop seems to sleep reliably now=
=2E Running LTS 5.15.131-1 without issue as I am making this report.
> >=20
> > I'm on a Dell Inspiron 15 5593 using BIOS ver 1.27.0 (latest as of now)=
, running Arch Linux x86_64
>=20
> See Bugzilla for the full thread.
>=20
> Anyway, I'm adding it to regzbot:
>=20
> #regzbot introduced: v5.15..v6.1 https://bugzilla.kernel.org/show_bug.cgi=
?id=3D217950
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217950
>=20

Hi Thorsten and all,

It seems like the BZ reporter is really busy with his college life; IOW
he can only bisect in the winter break [1]. Should I mark this regression
as inconclusive for now?

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217950#c5

--=20
An old man doll... just what I always wanted! - Clara

--LKCzLPBSKEZk9tIu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV4APwAKCRD2uYlJVVFO
o2AAAQDTwCOQWHhQjO5u0rqiRHxr5UzfJelTwcYdlfrqvbmiUgD/Zsh+FP3jNO3S
gRMaJaeLR5+9J9TbWbtkSOkrGF4AUAw=
=vXvH
-----END PGP SIGNATURE-----

--LKCzLPBSKEZk9tIu--
