Return-Path: <linux-kernel+bounces-152641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE968AC1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C59280E2B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1D54BD6;
	Sun, 21 Apr 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0p6mfgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224B54789;
	Sun, 21 Apr 2024 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738593; cv=none; b=FHAta8PHzongcYgMmqgpwr0gTyDo8BADsO3P+ocakHpnR0OkmsOhzgVs1rqJZzYG3/ysCD8A/OpNbHOgL/+LFmA8rHH7V97y6LZRRBxm+TZ0pW+NxwQSV6DNqP/PZ/QMBditj95gAWOael1TMcW+exMc90hBm/QiXCgoUXbQwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738593; c=relaxed/simple;
	bh=UH+6aUr9utTm5nv/K4+m8ZeCH7eZU+nOETs/mIikeOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsoDbMyylzLRnqsSsIqux7hSV11GAJHmu1drAvZVooVmZ6zg0P5sGC/i78iOuC448jEFqRp4Sz8G8Rm2yTpetu4uJXhCAkIGTevBYfjdwdQt0IkN1OwAa6COGVlGiTuQnvMTsrCSimqBDZvypiIhI0seejuDYUWMSjm/M9pujT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0p6mfgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F26DC4AF0C;
	Sun, 21 Apr 2024 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738592;
	bh=UH+6aUr9utTm5nv/K4+m8ZeCH7eZU+nOETs/mIikeOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0p6mfgj2tqVxT0tnSF3UKV5fh17tVRo0WTIYTmHjWyxr+HqWTlE0gsfEFiX+1dRu
	 O5zYAodgb0I7b0shLXHTcDwhjjZTmU3LgjnjUx42FZFI14WKKoI1ib3oRWXlc8fF/w
	 yRYLwrwDfmNuL5GpWRT8KoL8UbtjiJSI24LwRp/n2W65l+KrfxxpDfY9+3tuIzluE0
	 QA/2oRFgZ1gu9n7K6mubapYFzG8lNGvtuBnM7oM4+Y8W6du1nFYjUT7wQ+O+zt5fiZ
	 HI71jHoJ6iwcGr9xEcDw+BLrbq+W1W+A1VJifL1rSBmRSYk6kZfChiQT4NuDYtQQ+8
	 o1NARp5TEN0/A==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] firmware: qcom: scm: Remove log reporting memory allocation failure
Date: Sun, 21 Apr 2024 17:29:27 -0500
Message-ID: <171373856759.1196479.1054868371443084757.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
References: <1711034642-22860-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 21 Mar 2024 20:53:59 +0530, Mukesh Ojha wrote:
> Remove redundant memory allocation failure.
> 
> WARNING: Possible unnecessary 'out of memory' message
> +       if (!mdata_buf) {
> +               dev_err(__scm->dev, "Allocation of metadata buffer failed.\n");
> 
> 
> [...]

Applied, thanks!

[1/4] firmware: qcom: scm: Remove log reporting memory allocation failure
      commit: 3de990f7895906a7a18d2dff63e3e525acaa4ecc
[2/4] firmware: scm: Remove redundant scm argument from qcom_scm_waitq_wakeup()
      commit: 000636d91d605f6209a635a29d0487af5b12b237
[3/4] firmware: qcom: scm: Rework dload mode availability check
      commit: 398a4c58f3f29ac3ff4d777dc91fe40a07bbca8c
[4/4] firmware: qcom: scm: Fix __scm and waitq completion variable initialization
      commit: 2e4955167ec5c04534cebea9e8273a907e7a75e1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

