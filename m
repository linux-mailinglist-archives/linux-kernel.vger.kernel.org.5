Return-Path: <linux-kernel+bounces-152071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12508AB86D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516271F2187B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C66ABA;
	Sat, 20 Apr 2024 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Twj8UPeZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A13A40;
	Sat, 20 Apr 2024 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577636; cv=none; b=TKXPnBR0bXq4FsIgkyEzklS/aGR+fYRKWz7+uhKHPzH+MT2PQkq+UPgpSubNZ7xRAmpSnP8hKHqJUNeKLw84cJp0tBW1HDpXKpqrp7Rayn7R12fBc57jh58ud/J51SuQV0YdDNqLJLnqSj1AfzD10wfxWUgE460Ajyjw2is8tr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577636; c=relaxed/simple;
	bh=fi1gfxDGU9DyDoYCAwmnKrsw+kK2oGoPULKWkCn/ByY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DFgQDNyE6JpMf+yE4KvAM3Vc37H0ZiWAuFQtwq1eblb9eVHJzjKnRX3AdQfcSjz5m13aUtjbs9j1EXDyn8z0vhjnj9hUV4Y0LlkQtDobvSTbiLI2opReVyZF2tKLdxCAmKqJ/+LuS9G7qYeWkKxpqoJqzaOG0sMaIwee3T8w9Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Twj8UPeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D85C072AA;
	Sat, 20 Apr 2024 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577635;
	bh=fi1gfxDGU9DyDoYCAwmnKrsw+kK2oGoPULKWkCn/ByY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Twj8UPeZIGO8BeDUMG89gTomLhjnAhfSpvSO9YNlQMkvsbHwfvAF6EuhZKcl1lJb+
	 3DXM5qjlZ5jLIGCyEf21qwfbxRAKHqDtNAl1zGcq6qno8+AFdQlY1YuNhMua+3U4G2
	 dshDA59ztPHseB6v0VqK4NT94RzKipL/OwzxcaYJK4lN1bS6RZXfWJB/9V7w1O3XuH
	 bmhCjsEdUALj4rh0xfExqE/AEvu5AMTBHnWmLIx0qjUg3Z+TPLYYFDn0VOXOiV/yxZ
	 I1BzaYElbqQcUTSXqRLw/qZchERmjBN4ZFwVEPaUDYjVR2cl/p8B3RXMjpqUIf59Z9
	 8LrYtcUdmRYaw==
Message-ID: <094dde0105acb1fb1644ae14930065e8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-2-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-2-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 2/7] dt-bindings: spmi: Deprecate qcom,bus-id
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:47:13 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:54)
> As it is optional and no platform is actually using the secondary bus,
> deprecate the qcom,bus-id property. For newer platforms that implement
> SPMI PMIC ARB v7 in HW, the X1E80100 approach should be used.
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

