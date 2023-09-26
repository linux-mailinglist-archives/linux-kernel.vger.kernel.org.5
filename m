Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747087AE3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjIZC6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIZC6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D7FF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695697065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
        b=Q+UFtwu50D/OgAhWQM1E++fUtnqgECRR/0cV6oq9ALlZngXzZJdjVTmZQcVQB87lmlpmaH
        BHNp2xTG+4D+k/riSN8kSRdaOKks/1y6dwsAEjKTanHibxxG6DBOMOO5EYajuk1HEd5SU9
        N9EZIJR+4hhdGipxZEI3xFMsGIB85A8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-TnBeJse4PjuzrOWEkdoT-A-1; Mon, 25 Sep 2023 22:57:41 -0400
X-MC-Unique: TnBeJse4PjuzrOWEkdoT-A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2be51691dd5so111875781fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695697060; x=1696301860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8rCoPOuaYDCIDe0rlK/tHfmdP2Iqj9+uLvJ1lMY8pc=;
        b=l+sjcBU0Ybeg6QTWPbxeIjmo2xCYMjA9nJEBjU4Hqx18QJJNq5rRSE1fcGa0LM5eMo
         DFcSQUp1B8R8tlbwJcnQC0kkhTMUuigjTsYhREWAUebuH02UaYDsdb5gl1NTji3Hs4p3
         kNArCBpbsngOl21Kn3d6UxA/km2Am38koWakDWkjbOpy8xLKvkFiomPWRaxAHTg0YAeM
         nqsJqeyTQseZV3wjMMkI75s1HoTMRTErogs/7uKee+NL2KqqlIBVoE0nilueWwxtKcM5
         tk4pdHUC2dbGq7sfKSjhi3NR0xAQaG8FNp88YU9AjeTHxTvc/yiW/TEAS1Y+gHytYcB3
         ECIQ==
X-Gm-Message-State: AOJu0YyqCE5RPfvRjk3bFP1YV7DHur44q0HkJhgGkHZ1GEKWyO3EjdGz
        mlI9nlrMdGbz/64fBSo+dkaDclmh2ptqvMJpx0OG6pkqvRM74kFHDvAc3QTXOrawbCwJWYdWQrq
        I7SLLMtxFZHVjLJ7KZQnF4KGvqiCtl+Wk8NZFf+fG
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id u12-20020ac248ac000000b005030a764eebmr5830372lfg.16.1695697060328;
        Mon, 25 Sep 2023 19:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3RwYqaYdD2D197Rxxx50AyfpQufQFfgo1/JwgJGy62/rNkyDXHkQuYdQhZ6f74/Yi67MydQBhjJAzFfg+eVI=
X-Received: by 2002:ac2:48ac:0:b0:503:a76:4eeb with SMTP id
 u12-20020ac248ac000000b005030a764eebmr5830366lfg.16.1695697060053; Mon, 25
 Sep 2023 19:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230925103057.104541-1-sgarzare@redhat.com>
In-Reply-To: <20230925103057.104541-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Sep 2023 10:57:29 +0800
Message-ID: <CACGkMEvWKCoB+u2GO2mRroZDmmxcvd8+ytUjpu6wNcBOAu5RYQ@mail.gmail.com>
Subject: Re: [PATCH] vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 6:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> In the while loop of vringh_iov_xfer(), `partlen` could be 0 if one of
> the `iov` has 0 lenght.
> In this case, we should skip the iov and go to the next one.
> But calling vringh_kiov_advance() with 0 lenght does not cause the
> advancement, since it returns immediately if asked to advance by 0 bytes.
>
> Let's restore the code that was there before commit b8c06ad4d67d
> ("vringh: implement vringh_kiov_advance()"), avoiding using
> vringh_kiov_advance().
>
> Fixes: b8c06ad4d67d ("vringh: implement vringh_kiov_advance()")
> Cc: stable@vger.kernel.org
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vhost/vringh.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
> index 955d938eb663..7b8fd977f71c 100644
> --- a/drivers/vhost/vringh.c
> +++ b/drivers/vhost/vringh.c
> @@ -123,8 +123,18 @@ static inline ssize_t vringh_iov_xfer(struct vringh =
*vrh,
>                 done +=3D partlen;
>                 len -=3D partlen;
>                 ptr +=3D partlen;
> +               iov->consumed +=3D partlen;
> +               iov->iov[iov->i].iov_len -=3D partlen;
> +               iov->iov[iov->i].iov_base +=3D partlen;
>
> -               vringh_kiov_advance(iov, partlen);
> +               if (!iov->iov[iov->i].iov_len) {
> +                       /* Fix up old iov element then increment. */
> +                       iov->iov[iov->i].iov_len =3D iov->consumed;
> +                       iov->iov[iov->i].iov_base -=3D iov->consumed;
> +
> +                       iov->consumed =3D 0;
> +                       iov->i++;
> +               }
>         }
>         return done;
>  }
> --
> 2.41.0
>

