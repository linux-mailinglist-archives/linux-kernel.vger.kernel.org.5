Return-Path: <linux-kernel+bounces-86355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E09D86C453
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2111F26A43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805D55E4B;
	Thu, 29 Feb 2024 08:56:21 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95F43AD5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196980; cv=none; b=nHi5mPfmemXt9oV6VOqs+e/3hXAiGQ+8NmLcnWaqys3DO7NAy+jTOvbf/8QUAUKOAaIEyddJk4ap7cHxeIQV+p9XUUtaBFgLfWv3egtR41oa40xEMD/+MBOA/EA3ya4/21jlYc1ziy8JYqZ8HMjdSb4DNgJulGohQHgCe6ZD0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196980; c=relaxed/simple;
	bh=Ohh5o0tgsoOOCzMRKRvwy99ZeLUEdn4IneZlG7Vb4aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ4h4eEuY5dpHQrF5SrxjIleB8JCT08oJ0D9VojsVCgmN1aqs3pf8G7du0YZEK/DNBgv7FoZPgwM9a84ElmlGunb2VwAkYiqS8VFNwEnxfeUDfRbW2cIu1Kch7x8Vk78czYH44NqSxJ5MNQf0JmBc5eIFW/o6PX3UOhWQ3gsaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607e60d01b2so4221607b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196977; x=1709801777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFkr5JxwsV6XvZDodaeTLDSdT/zdoLo0VmIMVo/2cDw=;
        b=dkfhKyJ7qcxzQlCmzDszlCV1iwIrFT9Emxuq1+B+sl4rLtmvDIIHgQjQgF9GyHCrSj
         NCgCJzhoKvd6sOaORioBFYG4LDZjNgkAzARggmEEWcLip1dCtTAoo2OMWg4qRpHePf1K
         STrkpowhHaxxtYQYJDUsKV4HUBqis15gZgTEYHzB9wN1CN1qvf3bhkecG8yfxZMHOl+C
         duGgsE+uOU20fH+K3eYYIJ6A+xGu2ZmFBE3tCoKW5FUzNGO6DOnbxcl8VudwKr1eZjos
         uIjz3NLYJ/5HfaHCruCm1AaQvtYX4IwG+DWKx0al8ur2uYDdpqedlOtfES/hDRhO6Wm1
         YokA==
X-Forwarded-Encrypted: i=1; AJvYcCUqn/0b+5urDnIzdDw/k46ZnvyEuxxsU1cXjjpRjj8aYegOCp+EDxe5VhhsVWb7+zcRgdKM1E8uBOBIc1/GNXF68Lm1sSHeJ3GW/wES
X-Gm-Message-State: AOJu0YwsZsTeX1CJF/hKZ7/eLMV3AXsmIoKx2MO6isv0qJPfRXTW9kR4
	ZohkwVOMvkVuvwRSkbidoUEViiSCPstcCC9lWHOTekHeop3AReODUkrQNYhj+Tk=
X-Google-Smtp-Source: AGHT+IH383ovOmCv2eopcJPb5DaD4+9FP2qPLOMOstjHVxdl6OOQwSN/pxtn6hJaKWxPJVO2VXXH6Q==
X-Received: by 2002:a81:a243:0:b0:607:9504:ebf0 with SMTP id z3-20020a81a243000000b006079504ebf0mr1754988ywg.8.1709196976975;
        Thu, 29 Feb 2024 00:56:16 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id y17-20020a81a111000000b00607a42af275sm257918ywg.48.2024.02.29.00.56.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 00:56:16 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so648112276.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:56:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMJuZe/DQdZboRSOcgyA9eA67ZcDZ6+2ExPeTO+QPRjVqQXGYxf9HZYNzxDPwTp/lbacKAuuQ5ggeq0ZN3LHsOiscKVhL8jUgVmALY
X-Received: by 2002:a25:bb85:0:b0:dc6:bcd5:9503 with SMTP id
 y5-20020a25bb85000000b00dc6bcd59503mr1607791ybg.48.1709196975769; Thu, 29 Feb
 2024 00:56:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092040.403629-1-chao@kernel.org>
In-Reply-To: <20240221092040.403629-1-chao@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Feb 2024 09:56:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRuiV8PEe6azKYLp+z_Sa8CbL8849bzu59J1_XXtyk1g@mail.gmail.com>
Message-ID: <CAMuHMdXRuiV8PEe6azKYLp+z_Sa8CbL8849bzu59J1_XXtyk1g@mail.gmail.com>
Subject: Re: [PATCH] f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao,

On Wed, Feb 21, 2024 at 10:20=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
> Just cleanup, no functional change.
>
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks for your patch, which is now commit 5fa6a97d27842dab ("f2fs:
introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup") in next-20240229.

noreply@ellerman.id.au reports several build failures on m68k.
http://kisskb.ellerman.id.au/kisskb/head/f303a3e2bcfba900efb5aee55236d17030=
e9f882/

E.g. m68k defconfig + CONFIG_F2FS_FS=3Dy:

m68k-linux-gnu-ld: fs/f2fs/file.o: in function
`has_not_enough_free_secs.constprop.0':
file.c:(.text+0x19ee): undefined reference to `__moddi3'
m68k-linux-gnu-ld: file.c:(.text+0x1a22): undefined reference to `__divdi3'
m68k-linux-gnu-ld: fs/f2fs/file.o: in function `f2fs_ioc_defragment':
file.c:(.text+0x205a): undefined reference to `__divdi3'
m68k-linux-gnu-ld: fs/f2fs/inode.o: in function `f2fs_write_inode':
inode.c:(.text+0x1692): undefined reference to `__moddi3'
m68k-linux-gnu-ld: inode.c:(.text+0x16c0): undefined reference to `__divdi3=
'
m68k-linux-gnu-ld: fs/f2fs/namei.o: in function `f2fs_is_checkpoint_ready':
namei.c:(.text+0xa64): undefined reference to `__moddi3'
m68k-linux-gnu-ld: namei.c:(.text+0xa98): undefined reference to `__divdi3'
m68k-linux-gnu-ld: fs/f2fs/gc.o: in function
`has_not_enough_free_secs.constprop.0':
gc.c:(.text+0xe28): undefined reference to `__moddi3'
m68k-linux-gnu-ld: gc.c:(.text+0xe5c): undefined reference to `__divdi3'
m68k-linux-gnu-ld: fs/f2fs/gc.o: in function `f2fs_gc':
gc.c:(.text+0x2f2c): undefined reference to `__divdi3'
m68k-linux-gnu-ld: gc.c:(.text+0x2f58): undefined reference to `__divdi3'
m68k-linux-gnu-ld: gc.c:(.text+0x2f66): undefined reference to `__moddi3'
m68k-linux-gnu-ld: gc.c:(.text+0x2f96): undefined reference to `__moddi3'
m68k-linux-gnu-ld: fs/f2fs/data.o: in function
`has_not_enough_free_secs.constprop.0':
data.c:(.text+0xde8): undefined reference to `__moddi3'
m68k-linux-gnu-ld: data.c:(.text+0xe1c): undefined reference to `__divdi3'
m68k-linux-gnu-ld: fs/f2fs/segment.o: in function
`has_not_enough_free_secs.constprop.0':
segment.c:(.text+0x16ee): undefined reference to `__moddi3'
m68k-linux-gnu-ld: segment.c:(.text+0x1722): undefined reference to `__divd=
i3'
m68k-linux-gnu-ld: fs/f2fs/xattr.o: in function `f2fs_setxattr':
xattr.c:(.text+0xf5e): undefined reference to `__moddi3'
m68k-linux-gnu-ld: xattr.c:(.text+0xf8c): undefined reference to `__divdi3'

Other 32-bit architectures are affected, too, e.g. arm/shmobile_defconfig
+ CONFIG_F2FS_FS=3Dy:

arm-linux-gnueabihf-ld: fs/f2fs/file.o: in function
`has_not_enough_free_secs.constprop.0':
file.c:(.text+0x1d40): undefined reference to `__aeabi_ldivmod'
arm-linux-gnueabihf-ld: file.c:(.text+0x1d5c): undefined reference to
`__aeabi_ldivmod'
arm-linux-gnueabihf-ld: fs/f2fs/file.o: in function `f2fs_defragment_range'=
:
file.c:(.text+0x2018): undefined reference to `__aeabi_ldivmod'
arm-linux-gnueabihf-ld: fs/f2fs/inode.o: in function `f2fs_write_inode':
inode.c:(.text+0x19d4): undefined reference to `__aeabi_ldivmod'
arm-linux-gnueabihf-ld: inode.c:(.text+0x19f0): undefined reference to
`__aeabi_ldivmod'
arm-linux-gnueabihf-ld: fs/f2fs/namei.o:namei.c:(.text+0x12bc): more
undefined references to `__aeabi_ldivmod' follow

Manually reverting 5fa6a97d27842dab fixes the issue.

64-bit divisions (iff needed at all) must not be open-coded, but use
the helpers from <linux/math64.h> instead.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

