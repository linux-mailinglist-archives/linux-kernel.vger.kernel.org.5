Return-Path: <linux-kernel+bounces-145229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFEB8A511F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2796B22037
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD87F78B4E;
	Mon, 15 Apr 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj6lUXf3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5C71B40;
	Mon, 15 Apr 2024 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186615; cv=none; b=hdDjAtp4CS1Dz7iwHYrFFD2LqEXcIxZ/jxhjVCpk4O1EOSFmQyyT4qzrZxxqSOJ1iaWe4iRUT4fU0BJBQkx/gYhorPaak3t7iPwgMbnrkalexdEV04qao0TPqKAkM9NjMTL6yoIzjZP/CH/hx6mj49LyEibJbmPCEph2JUF2Lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186615; c=relaxed/simple;
	bh=VpE1Qnwojfh1X5BHVf4R6O3zFOF2Mqea75mnDO8ikEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbM71PFh7zA808ffoPmZvJei+yTJz19htGsd3eFe8MOhH4gCY+a/tZP/qBI6XO3HilavQQV2Afr1+X4U0K8azhcoa3wTkZCSRGLKbBfu4nn41BWNoC3l4EZbaIBFyIWh4fNbwcnZ1ZidS3EiDE2kE8fgCp+E80/xn/LDf2FS/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj6lUXf3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2da63269e75so12768501fa.1;
        Mon, 15 Apr 2024 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713186611; x=1713791411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YmX6u/Der+0IzS/XTdYy6+ZCel0Tz8ZK2bZueMcf0Y=;
        b=Bj6lUXf3eJ7XC1gy39UH3PBlQVsWw5abv1CLDM/v7hBlrNQxnXF9ipSYweMqfqDQP5
         6cAx919MYhdYwU5oksZJLiZTMI4N1+358yb3kMXDwceKjSJTuLuh+60nBMXd+Ig0d2Ru
         is8ogeMzbz7zlT+mAeO4K/WcL6LXH+8bwxFGETyBpm9bjs6l8pkDLm3UylIVKzY+tH4z
         6uqsE1BGwEXAR8aoBBP/18f9OX6KItUbfPgiZhPbzwQKcG+wNBJ24UBLJgEv+PNpF6SY
         AtJZE/IRhnk15i8c+Lt/RIy+GMq+i0YyqE0nH46+ECynBLrISiv50SeKzN+OngHbggIn
         GKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186611; x=1713791411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YmX6u/Der+0IzS/XTdYy6+ZCel0Tz8ZK2bZueMcf0Y=;
        b=Rv9fppIrhAefoLJFgWd2h05iHGBFuvflvJw2gsrmZqj4SqQpU2P1yJS3+eLu2fGX50
         oxNZtsDSaU03oRb1Q5HiW9nTEnWSwwuVDQ2vh1GkFDlYDa/iYxUcek+rloWgUayoHQaB
         OA0ogbIMvtm5tYmiqOM3XBetZir+blv5l6GWPaS2QtKd0dkyzAWOCjv/YcYc6lcmL8EJ
         BB1vh6xW0IoH7AWxq/sS9fDKM6rpo4taWqmm4HVGCFenO4GqQJY07vRJeNmKAhTYjMaX
         Daf7HF8+RKScSvYIv5pFVnlCyC0gk8dA7jE17tnqcX6aXJjmBxG4wjQkMg9E6SI/K7nm
         Kztg==
X-Forwarded-Encrypted: i=1; AJvYcCWOnYQgK6Rq5SzA/qW44wOhUtPl6E4A9XYuebx4feL+9EjO0YpycIaYiXWKddaLm/CPQhOzKdhGePAuGzCBe96j2PnRdy+YXjOEPTJVfKC32UEPPaZgr3ydX6O6P5lrjliXNTZnwZiZ8w==
X-Gm-Message-State: AOJu0YzweB0tUqDBuf96c84zfmRm82CDe19LiFrkLG+2EhWyBW9bPOGM
	RC3XclUPk48sGhTrW5JpkH+qQqc7txhEZhO8T+Ax20LpfdZjLfk3l24iwf5hu+sPvQrKem9KKuN
	EeMS0XldiIUB1+3ygRaH7ETHj+sk=
X-Google-Smtp-Source: AGHT+IGjIewtaI/sCKBqHEj0RrILEoev+3bQJiesZn9r6UVM/5fQn7CYy4r2gYKHReg36HLwcCY0Lx9k7BkYodlJaOk=
X-Received: by 2002:a2e:9984:0:b0:2d7:17e0:ff56 with SMTP id
 w4-20020a2e9984000000b002d717e0ff56mr7325159lji.18.1713186610759; Mon, 15 Apr
 2024 06:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415103523.139-1-bavishimithil@gmail.com> <171318046103.2331667.2375787628199943181.robh@kernel.org>
In-Reply-To: <171318046103.2331667.2375787628199943181.robh@kernel.org>
From: Mithil <bavishimithil@gmail.com>
Date: Mon, 15 Apr 2024 18:39:58 +0530
Message-ID: <CAGzNGRk1S3G1jWZMarRP6YaFOTVciqkUT8ipDvu96pmTvoDBLA@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
To: Rob Herring <robh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"

> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
>          $id: http://devicetree.org/schemas/sound/ti,omap-mcpdm.yaml
>         file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
>
Right forgot to rename it to omap4 in the id, should i send a patch v4
in a new mail?

Best Regards,
Mithil

