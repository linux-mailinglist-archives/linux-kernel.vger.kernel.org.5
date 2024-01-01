Return-Path: <linux-kernel+bounces-13884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE4821438
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B736281E60
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E696AB6;
	Mon,  1 Jan 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0MHm4CD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD76108;
	Mon,  1 Jan 2024 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78160ce40ceso278473585a.1;
        Mon, 01 Jan 2024 07:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704122962; x=1704727762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOai/QjEk7Tqo03+RAmdQPXZT0jZzm9Xucc4X/XwTic=;
        b=S0MHm4CD52KaEEjeuvYmjsrwjjdRyG+EID0hl8vFwr68Ctf5/jH3OMdnakoxzhVAx2
         Q/cbQvViQl7DoeFa6zcSWOUYXNUcNPMWn4As+Y8mgTEXN2sywENrZVcZdv9la79IyqdQ
         vYSLdxtmBqJUqRz/FrLhjat+MYD/gmGK6Xr1OtXtXd3zHjdpzUeuFAumW9Me/sDk054S
         t0FVJA+K72n3fcwT47MwxmlmRXgzVJhIbDF7JxNOWIu05WUKjjLVL4Fjb530nIU4FyBY
         IzolDWyvUY5cZAp8sR624KW89uEz3rfQyipilvZHJkK+SY08/ncVcD40htuMx6uHqVv+
         O5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704122962; x=1704727762;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOai/QjEk7Tqo03+RAmdQPXZT0jZzm9Xucc4X/XwTic=;
        b=Qfhfs1EuI/uXAJCuM6tlm82QHMioxS/zCjOIv9a3hPUIMvfBFe7BrwLtZP1g2KRsuI
         KqYeIi/j0TSFZQHBZqzrlTJyKkECYnIQyN2CzmBYB83MG5aHqLwFw4KSN3km/Cu0g8xr
         svMmFZD13t4NV7qTXgH6jPa3z+8dCqrk3BpP943zYm+7G+B0fFK3QbP6xxF8P8Ga0MPo
         XX9w3aIr0mhOHWXRjB5V1afQD7pJ40evrsBTSuovPbXlBKDR32yeMNsxoa37QYJEA2/5
         kCpT6e7ZY3VDdOh4RR8TFn3TVoGsE/qExoMSM9zqjPtX82mxkRyNwDKBTz3WzPv7Wfmn
         pDdg==
X-Gm-Message-State: AOJu0YwTBoIpDPgEro7VdUPmwgNim8JcHHVrkm6z+Wk9QeF1NY8X2AWF
	tvPYMLbrCtrwm8c4oGADjGs=
X-Google-Smtp-Source: AGHT+IEiXWhUUGuteY7oXndwbY3RQVWSKD09LycRD+xKMXWl0huVS4i4E8KI+ZYBdU+gy/EDb8ttiQ==
X-Received: by 2002:a05:620a:111c:b0:77d:85d9:c655 with SMTP id o28-20020a05620a111c00b0077d85d9c655mr15082676qkk.14.1704122962028;
        Mon, 01 Jan 2024 07:29:22 -0800 (PST)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05620a468e00b00781d60d3597sm95985qkb.120.2024.01.01.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 07:29:21 -0800 (PST)
Date: Mon, 01 Jan 2024 10:29:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org, 
 kernel-janitors@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <6592da5178589_238b0d2943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
 <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
 <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
Subject: Re: packet: Improve exception handling in fanout_add()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Elfring wrote:
> > It is fine to call kfree with a possible NULL pointer:
> =E2=80=A6
> > 	 * If @object is NULL, no operation is performed.
> > 	 */
> > 	void kfree(const void *object)
> =

> Such a function call triggers an input parameter validation
> with a corresponding immediate return, doesn't it?
> Do you find such data processing really helpful for the desired error/e=
xception handling?

It's not just personal preference. It is an established pattern to
avoid extra NULL tests around kfree.

A quick git log to show a few recent examples of patches that expressly
remove such branches, e.g.,

commit d0110443cf4a ("amd/pds_core: core: No need for Null pointer check =
before kfree")
commit efd9d065de67 ("drm/radeon: Remove unnecessary NULL test before kfr=
ee in 'radeon_connector_free_edid'")

An interesting older thread on the topic:

https://linux-kernel.vger.kernel.narkive.com/KVjlDsTo/kfree-null

My summary, the many branches scattered throughout the kernel likely
are more expensive than the occasional save from seeing the rare NULL
pointer.

