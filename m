Return-Path: <linux-kernel+bounces-136325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7589D2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52013B21CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A218762F8;
	Tue,  9 Apr 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aojo4/BD"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC679CC;
	Tue,  9 Apr 2024 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712645553; cv=none; b=GK3rosStEUp9BXUF74vLtfzBBlMwFQSnMrKvv9ALJ5QNgDQjbI9H253SBJQ1H4HwalLmAt/5siZKAl5LdFQdwUwglPzFFaB3OCNYknC16j8OFOVhX5stWYXSW532Q16eMhfLCwoSeXuuNtal5dqTsnmx0V2AvR4NDQsybcd0JVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712645553; c=relaxed/simple;
	bh=xoULbzlytF5RGrLomSCcvTJXxEPOJ61JtuUKMiYDaX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vls1WuvJ6kpTx3+bm4gPRFwbY2PZCzNEKzPgaZkBhiY6YUGExqxeLm/Mx67eJdtuVXT8ruShTKlIfLO8xm+MvMM5y1sLc6wLjYlQi8C1Kw9ui0+TCoEh1KNHtyAw1sIOoju3Uq4gCAu5lGHGDVJIFH/dnr1Om+LO7thJAvpkG5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aojo4/BD; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a2fcb4075so2209655ab.2;
        Mon, 08 Apr 2024 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712645551; x=1713250351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b352HOzGF/NbEGXGXSDOWNzIVRBqY7hL8lL0mia73U8=;
        b=aojo4/BDZvxmy9ZRpJ2jFkxMnncBYVcIO7EeaASKa35NqhK7o9HGxyXMUeM9eXeUCu
         YNIH0gCcuaAOWa40Ar7NkJzXnTtR7dIOyLp4zAP4goptQ0I+wJ/JXJZkvqzezCYwwOL1
         ZkOAh12YgTLrGeWoo6sh6uvcb16bY7pD22Jew7a3+39ZytK/ssuy3Nw80VuKtFyKNNLH
         LVdFlZDV9EiOtUStmBJScZGimhf368S/WcQbmOqKEBImjuRD1X96hZpHlUVytdZcEZfF
         zC9T9NK6H3MBHCbDKDQGAfwYYeUBwrgheMB+nv7LEQX3vFb34b6a2yjA/O8Q4qRaXQH6
         n5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712645551; x=1713250351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b352HOzGF/NbEGXGXSDOWNzIVRBqY7hL8lL0mia73U8=;
        b=KA9bxIpjZ8M+Ajcig/bLouN40nyms1YL0yYpN2yIDkb3BWiVG6psuzrfMEyCwI5Loc
         s+FxIDAbQQHNKOBaC7ijiKtS6T50PlOFC7sY3o3L/7Q+ISP2NZlAsutG/DmG0hxZ4ZIP
         DvP8KEyfOUVwhTnjazdvil116ApVEqZkDl9y3EUM2LjBi5AiGZm2igd4njot6W6qVL7d
         3tHXssMMn4FCizNMvq9QHp/Bupjofzzu0x6lGdpgi9ZHFrm5qxz9XwB8VdjtKLQwGufS
         60yYw7nxb+xSAAhxZ5CZI1J93FTfo5MyzTihJl2VMTKHvwjY+BeDarmyglcYaxMhq6WA
         x8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7APQwVpFyptlfoV2l1Vk0kPac8VqrPRartncrn/GafZyW2WAuSA+4r23wNXYOpOnCBvUrinXTQUnxi+7bjXxfcXYh4aLgE3TInGNPqWhRMWkGwTxlqTYwTIQv3Jet7WRZDq5XGzD7RClBP9sMPmGnpwAdHXagmoOpzOqeGzPYaVWXuGai
X-Gm-Message-State: AOJu0YwnhIn0T4HSKBnDyZfINBxEjkCg2nGeSfLTZVrmbcLkVSzAwT8c
	mT8c+f7pAlAp2XMmuqB6oqA7vxfsuSrxDVMk/aZt8EGqcbhhloF+6vrSRk0A3cvJbimp3Rhxz56
	rJJgr+anmWQwl5ao7+SxMQuEMtpE=
X-Google-Smtp-Source: AGHT+IHMPxlU5dxKgUHu5K8XuZe+qftwM2k80rxd63c4T1s7URnjvCONzf8sqUJd4pD7fgxGFHmmOvmrnrNpio20lb8=
X-Received: by 2002:a05:6e02:13a8:b0:36a:2351:60a with SMTP id
 h8-20020a056e0213a800b0036a2351060amr6153201ilo.25.1712645550968; Mon, 08 Apr
 2024 23:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1712561233-27250-1-git-send-email-shengjiu.wang@nxp.com>
 <01734d96-bed2-4f7e-bbba-7068f14c822b@linaro.org> <CAA+D8ANiKH7Oc+KAjD_BMp9P2EVeM8Q6dLGFCC8a83bJXUpPEA@mail.gmail.com>
 <69ab2bd9-401a-42ff-90fa-6600dd071722@linaro.org> <CAA+D8AOP6D+xUNF_XJXt-8dMi2qFyVh-Sbe8k67CzvUbnzrwoQ@mail.gmail.com>
 <51e482b3-ffbf-46f9-972d-875d106c2474@linaro.org>
In-Reply-To: <51e482b3-ffbf-46f9-972d-875d106c2474@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 9 Apr 2024 14:52:19 +0800
Message-ID: <CAA+D8AOTtCvsaU4efkEq-7LwSACzuP9qf+e5KeV4OGFgU7OdBQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: imx-audio-spdif: convert to YAML
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com, broonie@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:30=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/04/2024 03:37, Shengjiu Wang wrote:
> > On Mon, Apr 8, 2024 at 11:06=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/04/2024 10:01, Shengjiu Wang wrote:
> >>>>> +
> >>>>> +anyOf:
> >>>>> +  - required:
> >>>>> +      - spdif-in
> >>>>> +  - required:
> >>>>> +      - spdif-out
> >>>>> +  - required:
> >>>>> +      - spdif-out
> >>>>> +      - spdif-in
> >>>>
> >>>> Do you need the last required block?
> >>>
> >>> Yes,  one of them or both are required.
> >>
> >> And? It's already there: that's the meaning of any. It is not oneOf...
> >> Before answering please test your changes and ideas. I pointed issue
> >> here and you responded just to close my comment. That does not make me
> >> happy, just wastes my time.
> >
> > Maybe I didn't express clearly.
> >
> > we need at least one of them (spdif-in, spdif-out) in the node.  which =
means
> > that we need to select  "spdif-in",  or "spdif-out",  or "spdif-in and
> > spdif-out".
> >
> > So my understanding is that need to use "anyOf", if it is wrong, please=
 let
> > me know.
>
> Third time: it is wrong.
>
> Can you test the code instead continuing this discussion

Every time I change I definitely do dtbs_check test.
But There is no error reported by dtbs_check.

But finally I understand that
anyOf:
  - required:
      - spdif-in
  - required:
      - spdif-out
  - required:
      - spdif-out
      - spdif-in

is equal to:
anyOf:
  - required:
      - spdif-in
  - required:
      - spdif-out

best regards
Shengjiu Wang

