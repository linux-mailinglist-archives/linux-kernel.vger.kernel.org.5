Return-Path: <linux-kernel+bounces-152529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CB88AC00B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 18:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90CD280EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6520310;
	Sun, 21 Apr 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhZFoNVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4662383AF;
	Sun, 21 Apr 2024 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713715634; cv=none; b=lcOEw99PGih/W0efEimkKXGoGZA7gfOFtJ4VhHQ8KxA8Ic1/T1c09tpf/rGj/6pfxBSi5VEYG2baLsGQUdBNbUSATbHq+GOEzAeCQU5aw1yYj+1jeVZKVg+yDjT3sEnB9zyOjB0Y5l+GauWfzVp/JjgiLBOPWTJchDI5o98dRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713715634; c=relaxed/simple;
	bh=KUk5q81n35fZQQK++/IRj1wBVrqylAjpnubCWLHeuB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umnAydqK1WjsYAvCm7tisAZCw7wKWMSgQ7B3K3mh3C3OGD4L+5x4IdsC4gMgAHIc+rkW3sOT7WLXu6DdFD+7vm4HKQmHzLmrgylIrmv421nRwdCw4Q8RHcs0BaqtJSLiG3iXQGa7RvLknWy1OBgTS0SA1YuruN8KB+WlFb6g7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhZFoNVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7116C4AF09;
	Sun, 21 Apr 2024 16:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713715633;
	bh=KUk5q81n35fZQQK++/IRj1wBVrqylAjpnubCWLHeuB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhZFoNVvC45q22LIXIEhKebRE13ELkx7VFg7LtKa/FHakJXjmhhKooX7+uWxDrSL0
	 ZdoXWAH6RAwriDXvkh2CSTz//TSMw+WE+K0snIIKneyjrSZd/sHzQ8EC5dXSd3bKEB
	 KOPOZvBnmmV8qPuLjADsZvS9bgBTxvgtKdmwNjSBszrnGZQk5qC3T4FEjwWPzsDbNS
	 C0aVUceUguiwOvfKJLpmZwtakwLvR1kyjDKpKRQ34jQXzE36N2OcUxS9Fw3bXpI5ci
	 9Jkk0RBl4IOdukvxsiRIKfusX4zjkIF/HY+FW/5Q2JIL5ZWBxNCHGpilQKMLVez7Y1
	 B8DooDOddcHKQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Umang Chheda <quic_uchheda@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_kamalw@quicinc.com
Subject: Re: [PATCH v3] arm64: dts: qcom: qcm6490-idp: Name the regulators
Date: Sun, 21 Apr 2024 11:07:06 -0500
Message-ID: <171371562480.1174524.16499249150579133571.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412123237.2633000-1-quic_uchheda@quicinc.com>
References: <20240412123237.2633000-1-quic_uchheda@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Apr 2024 18:02:37 +0530, Umang Chheda wrote:
> Without explicitly specifying names for the regulators they are named
> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making it impossible to reason debug prints and
> regulator_summary.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: qcm6490-idp: Name the regulators
      commit: 776c5f3c9c9a28f5eea0f8fc2a49e83bb87fe7d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

