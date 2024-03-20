Return-Path: <linux-kernel+bounces-109327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126858817A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF47A1F234C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571E385645;
	Wed, 20 Mar 2024 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eA/c20Zf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DF85620;
	Wed, 20 Mar 2024 19:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961719; cv=none; b=YS9t1wSf/Rj51jfvhSSi9r8MMVvcz35PR+sZcmt3Qczel5X4zfhVvkufa4cJJTdXifflcTbUl9gzDklxtvtjC9fRb+k0gjQoMmn7wTOhZZoQSBiNuwu6ltZSjjg104w7JtkYAgAiqcnSukSxtKbf6oMmb0h97rM3mHXqCBsD4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961719; c=relaxed/simple;
	bh=RlLArVdNVxnX+9lojlX/66x+328N/NvGFFfTG53lmyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj53JVNrEl5baZAOtSZKnnaLUpvIZGHq/GboHJz10P6p1Bt8gaBIIgAceNp9yWZi2qIapoiAu8DZ12HY9PRQ+TaVyG5Rai3VGWycPmbAZgpbhqk97Wnr5eIFkR8RTEQDVk+tbe5BMOMXf+Kcb1UGDQd5xqsnQTnwjp3KnENZVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eA/c20Zf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710961716;
	bh=RlLArVdNVxnX+9lojlX/66x+328N/NvGFFfTG53lmyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eA/c20ZfNzyBlrCt0ItE+VzA7h+YQln+eiMR/Lu8qNlqE7EkkDDrmwUsm9nr31mRD
	 Id6Nvhmj/OI4anXOgyJQ0fxjvvXtm7HBy3sY2RId+XA9kFMnmIIsqJB1ilXOBfs14P
	 akR5YsIJKORrpZNTDdJOJhH5iDPLdl+ACUu9139pNaDvkHMhukmBxopKwz8BtBnbO8
	 VcEQsaTstLR+qtobFAGPC+LAU4Bbw6p1ZrHYqr1hBPl035ronnaw1e07G4L5pLXgkB
	 xSsHDuv5dIWVjYs9eMLHmva3tKQxTR9bvL0kuaginxIQHrXOE0aKaZMI9M8tPtxta1
	 VOTIzaNJs3SDg==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3713D3780BFE;
	Wed, 20 Mar 2024 19:08:32 +0000 (UTC)
Date: Wed, 20 Mar 2024 15:08:07 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Amit Kucheria <amitk@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v2 0/3] QCM2290 LMH
Message-ID: <d8ed4e6c-549f-4c04-b38a-2d788df8b707@notapiano>
References: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240308-topic-rb1_lmh-v2-0-bac3914b0fe3@linaro.org>

On Sat, Mar 09, 2024 at 02:15:01PM +0100, Konrad Dybcio wrote:
> Wire up LMH on QCM2290 and fix a bad bug while at it.
> 
> P1-2 for thermal, P3 for qcom
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Pick up tags
> - Fix a couple typos in commit messages
> - Drop stray msm8998 binding addition
> - Link to v1: https://lore.kernel.org/r/20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org
> 
> ---
> Konrad Dybcio (2):
>       dt-bindings: thermal: lmh: Add QCM2290 compatible
>       thermal: qcom: lmh: Check for SCM availability at probe
> 
> Loic Poulain (1):
>       arm64: dts: qcom: qcm2290: Add LMH node
> 
>  Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 12 ++++++++----
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                   | 14 +++++++++++++-
>  drivers/thermal/qcom/lmh.c                              |  3 +++
>  3 files changed, 24 insertions(+), 5 deletions(-)

Hi,

I've started tracking the results of 'make dtbs_check' on linux-next, and I've
noticed that on today's next, next-20240320, there's a new warning coming from
this. The reason is that the DT change has landed, but the binding has not,
since it goes through a separate tree. I thought the binding was supposed to
always land before the driver and DT that make use of it, but looking through
the dt-binding documentation pages I couldn't find anything confirming or
denying that.

I expect this to happen again in the future, which is why I'm reaching out to
understand better how to deal with this kind of situation.

Thanks,
Nícolas

> ---
> base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
> change-id: 20240308-topic-rb1_lmh-1e0f440c392a
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 

