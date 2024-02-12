Return-Path: <linux-kernel+bounces-61526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1837C851342
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B590028121E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9939FEF;
	Mon, 12 Feb 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIWaC6hk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A93CF46;
	Mon, 12 Feb 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739833; cv=none; b=EVb5a/gVtTkJZOVkgnZXQeGwIUh9oTo/YywbzF2tQu9pFEATnG0QZZ9E8zvC848iCwMjoGut1a9UmZY4SbhNQjpp6HW5WSVN5p2kEoLTPmAmQVd4iMvkJqIhLTZ0hhO7hU2gwczw1qeo8tPXQW4sxssna6pLQfDgtL153kd6jWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739833; c=relaxed/simple;
	bh=GnFWVmemu8BYOERdtyu9t5OJb87P5SyNHTwrEQ06Lag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RyxFDudod86AFfcj0xp3nnZPlP6D0gxHxdKGSgDegf1hmbEGWnLpFvQoUeVuEb2YqcG3SlzOLodU0hMsNhgr887My/lkhk+fY6FoJHFgL5cf1BQHnl4jbKO2f8ige6T9KHp+vkfwMPnUTfZ/c6GLeD2OfOw87ExeMfR7Xct8Xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIWaC6hk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-410ed9f8621so3217335e9.1;
        Mon, 12 Feb 2024 04:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707739829; x=1708344629; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WeckcWDXsxVoLYVhObU8PR+O3C3HC/cGcTfcIbOzKU4=;
        b=SIWaC6hkuI3DOMX9cG3AIPy0eppa/aOJ1KIcTfjM7yaATRu/OXmEdwDM0fqw5RsP34
         1Wqj+9X6C5mqgNOzmiAP/Je66N03OpwQLXNc9sAmtjjyhShILKGKPWekF8fW50ZrevXR
         9JNTOpdHQMYzNMxtTTV6HlPv2Ne7XOVM9zpsU5Vxrx31kXPtqTtdKJixMNbd4oYehono
         DHsuXC3jWP5m3Z4B6XWLU+FXB9lt4O+Jf+mceU7jS8N151QlFns4eOHRBbFf6DxC17RF
         gN0AzqTuUzRTeiyXMo3M+dNOC+swqJgIO0cxPYDAlRhXbaNwCx1SDLIEa7eewrNP8iAp
         HbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739829; x=1708344629;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeckcWDXsxVoLYVhObU8PR+O3C3HC/cGcTfcIbOzKU4=;
        b=O0NP/CNugCeRVs/Qq6O8ywEeRbuz5iXWvGjkSncd1AIDUU5/2Ip6v+QyYaCVvSBcY8
         lGxoM4n9Ux4iLKYeEXbaVGdDP2w9j+i6u1UbB3nj2YkPAbNq9fcjccTP4+XZsH+JqhJm
         qblxJzqgQWNso4x1+bpKP1n4UxVFfDrtrqKSStqsxkA74zDMJ9zu2JvR5jeYRopq8QJz
         1uhQjhlA6Ul50yqPHdPT1oqEMAfJ4dIDMWxgvQimt0j1dovnrwDuLBLJ2ElPlYsNPuO+
         v9Qhu1yEtEpuJ6yMAe4bK3kR/vRsIJNzOlpmW/J4I9IVIAabQGUpLyIhDgKmOa+v+qYp
         DCZw==
X-Gm-Message-State: AOJu0Yyigv5t0M4qTbU7u2giIZMxboh1MabTzOblWlQgmncLFyxFjkXn
	ehPiLlbBwh7uMIcugzmQg+sGS1kKgugJZ+YcFi6Bg/GGQL0Llf6Z
X-Google-Smtp-Source: AGHT+IGvQg/g6I11lMMUumpri0F9ohGfTFja0F7niRerM9cRNs8Z1IFkDAlbxyXQsM834xhCbprjoA==
X-Received: by 2002:adf:cf01:0:b0:33b:7134:7ec4 with SMTP id o1-20020adfcf01000000b0033b71347ec4mr4951109wrj.14.1707739829158;
        Mon, 12 Feb 2024 04:10:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzJR8YqEfUQzbusCbrs8gl5tQ4i/j/FaGviqmtKb6z+PIaGf9yjKkxlrSve1bDq5u0w/3fBRG8mjgNXeJaMUGNbItlSNvLWCX0WjAyKIK5TRyhBhBvcGDGJsN+p2soDhKp68SmJjLM20mJh/AT7fOA1Y4sbuHgDbmpdV8HmpUevOWHpjemwa1hp5gXjgrLv8UxT5Uw8JMMsy+BchiuymnPsS3IIRiQLq7FWvo1OyK90WS53fXMir9wWsZrNv8RUvxgY/PW0Z2dtH48RxNxzbcWm9r9iM3mI0AFzmgmspocJMPpjYeekwlJA3/mb3SGwB4ApiwVBB3bNUxZnjZz4Qr91ug+4S0hBlGQCGWVxHLaLVMOis6qgKR9uYpNw9UFOprzOLIb32qi4BeYqhvFQ3Ssp5qNYCrHGcrWy8slTzhKlQf+mU4KP8zAcYLJ
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id s8-20020adfecc8000000b0033b671f079dsm6586921wro.115.2024.02.12.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:10:28 -0800 (PST)
Message-ID: <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally
 <djrscally@gmail.com>,  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2024 13:10:27 +0100
In-Reply-To: <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
References: 
	<20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
	 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> Device links will drop their supplier + consumer refcounts
> asynchronously. That means that the refcount of the of_node attached to
> these devices will also be dropped asynchronously and so we cannot
> guarantee the DT overlay assumption that the of_node refcount must be 1 i=
n
> __of_changeset_entry_destroy().
>=20
> Given the above, call the new fwnode_links_flush_queue() helper to flush
> the devlink workqueue so we can be sure that all links are dropped before
> doing the proper checks.
>=20
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
> =C2=A0drivers/of/dynamic.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..b7153c72c9c9 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/string.h>
> =C2=A0#include <linux/proc_fs.h>
> +#include <linux/fwnode.h>
> =C2=A0
> =C2=A0#include "of_private.h"
> =C2=A0
> @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> =C2=A0
> =C2=A0static void __of_changeset_entry_destroy(struct of_changeset_entry =
*ce)
> =C2=A0{
> +	/*
> +	 * device links drop their device references (and hence their of_node
> +	 * references) asynchronously on a dedicated workqueue. Hence we need
> +	 * to flush it to make sure everything is done before doing the below
> +	 * checks.
> +	 */
> +	fwnode_links_flush_queue();
> =C2=A0	if (ce->action =3D=3D OF_RECONFIG_ATTACH_NODE &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 of_node_check_flag(ce->np, OF_OVERLAY)) {
> =C2=A0		if (kref_read(&ce->np->kobj.kref) > 1) {
>=20

Hi Rob and Frank,

Any way you could take a look at this and see if you're ok with the change =
in the
overlay code?=20

On the devlink side , we already got the ok from Rafael.

Thanks!
- Nuno S=C3=A1

