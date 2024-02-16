Return-Path: <linux-kernel+bounces-67936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298985734A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54661C2441F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310FD2EE;
	Fri, 16 Feb 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/PnqKO8"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA13C2ED;
	Fri, 16 Feb 2024 01:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046151; cv=none; b=QktbZRBu2jkNXPZgmMnzTCnXcPFzsmy9jap2QXEKj86Vye6hqbTqj6Qm+uk+EvsmOBMqKwAXRH1EIJyl5Fl6mNSXNT0qMmKA4BB5ZWSefFrOm9DeviFd4q2hMneu0j+xmSFshCWsKHl6o/CpdCaRKgo0W5ibx+CdRR8U7KRn9X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046151; c=relaxed/simple;
	bh=RvGKWOwdrkRtqJpsZ/aXi5VrDq0Nk4AQAlyxMvr+iH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX6T2W+12Jhck4P8WlPpYFkSgujvs2BbQiOG9GYgm3ZV1oMNTW54VkVKEtUOVQSf4+V6Qx+SWPRN7KU1sEn09nsTQfzeNO3dd0ppizoQvhv1bCUHD5LlXSldk7SwVBMVbTCanL/tH5DHMcAJWTR8Oqfyk53LVBnxc782F3jYv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/PnqKO8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so181610f8f.1;
        Thu, 15 Feb 2024 17:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046148; x=1708650948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O3eF6Xf0QzOmLsZzpe4pKtQUe75xBm3R5yP9XkNOOLw=;
        b=T/PnqKO8TIWkPZcAFcSwY+aHmo/9QuA2z2rfFhc+lqA5sM7YPUPEHYQHouxnXvLSdM
         jgHd/jnIB9ndO97JwFtPB3zSgRBGL7oP4QYkvUqCaQRh9jEOxvncXPBfYJLGb2+LNi7Z
         6OMXOR4lSP0FOoeVnYx78L9s+99bLLr2y7gJc99pzXiz8C+8mhYUFQu/mtefLQWRLjSc
         tvxIiRX5A40kOpE85fiGA/Vjmo3CYBJxaXdCCvDnKHXGyOFT7EEaOui7vk3S8fAshnAz
         8EBx66P8tRT5zIDmB/04uT+E3eb879iMfSSiIaVjiOp5+/Rqo0USJul/2CGRFjwMh17J
         A29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046148; x=1708650948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3eF6Xf0QzOmLsZzpe4pKtQUe75xBm3R5yP9XkNOOLw=;
        b=MY1UPDDuoZYCuFg4+mxms7lddZuMUYS8J/xC6AW2XKT3f/p0IkudgFVwHEnkW7t9HX
         SGTwBHL3vHkbuaYIdV/9wiROwYDoh8BAz/n6wZ/s6mvgZ7XvBocbc2kzibj29JL8eVW4
         2rkuntqrGQLYvI2VZkowOBvdwqsvAkouDPJMfmjMvDcSyF6uWyB8xKXDjS5+N/REHUkU
         btt6HhMGLquPXGLkZBBEj9CpRiDMIKIX8E0sSpRQ7XbHCBEsLwVp0sQ03be3B1vfEzTX
         oIs+13O1Go9KN1DKY/AuOP9mV4YmByODi4d0TzL+DkXr+6tFzMFuP4jxJclngYs9sz1B
         IIGw==
X-Forwarded-Encrypted: i=1; AJvYcCWeXk1flsS4DCjFir7bADGAdjiDxPWuvZIvQX8yW/Fn6K3KzbyqFLOnFQRnTEYLC6kMQHKnZiNR3dA3oYBym39OEoa54tRtNPnP5X27S78mRhpOAgL7IeN+gfZ4zjNZ1H0ymWzAFDWHoE+ql4/TV/xcS5ViQ5/E4L02A42ipY/WjQ==
X-Gm-Message-State: AOJu0YzfKhoBnuwgK8312+2hkeiRVGTuA5v/sx5HJ0QIiF/iui1Iyf8L
	f3k3HZRVnYzLQaYs6bs/bAHqfL5k02aTlpm+WpSpF1LNNLJM3PnF
X-Google-Smtp-Source: AGHT+IF6VMJxW0agCvlOGMGJ5nvy3Nv0ddeCPZAG0FB2FIOMSoQePmsrEdhN+P/vXDH+7cdTXqXRWA==
X-Received: by 2002:adf:a4cc:0:b0:33d:ca9:1fb9 with SMTP id h12-20020adfa4cc000000b0033d0ca91fb9mr2080936wrb.53.1708046148057;
        Thu, 15 Feb 2024 17:15:48 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id bw22-20020a0560001f9600b0033afe816977sm649518wrb.66.2024.02.15.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:15:47 -0800 (PST)
Date: Fri, 16 Feb 2024 03:15:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20240216011545.7fmup2qkqikvb7ro@skbuf>
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
 <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
 <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
 <CAJq09z4wgPo=1_OtA6Y-0O4gLJ2nxy1jdf0BDoZwVmL=TkOdUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJq09z4wgPo=1_OtA6Y-0O4gLJ2nxy1jdf0BDoZwVmL=TkOdUg@mail.gmail.com>

On Wed, Feb 14, 2024 at 07:17:55PM -0300, Luiz Angelo Daros de Luca wrote:
> > On Wed, Feb 14, 2024 at 1:54 AM Luiz Angelo Daros de Luca
> > <luizluca@gmail.com> wrote:
> >
> > > The 'reset-gpios' will not work when the switch reset is controlled by a
> > > reset controller.
> > >
> > > Although the reset is optional and the driver performs a soft reset
> > > during setup, if the initial reset state was asserted, the driver will
> > > not detect it.
> > >
> > > The reset controller will take precedence over the reset GPIO.
> > >
> > > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > (...)
> > > +void rtl83xx_reset_assert(struct realtek_priv *priv)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (priv->reset_ctl) {
> > > +               ret = reset_control_assert(priv->reset_ctl);
> >
> > Actually, reset_control_assert() is NULL-tolerand (as well as the
> > stubs) so you can just issue this unconditionally. If priv->reset_ctl
> > is NULL it will just return 0.
> 
> The idea was to avoid gpiod_set_value if the reset_control_assert was
> configured and worked. However, I don't see a big issue in calling
> them both as you don't expect both to be configured.
> I'll remove the "ifs not null" and let both be called.

In the defense of Linus' comment, your proposed code did not do what you
seem to have intended anyway. If priv->reset_ctl was non-NULL, it fell
through and potentially ran gpiod_set_value() anyway - there was no
early "return". So, the simplification comment was predictable.

