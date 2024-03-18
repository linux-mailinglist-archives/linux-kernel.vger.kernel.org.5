Return-Path: <linux-kernel+bounces-105789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8E87E47A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39E0B20FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DA2421D;
	Mon, 18 Mar 2024 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5Iwmfp3F"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC12263E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748528; cv=none; b=TTI+Mx3I9a0jU0LcLzqTEOy5Rw0JYEFeO25UEycNTEBPPmg7Vvn3UmLpMAOSeVJQLLna6n7R7Ow18GBe/xo17XGCNpspvKY1fZBPmGZ37105z5EWJ9E6rIbMlgAYEKULix4cfDKxFJHqyLSVtjHVh4CT6gIepugbahjtKRqx7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748528; c=relaxed/simple;
	bh=oWFse9ekt4BN9hGStBO3ysp4OZBQ/mn4vNBp7g52xSg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fsuvXNb5ionUcBvWxfgi/nvlfUlXlImkIOuxIBrAhv8lgGZvmcnctRflHHVFCwJMm9hr5+fLbkDSwPLK6mpaU9pkQQ9R6SVbINTt5NfB1jr8E4uNXt8FRvuVsiMEfEH88Jn8/aykX1/28eWgmNQkI256FOJIqhyLXfLoOEV4WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5Iwmfp3F; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568a53d2ce0so4562579a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1710748522; x=1711353322; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0wM7gb+uYqIRwVS3G2mY0QK2Uz/D6Ti8QCtsKMjfqM=;
        b=5Iwmfp3FflbfPfmUbx89UOyqJRK1FRQ4AFPHU7g1tmo0Bw3cP7bMMAmQC9FNzYzixc
         8YK9I9/2xPryEIT6VE4R7ialn6zWYnXUzJaPCa2xe3jCRN/7iDAVAzNeuxLBV9FP2wmL
         3+92u3RqbUMhJlVJJ9KbtvUSswrfwsnLSNsEtZbsId7YWNWrRN2rUg0nrtdkOgf1R3ML
         I5JsOkZJz3LW4shqRDdBApC59J/q7xE2HIKE2si/o7Js2lNVpXiRlYXWUT4UPTX+W2vQ
         CIyzHFerr6ZYHINCtNZPlpqwV961xZBqa8OUb3pB0HNBq0SbarKguWStXniXiyiX41wS
         yI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748522; x=1711353322;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I0wM7gb+uYqIRwVS3G2mY0QK2Uz/D6Ti8QCtsKMjfqM=;
        b=mraPCxIAam+ZtFkv6Ihy4ZImvF1/DKWoFQ167yotIafHyGpuQdDxCSMoFHPSqpJwFn
         Cm0+n4DDFj/ODdNrwPRs6ZODgyI0MVVCUq6QIw+Rbh4Y3ZqFjawpo0mFD795OgXXpIje
         bTDlJX7FgW+nK/g2gy1BvA9X1uTyEp1Oct4tI5AT2CH4U9gYiSypDb6bGxSJA1sF+pHi
         KW1gGcd4QbTgRGUSTd9M7GLgeas8Jukq+uU3xpyeS0EKV4Db4W/J5GSbfmnPSS0v3M1e
         +TnvyXLXIZAT/gehPq/mb1cTRk3afcFOloZlV5XTduvo8/Q7RC3zWeEDVRcKz6SMQO17
         nxqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3zWBCJW58rOjY9cm5m4p2r1uGbvtxnGh+Uljn04Kn5MCezJspHzzudBbLxwAGsZG2pu2/Y/A2a5XV8PD3UKapPYbV++BjVhHZI1uR
X-Gm-Message-State: AOJu0YwUgjvXYet/ySWIIKz+/LPZ044pLWMwBv/fhwWhmzTKOO8PcSs3
	L0wwW80wIdPE47HpuFzAJbkB7RDHR8RXNmTGH6ef5uXVPxQHVtXfjpQ0mwOejvc=
X-Google-Smtp-Source: AGHT+IGGtm5WZgLzsC1Q2ueS2Uq2APfDGSbekxZp76Rh22abzFr7/qjGZFERQdIYNyt7IAcyPcDqMw==
X-Received: by 2002:a17:906:acf:b0:a46:7780:bdb3 with SMTP id z15-20020a1709060acf00b00a467780bdb3mr6010896ejf.53.1710748521961;
        Mon, 18 Mar 2024 00:55:21 -0700 (PDT)
Received: from localhost (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id l3-20020a1709061c4300b00a46a3ad035esm2545440ejg.179.2024.03.18.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 08:55:20 +0100
Message-Id: <CZWPQKXWWDJF.31PYCW52I63O6@fairphone.com>
Subject: Re: ERROR: modpost: "devm_drm_of_get_bridge"
 [drivers/usb/typec/mux/ptn36502.ko] undefined!
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "kernel test robot" <lkp@intel.com>
Cc: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.15.2
References: <202403161449.bV9MUszO-lkp@intel.com>
In-Reply-To: <202403161449.bV9MUszO-lkp@intel.com>

On Sat Mar 16, 2024 at 7:23 AM CET, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   66a27abac311a30edbbb65fe8c41ff1b13876faa
> commit: 8e99dc783648e5e663494434544bdc5160522de3 usb: typec: add support =
for PTN36502 redriver
> date:   5 months ago
> config: riscv-randconfig-r064-20240311 (https://download.01.org/0day-ci/a=
rchive/20240316/202403161449.bV9MUszO-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240316/202403161449.bV9MUszO-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403161449.bV9MUszO-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/locktort=
ure.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcutorture.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/rcuscale.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/rcu/refscale.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/torture.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nfs/nfsv4.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/nls/nls_ucs2_utils.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_arc4=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/smb/common/cifs_md4.=
o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/gpu/drm/drm_pan=
el_orientation_quirks.o
> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/usb/typec/mux/nb7vpq904=
m.ko] undefined!
> >> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/usb/typec/mux/ptn365=
02.ko] undefined!

This should be fixed by the patch I sent a while ago:
https://lore.kernel.org/lkml/20240111-drm-panel-bridge-fixup-v1-1-e06292f6f=
500@fairphone.com/

Regards
Luca

