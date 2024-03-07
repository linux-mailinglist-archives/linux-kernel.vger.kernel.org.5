Return-Path: <linux-kernel+bounces-95971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593FC875583
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F28A1F218D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9913173E;
	Thu,  7 Mar 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9eY9P8G"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DB12FB2B;
	Thu,  7 Mar 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833743; cv=none; b=QlUPijXGlEAuY8A1xdq7h5pvGNMrOjxQuSRAwZBF4r3Nno8fWJAmHOzFKFzCIkkxCxPcvpPOk/+8JcesXM7TedJs+tjlko5uR7oy6j0F3cYWNj1zJjVtmIPrTQW608ZUQjizrhMOpFl5uu2TFP+bUtWPJLreZWL+NkO0gKRzzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833743; c=relaxed/simple;
	bh=SWaaB0XQCIhzAS6EmdUMQf+lLQWEmTzrwTE2/ASS73A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbUPgOgRq8h8XoeitHtziEpt2PIMU7lJdmLHyB1OIcsCJO3T9WJuUsbBJ2hxyiCekXw6wi8yhbO+im0qDh5gBN+Gfhp9kwBgrYJKGABW0uPZbGTk8kfnjT1UEESmQ+MerDOLhC0cU2F22E0x/AFq3cLozCNeMkaY1sLmsZ9XCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9eY9P8G; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42ee7fa077bso5066731cf.3;
        Thu, 07 Mar 2024 09:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709833741; x=1710438541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3azFskcK1Kr594pn4cAjp31V8LFrQG4+hgU7A9RDIXk=;
        b=L9eY9P8GPvIGZ/1AOuhnZEwuBhpYq56SeoWY1rLiw87s+jgS3BBHoi7yJvP1jgb++y
         s8vK3J4LizPptbc+OgZ/o0E+xHvH9rcCNXde+hMRqFjdtj4DGF+ep+iMSkxkbXXEFxrv
         AeqYtGINbZrwyeExt2bzwDETTVUsYViEI7umLKHjQgX7HjdwSPLgVBDpT7vTFOp6s//T
         GdlGxEwbma+TjI5bN+Lk+5kVfM+bSO//fP77Deq8RLZGaUulVp1PQX8r3amZ5r7hKNza
         vzDYa/aRVSrgDwq5/nE7sWvgswRUcqiHnUzisfEnKRUgGN+aSoS60hafHd3GBrmkVK5O
         Ju5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833741; x=1710438541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3azFskcK1Kr594pn4cAjp31V8LFrQG4+hgU7A9RDIXk=;
        b=EhxOCExzdQjIEW+Qq6EiHvdRQgACrBDPsGyaSNEsr63ZoHkzjFWvTqK5bqvoQfF1sQ
         L3aLA60Td+5iPW6lzWk/dGWEb89fUbv9OvHN4izFRTkXtLKfyxZjgkTVtyu7A509tTD1
         8A9jzC8kePe/p7kmMxm0CRNl0YrD8mP+Lhf44bUyA0jacMMerpwYLUg0MmRqBZqDBlft
         rW8/2M3pcFAKFGcf7+VbEwuxD2qlyeQT9WVM/GAqAO08aEeYphQtPOcfW/71LiSvUuo2
         bmfGCMXwfx+e3vZ88NcPdyMO1uvq2hUHEIST94xZ+i1UrmS1OpiohIOo3Mu1EMPtrjwk
         Y1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXTwBU+83xKFF1EzF8veIrgJ/zYBqEbjN0csQXidimZay5WRidUowZ3mI/VEEEq4fv5l7+fuf7L7CAsOFnoMrCUMY/dpCwbbu8fuSGywDGHxVwNly91p4AiYjleNHThsUD370jkmqTrX/U1w3b52MHyM9mBKoPpAp
X-Gm-Message-State: AOJu0YxMIw2eZhgdYm9nZ+2rZKeKYMmuXVr+linQ4Rit+DfOhKSMqs63
	BIrikzMJeF2hyZ4qSXFVxxM52MVmeNAVJe2pNiOfnpGN6U16GYeb4QN7GWWI17lrWawSg+2Z9Zu
	xOYlXzemiM/WbeoPzaYjTQ8SkPKksMU1OLV3fGw==
X-Google-Smtp-Source: AGHT+IFtJCet5o1lyZnRcTyn4EgVIYVJsxWpjc8YqORCDIgVR49weziOGhMcQg3AfHy5K2m4sfmNZwGAEqxGK2ey/9E=
X-Received: by 2002:a05:622a:15d6:b0:42e:da48:fbb3 with SMTP id
 d22-20020a05622a15d600b0042eda48fbb3mr8812751qty.41.1709833740937; Thu, 07
 Mar 2024 09:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeiNxaq3jzloO9l6@boxer> <20240307142402.906681-1-dgouarin@gmail.com>
 <ZenidKFF/gQefijz@boxer>
In-Reply-To: <ZenidKFF/gQefijz@boxer>
From: david gouarin <dgouarin@gmail.com>
Date: Thu, 7 Mar 2024 18:48:50 +0100
Message-ID: <CAH3uZAwOBeuV9FQpFJ5-S-j5HDWpxR5vvXKzUoq_UTOenz6=XQ@mail.gmail.com>
Subject: Re: [PATCH net v2] dpaa_eth: fix XDP queue index
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: david.gouarin@thalesgroup.com, Madalin Bucur <madalin.bucur@nxp.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Camelia Groza <camelia.groza@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 7 mars 2024 =C3=A0 16:51, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> a =C3=A9crit :
>
> On Thu, Mar 07, 2024 at 03:24:02PM +0100, David Gouarin wrote:
> > Make it possible to bind a XDP socket to a queue id.
> > The DPAA FQ Id was passed to the XDP program in the XDP packet metadata
> > which made it unusable with bpf_map_redirect.
>
> I think that referring to a member from xdp_rxq_info struct as 'packet
> metadata' is confusing. I was trying to find a place where you are
> actually storing this id at xdp_buff::data_meta. This is not happening
> AFAICT. Thing is that xsk_rcv_check() picks xdp->rxq->queue_index which
> holds fqid which is not related to queue number, right?

Correct. I have used the term xdp metadata because that is the terminology
used in the xdp program (struct xdp_md).
I should have said instead :
The DPAA FQ Id was passed to the XDP program in the xdp_rxq_info->queue_ind=
ex
instead of the queue number [...]

Maciej please forgive me for the double send and formatting mistakes,
kernel mailing lists are new to me.

>
> > Instead of the DPAA FQ Id, initialise the XDP rx queue with the channel=
 id.
> >
> > Fixes: d57e57d0cd04 ("dpaa_eth: add XDP_TX support")
> >
> > Signed-off-by: David Gouarin <dgouarin@gmail.com>
> > ---
> > v2: add Fixes: in description
> > ---
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/n=
et/ethernet/freescale/dpaa/dpaa_eth.c
> > index dcbc598b11c6..988dc9237368 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -1154,7 +1154,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, =
bool td_enable)
> >       if (dpaa_fq->fq_type =3D=3D FQ_TYPE_RX_DEFAULT ||
> >           dpaa_fq->fq_type =3D=3D FQ_TYPE_RX_PCD) {
> >               err =3D xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_=
dev,
> > -                                    dpaa_fq->fqid, 0);
> > +                                    dpaa_fq->channel, 0);
> >               if (err) {
> >                       dev_err(dev, "xdp_rxq_info_reg() =3D %d\n", err);
> >                       return err;
> > --
> > 2.34.1
> >

