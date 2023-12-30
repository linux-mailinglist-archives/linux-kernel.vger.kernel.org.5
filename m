Return-Path: <linux-kernel+bounces-13588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB83820871
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 21:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715FC1C21D58
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C3FC2C6;
	Sat, 30 Dec 2023 20:18:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E69C128;
	Sat, 30 Dec 2023 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b6838a.dsl.pool.telekom.hu [::ffff:81.182.131.138])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072293.0000000065907AFF.0014EE4E; Sat, 30 Dec 2023 21:18:07 +0100
Message-ID: <3933d97638cfe57de5f9651b1f9a168bf88e43a5.camel@irl.hu>
Subject: Re: [PATCH v2 0/4] ALSA: hda/tas2781: Add tas2563 support
From: Gergo Koteles <soyer@irl.hu>
To: Takashi Iwai <tiwai@suse.de>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Date: Sat, 30 Dec 2023 21:18:06 +0100
In-Reply-To: <87il4fwrs1.wl-tiwai@suse.de>
References: <cover.1701906455.git.soyer@irl.hu>
	 <cover.1703891777.git.soyer@irl.hu> <87il4fwrs1.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Takashi,

On Sat, 2023-12-30 at 17:59 +0100, Takashi Iwai wrote:
> Thanks, I guess I'll take this series later for 6.8 unless any
> objection is raised from reviewers.
>=20
> But, I'd like to hear clarifications of some points beforehand:
>=20
> - Did we get consensus about the ACPI HID?  I didn't follow the
>   previous thread completely.
>=20

The INT8866 is a (wrong) PNP ID, that should only be used by the owner
"Interphase Corporation".
Intel has also mistakenly used the INT PNP prefix in the past, and now
TI/leNovo.

>   Since those models have been already in the market for quite some
>   time, we'd have to accept "INT8866", I'm afraid.  But it's still
>   very important to know whether a similar problem can be avoided in
>   future.
>=20
> - Will be the firmware files upstreamed to linux-firmware tree later?
>   Otherwise users will have significant difficulties.

Shenghao sent the two files=C2=A0to linux-firmware@kernel.org a few days
ago, but I think the "Allegedly GPLv2+ ... Found in hex form in kernel
source." Licence needs to be fixed before acceptance.

But even if it is not included in the linux-firmware package, it is
easier for users to put two files in place per OS installation than
patching the kernel.


Regards,
Gergo


