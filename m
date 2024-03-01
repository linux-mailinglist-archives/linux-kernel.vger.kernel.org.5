Return-Path: <linux-kernel+bounces-88197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB67886DE68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD97B25F09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56726A8BB;
	Fri,  1 Mar 2024 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZDYSkYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE223BD;
	Fri,  1 Mar 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285994; cv=none; b=CkMXaB04liOKXOJq09yXKTMOjUOxSkks+b9bmqzJ5/kwF0/kNUl3Ts4TwqF7Uq9Lop5lhiKqcvw/5QAbD0GYQKAp6lSu+9WQDsQ3e29rVneuQw4sL3I9MOCzKKNzWMp9ycvMvvf15OZRg0w/YiwJIjIFwSTP2cjDsKtuc8V/f8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285994; c=relaxed/simple;
	bh=2H+wqfnKRplzPg5l6zYg26c/tyBENVooq2HXypPunyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzHspioT8+qU6ZIuEiKKGvopzwc22eij77wAvmj5S+gXoA2eAhRw0PHcDFsiBfj0sjeuy5IWenXz1p03pAUmneiBLvvP4E8Jo+JJb9lOi8e21R1OcsiN7g7mxCalOfV1c47vDaz6yMV1Bw+/aGVgp2HLCloU+bEKLDanHhjWt24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZDYSkYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79189C433F1;
	Fri,  1 Mar 2024 09:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709285993;
	bh=2H+wqfnKRplzPg5l6zYg26c/tyBENVooq2HXypPunyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZDYSkYoJ2RjOFFVciA0Fsl1z/GJ9YxbNRyWwBBXRHjkQPIZ6Mx+B6ko/uiQZlOtG
	 2seV4/AIoopDlGhLxeNPnGrth6CjMm6vT/FbPd0pokIHZ7hbFys+CiWVCcf8ZZSd1M
	 30GY3nEvEi9oKpRGKVmI8lyjhkD4LhOaREMEuWsvzWir2+pe47Iit/qfmAdbXYwfSY
	 Oaj0DLDvTMNvLe30h+KjhYe50WBYy/jFEkVeEwhDMiBmSTeClO3ZIouTkUuwOuazdP
	 ZKxDil2QbzL7jO8GUGwrq5oRJc/HEcUT/LI2JN/bOgl/j7G1+NkObsLQG27dfoZhWP
	 EOgSpn/OpRW3Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rfzN5-000000007Yk-2BYQ;
	Fri, 01 Mar 2024 10:40:04 +0100
Date: Fri, 1 Mar 2024 10:40:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
	Devi Priya <quic_devipriy@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Georgi Djakov <gdjakov@mm-sol.com>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency
 table arrays
Message-ID: <ZeGic5cG8lneKJXp@hovoldconsulting.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
 <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>

On Thu, Feb 29, 2024 at 07:07:46PM +0100, Gabor Juhos wrote:
> The frequency table arrays are supposed to be terminated with an
> empty element. Add such entry to the end of the arrays where it
> is missing in order to avoid possible out-of-bound access when
> the table is traversed by functions like qcom_find_freq() or
> qcom_find_freq_floor().
> 
> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")

Good find!

Looks like these should be backported to the stable kernels as well so
someone should add:

Cc: stable@vger.kernel.org

to all patches except possibly the sc8280xp one (that camera clock
controller was added in 6.8-rc1 so that patch does not need it in case
you can these fixes in before 6.8 is released).

Johan

