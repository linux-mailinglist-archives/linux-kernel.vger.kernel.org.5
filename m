Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604397BEADA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376299AbjJITuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346695AbjJITum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:50:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8EB6;
        Mon,  9 Oct 2023 12:50:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c008042211so59165611fa.2;
        Mon, 09 Oct 2023 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696881038; x=1697485838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCvsz/h9TY+Rnr8NBomSPRGnNvjlH7+ApWAJqBGhCEg=;
        b=SdHtX6PaPsXjEn/Of0ZvXVxjHqCijRL9dANCdgj8EPNV6piJePyCrciAnll9+Wp+cZ
         vgjTwSsbbm+FWMKcidB7CI5vmXnCuJIx5VhDX705RylyUdfnOc51W61SSuFBdBQwmuB5
         PHdGJewJ3Z55HTu2Wdd+yFBAa9vbtHV1hvFv7XeoHAayPrTbBrAhN/ZmplXXAwxY7l7g
         AQOs6GPvzNW+VTzgMJVhIA/azjaUj3sgIC8V+H6NM5g6O9eTXfY9ibh/UCW/fgsu1cP8
         pr2LWCR76AM/11IDHl2jzJ2nVOXVLW1EFEw9aSw8lzRJltUBbjatepDh5ODoYBwI+Hov
         KO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881038; x=1697485838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCvsz/h9TY+Rnr8NBomSPRGnNvjlH7+ApWAJqBGhCEg=;
        b=TvBjXcv/gMZS7xvtv8w5gKf/RdqyHPZ6Wq53hufIYSCbxlfZef44xHrIAAbfiA/gc1
         rhWPViJqtmxD7eMyMvW3uy0TLIjZkq7SVQOy/wHCT3nDcmsTJSRTm5Ao8qBFRqF8gX63
         KgB/5MrA6jFYvhGeJgvIoXjRgq1B+5tazVQjYNmaimCkXXmm+HdCCYwWBMaszwCCcTd8
         rJXzYqz51uIMw4ZuWxHiMK3U7Uxb96k0Og9yQwj4a5fzgzAc6g91lWRsOtBHueR/ilSR
         hyk6Bbzi9K4xSbfMqVW3oeCtPSGrzeDW8mhkxIU3EMH7unwaoHAY4TOHvcYEL7k9Tvsa
         9d/A==
X-Gm-Message-State: AOJu0YxVEg/1VK4kDTEgNNqnsigdD6tjrcB4Nk6etvhN9kTP6bx/GpMS
        NYAoLWOsYFjT9pHX0zoXwSthJkySx5GAXg4vJr4=
X-Google-Smtp-Source: AGHT+IFNib/1FUNelTBPZnwQ/ETGlj8YvjAwySBKGvclQsR9YBcZA+xkI0lQqbNwNHP+Qem/GR4XTlG4ASBXd4PG/Yc=
X-Received: by 2002:a2e:998e:0:b0:2ba:18e5:1064 with SMTP id
 w14-20020a2e998e000000b002ba18e51064mr14217882lji.14.1696881037531; Mon, 09
 Oct 2023 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <AM9P192MB12672AA34A0480B522D23741E8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
 <2023100727-passive-untidy-8df4@gregkh> <AM9P192MB1267C58F299DF86A5EEFE39EE8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
In-Reply-To: <AM9P192MB1267C58F299DF86A5EEFE39EE8C8A@AM9P192MB1267.EURP192.PROD.OUTLOOK.COM>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 9 Oct 2023 12:50:25 -0700
Message-ID: <CABBYNZLA2aTwRFqeDNLaT6Q4cytLB1e-q5oON=KVK1ts-0dz1w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com" 
        <syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuran,

On Sat, Oct 7, 2023 at 10:39=E2=80=AFAM Yuran Pereira <yuran.pereira@hotmai=
l.com> wrote:
>
> Hello Greg,
> My apologies, I just noticed that my patch is based on the mainline tree.=
 I'll re-submit one based on the Bluetooth tree and I'll ensure to include =
the commit id that it's fixing.
>
> Thanks,
> Yuran Pereira
> ________________________________
> De: Greg KH <gregkh@linuxfoundation.org>
> Enviado: 7 de outubro de 2023 11:41
> Para: Yuran Pereira <yuran.pereira@hotmail.com>
> Cc: marcel@holtmann.org <marcel@holtmann.org>; johan.hedberg@gmail.com <j=
ohan.hedberg@gmail.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.ke=
rnel.org>; linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org=
>; luiz.dentz@gmail.com <luiz.dentz@gmail.com>; syzbot+39ec16ff6cc18b1d066d=
@syzkaller.appspotmail.com <syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotma=
il.com>; linux-kernel-mentees@lists.linuxfoundation.org <linux-kernel-mente=
es@lists.linuxfoundation.org>
> Assunto: Re: [PATCH] Bluetooth: hci_conn_failed: Fixes memory leak
>
> On Sat, Oct 07, 2023 at 05:09:01PM +0530, Yuran Pereira wrote:
> > The hci_conn_failed() function currently calls hci_connect_cfm(), which
> > indirectly leads to the allocation of an l2cap_conn struct in l2cap_con=
n_add().
> > This operation results in a memory leak, as the l2cap_conn structure
> > becomes unreferenced.
> >
> > To address this issue and prevent the memory leak, this patch modifies
> > hci_conn_failed() to replace the call to hci_connect_cfm() with a
> > call to hci_disconn_cfm().

I suspect this is not quite right, hci_disconn_cfm is called when a
disconnection has been requested, hci_connect_cfm is correct here
since it is meant to notify the result of connection request procedure
so I can only assume that the culprit here is that hci_conn_failed is
called with status 0 which is invalid and needs fixing.

> > Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
> > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > ---
> >  net/bluetooth/hci_conn.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> What commit id does this fix?
>
> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz
