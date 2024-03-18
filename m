Return-Path: <linux-kernel+bounces-106018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C287E7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED85B2829A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECB2E821;
	Mon, 18 Mar 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gFShZaJm"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C192E644
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758763; cv=none; b=BaxuJHKdrqn203Go2GlxJMrdRS8mF0mYvrV6UHsSoL46vjtOO/heA7DEeRv/M5puWEno79Sg8lybStOpY1aUI09aLdj7t8ksirfTlhp9zP1+oEsSWuDNqbqWiPJR1+sAG+c/jvQHs8RhtCnEtqsCE3sDd755o/pSOgWJpFlNTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758763; c=relaxed/simple;
	bh=AnN09J7l+NzyG+L7VRxA++nqcTL77gssPZ6K+HlliN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SLsAM23w4nsWKTnnKxSN+Z5g77ig22LQ7h6BcCHK4XyRKrEbHiH+2kcoB1E9/SlavllbStXFJaOIwkQVJMyGu6PEsVhUISAymi0LHu8yYRCJ+iRIQokQVbBAjengU0Y6n7qhja2OdS92Bck6ok7QgQI9HkCA6Ksr/fVjGIn+iC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gFShZaJm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46c35dfb5aso74219466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1710758759; x=1711363559; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT8ZXpFVpdTpbU/Iue/RRtJuRFnBjnoJvr+qPsVlQ40=;
        b=gFShZaJm0J/4fRAbBSE/Url3e3UYnEDBjMm6YvFOstIIFcZ3JhM8nkwmm1YHtfhdBo
         UM07BNaqk9p7ncnNkJOMX2VfzlA4nChzpk4PGMDW5UIfV5MP2Xrcxx+sa93E2eiA1AGA
         P3PnAc5NDhPtoQAPmq+xsHgs2PB4gzNW/s2cryCSxgpdQcYWZ4V7ntR5Phmri+DRu/Oo
         GLyVTOn2ZUICM1g+vIhTFkaPUkss/VMGodQyNn2K5d0K7D46D/lmJVz7WgmAjhx50SPG
         eusJcLM3ESl5s9WRt9EF0DTSAb1wswHyUcRfhvHobGDLQmrKBiZ8pgACW5X8hybcF0jw
         fRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758759; x=1711363559;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QT8ZXpFVpdTpbU/Iue/RRtJuRFnBjnoJvr+qPsVlQ40=;
        b=MVCUGIhdmiRHvC7ERLRHoPAb29fUmm4KO5GoMDw8XbHynqh7/sWonhA9ESuDLHUWGD
         KKmNPeREToe/lJOTzlWlUlDi4/StvromIj8WZaUWrokVsZobhsh+5k95b0466CqiXPsk
         pSgQaZTG4SeUJOhHIsFQ9j9ln47H0vhrF6UYrestFfvj8NFL4vhp7Ysa0JV83icG+j00
         iaWeWSoZGW/bj25AmaIrMjehzF6YQyeLlBrONeyY79pPpDpKaHa8qJ312ugzrHCLguo4
         2gVs4KZBGudPUsRm5XWprA6ICkCAMh1WpFQ39SE2vKSSk2enQSba8Xax7szexYBmSjcC
         5KUA==
X-Forwarded-Encrypted: i=1; AJvYcCWznYfRZe42rTo9RmWaTLV8E2WjB1TLEablhc6QogxjQMUUMOHUi1p4DGfl1wUwt7DS2j0afwes59vR+sX2jhSZEJyC+PmoOqrFnCT1
X-Gm-Message-State: AOJu0YxVKhObomaa0fApJpDNHLnGy5zs6fBZgOiLFmdwSz2V91HldneN
	0dz1qUi8kRvXjX5VvlP+A5LKtU0nSoppoz2KpUWo0EI13ppArlCMWISJVixb0Dt2cy/9Ogy0pqs
	I
X-Google-Smtp-Source: AGHT+IFPJHgyGW8eWsjDqZVT5V0Yr6Jl+8ZG3GAIH6rvmehrSUpZJRzmZ6+jGP8apXMV0anVvWUU5w==
X-Received: by 2002:a17:907:961a:b0:a46:3785:4adc with SMTP id gb26-20020a170907961a00b00a4637854adcmr9600678ejc.57.1710758759368;
        Mon, 18 Mar 2024 03:45:59 -0700 (PDT)
Received: from localhost (046125249120.public.t-mobile.at. [46.125.249.120])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906198e00b00a46d049ff63sm114217ejd.21.2024.03.18.03.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 03:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 11:45:57 +0100
Message-Id: <CZWTD7P4CE12.1ZUNPF2WFTBHR@fairphone.com>
Cc: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Bjorn Andersson" <andersson@kernel.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>
X-Mailer: aerc 0.15.2
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org> <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com> <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org> <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
In-Reply-To: <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>

On Sat Mar 16, 2024 at 5:01 PM CET, Bjorn Andersson wrote:
> On Fri, Mar 15, 2024 at 06:35:15PM +0100, Neil Armstrong wrote:
> > On 15/03/2024 18:19, Luca Weiss wrote:
> > > On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
> > > > Register a typec mux in order to change the PHY mode on the Type-C
> > > > mux events depending on the mode and the svid when in Altmode setup=
.
> > > >=20
> > > > The DisplayPort phy should be left enabled if is still powered on
> > > > by the DRM DisplayPort controller, so bail out until the DisplayPor=
t
> > > > PHY is not powered off.
> > > >=20
> > > > The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE stat=
es
> > > > will be set in between of USB-Only, Combo and DisplayPort Only so
> > > > this will leave enough time to the DRM DisplayPort controller to
> > > > turn of the DisplayPort PHY.
> > > >=20
> > > > The patchset also includes bindings changes and DT changes.
> > > >=20
> > > > This has been successfully tested on an SM8550 board, but the
> > > > Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPo=
rt,
> > > > PD USB Hubs and PD Altmode Dongles to make sure the switch works
> > > > as expected.
> > > >=20
> > > > The DisplayPort 4 lanes setup can be check with:
> > > > $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debu=
g
> > > > 	name =3D msm_dp
> > > > 	drm_dp_link
> > > > 		rate =3D 540000
> > > > 		num_lanes =3D 4
> > >=20
> > > Hi Neil,
> > >=20
> > > I tried this on QCM6490/SC7280 which should also support 4-lane DP bu=
t I
> > > haven't had any success so far.
> > >=20
> [..]
> > > [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> > > [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 fail=
ed. ret=3D-11
> >=20
> > Interesting #1 means the 4 lanes are not physically connected to the ot=
her side,
> > perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes in=
 the PHY,
> > or some fixups in the init tables.
> >=20
>
> I tested the same on rb3gen2 (qcs6490) a couple of weeks ago, with the
> same outcome. Looking at the AUX reads, after switching to 4-lane the
> link training is failing on all 4 lanes, in contrast to succeeding only
> on the first 2 if you e.g. forget to mux the other two.

Good to know it's not just my device then ;)

>
> As such, my expectation is that there's something wrong in the QMP PHY
> (or possibly redriver) for this platform.

Since I imagine rb3gen2 uses a different redriver setup compared to FP5,
I wouldn't say that's at fault for now? And at least my ptn36502 driver
only has very little difference between 2-lane and 4-lane setup, only
setting the mode to DP-only and 4-lane (vs USB+DP and 2-lane), nothing
else.

Regards
Luca

>
> Regards,
> Bjorn


