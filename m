Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625D9758590
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGRTbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGRTbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:31:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC76198E;
        Tue, 18 Jul 2023 12:31:12 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso93029531fa.0;
        Tue, 18 Jul 2023 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689708670; x=1692300670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTrSAnnMNi3CJrN72jg6c2jFERcFPh+1lB6HHppzE2o=;
        b=YstOd1W6X1vyeMfDJmOipRaiIKM3IzxuY+kVIN/FOQeM6+H/CIXHfev4VHYQDS7zaR
         0kkXOJNSctTui42cWYPOOZUpWLOsizTbde2fZeUuqjApV9AYOBavHGPoqPjEihsrceJ9
         MU3Z0Ghyv+GV5CnWqWUaOH6UijQkEiUHlOEkacpTf5roK4x3DanRGNJCVFPQ9fNmrMqK
         X4PF/vBNHywJmm+QqMtWs9Y1kHdK5fNHP98DS6PeU48OWxFWe3UTfXSMGN9llTvi3cey
         /1/1VQeRp1rh86mVF3atw9KlljWG1Yi6ZdEKQZmHZgtt/T4iHKVnul9V8byJrn+GPu4n
         VglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689708670; x=1692300670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTrSAnnMNi3CJrN72jg6c2jFERcFPh+1lB6HHppzE2o=;
        b=SFHhAqwEmoy63AGN3qkHJ1jfr7mYtHCwUFT+URt1EE6BpUkzWHtuRQizTnS/b14Oh8
         bGXRnv0dYUl9aOPxauhLcmc+ARd6J5NfdmGaiVKyY4W4VcPwdXrgx1K1CET/EsuWhL5Z
         aC3lmXmjwf2KCdfagYzKfV/0D1l3YRUbAygP8x87UHK4jezxkfTDRFEBPiLTO17LXp+y
         pAMEFeHXBGhlkBAJexqHxPCJ68qzaPNKJBQe4ijpVLku4SO8lDecFNOcWYKFG6AIuyyJ
         yzRy/eCcVWlbzquAULwKB6LOgO5rK4LWxrmSdqpMsP50ppjOsdRTBOHjmxL400KHK8HA
         jifg==
X-Gm-Message-State: ABy/qLYv4gx4IwIOjH74jfoCCqqI+O0lRYMIplKCVXoCgAqzywirTwpm
        Bc3tb5dEk267RWDUhXvPrpZv1nDpmmFFd38UNCyDfkVq
X-Google-Smtp-Source: APBJJlHI4rX84tOEoaXYW/2w4q01fgbrq4MG7euNNK4/ARs8hVqH6cIsj+6x6vLLQZutSVqnnyi3aTO0pVXh+qr52LY=
X-Received: by 2002:a2e:b611:0:b0:2b7:2066:10e1 with SMTP id
 r17-20020a2eb611000000b002b7206610e1mr11095537ljn.0.1689708670027; Tue, 18
 Jul 2023 12:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
In-Reply-To: <5cbde2b4-69b5-4b25-a095-251c8347cb09@kili.mountain>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 18 Jul 2023 12:30:57 -0700
Message-ID: <CABBYNZK5MfkOSVUBtWLOLt+H-BBdYrQbZv=rmYtn4WtDyvJopw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: clean up some casts
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Mon, Jul 17, 2023 at 3:20=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The ERR_PTR/PTR_ERR() functions are only for error pointers.  They're
> not a generic way to cast pointers to int.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> We should really create INT_PTR/PTR_INT() functions.  But this is a
> cleanup until someone creates those.

Is there any reason you didn't create such macros? I mean we could
have it local first, or perhaps we just do HANDLE_PTR/PTR_HANDLE to
avoid any confusion.

>  net/bluetooth/hci_conn.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cccc2b8b60a8..aea6fa12d954 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -873,7 +873,7 @@ static void bis_cleanup(struct hci_conn *conn)
>
>  static int remove_cig_sync(struct hci_dev *hdev, void *data)
>  {
> -       u8 handle =3D PTR_ERR(data);
> +       u8 handle =3D (unsigned long)data;
>
>         return hci_le_remove_cig_sync(hdev, handle);
>  }
> @@ -882,7 +882,7 @@ static int hci_le_remove_cig(struct hci_dev *hdev, u8=
 handle)
>  {
>         bt_dev_dbg(hdev, "handle 0x%2.2x", handle);
>
> -       return hci_cmd_sync_queue(hdev, remove_cig_sync, ERR_PTR(handle),=
 NULL);
> +       return hci_cmd_sync_queue(hdev, remove_cig_sync, (void *)(unsigne=
d long)handle, NULL);
>  }
>
>  static void find_cis(struct hci_conn *conn, void *data)
> @@ -1234,7 +1234,7 @@ void hci_conn_failed(struct hci_conn *conn, u8 stat=
us)
>  static void create_le_conn_complete(struct hci_dev *hdev, void *data, in=
t err)
>  {
>         struct hci_conn *conn;
> -       u16 handle =3D PTR_ERR(data);
> +       u16 handle =3D (unsigned long)data;
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (!conn)
> @@ -1264,7 +1264,7 @@ static void create_le_conn_complete(struct hci_dev =
*hdev, void *data, int err)
>  static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn;
> -       u16 handle =3D PTR_ERR(data);
> +       u16 handle =3D (unsigned long)data;
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (!conn)
> @@ -2854,7 +2854,7 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
>  static int abort_conn_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn;
> -       u16 handle =3D PTR_ERR(data);
> +       u16 handle =3D (unsigned long)data;
>
>         conn =3D hci_conn_hash_lookup_handle(hdev, handle);
>         if (!conn)
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
