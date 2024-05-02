Return-Path: <linux-kernel+bounces-166745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB6B8B9ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08801B211D9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311416D4C0;
	Thu,  2 May 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTtXIYGT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1B664DB;
	Thu,  2 May 2024 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668394; cv=none; b=rMF3LFVBOfuVZZwdLPSCHfQxENSIoloCSnCfLhIFe3Crw9KeGNkNAHbHL7J+jCLCXCzWdpvB/LgBcws37tfM8UgswBYi7k5+ycdtBFnfi3e2pmpL/op/qTCkalqSTjW3RADnc1VkzweN8F+NbkLIuCYxyNpMW+mBaWZ7rRS9tOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668394; c=relaxed/simple;
	bh=yfNOr8I6emxbraWzqiLkTOoSxuGqpPV69lJpaOH6v8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iSsHQt2Dos3f82Po4gLYB0ZrAokOlVPFjy7ZEWUV42IKsg8rsYYbmohUINfST6GwVHFaOmAPeOonMd9+1BuYXN2B32scTIrO9ilOYaUGqtDOf8x5cku+KCjbZQd1LW+QIn9X4xgMGnWS2DnpHESjKM+qvapXT72/ujxNTArEAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTtXIYGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1432C32789;
	Thu,  2 May 2024 16:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668393;
	bh=yfNOr8I6emxbraWzqiLkTOoSxuGqpPV69lJpaOH6v8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gTtXIYGTEKi5RC2zj8ImegHgCO11KS+7xoSX+9z38kPGxcuIwkRUjdWDaMQZdsCUm
	 I9gJFCHszPoHDg2vP+SIsTO38XtC+vQwoX1lLzv5bNo7J4j7Reu6xPzd3j4RtWrgBp
	 ub2XM1sv+uFQGrlBqnF1tO9TCW/DStYRwZSGL/DcHseeoICm2Ts/pY03SJl3vIHxZm
	 uG8g+tvOIUugaRCAPAd69+Y6sXUG0RjtTG1Fpzx7+aMgjBLLG1NeE2PE8RrMp7LLD+
	 HFpZR0yTDaa7SIoVf8+olQ+Ib5RavWVOB0D93JvUQwwJ5K7nvBYL6eD31kcCJCbIw/
	 qNTOjUqbHKEBw==
From: Lee Jones <lee@kernel.org>
To: andersson@kernel.org, Herman van Hazendonk <github.com@herrie.org>
Cc: benwolsieffer@gmail.com, chris.chapuis@gmail.com, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Satya Priya <quic_c_skakit@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415123038.1526386-1-github.com@herrie.org>
References: <20240415123038.1526386-1-github.com@herrie.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: qcom: pm8xxx: Add pm8901
 compatible
Message-Id: <171466839064.1205357.5859595998076859143.b4-ty@kernel.org>
Date: Thu, 02 May 2024 17:46:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 15 Apr 2024 14:30:38 +0200, Herman van Hazendonk wrote:
> Add missing compatible for the pm8901 model used in msm8660
> such as (HP TouchPad (tenderloin).
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: qcom: pm8xxx: Add pm8901 compatible
      commit: cbb0241b40c4f2f27a2daf6fb09722d01a5c37ee

--
Lee Jones [李琼斯]


