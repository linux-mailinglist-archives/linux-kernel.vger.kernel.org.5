Return-Path: <linux-kernel+bounces-59115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654384F171
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4921F23717
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCAA664AF;
	Fri,  9 Feb 2024 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SAyVll43"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9C523B;
	Fri,  9 Feb 2024 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467829; cv=none; b=rG5hns45k8lhUWFpaIFSok7A6E3Biwq71WSQ0+W/QJ5WUZ1bV0kgNUjbOWq2kx9sPYQ+UcBDTsIfVg0hE5OtwlzlGK45ZTsMJzAfImcSeDVQXY0gZpHyyJV7qNyaNbHOYcDdgD6I+qFLeBg+p56fRru0JHs+W2nffoXBLiEr7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467829; c=relaxed/simple;
	bh=Oh0SoSjI5VGJ7QZhqJzBYomJfQSHUKNku+PlPGCbYMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvKOHajZWxo7HL8c75kBIL7gZ8/yWn3Ojnu7t1AF8WYGo3Ok0Nev2+eForNUUI4twqi8RT7i3+vM+UbSNfOctmHViMX+LHam2h9Gqfe+EHeQkwb2Mxou40rKZWtX9zjmC5VMH9uirQvQozig3xqfclMIKfr67+QsHTLg3LgBzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SAyVll43; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707467825; x=1739003825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMejX3VOvtM/mNvTQc+8XsLkkiURtYyo0DALDxqQj/s=;
  b=SAyVll43sRhw4ewwoaa1aDQWS3ut3HYEnAOc/80VdgpsqwnD8SGkpEDD
   Fba0FnopHN+BbVDrIKxY+CkrqavjfmbWCd1+BvVkRSsLvdJJJc6WSqAas
   nImE6KUpRwMz32bSMX/Do1E7VYLOEyh5x2YdH6KcEzQokiLWUoh+4I9BC
   +WHBghx1cFh+MPFq8N2SO+sDZA3IGOFi/W6YKmlqzhNHpupxG2GJHwXdC
   DUxTJ2TVkAjAzEUyXePTFsQc3l/q+7PHTu588q5j63mhBC28n2Seabcqu
   5Aettc+/qCBuapU0uQZ1WLF1EMGU0MY6s9Rwh4ZDbtRw5ZTA1eyQjubBD
   A==;
X-IronPort-AV: E=Sophos;i="6.05,256,1701126000"; 
   d="scan'208";a="35329826"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Feb 2024 09:37:02 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 80AEF280075;
	Fri,  9 Feb 2024 09:37:02 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: andersson@kernel.org, linus.walleij@linaro.org, Maria Yu <quic_aiquny@quicinc.com>
Cc: Maria Yu <quic_aiquny@quicinc.com>, kernel@quicinc.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] pinctrl: Add lock to ensure the state atomization
Date: Fri, 09 Feb 2024 09:37:03 +0100
Message-ID: <8376074.NyiUUSuA9g@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240202105854.26446-1-quic_aiquny@quicinc.com>
References: <20240202105854.26446-1-quic_aiquny@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 2. Februar 2024, 11:58:54 CET schrieb Maria Yu:
> Currently pinctrl_select_state is an export symbol and don't have
> effective re-entrance protect design. During async probing of devices
> it's possible to end up in pinctrl_select_state() from multiple
> contexts simultaneously, so make it thread safe.
> More over, when the real racy happened, the system frequently have
> printk message like:
>   "not freeing pin xx (xxx) as part of deactivating group xxx - it is
> already used for some other setting".
> Finally the system crashed after the flood log.
> Add per pinctrl lock to ensure the old state and new state transition
> atomization.
> Also move dev error print message outside the region with interrupts
> disabled.
> Use scoped guard to simplify the lock protection needed code.
>=20
> Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
> ---
>  drivers/pinctrl/core.c | 143 +++++++++++++++++++++--------------------
>  drivers/pinctrl/core.h |   2 +
>  2 files changed, 75 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> index ee56856cb80c..1f7d001d4c1e 100644
> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -1061,6 +1061,7 @@ static struct pinctrl *create_pinctrl(struct device
> *dev, p->dev =3D dev;
>  	INIT_LIST_HEAD(&p->states);
>  	INIT_LIST_HEAD(&p->dt_maps);
> +	spin_lock_init(&p->lock);
>=20
>  	ret =3D pinctrl_dt_to_map(p, pctldev);
>  	if (ret < 0) {
> @@ -1257,93 +1258,95 @@ static void pinctrl_link_add(struct pinctrl_dev
> *pctldev, static int pinctrl_commit_state(struct pinctrl *p, struct
> pinctrl_state *state) {
>  	struct pinctrl_setting *setting, *setting2;
> -	struct pinctrl_state *old_state =3D READ_ONCE(p->state);
> +	struct pinctrl_state *old_state;
>  	int ret;
>=20
> -	if (old_state) {
> -		/*
> -		 * For each pinmux setting in the old state, forget SW's=20
record
> -		 * of mux owner for that pingroup. Any pingroups which are
> -		 * still owned by the new state will be re-acquired by the=20
call
> -		 * to pinmux_enable_setting() in the loop below.
> -		 */
> -		list_for_each_entry(setting, &old_state->settings, node) {
> -			if (setting->type !=3D PIN_MAP_TYPE_MUX_GROUP)
> -				continue;
> -			pinmux_disable_setting(setting);
> +	scoped_guard(spinlock_irqsave, &p->lock) {
> +		old_state =3D p->state;
> +		if (old_state) {
> +			/*
> +			 * For each pinmux setting in the old state,=20
forget SW's record
> +			 * of mux owner for that pingroup. Any pingroups=20
which are
> +			 * still owned by the new state will be re-
acquired by the call
> +			 * to pinmux_enable_setting() in the loop below.
> +			 */
> +			list_for_each_entry(setting, &old_state-
>settings, node) {
> +				if (setting->type !=3D=20
PIN_MAP_TYPE_MUX_GROUP)
> +					continue;
> +				pinmux_disable_setting(setting);
> +			}
>  		}
> -	}
> -
> -	p->state =3D NULL;
>=20
> -	/* Apply all the settings for the new state - pinmux first */
> -	list_for_each_entry(setting, &state->settings, node) {
> -		switch (setting->type) {
> -		case PIN_MAP_TYPE_MUX_GROUP:
> -			ret =3D pinmux_enable_setting(setting);
> -			break;
> -		case PIN_MAP_TYPE_CONFIGS_PIN:
> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
> -			ret =3D 0;
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -			break;
> -		}
> +		p->state =3D NULL;
>=20
> -		if (ret < 0)
> -			goto unapply_new_state;
> +		/* Apply all the settings for the new state - pinmux first=20
*/
> +		list_for_each_entry(setting, &state->settings, node) {
> +			switch (setting->type) {
> +			case PIN_MAP_TYPE_MUX_GROUP:
> +				ret =3D pinmux_enable_setting(setting);
> +				break;
> +			case PIN_MAP_TYPE_CONFIGS_PIN:
> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
> +				ret =3D 0;
> +				break;
> +			default:
> +				ret =3D -EINVAL;
> +				break;
> +			}
>=20
> -		/* Do not link hogs (circular dependency) */
> -		if (p !=3D setting->pctldev->p)
> -			pinctrl_link_add(setting->pctldev, p->dev);
> -	}
> +			if (ret < 0)
> +				goto unapply_new_state;
>=20
> -	/* Apply all the settings for the new state - pinconf after */
> -	list_for_each_entry(setting, &state->settings, node) {
> -		switch (setting->type) {
> -		case PIN_MAP_TYPE_MUX_GROUP:
> -			ret =3D 0;
> -			break;
> -		case PIN_MAP_TYPE_CONFIGS_PIN:
> -		case PIN_MAP_TYPE_CONFIGS_GROUP:
> -			ret =3D pinconf_apply_setting(setting);
> -			break;
> -		default:
> -			ret =3D -EINVAL;
> -			break;
> +			/* Do not link hogs (circular dependency) */
> +			if (p !=3D setting->pctldev->p)
> +				pinctrl_link_add(setting->pctldev, p-
>dev);
>  		}
>=20
> -		if (ret < 0) {
> -			goto unapply_new_state;
> -		}
> +		/* Apply all the settings for the new state - pinconf=20
after */
> +		list_for_each_entry(setting, &state->settings, node) {
> +			switch (setting->type) {
> +			case PIN_MAP_TYPE_MUX_GROUP:
> +				ret =3D 0;
> +				break;
> +			case PIN_MAP_TYPE_CONFIGS_PIN:
> +			case PIN_MAP_TYPE_CONFIGS_GROUP:
> +				ret =3D pinconf_apply_setting(setting);
> +				break;
> +			default:
> +				ret =3D -EINVAL;
> +				break;
> +			}
>=20
> -		/* Do not link hogs (circular dependency) */
> -		if (p !=3D setting->pctldev->p)
> -			pinctrl_link_add(setting->pctldev, p->dev);
> -	}
> +			if (ret < 0)
> +				goto unapply_new_state;
>=20
> -	p->state =3D state;
> +			/* Do not link hogs (circular dependency) */
> +			if (p !=3D setting->pctldev->p)
> +				pinctrl_link_add(setting->pctldev, p-
>dev);
> +		}
>=20
> -	return 0;
> +		p->state =3D state;
> +
> +		return 0;
>=20
>  unapply_new_state:
> -	dev_err(p->dev, "Error applying setting, reverse things back\n");
>=20
> -	list_for_each_entry(setting2, &state->settings, node) {
> -		if (&setting2->node =3D=3D &setting->node)
> -			break;
> -		/*
> -		 * All we can do here is pinmux_disable_setting.
> -		 * That means that some pins are muxed differently now
> -		 * than they were before applying the setting (We can't
> -		 * "unmux a pin"!), but it's not a big deal since the pins
> -		 * are free to be muxed by another apply_setting.
> -		 */
> -		if (setting2->type =3D=3D PIN_MAP_TYPE_MUX_GROUP)
> -			pinmux_disable_setting(setting2);
> +		list_for_each_entry(setting2, &state->settings, node) {
> +			if (&setting2->node =3D=3D &setting->node)
> +				break;
> +			/*
> +			 * All we can do here is pinmux_disable_setting.
> +			 * That means that some pins are muxed=20
differently now
> +			 * than they were before applying the setting=20
(We can't
> +			 * "unmux a pin"!), but it's not a big deal=20
since the pins
> +			 * are free to be muxed by another=20
apply_setting.
> +			 */
> +			if (setting2->type =3D=3D PIN_MAP_TYPE_MUX_GROUP)
> +				pinmux_disable_setting(setting2);
> +		}
>  	}
>=20
> +	dev_err(p->dev, "Error applying setting, reverse things back\n");
>  	/* There's no infinite recursive loop here because p->state is NULL=20
*/
>  	if (old_state)
>  		pinctrl_select_state(p, old_state);
> diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> index 837fd5bd903d..6844edd38b4a 100644
> --- a/drivers/pinctrl/core.h
> +++ b/drivers/pinctrl/core.h
> @@ -12,6 +12,7 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/radix-tree.h>
> +#include <linux/spinlock.h>
>  #include <linux/types.h>
>=20
>  #include <linux/pinctrl/machine.h>
> @@ -91,6 +92,7 @@ struct pinctrl {
>  	struct pinctrl_state *state;
>  	struct list_head dt_maps;
>  	struct kref users;
> +	spinlock_t lock;
>  };
>=20
>  /**
>=20
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d

This breaks pinctrl-imx on imx8qxp:

[    1.170727] imx8qxp-pinctrl system-controller:pinctrl: initialized IMX=20
pinctrl driver
[    1.283968] BUG: sleeping function called from invalid context at kernel/
locking/mutex.c:283
[    1.292089] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 70,=20
name: kworker/u16:4
[    1.300341] preempt_count: 1, expected: 0
[    1.304337] RCU nest depth: 0, expected: 0
[    1.308423] CPU: 2 PID: 70 Comm: kworker/u16:4 Not tainted 6.8.0-rc3-
next-20240209+ #2267 0b2aeebc4d64f1aef3abdd5fede2a9b5162eb867
[    1.320148] Hardware name: TQ-Systems i.MX8QXP TQMa8XQP on MBa8Xx (DT)
[    1.326667] Workqueue: events_unbound deferred_probe_work_func
[    1.332486] Call trace:
[    1.334918]  dump_backtrace+0x90/0x10c
[    1.338653]  show_stack+0x14/0x1c
[    1.341954]  dump_stack_lvl+0x6c/0x80
[    1.345603]  dump_stack+0x14/0x1c
[    1.348904]  __might_resched+0x108/0x160
[    1.352813]  __might_sleep+0x58/0xb0
[    1.356375]  mutex_lock+0x20/0x74
[    1.359676]  imx_scu_call_rpc+0x44/0x2e8
[    1.363586]  imx_pinconf_set_scu+0x84/0x150
[    1.367756]  imx_pinconf_set+0x48/0x7c
[    1.371491]  pinconf_apply_setting+0x90/0x110
[    1.375835]  pinctrl_commit_state+0xcc/0x28c
[    1.380092]  pinctrl_select_state+0x18/0x28
[    1.384262]  pinctrl_bind_pins+0x1e4/0x26c
[    1.388345]  really_probe+0x60/0x3e0
[    1.391907]  __driver_probe_device+0x84/0x198
[    1.396251]  driver_probe_device+0x38/0x150
[    1.400421]  __device_attach_driver+0xcc/0x194
[    1.404851]  bus_for_each_drv+0x80/0xdc
[    1.408674]  __device_attach+0x9c/0x1d0
[    1.412496]  device_initial_probe+0x10/0x18
[    1.416666]  bus_probe_device+0xa4/0xa8
[    1.420489]  deferred_probe_work_func+0x9c/0xe8
[    1.425006]  process_one_work+0x14c/0x40c
[    1.429002]  worker_thread+0x304/0x414
[    1.432738]  kthread+0xf4/0x100
[    1.435866]  ret_from_fork+0x10/0x20

With this commit pin_config_set callbacks need to be atomic suddenly which =
is=20
a no-go for any device attached to i2c or spi and in this case IPC RPC.
Once reverted systems start normally again.

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



