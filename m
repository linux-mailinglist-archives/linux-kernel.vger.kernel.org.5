Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567217C9CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJPBTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:19:40 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33F3AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 18:19:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6744a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 18:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697419177; x=1698023977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycNhjCRFpUhksXsl43Gg/gmWjiI/q9jZ8V6D0q3J+8Y=;
        b=R4t/qqbBf+COGJh18xQQw6IwcLwoVtbnU/Q8cvMj84yaQzMtCxmupDKkG6m5jucZ8t
         cM5b9WNXvh4JE0TkN8yx/HvyGEHQNnfHiemH7LrBnc2/mOqfd/Yn7D7FbFP+vKMAA9HS
         5rpfZrVee3IMpROF0cTBtw2xCkU8ux4CFWdgb5AK2gYMIwJlY2grDxfnj/4n9QNyK0el
         Krdh1rurUl8jbVM8AFqlsJJNFoLNQmZTFs5p/S5ZYxzuzNZbnMW6QGN+Bo8O95LnmJek
         wRpru2KfiCnNe4APxy852pbe6sTtFHT5MQh+M+tm1aQfk0FG5nJnXhktXB2gkHT+ZdXA
         yQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697419177; x=1698023977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycNhjCRFpUhksXsl43Gg/gmWjiI/q9jZ8V6D0q3J+8Y=;
        b=egDBz6MbAc6rc52wb7dbGgs3cSUZnVArJYEtsnEsrA/yNK93JH/e8kvfYR06sMw+ZX
         Lz/IKrKETa5gjTKpxFzpICpPmDD/H75LRPrMHF59y8rc796QVOYVG1j4h5yC2C0QX3tj
         WkDLy9TRbARfHE6zbp8jTdCOlhFi/ZBz3GEQCl/VlJ+okqGQqe6rWmi7U4ACBa7SlNnA
         2d+83lwkhqqn+9cGEv2uK7nQ7eRva4j6SnQpBkKlCOz1wg9azkNgjHDwl2ya0YHlW1SM
         djEWJ4IGDfNkyy0QnIgw5IGp8D/Efj4vLwOtiEBtsFKeMrYkHjaI3ntl9+sWlWYRp8JS
         awbw==
X-Gm-Message-State: AOJu0YyMR+aErMpmVkWztlByDI1BZSI2+JVMaudIfRhcE0wFuQwAURdk
        A7We1AFrE6KBfCs4MMdpOoNlatgFAP3QgBqPxapi+g==
X-Google-Smtp-Source: AGHT+IGXF0ZwWO5sNdfXck3l+mKju6H+pypH0h1zgCwfJcjeI8E/GL+v9uDhBFb/YLdNJhnqrDO2GAWPYkhox/pShaQ=
X-Received: by 2002:a50:cd16:0:b0:538:1d3a:d704 with SMTP id
 z22-20020a50cd16000000b005381d3ad704mr105578edi.1.1697419177104; Sun, 15 Oct
 2023 18:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com> <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
 <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com> <fad5a7fb-cce1-46bc-a0af-72405c76d107@quicinc.com>
 <CANP3RGcqWBYd9FqAX47rE9pFgBTB8=0CGdwkScm-OH1epHcVWQ@mail.gmail.com>
 <8ff92053-52ff-4950-95c8-0e986f6a028a@quicinc.com> <CANP3RGd4G4dkMOyg6wSX29NYP2mp=LhMhmZpoG=rgoCz=bh1=w@mail.gmail.com>
 <b12eb7b1-54e7-406f-8c19-0046555b82d3@quicinc.com> <CANP3RGcUrFTaFL8V3tpuh+qQoEi84O0Dy9ie+XD=-H01c2btAw@mail.gmail.com>
 <70c15867-ccce-4788-a0dd-38a73decb785@quicinc.com> <d395d631-239a-43f1-bcbf-b88b11852c76@quicinc.com>
In-Reply-To: <d395d631-239a-43f1-bcbf-b88b11852c76@quicinc.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Sun, 15 Oct 2023 18:19:25 -0700
Message-ID: <CANP3RGcnpkcLK_CRfSLvxyGM3L0j5R3fybeF_L1bmRV9hNBcuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 1:24=E2=80=AFAM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 10/14/2023 12:32 PM, Krishna Kurapati PSSNV wrote:
> >
> >
> > On 10/14/2023 4:05 AM, Maciej =C5=BBenczykowski wrote:
> >>>>> The intent of posting the diff was two fold:
> >>>>>
> >>>>> 1. The question Greg asked regarding why the max segment size was
> >>>>> limited to 15014 was valid. When I thought about it, I actually wan=
ted
> >>>>> to limit the max MTU to 15000, so the max segment size automaticall=
y
> >>>>> needs to be limited to 15014.
> >>>>
> >>>> Note that this is a *very* abstract value.
> >>>> I get you want L3 MTU of 10 * 1500, but this value is not actually
> >>>> meaningful.
> >>>>
> >>>> IPv4/IPv6 fragmentation and IPv4/IPv6 TCP segmentation
> >>>> do not result in a trivial multiplication of the standard 1500 byte
> >>>> ethernet L3 MTU.
> >>>> Indeed aggregating 2 1500 L3 mtu frames results in *different* sized
> >>>> frames depending on which type of aggregation you do.
> >>>> (and for tcp it even depends on the number and size of tcp options,
> >>>> though it is often assumed that those take up 12 bytes, since that's
> >>>> the
> >>>> normal for Linux-to-Linux tcp connections)
> >>>>
> >>>> For example if you aggregate N standard Linux ipv6/tcp L3 1500 mtu
> >>>> frames,
> >>>> this means you have
> >>>> N frames: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
> >>>> payload (1500-12-20-40=3D1500-72=3D1428)
> >>>> post aggregation:
> >>>> 1 frame: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
> >>>> payload (N*1428)
> >>>>
> >>>> so N * 1500 =3D=3D N * (72 + 1428) --> 1 * (72 + N * 1428)
> >>>>
> >>>> That value of 72 is instead 52 for 'standard Linux ipv4/tcp),
> >>>> it's 40/60 if there's no tcp options (which I think happens when
> >>>> talking to windows)
> >>>> it's different still with ipv4 fragmentation... and again different
> >>>> with ipv6 fragmentation...
> >>>> etc.
> >>>>
> >>>> ie. 15000 L3 mtu is exactly as meaningless as 14000 L3 mtu.
> >>>> Either way you don't get full frames.
> >>>>
> >>>> As such I'd recommend going with whatever is the largest mtu that ca=
n
> >>>> be meaningfully made to fit in 16K with all the NCM header overhead.
> >>>> That's likely closer to 15500-16000 (though I have *not* checked).
> >>>>
> >>>>> But my commit text didn't mention this
> >>>>> properly which was a mistake on my behalf. But when I looked at the
> >>>>> code, limiting the max segment size 15014 would force the practical
> >>>>> max_mtu to not cross 15000 although theoretical max_mtu was set to:
> >>>>> (GETHER_MAX_MTU_SIZE - 15412) during registration of net device.
> >>>>>
> >>>>> So my assumption of limiting it to 15000 was wrong. It must be limi=
ted
> >>>>> to 15412 as mentioned in u_ether.c  This inturn means we must limit
> >>>>> max_segment_size to:
> >>>>> GETHER_MAX_ETH_FRAME_LEN (GETHER_MAX_MTU_SIZE + ETH_HLEN)
> >>>>> as mentioned in u_ether.c.
> >>>>>
> >>>>> I wanted to confirm that setting MAX_DATAGRAM_SIZE to
> >>>>> GETHER_MAX_ETH_FRAME_LEN was correct.
> >>>>>
> >>>>> 2. I am not actually able to test with MTU beyond 15000. When my ho=
st
> >>>>> device is a linux machine, the cdc_ncm.c limits max_segment_size to=
:
> >>>>> CDC_NCM_MAX_DATAGRAM_SIZE               8192    /* bytes */
> >>>>
> >>>> In practice you get 50% of the benefits of infinitely large mtu by
> >>>> going from 1500 to ~2980.
> >>>> you get 75% of the benefits by going to ~6K
> >>>> you get 87.5% of the benefits by going to ~12K
> >>>> the benefits of going even higher are smaller and smaller...
> >>>>   > If the host side is limited to 8192, maybe we should match that
> >>>> here too?
> >>>
> >>> Hi Maciej,
> >>>
> >>>    Thanks for the detailed explanation. I agree with you on setting
> >>> device side also to 8192 instead of what max_mtu is present in u_ethe=
r
> >>> or practical max segment size possible.
> >>>
> >>>>
> >>>> But the host side limitation of 8192 doesn't seem particularly sane
> >>>> either...
> >>>> Maybe we should relax that instead?
> >>>>
> >>> I really didn't understand why it was set to 8192 in first place.
> >>>
> >>>> (especially since for things like tcp zero copy you want an mtu whic=
h
> >>>> is slighly more then N * 4096,
> >>>> ie. around 4.5KB, 8.5KB, 12.5KB or something like that)
> >>>>
> >>>
> >>> I am not sure about host mode completely. If we want to increase thou=
gh,
> >>> just increasing the MAX_DATAGRAM_SIZE to some bigger value help ? (I
> >>> don't know the entire code of cdc_ncm, so I might be wrong).
> >>>
> >>> Regards,
> >>> Krishna,
> >>
> >> Hmm, I'm not sure.  I know I've experimented with high mtu ncm in the
> >> past
> >> (around 2.5 years ago).  I got it working between my Linux desktop (ho=
st)
> >> and a Pixel 6 (device/gadget) with absolutely no problems.
> >>
> >> I'm pretty sure I didn't change my desktop kernel, so I was probably
> >> limited to 8192 there
> >> (and I do more or less remember that).
> >>  From what I vaguely remember, it wasn't difficult (at all) to hit
> >> upwards of 7gbps for iperf tests.
> >> I don't remember how close to the theoretical USB 10gbps maximum of
> >> 9.7gbps I could get...
> >> [this was never the real bottleneck / issue, so I didn't ever dig
> >> particularly deep]
> >>
> >> I'm pretty sure my gadget side changes were non-configurable...
> >> Probably just bumped one or two constants...
> >>
> > Could you share what parameters you changed to get this high value of
> > iperf throughput.

Eh, I really don't remember, but it wasn't anything earth shattering.
From what I recall it was just a matter of bumping mtu, and tweaking
irq pinning to stronger cores.
Indeed I'm not even certain that the mtu was required to be over 5gbps.
Though I may be confusing some things, as at least some of the testing was =
done
with the kernel's built in packet generator.

> >
> >> I do *very* *vaguely* recall there being some funkiness though, where
> >> 8192 was
> >> *less* efficient than some slightly smaller value.
> >>
> >> If I recall correctly the issue is that 8192 + ethernet overhead + NCM
> >> overhead only fits *once* into 16384, which leaves a lot of space
> >> wasted.
> >> While ~7.5 kb + overhead fits twice and is thus a fair bit better.
> > Right, same goes for using 5K vs 5.5K MTU. If MTU is 5K, 3 packets can
> > conveniently fit into an NTB but if its 5.5, at max only two (5.5k)
> > packets can fit in (essentially filling ~11k of the 16384 bytes and
> > wasting the rest)
>
> Formatting gone wrong. So pasting the first paragraph again here:
>
> "Right, same goes for using 5K vs 5.5K MTU. If MTU is 5K, 3 packets can
> conveniently fit into an NTB but if its 5.5, at max only two (5.5k)
> packets can fit in (essentially filling ~11k of the 16384 bytes and
> wasting the rest)"
>
> >
> > And whether its Ipv4/Ipv6 like you mentioned on [1], the MTU is what NC=
M
> > layer receives and we append the Ethernet header and add NCM headers an=
d
> > send it out after aggregation. Why can't we set the MAX_DATAGRAM_SIZE t=
o
> > ~8050 or ~8100 ? The reason I say this value is, obviously setting it t=
o
> > 8192 would not efficiently use the NTB buffer. We need to fill as much
> > space in buffer as possible and assuming that each packet received on
> > ncm layer is of MTU size set (not less that that), we can assume that
> > even if only 2 packets are aggregated (minimum aggregation possible), w=
e
> > would be filling (2 * (8050 + ETH_HLEN) + (room for NCM headers)) would
> > almost be close to 16384 ep max packet size. I already check 8050 MTU
> > and it works. We can add a comment in code detailing the above
> > explanation and why we chose to use 8050 or 8100 as MAX_DATAGRAM_SIZE.
> >
> > Hope my reasoning of why we can chose 8.1K or 8.05K makes sense. Let me
> > know your thoughts on this.

Maybe just use an L3 mtu of 8000 then?  That's a nice round number...
But I'm also fine with 8050 or 8100.. though 8100 seems 'rounder'.

I'm not sure what the actual overhead is... I guess we control the
overhead in one direction, but not in the other, and there could be
some slop, so we need to be a little generous?

> >
>
> [1]:
> https://lore.kernel.org/all/CANP3RGd4G4dkMOyg6wSX29NYP2mp=3DLhMhmZpoG=3Dr=
goCz=3Dbh1=3Dw@mail.gmail.com/
>
> > Regards,
> > Krishna,
> >Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
