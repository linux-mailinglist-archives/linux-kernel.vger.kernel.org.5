Return-Path: <linux-kernel+bounces-152072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DA98AB870
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4117D281DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEBC79DE;
	Sat, 20 Apr 2024 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9qEJZHa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1B5CBD;
	Sat, 20 Apr 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577647; cv=none; b=VCq5qMbYohtH8nIplfM7bBvhcclGNRHVbU1FmE8WN85VHheXhhia9YoqUi0jwau7CoMklD32ddlm38NZrMVhtqem8ut59M6yfNs6IxKqffOICKL4Pp6nvvW+nWJokwhe2TQ3IPBQ998VhPQX1xCeRjMAFUh1/sNtVYvxXI4zTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577647; c=relaxed/simple;
	bh=Wkq9R/fdbk//Bx9s705zg1J5qQkoukUR/Zgkx33AMOA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=J8h4ksCaM9V+N5rJ9oY1ywJljm4BUz6z9sK/BCoZSIjnIrtz3Wwtg8zPVMpzjUrdhdUtRIGIQOOA7RskCw4MB/BWvYyJ600gL/V13oDPa/a+Sn3u+tcWFEet4BFqM1lS4+w/ivBysDZTYqa5/9zNStyu7dkGRc4qyN4pwJ/Tt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9qEJZHa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8D0C2BD11;
	Sat, 20 Apr 2024 01:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713577647;
	bh=Wkq9R/fdbk//Bx9s705zg1J5qQkoukUR/Zgkx33AMOA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=R9qEJZHaUguTYgNNIQJiSoa5EVzoriJOd+Pv/Nk46WJj1JJd0mcuwpJZTvUqi/SyW
	 hZej278gvBLV5Cf7Amwfn0KsbSAW4Hb6Bzib0A5OJqxRDNihNxrHCNdtFU2iAZfXtU
	 lELwxiCYg05XFFYQdo1pVHIuHapEyxHpBJluLgrkaMGmTbs9zEp5y+Iv1dpnPyvHZ5
	 LdVSIfvB4hVn4dZPkCOg4upsM7ybWqYjTTMYv1jFGBSniXTyTPy/vcJ9aVt2ivR+Sq
	 /9RCuSe4HGbSCzBHv7ZQxUMPo3gZCmLMnvnA9PBp1tFMSN2wQxcUYtcxoq/flw6zTQ
	 iNy1EUA7TqGvw==
Message-ID: <97594c7ca4b53b5c94097b72c412c3ac.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240417-spmi-multi-master-support-v10-3-5bc6d322e266@linaro.org>
References: <20240417-spmi-multi-master-support-v10-0-5bc6d322e266@linaro.org> <20240417-spmi-multi-master-support-v10-3-5bc6d322e266@linaro.org>
Subject: Re: [PATCH v10 3/7] spmi: pmic-arb: Fix some compile warnings about members not being described
From: Stephen Boyd <sboyd@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Date: Fri, 19 Apr 2024 18:47:25 -0700
User-Agent: alot/0.10

Quoting Abel Vesa (2024-04-17 13:00:55)
> Fix the following compile warnings:
>=20
>  warning: Function parameter or struct member 'core' not described in 'sp=
mi_pmic_arb'
>  warning: Function parameter or struct member 'core_size' not described i=
n 'spmi_pmic_arb'
>  warning: Function parameter or struct member 'mapping_table_valid' not d=
escribed in 'spmi_pmic_arb'
>  warning: Function parameter or struct member 'pmic_arb' not described in=
 'pmic_arb_read_data'
>  warning: Function parameter or struct member 'pmic_arb' not described in=
 'pmic_arb_write_data'
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

Applied to spmi-next

