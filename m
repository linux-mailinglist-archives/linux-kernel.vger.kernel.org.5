Return-Path: <linux-kernel+bounces-61878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330CD8517BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616491C21A1D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58863C47E;
	Mon, 12 Feb 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQkfmy+V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154611DFD9;
	Mon, 12 Feb 2024 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750892; cv=none; b=NDT9ivu9XMBNMZPO/R/Z3tSZhspyo4Qf/u9g6elUrpWaAixQAjMPWO4C27nSmSaHVNn6xJRYF95p6hEh0AjiehE2x6CVfaRjOWZEPR07eTBLx7VUbNS+KIDvcZFTPao1eXvU8km5AUM24r3kT7bWyAuyNy5rWlaUbb7AeWYW6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750892; c=relaxed/simple;
	bh=5q6JZRqfcRM8joFrd/AFSLb1fQAqV7AVpQcJ1988pP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IC+J3ePRB2YpIZ21S7JkEcgmTamurXQxGtSbfLZsmMoutGdRnQMWNidEpnIbbdK7NVpNY8V/r7kpORmAliPuNglmgE5Sn9zUwLrpQVhycHPVuq32FsuvvlwnPr62YSyWM2RK7CDvedb1jdyzHxvooFGxRo3uN8qvcstDh1kFWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQkfmy+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34609C433C7;
	Mon, 12 Feb 2024 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707750891;
	bh=5q6JZRqfcRM8joFrd/AFSLb1fQAqV7AVpQcJ1988pP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YQkfmy+VhabegvGXYGdHPXVnU/TNaW2q6GRYvxAKffYehQeYdPKGKik/HCuQ88VhG
	 juJB0HrNy/KuEymDRS460fW8Q+3mLNnW6gzkQuEANAB1OHBqYfWuoYIAN+xutNTJxR
	 oYJn6xUg+jaQNP1aO/1WQYbTQTORUYdE+cD9CAHnzywsuTvzBKFczSu58mlit3Fvfs
	 mvil+84HteuRA1x5MDRfVZD5JVcg73qqK/DtMW8d+C0q1bAieBygA+IvCvGJV+uLEl
	 WbK5BlpmL9TMKBjGsR6vqLz8rt1P43xbB85xA/ztcWebzfRXLd2kKs4ezbhpr4Ftua
	 c66lzHktm0dpg==
Date: Mon, 12 Feb 2024 09:14:49 -0600
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
	chao.wei@sophgo.com, conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com,
	richardcochran@gmail.com, sboyd@kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
	guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
	samuel.holland@sifive.com
Subject: Re: [PATCH v9 2/5] dt-bindings: clock: sophgo: add RP gate clocks
 for SG2042
Message-ID: <20240212151449.GA379868-robh@kernel.org>
References: <cover.1706854074.git.unicorn_wang@outlook.com>
 <fcdd83addcd9af159a0bebf2a14543168bd59a07.1706854074.git.unicorn_wang@outlook.com>
 <20240205172422.GA3643653-robh@kernel.org>
 <MA0P287MB2822C8930916B90A9C1BAA49FE462@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MA0P287MB2822C8930916B90A9C1BAA49FE462@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Tue, Feb 06, 2024 at 08:57:27PM +0800, Chen Wang wrote:
> 
> On 2024/2/6 1:24, Rob Herring wrote:
> > On Fri, Feb 02, 2024 at 02:42:02PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > > 
> > > Add bindings for the gate clocks of RP subsystem for Sophgo SG2042.
> > > 
> > > Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> > > ---
> > >   .../bindings/clock/sophgo,sg2042-rpgate.yaml  | 37 ++++++++++++
> > >   .../dt-bindings/clock/sophgo,sg2042-rpgate.h  | 58 +++++++++++++++++++
> > >   2 files changed, 95 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
> > >   create mode 100644 include/dt-bindings/clock/sophgo,sg2042-rpgate.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
> > > new file mode 100644
> > > index 000000000000..69ce3a64f66c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sophgo,sg2042-rpgate.yaml
> > > @@ -0,0 +1,37 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/clock/sophgo,sg2042-rpgate.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Sophgo SG2042 Gate Clock Generator for RP(riscv processors) subsystem
> > > +
> > > +maintainers:
> > > +  - Chen Wang <unicorn_wang@outlook.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: sophgo,sg2042-rpgate
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +    description:
> > > +      See <dt-bindings/clock/sophgo,sg2042-rpgate.h> for valid indices.
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - '#clock-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    clock-controller@10000000 {
> > > +      compatible = "sophgo,sg2042-rpgate";
> > > +      reg = <0x10000000 0x10000>;
> > > +      #clock-cells = <1>;
> > No input clocks?
> 
> I think it should have some input, I will add it, thanks.
> 
> BTW,  can we ignore this property if driver doesn't use it？ In other words,
> do we have to add this clocks property just to indicate that this node
> requires some clocks as input from a hardware perspective?

Yes and no. The kernel will see the dependency and track that. But your 
driver doesn't have to get the clock or anything. Though presumably the 
source is a fixed-clock and you need its frequency to calculate child 
clock rates.

Rob

