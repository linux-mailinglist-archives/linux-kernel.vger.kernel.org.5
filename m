Return-Path: <linux-kernel+bounces-58156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA04D84E202
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EA11F23CC5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D780D763F4;
	Thu,  8 Feb 2024 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4FdZemn"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B6763E4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399093; cv=none; b=VrrYOTEFGBdMtB7LRBSyisoKP12jnwyGz2Act4sH+TrIZMwrgEvdVLQOMX1a8ugBiCD0J7xBSk+QLvhyModpormH8jLTfquNDyPKKVGE2QVezwICvoJWTb3BGPgjiD26OWDKQPRWWca1ubh8IHU3e2EKnIVF2m1k8TAP2bwdNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399093; c=relaxed/simple;
	bh=C4OvEEEwjXlQdhcROp3m3acnLC0LaYM75E3IJm7BavY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG4xC7v4alDCAtfo0z3HuE1N2rm4JzXpoBo2wV0zF84j7m6C5qDgPzUxD36uXZI1U4dlnyYvaSYtshULKaQ7nokWIncAJG7Bmh3bTwUkyP733g8C+p/K/Ai3p7V4HbyjNqsH9keGZ6bvjXBIGV1pGfl9WU9jcYhJpg7bJaReEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S4FdZemn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6049b3deee8so15537017b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707399089; x=1708003889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4OvEEEwjXlQdhcROp3m3acnLC0LaYM75E3IJm7BavY=;
        b=S4FdZemnM0WZ/l/jl5wMZmdJJQKVgReuOcB0QNNVtS+IJVv7SqpOOlS/bWkxG3hvjk
         CG+nSxatlZ3Mg/uVHYxDZzfkmE/ENQGJJzo8m2PDeZ7Z0Mo0VgwJ/wYsyjP1fEVPcX3m
         vqKiXcPwun6AXF1QUIfnNXVWDOcSzjyz+Zn+YVaBX/pj9KIKBRQ+PRnLdR4ZfEhaGR+2
         UyFg7QgkcyD6V+yGN5kCMbFoAcLoO6RKtkny0H7Eac8h+Ise9xvYg8+4qnDlmXzMZp5f
         yFV3/y61D8OerhNVfc6ZliFd/Ld0OC6qDaGbKMsj4GHvAnp4nNrcF2MqDfDtSxUDzEZc
         Nhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399089; x=1708003889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4OvEEEwjXlQdhcROp3m3acnLC0LaYM75E3IJm7BavY=;
        b=UyFDX+77dsqHCrWCTruYmOlqY1+UB7lTeufeBaejJUkcr3GEdsnMaMdf4st3Nks1ba
         iYxRSyZuAnNqVasOlVbAMEFpm/R+B2yg6UPM5+2LEYkRpQMPHR9vi38C3qhmcTAFwCaf
         8dcNqwXK6AMB7rHFc4rjga5VL/f4uMX9eTolouEdF4nysaghQH0xmGGsfyAAXFwhvEnW
         GXDW8E2oSxdXPryc2J2nc0ESNNmvO7Ma8Bamk7u+XytBwFi7KBLcH8pooyXaxkS7Znjj
         f0aqIOUwE7e0otrVbaDYHnrAuwHa3g6H0mIaT2jAKJkMcu/2AQ9vGnrECAm8CohTrJGN
         mCOw==
X-Gm-Message-State: AOJu0YyQtpKz192Jee521AhHP5Rk/dnNy7GPTNckTFX5HUvrTBeT0X3/
	swKaF+NPfpo6f0rMbIyEK92q4eqdJULV9zeDJdTxEfI7aJQ1fa/HfEBaG0Q545pjqOxDCiRSh/7
	1dwU6Luk+EekxfiaHhhi2r+nx/SIAtBK3g7bnBQ==
X-Google-Smtp-Source: AGHT+IH7ejHpSxnYkgSDOz9JbPT7cK19dcHwdUp8da713zRYjS45D7HGSn8vMhrU2FW5og7Y4ZPr4S9V7UiubVyiBWo=
X-Received: by 2002:a0d:cb82:0:b0:604:9e94:7c02 with SMTP id
 n124-20020a0dcb82000000b006049e947c02mr3572225ywd.25.1707399089608; Thu, 08
 Feb 2024 05:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206112501.715042-1-naresh.solanki@9elements.com>
In-Reply-To: <20240206112501.715042-1-naresh.solanki@9elements.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 14:31:18 +0100
Message-ID: <CACRpkdbzv-Q8KouPCkWmc46Eti5fjnuiZUbWcSsKCXReurnnTA@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: pinctrl: cy8c95x0: Update gpio-reserved-ranges
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:25=E2=80=AFPM Naresh Solanki
<naresh.solanki@9elements.com> wrote:

> Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
> reserved ranges.
> Add input-enable property to allow configuring a pin as input.
> Also update example.
>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Patch applied.

Yours,
Linus Walleij

