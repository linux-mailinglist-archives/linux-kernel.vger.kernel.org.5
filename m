Return-Path: <linux-kernel+bounces-86538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5D86C6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117EC1F2602A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0833664CF9;
	Thu, 29 Feb 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy02jnUV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F364AB6;
	Thu, 29 Feb 2024 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202110; cv=none; b=S1zBuQb6a4Ag5IL89sKwHFsYWkOYcxc2OnHstrsxLtxH7S7YHIiHKB+0CobxrzbMxjzDdW7O9YwyyG9FpDAffJD9kNi/K9J7ab7GoenECO4Lz0jijNbvCVVMfQkrirftv6oegIlvnR/ria1xiZIXRLU2ra3A6Zh4O23KYw4ePIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202110; c=relaxed/simple;
	bh=w3kEVFOrvKCGNI2O50JnYc2GqcNbmvQBLSVNxFfrY9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7rDbTMkwCY+C9xLdBnZ0oQNA5r+db/I77bJ0JImoHXu0iS3SzchhPNM8h/KqlhOkHrlfvuxrh94t7YwAO+g0VzJ2IlfqSAcfjLhNm315oFu6l8BbIZyQS1ofI6SmbXBT19QZT5ukBuRYd765oX1zRmy9Y1j4G5gLK9o3n706So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gy02jnUV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so113550866b.1;
        Thu, 29 Feb 2024 02:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709202107; x=1709806907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w3kEVFOrvKCGNI2O50JnYc2GqcNbmvQBLSVNxFfrY9A=;
        b=Gy02jnUVGtgp4N1pW3VrDdxMQFyb9rg2ej5AjZotG7ohA6M6Z8D7jxvJ6xdNTQ8MXI
         rfQ663lm+J1uC9WhcLeM6bpTgTbbbeN9cAkWD2ppLJrYuuaUmd48ssN+0UvL8pJbi7I6
         STuJKxKcGQlEYMzPqtEhOWOMI1prDB3aggBoTkcnLlflLajMnMPf7MswSXthlDCAc/LO
         YcwmIzHcgXoE5oR0+sRACDHljZjycnX5Y+3QEMs1HnY1uYVoRm88/VaSNunVa46ARyPR
         9ZKDLBjPNTaJ750vZFl3efhIldxJ55XErR9WAexne7EApZU4SF0zU6RbNpRdUg0RD97c
         h54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202107; x=1709806907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3kEVFOrvKCGNI2O50JnYc2GqcNbmvQBLSVNxFfrY9A=;
        b=Dc5SVTddsfp6AgoLAgiSaj4V6/Sji567QBZ/RMUVLqBAUHMjJyy8NTuP2WEoO2+tle
         eOI4a5whDfcsDjlTqphIkdrikPPDY5dHtZ2vIdZbHSLWF69AzD1LG08Eq9AgEX8mZhj/
         f7YIwiouZxeUwTGNqeIogZyeHeu50DKJcjAtIMox+FJWDpDNMFVzWWzfJN5NaZ12Im4l
         IJFv6ML9n3qg5r8iz6YHrw07wcUWjePEDUkrT6pBiEp758/ACYIRgM6oij2rviXinMZy
         jIUAOqevdxIA0HVovqHBE/rXeBCIXOTYbRlTezLnJ3UOnFt5FdlIUs4heoYLHokafALl
         GN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgT+6yDFtqqOmoVWfGT2jHfGyLnT/hrM4ak2DQXadgZWZRPGCR3A18I3kfsiqytXbgnS7ArTVPUBVlc0Zn9nVIjwYsOKunRjLfKdsVtNsPllqBrlB4Gcx1Yh65Z2SlijsNIOwTef6Tw1mbWpPybt0/0pbeej8rgl5kObdNucgSgQ==
X-Gm-Message-State: AOJu0YyliJZ18ngfubmbA0CmosKR+INDGPBqleISak3+jSAie9M9Znb5
	v8Gg2ZoYwlrjcMjIBPOYr/PDHFhznEMTghiY3CjkeZ+VHv6vPAxj
X-Google-Smtp-Source: AGHT+IHP6SnZ+t4Rm6KnZQyLCPnDHrCVu8cAcZaXXcHYjJTCsFL5UqAxZ1do7itkDcPWR4ldQU/9Mw==
X-Received: by 2002:a17:906:b247:b0:a3f:5e8c:8a34 with SMTP id ce7-20020a170906b24700b00a3f5e8c8a34mr1300997ejb.9.1709202106581;
        Thu, 29 Feb 2024 02:21:46 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170906ae4c00b00a3f27031d7bsm530358ejb.104.2024.02.29.02.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 02:21:46 -0800 (PST)
Message-ID: <581fb060128519d29c06f797ee8ec7c8d0e60ca0.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, Max Zhen
 <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>, Stefano Stabellini
 <stefano.stabellini@xilinx.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>,  linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,  Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 11:25:09 +0100
In-Reply-To: <20240229111430.54bdb6b1@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
	 <20240229083953.607569-3-herve.codina@bootlin.com>
	 <c2b830bb4a4cf76dec8783f38b2477120edb1a15.camel@gmail.com>
	 <20240229111430.54bdb6b1@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 11:14 +0100, Herve Codina wrote:
> On Thu, 29 Feb 2024 10:50:21 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, 2024-02-29 at 09:39 +0100, Herve Codina wrote:
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
> > > =C2=A0drivers/of/overlay.c | 9 ++++++++-
> > > =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > > index 2ae7e9d24a64..99659ae9fb28 100644
> > > --- a/drivers/of/overlay.c
> > > +++ b/drivers/of/overlay.c=C2=A0=20
> >=20
> > In the cover, you mention device.h inclusion but I'm not seeing it? Thi=
s is
> > clearly up to the DT maintainers to decide but, IMHO, I would very much
> > prefer
> > to see fwnode.h included in here rather than directly device.h (so yeah=
,
> > renaming the function to fwnode_*). But yeah, I might be biased by own
> > series :)
> >=20
>=20
> Damned. I missed device.h in this patch.
> Without this one, the patch do not compile :(
>=20
> A fixup commit I missed to squash before sending.
>=20
> A v3 is planned to add this device.h.
>=20
> Nuno, do you prefer I wait few days before sending this v3 waiting for mo=
re
> replies
> or I send it right now and you re-do your comment on the v3 ?
>=20
> I would really prefer to send it now :)
>=20

Typically maintainers don't like much of re-spinning versions too fast. Tha=
t
said, up to you :). I can copy paste my comments in v3.

- Nuno S=C3=A1


