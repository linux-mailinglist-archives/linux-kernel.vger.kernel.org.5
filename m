Return-Path: <linux-kernel+bounces-121656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5A188EBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B679629A9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D86314D6F9;
	Wed, 27 Mar 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGtFmWoq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36145149E1A;
	Wed, 27 Mar 2024 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558567; cv=none; b=Jt93xgPR8itQMZaE9RMVQtnRkgFD7GFrsjFg6deQmhGKtehTjkBl2d5m0ug3ajeqjz9XInRJyp/AfB4qjWgOh7MpaeYkPrxmME8mIcrVjDL2epGwhURfQtIC6H3TWMxDJ5/oFx24xmicGK8SGDuy5wJvJLrv+ZA4H7Tafwv01G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558567; c=relaxed/simple;
	bh=L78l5HV6r6FvAq0ammCKTqc3oUxKocapFhHEKjY00Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flS3CIYKZtpjwxPOCYWVlJo+wH7zqyHrDTpPiPe9jxpJQ2LMd4JYlbCharhkStoeJeGa6tJ/yLJ5sLYW++BImpeFXLKS/t5RahWtjQ9i2DFE+VfNAI1x60TL2wqGpnKiSCETj/l+muLE9lU+nm2cgVDNUTpiJwaItmyJVsGkIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGtFmWoq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so91077191fa.0;
        Wed, 27 Mar 2024 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711558563; x=1712163363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyBhgXGV/r7A7I3H1G+vTu3S7hP/dCUL8SoTG8bF7gk=;
        b=AGtFmWoqwmXTks/oub1gy6nlz8WwylMJlaDBLbTFGBzV1Oi3OegSO6s1eFuob7kZv2
         YpviDzpU0CRCqaZu8Cvc/++pA+Wv4H+ZyohQ3lbuanwx1DVR4EmGJrXQHzefwsMu5NGy
         h5sFqv6vehHohpzKKbd/s+YbfE8LTVrfD31d9lVYWHR0SWEeLM5kvC2t+i7d5G548NRP
         7axXYFof7EfdC+JH/T82iLBwtwdrGy5XgdfmUYYOu9DAEU5GwiHNW9Ko4gOxo3XwP70A
         YU5mEWcxCbFt/jCWQxVqpELdtRpKmEwbaWwWyS9H5OrijTk7bJDrXfNp3qwganpfphdT
         SvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711558563; x=1712163363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyBhgXGV/r7A7I3H1G+vTu3S7hP/dCUL8SoTG8bF7gk=;
        b=Voa3DnssEUDCvzQb52jG3az0XoihXRh7VFMehrGbr5OatmacL1BjSE/JsWjR48If2N
         A4uLPMwLRx37YFW2AP7xOONT/qqm8aX4coyOHt9/+gQ5s5VU/Gb6vh6WwyuykvMDWV6I
         AtzpOVTyJZPoJqM+0OBg80spbM6byZ+1cs+evZdUUkn8E3yu5LclXt8UEgK75/+OBOai
         uPBpd6Nd0slRNfupKVdXrlwoncw92ghTIEk0zRmQSLvNb6CT4NLw3DDi6hyCvhstjbBA
         jqlrM8bz2L573J8qQ/nLVZ2zFk80wmtT2DOpQ0b3FT4ebRnm7XQBdCFXgmaBPacanYrb
         HLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI4DprzihZF2IslTJakQqZHvz4zG1/OXadzPalMaB7NIZbTj9pMNenrjD/JXjTxqTbj8I/XGu0jQibq86ClE0Xi6KtcRaZsBIqxwHDjBW0LFpNbpqgEMLoTBSrphqXucyDM9ULoSivf44f2Pvh+u1KW15Nh0YQ0oLOQrR6DM9WCMPd6O9AdYAaRtnvRit3tv0ujQwyV8/BInIEE6EptBq/he/4lo0b
X-Gm-Message-State: AOJu0YxeLPyztFgJI9H/SVCYazY1gxdDUeN9UVIcA1aqqjHFpJadpir6
	8B6t+oROiDef97qnYl3YSJ/HYaWryfLsGimdxI8XKa+4jJOIoxw9kKnCmYAfXuuZaqvYlgSTYgc
	Lc+yMirKzJU9xGPeQ07Pm+0aOU2Q=
X-Google-Smtp-Source: AGHT+IHgkl+xfw6U0Pi6v9QP9YmxuYstHmaIne8ORlpeS/0ZFtRzCIoh2DRawH7RG84PM8PiO3jIWeSsohP5NpYcv6U=
X-Received: by 2002:a05:651c:124c:b0:2d6:b582:58b8 with SMTP id
 h12-20020a05651c124c00b002d6b58258b8mr443482ljh.52.1711558562772; Wed, 27 Mar
 2024 09:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgRIF1bkXlZlaK22@neat>
In-Reply-To: <ZgRIF1bkXlZlaK22@neat>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Mar 2024 12:55:49 -0400
Message-ID: <CABBYNZLi_PCbRB6CVYxwOG04917tDudMvuVT1NU3LVth=xpCtw@mail.gmail.com>
Subject: Re: [PATCH v2][next] Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
 warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Wed, Mar 27, 2024 at 12:23=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.

Which tree is this base on, I just rebased bluetooth-next on top of
net-next but it looks like CI is still failing to build it, so either
we don't have all the dependencies already in net-next or perhaps you
had it submit while the tree had not been updated.

> There are currently a couple of objects (`req` and `rsp`), in a couple
> of structures, that contain flexible structures (`struct l2cap_ecred_conn=
_req`
> and `struct l2cap_ecred_conn_rsp`), for example:
>
> struct l2cap_ecred_rsp_data {
>         struct {
>                 struct l2cap_ecred_conn_rsp rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;
>         int count;
> };
>
> in the struct above, `struct l2cap_ecred_conn_rsp` is a flexible
> structure:
>
> struct l2cap_ecred_conn_rsp {
>         __le16 mtu;
>         __le16 mps;
>         __le16 credits;
>         __le16 result;
>         __le16 dcid[];
> };
>
> So, in order to avoid ending up with a flexible-array member in the
> middle of another structure, we use the `struct_group_tagged()` (and
> `__struct_group()` when the flexible structure is `__packed`) helper
> to separate the flexible array from the rest of the members in the
> flexible structure:
>
> struct l2cap_ecred_conn_rsp {
>         struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
>
>         ... the rest of members
>
>         );
>         __le16 dcid[];
> };
>
> With the change described above, we now declare objects of the type of
> the tagged struct, in this example `struct l2cap_ecred_conn_rsp_hdr`,
> without embedding flexible arrays in the middle of other structures:
>
> struct l2cap_ecred_rsp_data {
>         struct {
>                 struct l2cap_ecred_conn_rsp_hdr rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;
>         int count;
> };
>
> Also, when the flexible-array member needs to be accessed, we use
> `container_of()` to retrieve a pointer to the flexible structure.
>
> We also use the `DEFINE_RAW_FLEX()` helper for a couple of on-stack
> definitions of a flexible structure where the size of the flexible-array
> member is known at compile-time.
>
> So, with these changes, fix the following warnings:
> net/bluetooth/l2cap_core.c:1260:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:3740:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:4999:45: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
> net/bluetooth/l2cap_core.c:7116:47: warning: structure containing a flexi=
ble array member is not at the end of another structure [-Wflex-array-membe=
r-not-at-end]
>
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Add a couple of code comments.
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZgMpynzZ8FltPCi3@neat/
>
> Hi!
>
> I wonder if `struct l2cap_ecred_conn_rsp` should also be `__packed`.
>
> Thanks
>  - Gustavo
>
>  include/net/bluetooth/l2cap.h | 22 +++++++++++------
>  net/bluetooth/l2cap_core.c    | 46 ++++++++++++++++-------------------
>  2 files changed, 35 insertions(+), 33 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index a4278aa618ab..7d4a3e766e7b 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -463,18 +463,24 @@ struct l2cap_le_credits {
>  #define L2CAP_ECRED_MAX_CID            5
>
>  struct l2cap_ecred_conn_req {
> -       __le16 psm;
> -       __le16 mtu;
> -       __le16 mps;
> -       __le16 credits;
> +       /* New members must be added within the struct_group() macro belo=
w. */
> +       __struct_group(l2cap_ecred_conn_req_hdr, hdr, __packed,
> +               __le16 psm;
> +               __le16 mtu;
> +               __le16 mps;
> +               __le16 credits;
> +       );
>         __le16 scid[];
>  } __packed;
>
>  struct l2cap_ecred_conn_rsp {
> -       __le16 mtu;
> -       __le16 mps;
> -       __le16 credits;
> -       __le16 result;
> +       /* New members must be added within the struct_group() macro belo=
w. */
> +       struct_group_tagged(l2cap_ecred_conn_rsp_hdr, hdr,
> +               __le16 mtu;
> +               __le16 mps;
> +               __le16 credits;
> +               __le16 result;
> +       );
>         __le16 dcid[];
>  };
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 467b242d8be0..bf087eca489e 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1257,7 +1257,7 @@ static void l2cap_le_connect(struct l2cap_chan *cha=
n)
>
>  struct l2cap_ecred_conn_data {
>         struct {
> -               struct l2cap_ecred_conn_req req;
> +               struct l2cap_ecred_conn_req_hdr req;
>                 __le16 scid[5];
>         } __packed pdu;
>         struct l2cap_chan *chan;
> @@ -3737,7 +3737,7 @@ static void l2cap_ecred_list_defer(struct l2cap_cha=
n *chan, void *data)
>
>  struct l2cap_ecred_rsp_data {
>         struct {
> -               struct l2cap_ecred_conn_rsp rsp;
> +               struct l2cap_ecred_conn_rsp_hdr rsp;
>                 __le16 scid[L2CAP_ECRED_MAX_CID];
>         } __packed pdu;
>         int count;
> @@ -3746,6 +3746,8 @@ struct l2cap_ecred_rsp_data {
>  static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
>  {
>         struct l2cap_ecred_rsp_data *rsp =3D data;
> +       struct l2cap_ecred_conn_rsp *rsp_flex =3D
> +               container_of(&rsp->pdu.rsp, struct l2cap_ecred_conn_rsp, =
hdr);
>
>         if (test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
>                 return;
> @@ -3755,7 +3757,7 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan=
 *chan, void *data)
>
>         /* Include all channels pending with the same ident */
>         if (!rsp->pdu.rsp.result)
> -               rsp->pdu.rsp.dcid[rsp->count++] =3D cpu_to_le16(chan->sci=
d);
> +               rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
>         else
>                 l2cap_chan_del(chan, ECONNRESET);
>  }
> @@ -4995,10 +4997,7 @@ static inline int l2cap_ecred_conn_req(struct l2ca=
p_conn *conn,
>                                        u8 *data)
>  {
>         struct l2cap_ecred_conn_req *req =3D (void *) data;
> -       struct {
> -               struct l2cap_ecred_conn_rsp rsp;
> -               __le16 dcid[L2CAP_ECRED_MAX_CID];
> -       } __packed pdu;
> +       DEFINE_RAW_FLEX(struct l2cap_ecred_conn_rsp, pdu, dcid, L2CAP_ECR=
ED_MAX_CID);
>         struct l2cap_chan *chan, *pchan;
>         u16 mtu, mps;
>         __le16 psm;
> @@ -5017,7 +5016,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>         cmd_len -=3D sizeof(*req);
>         num_scid =3D cmd_len / sizeof(u16);
>
> -       if (num_scid > ARRAY_SIZE(pdu.dcid)) {
> +       if (num_scid > L2CAP_ECRED_MAX_CID) {
>                 result =3D L2CAP_CR_LE_INVALID_PARAMS;
>                 goto response;
>         }
> @@ -5046,7 +5045,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>
>         BT_DBG("psm 0x%2.2x mtu %u mps %u", __le16_to_cpu(psm), mtu, mps)=
;
>
> -       memset(&pdu, 0, sizeof(pdu));
> +       memset(pdu, 0, sizeof(*pdu));
>
>         /* Check if we have socket listening on psm */
>         pchan =3D l2cap_global_chan_by_psm(BT_LISTEN, psm, &conn->hcon->s=
rc,
> @@ -5072,8 +5071,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap=
_conn *conn,
>
>                 BT_DBG("scid[%d] 0x%4.4x", i, scid);
>
> -               pdu.dcid[i] =3D 0x0000;
> -               len +=3D sizeof(*pdu.dcid);
> +               pdu->dcid[i] =3D 0x0000;
> +               len +=3D sizeof(*pdu->dcid);
>
>                 /* Check for valid dynamic CID range */
>                 if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN=
_END) {
> @@ -5107,13 +5106,13 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>
>                 /* Init response */
> -               if (!pdu.rsp.credits) {
> -                       pdu.rsp.mtu =3D cpu_to_le16(chan->imtu);
> -                       pdu.rsp.mps =3D cpu_to_le16(chan->mps);
> -                       pdu.rsp.credits =3D cpu_to_le16(chan->rx_credits)=
;
> +               if (!pdu->credits) {
> +                       pdu->mtu =3D cpu_to_le16(chan->imtu);
> +                       pdu->mps =3D cpu_to_le16(chan->mps);
> +                       pdu->credits =3D cpu_to_le16(chan->rx_credits);
>                 }
>
> -               pdu.dcid[i] =3D cpu_to_le16(chan->scid);
> +               pdu->dcid[i] =3D cpu_to_le16(chan->scid);
>
>                 __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>
> @@ -5135,13 +5134,13 @@ static inline int l2cap_ecred_conn_req(struct l2c=
ap_conn *conn,
>         l2cap_chan_put(pchan);
>
>  response:
> -       pdu.rsp.result =3D cpu_to_le16(result);
> +       pdu->result =3D cpu_to_le16(result);
>
>         if (defer)
>                 return 0;
>
>         l2cap_send_cmd(conn, cmd->ident, L2CAP_ECRED_CONN_RSP,
> -                      sizeof(pdu.rsp) + len, &pdu);
> +                      sizeof(*pdu) + len, pdu);
>
>         return 0;
>  }
> @@ -7112,14 +7111,11 @@ EXPORT_SYMBOL_GPL(l2cap_chan_connect);
>  static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
>  {
>         struct l2cap_conn *conn =3D chan->conn;
> -       struct {
> -               struct l2cap_ecred_reconf_req req;
> -               __le16 scid;
> -       } pdu;
> +       DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
>
> -       pdu.req.mtu =3D cpu_to_le16(chan->imtu);
> -       pdu.req.mps =3D cpu_to_le16(chan->mps);
> -       pdu.scid    =3D cpu_to_le16(chan->scid);
> +       pdu->mtu =3D cpu_to_le16(chan->imtu);
> +       pdu->mps =3D cpu_to_le16(chan->mps);
> +       pdu->scid[0] =3D cpu_to_le16(chan->scid);
>
>         chan->ident =3D l2cap_get_ident(conn);
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

