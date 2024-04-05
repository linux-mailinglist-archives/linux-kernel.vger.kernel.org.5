Return-Path: <linux-kernel+bounces-132812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E59899A95
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC98282D8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FA161B53;
	Fri,  5 Apr 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="kMZ3ZPK+"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0815516193A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312390; cv=none; b=FeKzSUlyVhVPUmIfSp40lG1iNcNYRq+CGXKi0PgvjhF1cBZ9LD/dhdeeMC9HbHem2z7O0FO1ODAdT/8idhcxPIkiQ/pHSOvviD2N8ZG8hvAjQLTo5czF8z4kdYHXxKFhHU+897j4loG3oaFZ+EspiHsiLCdakyz4saLPw4lYQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312390; c=relaxed/simple;
	bh=0OI2ryIMCXvO8K9vutx7EIqbESyjJfJ3MkE47w6lRgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=aJ1eG8tnQ/7MyRIrmkqVev/0vdurANJTQW3MUCGJbvDogOfOpzGauUv7sze5ZXGzgbqYyD/fQV1fhyObtiW89uzWKSAvEgIq51tBb2Wh99NzEQK7uj5lJPNCZiH8ewgROnz7LHCUptx2Zo+Z+f591krVCelQ6U2BUzynnnVnicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=kMZ3ZPK+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a519eae91d1so98405066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712312387; x=1712917187; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7wBknhXnwsdUBBqfoshvbTdHyCPt+Ehzl1Q7shB3pk=;
        b=kMZ3ZPK+sPR9UEoin6D/sgvVaZO85XByUatjMvsQDWCSkUAWA4cpOFHMkefjnj/nq3
         NvMWxhLYvfcrBia5ixw8ndE4s/KMhJ3jjSFDtkRwSYg0P1bsmv5Y/4P46pXoFUY0PUxe
         ginzIYX1dXxUYAE/kXXNGH8lTOlJXK1XMwNnadzKxOGfopIVDpgybs/+i+ufD5hb7jol
         AYVl3dk+Wqk6BO505JF6+8maVQwHpe+PyMhEcbHIcXVAl+HquiAaIh8QlNzSPiKDk1Fi
         X3TuijLwCmbkdXmwETzNt8RCIaFWTtfUdTG1aqbMVLj0EtD/fn+i8H9xH1lz2twZB7tA
         MbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312387; x=1712917187;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/7wBknhXnwsdUBBqfoshvbTdHyCPt+Ehzl1Q7shB3pk=;
        b=D+FTyH4Du4T4nNM3KvhgXS77LgMUaaHi7ez29qJKRIvL/caihQg1r/wcKfRzbh9xRn
         8OnLvC9ZGGK9vW9JeFHzRw0HS+y9KbBex9f8DPzmT99I6mmPmx3tFtkXTL2Oh7G/CmTn
         p5c+ixuDUjy0O2NwiwDiIoA4lsrctW7ieEEESlk9F1v4wg714DwqMJkHWMc5+WMbMwGK
         6GHMtYyeVNBQQiWUX1oIFCnGSpmJfMvt6/9RB43zF5cGa6liz46FP2W5cKHfJzrCWNCu
         vyMZpHre9XG/FlDFSLOEBsf907ajPZkW5WaFr6WYnNtjCCcYdlBPU47V25eTq/TzVKBR
         wMcg==
X-Forwarded-Encrypted: i=1; AJvYcCWdf1qy2VF/lZwmdHEkfhkHQY1UoqB7Lu/V6ysPxqP2D7opICgUPwpODIpptIg+bZ113b4s2FKE1wEYEvNIkLoOkNKAZAjTtmv+hcBN
X-Gm-Message-State: AOJu0YyYN8PZa2i4qOHHwoMN//r94cGFqIMfYOIiebIWKdCTSoJWqMub
	XhnGg83Qb+7zZXYYkGaxH/qAb5S9in31zJJb+AEiNLXQrX+l2HyM4Gtk+K8I8Ac=
X-Google-Smtp-Source: AGHT+IEb6UquOirryxNCdTbMBwQSxXMSkSkdEgWggO43HlcRkq+10Oy8opxJEoC4UC+X+wGb7hJvGQ==
X-Received: by 2002:a17:906:38f:b0:a47:2036:dbc4 with SMTP id b15-20020a170906038f00b00a472036dbc4mr541798eja.25.1712312387218;
        Fri, 05 Apr 2024 03:19:47 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm670330ejc.131.2024.04.05.03.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 03:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Apr 2024 12:19:46 +0200
Message-Id: <D0C42YR1270X.23P9WCWWNB8XF@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: <neil.armstrong@linaro.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Bjorn Andersson" <andersson@kernel.org>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kishon Vijay Abraham I"
 <kishon@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
X-Mailer: aerc 0.15.2
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org> <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com> <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org> <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt> <236a104c-fc16-4b3d-9a00-e16517c00e3a@linaro.org> <D064242SMIVM.1GUC1I9GE9IGC@fairphone.com> <963b60e5-6ab7-4d9f-885a-ba744c2b7991@linaro.org>
In-Reply-To: <963b60e5-6ab7-4d9f-885a-ba744c2b7991@linaro.org>

On Fri Apr 5, 2024 at 10:08 AM CEST, Neil Armstrong wrote:
> Hi Luca,
>
> On 29/03/2024 10:02, Luca Weiss wrote:
> > On Tue Mar 26, 2024 at 10:02 PM CET, Konrad Dybcio wrote:
> >> On 16.03.2024 5:01 PM, Bjorn Andersson wrote:
> >>> On Fri, Mar 15, 2024 at 06:35:15PM +0100, Neil Armstrong wrote:
> >>>> On 15/03/2024 18:19, Luca Weiss wrote:
> >>>>> On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
> >>>>>> Register a typec mux in order to change the PHY mode on the Type-C
> >>>>>> mux events depending on the mode and the svid when in Altmode setu=
p.
> >>>>>>
> >>>>>> The DisplayPort phy should be left enabled if is still powered on
> >>>>>> by the DRM DisplayPort controller, so bail out until the DisplayPo=
rt
> >>>>>> PHY is not powered off.
> >>>>>>
> >>>>>> The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE sta=
tes
> >>>>>> will be set in between of USB-Only, Combo and DisplayPort Only so
> >>>>>> this will leave enough time to the DRM DisplayPort controller to
> >>>>>> turn of the DisplayPort PHY.
> >>>>>>
> >>>>>> The patchset also includes bindings changes and DT changes.
> >>>>>>
> >>>>>> This has been successfully tested on an SM8550 board, but the
> >>>>>> Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayP=
ort,
> >>>>>> PD USB Hubs and PD Altmode Dongles to make sure the switch works
> >>>>>> as expected.
> >>>>>>
> >>>>>> The DisplayPort 4 lanes setup can be check with:
> >>>>>> $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_deb=
ug
> >>>>>> 	name =3D msm_dp
> >>>>>> 	drm_dp_link
> >>>>>> 		rate =3D 540000
> >>>>>> 		num_lanes =3D 4
> >>>>>
> >>>>> Hi Neil,
> >>>>>
> >>>>> I tried this on QCM6490/SC7280 which should also support 4-lane DP =
but I
> >>>>> haven't had any success so far.
> >>>>>
> >>> [..]
> >>>>> [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> >>>>> [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 fa=
iled. ret=3D-11
> >>>>
> >>>> Interesting #1 means the 4 lanes are not physically connected to the=
 other side,
> >>>> perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes=
 in the PHY,
> >>>> or some fixups in the init tables.
> >>>>
> >>>
> >>> I tested the same on rb3gen2 (qcs6490) a couple of weeks ago, with th=
e
> >>> same outcome. Looking at the AUX reads, after switching to 4-lane the
> >>> link training is failing on all 4 lanes, in contrast to succeeding on=
ly
> >>> on the first 2 if you e.g. forget to mux the other two.
> >>>
> >>> As such, my expectation is that there's something wrong in the QMP PH=
Y
> >>> (or possibly redriver) for this platform.
> >>
> >> Do we have any downstream tag where 4lane dp works? I'm willing to bel=
ieve
> >> the PHY story..
> >=20
> > Just tested on Fairphone 5 downstream and 4 lane appears to work there.
> > This is with an USB-C to HDMI adapter that only does HDMI.
> >=20
> > FP5:/ # cat /sys/kernel/debug/drm_dp/dp_debug
> >          state=3D0x20a5
> >          link_rate=3D270000
> >          num_lanes=3D4
> >          resolution=3D2560x1440@60Hz
> >          pclock=3D241500KHz
> >          bpp=3D24
> >          test_req=3DDP_LINK_STATUS_UPDATED
> >          lane_count=3D4
> >          bw_code=3D10
> >          v_level=3D0
> >          p_level=3D0
> >=20
> > Sources are here:
> > https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-5.4=
/+/refs/heads/odm/rc/target/13/fp5
> > And probably more importantly techpack/display:
> > https://gerrit-public.fairphone.software/plugins/gitiles/platform/vendo=
r/opensource/display-drivers/+/refs/heads/odm/rc/target/13/fp5
> > Dts if useful:
> > https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-ext=
ra/devicetree/+/refs/heads/kernel/13/fp5
>
> Could you retry with this applied ?
>
> https://lore.kernel.org/all/20240405000111.1450598-1-swboyd@chromium.org/

Unfortunately I do not see any change with this on QCM6490 Fairphone 5
and 4-lane DP.

Regards
Luca

>
> Thanks,
> Neil
>
> >=20
> > Regards
> > Luca
> >=20
> >>
> >> Konrad
> >=20


