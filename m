Return-Path: <linux-kernel+bounces-153928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1B8AD501
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA30B21BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E675015534E;
	Mon, 22 Apr 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFO2Ppps"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2F15533B;
	Mon, 22 Apr 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814971; cv=none; b=uOGXwXNV8WjZZePLzD4I+XcLUTyxbsEkCIxZP8WdC9OXT0fMNDQZFNUY21tBM1eMiSKM/uUCDjATiKxJNs1g/6Brc6uTovKNoYVZPR3cbNM1RR4eNGg7LE1fEPIOtwt7ttgjdswsyg7EUP6ijvx8oY/W60+GXF+eHC8a/ZoLmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814971; c=relaxed/simple;
	bh=X5NGLyhlmkWiEztUhkG/dYmbEnrBjLWsUuPd6etmt3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZNIAt+Ac1KKYdL+MD7QBCBsmejJc9ZcBpu0JuAE5jIf+1BpC61zcsmmQYjlFOndY7XIN7Ww0SFHxmgMvYt5Wsvk9UgS7Rv9uHWfrrdzmwnDaegcWxmaMXJ6J87UtP0Yc/3Ujn2LOAyGfwWRtXrpzbjN7+bnB0NEDlz/aQD8Gi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFO2Ppps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A770AC113CC;
	Mon, 22 Apr 2024 19:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713814970;
	bh=X5NGLyhlmkWiEztUhkG/dYmbEnrBjLWsUuPd6etmt3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HFO2Ppps/oZr9UBPkLMNSFWLF8JT0mQUjb6KEmKTavUYAzUBfRay7wviM9/lYJ1ox
	 VGD9BugBnxpekoWlFpo267NnDA//Jp5Q03vIdUlgWRdD5s8i+dVQ9wvKVAa/kA+Lf7
	 rcg23e19F5+xrsUNWPs6AGzRt2dud8+yPRn9eWr+QBAVHGly6fogMw1Dyv/kknlIiX
	 p9k2P5UGa39I2lZ1fXX16QOFEj+llvJVWZp/i64mCSjL875AMlg1avpPvOhxsKBeCj
	 8wfk/8dB14dU5dPWZ/HfY//p4xmc1x/tuJsCKA8Vq8GFKQwH/ROYrfcbP1V7YQH6F9
	 UWocTlyMx3Vfg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso7204500e87.3;
        Mon, 22 Apr 2024 12:42:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAQNQ7y5T3lz9L/YRm5AWQoC5SfuYnyLnC+bff5XFGwuxLyX5EW4413M7bbYFrSdPlH/8hYbb9722d95gxQ++IMw6rQtmqbijH2dWHi/vu0Rh3buyDfBwrWWlwEiq703BTeQRofDBQX+Hlyx33oGT7Qp2TH27bdIGGPbRtQySvj3hvHkMm27PnKclprWI=
X-Gm-Message-State: AOJu0YzON+bKAQ8zAl58vXnkOXWcncY0UiKhbx6H7K6dmZXYmgMSYRji
	hjossPd6MQdju+mCOORn70SE25f7R0bVdUUr9jdSVmpLUkgS/wWXGGVR3If1vOmDRBf9Ajir5Yz
	sfjVEVoeOIiaoY2X+HJRWmEXCZi0=
X-Google-Smtp-Source: AGHT+IFUc94RfCXq+iQAJz7qjewz+jSCFsONec3F2z9I3xwsiexX4d/Q6fXVP4Y2744DYOS3241u2oWO23s5CFrO6bQ=
X-Received: by 2002:ac2:46f6:0:b0:513:d5ec:afb with SMTP id
 q22-20020ac246f6000000b00513d5ec0afbmr8808090lfo.40.1713814969390; Mon, 22
 Apr 2024 12:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713780345.git.geert+renesas@glider.be> <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com> <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com> <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
 <d3f406ed-1b93-4fcf-850a-743d27f20dc2@app.fastmail.com>
In-Reply-To: <d3f406ed-1b93-4fcf-850a-743d27f20dc2@app.fastmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 04:42:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNb0kB=cytOmJn+K59vQ8ekESqY-=1SFDOQox-B3GJrQ@mail.gmail.com>
Message-ID: <CAK7LNARNb0kB=cytOmJn+K59vQ8ekESqY-=1SFDOQox-B3GJrQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:24=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Apr 22, 2024, at 18:58, Geert Uytterhoeven wrote:
> > On Mon, Apr 22, 2024 at 3:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Mon, Apr 22, 2024, at 15:28, Jani Nikula wrote:
> >> Whereas this one is broken:
> >>
> >> config FEATURE_A
> >>        tristate "user visible if I2C is enabled"
> >>        depends on I2C
> >>
> >> config HELPER_B
> >>        tristate # hidden
> >>        select FEATURE_A
> >>
> >> config DRIVER
> >>        tristate "This driver is broken if I2C is disabled"
> >>        select HELPER_B
> >
> > So the DRIVER section should gain a "depends on I2C" statement.
>
> That is of course the common workaround, but my point was
> that nothing should ever 'select I2C' or any of the other
> subsystems that are user visible.
>
> > Yamada-san: would it be difficult to modify Kconfig to ignore symbols
> > like DRIVER that select other symbols with unmet dependencies?
> > Currently it already warns about that.
> >
> > Handling this implicitly (instead of the current explict "depends
> > on") would have the disadvantage though: a user who is not aware of
> > the implicit dependency may wonder why DRIVER is invisible in his
> > config interface.
>
> I think hiding this would make it much harder to get anything
> right. The symbols in question are almost all ones that should
> be enabled in normal configs, and the 'make menuconfig' help
> doesn't make it too hard to figure things out normally, we just
> have to find a way to avoid regressions when converting things
> to 'depends on' that used an incorrect 'select'.
>
>      Arnd



I am confused because you repeatedly discussed
the missing I2C dependency.


Are you talking about DRM drivers,
or is it just "an example" in general?



DRM selects I2C.

https://github.com/torvalds/linux/blob/v6.9-rc4/drivers/gpu/drm/Kconfig#L16



If you make sure individual DRM drivers depend on DRM,
none of them can be enabled without I2C.



Currently, this is not guaranteed just because
DRM folks do not know how to use the "menuconfig" syntax.



The "menuconfig" makes sense only when it is
followed by "if".




diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5a0c476361c3..6984b3fea271 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -29,6 +29,8 @@ menuconfig DRM
          details.  You should also select and configure AGP
          (/dev/agpgart) support if it is available for your platform.

+if DRM
+
 config DRM_MIPI_DBI
        tristate
        depends on DRM
@@ -414,3 +416,5 @@ config DRM_LIB_RANDOM
 config DRM_PRIVACY_SCREEN
        bool
        default n
+
+endif










--
Best Regards
Masahiro Yamada

