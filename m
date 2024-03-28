Return-Path: <linux-kernel+bounces-123687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAA890CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E129293165
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561DC13B593;
	Thu, 28 Mar 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esHe22s8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412681752;
	Thu, 28 Mar 2024 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711662672; cv=none; b=J3Qm5FK1yfrpB92QRbAft/ULqiEWWlSaGJ+lo/haKdqNOQ6NKEnJ5N+lFITJ/cGsWedG+wmDlfNLvikPtzwj0xej9Mmhfccayka4XlcrehzmyR4T71+YO0cC90XxE7W2ZTpbTqfKhbJ7lEOm+cAnB+Uj18lyhjjZZcXOFJBjM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711662672; c=relaxed/simple;
	bh=kDwe9Nhm7lE8AL8JY1vMlWhsHIywSrYlJ13DQOehe5w=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=UNkCzQoKqkq++bvBlUzJ3ppbtsaJS+/W8gk6MfcW8n33rNpNCs/51v1LryFSM5kVAAbjom8Bb2Yims/HUy8WmFgX/GldH/bOMZ1JH/lpufkVWnMTNXhXKBFAOxc0XPU5fMTDxncUNOHs7zFPEzymi16Jd6Z1TPsqMyiOKq+2+Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esHe22s8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DD5C433C7;
	Thu, 28 Mar 2024 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711662672;
	bh=kDwe9Nhm7lE8AL8JY1vMlWhsHIywSrYlJ13DQOehe5w=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=esHe22s85rralJGnhs8eo4vhoGNOF3mAbLKgBYcVJ7P+tP31vCRN6vLDmchmII1ha
	 nPgeDao773r95dEb4iflh+8KUj/uHtBo8Hz/pOT4LByEgFT2odyrzr9VkiFA+ppOB3
	 Kg6hkx18pm6KthBhxVMFOQFKATxliKE7AGFyTmFoTjLYJdSFus8K6/FuKhKa5tHwpf
	 qvQyJZNX8IhQU01riZSw6sVKta4qJ5w8bD60iAgcrKVNC84g+SxiQ/tBln+Y1E6PSK
	 ICuuEYcoLBnQ6JWklfKfNsGHxVzozqAl0iqQuLaoO3hTbM3cnk7IAz+5l+Ng2pEURz
	 57saOLSBf/cgQ==
Message-ID: <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240328075936.223461-5-quic_varada@quicinc.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com> <20240328075936.223461-5-quic_varada@quicinc.com>
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC related clocks
From: Stephen Boyd <sboyd@kernel.org>
To: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, djakov@kernel.org, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, quic_anusha@quicinc.com, quic_varada@quicinc.com, robh@kernel.org
Date: Thu, 28 Mar 2024 14:51:09 -0700
User-Agent: alot/0.10

Quoting Varadarajan Narayanan (2024-03-28 00:59:35)
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq957=
4.c
> index 0a3f846695b8..187fd9dcdf49 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_res=
ets[] =3D {
>         [GCC_WCSS_Q6_TBU_BCR] =3D { 0x12054, 0 },
>  };
> =20
> +#define IPQ_APPS_ID                    9574    /* some unique value */

How is this supposed to stay unique? I don't understand
icc_node_create() API quite honestly. Why can't icc_clk_register()
maintain some ida of allocated numbers? Or is there some global number
space that we can "reserve" from? I'm quite amazed this is how things
are connected in interconnect framework.

> +
> +enum {
> +       ICC_ANOC_PCIE0,
> +       ICC_SNOC_PCIE0,
> +       ICC_ANOC_PCIE1,
> +       ICC_SNOC_PCIE1,
> +       ICC_ANOC_PCIE2,
> +       ICC_SNOC_PCIE2,
> +       ICC_ANOC_PCIE3,
> +       ICC_SNOC_PCIE3,
> +       ICC_SNOC_USB,
> +       ICC_ANOC_USB_AXI,
> +       ICC_NSSNOC_NSSCC,
> +       ICC_NSSNOC_SNOC_0,
> +       ICC_NSSNOC_SNOC_1,
> +       ICC_NSSNOC_PCNOC_1,
> +       ICC_NSSNOC_QOSGEN_REF,
> +       ICC_NSSNOC_TIMEOUT_REF,
> +       ICC_NSSNOC_XO_DCD,
> +       ICC_NSSNOC_ATB,
> +       ICC_MEM_NOC_NSSNOC,
> +       ICC_NSSNOC_MEMNOC,
> +       ICC_NSSNOC_MEM_NOC_1,
> +};

Are these supposed to be in a dt-binding header?

> +
> +static struct clk_hw *icc_ipq9574_hws[] =3D {
> +       [ICC_ANOC_PCIE0] =3D &gcc_anoc_pcie0_1lane_m_clk.clkr.hw,
> +       [ICC_SNOC_PCIE0] =3D &gcc_anoc_pcie1_1lane_m_clk.clkr.hw,
> +       [ICC_ANOC_PCIE1] =3D &gcc_anoc_pcie2_2lane_m_clk.clkr.hw,
> +       [ICC_SNOC_PCIE1] =3D &gcc_anoc_pcie3_2lane_m_clk.clkr.hw,
> +       [ICC_ANOC_PCIE2] =3D &gcc_snoc_pcie0_1lane_s_clk.clkr.hw,
> +       [ICC_SNOC_PCIE2] =3D &gcc_snoc_pcie1_1lane_s_clk.clkr.hw,

