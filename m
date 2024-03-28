Return-Path: <linux-kernel+bounces-123328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FA28906A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AE11C3116D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3140137C3D;
	Thu, 28 Mar 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ8h9ijN"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC064CE1;
	Thu, 28 Mar 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645228; cv=none; b=HKSKUprWOVLa6vnQwu1gkl6pullZPREBjYOLgmsNmPJrLzjKy/Ye6JCLkhA7fYZ/IFID8ApAayf/GSkUB0QKed9URSeE6PDnyU9qxQsR/++xeGIOAeQJvJF/AjvgT4b2HAVDrF0K5Vt71b8ziU8WnI+9RGtlK2qJTvCDalXQk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645228; c=relaxed/simple;
	bh=rrRuTb2yJ2Swx2Uv9qQuOIuBSC2ay4zk/OqFkeW8JdE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JiyR/jdpJwkHmfd5j9NbuPavcYiqOlwuT4i3UNWRXvJT/HYiUquP75Ne7gYmdo5IlMU6PuiL+lSs9JEUXmbOhFl5d+ixka9iLdr+A5TVh0P9xMlqBLRDGQbIKsLKf+3tOMHGIm2zfdUi6AzyktxdUQrsO1PUQQAqTYvZMtGZHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ8h9ijN; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c583f5381so807626a12.1;
        Thu, 28 Mar 2024 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711645224; x=1712250024; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=stvwvcw6BBFyPtIGiBiLhJ1aHDfsR73bSliLCyyMaps=;
        b=nQ8h9ijN6rZEUoRRFOYkwjZVPfvzH+sZ+n2si6LEHCW24wqlG2JLBjRwaQAEF/S+MQ
         BsWTwlOWd1+gW9dTqnlxPQpSrnUlPI3kqVTL96ARGcK/8+NNIXrJFjFp71oT/0enM8j1
         MZWpqhBHDrQO6ajGWJkKo/um+Wn0Tnlw2ZuIy1/Q70BMkczeeu1Sn5Y1b9vQr8/APAXQ
         yyafXb/yNqFYWty8EzYK/5WVJeKkLkmImNprQgM6JenhHqJkJ33BN2M8HjJXCe5w/xZq
         LWdbG4VEWU74x93A+Dd0h3473JQjmlPkuVEDqIxh4B7VOO+nFtPIC67h3EotQ4xoQx3H
         0BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711645224; x=1712250024;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stvwvcw6BBFyPtIGiBiLhJ1aHDfsR73bSliLCyyMaps=;
        b=i63lKlyMXkXgKQBarm+c4CeQyL3N6PeM0CGfhJYkzRugGvVPzZR8Dv67esX/2waP1t
         Pae60q/I+8hjYzomxQirnRz9xreBCNr9AZD8wbwBXcK4RNPe2PxyKN6esp8mLPqwavJD
         EQgBJuEsO5FYK6xmHEd0AbaBMccjAw5vIjpLeLMYBdGVJZSnnvr/hlQfy6W0F9d5lmsi
         tc1Uyxzc+NLE5p10ELj4E9Ks1lbl6WXPycVsJRC7AXAJDAGbButl2ufvbkv3Ij0Y8tea
         j02vl6OqhAF1L9Pzs6e8HEn0jDqZ/bCIv3xcLeZ97R8F1Vef9Qy8JszEBN+WlV+Yb8G2
         m3hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLmCCBwhOemV6Rn3EUbuZHSAMgQhRVLc01tLe5jt/+dgCmpfIXWkzCWp2J8XnqNynAyvzgtK/j5RO7cUdnwCzujx9fItETTlPzUgHkJue/m0gQ7ssgslmPOp7hqUhospmfJnRwXZqXuQ==
X-Gm-Message-State: AOJu0YzTor+Gkh5+kc08N//Uc46Q7ByWHokQondaS1Ozxb3hs5qr4B4g
	m9SifMWwJVY6pzJhY/TyymyVDK2fqbul+i8L0mLmoHM0XT6aQ1wa
X-Google-Smtp-Source: AGHT+IE15SGYpN8ex/nr3KjAwYMch+D9d3pqxB0exiuUAHDkZNAUeSO5Pj/RXrauUaAKcwfeFrlBQQ==
X-Received: by 2002:a05:6402:2350:b0:56b:dd7c:ac3d with SMTP id r16-20020a056402235000b0056bdd7cac3dmr9313eda.10.1711645224162;
        Thu, 28 Mar 2024 10:00:24 -0700 (PDT)
Received: from [192.168.1.63] ([109.28.199.236])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b0056c4f8130c3sm1047007edu.82.2024.03.28.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:00:23 -0700 (PDT)
Message-ID: <871f0b24a38208d9c5d6abc87d83b067162c103e.camel@gmail.com>
Subject: Re: [PATCH 1/3] phy: rockchip: emmc: Enable pulldown for strobe line
From: Alban Browaeys <alban.browaeys@gmail.com>
To: Conor Dooley <conor@kernel.org>, dev@folker-schwesinger.de
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,  Heiko Stuebner <heiko@sntech.de>, Chris Ruehl
 <chris.ruehl@gtsys.com.hk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Christopher Obbard <chris.obbard@collabora.com>,
 Doug Anderson <dianders@chromium.org>, Brian Norris
 <briannorris@chromium.org>, Jensen Huang <jensenhuang@friendlyarm.com>,
 linux-phy@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Thu, 28 Mar 2024 18:00:03 +0100
In-Reply-To: <20240326-tactical-onlooker-3df8d2352dc2@spud>
References: 
	<20240326-rk-default-enable-strobe-pulldown-v1-0-f410c71605c0@folker-schwesinger.de>
	 <20240326-rk-default-enable-strobe-pulldown-v1-1-f410c71605c0@folker-schwesinger.de>
	 <20240326-tactical-onlooker-3df8d2352dc2@spud>
Autocrypt: addr=alban.browaeys@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le mardi 26 mars 2024 =C3=A0 19:46 +0000, Conor Dooley a =C3=A9crit=C2=A0:
> On Tue, Mar 26, 2024 at 07:54:35PM +0100, Folker Schwesinger via B4
> Relay wrote:
> > From: Folker Schwesinger <dev@folker-schwesinger.de>
> > -	if (of_property_read_bool(dev->of_node, "rockchip,enable-
> > strobe-pulldown"))
> > -		rk_phy->enable_strobe_pulldown =3D
> > PHYCTRL_REN_STRB_ENABLE;
> > +	if (of_property_read_bool(dev->of_node, "rockchip,disable-
> > strobe-pulldown"))
> > +		rk_phy->enable_strobe_pulldown =3D
> > PHYCTRL_REN_STRB_DISABLE;
>=20
> Unfortunately you cannot do this.
> Previously no property at all meant disabled and a property was
> required
> to enable it. With this change the absence of a property means that
> it
> will be enabled.
> An old devicetree is that wanted this to be disabled would have no
> property and will now end up with it enabled. This is an ABI break
> and is
> clearly not backwards compatible, that's a NAK unless it is
> demonstrable
> that noone actually wants to disable it at all.


But the patch that introduced the new default to disable the pulldown
explicitely introduced a regression for at least 4 boards.
It took time to sort out that the default to disable pulldown was the
culprit but still.
Will we carry this new behavor that breaks the default design for
rk3399 because since the regression was introduced new board definition
might have expceted this new behavior.

Could the best option be to revert to =C3=A9not set a default enable/disabl=
e
pulldown" (as before the commit that introduced the regression) and
allow one to force the pulldown via the enable/disable pulldown
property?
I mean the commit that introduced a default value for the pulldown did
not seem to be about fixing anything. But it broke a lot. ANd it was
really really hard to find the description of this commit to understand
that one had to enable pulldown to restore hs400.

In more than 3 years, only one board maintainer noticed that this
property was required to get back HS400  and thanks to a user telling
me that this board was working I found from this board that this
property was "missing" from most board definitions (while it was not
required before).


I am all for not breaking ABI. But what about not reverting a patch
that already broke ABI because this patch introduced a new ABI that we
don't want to break?
I mean shouldn't a new commit with a new ABI that regressed the kernel
be reverted?

Mind fixing the initial regression 8b5c2b45b8f0 "phy: rockchip: set
pulldown for strobe line in dts" does not necessarily mean changing the
default to the opposite value but could also be reverting to not
setting a default.
Though I don't know if there are pros to setting a default.


> If this patch fixes a problem on a board that you have, I would
> suggest
> that you add the property to enable it, as the binding tells you to.
>=20
> Thanks,
> Conor.


Regards,
Alban

