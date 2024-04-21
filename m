Return-Path: <linux-kernel+bounces-152633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38A38AC1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 00:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6BD280E5C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B575029C;
	Sun, 21 Apr 2024 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diNew6C5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AE050282;
	Sun, 21 Apr 2024 22:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738584; cv=none; b=dkbOTOqZSqb0gpuisEMwFbuJxCXHeJssqzsD8cGNGqEikkmEWYLk9+9l10ijfNCOt6/+LxkiKb8wIFSU7lczMAkCjqWwyK2hac67LmoivMRgYwMxhKExWfd1y1jjyokXOOl9iRlvlGwWR45NtOxD6Zsvf6TtOe8Imig3FXOevII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738584; c=relaxed/simple;
	bh=jEjKhcnluuJojYzcaevi9FZZrWku84zNkzsM0CAGaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cawiverwb5O3YqsFqZi777SpY1yhFoxD1hj/DAY5b2OGP+kEfAJMlXTF9Ob8U9Txma+B2pvmyazJBB1Wks77ZZxq4C4nL+c8v/rkKrdq+AATbEKo1KrgJhS5WOhhD5iUCW4IdrXOqiy2xiHT3XiYCWflY8Zg0sNpO8WEP85Nan8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diNew6C5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A534CC32783;
	Sun, 21 Apr 2024 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713738584;
	bh=jEjKhcnluuJojYzcaevi9FZZrWku84zNkzsM0CAGaQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diNew6C58uKmlWR/CBm+8502SPRnKn5K4aX20yN6ChH3pXks/xy39SXZ2LhJfcSfF
	 J+IT5X6kXIiLtPdY3jtpubSBQyMietHHv1FG+tXDHOgTyCFTs0luUnzGP4hK0HB58G
	 narEavKl9j7qm6aE4HzHQGutk6SebSif0EhPFmEpY5k9beSygxqCJegX5QDMRaRA+9
	 VPMnUYtE953rPZ6V+9o7RvnmcWvsEN4JXVB7QOhgYxT7BIHL63ExNcTVn47hueQ43S
	 oyACtK5iL5N6Rp++PZJ0XuHgtgmfsEXHnviWpMM1ZqihhQkeUDODB9c2wLpqV+UbMy
	 a2EhhOCHRHeQw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Jianhua Lu <lujianhua000@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus regulator-min-microamp and regulator-max-microamp
Date: Sun, 21 Apr 2024 17:29:18 -0500
Message-ID: <171373856759.1196479.16513435248860288869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240323100443.2478-1-lujianhua000@gmail.com>
References: <20240323100443.2478-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 23 Mar 2024 18:04:43 +0800, Jianhua Lu wrote:
> Fix the dtb check warnings:
>   sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-min-microamp' is a required property
>   sm8250-xiaomi-elish-boe.dtb: usb-vbus-regulator@1100: 'regulator-max-microamp' is a required property
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-xiaomi-elish: set pm8150b_vbus regulator-min-microamp and regulator-max-microamp
      commit: 0a8ab4a834507fd5432168ddda7fd3f9eab239f0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

