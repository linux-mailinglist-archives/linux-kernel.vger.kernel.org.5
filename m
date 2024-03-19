Return-Path: <linux-kernel+bounces-108086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12E8805C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166D5284C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2258138;
	Tue, 19 Mar 2024 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJnDqtCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31012C6B8;
	Tue, 19 Mar 2024 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878530; cv=none; b=gSSfiKvcScbgnqQNWsbQlN4E4FXrHl+PCQs2t7DB5q2ZD7HVM8DgDPvw/ZqGRGSYdrN3QQzm997oLaumtmQpigR20fSlyGXBY6K9t7NGhYPWcf+gxp0oZKaq7RU0yrSwwPzzGrvNq4gVDW3Uh1Hx0ySTCPVqlBYCf+MTYa+cqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878530; c=relaxed/simple;
	bh=BfzfXnXoSemadhBtWj3WTtx3o15kRsVsxyeo0pRpIbA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=pgN9pf30Ym5VusHhsu7L5PJ6zfVMHX2nyr7QTIbt2xBwCj6xjofg6EeaAjOWvQ0lyuAojOLKan/Qm0XaAy2SY/Rg7YeGyWnw4XWQ494143EsF/xkU9Fey0jm14kD1GS76mL746cR0iHeW+iyO7iHOFaouD0taO0JidHSHAPfINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJnDqtCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5E5C433C7;
	Tue, 19 Mar 2024 20:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710878529;
	bh=BfzfXnXoSemadhBtWj3WTtx3o15kRsVsxyeo0pRpIbA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pJnDqtCzYhzzXWlnC9ojvuZnXmWsdooKOdDBCKUA3VpLuUkNv6/QqSCz2Iq1NYCId
	 QWeNNDoQHySk/Co56XBb0CoTAo7F2JYQFkTgR0nl1QOBP6T3/rPjEOLNk8FXDzvayn
	 nUFdCRXbp3yMYYgotTwKXP6wL73w3M6y4gBC8Y5o7FiQQc9DBmnlTRso4emUlHJh44
	 a31RC8yKuy3KD6RpVfvKIgkpMxdYysdBrtkl81Nq78Lg4zYn7b3Ek6arb2H8qNye61
	 w5tUz5gfardmH9IAmTMfdkPDHZzDyWYDLsHFBaeD+8NDkIuQOpjI8sYwNGz4h6zFdu
	 dOAfSntfba3Ag==
Date: Tue, 19 Mar 2024 15:02:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, 
 netdev@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Rocky Liao <quic_rjliao@quicinc.com>, 
 linux-bluetooth@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Marcel Holtmann <marcel@holtmann.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240319152926.1288-2-johan+linaro@kernel.org>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-2-johan+linaro@kernel.org>
Message-Id: <171087317847.5394.2197018705200988833.robh@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: bluetooth: add
 'qcom,local-bd-address-broken'


On Tue, 19 Mar 2024 16:29:22 +0100, Johan Hovold wrote:
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
> 
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
> 
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks.
> 
> Add a 'qcom,local-bd-address-broken' property which can be set on these
> platforms to indicate that the boot firmware is using the wrong byte
> order.
> 
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml  | 3 +++
>  1 file changed, 3 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:98:16: [error] syntax error: mapping values are not allowed here (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.example.dts'
Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:98:16: mapping values are not allowed in this context
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:98:16: mapping values are not allowed in this context
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1428: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240319152926.1288-2-johan+linaro@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


