Return-Path: <linux-kernel+bounces-136849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF389D8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C7A28845C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF59812D76E;
	Tue,  9 Apr 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Sfvet1Gz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906E12AAC8;
	Tue,  9 Apr 2024 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664721; cv=none; b=rgkZGM08/3TIg3XwVGdR2HfmoQVkfE0UaGnLoxM3+DXMBJLtPrXyI7mxpBzjrMIg4Qqgp8aiEyvLUnGL0gJ5rJQtlOdhnM/M4ExbFycyt+Mah9+7aHXSCD8lRhHK18+M7XdtzBpCMMT5xLNA7PzSd4aV1V75pBMNNEodi9MO/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664721; c=relaxed/simple;
	bh=v0RQHTIRFDC41mS96xZoh27SZqw4jzWtkR/nAo3pAB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sCx7bD+nt+JY72NNSzFIJW3WvMJMJEZ4Opw8QyOjeTMPeBZOcruDZUvtnhmCrsGNqnHifFLfQiYo3zNXX0HZMC7Ul+qB9j4+aFYF+Q4sb2deAjIBcvKXnzfbd3Ip/Nt7nyn+6c4HBOh90yzHRaOjQcsy2QA30BWp0JbLd+qlSeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Sfvet1Gz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712664718;
	bh=v0RQHTIRFDC41mS96xZoh27SZqw4jzWtkR/nAo3pAB4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sfvet1GzYabCTR3o7M2mjfoh0odXuBq3BtLvTRdNenZLcjqXnid0lKLMZJjGlDrXR
	 vbdXYEMOvz5pLLx5ZNveOlVapvkJKEtvwuse7qeAsNxqI2qigPmfTpbI1sCjVgBhxL
	 NaL2mbjQAwfDtR2VrxmbhymdDkmgwqqmA9zdTWtwDwTsOss7xDjH9DrTWa9yECYMmh
	 QQXK6agbu3YOMA6H8PStgF1h0RB6Ml53t3sJjh2OVY2EPhMsSb9URy4EBGa/8Ax0D5
	 HI0J0N5a+F9K0CH/Ad1XAHdG+EDczp6NEKQBSfTYAE8DfftiMu03d+k9NIVQHAcIsA
	 fBYq+CGN5Dqow==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B8CC37820F8;
	Tue,  9 Apr 2024 12:11:57 +0000 (UTC)
Message-ID: <2bfff311-87f0-488e-a0f0-709513ae2799@collabora.com>
Date: Tue, 9 Apr 2024 14:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: qcom: Add MSM8974 APCS
 compatible
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240408-msm8974-apcs-v1-0-90cb7368836e@z3ntu.xyz>
 <20240408-msm8974-apcs-v1-1-90cb7368836e@z3ntu.xyz>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240408-msm8974-apcs-v1-1-90cb7368836e@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/04/24 21:32, Luca Weiss ha scritto:
> Add compatible for the Qualcomm MSM8974 APCS block.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


