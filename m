Return-Path: <linux-kernel+bounces-98276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB48777C1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E231F21149
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888F39850;
	Sun, 10 Mar 2024 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX3qLIWE"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC593771E;
	Sun, 10 Mar 2024 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091920; cv=none; b=juFdXH2Jp/gbaxYNfKJDMDE/XKBB7Ca/l/vG1JmZ6S9dbvlsBylYAL2wK+l+SbPOdVcoe6eDCI8XoEMVGn9iOuTe0XUzX9kw9rKOL+9ujj/8ijP6jjNkUUcUSIPVwGhktDHcMKlbhJ3fAU2w5S/2HnJRVRURogfCVWlXlgDjudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091920; c=relaxed/simple;
	bh=7cWT5xfSREwAEkQVO7e1cpCy5aPPwK8I0hZoOB5bRQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjgLFbtg9FY6S6fE0/zVxAsDR9HEKoWP/wkuz4YP9nNDvacH1ewxv905emtpNUXhr0E1oKMh3MYuV1TVYh6CjFgPFEJ7I7YMa80o84TCrQGezJdQ6p/sN+qbzSGIPHYO9K2p+gWsvHftFyE4KEtXyALPh+vg5tR9jeHJDPV7xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX3qLIWE; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221ca677834so760698fac.2;
        Sun, 10 Mar 2024 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710091918; x=1710696718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cWT5xfSREwAEkQVO7e1cpCy5aPPwK8I0hZoOB5bRQE=;
        b=PX3qLIWEa+EechRtM5lo+vLpXhtrXtXdZ/HTUKa4p/aX0GMfIN0GFWGA95xaLiSyh9
         qYWcKiW7LnUVlhHyB6X8tvCLoQXPs//iDDkOoZ28zwN6cLSI+94oHLvRGw7cGM5ENiMk
         /37ycGkFJWPtUa/FK6FX+82gpDT42jWgwf+o/yP4y1A9jT5yZ0Wt+jo1X+UcBcO205zE
         iANSqT/OpUx5MWMd1uJPnvmuxPrDD2snOkrHafkD+3LCakqc3bMd63k/nRR4qQSRKO49
         2anbHEV8XS20HctDtSSUx8SZCEAi3LSk3fztSCrpuaPwjE1+1On18MN5vk+4ZhZc/Tkk
         jGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710091918; x=1710696718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cWT5xfSREwAEkQVO7e1cpCy5aPPwK8I0hZoOB5bRQE=;
        b=PBETR/6KQ6JgJfKViR1NVmw+akfh3ZH3L8sOlcet4K/mHEVbop3Nc9jutWTG2zlONI
         /LUDeFgn/xmnS/SdMqLk8cyvq1B+JdGDZzkdHSZR7B0jns+Dlja+ev9GUMzAiSpmPJ/G
         bd7DkEhNeXRmDmZtkGXgJcxo2LYwrPKHOP+DOCbJ3nYONLybt/EookiMsg0ZP1MGmgEw
         hH3P6UDiPIJawvmLssEs8tP4Ju38Nu0KUfzGgvs1a5kHt3SdxUtEOCez7ZejrcF5AIL9
         5UqpExYEGX7O8T78ktYZGw6KQFBEJX3xRjnIzFx1tf4CMej1PS+1EJjufV+VTjwMgjhL
         WIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB4t0CufuYNd0mrgesJGtYD/LTBrxS2EatChc9WeON25W9PQ6tavqeY8Zs27bpnnrRTpOWGQKZFmh16iJI8UWk4+JekP/aCx37hrUf1Ff4z+qEcizYdHnUuclIv1a7Ag/2Nl0wCCUpNlG+ipD9uvDBpsV81gvSrS2T2lS9rHZ5dJ+TTg==
X-Gm-Message-State: AOJu0Yy9GctPL/0cYAbz+w5Vz/jhqDO+EbiZ9mYJFhrqGAG4KAkh75lw
	nCVGBPHWXAqOhMI9HUkG2wtSC5UnJi0EhJqsVBZSNZqsWrkDU4CjQTH0cWzzNmgwA9fTCxrIug0
	1DTY8tXfxTPeTSKHNilgeBQENf4s=
X-Google-Smtp-Source: AGHT+IES5PfXOzMPabZb+7fMKY/AXfsq3UWaR5FKgTxJHWms2x5hQHp+9LqMNF6W9fC9fjCH0UJSstL152Wl0KWET/M=
X-Received: by 2002:a05:6871:5806:b0:221:14d4:6ab9 with SMTP id
 oj6-20020a056871580600b0022114d46ab9mr4973231oac.2.1710091917675; Sun, 10 Mar
 2024 10:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310171958.96388-1-animeshagarwal28@gmail.com> <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org>
In-Reply-To: <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Sun, 10 Mar 2024 23:01:46 +0530
Message-ID: <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 10:55=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Same commit msg, nothing changed.
Sorry, I will change the subject line of the commit message as well now.

> No need for items here, just const.
Ok, fixing it.

Thanks & Regards
Animesh Agarwal

