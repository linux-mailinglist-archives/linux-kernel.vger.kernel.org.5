Return-Path: <linux-kernel+bounces-55305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC384BAAA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CF7B27D87
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC43134CE2;
	Tue,  6 Feb 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRJdownx"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9F812D150;
	Tue,  6 Feb 2024 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235959; cv=none; b=eYJgplD6D3nMyqNMzlNEAlbTr2XeGuy8Sk9ryg8EvdKBpcBckA+jtiim4N8pqexdccA1L6uLfwgrKG1AWVFlu83uLZCQvzFT4N2YQgayj4LZvjR+EkMzlwl/y6MPL7DY5EYvb8y9biRVhx82CVS+zLMojRDM0z9b2qjxsLCeD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235959; c=relaxed/simple;
	bh=1ieCV6VVcI8BpYY3r+hbEHsH1TQli35xglXAqR7oGvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgquhM8ebHD9Kw6NJJ57OxEDV3O14KI4wq1JhfiOROJfTTB6ow/p4xbshj3ARUPwoN6HMlNhoraNfn+fOph3ZhMHxwnMpOA9cj6QRctNr+GVhRSSHUhnqM619dw0k0cPq6ZfS9d92FaKZDUe6bm7AE3CG3K0LslACf0xIcJBrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRJdownx; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68c9711344bso5035086d6.0;
        Tue, 06 Feb 2024 08:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707235956; x=1707840756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ieCV6VVcI8BpYY3r+hbEHsH1TQli35xglXAqR7oGvA=;
        b=PRJdownx9DJE98B67dMDw50ZTQK6UYHUVr0PcrexY7Q0XWchlD3FIDF7id6DA3sD0W
         yy4I+3tczn8ZeViWUhWXZAdO3TH8G0Rcqg2uTL4cY7fE2UI2zOghaLlHJM6o7kx9wmwL
         h0qUv1tgEg7OUagKXDTChnKhPsAkbkyOmle7gZqpHN28P9sSXBIEEO1oNF3YfQUru6hN
         fosU9iUrGSY04NhYTz9887g67mUVt6q8Kc8VIxSOeYx+AeVbkOYZAw1AuPAIX4rnOsp1
         FjaoesRT6JboGFCoNNySw5CGPJXWTyaDx1TVTKl7VrZg7paVRBPqYuwsxlq8hpam1dzk
         TyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707235956; x=1707840756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ieCV6VVcI8BpYY3r+hbEHsH1TQli35xglXAqR7oGvA=;
        b=UoZoKakp4QWPqeHTgS2ZlY+zYgkFulC5mdI7s1yu0Qj+T61X+GuKYohUHtjSJSQA4F
         UKCPdGjwOL6rIobQgS2kS9JK9i7bAgBKS7DRVH3ZazZkjREwo6ELPaICMxgPj+piYRxP
         TRwchRirBs1/Ga9pK27jr0habx+kcUKG1fC1L3W9cPDaynfkU2Pc82Y3V63UrILCYO+4
         pOAm5U8b9AhzwoPASHp6PLdlQp/XD4L5rRouXl3p/90GX45tHs2FDz/9Xm7/oo5FUFwi
         E8zbkgRkUKs88sYnWh7ylFce6MsKm3bNVMZt50Ypgyj1WXi7PEOCd41qUdvMesUY4WAE
         h+gw==
X-Forwarded-Encrypted: i=1; AJvYcCX7NCVSHecBynVFzegwCLtJSxUreBJJh9d/6vs0BHGwlJwssg9FEb5Wrs1L4nGldrQ4cEg9cmoIUeEPthu7Npq2ckDtKGsS77vd0mixVtNuXJND9CqZfKBDRbGhDscOEzKOLXgvRath
X-Gm-Message-State: AOJu0YxUlhf8CikdpvhnxWj19xxNBR/eNoCEbAbRn+k0CBdVYUmLrY/Z
	jRYaUG4yp3IvwDXDLCA5Joa7UsXxQxtV0lXNiA1tD3lZ1lngNdUPftoDSw9cSGrm7mCaH0UzUxd
	MsdjtTJEUm21VG8sAQ0LKpGGVZDvBr4BeYRQ0EdWrgmg=
X-Google-Smtp-Source: AGHT+IGibg/Uy/VO28H8MiZGzensmJWg8/tCqb4k3XcsN6etZYaid1T7Pd2D/urVLTK3tzdCfGagOf9QsdUod+Oj0Fo=
X-Received: by 2002:a05:6214:1649:b0:68c:b0e5:7cd7 with SMTP id
 f9-20020a056214164900b0068cb0e57cd7mr2495948qvw.4.1707235956193; Tue, 06 Feb
 2024 08:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com> <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
In-Reply-To: <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 6 Feb 2024 21:12:24 +0500
Message-ID: <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_wha?=
	=?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_t?=
	=?UTF-8?Q?ime_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c7?=
	=?UTF-8?Q?5849406c?=
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b7e14c0610b8d8ef"

--000000000000b7e14c0610b8d8ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:24=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
>
> This seems odd, not sure how this usb host change would impact your netwo=
rk speed.
>
> Could you try reverting that patch from 6.8-rc1 and see if it helps?
>
> There are some other patches on top of it that needs to be reverted first=
.
> These should be enough:
>
> 36b24ebf9a04 xhci: minor coding style cleanup in 'xhci_try_enable_msi()
> 9831960df237 xhci: rework 'xhci_try_enable_msi()' MSI and MSI-X setup cod=
e
> dfbf4441f2d3 xhci: change 'msix_count' to encompass MSI or MSI-X vectors
> a795f708b284 xhci: refactor static MSI function
> 74554e9c2276 xhci: refactor static MSI-X function
> f977f4c9301c xhci: add handler for only one interrupt line

I confirm after reverting all listed commits and 57e153dfd0e7
performance of the network returned to theoretical maximum.

> That patch changes how we request MSI/MSI-X interrupt(s) for xhci.
>
> Is there any change is /proc/interrupts between a good and bad case?
> Such as xhci_hcd using MSI-X instead of MSI, or eth0 and xhci_hcd
> interrupting on the same CPU?

On the good kernel I have - 32 xhci_hcd, and bad only - 4.
In both scenarios using PCI-MSIX.
I attached both interrupt output as archives to this message.

[1] https://postimg.cc/zL2RYgYZ

--=20
Best Regards,
Mike Gavrilov.

--000000000000b7e14c0610b8d8ef
Content-Type: application/zip; name="interrupts-good.zip"
Content-Disposition: attachment; filename="interrupts-good.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_lsajhr4c0>
X-Attachment-Id: f_lsajhr4c0

UEsDBBQACAAIAKqlRlgAAAAAAAAAAA3VAAATACAAaW50ZXJydXB0cy1nb29kLnR4dFVUDQAHEFTC
ZapVwmWqVcJldXgLAAEE6AMAAAToAwAA7Z3vbts4FsW/5yn0Ah7wXlKUlG+ZNIM10GS8aWZmgcWi
8NpqbdT/VnbaefwFLVOUTenWkU1Htln0w4Eji7J+OhKPLikFgfl33/uDGQlGopHcSGFkaKQ0MjIy
NjIpNcGMBCPRSG6kMDI0UhoZGRkbmZhfYVpD0xqa1tC0hqY1NK2haQ1Na2haQ9MaN63xTWs3QRCw
W723IdH7R33s5fFk97nT/b1z1+veqw+wkw6/pvkfV+NpmikM0e3bVunloRiizpf+cpXOx0EQLMaz
wSqbfO5PhwpG7GE4l9sw4pInstWAKQqJp+BcblNISpboDxbjmyBA6Sk4l737bufxU7fDGGO36/+/
rDsBrOSKu8cPnT/XRPylwr3sT4efvy7Gc9UtYkFwd9/r3j58T2crBcBfHtzLEoCA7wLwVwb3sgSA
4w4AzhoCwDcse+2y+9yxrgvwyzq5la8LvftuGvQeHxQW8L5wLquxWJfrMhb0WJzLKixIu4V7LM5l
FZaYxiI8FueyGsv6bmMNFuH7XO7lLhYAFQXXy5Sx9EeD8b/LC/znJgjCpn2ys5IQ8rDB144P6F8b
QqyS0N+jwfjzaKBuJoa+U+ZeUlyghovvlbmXFBes4eK7Ze4lxYXXcPH9MveS4iJquISei3NJcQlr
uPjCiXtJcZE1XHz5xL2kuEQ1XHzAPEACCr7HsjYXVFys4F/iIq8iV7bOL4ZLTX6RPle6lxSXmvwi
fa50LykuNflF+lzpXlJcavKL9LnSvaS41OQX6XOle0lxqckv0udK95LiUpNfpB8V5l7WcFnPjajL
Lz5XupcUl5r8Evlc6V5SXGryS+RzpXtJcanJL5HPle4lxaUmv0Q+V7qXFJea/BL5XOleUlxq8kvk
c6V7SXGpyS+Rz5Xupc2F/2z8WOTrle4lxaUuv/i8715SXOryi8/77iXFpSa/xD7vu5cUl5r8Evu8
715SXGryS+zzvntJcanJL7HP++4lxaUmv8Q+V7qXNbnSmv26WC46oKD48PI2CTEw/YSwfb9mQWFp
ZahMZwsQS/Vonfiq+8ix2H/ZY3qFRZVYZt+nKfxPYUl8F9mtjEQVFlGLheVYih4yCAE/acLLZpJy
C1huUdeW5Gw7yBgl5/IgFMotu1hYjqWqf4wsiuua8PK4bkHLLaiwVJXDuHzX2dQXJym37GJhOZaf
pBaQiSd0qKTcwi23cIXlZ8UwGfqOwKGScssuFpZjeUOcjNgbY5SXP3eLsNwiFJb9S2HAYt8RaCQp
t+xiYTmWZilfoL/i7C8pt4SWW8KbAFizlJ+wc8kMbZCUW3axsBzLwXWwMNpnCu5VS8ot0nKLVFgO
TvlhKPde9kol5ZZdLCzHcswqGErfVauSlFsiyy2RwnLMQa+hbMl+aJmk3LKLheVYHNUmpe9MG0m5
JbbcEissjoa8cuHPZ4Wk3LKLheVYnBeNQfKW7J13k5RbEssticLifMAryPDae9CUW3axsBzLKWv5
yOOW7KjTSsItYNfygd0EAKcs5iPjV3k/mrCLxYVtuLzTeNcQ5GnGnbRBUn6pqOaD4vJO5XweJi3Z
aSeQlF8qyvlrLu8/3hVCvPBbOJRf7Ho+oOLy/vNbhbj0GhvlF7ugn3Np1zhkeZH31ii/2BV94IpL
q+a3IlwJF1HLhW24tHaIeHw5HTbKL3ZNH4Ti0tb5rRjhBXMRtVzYhss5jN3HMx9DQPnFruqDqh/j
OQzel3Der3in/GKX9XMuZza/NTnHqw7lF7uuD6qCjOc1fB/gHKd+UH6xC/s5l/fP+01ldDYjPSi/
2JV9UDVkfP+8fwQXYdxqRJRf7NJ+zqVdeb+hDNvdMaD8Ytf2QVWRsVV5/whSsPYhovxiF/dzLq3N
+w0lQvsG5lJ+sav7oOrI2Na8f4yzW1tKPJRf7PJ+zuUc8n4zCawt9QPCL2jX91HVkfk55P2DJcbi
PYcYEn6xuLANlzPL+w2tE0fvedWh/GLX91HVkfl55f0jSH6iB42UJOUXu76fcznfvN9QhnjyUxrl
l4r5+qqOzC8h7zeVMjrNzTbKLxUT9tdcLiLvN5TiRNah/GLX91HVkfml5f2mVx2XI0Epv9j1/ZzL
peX9ZhJY6LDDRvnFru+jqiPzC877DWUYHrtqTfnFru/nXC437zfmEh/7lEb5xa7vo6oji6vI+03P
bslx5opSfrHr+zmXq8j7DSUHeZSiAeUXu76Pqo4sri7vN5OCHXCbgPKLXd/PuVxd3m8mQ3HAMEPK
L3Z9H1UdWVxz3m94dkvYG+Mo5Re7vp9zuea831Aie6N1KL/Y9X1UdWTh8/4BkjPYZ6o15Re7vp9z
8Xn/AAn7jZym/GLX91HVkYXP+8eRHGWtdSi/2PX9nIvP+8eRYVg/tpDwC7fr+1zVkUOf948v450H
fBB+sbiwDRef948uIdkZ3E75xa7vc1VHDn3edykh5AntF7u+n3Pxed+p5JGk/WLX97mqI4c+76/L
YpI7fOaT4bLBUv263f50+HXxqqD4ULkr46OX/KuhrC9AZSjL2fDzaNj/PJ6t0sntoJ8N16czHy/d
y11C+Vve1r1rmtD6xOaD5n5SJM1rM5aHvlSe2KarKEFIb4Knx26JiqsRImc4Q5KWpUvTXr/taT7r
TPvLb/3/TtJA2SLLXher5U3w8ff7zf5HxnHzLQiL14iAQP1OKOCxrjwAY/pOKpiHIAFExdcY4uYg
QhBMfxqDYIUsPuVJoiVilGgphCxWpqcYAYAe9w0sYnoBIaVpODIr43ojJSttZPEzgclivVIPg4GQ
Ma7Xy0C3xvlmWcAo0TNrIGax3t64GKUByFEvwEJQ2/BxPuhPgtV4mmZbu/9T7w9/UnIvPy1es/H8
dbm173v+1NNEvvXU00uzL/Ns2p8N0mA6n41X82w8+7pFovtXmUTp4gOVsuGObtkjXKu2F6F0p5BX
ysqV4V5Qus//DH7Ms29b+/755dmfgdzLu173PujePwdZ2h8GWbrKxqna+w+fir2PcTEQE0VRbAHz
njUUxUohNguYu8tgphOCeecHxoWj0IzBRWnWy4pPS+tFM/MakqIJxGJmHMjYfK20ZebTqLRlpR9k
1mueNYbmRh9CsQY0U4tLm1NewPwgSEpfMxu57lo8p8vBKB2+TnbPPPd3Hzf7X8ZC9yF4IkDLMEwS
LYtt5DzUBX6OILj+NNJrwDjWb8XhUaKxCRbr3Ss46tE1XHBZrCEB/SnnQhRN6M4Lx0S/GJGj1LS5
ANCfcpS6YWC6f8R5ortVnEOkv8aKHck5FL+Yge538YTpB1cIYIneSFPP4JLrY0BEcSj0z4RiT4bx
umz42+tssBrPZ8GgP5lsAXj5+GthACgdnbx0dAqzQOEQKcxRZA5fNMchZ4UBSk9IAWMsNINq0dzq
SUJz+CbmKDKvvgZWNCGK4xtA9zRVn9E4z7xOFUsGKPkxMttrbmegGZHNY+OQ0kFtZqGI0paVvGsm
4eW75OXjr8FyNJ+vhvMfM7Xbnx/9Wd+9fBml2bQ/CdLv6Wy1fdz/w192TyBfRlm6HM0nw/wCXCbw
4TdP4ATyQ/olzbJ0GDxk2TyzMTzeP3gM7uVjfzAaz9JgMEoH34L070G6UBfkNYBedQz28phyG8Bi
Ppksb4KH561z0E3w2P20/UGv++Tt4V725stVOuwUJ6ZgNl+Nv4wH/XWvdX35vgmeel3Pwr18ShWL
YLGLZEOh1/3LU3AvLUf86H9LXxcbCv8HUEsHCObLq7/pCgAADdUAAFBLAQIUAxQACAAIAKqlRljm
y6u/6QoAAA3VAAATACAAAAAAAAAAAACkgQAAAABpbnRlcnJ1cHRzLWdvb2QudHh0VVQNAAcQVMJl
qlXCZapVwmV1eAsAAQToAwAABOgDAABQSwUGAAAAAAEAAQBhAAAASgsAAAAA
--000000000000b7e14c0610b8d8ef
Content-Type: application/zip; name="interrupts-bad.zip"
Content-Disposition: attachment; filename="interrupts-bad.zip"
Content-Transfer-Encoding: base64
Content-ID: <f_lsajhu6n1>
X-Attachment-Id: f_lsajhu6n1

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
BgAAAAABAAEAYAAAAKMLAAAAAA==
--000000000000b7e14c0610b8d8ef--

