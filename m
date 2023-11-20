Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218807F1130
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjKTLB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbjKTLBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:01:55 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791209D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:01:30 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50797cf5b69so5561334e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700478088; x=1701082888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PPW06YC38erq8SZWtv+ncf66iEcbQv3rHXBqyT0lxI=;
        b=OONPdmZ1Yiv1fuSttkzmSfdEaygm7Oz6P1uEM1iBmrP9C/zMyf+VOuVL2tmNdhcDvX
         K2zY+U2A5aIJ+mngg9/K7fLtmg6vDRgF8KKcDqcPdNSh6epIqvAytnt35JgZchJBnN7z
         UtH3Aisk7IAr1maAbKJGNlx3/52piaq3ButxyH/7bfm3mg445rir59Abx9RieW2eKnxF
         1X4rJijFScvemdVc8eX8fjX5dTS1ei4fPdLsV5FljGDNC1aeJcckhbu1atWvVOdeLDRY
         4pirimsf97CzoxTiS7a+f6f+ZjHSyk0Y3BzAVdw7HlatsHmo1RfhkrYbzQY6F6NkLphf
         /SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478088; x=1701082888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PPW06YC38erq8SZWtv+ncf66iEcbQv3rHXBqyT0lxI=;
        b=mnzWJGcxo1ML+1nRutZZwPBC2mkO/xVzeYwbGUasg+4j2kZXNm/WgdQBZ7m4dpDBa5
         6y0Uv809kY3feOdZsANold3jSupur5UT5rypntDYTEIB0NL7KpVR5UubddRQ23Pw1kUv
         Dk/NoN32Y9i2j/EpnRqJWRx27VCYwDSwVX8lmO0mmF8q9WUoOk1BRpnd1dnIaOzR9KYh
         B4tX2rWpULsyjTrxlAcPK/QCD4ddvQo3OQFD0CgCyJ0wQ2CKhWzMnIO4U/7KDo1H1g/z
         RR+2sIciDZSKY+8yYNi7/VfcSgactMh2fnlWIXSA7ti+JptqDi81iUiMi5L6FXZuQM4K
         K6mg==
X-Gm-Message-State: AOJu0YwcQf+JNQDLNs3sNVr0guswqJInufeQyZfgxmUxWA0bGgOvGDsI
        pk8QDcLt8VRwcMcLSPLBGv4mhV1iKwKlDRv2/nDc2A==
X-Google-Smtp-Source: AGHT+IGqrl+BKwsuiltU8GvpE7zptGLvkTub9X/9cMNcMb3F3anQAwtf3Dxg4wx6drjoVWqrc6khwBJvqgi+N0M4OTM=
X-Received: by 2002:a2e:b60c:0:b0:2ba:6519:c50f with SMTP id
 r12-20020a2eb60c000000b002ba6519c50fmr4938095ljn.52.1700478088590; Mon, 20
 Nov 2023 03:01:28 -0800 (PST)
MIME-Version: 1.0
References: <20231116114150.48639-1-huangjie.albert@bytedance.com>
 <ZVcxmwm/DRTB8QwO@lore-desk> <CABKxMyPMboVYs01KfPEdxPbx-LT88Qe1pcDMaT0NiNWhA-5emg@mail.gmail.com>
 <ZVssMWXZYxM0eKiY@lore-desk> <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
In-Reply-To: <CABKxMyPNYS=6BHhaMDOSSMu8F0C5jkoa5Tck1dE6QnLa6--6UQ@mail.gmail.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 20 Nov 2023 19:01:16 +0800
Message-ID: <CABKxMyO0oExMvKbZ32_Qh+3ezcY8CK0AYjxL6B2iD3DQ26J_Kg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH net] veth: fix ethtool statistical errors
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E9=BB=84=E6=9D=B0 <huangjie.albert@bytedance.com> =E4=BA=8E2023=E5=B9=B411=
=E6=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 18:02=E5=86=99=E9=81=93=EF=BC=9A
>
> Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=80 17:52=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=
=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:26=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > > if peer->real_num_rx_queues > 1, the ethtool -s command for
> > > > > veth network device will display some error statistical values.
> > > > > The value of tx_idx is reset with each iteration, so even if
> > > > > peer->real_num_rx_queues is greater than 1, the value of tx_idx
> > > > > will remain constant. This results in incorrect statistical value=
s.
> > > > > To fix this issue, assign the value of pp_idx to tx_idx.
> > > > >
> > > > > Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit=
 accounting")
> > > > > Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
> > > > > ---
> > > > >  drivers/net/veth.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > > index 0deefd1573cf..3a8e3fc5eeb5 100644
> > > > > --- a/drivers/net/veth.c
> > > > > +++ b/drivers/net/veth.c
> > > > > @@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net=
_device *dev,
> > > > >       for (i =3D 0; i < peer->real_num_rx_queues; i++) {
> > > > >               const struct veth_rq_stats *rq_stats =3D &rcv_priv-=
>rq[i].stats;
> > > > >               const void *base =3D (void *)&rq_stats->vs;
> > > > > -             unsigned int start, tx_idx =3D idx;
> > > > > +             unsigned int start, tx_idx =3D pp_idx;
> > > > >               size_t offset;
> > > > >
> > > > >               tx_idx +=3D (i % dev->real_num_tx_queues) * VETH_TQ=
_STATS_LEN;
> > > > > --
> > > > > 2.20.1
> > > > >
> > > >
> > > > Hi Albert,
> > > >
> > > > Can you please provide more details about the issue you are facing?
> > > > In particular, what is the number of configured tx and rx queues fo=
r both
> > > > peers?
> > >
> > > Hi, Lorenzo
> > > I found this because I wanted to add more echo information in ethttoo=
l=EF=BC=88for veth,
> > > but I found that the information was incorrect. That's why I paid
> > > attention here.
> >
> > ack. Could you please share the veth pair tx/rx queue configuration?
> >
>
> dev: tx --->4.  rx--->4
> peer: tx--->1 rx---->1
>
> Could the following code still be problematic? pp_idx not updated correct=
ly.
> page_pool_stats:
> veth_get_page_pool_stats(dev, &data[pp_idx]);

I did the test locally and there is no problem with this place. I
didn't fully understand
this piece of code before
thanks.
BR
Albert.

>
> BR
> Albert
>
> > Rergards,
> > Lorenzo
> >
> > >
> > > > tx_idx is the index of the current (local) tx queue and it must res=
tart from
> > > > idx in each iteration otherwise we will have an issue when
> > > > peer->real_num_rx_queues is greater than dev->real_num_tx_queues.
> > > >
> > > OK. I don't know if this is a known issue.
> > >
> > > BR
> > > Albert
> > >
> > >
> > > > Regards,
> > > > Lorenzo
