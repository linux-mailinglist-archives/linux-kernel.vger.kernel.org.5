Return-Path: <linux-kernel+bounces-134679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B889B4E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A60B20F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4449F1E876;
	Mon,  8 Apr 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAc7K/zC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6791DFC5;
	Mon,  8 Apr 2024 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712534827; cv=none; b=gYAHT1U845Rl4nEp6NbwkyW+oG8KWCR9hU01dl1l+F1kMic1loh8UHtHh+EZJm6bQDy6AuywN2Plqw1H7ARYrdZnZgebKXOyIuMOGYGeX3KRAzVNhPwQ7DefSp7vpS/aTm6zwV4adij8CJApZ7ecsbi9EijqEMz0UveKKnlkjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712534827; c=relaxed/simple;
	bh=4A6xrkkJR9Gpkc/uXFnyXfPY6mYgg2NhHzgcMzsviag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc7rjV5qbtvYGQlGpNkMgN1AoPIsVNIPMcr3WqNQmBMxLC232gN97fWjZl4JfeNsXf1pS9B8hKm8bGeJEaXd9L+GD2EcSo6yIBN4jWTizxN625V6RS5AI87ULgD5coWwt0mh29Pdw/TR/vJrtotGMksWs9KMa+dO0Cr/ypv9R7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAc7K/zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89728C433C7;
	Mon,  8 Apr 2024 00:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712534826;
	bh=4A6xrkkJR9Gpkc/uXFnyXfPY6mYgg2NhHzgcMzsviag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAc7K/zCHaVCzMj/rrqxnwJ/C7ghWjM4L3daMo8oa4RSKuW5cJK+rze9tp7hdlx3N
	 YenELiKelk4K4OVezAmKQRF9GCbJvmlU1d2HNsQfnhHV8qCL49YD4UDBHb5qRlnYIa
	 KH0y7yZbfOEffNzf+kz4Dqf7hElcYD+oGiiOM/wOCkX+aMHZ9aIeYxUbl2Fdf3bNPS
	 XH9PcxvP+vCa42bRgwQreicjhICJ/02czQXwEJGkpVpo7fn2upTax3H1GzZieOzTXl
	 WU4A5Wxy+yc9j7JP6421txn00+OmK5tnz1Z/q8KPZci3SQI7sltmWmmg+ll+ZDXOqV
	 ShzmXcSE9R/Uw==
Date: Sun, 7 Apr 2024 19:07:03 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Johan Hovold <johan@kernel.org>, 
	David Collins <quic_collinsd@quicinc.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v9 1/7] dt-bindings: spmi: Add X1E80100 SPMI PMIC ARB
 schema
Message-ID: <fkwugrnak3fhkg5ig47kmy3edm45ut4dprkabntnwemjt3w2mb@7cak5zxwzw4p>
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
 <20240407-spmi-multi-master-support-v9-1-fa151c1391f3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407-spmi-multi-master-support-v9-1-fa151c1391f3@linaro.org>

On Sun, Apr 07, 2024 at 07:23:21PM +0300, Abel Vesa wrote:
> Add dedicated schema for X1E80100 PMIC ARB (v7) as it allows multiple
> buses by declaring them as child nodes.
> 

But is this really a "dedicated schema for X1E80100"? Isn't it "the
schema for all multi-bus controllers"?

I.e. isn't this a "dedicated schema for all platforms starting with
SM8450"?

Can you please use the commit message to document the actual reason why
you choose to create a dedicated schema for this? Is it simply to avoid
having to schema with either pmics or multiple buses as children?

Regards,
Bjorn

