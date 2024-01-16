Return-Path: <linux-kernel+bounces-27767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED582F592
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897A52867DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284181D549;
	Tue, 16 Jan 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir7VTOym"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBB1D53C;
	Tue, 16 Jan 2024 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433997; cv=none; b=mYfd/JSl9owTGX1ZxFSSswiH2K3jqCWFEiLKsLcBvwu47Sw8CGM2yhSMDpnoWJDGDuratbyn+1dE3461y6L5X+33HQZjxmXa5pbLZ7VkZuwdQuv9hlQzgzOR29mTwnFgr6WCg5FOXQYCB5Z80WygD3fTf09uoXj4Elgh7KSV8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433997; c=relaxed/simple;
	bh=/TXrWyHiiSTgpveq6sOiQ38RhpDY6Y4heRubaDLwPmE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=Yv52fNl1rwu3G2x5RvroxE6SeFVSNaFk1lEESj6TiLDaQKdUibSAeNH3igk7xJIH2QZDMJYBaOo21I8V+YjHb8wHGKL3Et6WksVPck/VVUC7omDmlBNA5wjG2T/HQ091gjZgu0GBTu/68djCPJSRAeGLPvQpljkwx3jKyb7jImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir7VTOym; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5ff63b12340so378157b3.0;
        Tue, 16 Jan 2024 11:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705433995; x=1706038795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/TXrWyHiiSTgpveq6sOiQ38RhpDY6Y4heRubaDLwPmE=;
        b=Ir7VTOymj2T743RlreOVTjvsCZcKpCZEVDxtDJQPynYtwfj2H3+8soewz43jQybRfI
         1A0uuzt+HdLJ+2vXlSRPGeJgJsB9seVL6tlB1vRXTNCGun6lU6tsrFFEacUYcGS4WkKW
         CZ69mtZmVzRF9VUvC091ml10H3BDWCbRThUSpblmMtPZDUIz1lDqevgKthAS/K1SnAe5
         cEm02aMLLZv6J2IS7AXn/3tQKBQ6d3Pe10blzTpnANbYZGRa2eKO5qefqqtoUr5U4Y13
         p5M/NblL8VNtQY2Iv91ju9t+HOFnsrze8bKkgR7yF1mIiHIxN1/VilfvGKgTq65fjON3
         GxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705433995; x=1706038795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TXrWyHiiSTgpveq6sOiQ38RhpDY6Y4heRubaDLwPmE=;
        b=Xp2Fi+t6pc84iDhtzZJSmvfYKwsNzyOlsLKUqYyCkc84nAvOcHZUPefxiBDNbBxSIz
         xcqXNL/v1J+CROZ0JfYbmOvUdgbKBPhw55be4W9HWwfHssUruz7CV8dLBbbPKML6Ihw7
         HdsKxekx4O3+TXHSSBeZvJWV+PkLUEfGTw9oyJaAvrb0ubMLHju1bevqMhFh0MvM4CiX
         TgtAcgg8C91hIgJOqtE49ulXpVZKZpF86NublR4JP2t10xt1Ys8ZaXDa8MQ0jUFope27
         HhApzKkU5JouBb2CAGbtUSoblPLqDyDZvc8lb2xZkFUtU8MV1orcIFDh1s8fP1VuWbX1
         y6aA==
X-Gm-Message-State: AOJu0YxTUcmJr4v6e1+T4gV97lXUWa2dbUXw8YW6oUJPdP9lkBTtBIGn
	faTdbOdwWyGnKV34+VrNEqTRUxi6Ejk1JZIpvKo=
X-Google-Smtp-Source: AGHT+IHl7pQB/4BopFUtAbosETyvinXpzrfJUa2QsBn7qAYwOuBOVtdkXkA/phlJcO5qEAjLc6AKbVoymoezexRzl3E=
X-Received: by 2002:a05:690c:f90:b0:5ff:56b4:263e with SMTP id
 df16-20020a05690c0f9000b005ff56b4263emr1259306ywb.101.1705433995037; Tue, 16
 Jan 2024 11:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-8-tmaimon77@gmail.com>
 <23fdd643-ae30-474b-93b0-fb98edeb0071@linaro.org>
In-Reply-To: <23fdd643-ae30-474b-93b0-fb98edeb0071@linaro.org>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Tue, 16 Jan 2024 21:39:44 +0200
Message-ID: <CAP6Zq1i88mx8hfE-Ui_yMDOUxB5YofyyRSygBY8zuPq71ptHqg@mail.gmail.com>
Subject: Re: [PATCH v22 7/8] arm64: dts: nuvoton: npcm8xx: replace reg with
 syscon property
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your comment.

On Wed, 10 Jan 2024 at 22:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 14:54, Tomer Maimon wrote:
> > Replace reg with syscon property since the clock registers handle the
> > reset registers as well.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
>
> NAK for the same reasons as previous patch.
Will explain more in the commit message
>
> Best regards,
> Krzysztof
>

Best regards,

Tomer

