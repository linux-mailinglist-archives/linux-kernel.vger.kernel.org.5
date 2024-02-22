Return-Path: <linux-kernel+bounces-76983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975AE85FF73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38221B247C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E6153BEF;
	Thu, 22 Feb 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kL2z3nZO"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C2156976
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708623150; cv=none; b=QhC6oxs4o9oIBahHnMguhEvr7BXGNdQCwnpJPwy5lJQCHJ95JtQnNAan/OPG+6v1nzJjaGX1tTyPl7rve97OzbuSkTOkvJHZAQrkpjiwdXJX4bLgI637WBcbJHPnQ4dTkAgFDNQ1nM44NIPA7h6FJHNX0dtHy8OgQyjo/GlhOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708623150; c=relaxed/simple;
	bh=XoXX/VGE3vTnIw/F8JWFhSua5GxofxdO60mrbzWRe4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szDbIY+uG3HWEu3OpBQYzV4MEhy9P3yzrRfxzdHu1uaCcDUA200dLHAbKYG5eENi2TTL3NWOErE1ZwehAZxYaTm+hqJbLImzPzA/qOHMI7QhZ6E7HkgF1YbLIp7DiCNSSYqeeLv0sv5xNa9W9jyy1nFKUXnr6KXJ/nUaogghcjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kL2z3nZO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-607d9c4fa90so84606857b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708623147; x=1709227947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uHYuztdiqcnoWxT8IYhA0vORd3mYh+h0ETbBCJU2hFs=;
        b=kL2z3nZOztxBINmjthIYNqVOy3nfyv/QdwJy5XKPUavBawjUiJABSK0rke1Q7dk2OC
         5xRwENisjn6J61ztzxE5N37C6bKsqFg6x8aDlDUVPBBKkReDoPj1gGjEtCqp+Pw5b43/
         mTXqPi/lMZ7bZjrLhp0PJzTCjQ9i6809PRR8tRDlnGXPle8q3J2KUetLO69vjGGV60UZ
         7UpZYS7/R3OFBD+x5eS5seyg30f7WQlTiT42qsJBbzIQgwDFe2BK4THRJqZI51PaUm6x
         lA23xd5eLA6c0uVSdHs8ZWLptddS+pSNR9cBmfULeT9IlUdmIa9tXnO3q2vZaomGw3C1
         lE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708623147; x=1709227947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uHYuztdiqcnoWxT8IYhA0vORd3mYh+h0ETbBCJU2hFs=;
        b=Ch8PYp8D7P1KPXBZGsgJIVNu4YRQmslGmk16kHsIHE8Qywj1Nixh4kTTFkQKZTha45
         sHMpiJbbkA3Wt1j08SlmAXi+RM+kzdQUrT0IMMGhpTTPqQq0F7iYDphYYB5191NFGO0F
         IG/0PN8A6kaKltWTW/P/RU4/i/dXtJkpTPbwg5pocrKhUU9f4Tzzc0r3hEDrC+c8ZYu1
         utgCI34NuC5EfePJM7tfYcpmpqB2Kzwyva443+exkYcD/FZwIywr7ZmEvnjO5JuTr3mx
         tg2uWjDLwym1w3ewSGtFEHIo8xGu7v01DpH7qbT3nzrNCj4BrdPBpHXxpGDuMvDCLx+F
         pTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3uuHGNIVWUlTuj3n9FfAVDjNnmC60bDjNU+1g2O1vFcjSxUTM9J7tkI7SUuipxouzJu/VEmvDfqHw/MnQmXL0wb8CKkkEkvfz4oY+
X-Gm-Message-State: AOJu0YyNBtIrtPiMd9dVHSzT5yUU1BZCDKZa2LqhaQgOMyRfIoeokXcB
	pev6PhbC2h9ZR4MooIW0MEy8NfCJcE+ffbZ3Dt/57WjtQOt9cCcU8wWh7PGiE3WAAAmTDBXE3Kr
	HZkjxWqiNMtr4nXZacz2bBsEj561E3H7iUYOX2A==
X-Google-Smtp-Source: AGHT+IEChpsE7RSvYtvlDilze7tlEfcebE5fWeV9v6TUsqyy6KJBLB0hOKOdzrs9KYPLmaKn2wbmU4LNaaPxNFAv0eU=
X-Received: by 2002:a81:6c0f:0:b0:608:7488:8691 with SMTP id
 h15-20020a816c0f000000b0060874888691mr6826857ywc.38.1708623147287; Thu, 22
 Feb 2024 09:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org> <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org> <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
 <20240222150423.GI2936378@hu-bjorande-lv.qualcomm.com>
In-Reply-To: <20240222150423.GI2936378@hu-bjorande-lv.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 19:32:15 +0200
Message-ID: <CAA8EJpqd=1KV_dN8AURQDcFDDyO+YtbC59gM7ftt+HohGM93hg@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 17:04, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> On Thu, Feb 22, 2024 at 11:46:26AM +0200, Dmitry Baryshkov wrote:
> > On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > >
> > >
> > >
> > > On 2/22/24 10:04, Dmitry Baryshkov wrote:
> > > > On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 2/22/24 00:41, Dmitry Baryshkov wrote:
> > > >>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> > > >>>>
> > > >>>> The max frequency listed in the DPU opp-table is 506MHz, this is not
> > > >>>> sufficient to drive a 4k@60 display, resulting in constant underrun.
> > > >>>>
> > > >>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
> > > >>>> fix this.
> > > >>>
> > > >>> I think we might want to keep this disabled for ChromeOS devices. Doug?
> > > >>
> > > >> ChromeOS devices don't get a special SoC
> > > >
> > > > But they have the sc7280-chrome-common.dtsi, which might contain a
> > > > corresponding /delete-node/ .
> > >
> > > What does that change? The clock rates are bound to the
> > > SoC and the effective values are limited by link-frequencies
> > > or the panel driver.
> >
> > Preventing the DPU from overheating? Or spending too much power?
> >
>
> Perhaps I'm misunderstanding the implementation then, are we always
> running at the max opp? I thought the opp was selected based on the
> current need for performance?

Yes. My concern was whether the Chrome people purposely skipped this
top/turbo freq for any reason. In such a case, surprising them by
adding it to all platforms might be not the best idea. I hope Doug can
comment here.


-- 
With best wishes
Dmitry

