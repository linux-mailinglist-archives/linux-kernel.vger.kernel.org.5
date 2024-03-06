Return-Path: <linux-kernel+bounces-93611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB5E873255
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EBF28FE75
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB465DF04;
	Wed,  6 Mar 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhnuIwHe"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D651426B;
	Wed,  6 Mar 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716660; cv=none; b=MQGTo3SNKE9nC55InXvMapB7eMrsnqam1m5lqbzxoOs4QzycVYJMqD6meBC5Vmd2TXTUgP6mrEf8rQRBUYldRv5e/d4QFdiyHzA85TtAhKDWJ9wJbIHTB4P9v0AaXPexOR3WyiHa9itZiQ8ufCwBMByC8BGWnmTUd9Vz3Z8SVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716660; c=relaxed/simple;
	bh=JCzzi0CCK6mpbkxHx7yxf1dGanKXYtS2e3YouRCYaL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkC0ZFYlJQKMW3h4/dihbPbB0mD1G0FbVnF9iHBeJY4FFf8qkr/4A1Rqx0nwiz/CbFJXH0ackxm57mviyBRJq0HmobN/e3VlCJeLTvfmyx2VBVbhsjgYpNg72BvtJzPLnztPG4PQ16tNmN56fEUD9dKvo2sSKNAID90HYyV6zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhnuIwHe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56715a6aa55so3876475a12.2;
        Wed, 06 Mar 2024 01:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716657; x=1710321457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qkqt8dEmmlTcLYpeoo+RLVm9X92pye6PGGcOjeLLYQM=;
        b=UhnuIwHeJX5Z80SIoneyRQgpDNELOflYwzJFW+jOOECiscL3pFj4+fCyxIdVBoX9eD
         V6MthgRgZWfMQE4ftc/lv3VXmfrqHsDzrHdf4gY6MCfHOWELsSgOrmh2Lw/Bt52CaYPm
         gGnSofHHdCNanQJ4tuvSrHRv06yaZgvCStijlcb4tMgCwBjMyDad1W9AqrrVm6Q1PsU6
         myQ5yKfdGj5Z5BRrzgE81GgGFCDXoA1aTkDTVUwJyg/8596Wp80v7hRR7zWyK097+/yC
         HckUHaOSdTLzKcFK+AR5hnY5QxRDMAuz3DfMY/QPch/217S60WOj0nkaGQHjrSyL2OF1
         2mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716657; x=1710321457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkqt8dEmmlTcLYpeoo+RLVm9X92pye6PGGcOjeLLYQM=;
        b=WnopKL8N9z7GAuqt1jXbBrCxmYk/UqQoQ6J/3u1QpMc9+W+AB7pmV4bgmlwJ6iH8NH
         eAYmkDYfnBJm7abwvrfxsT1UUoZX4X0y1iaeXNUfJBuI9mEc1K1jWCdRAG8CmeENAxxr
         Lk0qIJYFWfnGjhmr1gMrmxTB53iPaqtEIkWyluaXybFIiIWF+ZaqOqYZj0ws0o94qo7d
         ycnqCkH/c6SzhU8BwxzOMxeq7q/6NlsWB3ntFSrNj4WoIshQuLTy6rNFvj9vfuZH0Eqt
         ZvfTGkfYwn6L0Yi7M2GvhijyIdDnfGG9HJtVkyAIMn8supY9ONX67qUdvvpUkPOAZaOW
         +pKw==
X-Forwarded-Encrypted: i=1; AJvYcCWHBzwdDFZCSDw9m0eo7LjQ3toHD1N9+JEEG4C6q4R0ZM9ufCEAyVUSIB22Tu4N7RrFSmEW2KNWmajCS+shUEYhYAxa6+QNEcmrSStX+r0jB60JC0fD1Rm1+eVJtlzU3wB5AyEfy1lgl/Ih3trzD+glMOlHnyXc7LwrAwpgd5AiIQ==
X-Gm-Message-State: AOJu0YyTkdtoSTuBPGk/tQXmeXHy08hhhDDM92mMyImyEvddTxraGmcW
	GxHxtT536K8r2a9mX/NEnComXIxIit7nCPujd5ZPPMEfihVsIodh
X-Google-Smtp-Source: AGHT+IF7w3hjFiPuTdDXsCLR6sdv+vnDtw7JJd6JpVGaweJAe9/vrPziarjkeJi7fzrnYa3/8ysNjA==
X-Received: by 2002:a05:6402:323:b0:566:a822:990e with SMTP id q3-20020a056402032300b00566a822990emr9600720edw.38.1709716657310;
        Wed, 06 Mar 2024 01:17:37 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id c8-20020aa7d608000000b0056470bf320asm6714469edr.43.2024.03.06.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:17:37 -0800 (PST)
Message-ID: <39147ed6f3ece627ee0c18d90e00b37e636553f2.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] of: dynamic: Synchronize of_changeset_destroy()
 with the devlink removals
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Saravana Kannan <saravanak@google.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>, Sonal Santan
 <sonal.santan@amd.com>, Stefano Stabellini <stefano.stabellini@xilinx.com>,
  Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Nuno Sa <nuno.sa@analog.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  stable@vger.kernel.org
Date: Wed, 06 Mar 2024 10:21:02 +0100
In-Reply-To: <20240306085007.169771-3-herve.codina@bootlin.com>
References: <20240306085007.169771-1-herve.codina@bootlin.com>
	 <20240306085007.169771-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-06 at 09:50 +0100, Herve Codina wrote:
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
> the of_node destruction, synchronize the of_changeset_destroy() with the
> devlink removals.
>=20
> Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

LGTM

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/of/dynamic.c | 7 +++++++
> =C2=A01 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..169e2a9ae22f 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -9,6 +9,7 @@
> =C2=A0
> =C2=A0#define pr_fmt(fmt)	"OF: " fmt
> =C2=A0
> +#include <linux/device.h>
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/spinlock.h>
> =C2=A0#include <linux/slab.h>
> @@ -667,6 +668,12 @@ void of_changeset_destroy(struct of_changeset *ocs)
> =C2=A0{
> =C2=A0	struct of_changeset_entry *ce, *cen;
> =C2=A0
> +	/*
> +	 * Wait for any ongoing device link removals before destroying some
> of
> +	 * nodes.
> +	 */
> +	device_link_wait_removal();
> +
> =C2=A0	list_for_each_entry_safe_reverse(ce, cen, &ocs->entries, node)
> =C2=A0		__of_changeset_entry_destroy(ce);
> =C2=A0}


