Return-Path: <linux-kernel+bounces-91296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2B870C6A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13D11F2287E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB727C097;
	Mon,  4 Mar 2024 21:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8LzTQ2F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566147BB14;
	Mon,  4 Mar 2024 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587434; cv=none; b=uAv3XBygUo9Y8ZAMCNEV8TRMpp4U+7LuVYnbmSvdYhokR2i3xaUwR1CMrXjk+qLjz9YOrVSwEqZw6hps8x6JkPmAmhCifsZ+UJNdpUzLJYYIut+CImMwo7Jiz/gLednvwoW95QRkK7AVEoNl8qPAMZYopd+npZbD+B4TkCXQQxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587434; c=relaxed/simple;
	bh=fmnxBmvQENBK6rJ7r2zTJLLEyQqWQmRXJ4nyyN6Mkf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESLwfVAaupNvPa/0aeHihJYEFEL8zHYx8iSRzID71ayOKMPSAQvG/p8/fz0682p1d4iuLIi3jVD5cbQ1REx+91IsVLi+lFQbQ+OpnCnQLajlundkSoqnm8n5V/+p45LLxLggotGGI05hjICFYsPGnHxxaupAMW6HaNIZpq15e4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8LzTQ2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C55C43394;
	Mon,  4 Mar 2024 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587434;
	bh=fmnxBmvQENBK6rJ7r2zTJLLEyQqWQmRXJ4nyyN6Mkf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C8LzTQ2F3oyNq3fWKaqxucSF5jEKo7Kjgb5w3s1bjwVejRaHXG8uzwysOCUIZQFlb
	 IV2Ofh09fy1VwgyEx1mOYyEBy3Auj4GAVp9gTqAireX4JHvqKIpEFmdtzcwNs+mke9
	 eXDS2EPkJPuxjOkLhgtvlGrXu9SCVRWDhwdm/uxVUfzpHAf/UjxW3irq+nDVFlIN2d
	 8jzhH+s35k0bnEBrL5lMEAcZrBbRUD5CJfNQFXXFPvT/KXwXdZmoDUaJiiMleFcZKj
	 P1FC0FvTgOE4DXjARwGg0P52O4PCCEd1igidOrqmMEm7SUb+ZPD1lpS5zi+px9yfGL
	 KbFVU6Jvr/96g==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianhua Lu <lujianhua000@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250-xiaomi-elish: set rotation
Date: Mon,  4 Mar 2024 13:28:43 -0800
Message-ID: <170958768041.1828118.8042574606703966284.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227121744.10918-1-lujianhua000@gmail.com>
References: <20240227121744.10918-1-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 27 Feb 2024 20:17:44 +0800, Jianhua Lu wrote:
> Xiaomi Pad 5 Pro has a 2560x1600 portrait screen, set RIGHT_UP rotation
> to make it look like a landscape screen.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-xiaomi-elish: set rotation
      commit: 2219626708d7300402a46c31e2347d40db7c4971

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

