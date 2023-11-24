Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F27F69BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjKXATu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjKXATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:19:47 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D9010E5;
        Thu, 23 Nov 2023 16:19:54 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41eae4f0ee6so6453571cf.3;
        Thu, 23 Nov 2023 16:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700785193; x=1701389993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRrczTl2dmji0BpEcvz0ytvI2sxamQ/CJSEn/YlePo4=;
        b=OK1gypCIzXSDDX6WZQfUkip686LfFNu1yKUzifrbEORw63Pouq6niyzuThPUZiUoEJ
         X4MsRu0oqpeXGKOxjlYT6M7N98i4m/X5IBee5azbW9X4e6vpwt0jKw9Oxi0MjRve7f/p
         0groLIcFcTxn33WAowBLVG7xzr/34R/c0pouM8XsMkTWJDGlun+aJ9DIb91C38HEDUeP
         vOepC/xr2ZxCZOiycZSaYut7h7lNlzhYY+ae9JfmTpcf+MehHb9zBv+bixTI3YjKNbNm
         BxQd1XjL5Ek1WqJSwTCq7EXJ+A3MZsG9iv04D5+w+s6GODgu0/QIQhePNmZe26uqIiX2
         g63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785193; x=1701389993;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xRrczTl2dmji0BpEcvz0ytvI2sxamQ/CJSEn/YlePo4=;
        b=vx9SPIqBdVm/MEQ2vVYehGIowSvW0dOv1DV1liEyviJTQhGdupn0fG7deWNoL9k0c6
         PC8bOPLZhvQ8fN+st3ILnfk7npUQyzuSIBHKzNKPuopc51udYp6SfPBEKJLObPgkcgrt
         ROcngAMGaDW0Pj87T+kwTVtljj6CsllYmLcZwxIGGLPpIY1YXLfiI9jIcn/nM2XFTFX9
         pov7eevdbzhlCoZvRDmy6lR+vvD9Pc9ntRFg8OeVJz7yuuBHNlAzltJE8xRPYSyEUr2D
         4Sb32bKB0J8yQ/Uyy0F+E2ctC1RqTlolyHsRn86lAq8ZPQNRWrN4AcL1h5bKiBMYeL74
         NeHw==
X-Gm-Message-State: AOJu0Yyqzmee6ok8vGjFvYhHSwCxpwIL9ESOrh0ixZ8AcnTjEP+CPNtm
        DsKuOKZRgLGb6/Xcnr2T9Bk=
X-Google-Smtp-Source: AGHT+IHVVFRNespoWFMVU0o5ntPVQqECOD7INgMy3+lvh/0VVYhjCsDYY8Dug08J1JmSNlupRfZcRA==
X-Received: by 2002:a05:622a:100d:b0:423:95ae:9b64 with SMTP id d13-20020a05622a100d00b0042395ae9b64mr952868qte.51.1700785193101;
        Thu, 23 Nov 2023 16:19:53 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id t2-20020ac87602000000b00421c272bcbasm849036qtq.11.2023.11.23.16.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:19:52 -0800 (PST)
Date:   Thu, 23 Nov 2023 19:19:52 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Mike Pattrick <mkp@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <655fec28a1c0f_db39d294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
References: <20231123183835.635210-1-mkp@redhat.com>
 <655fc32bb506e_d14d4294b3@willemb.c.googlers.com.notmuch>
 <CAHcdBH7h-sq=Gzkan1du3uxx44WibK0yzdnUcZCuw-mp=9OxOg@mail.gmail.com>
 <655fe8e5b5cf5_d9fc5294a0@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when
 virtio_net_hdr is enabled
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

Willem de Bruijn wrote:
> Mike Pattrick wrote:
> > On Thu, Nov 23, 2023 at 4:25=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Mike Pattrick wrote:
> > > > Af_packet provides checksum offload offsets to usermode applicati=
ons
> > > > through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on =
the
> > > > socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
> > > > af_packet will include the link level header and so csum_start ne=
eds
> > > > to be adjusted accordingly.
> > >
> > > Is this patch based on observing an incorrect offset in a workload,=

> > > or on code inspection?
> > =

> > Based on an incorrect offset in a workload. The setup involved sendin=
g
> > vxlan traffic though a veth interface configured with a vlan. The
> > vnet_hdr's csum_start value was off by 4, and this problem went away
> > when the vlan was removed.
> > =

> > I'll take another look at this patch.
> =

> This is a vlan device on top of a veth device? On which device and at
> which point (ingress or egress) are you receiving the packet over the
> packet socket?
> =

> From a quick glance, in all cases that I see the VLAN tag is kept in
> skb->vlan_tci, so is never part of the packet payload.
> =

> But checksum offload with VXLAN can be non-trivial on its own. If
> type & SKB_GSO_UDP_TUNNEL_CSUM | SKB_GSO_TUNNEL_REMCSUM, say. Then
> csum_start will point to the checksum in vxlanhdr.

This last statement is incorrect. But SKB_GSO_UDP_TUNNEL_CSUM might
be relevant to unexpected csum_start.

