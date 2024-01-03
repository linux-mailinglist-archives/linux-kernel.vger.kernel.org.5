Return-Path: <linux-kernel+bounces-15826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223308233EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5287286C82
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2D1C6B4;
	Wed,  3 Jan 2024 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROahT/8a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E521C6AE;
	Wed,  3 Jan 2024 17:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718D2C433C7;
	Wed,  3 Jan 2024 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704304467;
	bh=bjY+TelhsJhVcAkpYhMDsUdz6i9JvN3gBf3gtTujZ1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ROahT/8aY0QDu/FZ89Eg8rXfrfU5CK/zMWmuIs4IO9BtDTHJYEVvJ2TZylO3ELRx+
	 nf3rGE1oyjfqSwMC+DwtjCtZMfxH6aktMcSY4QCuzCPNOd8jV/MHtHLHtx+9VavmfN
	 UPUkYbZq49tykJj4ZUXgfo73yWqrAibYvUy0Dro9/aP5cy17x0zTPVPaAmlTQ+nYKg
	 JndllnIxg9gw7KvLDWY66qYcd+WBXJuWXNIAXyoFpnS/bkmeTuc/lY2jGr10+PN0gQ
	 4tqVaZhdFo9/jd1MQADboEpJ0kNYDQExoyFXPdGZxl/wN4kjAzqlkqVIfvZpHuqzLc
	 c70ZtlQgFDw+A==
Received: (nullmailer pid 1445325 invoked by uid 1000);
	Wed, 03 Jan 2024 17:54:24 -0000
Date: Wed, 3 Jan 2024 10:54:24 -0700
From: Rob Herring <robh@kernel.org>
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Message-ID: <20240103175424.GA1440392-robh@kernel.org>
References: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org>
 <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org>
 <87bcff40-b5ff-41c9-a33f-95f5e80a2f22@linaro.org>
 <62995a12-e835-40ff-966f-8522f2ab53dc@nexus-software.ie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62995a12-e835-40ff-966f-8522f2ab53dc@nexus-software.ie>

On Wed, Jan 03, 2024 at 09:40:02AM +0000, Bryan O'Donoghue wrote:
> On 03/01/2024 07:40, Krzysztof Kozlowski wrote:
> > On 03/01/2024 03:18, Bryan O'Donoghue wrote:
> > > Add bindings for qcom,sc8280xp-camss in order to support the camera
> > > subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> > > 
> > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > >   .../bindings/media/qcom,sc8280xp-camss.yaml        | 512 +++++++++++++++++++++
> > >   1 file changed, 512 insertions(+)
> > > 
> > 
> > This patch fails, as pointed out by Robot.
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> 
> Ah its in Bjorn's 6.8 clock pull tree.
> 
> I will repost when it hits -next

How is that helpful? It will still fail, and the media maintainers still 
can't apply this. If you work on linux-next, you'd better be 
aware of and explain the dependencies.

Rob

