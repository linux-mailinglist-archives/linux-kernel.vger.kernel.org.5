Return-Path: <linux-kernel+bounces-34097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E68C837366
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934C1287DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944A405EB;
	Mon, 22 Jan 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Roldsi+e"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF523B790;
	Mon, 22 Jan 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953692; cv=none; b=LDGEjxQVCAE0UBlE2WUsGaKQoQcafU7mrOboVbfE9Ds0E5Pu6h2MeQy6TN82KZ/l/1UEWg13cjNi5T2OjF4mZCBOMKqeCi3Qtpq/EXgueWdekhh7vPgfdbDyrDTy0wFW4biOCKCo8PjCsnwYT0/2kUO+51OBnRgpMQuZuh/y96o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953692; c=relaxed/simple;
	bh=dNelk4kBrgBCghijjRjoFYY9rvEodTp1XYkmBPmw944=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsNTXAKf6XRnp7FP6czi+rGNmyzSRUOw8ZCLinUYEVsbXTL5x8hV4BsZvkx8NLy5HzGlodpPFmlOMFFP75g+IWfX4MF2XRZ5wOEKTyRlicQ54s5TmM/nBDzjEabLg+68SEuecQvjKMjFatXwu5QYY0znQI9P2pU1HhRsjpKfSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Roldsi+e; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705953660; x=1706558460; i=deller@gmx.de;
	bh=dNelk4kBrgBCghijjRjoFYY9rvEodTp1XYkmBPmw944=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Roldsi+e/ixsw0Rufo0TEKAUHwJ964vRlLwtamHVpZ1xrEG7UaEczqqFz4sDeIRS
	 ic0L8UckEsHeeywccp9evzE4PnUSo4EnXD1rhJETkLPpdbOxdNHOEpJP6Kmv1faQW
	 MYb0m35MDfLSjtlbbPukc6mmMnB0hOSjkyVTIqClVl/MhfbxNABvktXjaiMw1T9Zh
	 +C9wUuoa0ePtyS052o7yTMwRKZIBcHdyQq35dINaac6bPPQVtPxZ/QAMVMRWfedFy
	 YVJ73IupSgKAjZOSd8JYcUP8z1/bUsSVkAouGd8xAd2h1x+W0vDKY+EYNlLj4wkzK
	 Sm4PA/vmBmYnGU9Mng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.156.47]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDc7-1r7Ahd0JdF-00uZaX; Mon, 22
 Jan 2024 21:01:00 +0100
Message-ID: <00232392-dc40-4790-9278-91df30e50a04@gmx.de>
Date: Mon, 22 Jan 2024 21:00:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/47] tty: vt: cleanup and documentation
Content-Language: en-US
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 Martin Hostettler <textshell@uchuujin.de>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <20240122110401.7289-1-jirislaby@kernel.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+gm3ywaYDIj1z5b8uKNnsDEONVgpeLMuXadHkrhEOpzr6RnNRc7
 MKGXdTFk8i7+n/hahB3Z1Qd8HY06s3puVkp07+cNPf46oh5IMvd3h1bWGRq80KU0k0bugu9
 YObXAsna5CKxrH/v31pd/DN7EvKZxpRVxMGu7Rdl0bJ4eQ/OqbHLZeQ2hFs9tdPdBMSD0qR
 aJAfV/luWPLKrCuWbAFLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5N8g+roOATs=;p5v/fSt9MlMDLMws6IHxxqdF0j/
 9qrDa48mvx+g132niFtZYy4NuzSIoKKuc4JHILs9PXpMu7h3gdSmcDlbkO1H3qTlKIF+FBZBh
 AFG5SD5BhbkjSCLY3hsw/v8IKys0SySa8kiNOGGVZAQoPEhd6OASbF8fgw7hNfDN2okRrZsp0
 eNk38aYHyot3S/jaa6eQYzVuzm/alVU4Vy88eWqnv5fTppyB4NKOaXs9EdaUil7KaH5tlW7dq
 wtYiWTpdOmY9V21fnDsnCuHUyIJm12VVibs+c4BwD3b3nwrru93Q57BpY1RC6dyMtwgXJQKSb
 /vkRuVPj8K0pQae3n+p9i4l5alAZkqkjEbv6Nq3KdgiPTu2Rs9hoceBHQhebrFt8EuR+2x0EK
 HjAM+WDMvo+JrgU6a+3BmoqBcX/gVdaRBOA1sdI5TFjBTn8QMVyGa+/gsiEmYATe/p6zRva+H
 W5TzpfZYuuKOCH2S71kRL0xbL8DewQ9j0J02f4FC2Cw0V3B+z7C5rX4PQtwI5MQoc4vI8TH9/
 cc2iFQRmPYXx/28uwAUKo7K4zZN/0tMhG0rbfTuKC0AOfokwwM7JSaVV0wXVigbNf+O9s0bNc
 60KVPXtnVwsk+VywgROWfrpPyIuaVTDjiQULY9cNF4RtMTncR1nkDqLY9rlTidwMNHbSUxN2b
 mqz7QbZmPTQWoxWhGERqPJbA1HG8dqPXVq1yDuHa2BtBM175z61NSo2/eWltWau0Elh9EYLo0
 Tn2VF7lX8DIm8fQNGS35Sdiyto/XVfh6OC2In7nex24Wf+qJMc92WRnFp5WgPUffwVlTQQxld
 5TF1+oRDWqkJWbNoywlACASXzSPMAvAAMGqVGCvtIbo1DZ1UUmhKPLnDLU5XYnZ+ksJ3gUFvB
 LNS64cTPvYnLF0Ydp7l2Y4hdKsCUBTtYg56Vus4plpOwR0zYQPV+I+WHi12KyNMPHp96XBeFJ
 QbQOzA==

On 1/22/24 12:03, Jiri Slaby (SUSE) wrote:
> Push the console code (vt.c, vt.h, console.h, ...) into a bit more
> maintainable state. Especially all around consw structure and document
> it.
>
> CSI parser is also a bit cleaned up. More to follow some time in the
> next round.

I've not yet looked through all of those patches, but I
tried to boot up a machine with the STI console driver
and I've not seen any issues yet.
So far:

Tested-by: Helge Deller <deller@gmx.de> # parisc STI console

Helge

> [v2] See respective patches for changes. The major changes:
>   * vesa.h introduced
>   * parameters of csi*() simplified
>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Helge Deller <deller@gmx.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: Martin Hostettler <textshell@uchuujin.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>
> Jiri Slaby (SUSE) (47):
>
>    vgacon: inline vc_scrolldelta_helper() into vgacon_scrolldelta()
>    fbcon: make display_desc a static array in fbcon_startup()
>    tty: vt: fix 20 vs 0x20 typo in EScsiignore
>    tty: vt: expect valid vc when in tty ops
>    tty: vt: pass proper pointers from tioclinux()
>    tty: vt: push console lock from tioclinux() down to 2 functions
>    tty: vt: pass vc_resize_user as a parameter
>    tty: vt: make vc_is_sel()'s vc const
>    tty: vt: define an enum for CSI+m codes
>    tty: vt: use case ranges for CSI+m fg/bg colors
>    tty: vt: define an enum for CSI+J codes
>    tty: vt: reflow csi_J()
>    use clamp() for counts in csi_?() handlers
>    don't pass vc->vc_par[0] to csi_?() handlers
>    tty: vt: define an enum for CSI+K codes
>    tty: vt: reflow csi_K()
>    tty: vt: define an enum for ascii characters
>    tty: vt: remove extern from functions in selection.h
>    tty: vt: make consw::con_debug_*() return void
>    tty: vt: make init parameter of consw::con_init() a bool
>    tty: vt: sanitize arguments of consw::con_clear()
>    tty: vt: remove checks for count in consw::con_clear() implementation=
s
>    tty: vt: add con_putc() helper
>    tty: vt: eliminate unneeded consw::con_putc() implementations
>    tty: vt: sanitize consw::con_putc() parameters
>    tty: vt: sanitize consw::con_putcs() parameters
>    consoles: use if instead of switch-case in consw::con_cursor()
>    fbdev/core: simplify cursor_state setting in fbcon_ops::cursor()
>    tty: vt: remove CM_* constants
>    tty: vt: make consw::con_switch() return a bool
>    tty: vt: stop using -1 for blank mode in consw::con_blank()
>    tty: vt: define a common enum for VESA blanking constants
>    tty: vt: use VESA blanking constants
>    tty: vt: use enum constants for VESA blanking modes
>    tty: vt: make types around consw::con_blank() bool
>    tty: vt: make font of consw::con_font_set() const
>    tty: vt: make consw::con_font_default()'s name const
>    tty: vt: change consw::con_set_origin() return type
>    fbcon: remove consw::con_screen_pos()
>    tty: vt: remove consw::con_screen_pos()
>    tty: vt: make types of screenpos() more consistent
>    fbcon: remove fbcon_getxy()
>    tty: vt: remove consw::con_getxy()
>    tty: vt: remove unused consw::con_flush_scrollback()
>    tty: vt: document the rest of struct consw
>    tty: vt: fix up kernel-doc
>    Documentation: add console.rst
>
>   Documentation/driver-api/tty/console.rst |  45 ++
>   Documentation/driver-api/tty/index.rst   |   1 +
>   drivers/tty/vt/selection.c               |  43 +-
>   drivers/tty/vt/vt.c                      | 645 +++++++++++------------
>   drivers/tty/vt/vt_ioctl.c                |   6 +-
>   drivers/video/console/dummycon.c         |  38 +-
>   drivers/video/console/mdacon.c           |  43 +-
>   drivers/video/console/newport_con.c      |  69 +--
>   drivers/video/console/sticon.c           |  79 ++-
>   drivers/video/console/vgacon.c           | 152 +++---
>   drivers/video/fbdev/core/bitblit.c       |  13 +-
>   drivers/video/fbdev/core/fbcon.c         | 123 ++---
>   drivers/video/fbdev/core/fbcon.h         |   4 +-
>   drivers/video/fbdev/core/fbcon_ccw.c     |  13 +-
>   drivers/video/fbdev/core/fbcon_cw.c      |  13 +-
>   drivers/video/fbdev/core/fbcon_ud.c      |  13 +-
>   drivers/video/fbdev/core/tileblit.c      |   4 +-
>   include/linux/console.h                  | 124 +++--
>   include/linux/console_struct.h           |   1 -
>   include/linux/selection.h                |  56 +-
>   include/linux/vt_kern.h                  |  12 +-
>   include/uapi/linux/fb.h                  |   8 +-
>   include/uapi/linux/vesa.h                |  18 +
>   23 files changed, 755 insertions(+), 768 deletions(-)
>   create mode 100644 Documentation/driver-api/tty/console.rst
>   create mode 100644 include/uapi/linux/vesa.h
>


