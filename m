Return-Path: <linux-kernel+bounces-22829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F382A387
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7B82896F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B144F883;
	Wed, 10 Jan 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhR0vvYK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834712AE69;
	Wed, 10 Jan 2024 21:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11E0C433F1;
	Wed, 10 Jan 2024 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704923162;
	bh=hbT21zaEKH9BJDarRM6/a+kiLWB9ebn7plUYWqUhisQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=EhR0vvYKUylc/ffJRTLhiUMz4eN/s/9vb5ME9IPglzsrEhg/rZknl1Q4Io8EH846r
	 FYxqjVYhg/AhaHO3xk6mFAmGKXpzSqLGEKLqaYfcbN50SRm2Q7urgg+VF2h+xZNny7
	 7UJ4g7lTYiz2aoxnKzYeNvUtucnvRJbzB9PffTbm07MCWE8bS0648WBgTRcrHXK3A8
	 0lNCdqCaiMkGVfg4+jNPSmL+8OLrj6V27ng9mPNQbyXNbjrRaXlLFP6Mb5ZG8DbAv4
	 +bMqG4j48/inmnAcm3ammI/JcCIo3jmWiUv3h82R0KyG/mVXCDGB/6inWjJkb09UCC
	 N8wblpu7kQkpg==
Message-ID: <78875535469138a0fd0659d7e621a4f2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <dc739435-d955-44f7-b5ee-9de4d5336725@linaro.org>
References: <20240108135421.684263-1-tmaimon77@gmail.com> <20240108135421.684263-2-tmaimon77@gmail.com> <20240109170830.GA2772086-robh@kernel.org> <CAP6Zq1jCHVrFfRa6c3DZ4t2aaJTkWukeEkia0AqhzppC0mjbfg@mail.gmail.com> <dc739435-d955-44f7-b5ee-9de4d5336725@linaro.org>
Subject: Re: [PATCH v22 1/8] dt-bindings: clock: npcm845: Add reference 25m clock property
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com, joel@jms.id.au, venture@google.com, yuenn@google.com, benjaminfair@google.com, openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 10 Jan 2024 13:45:59 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-01-10 12:54:14)
> On 10/01/2024 14:47, Tomer Maimon wrote:
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: refclk
> >>> +
> >>>    '#clock-cells':
> >>>      const: 1
> >>>      description:
> >>> @@ -30,12 +38,20 @@ properties:
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>> +  - clocks
> >>> +  - clock-names
> >>
> >> New required properties are an ABI break. That's fine if you explain w=
hy
> >> that's okay in the commit msg.
> > What do you mean?
>=20
> I think it was clear. Which part is not clear?
>=20
> > Could I add the new required properties to the required list?
>=20
> You just did, didn't you? And received feedback that you are breaking
> the ABI.
>=20

It's fine to break the ABI as long as the commit message explains that
the driver isn't merged yet.

