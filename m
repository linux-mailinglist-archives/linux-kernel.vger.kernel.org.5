Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C355B7FF15C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345853AbjK3OKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345867AbjK3OKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:10:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13A8D4A;
        Thu, 30 Nov 2023 06:10:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d00689f5c8so9241075ad.3;
        Thu, 30 Nov 2023 06:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353452; x=1701958252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dE47Cw76xuUIfSQwDeLYhzziVg6LOr/m9eTrQ3RiaO0=;
        b=QhVrWqsc149DoIhIfZcbGvysUXvHFNJoKE9xAT2QFUyn/yy+wqG2d8Sx/DBGGO5ShJ
         5Kqw+KkoC3H54KGw1aFlznqgMNfUkXod/olXYvWD7LIUN6kELJ0PUgMSlU+XxSbai04k
         TasgJgNc24c2TINdE+IaV66SeiFoGVqo1TrR/CpaUEVmcpZTbVo0d79WKS1Om9UwvkIS
         ZZFFy6JpTd4GTaajfic8LbtrFxORHfGlo0Ft0yor9SA6WQOIn2TzMyWEuliaRZ54a7uL
         W+LWeD2K3QQYskaQUSSeirOaRXobKIgzzwwYVGjaaC1EeAeW6n95INGM5NkJ7bF5BBaa
         vtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353452; x=1701958252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE47Cw76xuUIfSQwDeLYhzziVg6LOr/m9eTrQ3RiaO0=;
        b=D4LUbaWuuwqtKBrMz/wmek0vUgruNKd7g0l+JIH8fyi2rDPKJVHmlfGN7ogf5GOZP5
         oanQfa0F3cPCP76jBcXUIPBQwAqj6FhmFzg7PD9nqf4yf3xlelcFZNcGMEkPoj4ftZdj
         yGO01M1wsH2y1aeluNEWdB149wm7elqeZ9XNX9hRWYP7arvPjrxIs/83FzG3XvElu4gJ
         Iw8tS2zJtq8PgP7AmL/HCuCIlWPuYzpevB9YYKFznSDATmSnenkTYyA1psyh5VYV9OXA
         erYUdzr3g6RLDUiYT2KMxfVNhnHOrJ6gHs1gyS9Csm3rYKihihXPcFyDFt0ZwQD22jPP
         Cyig==
X-Gm-Message-State: AOJu0YwbaVJqurcFCA1Ir0jkaH9ARwqTafQX/qtNgl1cyjXyWS4icO6A
        0olmmFhlj6gqI7FfDIOBVqs=
X-Google-Smtp-Source: AGHT+IGMndrqXnGMpG3E0OJhMK/QUwMXYTZLRWve5i8XYeazMaCtffkQZksUI0nQh9IW/slN22nM1w==
X-Received: by 2002:a17:902:e80e:b0:1cf:daca:2b5e with SMTP id u14-20020a170902e80e00b001cfdaca2b5emr14536787plg.38.1701353452299;
        Thu, 30 Nov 2023 06:10:52 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b001cf89e69a70sm1401937plm.307.2023.11.30.06.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:10:51 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 4BC09102F908A; Thu, 30 Nov 2023 21:10:48 +0700 (WIB)
Date:   Thu, 30 Nov 2023 21:10:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shachar Kagan <skagan@nvidia.com>,
        "edumazet@google.com" <edumazet@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>,
        Topaz Uliel <topazu@nvidia.com>,
        Shirly Ohnona <shirlyo@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>
Subject: Re: Bug report connect to VM with Vagrant
Message-ID: <ZWiX6NtanFyx4lmw@archie.me>
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lLgwSM4kOO8NeYim"
Content-Disposition: inline
In-Reply-To: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lLgwSM4kOO8NeYim
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 01:55:06PM +0000, Shachar Kagan wrote:
> Hi Eric,
>=20
> I have an issue that bisection pointed at this patch:
> commit 0a8de364ff7a14558e9676f424283148110384d6
> tcp: no longer abort SYN_SENT when receiving some ICMP
>=20
> Full commit message at [1].
>    =20
> The issue appears while using Vagrant to manage nested VMs.
> The steps are:
> * create vagrant file
> * vagrant up
> * vagrant halt (VM is created but shut down)
> * vagrant up - fail
>=20
> Turn on a VM with =E2=80=98Vagrant up=E2=80=99 fails when the VM is in ha=
lt state. When the VM hasn't been created yet, 'Vagrant up' passes.
> The failure occurs in the Net-SSH connection to the VM step.
> Vagrant error is =E2=80=98Guest communication could not be established! T=
his is usually because SSH is not running, the authentication information w=
as changed, or some other networking issue.'
> We use a new version of vagrant-libvirt.
> Turn on the VM with virsh instead of vagrant works.
>=20
> Stdout[2] bellow.
>=20
> Any idea what may cause the error with your patch?
>=20
> Thanks,
> Shachar Kagan
>=20
> [1]
> commit 0a8de364ff7a14558e9676f424283148110384d6
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Nov 14 17:23:41 2023 +0000
>=20
>     tcp: no longer abort SYN_SENT when receiving some ICMP
>    =20
>     Currently, non fatal ICMP messages received on behalf
>     of SYN_SENT sockets do call tcp_ld_RTO_revert()
>     to implement RFC 6069, but immediately call tcp_done(),
>     thus aborting the connect() attempt.
>    =20
>     This violates RFC 1122 following requirement:
>    =20
>     4.2.3.9  ICMP Messages
>     ...
>               o    Destination Unreachable -- codes 0, 1, 5
>    =20
>                      Since these Unreachable messages indicate soft error
>                      conditions, TCP MUST NOT abort the connection, and it
>                      SHOULD make the information available to the
>                      application.
>    =20
>     This patch makes sure non 'fatal' ICMP[v6] messages do not
>     abort the connection attempt.
>    =20
>     It enables RFC 6069 for SYN_SENT sockets as a result.
>    =20
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: David Morley <morleyd@google.com>
>     Cc: Neal Cardwell <ncardwell@google.com>
>     Cc: Yuchung Cheng <ycheng@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>=20
> [2]
> Vagrant up stdout:
> Bringing machine 'player1' up with 'libvirt' provider...
> =3D=3D> player1: Creating shared folders metadata...
> =3D=3D> player1: Starting domain.
> =3D=3D> player1: Domain launching with graphics connection settings...
> =3D=3D> player1:  -- Graphics Port:      5900
> =3D=3D> player1:  -- Graphics IP:        127.0.0.1
> =3D=3D> player1:  -- Graphics Password:  Not defined
> =3D=3D> player1:  -- Graphics Websocket: 5700
> =3D=3D> player1: Waiting for domain to get an IP address...
> =3D=3D> player1: Waiting for machine to boot. This may take a few minutes=
=2E..
>     player1: SSH address: 192.168.123.61:22
>     player1: SSH username: vagrant
>     player1: SSH auth method: private key
> =3D=3D> player1: Attempting graceful shutdown of VM...
> =3D=3D> player1: Attempting graceful shutdown of VM...
> =3D=3D> player1: Attempting graceful shutdown of VM...
>     player1: Guest communication could not be established! This is usuall=
y because
>     player1: SSH is not running, the authentication information was chang=
ed,
>     player1: or some other networking issue. Vagrant will force halt, if
>     player1: capable.
> =3D=3D> player1: Attempting direct shutdown of domain...
>=20
>=20

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 0a8de364ff7a14
#regzbot title: starting Vagrant VM fails due to not aborting SYN_SENT

--=20
An old man doll... just what I always wanted! - Clara

--lLgwSM4kOO8NeYim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWiX5AAKCRD2uYlJVVFO
o0msAP0YtPQj+1kQr2oLBrT2KntONODcf0o0IqmpNwpK64hDtgEArzAfTafqswql
hpTOqUdIWuz2TfZ3jaLej5JOpNHmJwE=
=mc86
-----END PGP SIGNATURE-----

--lLgwSM4kOO8NeYim--
