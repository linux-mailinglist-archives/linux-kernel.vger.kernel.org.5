Return-Path: <linux-kernel+bounces-89888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E986F6EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD295B20F38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC5D7A711;
	Sun,  3 Mar 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAGNpe4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA227A12E;
	Sun,  3 Mar 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709495426; cv=none; b=TJv++ktxGfRj22Eu198VvIDaugT1H219v024FIIFcfuvaUrW5O2poIwrrT4ZXWNrbusCMiRratt8sNXXKXx/FdpHSKNqqiK6EnSh314VWkWbUcxD3ARCjlD+m0jKH1kAIcu5qGe1m8UdvjbMlInhGx7GuTNVFljvAW6o5jrfU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709495426; c=relaxed/simple;
	bh=NqOpHNUkPpcXOLnh/QWRufn/Ytxmtgs9sizhlMM6yUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmHHnoHpJdiPaRRKuKDDsVS58YqV9eU+0geFtz4CW6hMPfmbg1rJKX/vBIQvrlcpQ36eDM3H9TEV07RqphxFkbjNJf/I5oFmuP8CkinNqn8bz1L4WUxGtO245QdHeSS+V2B1uLa6LujoG/q9WW0xc7D4Vq99ojluWDnUzHbsyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAGNpe4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849B9C433B1;
	Sun,  3 Mar 2024 19:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709495426;
	bh=NqOpHNUkPpcXOLnh/QWRufn/Ytxmtgs9sizhlMM6yUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAGNpe4vbmCT1lk0B4Ggv5UAZaXI/dje2Dg2hpGp03ESpBowujBmH4jQDaxPIFdZW
	 mV05WggJJz+JLN4/eE47tWNX2sMbmi9aaHsFkBZocU6jWRx8nA4GVE1fJCdr+SlDTa
	 f7OA5ay7cvWttsVjGxAYh+iu5b8XvAZBLGqJoE7Lo3wGMmsqIBOe9DEcCoZ9PpRukN
	 8Y4S+DIVqhZQZXsbnm2VGDljEhN2eYjlTjokfamd/9qbyky71NjEN50Pe8VKtwehao
	 NCYpbfv8DO9sz6ZdvWylP9Olyde5H4JBXB64ooYa7uBJF9HRIV01kM0mh896st8caw
	 i7W7iqbID8UJg==
From: Bjorn Andersson <andersson@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3 ITS enable
Date: Sun,  3 Mar 2024 13:50:20 -0600
Message-ID: <170949540962.78121.423418904639454445.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223152124.20042-1-johan+linaro@kernel.org>
References: <20240223152124.20042-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 23 Feb 2024 16:21:12 +0100, Johan Hovold wrote:
> This series addresses a few problems with the sc8280xp PCIe
> implementation.
> 
> The DWC PCIe controller can either use its internal MSI controller or an
> external one such as the GICv3 ITS. Enabling the latter allows for
> assigning affinity to individual interrupts, but results in a large
> amount of Correctable Errors being logged on both the Lenovo ThinkPad
> X13s and the sc8280xp-crd reference design.
> 
> [...]

Applied, thanks!

[06/12] arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
        commit: db8138845cebcdd0c709570b8217bd052757b8df
[07/12] arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
        commit: 7a1c6a8bf47b0b290c79b9cc3ba6ee68be5522e8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

