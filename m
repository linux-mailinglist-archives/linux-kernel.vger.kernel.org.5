Return-Path: <linux-kernel+bounces-1224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C68814BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090FA1F225F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E944381B9;
	Fri, 15 Dec 2023 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWAeZwBw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7B37169;
	Fri, 15 Dec 2023 15:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB16C433C8;
	Fri, 15 Dec 2023 15:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702654890;
	bh=9eb/YXAxsUcPYKS4pAEAtfBhfAIyQkqe9AYM+SecHT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XWAeZwBw01RQ5p8XwwCktMHqn1dhx41Rd+aTliosRr6XB6IzVjzhEl//DzG7rggci
	 Xc6elGVBXYp6B0eJjqzM7hYwKyyVDxCs6YR6+0Tu8S7HXqbdwkEl1AncckNACpnZhV
	 vF3oNXUwXww5/E1874zeWbU6XF20SoqqHyk+fGyQ84ibYQUlIn8zcJx9KUPSi//uEO
	 0omLe0NazHtTyf8tqcCtqVhu0rBtLmo979JfU55vJIklehbJHA8Kev87w1BBkJ+8ot
	 3ST7Anyrn+i/bU/lqXD/OuiDaYDc3xDO+YXouJ4j4ky0l2EzSpW7EUkQ0co46J8LuU
	 1+8LcChbddzOA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50be9e6427dso822168e87.1;
        Fri, 15 Dec 2023 07:41:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yy2skKqnvIqCC2XKsVbknYgYlzIFgJlRO7Io+dLKA0BdOpeCW0H
	ZJ0Eq6BLDeSGxCv+b1htmp/qjUU8UMx3vw5Xew==
X-Google-Smtp-Source: AGHT+IGnAJfnE/sQ4Y8/oGYmAjDUUeKmL8J99ab6q70z2JbHalypEIVNYp+q9/np/aq6YGsP/Vl1mwpFXcp2/gLTWg4=
X-Received: by 2002:ac2:5b50:0:b0:50b:eca9:fa18 with SMTP id
 i16-20020ac25b50000000b0050beca9fa18mr5216683lfp.118.1702654888249; Fri, 15
 Dec 2023 07:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213232455.2248056-1-robh@kernel.org> <20231214-buzz-playlist-2f75095ef2b0@spud>
 <CAL_JsqKaGFfQNwR3HqRnVs3K7SUtevpoG6tEDntM0SNfyyp6AQ@mail.gmail.com> <e59ff8c2-caa1-4072-b86f-0446120ac49b@lunn.ch>
In-Reply-To: <e59ff8c2-caa1-4072-b86f-0446120ac49b@lunn.ch>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Dec 2023 09:41:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJwqQTCJmAfNpM7z+0BjusB33OwUgr7_7AxOpnQ-GwaLQ@mail.gmail.com>
Message-ID: <CAL_JsqJwqQTCJmAfNpM7z+0BjusB33OwUgr7_7AxOpnQ-GwaLQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg"
 sizes schema
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 4:18=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Dec 14, 2023 at 12:12:42PM -0600, Rob Herring wrote:
> > On Thu, Dec 14, 2023 at 10:23=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> > > > Defining the size of register regions is not really in scope of wha=
t
> > > > bindings need to cover. The schema for this is also not completely =
correct
> > > > as a reg entry can be variable number of cells for the address and =
size,
> > > > but the schema assumes 1 cell.
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > >
> > > Does this not also remove restrictions on what the number in the reg
> > > entry is actually allowed to be?
> >
> > Yes, that's what I mean with the first sentence. We don't do this
> > anywhere else with the exception of some I2C devices with fixed
> > addresses. Keying off of the interrupt property also seems
> > questionable. If the register size is different, that should be a
> > different compatible.
>
> Reading the code, it appears the hardware always supported interrupts,
> however the first version of the driver never used them. It seems like
> some DT blobs had the register space cover just the needed registers
> for polling, and excluded the interrupt control register. When
> interrupt support was added, all in-tree DT files were updated with
> the extended register space, but to allow backwards compatibility, the
> driver checks the length of the register space and will not enable
> interrupts if its too small.
>
> I'm guessing that since the hardware did not change, a new compatible
> was not used when adding interrupt support. And the yaml is there to
> help when old out of tree .dts files are merged into the tree and have
> the old register space.
>
> This is and old driver, and its usage of DT is from long before many
> of the current best practices where determined, or yaml was even an
> idea. So i'm not surprised it has a few odd quirks.
>
> I don't see a reason not to remove these constraints, as i said, the
> driver should do the right thing if the register space it too small
> and YAML does not warn about it.

Is that an Ack? I almost read your double negative as a Nak and that's
what the maintainers read because it is now "Rejected" in PW.

Rob

