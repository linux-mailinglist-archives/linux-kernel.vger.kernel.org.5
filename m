Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550A67B0280
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjI0LNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjI0LNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:13:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1B13A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:13:13 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41958410e5cso550151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695813192; x=1696417992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3T0uZM81nh3MMMeHJ0x5DLvTiX2DwUPL7g6/tO7DRc=;
        b=P2TCvwtaihwVYoXCO/s5A+oQmNqWiAJYQ7bIcJS9ylkXHxLfhQNQFqtM9fwB8f5LiB
         gsFGX4Msi8YNfpkgxTbGuQKWzRWFT+kJmJdZdjomKd5Z0oamGymZHxTKfkLs+5t06Zjt
         n4J/15j/Wqwcns9QYBSclWrVb3f8Aa2F10OekCqD73wrk0O+YNVaNtViHJkE8/5x9gHn
         SxC+/4zh9bvsMvqUl7EORzLHG5C1C/ocVgj4bqQxtrb45FMKA6JguhKyCl3ebpIv+R4y
         Cpsw9n+LYpxkIeWXk0iiR29JXpS9B16vpA/a41piyyJUXxWco/5McAcQjNS35YUAqs5v
         L07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813192; x=1696417992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q3T0uZM81nh3MMMeHJ0x5DLvTiX2DwUPL7g6/tO7DRc=;
        b=glX7Dq5YRcb/DmDH9dHEbXYLN84zIVSsgghVxVGfZd4rK3kijbdWjYLxC0qXCSlKuS
         bky/VWMPP+PJhctMj48Pjo6JsxuLgU/Xkm2gzXbewg2vB7PthUqlIO11iunfUMI7sv2i
         EtXYJJj3WSQwHX/jFgqrR/aPnBhLxah8Uztpz0GomMV5JpLCYCN+p7BD171wVn6SNdXa
         9f+a5GT0dTEwjrjo9il/Us/NG7aP8eMndlbtujslZLcVNDz381yzArpGcjLGwfj6bc/D
         zH72rVXk+v6r/yU6Ei5050L2/get2aHWfC2r0KxtGJI3gyQhk4asHQwwlebTshBJ/xKR
         U4dA==
X-Gm-Message-State: AOJu0YyYxqvvt7tlfKfZPXEdSJdHq+p5eNzNkDZVfokBmPW3H3J8O4Cc
        7WxIlteSDsvUml9418o8PvQk5zOvW9SS/S7Mwp5m9g==
X-Google-Smtp-Source: AGHT+IGlYUe+ty9S5L6G+a9UM05DUyiLGpED/5fz3M2kc6vqSgpuXjGJtjhwJ7K3Ne82Jhis9uR7jvtLWCq4xjMbd2I=
X-Received: by 2002:ac8:7d0b:0:b0:410:653f:90e8 with SMTP id
 g11-20020ac87d0b000000b00410653f90e8mr535228qtb.11.1695813192307; Wed, 27 Sep
 2023 04:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230927105858.12950-1-quic_kriskura@quicinc.com>
In-Reply-To: <20230927105858.12950-1-quic_kriskura@quicinc.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Wed, 27 Sep 2023 04:13:00 -0700
Message-ID: <CANP3RGd1ZzQXE2-kDDNyfxuLZCDYoJKJQ-2uBsq++StqTDkCRg@mail.gmail.com>
Subject: Re: [PATCH v4] usb: gadget: ncm: Handle decoding of multiple NTB's in
 unwrap call
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 3:59=E2=80=AFAM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> When NCM is used with hosts like Windows PC, it is observed that there ar=
e
> multiple NTB's contained in one usb request giveback. Since the driver
> unwraps the obtained request data assuming only one NTB is present, we
> loose the subsequent NTB's present resulting in data loss.
>
> Fix this by checking the parsed block length with the obtained data
> length in usb request and continue parsing after the last byte of current
> NTB.
>
> Cc: stable@vger.kernel.org
> Fixes: 9f6ce4240a2b ("usb: gadget: f_ncm.c added")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Changes in v4: Replaced void* with __le16* typecast for tmp variable
> Changes in v3: Removed explicit void* typecast for ntb_ptr variable
>
>  drivers/usb/gadget/function/f_ncm.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/fun=
ction/f_ncm.c
> index 424bb3b666db..faf90a217419 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1171,7 +1171,8 @@ static int ncm_unwrap_ntb(struct gether *port,
>                           struct sk_buff_head *list)
>  {
>         struct f_ncm    *ncm =3D func_to_ncm(&port->func);
> -       __le16          *tmp =3D (void *) skb->data;
> +       unsigned char   *ntb_ptr =3D skb->data;
> +       __le16          *tmp;
>         unsigned        index, index2;
>         int             ndp_index;
>         unsigned        dg_len, dg_len2;
> @@ -1184,6 +1185,10 @@ static int ncm_unwrap_ntb(struct gether *port,
>         const struct ndp_parser_opts *opts =3D ncm->parser_opts;
>         unsigned        crc_len =3D ncm->is_crc ? sizeof(uint32_t) : 0;
>         int             dgram_counter;
> +       int             to_process =3D skb->len;
> +
> +parse_ntb:
> +       tmp =3D (__le16 *)ntb_ptr;
>
>         /* dwSignature */
>         if (get_unaligned_le32(tmp) !=3D opts->nth_sign) {
> @@ -1230,7 +1235,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>                  * walk through NDP
>                  * dwSignature
>                  */
> -               tmp =3D (void *)(skb->data + ndp_index);
> +               tmp =3D (__le16 *)(ntb_ptr + ndp_index);
>                 if (get_unaligned_le32(tmp) !=3D ncm->ndp_sign) {
>                         INFO(port->func.config->cdev, "Wrong NDP SIGN\n")=
;
>                         goto err;
> @@ -1287,11 +1292,11 @@ static int ncm_unwrap_ntb(struct gether *port,
>                         if (ncm->is_crc) {
>                                 uint32_t crc, crc2;
>
> -                               crc =3D get_unaligned_le32(skb->data +
> +                               crc =3D get_unaligned_le32(ntb_ptr +
>                                                          index + dg_len -
>                                                          crc_len);
>                                 crc2 =3D ~crc32_le(~0,
> -                                                skb->data + index,
> +                                                ntb_ptr + index,
>                                                  dg_len - crc_len);
>                                 if (crc !=3D crc2) {
>                                         INFO(port->func.config->cdev,
> @@ -1318,7 +1323,7 @@ static int ncm_unwrap_ntb(struct gether *port,
>                                                          dg_len - crc_len=
);
>                         if (skb2 =3D=3D NULL)
>                                 goto err;
> -                       skb_put_data(skb2, skb->data + index,
> +                       skb_put_data(skb2, ntb_ptr + index,
>                                      dg_len - crc_len);
>
>                         skb_queue_tail(list, skb2);
> @@ -1331,10 +1336,17 @@ static int ncm_unwrap_ntb(struct gether *port,
>                 } while (ndp_len > 2 * (opts->dgram_item_len * 2));
>         } while (ndp_index);
>
> -       dev_consume_skb_any(skb);
> -
>         VDBG(port->func.config->cdev,
>              "Parsed NTB with %d frames\n", dgram_counter);
> +
> +       to_process -=3D block_len;
> +       if (to_process !=3D 0) {
> +               ntb_ptr =3D (unsigned char *)(ntb_ptr + block_len);
> +               goto parse_ntb;
> +       }
> +
> +       dev_consume_skb_any(skb);
> +
>         return 0;
>  err:
>         skb_queue_purge(list);
> --
> 2.42.0

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
