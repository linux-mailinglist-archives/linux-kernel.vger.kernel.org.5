Return-Path: <linux-kernel+bounces-98281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 773288777D4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C34B20D9C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598339AC9;
	Sun, 10 Mar 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9321xr+"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22722318;
	Sun, 10 Mar 2024 17:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710093080; cv=none; b=X6nApUbtTZuwaU0Tsk3uLAma/VrX5Fbznv4cHx+f3+iE6zU5VbIFyxjD+6h26WuiejmmeFqp8z/ECMcMVVGQtknqmNXuAg+ncCna8MJ18StMo1xALX58NZ9gBD1e07k7As9y1yaBYAYW1VsPZWmmx0IyFWhvOYHD64hcnydjLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710093080; c=relaxed/simple;
	bh=bsFRTL4OWLK5wD8lEfGHOAXfma6MC8Vd5IyXchmZz0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAglz/yIpuaMi1w36Yp5MayMIl0f7o0NWjKQJXXPIH6hg/bM2dqHJ7+GK3KS7sRR8DdYUaWa1q4fg0/GVWfNGMRsMYpbenp3T/QlU66ChAD0RVIHVo6vmmfnTct3zZw4Xg9R3SDDxeX2mFS6QDnCWtc4+tE0/S+NCga3DOznw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9321xr+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2218a0f55e1so1945966fac.1;
        Sun, 10 Mar 2024 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710093077; x=1710697877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsFRTL4OWLK5wD8lEfGHOAXfma6MC8Vd5IyXchmZz0E=;
        b=I9321xr+inZSP4lrqFbpFooCv1rVwHO9x4IU0WHOLK/iLVMP8UuP9iIYpCwqRUkTmH
         86LqoJbeUHLtk59DWrNyHNommjrIqEBZysx6VkOVtTYE0DSTXtge5gRyL7RKQV+4SvY6
         jIWqN8FsxjROrnhBToPG1q9jx6GU8+f0L7PYxOFvtkMc7KrqljtueL6gEgrWUm4oixsK
         Db5Ph/ihp7jBBSTUFYVCbxnv7ccuJTZmdb0y04okbPALMKV+xfUSstnyh6dYlq4z1f7i
         5R/W92huHKYn6VqfvJ80BhuOr1H23xx4h2EYeVGEkkCHTNCK/Bd6L293sP1WJDrak8K7
         PCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710093077; x=1710697877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsFRTL4OWLK5wD8lEfGHOAXfma6MC8Vd5IyXchmZz0E=;
        b=amPI3lz7uqJKLOYzHQ3Etud+2DLljezGQEA9ud5zLnTcxNhBbcO0i7VoCEKVRv6iJt
         cUK6CnfN0G7PFroZhSH8XoleVjrwuKq/fa+z6tbrTrc+gQ/2fEl9LHTMMTlRiBOEvAZq
         aZ7ea9i9AiXhlabTcrsolIyDEvc3W/eqUb2qpA8hQIXeBMw+kuSygv7CBjQworiYQ0nG
         mgUOUXA3rCrwQOJoTbWReRSGUQXOO6ofSOokndkkuaQUVY/51/WOIT3N6YqLRm0+z1oa
         mUKw0lU5E2U2Ruy1pSd2iDXbQXdtLfLbySCx11LqpftuZzwxvschWBHvKZwIldd5IX+V
         Mlhw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMxc/l0N59M5ogCq5TD4WaIOMgPpXZOH4aZLlWEk8VWjipWOLJbzgNrEJnwrwyuWm0Q0UUY06aYibYcvM4TKGXFF0V4sX8JVSn0g8JdzCef8NuSvoXIqHfymeR8sHvbsM73JdH7kLWrIM4HKrof2IyIX8AgEtR38rA8ycWf10KvjaEw==
X-Gm-Message-State: AOJu0YxbPfH4BiUi/WGDuFajqKfvEdzXoE27GokrjB1WrPkhQaNOEOJL
	HzFj0LX9vQCsXWqx1QOjuECrebJghz2d1pBbxdkrGsN4FQu9vA1wKVeJDdY449PpKv/GorlEIYn
	7uq30nYXNbGBNrpUQPMqrwno2kaD0hJaBFsM=
X-Google-Smtp-Source: AGHT+IGKzauZiQq5aGT1957OXJ7Zz5D/KSOp1V5RE9wHd+vAotNs0VguqGePzgh3cpZCkhl3ZQps4EIu1kirla6Dkto=
X-Received: by 2002:a05:6870:649f:b0:21e:e476:9170 with SMTP id
 cz31-20020a056870649f00b0021ee4769170mr5536519oab.43.1710093077653; Sun, 10
 Mar 2024 10:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310171958.96388-1-animeshagarwal28@gmail.com>
 <2b939f61-c8b9-4b41-a319-3bf7be42ba3e@linaro.org> <CAE3Oz82coV5RgcRE=Lj5mm2kjdzh3iFJGpMBBw_OfZppfWAHfg@mail.gmail.com>
 <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org>
In-Reply-To: <d609c172-2bb3-479a-b5f2-841aed455bff@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Sun, 10 Mar 2024 23:21:06 +0530
Message-ID: <CAE3Oz80zrnLvpo=YdBA-3PAtJFP8KK4LGHpEpQaMCacFFG13Qg@mail.gmail.com>
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

On Sun, Mar 10, 2024 at 11:08=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> I did not say about subject, but about commit message.
Ok, I'll add commit message above the change log.

