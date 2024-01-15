Return-Path: <linux-kernel+bounces-25823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21FB82D65D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6A281FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4531DE573;
	Mon, 15 Jan 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OHlw7b5l"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C87DF50D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso9495038a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705312331; x=1705917131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZFT1yFxYlVkgqvKMiV1rHlNH9vvM1PcstUoRcD6u4I=;
        b=OHlw7b5lY7AgyX/NVhm0cm6539Bm8DPEV2E6yqOYmUWMOtTgP5WdcY+0WP0+VaIJOq
         PAdXFFOsepa8G6uneknX4woqZm6XKUcLVgRRHAB+1eRvgi3oA+Y+zfHpMu/NXzraxcz3
         m6Ok91hSGKR/zMOsxdmRD2wemAnKqVrqg+M7AgwwFv/XkNsGPelwocW+UfLbUI1BKx9F
         LOg1r5iNJ811vf0H7TQsVGc46eMb4iPSnghnDPbs9N7m3+ZdbwR2dDxnq3NZIQU8gF09
         +Z6Q01Hhz0qEFsvaHCwaNW9HY6gGkP1d1Sk19Z/v+ouWJQrH65aYalv1U4zQy6IAcJJT
         mAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312331; x=1705917131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZFT1yFxYlVkgqvKMiV1rHlNH9vvM1PcstUoRcD6u4I=;
        b=mHSLNsDhu49ar2VMmR/HYRoij8j+9yzkAln45JlyLNfAD7mFCc/66atZYlH+nNfbVn
         GO+y1fVdMmNgKXkQdukosrkyFLMVvGYZnCfJ8vpTYX5cqvTxbfPJ96bNpzqEpNqfY7Ve
         LkwMdPjLXoN+EQPxuWw68vALCNswOwEOxad+lqBM3RIvlQYS6TdbvyV6xYT6ylKXetR4
         CpDJ0NxgUNACfRmLlcYnhiYJGruD9sPDhd/4K447sFhA3n/Ew20MO4/eA8LTsTaTan/Q
         cIirk5ipWJr+0LQlWDqXwXrIj+yiOWyDuTlSpJDXdDZedQlL1fcZNh5IMG72oEFNhggO
         a3Fg==
X-Gm-Message-State: AOJu0YyAiKdHPM2T/zT9W80V2JbKnVYxUTxQC8m71ZXnf3iuxdM3CQ8l
	bWKuVXX8SMO1qnultb8MQzHi7hp0IWoHcg==
X-Google-Smtp-Source: AGHT+IHBVQUjjN8/aG9IdhmJJPXEZfd8a0pPAsVT20N4DzCul13RsnLmi6Q0dZZtNr4378VNTQVVXQ==
X-Received: by 2002:a17:906:3750:b0:a23:71ca:2bb4 with SMTP id e16-20020a170906375000b00a2371ca2bb4mr2367128ejc.144.1705312331209;
        Mon, 15 Jan 2024 01:52:11 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id st7-20020a170907c08700b00a2cfa8edbcesm3342141ejc.199.2024.01.15.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 01:52:10 -0800 (PST)
Date: Mon, 15 Jan 2024 11:52:09 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] phy: qcom: edp: Add support for DT phy mode
 configuration
Message-ID: <ZaUASV+0gc/Bufmw@linaro.org>
References: <20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org>
 <CAA8EJpr8rKMBzcm-=HGu7-C5hPkNMrnG1cA78O00UjgJVT7p6Q@mail.gmail.com>
 <6179e3c7-f399-4b0f-abb0-aaf5e549d8d9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6179e3c7-f399-4b0f-abb0-aaf5e549d8d9@linaro.org>

On 24-01-03 14:42:49, Konrad Dybcio wrote:
> On 21.12.2023 17:27, Dmitry Baryshkov wrote:
> > On Tue, 19 Dec 2023 at 22:55, Abel Vesa <abel.vesa@linaro.org> wrote:
> >>
> >> Until now, all platform that supported both eDP and DP had different
> >> compatibles for each mode. Using different compatibles for basically
> >> the same IP block but for a different configuration is bad way all
> >> around. There is a new compute platform from Qualcomm that supports
> >> both eDP and DP with the same PHY. So instead of following the old
> >> method, we should allow the mode to be configured from devicetree.
> >>
> >> There has been an off-list discussion on what would be the right way
> >> to pass on the PHY mode information to the driver and it has been
> >> concluded that phy-cells is the way to go. This means that basically
> >> the controller will pass another value (that is, the PHY type) to
> >> its 'phys' DT property.
> >>
> >> For this, we need both the bindings value and the PHY mode value to be
> >> added as well.
> >>
> >> The controller part will follow shortly. But for now, lets see where
> >> this is going.
> >>
> >> There has been another attempt at this here:
> >> https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/
> >>
> >> Compared to that version, this one uses the phy-cells method and drops
> >> the X1E80100 support. The X1E80100 support will be a separate patchset.
> > 
> > After several back and forth discussions, I think that this approach
> > is not correct and not that easy to extend. Instead I'd like to
> > suggest adding a property to the DP controller, which enables eDP
> > behaviour (and thus makes DP driver call phy_set_mode()). Something
> > like this:
> > dp: displayport-controller@ae0000 {
> >     compatible = "qcom,sm8000-dp";
> >     /* reg, interrupts, etc */
> >    edp-interface;
> >    /* or simpler */
> >    is-edp;
> > };
> > 
> > What do you think?
> 
> Please excuse my alzheimer, but why did we not go with phy-type after
> the last discussion?

phy-type would be a property of the phy. That way we would need pass
the mode to the controller. So it was concluded that passing that
information from the controller via phy_set_mode is more straightforward.

> 
> Konrad

