Return-Path: <linux-kernel+bounces-14285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9689A821AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A53A28317B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE55EADA;
	Tue,  2 Jan 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6TahE28"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABAEAD6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so97104a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704194574; x=1704799374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfTbWWodBrX6f385mu9rEzF4b+5J7/G71pSZWTjDapw=;
        b=C6TahE28RAzqM6v2tCJUDX7OJT0YBRecjiAufds6vp10OXjjusDkyxKEFY5VuTjLHR
         aE2SSRhdUtyjRgvPy9pUIV5oBuQfGMz5ilmiS3HNqRw2l+bel1tqBWEQbfXX8Ktk+4dW
         ChWJCj+WCyzjrIWbQwe+bI0X9GpR2JCgvepMxXzV/ROWunSsac2O7XJXgp8kIBXgLO/o
         vSGVP/XKGyOeE+tZ1OfkiHZ/GrOguBHpdMUFdF84aGNHcv16gTkn7xtu7zXwLG97Hq9a
         HXQIKuCqwJXRKHF88f4TjrO3QeANcKUt3ET/73NkgA0k2iLjxM8Gu98euiY1dEMob7Zm
         Gndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194574; x=1704799374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfTbWWodBrX6f385mu9rEzF4b+5J7/G71pSZWTjDapw=;
        b=VWO1T6OKkEveADu4vcfeOAuLLnrKafC/tFKdWP5d5RQRTr0QXOsvgFaf89haWx4z7L
         PPuGgauot9QZSnwXZbIDnw6fo1YFDDOpqjP0g8SGIcMsnICuyQFG/ymdwo6VIBSQQUfj
         6KGloB5W+pPMRAAWKAehNPDxLdrVeaY/OzLr+Y+xm5VyXUX3gPbuJNlyB/QtteyWS4wv
         zCTxC5eiyyxnV1n9301kv7xeFwQdFEnXbZBBIVhhgZSzLM8f210gJ3Kz/NtLit5ganiM
         s751lMdRgzxTQBc9/H5kveM6jZeQZNhkx8ReAHbRMdvMiKDW8A4mcf+5kLtTptjDAFfQ
         uTnQ==
X-Gm-Message-State: AOJu0YzEZmCqLcSXO8x1f9D/YZMAQlttWshf6XZZOKIg/Ul/uukFDpUR
	OOg7LO59HjYZeXINh7gUWZ+Ro+M7Iw9sSsfvU8I3DsFzGeWT
X-Google-Smtp-Source: AGHT+IEQFWe3iDRxjzX8K2gba7QF3ubT/1Zm2rboow+XsJquXNsprTpYNC75y1IuLrc/d4+32gbBPOLPbkWCBFbO8RM=
X-Received: by 2002:a50:cd8a:0:b0:553:9d94:9f6a with SMTP id
 p10-20020a50cd8a000000b005539d949f6amr1153795edi.7.1704194574433; Tue, 02 Jan
 2024 03:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102055143.3889-1-quic_kriskura@quicinc.com>
 <CANP3RGeirg+f8cBbw_3YR5AvuB1ZxJC_9-wcn+Tb-GXf1ESKCQ@mail.gmail.com> <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
In-Reply-To: <ad60f399-5c6a-4f16-8c28-f4d4e0fde1ff@quicinc.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Tue, 2 Jan 2024 03:22:42 -0800
Message-ID: <CANP3RGf5dg14DNuKOn9pqWd4oSBDsPhwwBB7AJ0c3qHbDT0sBQ@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hardik Gajjar <hgajjar@de.adit-jv.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 2:48=E2=80=AFAM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
> >> It is observed sometimes when tethering is used over NCM with Windows =
11
> >> as host, at some instances, the gadget_giveback has one byte appended =
at
> >> the end of a proper NTB. When the NTB is parsed, unwrap call looks for
> >> any leftover bytes in SKB provided by u_ether and if there are any pen=
ding
> >> bytes, it treats them as a separate NTB and parses it. But in case the
> >> second NTB (as per unwrap call) is faulty/corrupt, all the datagrams t=
hat
> >> were parsed properly in the first NTB and saved in rx_list are dropped=
.
> >
> > I think this is likely Windows trying to avoid generating 0 length fram=
es.
> >
> > (usb max single datagram [frame?] size is 1024 bytes).
> >
> > My guess is this extra byte will only ever happen at the end of a
> > multiple of 1024 bytes,
> > and it will always be exactly one byte, and it will likely be a '0' pad=
 byte.
> >
>
> You are right. This happens only with packet sizes of 1024/2048/3072
> etc., and it is 0x00 only.
>
> > Could you check if a more specific test of this sort would make sense?
> > (ie. fix the problem)
> >
> > Something like
> >
> > if (to_process =3D=3D 1) && (current_offset & 1023 =3D=3D 0) && (*paylo=
ad =3D=3D 0)
> >    // extra 1 zero byte pad to prevent multiple of 1024 sized packet
> >    return
> > }
> >
>
> The above might work. But just wanted to check why this 1 byte would
> come actually ? Any reason for this ? ZLP must not give a 1 byte packet
> of 1 byte AFAIK.

I'm not a USB expert, but... my (possibly wrong) understanding is:
(note I may be using bad terminology... also the 1024/16384 constants
are USB3 specific, USB2 has afaik max 512 not 1024, I think USB1 is
even 64, but it's likely too old to matter, etc.)

USB3 payloads can be up to 16384 bytes in size,
on the wire they are split up into packets of between 0 and 1024 bytes.
[a Zero Length Packet is a ZLP]
A usb payload is terminated with a usb packet of < 1024 bytes.

So a 1524 byte payload would be sent as 2 packets 1024 + 500.
While a 2048 byte payload would be sent as 3 packets 1024 + 1024 + 0 (ie. Z=
LP)

A 16384 byte payload could be sent as 16 * 1024 + ZLP,
but since 16384 is the max you might be able to get away with just 16
* 1024 and skip the ZLP...

I think this is why the Linux usb code base has ZLP / NO_ZLP quirks.
[but do note I may be wrong, I haven't gone looking at what exactly
the zlp quirks do,
not even sure if they're receive or transmit side... or both]

Different hardware/usb chipsets/etc have different behaviour wrt. ZLPs.

In general it seems like what needs to happen is much clearer if you
just avoid the need for ZLPs entirely.
I think that's what windows is trying to do here: avoid ever sending a
usb payload with a multiple of 1024 bytes,
so it never has to send ZLPs. This seems easy enough to do...
limit max to 16383 (not 16384) and add 1 byte of zero pad if the
payload ends up being a multiple of 1024.

> > It seems a little dangerous to just blindly ignore arbitrary amounts
> > of trailing garbage...
>
> Yes. I agree, which is why I put a note in comment section of patch
> stating that this doesn't cover all cases, just the ones found in the
> testing so far. But the code suggestion you provided might actually work
> out. So something like the following ?
>
> if (to_process =3D=3D 1) && (block_len%1024 =3D=3D 0) && (*payload =3D=3D=
 0)

Assuming it compiles and works ;-) I wrote this without looking at the code=
.

I'm guessing this needs to be %512 for usb2...
Do we know if we're connected via usb2 or usb3?
[mayhaps there's some field that already stores this 1024 constant...]
If not... should we just check for %512 instead to support both usb2 and us=
b3?

>      // extra 1 zero byte pad to prevent multiple of 1024 sized packet
>      return
> } else if (to_process > 1) {

this should likely continue to be !=3D 0 or > 0

>      goto parse_ntb;
> }
>
> Just modified in current_offset with block_len and checked it with
> %1024. Let me know if it is fine and I will give the change to testing
> team. The issue is easily reproducible.
>
> Regards,
> Krishna,
>
> >>
> >> Adding a few custom traces showed the following:
> >>
> >> [002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
> >> req 000000003868811a length 1025/16384 zsI =3D=3D> 0
> >> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: =
1025
> >> [002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199=
9342
> >> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
> >> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x=
400
> >> [002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x=
10
> >> [002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames
> >>
> >> In this case, the giveback is of 1025 bytes and block length is 1024.
> >> The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
> >> all datagrams in rx_list.
> >>
> >> Same is case with packets of size 2048:
> >> [002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
> >> req 0000000011dfd96e length 2049/16384 zsI =3D=3D> 0
> >> [002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 175199=
9342
> >> [002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x=
800
> >>
> >> Lecroy shows one byte coming in extra confirming that the byte is comi=
ng
> >> in from PC:
> >>
> >> Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
> >> - Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
> >> --- Packet 4063861
> >>        Data(1024 bytes)
> >>        Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
> >> --- Packet 4063863
> >>        Data(1 byte)
> >>        Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)
> >>
> >> Fix this by checking if the leftover bytes before parsing next NTB is =
of
> >> size more than the expected header.
> >>
> >> Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NT=
B's in unwrap call")
> >> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> >> ---
> >> There could probably be cases where the first NTB is proper and the se=
cond
> >> NTB's header is proper but the NDP is corrupt, and in those cases too,=
 all
> >> the datagrams are dropped. But I haven't seen such case practically.
> >>
> >>   drivers/usb/gadget/function/f_ncm.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/=
function/f_ncm.c
> >> index cc0ed29a4adc..a75b6dc8b0cb 100644
> >> --- a/drivers/usb/gadget/function/f_ncm.c
> >> +++ b/drivers/usb/gadget/function/f_ncm.c
> >> @@ -1325,7 +1325,7 @@ static int ncm_unwrap_ntb(struct gether *port,
> >>               "Parsed NTB with %d frames\n", dgram_counter);
> >>
> >>          to_process -=3D block_len;
> >> -       if (to_process !=3D 0) {
> >> +       if (to_process > opts->nth_size) {
> >
> > shouldn't this check actually be >=3D not > ?
> >
>
> Yes. But what is header is present and no data further ? Just to fix
> another harmless corner case, I added the "=3D".
>
> Regards,
> Krishna,

