Return-Path: <linux-kernel+bounces-4642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08642818036
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05FD1F243D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6111728;
	Tue, 19 Dec 2023 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBbbisUn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79D11700;
	Tue, 19 Dec 2023 03:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525C2C433C8;
	Tue, 19 Dec 2023 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702956475;
	bh=ly5MkWkrf0sVyD+7wDf7pEb9V3jwCKHfjog8ZuNE3v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iBbbisUnJxxblNJMHfYxa4edTG7OUXFT0x0PYxJD1WWcb5CNR0amGvZNnxfgmASEa
	 h3qHBMZig5QyZ453MsX45aMf6mneG0ptZe97mWMkmpYmHe1ffn1pU1tDKSsyaxnUj6
	 uYatCYehho/4sQOjdMzvRuYX+Qys1HjLDaHDAwvYuMQnwwK1vububM/a8cDiTT5Tbv
	 Gw3k/+xzTbXhmwiDAs7bQudmba4a4RcJ2wHzEWcEAWu1wZ7WANjatEoaYcMQE4umtY
	 5rCca2pzt/pE1NjNpBtKQ9YFI011K9BkqqcQ33Hsq79Y6IP6kIagOs0FrbHf0nHeXk
	 bfMwsBEdYLuQQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: (subset) [PATCH v6 00/13] arm64: qcom: add and enable SHM Bridge support
Date: Mon, 18 Dec 2023 21:27:52 -0600
Message-ID: <170295646310.109617.9399976770089648986.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231127141600.20929-1-brgl@bgdev.pl>
References: <20231127141600.20929-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 27 Nov 2023 15:15:47 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This is pretty much another full rewrite of the SHM Bridge support
> series. After more on- and off-list discussions I think this time it
> will be close to the final thing though.
> 
> We've established the need for using separate pools for SCM and QSEECOM
> as well as the upcoming scminvoke driver.
> 
> [...]

Applied, thanks!

[01/13] firmware: qcom: qseecom: fix memory leaks in error paths
        commit: 6c57d7b593c4a4e60db65d5ce0fe1d9f79ccbe9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

