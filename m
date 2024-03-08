Return-Path: <linux-kernel+bounces-97037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A312A8764BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FA8284D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C21EF0D;
	Fri,  8 Mar 2024 13:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pfj29tWJ"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320761D52B;
	Fri,  8 Mar 2024 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903255; cv=none; b=e/6jZF2jkQAKn/8jeT/BKcqVb11ERT095f6Ykfa5UdJu9J4IpsKoCs3vnG/K8bQoRRsq6QpGQdjkabsEGvzRMz2e6go5bVb00rkliIXMoRIp77zUtn0qhk7OpKaKy2Dypx+cPWQo2zW+gsO9AJKEAqLMKj//zUXeBh+IAvc+TOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903255; c=relaxed/simple;
	bh=+MwDkBXQYRMMznsSGyr3vHs61eQb5+gzl+EDA+0mKv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgWHXJmJOUfYqpFXh0XKphyq4J7rS0qkDaYKnufWlmBgTzDXXf5At5/bspm67IwoHMPXAqjOJoILNhitLKGSVfHocHVjRqcBo8obQGXXNFtO5ll1EkjUEtKzU2DCeW1gMy4NyLInNRf2aQzNCna61bFvBF+7iRV2LGenCCIzlHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pfj29tWJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56781070f38so5447957a12.0;
        Fri, 08 Mar 2024 05:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903251; x=1710508051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktcqcbp8TILmk6Ql94Pq2q2cmPwUg/4yXovkDsGT+eI=;
        b=Pfj29tWJYh+SI7doYriYwRJ8Q3MiSWl+AustIFWeHKWQ9FhVkvL9G2xDg5u8gr4o0S
         XfjxDapLj/ED0Ysh6K74Xqk8yqSoO8gyxjZTnMg+Q2XPV544OZJNlEUG92SCtV+3hsCd
         cWmya8YVdbthKTXo36Lb0Kf5kbrYlnMQB2VNT1QWcMRKd/4D4yudel31/Yo17fTEteJD
         C3to4H/nXD3FRVsUxIEq6xymbL7YztYFV6YghfzHYJLVvCxx6PGJ8Dk00549TlbrI6l1
         M15LO1qIlvMa+IQMbhUNvbZFgLD+2938drlkYx+dWH5pjcRMfbAytYwpwtYsq1ACDRoJ
         Z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903251; x=1710508051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktcqcbp8TILmk6Ql94Pq2q2cmPwUg/4yXovkDsGT+eI=;
        b=TGWbJLrWltzyO9ah0A/V1CqPA01BX5Vwcpg1d79v2xolBrdNqyqkgfgUEhl+6IL3y6
         5vTmZfqwjr06JJEXo7nsohrAJBcSVjMxPNbdqWdQzQjwMmXSw33TYc9ZAzj/YVBFaniJ
         vKQ+P7HOpGyTSl+IqtNf6z+xq95QV+uGgaoWoTHWM8D3r7X4hnjyIvLGyHbLjD/wyOXe
         FDfzCS3EUQG0YbSSREO5ulifrWePqTmYmQ+GjDK1sa/izf++LxNxFJBB04c3Rd853/JR
         +Od7Go76n1sh93PafALmEG9UW6HkgyQPBi5uCf5gvU3YLYV9htq9kDxKmsU1OI/10Z31
         DGMw==
X-Forwarded-Encrypted: i=1; AJvYcCXhp8TK1iFBVYTnU80Uu7i1TWUOfpcMNpQrCLhXkdWcLeLwM4etnfXETT4fSlMwykNUBDpo4zVBQjn+BRr2Gb3BZcj2gxdWU1x0khlaV7cTIeOHC4tvHvfuc/SopK4Z3Mz511p6
X-Gm-Message-State: AOJu0YwYFlOgjys3elVWuIygDDgEyU+9+fQlx9aItP3JaGJkbUnp3jqq
	lEmqADbo/VsDeUefUXKDpP/+rO1cDzUo9Pbfhsk+dA5Nw2efEBmAhl+sYoa2WxopFCngtaU1eSL
	qGWGzli9twPOI3mWighhVdaaCWMo=
X-Google-Smtp-Source: AGHT+IEg2pRZx7maZIvnMqccwSlBvyq8O4u7LnBiiwDvF8uxo5DHO77xhwIAjtnfCx+6bRv18IBJQE2cpzR24ue5m5s=
X-Received: by 2002:a17:906:a88d:b0:a45:f06:766 with SMTP id
 ha13-20020a170906a88d00b00a450f060766mr211006ejb.4.1709903251280; Fri, 08 Mar
 2024 05:07:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 8 Mar 2024 21:06:54 +0800
Message-ID: <CAL+tcoCsw0foaqr0Xh-JmWSV+NN=bLsyp+-LO=kpO4MbqKjRhw@mail.gmail.com>
Subject: Re: [PATCH net-next] net/packet: Add getsockopt support for PACKET_COPY_THRESH
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 7:43=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Juntong Deng wrote:
> > Currently getsockopt does not support PACKET_COPY_THRESH,
> > and we are unable to get the value of PACKET_COPY_THRESH
> > socket option through getsockopt.
> >
> > This patch adds getsockopt support for PACKET_COPY_THRESH.
> >
> > Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> > ---
> >  net/packet/af_packet.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 0db31ca4982d..65042edd1a97 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock,=
 int level, int optname,
> >       case PACKET_VNET_HDR_SZ:
> >               val =3D READ_ONCE(po->vnet_hdr_sz);
> >               break;
> > +     case PACKET_COPY_THRESH:
> > +             val =3D pkt_sk(sk)->copy_thresh;
> > +             break;
>
> This is probably a good opportunity to use READ_ONCE/WRITE_ONCE for
> this variable that can be modified and read concurrently.
>
> Alternatively I can fix up all three locations in a follow-on patch.

Yes, variables which can be set through setsockopt related functions
have a chance to be modified when another process does read it.

The patch you mentioned goes like this, I think:

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 0db31ca4982d..b598dcafe441 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb,
struct net_device *dev,
        }
        if (po->tp_version <=3D TPACKET_V2) {
                if (macoff + snaplen > po->rx_ring.frame_size) {
-                       if (po->copy_thresh &&
+                       if (READ_ONCE(po->copy_thresh) &&
                            atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf=
) {
                                if (skb_shared(skb)) {
                                        copy_skb =3D skb_clone(skb, GFP_ATO=
MIC);
@@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int
level, int optname, sockptr_t optval,
                if (copy_from_sockptr(&val, optval, sizeof(val)))
                        return -EFAULT;

-               pkt_sk(sk)->copy_thresh =3D val;
+               WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
                return 0;
        }
        case PACKET_VERSION:
diff --git a/net/packet/diag.c b/net/packet/diag.c
index b3bd2f6c2bf7..47f69f3dbf73 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -17,7 +17,7 @@ static int pdiag_put_info(const struct packet_sock
*po, struct sk_buff *nlskb)
        pinfo.pdi_index =3D po->ifindex;
        pinfo.pdi_version =3D po->tp_version;
        pinfo.pdi_reserve =3D po->tp_reserve;
-       pinfo.pdi_copy_thresh =3D po->copy_thresh;
+       pinfo.pdi_copy_thresh =3D READ_ONCE(po->copy_thresh);
        pinfo.pdi_tstamp =3D READ_ONCE(po->tp_tstamp);

        pinfo.pdi_flags =3D 0;

Thanks,
Jason

>
> No concerns with adding the getsockopt itself.
>
> >       case PACKET_VERSION:
> >               val =3D po->tp_version;
> >               break;
> > --
> > 2.39.2
> >
>
>
>

