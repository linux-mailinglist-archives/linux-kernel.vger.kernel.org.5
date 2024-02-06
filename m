Return-Path: <linux-kernel+bounces-55321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948E884BB14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4996628975E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EBD4A3C;
	Tue,  6 Feb 2024 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0YTxoJQ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC015D1;
	Tue,  6 Feb 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237304; cv=none; b=tiWWRO4DZvBQRlZGZmEndOKlyRt/LJpoOa+KvncCt0moPyUNYNSjpojfgz4noIFcHxK9ad7bZK3BDKX7n5kzt6xYeMTCnXUL+RQkw3O509defBnRSy440z0CErzonjBMKaP6AUogRTd9UwVebgKr9PVZoyPn2Czjuot7PK3FgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237304; c=relaxed/simple;
	bh=xeB57moN2ck9rUx+Ka2oPpkM6UMOj51QtdPLL4OQPnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GUVd9GFwDKvxCSkSlYNUrSIz+0wuX/4OV91sFBjfY4FcbsdUEdgBnQ9LwLcepRMS4KEWLjp7EebCConocxqqPYfAKObc8qIYV3IqLLvOYlZQBKoFc3Z1OBdBdn2r8odJdn6IHdVnQYvHfxTu+1JDv1oNosLHbDPTGrvfg+f+MY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0YTxoJQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so4792211a12.1;
        Tue, 06 Feb 2024 08:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707237302; x=1707842102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrnMHxcXOIjSaTL3B2HtdyCEmoJwBUba5veBY3jO5xo=;
        b=U0YTxoJQz3blKuGJK3i4pJlZNch+CaND35cld73GzbpYUpKHLvweBBN/KsgfsY1hNt
         75CAwyz9wM7eNIgAYzguJVJFW9oBNANyCmg3Y1TnUgZx/8u/ZHsiKeoCalt+j1eop6WU
         WRI1bKU2QO/NJ5ZU0DNb1dmfgIb9LBO7gT+QMcCJw8e1Sqe3biK9O+r/o+xwg8OhbMET
         cB5cNvi85JsYb07yJBLvbipJ8mxYL1PsAAMTn35fvnFb6IluublML1DX7Yroaa8biQWT
         UOzJFU+PMlZqJV4JuUjW6mQKjkenxGkkQDVtrL9UeZfMzVP/b/+qyn0CD+XxJIs+t7y7
         CvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237302; x=1707842102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrnMHxcXOIjSaTL3B2HtdyCEmoJwBUba5veBY3jO5xo=;
        b=ic3wVspvjU4PfPz3sHiUHMnKwKWnpwrQFit1sFOg1gytseOLzKjPbSorecdkSIg2Uh
         l22XaGUmow+yd5wJDE3gV0M5BegNWBOWA5dtGsSA7JrMLs9kGwWeoU2Wy6nZLMS4J3qm
         pUhwIwZgoZLFImVFXPTiBUewZc7iqc46ivq9d6IYh3sJUmms7bydn98yxJqah1try4Ma
         3HEDJZO8KU7jbOU3J9X5yZ8gwJ1/r5aVTCaysKV3Cdlp4hh1h0z602GXAPwV/lh/e6vP
         KGTjRFovm45n6suhJAaNDOhDOxLoKEpESC/T12TX+ndgmhlYU/UMKtBaiPdcUam6Jrul
         Q3Nw==
X-Gm-Message-State: AOJu0Yy7VnI84Ioy5yhS0LeFlf8HRMzMWwWvLmIYJSv30LkcWjG06f0q
	KPIfa1qmm2XjxUyXOizSarwN0IYFGdzSo+euEYorwIGUeBlE0i4URyXaCHAe066bbuK/F/bjeSz
	Le0fKEl7GG7Lspg83CdCpTZlocg==
X-Google-Smtp-Source: AGHT+IEMKxaH+2qvq1R/fkW7tWR6Mi2syjsk1OUdXAsGlQ2WzoPOQN7loOSd+vQshjuyL9NJvS0jXTkk3roThkNqvNs=
X-Received: by 2002:a05:6a20:93a5:b0:19e:9a58:fb2a with SMTP id
 x37-20020a056a2093a500b0019e9a58fb2amr2459034pzh.15.1707237301975; Tue, 06
 Feb 2024 08:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191828.998783-1-frut3k7@gmail.com> <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
 <CAKEyCaAXqhzMbTQL8WhLze39cey_DuE-LYOrK+oitD=NiZMuTQ@mail.gmail.com> <7e2d927b-ce84-4939-8d0f-adfad2a3ef70@linaro.org>
In-Reply-To: <7e2d927b-ce84-4939-8d0f-adfad2a3ef70@linaro.org>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 17:34:50 +0100
Message-ID: <CAKEyCaBADYxbU3XkJYv3WkZpJZ93nvfg+Zg2bvaViHCg47=9zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Naresh Solanki <Naresh.Solanki@9elements.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Peter Yin <peteryin.openbmc@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@denx.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 5:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/02/2024 17:11, frut3k7 wrote:
> > On Tue, Feb 6, 2024 at 8:44=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/02/2024 20:18, Pawe=C5=82 Owoc wrote:
> >>> Add Qualcomm QCA4024 to trivial devices.
> >>>
> >>> Signed-off-by: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b=
/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> index 79dcd92c4a43..50efbdf2a735 100644
> >>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>> @@ -309,6 +309,8 @@ properties:
> >>>            - plx,pex8648
> >>>              # Pulsedlight LIDAR range-finding sensor
> >>>            - pulsedlight,lidar-lite-v2
> >>> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> >>> +          - qca,spidev
> >>
> >> There is no such hardware as spidev and you even mentioned it is calle=
d
> >> QCA4024, not spidev. Please don't use that name but a real name.
> >>
> > The compatibility will be changed to "qca4024" and a new patch version
> > will be prepared.
>
> That would be ok except:
>
> >
> >> Also, I have doubts that Bluetooth is a trivial device. Such devices
> >> need supplies, have reset/powerdown GPIOs.
>
> this is not resolved. Bluetooth chips are not trivial devices. This one
> particular exposes several interfaces to the host, needs a clock and
> power supply.
>
Device is used over QUP4 SPI controller inside of IPQ8074:
https://lore.kernel.org/all/20231123121324.1046164-1-robimarko@gmail.com/
I'm not sure if these pin settings should be upstreamed as they are
specific to this platform:
https://github.com/openwrt/openwrt/pull/14051/files#diff-ed3fbf0226fbdc76c9=
c160f2f2b9e988120df472480b9861abe7a46796558115R81-R111

> Best regards,
> Krzysztof
>

