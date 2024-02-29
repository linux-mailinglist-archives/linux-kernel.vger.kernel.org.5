Return-Path: <linux-kernel+bounces-86464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33186C5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AFF1C22E50
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D03612EB;
	Thu, 29 Feb 2024 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/+zdONQ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1B612C6;
	Thu, 29 Feb 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199850; cv=none; b=QRSGiaUdu7cJCSMHU1nNLptHiQrtCjwZABHMdjBdNbi7pJNCWMQmNlp5R4JC8VlhFKXpSSFcPiHqTFJISWOIdl9L8XFehCmS1KTAPvs/ZWcOv7xyzSIQ7PlXafmzTDIdrbdtqKhVf0MpDw1txlsQhZXxmnMKFVPUZB5JJY747Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199850; c=relaxed/simple;
	bh=ESNGO2IXUgzrFIeskrANYbU6PHVWkCUz3+MPORBNKcY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWlaInj+CE4GNN0bXVWeXsZ/ZHrVYn3NWtaon3F35eASnrsHWcoyQUJUVIAflagMfXUOGYmV0FxCZf7q443RjGoSYcc+uSiQCI193PZtwSqWTgo+mf9/2GVaoFtNF7dYA+yBfOnsBwiuBjdB27KWfb4LHqd/Xc8rE57g/3BgOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/+zdONQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3f3d0d2787so99914766b.3;
        Thu, 29 Feb 2024 01:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709199846; x=1709804646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JMs6V3SRmaiLH9E8OpJqGhJQdLFZcXEpx0tmvAjRDjk=;
        b=U/+zdONQ5pJRpiBnD4MXeqEh9GKkme+el3UX4g0gusSXLnRwfGNvuq7Ga0RnNZIP4B
         HfiRQr3z1YE3vNuZR1ObKPgm1RkIIcxXHCnJz9RKO/3savnhnlHuAw6hIRR0ix241s2i
         oSdHHWCdswnUSOFsYPXOwSs6nWfGHUuVNIwWEk+BulslQhW4Nf7plZVQGxeEsxOLFsK4
         R5cie88wPFHTzLQ2PVf0qxAZgb4iiqJ6eIMJkph72mfPI8b8vcOuZmvdy1JAwxZhd5T2
         TgHipvS9JshLH5MEpvb7/5UpvPiApSgSjJ/5/mbHI32Lk9EGRgGi/Qyc7c0YDv08vxBH
         rZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199846; x=1709804646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMs6V3SRmaiLH9E8OpJqGhJQdLFZcXEpx0tmvAjRDjk=;
        b=sUSnANUgtlZ7S1CWMiUcEe5r4+jOWFs81tC50jNts1pXwRHwnhHMHpHRCLDUviW5TA
         75sA//oFJhe+3SrVwJg8NLDsd9L3WFtKxfNN6PEtq11GTadvfDBfC9jIm/voNlXWQYH/
         6In9moixdKPcw1R4o+OCv4Gdm8vem+y7gyTnar2IW2tozhcqi0G9ejhqxdcwhANogZRe
         2VOgZMcbNe/q68pm11PFWXW/WuFtMNQzIzdK3ehEKS87zIkNspjkbkIqoqtHUf29gLr8
         U5Ze3NTTXoxQKGQvvwBlYeb4VhLPBvqpBz/iMWkAEquqQQajTQYUYn4RFJem3vH8lW3/
         OOCA==
X-Forwarded-Encrypted: i=1; AJvYcCWZiVg93Zv/B5TrlLlAKK6VTckIh4QFupJzV1TtZQXsIvsukx96Ene3FLtBBkUL62KWfGIL7NTAr0JI1jZOnTGOuVe09dEe3RG274aKpIeSglm8u7wi1g0Lui13emyOJGXJAo8yYur1+6v2H86IpZQ19JUeI6Bb61wx92otxomokQ==
X-Gm-Message-State: AOJu0YyK5AvNfWMGyNWrpJjNfKhyRBRJCwtuVj/Obp3NYHF2qMBdPC90
	j0GQjKDLQarFNYLNVsd3WJJK1NXnLEJ9OW3ZC6p6oiAQPpMSKF01
X-Google-Smtp-Source: AGHT+IHzuluh58/095WHr4Vcz7H7bRFywSky7I3lIIrmGML8SUFZovx2fcM3Sa6RmEzNDDQgUK9OiA==
X-Received: by 2002:a17:906:4917:b0:a44:4f9f:1270 with SMTP id b23-20020a170906491700b00a444f9f1270mr577476ejq.37.1709199846155;
        Thu, 29 Feb 2024 01:44:06 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id vi10-20020a170907d40a00b00a445db55f39sm30850ejc.156.2024.02.29.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:44:05 -0800 (PST)
Message-ID: <7eb7453244edace460f8c6fb91cb92a86fe2fc58.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: overlay: Synchronize of_overlay_remove()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
	Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Thu, 29 Feb 2024 10:47:29 +0100
In-Reply-To: <20240229083953.607569-3-herve.codina@bootlin.com>
References: <20240229083953.607569-1-herve.codina@bootlin.com>
	 <20240229083953.607569-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 09:39 +0100, Herve Codina wrote:
> In the following sequence:
> =C2=A0 1) of_platform_depopulate()
> =C2=A0 2) of_overlay_remove()
>=20
> During the step 1, devices are destroyed and devlinks are removed.
> During the step 2, OF nodes are destroyed but
> __of_changeset_entry_destroy() can raise warnings related to missing
> of_node_put():
> =C2=A0 ERROR: memory leak, expected refcount 1 instead of 2 ...
>=20
> Indeed, during the devlink removals performed at step 1, the removal
> itself releasing the device (and the attached of_node) is done by a job
> queued in a workqueue and so, it is done asynchronously with respect to
> function calls.
> When the warning is present, of_node_put() will be called but wrongly
> too late from the workqueue job.
>=20
> In order to be sure that any ongoing devlink removals are done before
> the of_node destruction, synchronize the of_overlay_remove() with the
> devlink removals.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/of/overlay.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 2ae7e9d24a64..99659ae9fb28 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -853,6 +853,14 @@ static void free_overlay_changeset(struct
> overlay_changeset *ovcs)
> =C2=A0{
> =C2=A0	int i;
> =C2=A0
> +	/*
> +	 * Wait for any ongoing device link removals before removing some of
> +	 * nodes. Drop the global lock while waiting
> +	 */
> +	mutex_unlock(&of_mutex);
> +	device_link_wait_removal();
> +	mutex_lock(&of_mutex);

I'm still not convinced we need to drop the lock. What happens if someone e=
lse
grabs the lock while we are in device_link_wait_removal()? Can we guarantee=
 that
we can't screw things badly?

The question is, do you have a system/use case where you can really see the
deadlock happening? Until I see one, I'm very skeptical about this. And if =
we
have one, I'm not really sure this is also the right solution for it.

- Nuno S=C3=A1


