Return-Path: <linux-kernel+bounces-2978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B772781657B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD5282882
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2595399;
	Mon, 18 Dec 2023 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QUIaTDAh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAB538B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbd24b0f0e9so333660276.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 20:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702872117; x=1703476917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/dws8qihrRmeu0Tulyhju8JboXJbpC7pxItSGb6vIE=;
        b=QUIaTDAhSTDVg6SDJTS9RBt9Zvjqh04uSaEOh5qOhH58U3/xWwVnAkVoMWsCITpFDc
         GsBAN/Pzfs4g3am0fPN/ziokqmfSIDMzWzLBHnG56ctNF4cpWgqABw73K+D4TDFnjVs3
         O5S3UITS1OE9isPZGF+j4oJaYd0ca3qV9wuRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702872117; x=1703476917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/dws8qihrRmeu0Tulyhju8JboXJbpC7pxItSGb6vIE=;
        b=SxwiolWoBLTFF4EcBc73I65ycKo3KaFsrjMniK9D6livtbvq0BLTxfBIu3KYUTQ3kM
         7q+YJbI6VRT67GdOX369FnbTW1lyLNra5+/eg1gnyuKUkvlsSWiBZLMAwVwO1hswR0CK
         YW3ZT4LVrSpMwtKv7sxds3FK0LwvpM3ed0bvRd0ATCSyHiaRXcVky9DbwjIb+beyiT9x
         I0tZFJZaLoEIfNBx8ptJGSvdBPcZHlrsWKPhVcjKvJLamZb8eZusuuFXziuM4CdNOeJD
         iwXWULVBERfKptRNBj0XNKnJKT8FrYqG86XRhNBdPMNiCErecACwsgRVRwetswy/2T8m
         mwOg==
X-Gm-Message-State: AOJu0Yzm1Rvsjwvvlqz5zFNrCDFqUtwZbehxCKwy4XX7CEgTBFcLtH4J
	pcCX9M8WoZu3/naCbXpAcnkAtB7XqXIFOMdBGFILjw==
X-Google-Smtp-Source: AGHT+IHijNr4JgfCbOCPk8oNO6u8b76+Do2wBQG4ojyi9QyBXY1t7VqzneGDFvpIBqbseVIp2XWDmlmzuaQvSf9yz9I=
X-Received: by 2002:a5b:787:0:b0:d9a:66a1:a957 with SMTP id
 b7-20020a5b0787000000b00d9a66a1a957mr9675360ybq.13.1702872117437; Sun, 17 Dec
 2023 20:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215234102.16574-1-rdunlap@infradead.org>
In-Reply-To: <20231215234102.16574-1-rdunlap@infradead.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Sun, 17 Dec 2023 23:01:46 -0500
Message-ID: <CABQX2QNRWsODj48LJpsjD1+5TKUT7JWE745rgBJ829z4woGCYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: fix all kernel-doc warnings in stdu
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	dri-devel@lists.freedesktop.org, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Zack Rusin <zackr@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 6:41=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> kernel test robot reports one kernel-doc warning in stdu, but
> running scripts/kernel-doc in -Wall mode reports several more,
> so fix all of them at one time:
>
> vmwgfx_stdu.c:76: warning: Excess struct member 'transfer' description in=
 'vmw_stdu_dirty'
> vmwgfx_stdu.c:103: warning: missing initial short description on line:
>  * struct vmw_screen_target_display_unit
> vmwgfx_stdu.c:215: warning: No description found for return value of 'vmw=
_stdu_bind_st'
> vmwgfx_stdu.c:320: warning: No description found for return value of 'vmw=
_stdu_destroy_st'
> vmwgfx_stdu.c:551: warning: No description found for return value of 'vmw=
_kms_stdu_readback'
> vmwgfx_stdu.c:719: warning: No description found for return value of 'vmw=
_kms_stdu_surface_dirty'
> vmwgfx_stdu.c:895: warning: No description found for return value of 'vmw=
_stdu_primary_plane_prepare_fb'
> vmwgfx_stdu.c:1470: warning: No description found for return value of 'vm=
w_stdu_init'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150347.5icezNlK-lkp@i=
ntel.com/
> Cc: Zack Rusin <zackr@vmware.com>
> Cc: VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> ---

LGTM. Thanks!

Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>

z

