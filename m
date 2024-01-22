Return-Path: <linux-kernel+bounces-32540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E2B835CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89B51C2142A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE9347A1;
	Mon, 22 Jan 2024 08:42:55 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FE3839A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912974; cv=none; b=bNnUFSJ5y78cDkJTjfn+kxm9hdQuKBAkHdiVQKwuws8mT2XrQzVYBVFQOqUUYtNN5mxvmGMBnBwo7apOVEKv4fY9CgW+Bo3TIksZ5OAz0IXZS9DtKDC+78Pz32yrVEkFaWVU14OGxMt9P7BaNl54DowF/AYmDyygoeQkto+Kq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912974; c=relaxed/simple;
	bh=53AcOeGD0p7nbe5TjajfohEKjEBXxQ84zejXF9ZzjXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bi3EXV10iwz5Kw7BxS5+9BQblZf3u0fUU7TgCS1ee+0chAmyOXToPbvu1fOlp6nWC4JZfoesfMTWBwNvVYQzCsyatUfKPL/sNob4jrjAjxqhiWf4btEPSYvLKJSiXTJX/W/QZq7RBc2chqngudtGlhxlyDae7IM5tw3ABCE3x5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5ff7a8b5e61so22679667b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912971; x=1706517771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wzva1Y3egJkJwaa7xDcetdIkG2yn3nRK1Yg5xorbkj4=;
        b=ho9gRlmDwOjJia8E4skOcI6PyKeGe0zh76SsqmdkgAEV+y5FAfpdhCFRLnz3Q6/+ef
         5ze+DR5MwKNP4kd4QFVAsAuacgwMsBzYekaCvgfsj2nm0Zi9yqB69N3rcDT+kPAUQez3
         9eyfaXkn4Jwzw4lrhCneP4JYngXrdQnRi75rZ3JKubQjstWAWr4xbrQU/zBc5X1x0W/F
         6eYMWijuEBtOwSH2Aq94yN+T4VboVeewX3+tG0kOiz950McYeYq3+0cX7Gd+21drnvww
         HiorvNlEjL+kNmmawJhzWsMGLsxN9VL4HQ5f/+zUR+5jjMw6aBvPN7CIRixBSAY6mhRX
         O/lA==
X-Gm-Message-State: AOJu0YxP36uDYDKekxXOpCn+IoX3PsPpIJHtORUKrLDykoWsqvjbRbji
	M5wdXovprCoNjpJIMHgTpEHxHyVDwLqI6tBezwIX0vebEs+p0zq3nYek+3+fNq0=
X-Google-Smtp-Source: AGHT+IFmHSyd6g56UWErubGlZXiXo6Aeavvban2BS2cQUewD/KuVfqrbbpv9CA774VIT/4ThKXSk2g==
X-Received: by 2002:a81:83ce:0:b0:5ff:9428:a8af with SMTP id t197-20020a8183ce000000b005ff9428a8afmr3436199ywf.66.1705912970635;
        Mon, 22 Jan 2024 00:42:50 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id s9-20020a819b09000000b005ff81bbfd66sm3370009ywg.136.2024.01.22.00.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:42:50 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-600094c5703so3039407b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:42:50 -0800 (PST)
X-Received: by 2002:a81:c24c:0:b0:5ff:a51a:8db3 with SMTP id
 t12-20020a81c24c000000b005ffa51a8db3mr3037461ywg.26.1705912970152; Mon, 22
 Jan 2024 00:42:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za4nzDtwGVA+U1OL@rli9-mobl>
In-Reply-To: <Za4nzDtwGVA+U1OL@rli9-mobl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jan 2024 09:42:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWvX-sUaXc=WMOU_yCQWwkTkCb3i+swHKpHQAz1BKUOJg@mail.gmail.com>
Message-ID: <CAMuHMdWvX-sUaXc=WMOU_yCQWwkTkCb3i+swHKpHQAz1BKUOJg@mail.gmail.com>
Subject: Re: sound/ac97/bus.c:192: warning: Function parameter or member 'drv'
 not described in 'snd_ac97_codec_driver_register'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kernel Test Robot,

On Mon, Jan 22, 2024 at 9:31=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
> First bad commit (maybe !=3D root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   ac865f00af293d081356bec56eea90815094a60e
> commit: ea00d95200d02ece71f5814d41b14f2eb16d598b ASoC: Use imply for SND_=
SOC_ALL_CODECS
> date:   3 years, 11 months ago
> :::::: branch date: 16 hours ago
> :::::: commit date: 3 years, 11 months ago
> config: x86_64-buildonly-randconfig-003-20231102 (https://download.01.org=
/0day-ci/archive/20240104/202401042239.2zkHgzki-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240104/202401042239.2zkHgzki-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202401042239.2zkHgzki-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> sound/ac97/bus.c:192: warning: Function parameter or member 'drv' not =
described in 'snd_ac97_codec_driver_register'
> >> sound/ac97/bus.c:192: warning: Excess function parameter 'dev' descrip=
tion in 'snd_ac97_codec_driver_register'
> >> sound/ac97/bus.c:205: warning: Function parameter or member 'drv' not =
described in 'snd_ac97_codec_driver_unregister'
> >> sound/ac97/bus.c:205: warning: Excess function parameter 'dev' descrip=
tion in 'snd_ac97_codec_driver_unregister'
> >> sound/ac97/bus.c:351: warning: Function parameter or member 'codecs_pd=
ata' not described in 'snd_ac97_controller_register'

Definitely not introduced by my commit.
Origin is commit 74426fbff66eea8e ("ALSA: ac97: add an ac97 bus") in v4.15.


>
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for REGMAP_SPI
>    Depends on [n]: SPI [=3Dn]
>    Selected by [m]:
>    - SND_SOC_ADAU1781_SPI [=3Dm] && SOUND [=3Dy] && !UML && SND [=3Dm] &&=
 SND_SOC [=3Dm]
>    - SND_SOC_ADAU1977_SPI [=3Dm] && SOUND [=3Dy] && !UML && SND [=3Dm] &&=
 SND_SOC [=3Dm]
>
>
> vim +192 sound/ac97/bus.c
>
> 74426fbff66eea Robert Jarzmik 2017-09-02  181
> 74426fbff66eea Robert Jarzmik 2017-09-02  182  /**
> 74426fbff66eea Robert Jarzmik 2017-09-02  183   * snd_ac97_codec_driver_r=
egister - register an AC97 codec driver
> 74426fbff66eea Robert Jarzmik 2017-09-02  184   * @dev: AC97 driver codec=
 to register
> 74426fbff66eea Robert Jarzmik 2017-09-02  185   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  186   * Register an AC97 codec =
driver to the ac97 bus driver, aka. the AC97 digital
> 74426fbff66eea Robert Jarzmik 2017-09-02  187   * controller.
> 74426fbff66eea Robert Jarzmik 2017-09-02  188   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  189   * Returns 0 on success or=
 error code
> 74426fbff66eea Robert Jarzmik 2017-09-02  190   */
> 74426fbff66eea Robert Jarzmik 2017-09-02  191  int snd_ac97_codec_driver_=
register(struct ac97_codec_driver *drv)
> 74426fbff66eea Robert Jarzmik 2017-09-02 @192  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  193   drv->driver.bus =3D &ac97=
_bus_type;
> 74426fbff66eea Robert Jarzmik 2017-09-02  194   return driver_register(&d=
rv->driver);
> 74426fbff66eea Robert Jarzmik 2017-09-02  195  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  196  EXPORT_SYMBOL_GPL(snd_ac97=
_codec_driver_register);
> 74426fbff66eea Robert Jarzmik 2017-09-02  197
> 74426fbff66eea Robert Jarzmik 2017-09-02  198  /**
> 74426fbff66eea Robert Jarzmik 2017-09-02  199   * snd_ac97_codec_driver_u=
nregister - unregister an AC97 codec driver
> 74426fbff66eea Robert Jarzmik 2017-09-02  200   * @dev: AC97 codec driver=
 to unregister
> 74426fbff66eea Robert Jarzmik 2017-09-02  201   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  202   * Unregister a previously=
 registered ac97 codec driver.
> 74426fbff66eea Robert Jarzmik 2017-09-02  203   */
> 74426fbff66eea Robert Jarzmik 2017-09-02  204  void snd_ac97_codec_driver=
_unregister(struct ac97_codec_driver *drv)
> 74426fbff66eea Robert Jarzmik 2017-09-02 @205  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  206   driver_unregister(&drv->d=
river);
> 74426fbff66eea Robert Jarzmik 2017-09-02  207  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  208  EXPORT_SYMBOL_GPL(snd_ac97=
_codec_driver_unregister);
> 74426fbff66eea Robert Jarzmik 2017-09-02  209
> 74426fbff66eea Robert Jarzmik 2017-09-02  210  /**
> 74426fbff66eea Robert Jarzmik 2017-09-02  211   * snd_ac97_codec_get_plat=
data - get platform_data
> 74426fbff66eea Robert Jarzmik 2017-09-02  212   * @adev: the ac97 codec d=
evice
> 74426fbff66eea Robert Jarzmik 2017-09-02  213   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  214   * For legacy platforms, i=
n order to have platform_data in codec drivers
> 74426fbff66eea Robert Jarzmik 2017-09-02  215   * available, while ac97 d=
evice are auto-created upon probe, this retrieves the
> 74426fbff66eea Robert Jarzmik 2017-09-02  216   * platdata which was setu=
p on ac97 controller registration.
> 74426fbff66eea Robert Jarzmik 2017-09-02  217   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  218   * Returns the platform da=
ta pointer
> 74426fbff66eea Robert Jarzmik 2017-09-02  219   */
> 74426fbff66eea Robert Jarzmik 2017-09-02  220  void *snd_ac97_codec_get_p=
latdata(const struct ac97_codec_device *adev)
> 74426fbff66eea Robert Jarzmik 2017-09-02  221  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  222   struct ac97_controller *a=
c97_ctrl =3D adev->ac97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  223
> 74426fbff66eea Robert Jarzmik 2017-09-02  224   return ac97_ctrl->codecs_=
pdata[adev->num];
> 74426fbff66eea Robert Jarzmik 2017-09-02  225  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  226  EXPORT_SYMBOL_GPL(snd_ac97=
_codec_get_platdata);
> 74426fbff66eea Robert Jarzmik 2017-09-02  227
> 74426fbff66eea Robert Jarzmik 2017-09-02  228  static void ac97_ctrl_code=
cs_unregister(struct ac97_controller *ac97_ctrl)
> 74426fbff66eea Robert Jarzmik 2017-09-02  229  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  230   int i;
> 74426fbff66eea Robert Jarzmik 2017-09-02  231
> 74426fbff66eea Robert Jarzmik 2017-09-02  232   for (i =3D 0; i < AC97_BU=
S_MAX_CODECS; i++)
> 74426fbff66eea Robert Jarzmik 2017-09-02  233           if (ac97_ctrl->co=
decs[i]) {
> 74426fbff66eea Robert Jarzmik 2017-09-02  234                   ac97_ctrl=
->codecs[i]->ac97_ctrl =3D &ac97_unbound_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  235                   device_un=
register(&ac97_ctrl->codecs[i]->dev);
> 74426fbff66eea Robert Jarzmik 2017-09-02  236           }
> 74426fbff66eea Robert Jarzmik 2017-09-02  237  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  238
> 74426fbff66eea Robert Jarzmik 2017-09-02  239  static ssize_t cold_reset_=
store(struct device *dev,
> 74426fbff66eea Robert Jarzmik 2017-09-02  240                           s=
truct device_attribute *attr, const char *buf,
> 74426fbff66eea Robert Jarzmik 2017-09-02  241                           s=
ize_t len)
> 74426fbff66eea Robert Jarzmik 2017-09-02  242  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  243   struct ac97_controller *a=
c97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  244
> 74426fbff66eea Robert Jarzmik 2017-09-02  245   mutex_lock(&ac97_controll=
ers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  246   ac97_ctrl =3D to_ac97_con=
troller(dev);
> 74426fbff66eea Robert Jarzmik 2017-09-02  247   ac97_ctrl->ops->reset(ac9=
7_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  248   mutex_unlock(&ac97_contro=
llers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  249   return len;
> 74426fbff66eea Robert Jarzmik 2017-09-02  250  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  251  static DEVICE_ATTR_WO(cold=
_reset);
> 74426fbff66eea Robert Jarzmik 2017-09-02  252
> 74426fbff66eea Robert Jarzmik 2017-09-02  253  static ssize_t warm_reset_=
store(struct device *dev,
> 74426fbff66eea Robert Jarzmik 2017-09-02  254                           s=
truct device_attribute *attr, const char *buf,
> 74426fbff66eea Robert Jarzmik 2017-09-02  255                           s=
ize_t len)
> 74426fbff66eea Robert Jarzmik 2017-09-02  256  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  257   struct ac97_controller *a=
c97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  258
> 74426fbff66eea Robert Jarzmik 2017-09-02  259   if (!dev)
> 74426fbff66eea Robert Jarzmik 2017-09-02  260           return -ENODEV;
> 74426fbff66eea Robert Jarzmik 2017-09-02  261
> 74426fbff66eea Robert Jarzmik 2017-09-02  262   mutex_lock(&ac97_controll=
ers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  263   ac97_ctrl =3D to_ac97_con=
troller(dev);
> 74426fbff66eea Robert Jarzmik 2017-09-02  264   ac97_ctrl->ops->warm_rese=
t(ac97_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  265   mutex_unlock(&ac97_contro=
llers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  266   return len;
> 74426fbff66eea Robert Jarzmik 2017-09-02  267  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  268  static DEVICE_ATTR_WO(warm=
_reset);
> 74426fbff66eea Robert Jarzmik 2017-09-02  269
> 74426fbff66eea Robert Jarzmik 2017-09-02  270  static struct attribute *a=
c97_controller_device_attrs[] =3D {
> 74426fbff66eea Robert Jarzmik 2017-09-02  271   &dev_attr_cold_reset.attr=
,
> 74426fbff66eea Robert Jarzmik 2017-09-02  272   &dev_attr_warm_reset.attr=
,
> 74426fbff66eea Robert Jarzmik 2017-09-02  273   NULL
> 74426fbff66eea Robert Jarzmik 2017-09-02  274  };
> 74426fbff66eea Robert Jarzmik 2017-09-02  275
> 74426fbff66eea Robert Jarzmik 2017-09-02  276  static struct attribute_gr=
oup ac97_adapter_attr_group =3D {
> 74426fbff66eea Robert Jarzmik 2017-09-02  277   .name   =3D "ac97_operati=
ons",
> 74426fbff66eea Robert Jarzmik 2017-09-02  278   .attrs  =3D ac97_controll=
er_device_attrs,
> 74426fbff66eea Robert Jarzmik 2017-09-02  279  };
> 74426fbff66eea Robert Jarzmik 2017-09-02  280
> 74426fbff66eea Robert Jarzmik 2017-09-02  281  static const struct attrib=
ute_group *ac97_adapter_groups[] =3D {
> 74426fbff66eea Robert Jarzmik 2017-09-02  282   &ac97_adapter_attr_group,
> 74426fbff66eea Robert Jarzmik 2017-09-02  283   NULL,
> 74426fbff66eea Robert Jarzmik 2017-09-02  284  };
> 74426fbff66eea Robert Jarzmik 2017-09-02  285
> 74426fbff66eea Robert Jarzmik 2017-09-02  286  static void ac97_del_adapt=
er(struct ac97_controller *ac97_ctrl)
> 74426fbff66eea Robert Jarzmik 2017-09-02  287  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  288   mutex_lock(&ac97_controll=
ers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  289   ac97_ctrl_codecs_unregist=
er(ac97_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  290   list_del(&ac97_ctrl->cont=
rollers);
> 74426fbff66eea Robert Jarzmik 2017-09-02  291   mutex_unlock(&ac97_contro=
llers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  292
> 74426fbff66eea Robert Jarzmik 2017-09-02  293   device_unregister(&ac97_c=
trl->adap);
> 74426fbff66eea Robert Jarzmik 2017-09-02  294  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  295
> 74426fbff66eea Robert Jarzmik 2017-09-02  296  static void ac97_adapter_r=
elease(struct device *dev)
> 74426fbff66eea Robert Jarzmik 2017-09-02  297  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  298   struct ac97_controller *a=
c97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  299
> 74426fbff66eea Robert Jarzmik 2017-09-02  300   ac97_ctrl =3D to_ac97_con=
troller(dev);
> 74426fbff66eea Robert Jarzmik 2017-09-02  301   idr_remove(&ac97_adapter_=
idr, ac97_ctrl->nr);
> 74426fbff66eea Robert Jarzmik 2017-09-02  302   dev_dbg(&ac97_ctrl->adap,=
 "adapter unregistered by %s\n",
> 74426fbff66eea Robert Jarzmik 2017-09-02  303           dev_name(ac97_ctr=
l->parent));
> 74426fbff66eea Robert Jarzmik 2017-09-02  304  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  305
> 74426fbff66eea Robert Jarzmik 2017-09-02  306  static const struct device=
_type ac97_adapter_type =3D {
> 74426fbff66eea Robert Jarzmik 2017-09-02  307   .groups         =3D ac97_=
adapter_groups,
> 74426fbff66eea Robert Jarzmik 2017-09-02  308   .release        =3D ac97_=
adapter_release,
> 74426fbff66eea Robert Jarzmik 2017-09-02  309  };
> 74426fbff66eea Robert Jarzmik 2017-09-02  310
> 74426fbff66eea Robert Jarzmik 2017-09-02  311  static int ac97_add_adapte=
r(struct ac97_controller *ac97_ctrl)
> 74426fbff66eea Robert Jarzmik 2017-09-02  312  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  313   int ret;
> 74426fbff66eea Robert Jarzmik 2017-09-02  314
> 74426fbff66eea Robert Jarzmik 2017-09-02  315   mutex_lock(&ac97_controll=
ers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  316   ret =3D idr_alloc(&ac97_a=
dapter_idr, ac97_ctrl, 0, 0, GFP_KERNEL);
> 74426fbff66eea Robert Jarzmik 2017-09-02  317   ac97_ctrl->nr =3D ret;
> 74426fbff66eea Robert Jarzmik 2017-09-02  318   if (ret >=3D 0) {
> 74426fbff66eea Robert Jarzmik 2017-09-02  319           dev_set_name(&ac9=
7_ctrl->adap, "ac97-%d", ret);
> 74426fbff66eea Robert Jarzmik 2017-09-02  320           ac97_ctrl->adap.t=
ype =3D &ac97_adapter_type;
> 74426fbff66eea Robert Jarzmik 2017-09-02  321           ac97_ctrl->adap.p=
arent =3D ac97_ctrl->parent;
> 74426fbff66eea Robert Jarzmik 2017-09-02  322           ret =3D device_re=
gister(&ac97_ctrl->adap);
> 74426fbff66eea Robert Jarzmik 2017-09-02  323           if (ret)
> 74426fbff66eea Robert Jarzmik 2017-09-02  324                   put_devic=
e(&ac97_ctrl->adap);
> 74426fbff66eea Robert Jarzmik 2017-09-02  325   }
> 74426fbff66eea Robert Jarzmik 2017-09-02  326   if (!ret)
> 74426fbff66eea Robert Jarzmik 2017-09-02  327           list_add(&ac97_ct=
rl->controllers, &ac97_controllers);
> 74426fbff66eea Robert Jarzmik 2017-09-02  328   mutex_unlock(&ac97_contro=
llers_mutex);
> 74426fbff66eea Robert Jarzmik 2017-09-02  329
> 74426fbff66eea Robert Jarzmik 2017-09-02  330   if (!ret)
> 74426fbff66eea Robert Jarzmik 2017-09-02  331           dev_dbg(&ac97_ctr=
l->adap, "adapter registered by %s\n",
> 74426fbff66eea Robert Jarzmik 2017-09-02  332                   dev_name(=
ac97_ctrl->parent));
> 74426fbff66eea Robert Jarzmik 2017-09-02  333   return ret;
> 74426fbff66eea Robert Jarzmik 2017-09-02  334  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  335
> 74426fbff66eea Robert Jarzmik 2017-09-02  336  /**
> 74426fbff66eea Robert Jarzmik 2017-09-02  337   * snd_ac97_controller_reg=
ister - register an ac97 controller
> 74426fbff66eea Robert Jarzmik 2017-09-02  338   * @ops: the ac97 bus oper=
ations
> 74426fbff66eea Robert Jarzmik 2017-09-02  339   * @dev: the device provid=
ing the ac97 DC function
> 74426fbff66eea Robert Jarzmik 2017-09-02  340   * @slots_available: mask =
of the ac97 codecs that can be scanned and probed
> 74426fbff66eea Robert Jarzmik 2017-09-02  341   *                   bit0 =
=3D> codec 0, bit1 =3D> codec 1 ... bit 3 =3D> codec 3
> 74426fbff66eea Robert Jarzmik 2017-09-02  342   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  343   * Register a digital cont=
roller which can control up to 4 ac97 codecs. This is
> 74426fbff66eea Robert Jarzmik 2017-09-02  344   * the controller side of =
the AC97 AC-link, while the slave side are the codecs.
> 74426fbff66eea Robert Jarzmik 2017-09-02  345   *
> 74426fbff66eea Robert Jarzmik 2017-09-02  346   * Returns a valid control=
ler upon success, negative pointer value upon error
> 74426fbff66eea Robert Jarzmik 2017-09-02  347   */
> 74426fbff66eea Robert Jarzmik 2017-09-02  348  struct ac97_controller *sn=
d_ac97_controller_register(
> 74426fbff66eea Robert Jarzmik 2017-09-02  349   const struct ac97_control=
ler_ops *ops, struct device *dev,
> 74426fbff66eea Robert Jarzmik 2017-09-02  350   unsigned short slots_avai=
lable, void **codecs_pdata)
> 74426fbff66eea Robert Jarzmik 2017-09-02 @351  {
> 74426fbff66eea Robert Jarzmik 2017-09-02  352   struct ac97_controller *a=
c97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  353   int ret, i;
> 74426fbff66eea Robert Jarzmik 2017-09-02  354
> 74426fbff66eea Robert Jarzmik 2017-09-02  355   ac97_ctrl =3D kzalloc(siz=
eof(*ac97_ctrl), GFP_KERNEL);
> 74426fbff66eea Robert Jarzmik 2017-09-02  356   if (!ac97_ctrl)
> 74426fbff66eea Robert Jarzmik 2017-09-02  357           return ERR_PTR(-E=
NOMEM);
> 74426fbff66eea Robert Jarzmik 2017-09-02  358
> 74426fbff66eea Robert Jarzmik 2017-09-02  359   for (i =3D 0; i < AC97_BU=
S_MAX_CODECS && codecs_pdata; i++)
> 74426fbff66eea Robert Jarzmik 2017-09-02  360           ac97_ctrl->codecs=
_pdata[i] =3D codecs_pdata[i];
> 74426fbff66eea Robert Jarzmik 2017-09-02  361
> 74426fbff66eea Robert Jarzmik 2017-09-02  362   ac97_ctrl->ops =3D ops;
> 74426fbff66eea Robert Jarzmik 2017-09-02  363   ac97_ctrl->slots_availabl=
e =3D slots_available;
> 74426fbff66eea Robert Jarzmik 2017-09-02  364   ac97_ctrl->parent =3D dev=
;
> 74426fbff66eea Robert Jarzmik 2017-09-02  365   ret =3D ac97_add_adapter(=
ac97_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  366
> 74426fbff66eea Robert Jarzmik 2017-09-02  367   if (ret)
> 74426fbff66eea Robert Jarzmik 2017-09-02  368           goto err;
> 74426fbff66eea Robert Jarzmik 2017-09-02  369   ac97_bus_reset(ac97_ctrl)=
;
> 74426fbff66eea Robert Jarzmik 2017-09-02  370   ac97_bus_scan(ac97_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  371
> 74426fbff66eea Robert Jarzmik 2017-09-02  372   return ac97_ctrl;
> 74426fbff66eea Robert Jarzmik 2017-09-02  373  err:
> 74426fbff66eea Robert Jarzmik 2017-09-02  374   kfree(ac97_ctrl);
> 74426fbff66eea Robert Jarzmik 2017-09-02  375   return ERR_PTR(ret);
> 74426fbff66eea Robert Jarzmik 2017-09-02  376  }
> 74426fbff66eea Robert Jarzmik 2017-09-02  377  EXPORT_SYMBOL_GPL(snd_ac97=
_controller_register);
> 74426fbff66eea Robert Jarzmik 2017-09-02  378
>
> :::::: The code at line 192 was first introduced by commit
> :::::: 74426fbff66eea8e8d1f42c8238c268d1e63a832 ALSA: ac97: add an ac97 b=
us
>
> :::::: TO: Robert Jarzmik <robert.jarzmik@free.fr>
> :::::: CC: Mark Brown <broonie@kernel.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

