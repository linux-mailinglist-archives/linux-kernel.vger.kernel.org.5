Return-Path: <linux-kernel+bounces-132932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20907899C21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF26D286C6C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38616C6A8;
	Fri,  5 Apr 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCJdQ2M8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4D36CDB7;
	Fri,  5 Apr 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318063; cv=none; b=fyTWhiPtcGnJVgO8gFh+RXllvCuYsYyCYPdiHg9QeF2CM1IcJzBAwMxjy3C7rtdUnKH++BUvwWXty46sGz+EKDDxaJCt5waGS2M4/FESm4Qu0deC3RKSz+U7QI6mA6slKKkuHgY+28iXX/EsvZ2uVZwZQuzv8zfS6LwqlRwX0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318063; c=relaxed/simple;
	bh=xtWDTgQnqWwlGt4hSK509dlzyI5ov0XFlUekFt9Elt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyeLVNACqJ7nNsH1eZ7rUqu3emmQXhKNk2+EIujcCsdNLS3ZQEdrpmwGFAwHhxH4Vxf2nGOCkSnCJ2v3+obcLet8nNr/53t/+rtTDtCtGFmRRjwLUsN6BCEYd+4tSU68j8LFxtxkgvLrQU4AJDudCZmu9msWsHqizn8rmow/L7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCJdQ2M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E741C433F1;
	Fri,  5 Apr 2024 11:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712318063;
	bh=xtWDTgQnqWwlGt4hSK509dlzyI5ov0XFlUekFt9Elt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LCJdQ2M8SudtctJXICiqEHb5IW5cnvqyV8c2DgU/C3Jb0sDEtWhdj2JCUPlhLgjCY
	 HbfBMDYfXvCJTWsP3yzz6cKHc3uxyZyeflmjb2f/Ra0Mi6j4kh/J8q2XpzafXXlbYs
	 lGHCzLlb51yurcbLyacoBP/nW05DysT8gpH1o3IJiTrB0tfxVTzcUJdWHlrTIGpL9d
	 zCspJvFYsiq4ZSuBxF8m9I8Y5Kg2z1I8EFKaxzk5JxzkRAfwFsN7DlGeJVmaeAziy8
	 tp+CnEtUtjF0gbTsGmVzQM42blDR4wehkLTGLoTy2glcFfSSNdsr2MEm//6hYPsZ7r
	 +A2R5gx9VlNPA==
Date: Fri, 5 Apr 2024 17:24:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer devices
Message-ID: <Zg_maukMaZXuJAWR@matsya>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
 <Zg_fvU-SA9nwmzW8@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg_fvU-SA9nwmzW8@matsya>

On 05-04-24, 16:55, Vinod Koul wrote:
> On 03-04-24, 15:27, Krzysztof Kozlowski wrote:
> > Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> > over two Soundwire controllers, thus they need a multi-link Soundwire
> > stream runtime.
> 
> This does on apply on sdw/next.

s/does/does not

> 
> Pls rebase
> 
> -- 
> ~Vinod

-- 
~Vinod

