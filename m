Return-Path: <linux-kernel+bounces-103913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6990F87C67E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F6F283023
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C3111CBD;
	Thu, 14 Mar 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMrGkmHI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A17210798;
	Thu, 14 Mar 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710459456; cv=none; b=PUBDnMDy8xM8PvMJjbH//eiq9QJFUdE8R22f0gK9XSPxE+Pj/+sxfZg9nARB7+Y0CDcR9FEQOD+A0kp49EGfKDWA/0JwSJ5nFqJpcBotvmoEBDWBqIP3uQD0hkfX6qEUny+ge9ILlK7O06ZdlMJwCC46uIUXHXOCPaooLG6M07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710459456; c=relaxed/simple;
	bh=jlyAYfa5ICpKXn+qyd19xMm4fefKCgeCjNzVQ2M59sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhJHJ6y6Lp0Eic/MMWoXOB4xrq7BDFiUJrelM9EbhbY28gPN23pWST/+T0J0+/s6l1n9QlPH6fwzdjRNFtiHsU21acw4iF+pxpRro5///IUTkkR9Y0a2j/CAaQLL1GRqV5EY8kHPNhGaAAZPhe5wJx9//fHNeTl1ch/IPhO8oo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMrGkmHI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso1999760a12.2;
        Thu, 14 Mar 2024 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710459453; x=1711064253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmpupRoQTR98i+0BALoB9IZnxDmgxkFF3hs7MfwHtOw=;
        b=TMrGkmHIfrhiiiSqqFVmR7s6VFBE6sriW0UMu7SvPkI5VWLsBoMmwK0OblLj7eCzT9
         DADkUdq39XFYouw0/WuMPg6kAvGXrk0Sf2xJifFBxFgzXQkvj+nxi35LCq2GHIfXD4eJ
         ETWCDyIyk8PE0slAgUMOEQqMm411tSCiATC8b7+W7yAolWIUkv8b4f77Cet+VkS0RIF9
         8YO3hzx3clrrPr3Ce1MhKjaG9bLeka+oTtGavEys4ykWvTeod5g8pBC8Dyp0N3GHe0Yo
         gu92mssnpM+MGbEYc+8uXtZtlPHu0/uHWV5mtLmahf76YV0n4cDXfSsi5zUNaoSeGFS2
         BJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710459453; x=1711064253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmpupRoQTR98i+0BALoB9IZnxDmgxkFF3hs7MfwHtOw=;
        b=C7iCW0OQcdpLbFaytrkez0xOj+6upbUlmGtapHlhO91zUP+oqQm9ixBs4/t1Hc9eA7
         ipKp+IewD0zQN6ZYMP6sHh0iHENwi6ZLzXKRAZTlmFr+5UdsfaxovYTxWfD/QNVRVEim
         yuQwen7nXipouRQFokXoK3n34JmCaKNC6jruz8xf4g/w8YMZe/sd3977+IWewsrg5pmU
         F9TFa7llhGRcXNXfO8Tkdc6CNTQ14eFxwW+wKwkounHHriURMebcCXhKFpZqP7ZqhpFw
         VeEAWB0L239Mp/OH29dPJ4U81IXirrvlfWXRkoIX4nRSBRX//0o3BVS5qAvvUhCezrTZ
         NcFw==
X-Forwarded-Encrypted: i=1; AJvYcCVP2BtO414hqgfuFL7JNLMo0qtdIu8N8cOBCJNIwNA6TIjJ0UxcCztB4BruVF7lPoQQPHaajUj1B/P5/jkzNUAnvvW0mMtfCbmSGFGe1vcNFOJyQ4RVmS+Fr/YMk6Dg6hPDrx0uujiuMQ==
X-Gm-Message-State: AOJu0YyzhEuJ8ijuJtrUPG49BMV4NYwJ5Vbq13uHQ/dEOaHDxCjSFTf+
	UQV4b6YGCwyzskA1znmUlYrg6dV96Kl4JnTgrL8OfrAmVtx1oZ9d5e2LP4+eIyhBlvgg92GoMd+
	sEHvSsPhAnY5N4qVsmEiqG+fYQkE=
X-Google-Smtp-Source: AGHT+IGpyWDl685GIipAYVhXMHr+oQMKtT2p4/TqCny7ksyf4QQagKsC7ndsVHI0Is+HDoff6n8WB/EwsSoR+PE943k=
X-Received: by 2002:a17:906:9c8c:b0:a46:7734:1f12 with SMTP id
 fj12-20020a1709069c8c00b00a4677341f12mr1913901ejc.47.1710459453424; Thu, 14
 Mar 2024 16:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314201856.1991899-1-gnstark@salutedevices.com> <20240314201856.1991899-5-gnstark@salutedevices.com>
In-Reply-To: <20240314201856.1991899-5-gnstark@salutedevices.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Mar 2024 01:36:57 +0200
Message-ID: <CAHp75VeNijg6sXyW_frwD4siJ-LWBLBfVCmMDug8jYAVVg9Bmw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] leds: lp3952: use devm API to cleanup module's resources
To: George Stark <gnstark@salutedevices.com>
Cc: pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com, 
	christophe.leroy@csgroup.eu, hdegoede@redhat.com, mazziesaccount@gmail.com, 
	peterz@infradead.org, mingo@redhat.com, will@kernel.org, longman@redhat.com, 
	boqun.feng@gmail.com, nikitos.tr@gmail.com, marek.behun@nic.cz, 
	kabel@kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:19=E2=80=AFPM George Stark <gnstark@salutedevice=
s.com> wrote:
>
> In this driver LEDs are registered using devm_led_classdev_register()
> so they are automatically unregistered after module's remove() is done.
> led_classdev_unregister() calls module's led_set_brightness() to turn off
> the LEDs and that callback uses resources which were destroyed already
> in module's remove() so use devm API instead of remove().
> Also drop explicit turning LEDs off from remove() due to they will be off
> anyway by led_classdev_unregister().

..

> +static void gpio_set_low_action(void *data)
> +{
> +       struct lp3952_led_array *priv =3D (struct lp3952_led_array *)data=
;

In case of new series, drop these castings in patches 4-6.

> +       gpiod_set_value(priv->enable_gpio, 0);
> +}


--=20
With Best Regards,
Andy Shevchenko

