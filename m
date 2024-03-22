Return-Path: <linux-kernel+bounces-111725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041D887007
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958341F23040
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9D56B9C;
	Fri, 22 Mar 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/TuKihk"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C356751
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122554; cv=none; b=crJfnJYDDrYZ85sz38ALbw4ABTzfjibMajTI6ieIm4Kg4VIDXTu9rjCCMX2w9kpOEH03ylte8llLxkC2SSUc4qYUSrv8bxTjYwe9BzqFq3g9F4zG+RGYzbeLr8739hjADcUBQpkGiKQODoeAOKQlHEnE7nve/xD7gwDKXhtIa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122554; c=relaxed/simple;
	bh=LsOMbpCEQIIHG6CfpAE1g8TZNBCVGvVpD4Ejjgm/Dcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdybDyokuoqPMvcUBsr7avP33dsKUKgvhtInGQ+kxpx4oe0I53swbJj98zC4FnR2+Lr7lvYyJWiZjNy6dOl76lWPa0sBDmhbQ+acn8YUrjQ7z3xWkj/93C1MUnmi1G7iDCppmWUwbGgs0GsPFd7P1gtqTXbjgr7DtCbUmHJwuCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/TuKihk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso2280308276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711122551; x=1711727351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BhAHakpbkRWxLnwXTY/kFw/E9GCrD7/tzOACR4ggZS8=;
        b=G/TuKihkWwCPVE0yS56OGoFOoHt9H4oapCfxhpoZrVlPkKoQoVGhR9oYzab9ue/iTw
         iwIky5Da444SmxPzqK5IaCJ4C5xxh+wWAND31c/CJy0pmD/cGWiqJveKB8cGM+yPMDPr
         mMRLQMLzBSKLDQHtgwwNapJQADB+8nsbmAN7t0S3eSbDZcsTjz8I1zHhINT8g5yRuEeg
         bzp3FJNIXgUKcMkOFnU7BRIPBfDPp7A0nXD2RFdPmP2T6fxZuZM2wDR+v7/8ZdkjkaVk
         QpoGWvvF6t75QVBOXBL9yqFtYg7sN2o2EdANhsodDULuy0NlaEw1XW7jZIMbexIxUeAv
         Njdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122551; x=1711727351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhAHakpbkRWxLnwXTY/kFw/E9GCrD7/tzOACR4ggZS8=;
        b=BzUXvm+mJm5wbsW5G2EWmKzsDn3squsVLK4py55LYQWXFwH7nvF6ZhogNhnL33FD3P
         2SvwO+EM7TlmYL5qt/oB1eWn4V94+7Ky7J+6XW6VnNsxyM4hliEpEn55k5F6lEmhQC9x
         rGukS4rHQfEBPjiSOCCEKApgnUx3q67PQZNjU0J0ID+gJGBx9ZuBcRYPMvJJqmbdE/K5
         yt9/uW5iGwBThXUZQYybwvCfVbGZRfb5jyMidT5PwhJMoTbrBLs4aV5Qm8pZv0LcTGuM
         DGFr39Fnd6f7arltaqVU27hbBulblMa97bsi4gDZj9aLtjEHoRxnkZbCx9259n3kcybU
         Yadg==
X-Forwarded-Encrypted: i=1; AJvYcCX8KqFnIKkxvZwzJmjM7aioC34gaMKsJzdjxY6pPfsYz5uw3YE4/c2LpB6d6yGroWyM5OiwThpsVAf6dsoynrJtrrVvptkqmCO4g728
X-Gm-Message-State: AOJu0YwljvFpxeSvckg/zDvbpbWxPGGM9S6I95RK6UMwA5KGMxDL2NJq
	dqB91ZA5riTUwq/QtlyU5uQ3yyqJhJRIo9PZN+8IPHde7CuKkTM7hJubN1utAqmprvcONPB5Y9/
	uIzjKO65YR76gTEjewiMV/QiUI5aHZUKFyU33Cw==
X-Google-Smtp-Source: AGHT+IFiFCNGwQo5I6qyGn88vMxbQnGLr2JUj+WbGlV0wpAWvPqe41X7FfktEE56qWUVZrUDzWGTPOfaUdP0x+NfxmI=
X-Received: by 2002:a25:ab41:0:b0:dc7:32ea:c89f with SMTP id
 u59-20020a25ab41000000b00dc732eac89fmr2674099ybi.15.1711122551622; Fri, 22
 Mar 2024 08:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org> <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
 <CAA8EJprD3fM966pLV4QXPUu=bFTn24fvPMKOaGqtqkAbdz7sOQ@mail.gmail.com>
 <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org> <c0f1e898-7638-4b7b-a938-9e31e5b57e57@linaro.org>
 <0b091595-1587-421d-bb00-c00ef729d143@linaro.org>
In-Reply-To: <0b091595-1587-421d-bb00-c00ef729d143@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 17:49:00 +0200
Message-ID: <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port description
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 17:23, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 22/03/2024 15:09, neil.armstrong@linaro.org wrote:
> >> TBH I think we should drop this HS, SS stuff from the connector
> >> definition - there's nothing to say in a h/w definition anywhere HS
> >> must be a port or indeed SS - not all hardware knows or cares about
> >> different HS/SS signalling.
> >
> > It matches the USB-C connector electrical characteristics, which by spec
> > has, at least:
> > - High-Speed USB Line
> > - up to 4 differential high-speed lanes that can be switched to DP, USB2
> > or PCIe
> > - SideBand line (SBU)
> >
> > And those 3 components can be handled by 3 different HW in the SoC, so
> > each one has a dedicated port.
> >
> > Remember DT describes the HW, not the SW implementation.
> >
> > Neil
>
> Yes, you're right about that.
>
> I suppose
>
> 1. Orientation switches should be defined as coming from a port on the
>     connector associated with the CC pins.
>     port@3:
>     orientation-switch port name goes here
>
> 2. Data-role switches...
>     Again the CC pins
>
> https://community.silabs.com/s/article/what-s-the-role-of-cc-pin-in-type-c-solution?language=en_US
>
> Maybe the right-thing-to-do is to add another port for the CC pins -
> which would still describe the hardware characteristics but would
> _accurately_ name the thing which does the data-role/orientation switching

It's true that we don't describe CC lines. However In most of the
cases CC lines are handled by the Type-C port manager directly. So
there will be a connection from usb-c-connector to the pmic-typec
itself (which looks pretty redundant).

The TCPM then sends these events to the interested parties. SS and SBU
chains really care only about orientation (to be able to remux SS
lanes and SBU polarity). USB data role is only relevant for the USB
controller itself.

So either we should add special role-switching link from the TCPM to
USB-controller, or just reuse the HS link.

>
> CC1/CC2
>
> Then we would not be abusing HS/SS/SBU for the port names - we'd be
> extending the connector definition but also naming the ports/endpoints
> appropriately associated with the data over the hw



-- 
With best wishes
Dmitry

