Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D777FF114
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345580AbjK3OCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjK3OCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:02:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E9B9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:02:12 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso9965a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701352931; x=1701957731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxBMiGcAEd4doX2T6kUaaKToconnxbKJJPNo5nm1fd4=;
        b=OCP2R1RqAZDCq6wXGz74eZL+wxQIbqkSreG/uMzQADiOjLifhVwbq9Rtu79e/RTiUT
         g+BjpyARHtw2DSG1Yk/IJDtRNu9ckZvENcYrhc/oJFf28XTUK2WA4GDxX+zCSdyxKBoJ
         GMjCKG3L6V9K+DCtYmKgpWVf0nQpMuLDMbfg8h1Bj271OnpMx3TU/PA/jQZglZILAM7G
         aasOYD2bm254PNgOEmuM1U7o4QnbufgjrClkPhAwRUuTQkVcWBL7dxV3BXrtSZV4mk74
         v0C1EzdsMLIoo/u2+HKtB1x3Ts/KlvnFWHfD1xOM4LwT+J2nbaXd8JYkoq8eJyniQ3GC
         t6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701352931; x=1701957731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxBMiGcAEd4doX2T6kUaaKToconnxbKJJPNo5nm1fd4=;
        b=uM+rsdtpJsvp9+qCSKIGxNXP8YD8wPiodSe8a0jk4FCZPsCBs5IZIzku4TpDhyADoi
         +dph8Mw7juBe1t3GxZdXDtzV6eHjuz7uAz713iIoEZCUk/FepNkck3njHam//1dCUmKX
         RDrFe5sD+RloPpqGrxT3uZFYVkTuUG9I6IX3KwqqW+Gfk6jrUfO+kglyWTCsMbdexuMP
         izKEVQAvjPXcvE2Gmo9HmICFzv7eUEVhnx2Mr4aIjUlca6sFdpQkydw8lMDAkmxNcoHs
         X4zrWFFwW8jInVbZpuCb5tKmu/sXx3nqBPpPLsCstlBdpDeze5QdGMng34ftkNZqnK94
         EADA==
X-Gm-Message-State: AOJu0Ywpfh3XpWqYmdauvgE5L2jqnO0kRnNNL++tkMbe6sBxdIrGW1Fu
        U1gVqg3QLvWtj3yff8GeMuxMdgt6Yo86/+aEZ8K2+g==
X-Google-Smtp-Source: AGHT+IEVq5eaRqCUGxQslevokHcou3lYVimBUmZu/Cymvq6zNuxmXKwBkEpc68x5OOLtst4kFtL6VTT+EwfFF1xjZC8=
X-Received: by 2002:a50:8a8e:0:b0:54b:bf08:a95f with SMTP id
 j14-20020a508a8e000000b0054bbf08a95fmr167000edj.6.1701352931041; Thu, 30 Nov
 2023 06:02:11 -0800 (PST)
MIME-Version: 1.0
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Nov 2023 15:01:56 +0100
Message-ID: <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com>
Subject: Re: Bug report connect to VM with Vagrant
To:     Shachar Kagan <skagan@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>,
        Topaz Uliel <topazu@nvidia.com>,
        Shirly Ohnona <shirlyo@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 2:55=E2=80=AFPM Shachar Kagan <skagan@nvidia.com> w=
rote:
>
> Hi Eric,
>
> I have an issue that bisection pointed at this patch:
> commit 0a8de364ff7a14558e9676f424283148110384d6
> tcp: no longer abort SYN_SENT when receiving some ICMP
>

Please provide tcpdump/pcap captures.

 It is hard to say what is going on just by looking at some application log=
s.


> Full commit message at [1].
>
> The issue appears while using Vagrant to manage nested VMs.
> The steps are:
> * create vagrant file
> * vagrant up
> * vagrant halt (VM is created but shut down)
> * vagrant up - fail
>
> Turn on a VM with =E2=80=98Vagrant up=E2=80=99 fails when the VM is in ha=
lt state. When the VM hasn't been created yet, 'Vagrant up' passes.
> The failure occurs in the Net-SSH connection to the VM step.
> Vagrant error is =E2=80=98Guest communication could not be established! T=
his is usually because SSH is not running, the authentication information w=
as changed, or some other networking issue.'
> We use a new version of vagrant-libvirt.
> Turn on the VM with virsh instead of vagrant works.
>
> Stdout[2] bellow.
>
> Any idea what may cause the error with your patch?
>
> Thanks,
> Shachar Kagan
>
> [1]
> commit 0a8de364ff7a14558e9676f424283148110384d6
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Nov 14 17:23:41 2023 +0000
>
>     tcp: no longer abort SYN_SENT when receiving some ICMP
>
>     Currently, non fatal ICMP messages received on behalf
>     of SYN_SENT sockets do call tcp_ld_RTO_revert()
>     to implement RFC 6069, but immediately call tcp_done(),
>     thus aborting the connect() attempt.
>
>     This violates RFC 1122 following requirement:
>
>     4.2.3.9  ICMP Messages
>     ...
>               o    Destination Unreachable -- codes 0, 1, 5
>
>                      Since these Unreachable messages indicate soft error
>                      conditions, TCP MUST NOT abort the connection, and i=
t
>                      SHOULD make the information available to the
>                      application.
>
>     This patch makes sure non 'fatal' ICMP[v6] messages do not
>     abort the connection attempt.
>
>     It enables RFC 6069 for SYN_SENT sockets as a result.
>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: David Morley <morleyd@google.com>
>     Cc: Neal Cardwell <ncardwell@google.com>
>     Cc: Yuchung Cheng <ycheng@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
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
...
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
>
>
