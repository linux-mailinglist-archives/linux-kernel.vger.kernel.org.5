Return-Path: <linux-kernel+bounces-146693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F225D8A6971
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DC8282F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22FE12882E;
	Tue, 16 Apr 2024 11:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku6XLBND"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A9128393;
	Tue, 16 Apr 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713265934; cv=none; b=a4x+6Knojrg/N56Cr/Fya+5f+auTMaNQlcsRusxg3GRNXMa2Vc1SyxSyHRmiOPfFnOpHURGfE1CNFKj+PesTqtMbBkyu48Yxrp/Vbl5OcWG7V5A27JUiPZ6Vxt2fNw109yklzaDk60okAKNmImHeZhBaQkpqN22hD9MqGl7zDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713265934; c=relaxed/simple;
	bh=WUeOeIUBKLtxrF61EOrBlEICYb0I3CNp/rnZBQWIcjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8Cay2mocBRmhdVMoLbHgclNfcVFMlLvvER5DWKfGWFS7tsk8azSbvDSZsTyKXxKKpM+Wn30Ne9LsxJNfTx0hXzSA0dWglhvzkt2Z6LDh4uD7JuzDkh8+s9LLcV6hrFxsT1lVbn2jzU6HsnuDklbziuebn0+LAcLi88iGLqjvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku6XLBND; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57020ad438fso3751482a12.0;
        Tue, 16 Apr 2024 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713265931; x=1713870731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADMsDHTpuzrPaN2i1AVLmsNYmni3qZ56Wq0WR2pQ1C8=;
        b=Ku6XLBNDRXl+mwxRamH/XuYEAcaa47dd5JhivDC8VLssgxlMOtaN/RuWqcHgZhC6Kt
         lMBXFsG02wkZQ5jd1PNwohBg9VF80S2MfZK4ltmIOAhslLIfvjOrUQGBKT2KDxahKfGg
         21hkam4KmCYWigcOKRp02iC0vXJclPqcxpqW8U3O5PpzB+gP0Rx1qKBrAKNp/Q2X0Vzz
         V88F6tL97VpHzYPvfoZ6c6+HMPU1cuq0lbK2SUOvSSJ5L8MAxEM/2veLcGaBgK2JmXFh
         3EGSgp3WOSFoX4CnsQxR4Xdt5Y41UJjPjPxmA8wkkBTLMgs3DpXCoMu4jgrkhCTKOOCR
         mUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713265931; x=1713870731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADMsDHTpuzrPaN2i1AVLmsNYmni3qZ56Wq0WR2pQ1C8=;
        b=ojRNM/QCbhgGckRPPO332+h/z0dqw9Yc00k1W5Je4TSfJGJYUyGyl71E2O8K39+r6w
         mi27tws1lv4dmrDkk7hoBTegvXZRrqeCCxAF3C4/4ToWY1bEehMaZ13VGGgF2MgwIGaW
         6iApPnMJDxitOa9gqYZXs4XGzFVpQ34psty5fUHojQgEYR+UEbIYc4lypA53t6yJbl0r
         JW944D/syTnU4AfJYnrW+N8+ITKTReHTC2DxiYK0ynDrcwoxxRGrfC8tZQb7/AeEtLDY
         owjcEZ39VB2TczySKLJiAiR5jxHQ30vqzZ9vXKqAbBiLtzf2P/pHrXVMANCsRJOtCDHF
         QsXg==
X-Forwarded-Encrypted: i=1; AJvYcCXgQi2TBeOl5LpgkSFwBQOjlovkvrr2BDJS68jOm/9PJRXkHS/OiYCowdA+KrV1GXgkY8EM3jWuIH50vYJGYLA6ZA4M+IgnqljkcwF4
X-Gm-Message-State: AOJu0YxaPEyxoSSTFSQYZrJfz+RJCEhW/hqlZVqE3j+GAnCPCL1SzbGQ
	X0fjxy4RVMsNMhbZXm2Rn6NYzN+n+3T1CnrUO5wvRUTpy0oXIHi/NfJsES9drFTbaPVlR50b2qf
	emU9Fiiyg/LjDMH6W4juZJw00MBE=
X-Google-Smtp-Source: AGHT+IHXIwGj6aH+H9fCW5Ehxa1vZNOsHUgoqAZLwIgfrWI/At+d82nWvx/mBKxAH+gjreG9BOXjQyMdzfI86Sn9iKM=
X-Received: by 2002:a05:6402:f0c:b0:570:17a:b1f6 with SMTP id
 i12-20020a0564020f0c00b00570017ab1f6mr2196166eda.6.1713265930533; Tue, 16 Apr
 2024 04:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416034626.317823-1-liujianfeng1994@gmail.com> <20240416034626.317823-3-liujianfeng1994@gmail.com>
In-Reply-To: <20240416034626.317823-3-liujianfeng1994@gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Tue, 16 Apr 2024 19:11:59 +0800
Message-ID: <CAHk0Hosivk8=2LNC6Pz1qAGFg1791z12tYRf-cEZNLZb7HaQVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add ArmSoM Sige7
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	sfr@canb.auug.org.au, weizhao.ouyang@arm.com, 
	Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 11:46=E2=80=AFAM Jianfeng Liu <liujianfeng1994@gmai=
l.com> wrote:
>
> Add devicetree binding for ArmSoM Sige7 board
>
> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>

BR,
Weizhao

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Docume=
ntation/devicetree/bindings/arm/rockchip.yaml
> index 4bd033ade..fd644e32c 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -49,6 +49,11 @@ properties:
>                - anbernic,rg-arc-s
>            - const: rockchip,rk3566
>
> +      - description: ArmSoM Sige7 board
> +        items:
> +          - const: armsom,sige7
> +          - const: rockchip,rk3588
> +
>        - description: Asus Tinker board
>          items:
>            - const: asus,rk3288-tinker
> --
> 2.34.1
>

