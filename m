Return-Path: <linux-kernel+bounces-136141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D1789D06C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C82B23A75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3D5465D;
	Tue,  9 Apr 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfDuqMsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21A5465B;
	Tue,  9 Apr 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712630095; cv=none; b=a6gW8ksQlhZLtxp7YL4NuIQm5yKIhGjE02/RinoSuKKhGq6lSsuArUrTD9ZZlLKIbwm2G2F7VQ5c4ASbyZ8jXD1vcc4yxhy+V+m/rkfePQAIKL2Wtk1wh/EMwGYn5xN/keb1a16e97ueXbxGQq9MUDR34OToSlelAk0bwyYVXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712630095; c=relaxed/simple;
	bh=Seu7MEseXAofsiFG8utdZXOywqzS1EPCJzsIpTnAYMg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mSDPTzUxNrj1ZS+yjBuomJCp7efEC94ADRTtuhVaL1SzPNgnE5NegWRVFb+aPo7qgLAIxesHApkXbiGAxvlV5VHYT0/lEFDcf+wQzSyO0ycayvP0y6SqjU4DVEgBx6iUamllw+Pfm0jH0NwrIuUi6kRUF4Y5XoD8+49mowXV49U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfDuqMsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F7CC433F1;
	Tue,  9 Apr 2024 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712630094;
	bh=Seu7MEseXAofsiFG8utdZXOywqzS1EPCJzsIpTnAYMg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qfDuqMsENwFasEEnQB3DM2C76irjmQ9u3yD02di/koRT29NkVGW0DrAzVF5FuloQu
	 IOcqkQSQZP3m5mu2nfuNzP6225SWvoa5ioYYi3jS/Oq20FtZSuiJIPKjxvv10uEPCd
	 lCRja8XT8J28ZCzqGNynuRprPLInP5rZ1uGhtOsz8hQH7h4J7myjoZNrQ1fs7RJFXW
	 fIxFY+oIvqpXQjVP8TtUpkt27CWkTYGIdVX4hmEgpgknFUB//1ONgXgTwQXcGKjkt5
	 YZg0SWUhPU81YCe+ygmq8hVc4TMKxYxN+gHK3jypgjEw644u6IEEvudLcf+IEsk8l/
	 deWqc/hlqB74A==
Message-ID: <ad3e3201fbea1f73f1550877d5c12ba5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240408-dispcc-dp-clocks-v1-1-f9e44902c28d@linaro.org>
References: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org> <20240408-dispcc-dp-clocks-v1-1-f9e44902c28d@linaro.org>
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sm8450: fix DisplayPort clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Konrad Dybcio <konrad.dybcio@somainline.org>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 08 Apr 2024 19:34:52 -0700
User-Agent: alot/0.10

Quoting Dmitry Baryshkov (2024-04-08 04:47:04)
> On SM8450 DisplayPort link clocks use frequency tables inherited from
> the vendor kernel, it is not applicable in the upstream kernel. Drop
> frequency tables and use clk_byte2_ops for those clocks.

The subject says "fix", but does this fix anything, or simply optimize?
Is something broken by having the frequency table?

