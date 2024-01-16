Return-Path: <linux-kernel+bounces-27633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D982F365
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EC0285B71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DE11CABF;
	Tue, 16 Jan 2024 17:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kytYOVsL"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793291CD04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427034; cv=none; b=AIATk4sofaVsmNWiWlcUr2Zn0I41mDvbEim+HO89oSg9rEAIRpmvgzCiFcPbpPq/9GeM81uRYExZIfw0ucsWW1hYFOb4ul2yJ3rOKjEJwdG+z6USv54kOMuoZ1N5Y3McLIydu43Gp3KJfWIMpJgb9TVwwDZ9hP2X4JU/ep+lVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427034; c=relaxed/simple;
	bh=/5RHq/YUI+hVWY/e6eVlbHgLBhBZafmQizAWBbYsCwk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=V+4hR1NXv+UU6wqmFhWkgppBeYOh9AajtYH1xfL99/Yxud6pPzWzsaM0+a37DU9jAW1CrGfs/1GZSYZ+AOCatQiagT0kTD9a1q6I+0auMhtL2tTGemyFsrDVwUcgmdB37ZIBrOztdABZ7jqrhcdGuguiyib7mOdT2ytMM8XiGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kytYOVsL; arc=none smtp.client-ip=209.85.210.42
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dde528dbe8so4603819a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705427032; x=1706031832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sadTVFX/+yOxJi04GWahAJ/5tRCyZICMzUufzMQzqTs=;
        b=kytYOVsLpgGPnOWZyUS2ZYPnNospG68NYHcfCGdQm4YT4Wemn5GnlaJA9xp3OOiGvW
         pYenBsMEW95zkvgxXtT1KbyU8wsXjDf+b7Ax69cyRYuBBj8BVUcA7rtna+F7qajviC/F
         qlRSXSsjp0lL9+iZR/UAQPNgxLqHDKDEDmKPWDbDIocIIL4LLIpx/m+Leyb7ey3NOwT7
         Fjp371GLQ4p8D9OKuuzskbGSPDbUHFtfmavg9Nc8+Zp1ZvYgsXFSCnkPn/1pT68LA3MH
         ekWFgTa0yj0iqhIMpkOZk1GalDGnTwH7NeT2IQVNuMUiJncrJb9IfrSmXbKbHnYLDwbW
         5qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427032; x=1706031832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sadTVFX/+yOxJi04GWahAJ/5tRCyZICMzUufzMQzqTs=;
        b=PDRdEENQVuiF0D/+6p5w/fBmdJrTT80qkF6fFh9bR9iVVSKieXLvWShW2E5KTRreee
         j0WrNhmXF1gCIav7NGEbTCmXzkuAwywgTqsXLzIKpLLG7f4CpAFylostQT9fR+sl7JOl
         mbrp6irJInvUcp+bZwtRbPuVV43trwp17czXT7wQXY627xbZ60605TtQynEWPTdAHKWM
         uEdBiunipDJdBQFdheQW1JnAxj1HFDrzrrYXFFpdF48q7ib4Te72ZN16JroCLk09+Ytp
         ip44KC8P7rI1B9S5qRepRMiRuMFReh9RlDRgCLYk4YeoAzr/HHP9o8Pa/6pDQe1msD+K
         qRIg==
X-Gm-Message-State: AOJu0Yxh3QleeUC28HDdm0DA1CNLTcXi/cYfDTT7Ls7+QKWh3v56K3jY
	odQKMfUXQF+ZbL4vawN1J247V2IqkflCatOA8AeeB9+pK7m8Yg==
X-Google-Smtp-Source: AGHT+IGI87JfSO1MZ7YpCV7ykS5z6dPmVztVmhDswHZl7XYfkO+o3BgBUIEzwgatKdnzSh1R8Y7xKS2CmWu9HOzK/b8=
X-Received: by 2002:a05:6358:611b:b0:175:77e8:6c31 with SMTP id
 27-20020a056358611b00b0017577e86c31mr4700924rws.42.1705427032574; Tue, 16 Jan
 2024 09:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109114908.3623645-1-tudor.ambarus@linaro.org> <20240109114908.3623645-2-tudor.ambarus@linaro.org>
In-Reply-To: <20240109114908.3623645-2-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 11:43:41 -0600
Message-ID: <CAPLW+4nz9nOYgdkYGc47h2LRnDpO=ZG0vmNgyNXV5YkSQEqE_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: gs101: rename cmu_misc clock-names
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
	peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	conor+dt@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
	tomasz.figa@gmail.com, cw00.choi@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:49=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> 'bus' and 'ip' are sufficient because naming is local to the module.
> As the bindings have not made a release yet, rename the cmu_misc
> clock-names.
>
> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock manageme=
nt unit bindings")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../devicetree/bindings/clock/google,gs101-clock.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.y=
aml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> index 3eebc03a309b..ca7fdada3ff2 100644
> --- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
> @@ -85,8 +85,8 @@ allOf:
>
>          clock-names:
>            items:
> -            - const: dout_cmu_misc_bus
> -            - const: dout_cmu_misc_sss
> +            - const: bus
> +            - const: sss
>
>  additionalProperties: false
>
> --
> 2.43.0.472.g3155946c3a-goog
>

