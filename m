Return-Path: <linux-kernel+bounces-90838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C568705A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52094B2AC02
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5704DA14;
	Mon,  4 Mar 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwV6aY0S"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE44D134;
	Mon,  4 Mar 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566375; cv=none; b=QxtWonXixoUtumE8D4fGUmiIEQYa+V8lZkTj8xOPotrUSCc4NB65upGYQdb3UMq+Fqznea/+mt8PhxNr+gwlvu6ugYusnsagj/XJfN9JdDrBlhIyRlKcCar6HpUFq+vsFV5HkepkEhERoL0nBoJLIjzmBIjM29imt9xoy4SjTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566375; c=relaxed/simple;
	bh=3EAj3xv1au4Q4TJ50vvjHAcAy5htc0pMEaTTLlfhjOQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c98cGUrQvBOvqo7XGLOaGpPfH5Won6BS+xUeMfapek2/QjEAMNXeBY5Vq7e2x/HlVuBAgQy/I0KInGee8cimDa2ni52CWdxPZOuIH9yVHBG07mvIJsqqHn0FGCUPrdm0JkzMLhAq61UN0HDRPWGHLZdSBUHJysBrklaxldk8xwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwV6aY0S; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a441d7c6125so562907966b.2;
        Mon, 04 Mar 2024 07:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709566372; x=1710171172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWvYOuCuRfEcVskjhEHNCFWud68WSGUgd2zUqGEpjT0=;
        b=IwV6aY0Szpjtuexl28y/Bg5Dzx2rQ3Mf07TlyJbpZIvjp+rsxbH/TBcFmb4ZIDH/fz
         Gj87MHiS5CIqUjlHg8SEBaMMrXu4nHnEHsj6kZGPGnp6CIMWlmPR97PGY6BovE2mzbGG
         HyJ11E2ZFMD1YATGRNl6lrQi7QAZQoP7L9HIlOgeB5NWRYYbNq/TG7AgPACg86Gf/ciG
         Ic+hQcmpI5eeI1Fce64wUA6uYMneuP93ybU/sTzgH5CF4kdvmTyOOC/4G5WKbdRKHEl6
         vRke1BbVd8aj8lC6PPu+nNnElTg4CNe88THHmoWnchVq9k1d3B6oXIajB0uziDlLcOd1
         EhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566372; x=1710171172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWvYOuCuRfEcVskjhEHNCFWud68WSGUgd2zUqGEpjT0=;
        b=lOZ7VcF6w+F2OkX6kTWcdf+ENp9qJtfuNFPtOgkRKvIZPYfsLljPfXVwNFyp5jnRwE
         RAFmh7+BB+FxgsPkU60dlkVKPVx4h6CHMGEYyRnhTsYRE5dFV3W6mmxIZDnYDhy3+nxX
         xHJNXhVLoJnjGKh+alVsxac6NYT9zHHf2sUY0lQ+bPyveHNCGLAXAqza3b2O7ERTc54S
         VxzUhuGrU14BA+Zsjk5SusMRQzNtzrEfBUdIKv1jIIb/yq12/Szblq1c9KR21nPVYyYb
         +0andbAxj5BI70dx9npG5GYmGnza2UwZvcICdJCAvMhucF5yMNt+Wyzm3IfPdAlOMPlQ
         PHtg==
X-Forwarded-Encrypted: i=1; AJvYcCWicphpRxCFdQB7ED0O3QBs3me51CHiGYNrpcFetXiooWpUSMcwLWlIYavv2zAIQxTjAN77ni2HeDqLiyvh8/LFdjpF0OnHl4ZFIYDidotF0/WmVdrSrKOkKUACzemj+f2QPk9rFHv0/EOtjYGwmco9vMkMpodfc6cW4n3dK/mhrg==
X-Gm-Message-State: AOJu0YwvpwXMwv+fcjpluJv9wL4nohcO6ez0MeMeBM//WvO71hHkihHD
	OY6EjwgoLD6FmRp4lAYZbndUgNcHShtxXz8wTemmPtxsf5V7ic/v
X-Google-Smtp-Source: AGHT+IHKE7kIPPNrF2w6yyuuVMCu9i3ZIMUD02F9duWP7L1huDB65YHByUXUVOOjQ3Ls99sC0F1W4g==
X-Received: by 2002:a17:906:f35b:b0:a43:fd9e:2d69 with SMTP id hg27-20020a170906f35b00b00a43fd9e2d69mr7096029ejb.6.1709566371768;
        Mon, 04 Mar 2024 07:32:51 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id wp1-20020a170907060100b00a44ce0671b1sm2937118ejb.108.2024.03.04.07.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:32:51 -0800 (PST)
Message-ID: <93d0adf0ee6f3737af4d482dc206fe152f762482.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max
 Zhen <max.zhen@amd.com>,  Sonal Santan <sonal.santan@amd.com>, Stefano
 Stabellini <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Date: Mon, 04 Mar 2024 16:36:15 +0100
In-Reply-To: <20240304152202.GA222088-robh@kernel.org>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
	 <20240229105204.720717-3-herve.codina@bootlin.com>
	 <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
	 <20240304152202.GA222088-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 09:22 -0600, Rob Herring wrote:
> On Thu, Feb 29, 2024 at 12:18:49PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> > > In the following sequence:
> > > =C2=A0 1) of_platform_depopulate()
> > > =C2=A0 2) of_overlay_remove()
> > >=20
> > > During the step 1, devices are destroyed and devlinks are removed.
> > > During the step 2, OF nodes are destroyed but
> > > __of_changeset_entry_destroy() can raise warnings related to missing
> > > of_node_put():
> > > =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
> > >=20
> > > Indeed, during the devlink removals performed at step 1, the removal
> > > itself releasing the device (and the attached of_node) is done by a j=
ob
> > > queued in a workqueue and so, it is done asynchronously with respect =
to
> > > function calls.
> > > When the warning is present, of_node_put() will be called but wrongly
> > > too late from the workqueue job.
> > >=20
> > > In order to be sure that any ongoing devlink removals are done before
> > > the of_node destruction, synchronize the of_overlay_remove() with the
> > > devlink removals.
> > >=20
> > > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > > =C2=A0drivers/of/overlay.c | 10 +++++++++-
> > > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > index 2ae7e9d24a64..7a010a62b9d8 100644
> > > --- a/drivers/of/overlay.c
> > > +++ b/drivers/of/overlay.c
> > > @@ -8,6 +8,7 @@
> > > =C2=A0
> > > =C2=A0#define pr_fmt(fmt)	"OF: overlay: " fmt
> > > =C2=A0
> > > +#include <linux/device.h>
> >=20
> > This is clearly up to the DT maintainers to decide but, IMHO, I would v=
ery
> > much
> > prefer to see fwnode.h included in here rather than directly device.h (=
so
> > yeah,
> > renaming the function to fwnode_*).
>=20
> IMO, the DT code should know almost nothing about fwnode because that's=
=20
> the layer above it. But then overlay stuff is kind of a layer above the=
=20
> core DT code too.

Yeah, my reasoning is just that it may be better than knowing about device.=
h
code... But maybe I'm wrong :)

>=20
> > But yeah, I might be biased by own series :)
> >=20
> > > =C2=A0#include <linux/kernel.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/of.h>
> > > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > > overlay_changeset *ovcs)
> > > =C2=A0{
> > > =C2=A0	int i;
> > > =C2=A0
> > > +	/*
> > > +	 * Wait for any ongoing device link removals before removing some
> > > of
> > > +	 * nodes. Drop the global lock while waiting
> > > +	 */
> > > +	mutex_unlock(&of_mutex);
> > > +	device_link_wait_removal();
> > > +	mutex_lock(&of_mutex);
> >=20
> > I'm still not convinced we need to drop the lock. What happens if someo=
ne
> > else
> > grabs the lock while we are in device_link_wait_removal()? Can we guara=
ntee
> > that
> > we can't screw things badly?
>=20
> It is also just ugly because it's the callers of=20
> free_overlay_changeset() that hold the lock and now we're releasing it=
=20
> behind their back.
>=20
> As device_link_wait_removal() is called before we touch anything, can't=
=20
> it be called before we take the lock? And do we need to call it if=20
> applying the overlay fails?
>=20

My natural feeling was to put it right before checking the node refcount...=
 and
I would like to still see proof that there's any potential deadlock. I did =
not
checked the code but the issue with calling it before we take the lock is t=
hat
likely the device links wont be removed because the overlay removal path (w=
hich
unbinds devices from drivers) needs to run under the lock?

- Nuno S=C3=A1

