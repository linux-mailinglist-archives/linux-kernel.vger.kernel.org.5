Return-Path: <linux-kernel+bounces-71116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B985A0DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69131C21441
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4591288D7;
	Mon, 19 Feb 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZ6kbIYt"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9457C25628
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338197; cv=none; b=WKgILl3Ia9eygAeDukdqk8mqe19KGDiG0OBBpGPWoVacaMsT19XUCirrHXUT6h7n03XTU8P52LF2RArsoZRru/8BTY2GBXadGt7C/Eu1+hKCWCThruujQkGSzMeiIpcLcKeCkCtaxkHrIgzjZN9+ICNpbg14P0ptoOeChlgcVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338197; c=relaxed/simple;
	bh=RWXNHUGEvBUqJCoB+kDBknBCopB3TrSyunf4vw0H9b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCGc7ivfP198xsG9eHY9c8A5ti7K5l4C0qd+8U9bJPB179hQg+WQa57DIjSBeqnOC0PmhFCR0K1PS+shCiC94dyKUrYgeNl2Xk0TNIAbKEC2Qvdg0GjoJci55hmYqV1UYNguSRtQY77GtU4GYUarXcqGKBkaBck3WK+fz0EuDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kZ6kbIYt; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607dec82853so35275097b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708338194; x=1708942994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P1ZbvUj4g/1dmV9lTG+hpiBDBBa56SEI8So/qgiUsAU=;
        b=kZ6kbIYttBRbtKi6cPWzdZ7AOKnsKuiU+45xK5OibNJaM8rvdWGITOMrZ5JLM2Cf+E
         79AmBdWjmPNqB1wIYLYRJIuyW0O7mrPHqZXYTq/x/MJ3jzzrCK+drSD4OIAD7HIL/1NL
         nwr4iQwIi8NTHnMb+L065r2LJTqK9zpy0/v35hqV6g1xOVCoM8Emhx7fBL0cRJ/L7xo5
         dzUJCzJ5oT72zQaNm2f7go6xPfXiN7WiUedol08PSU7gGPkaer9dF09/u5Px+OFukkkV
         3XtBf8k+zzfzvV3Xa813+x2AQHqjgMlDRWORJ1NpoEK4RaVVgA8YKwu3w7IgzCRB28uS
         t8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708338194; x=1708942994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1ZbvUj4g/1dmV9lTG+hpiBDBBa56SEI8So/qgiUsAU=;
        b=t6cXkdz/rgVuQ5BZtWDce/t0IBUpci3swLjiiGTse/hHumLfGhaee9hfjljaCiiVAu
         T01k7T+KmQgBaWPiTYaKzwJ+Dpymj+3V5bSF9UR0ET0auYUUS/3lPNXk6v9RYTyhnqHd
         LUzJkcGTWWycvAcdzJDVuvZ6LhYJGq9+RVqYEclsQJzLCL9AxG1AxsZamGo/3QnOCOxi
         kvuf1rr40I+0qc0T7XVZNpLYw4jcLBNNEnF/n34MJ+EY/lL9iS0zPiS7+aq+Jja57iLj
         V2xwFvipuPku02YbdpDd+EakqpNJVkH7YzXmolmd0eH/uOY0uqLEY9cihOax9+Jxtx87
         vrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9AAELV5WL+fxZ6Q9gV9olggIxPZ0zocEWVfmeljXuH/ruQiKeRr/eZ+DkLHm+uHAXXvHq/17pmiTc7PF41O4G3Wi1PRMfU29Ta2FZ
X-Gm-Message-State: AOJu0YwX9aIzQZIWmc+vNCv2yZr45nx/0hS0zpRmCn9r72RM9vfv1G11
	DZifJ3ohTxZgywPklWMQPAivZ+1LsXaGjdqod3aiWmV0w5hJ6lNRUl5iSUM3bwTbF8P6Vl03TNf
	ro5I/wUGL8nqRdkay3h2TBiIGzhacbJY7+Jtlzg==
X-Google-Smtp-Source: AGHT+IH5oIcfK+pzIlzufb2Y2g0Srso+To9j4nOMGd/Wz87mtK+W4F/PAtewgD0Ixr6xM+851B8U0nnEnWifG9DTxEk=
X-Received: by 2002:a25:a348:0:b0:dcd:3663:b5e5 with SMTP id
 d66-20020a25a348000000b00dcd3663b5e5mr9035958ybi.25.1708338194451; Mon, 19
 Feb 2024 02:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com> <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com> <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com> <CAA8EJppe6aNf2WJ5BvaX8SPTbuaEwzRm74F8QKyFtbmnGQt=1w@mail.gmail.com>
 <74f585c2-d220-4324-96eb-1a945fef9608@quicinc.com> <CAA8EJppuNRB9fhjimg4SUR2PydX7-KLWSb9H-nC-oSMYVOME-Q@mail.gmail.com>
 <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com>
In-Reply-To: <d518dbc1-41aa-46f9-b549-c95a33b06ee0@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 12:23:03 +0200
Message-ID: <CAA8EJppP_bAPRH7Upnq8dO7__xQPOJ6F_Lc-fpRAcutKKzk0eA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 06:29, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 2/17/2024 10:15 PM, Dmitry Baryshkov wrote:
> > On Sat, 17 Feb 2024 at 17:45, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >>
> >> <snip>
> >>
> >>>> Reason being, to access the NSSCC clocks, these GCC clocks
> >>>> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
> >>>> should be turned ON. But CCF disables these clocks as well due to the
> >>>> lack of consumer.
> >>>
> >>> This means that NSSCC is also a consumer of those clocks. Please fix
> >>> both DT and nsscc driver to handle NSSNOC clocks.
> >>
> >>
> >> Thanks Dmitry. I shall include these clocks in the NSSCC DT node and
> >> enable the same in the NSSCC driver probe.
> >
> > Or use them through pm_clk. This might be better, as the system
> > doesn't need these clocks if NSSCC is suspended.
>
>
> IPQ53XX SoC doesn't support the PM(suspend / resume) functionality, so
> that, can I enable these clocks in NSSCC driver probe itself?

There is a difference between PM (suspend/resume) and runtime PM.


-- 
With best wishes
Dmitry

