Return-Path: <linux-kernel+bounces-65740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F468550FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CF51C29D97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180C129A6D;
	Wed, 14 Feb 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNWCpJkf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B741292F0;
	Wed, 14 Feb 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933468; cv=none; b=lB1SrIhdc1i6nAgzgl/6OFMzmYjgn8fCj84BbLmQ+srYgJPjvD8RlGfBPIZWKiJGyluPh/C4JFPKkyHJMhBvsJlJDemDT5iWYV/fuBpa/6AF5n6hCXv9jQyibWOgwxsP5fkZQA3/RivfKYAc3vn2tHboZITWumNbLDjj6qLiBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933468; c=relaxed/simple;
	bh=e9d9nBEcVxvgAYnCI2Y4Nbm8yLTOdSlgzQdxVJtZ7XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9Nc6eHetfgJstRIN4OgNgjwQDjfWsGvDqLK93VpvHsJ9rAT7XXeqQL8suB1usZqabrKYdypT7KxfO5SK7T7DkmMqnAHQ+RyDMDR/Dyxw/ZUhkLwGc4uHv0WJGFEIG4MX4Ed8mA+/KmtadgfwEA2SxDvFchzypTnxPQtakl2trw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNWCpJkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A64C433C7;
	Wed, 14 Feb 2024 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707933467;
	bh=e9d9nBEcVxvgAYnCI2Y4Nbm8yLTOdSlgzQdxVJtZ7XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNWCpJkfapwxErKu8pl7rxDtpjXOKjUXdlglnHRq/8cgvvaVQ9RzJnBxvD7BBxhzk
	 5FiYKWVufBXuQ4jdviKqgzQf2LmInbbmoUr3g/t6M1mNxsD1Fzsm2xZrE2mRbUJhpH
	 aww+ouJdEy0YbNTBKrIJ2i3gSPF2f7AFToKjRq/1WwE8zWR3xuEge+LtYgGp2IRmIe
	 3ljvFPCEYr1aFouWO4m2GE9WWutpSZiS8xi1kb6zQHMWr/h+/yfrF8LlXwVDi6TViR
	 7CTg1YRPVlIC3KrMYCxxqgT3pUAyYLr9A6jwm6xTVh7C0738wNInAsSIcutoXXXnnf
	 UzVWeKlv5bb/g==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: socinfo: Add SM8475 IDs
Date: Wed, 14 Feb 2024 11:57:21 -0600
Message-ID: <170793345823.27225.60582762103313981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212201428.87151-1-danila@jiaxyga.com>
References: <20240212201428.87151-1-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 23:14:26 +0300, Danila Tikhonov wrote:
> This series adds IDs for Qualcomm SM8475 SoC.
> 
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for SM8475 family
      commit: 307b7d8f70b25733c88c66846bab5acf319fffef
[2/2] soc: qcom: socinfo: Add Soc IDs for SM8475 family
      commit: c8f349ac13d174f0ceb26df67b86075b491cacc1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

