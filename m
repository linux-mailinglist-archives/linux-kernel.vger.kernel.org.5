Return-Path: <linux-kernel+bounces-69466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FE88589EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251D81F21D63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFF214C5AA;
	Fri, 16 Feb 2024 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKH5BHyD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9F14C587;
	Fri, 16 Feb 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125057; cv=none; b=ZKZ8aA7DggzV5Vc6ymoCJmqIs7cx9K2MCkuZsUzUQwhXyDPKmGYkAvwPx4gI1QhvySxJ8b5JXMvTmMpw8stO6bGZ3g8X9kpo2Kn0Owi8dT+VuiX9383suEH5yUkqvPW45WWWCAKwfcOd+e3u7D2wC8dybbXlOB2IZRcPpyffJA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125057; c=relaxed/simple;
	bh=kFscJpd4PtsMos7FcDnb8F7Hy9BzwMNBGQNhfikpbx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ3p19p3vf+lpHa+P4vHeGRBbs/m7tZ4wdXBIocYzNw2VS15FjDX/3kFHxuXxvW8/OfR31SNC6F5bP1ewGPhvmct78OV/9Zumilkfi7+aGuqUZgqEdw+cXKkvXvWKElxjkgIbuhtz/yIywSW9Cuhr3HoVL9/w+WDkSZVlyo0NJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKH5BHyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51347C433C7;
	Fri, 16 Feb 2024 23:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125057;
	bh=kFscJpd4PtsMos7FcDnb8F7Hy9BzwMNBGQNhfikpbx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKH5BHyDT91jVZ0ealppnCoK5yciKRR/2GfTUnStw5YLAhlMAU7Nf+6Y5PfI3oiIr
	 fx75y2ZDjTmVJM20qdggTyrWgROO+SnUeG4KJpK7Q9/2S8faBcHWoyLSEWGU8wWrin
	 nuMlHQa4HnWrHijWy26LWRQITPhROVZb31Nxz1xqk+1fFyoJEQK2cyuheTToQtN2Vb
	 +dHUxN/04NmCqS37iF1SYkULVu/MWKvHCQ4ManwU1h/JhbDH8XRUqJqwafr+AcAB89
	 6k2q303xGWixAxDx6L9t1lyT8y/LTzntZynZ0w4szl+XFPovg0Yp+NiS3l7H6cFIsw
	 aGGiIuB6kZadQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v3 0/4] Add display support for Fairphone 4
Date: Fri, 16 Feb 2024 17:10:40 -0600
Message-ID: <170812504021.18043.10678302937679130651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
References: <20240216-fp4-panel-v3-0-a556e4b79640@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Feb 2024 11:10:47 +0100, Luca Weiss wrote:
> Introduce the bindings and panel driver for the LCD panel with the model
> number 9A-3R063-1102B from DJN which is using the HX83112A driver IC. It
> is used on the Fairphone 4 smartphone.
> 
> Then we can add the panel to the device dts and also enable the GPU.
> 
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sm6350: Remove "disabled" state of GMU
      commit: 2abe4a310cc742332038aed5f9f4a15e65a0bcc1
[4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Enable display and GPU
      commit: 891af1aa1ea42514b9a7f42caaa1fa0c32f8e232

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

