Return-Path: <linux-kernel+bounces-50708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABCB847D20
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA38228B542
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45712C801;
	Fri,  2 Feb 2024 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5E2eXf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75108592F;
	Fri,  2 Feb 2024 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916049; cv=none; b=WeLqos2GAWeU495/7Psv9R/Q84LY7XoJQc48X/iYue7gFM37VfVC5JpXnsxX+ZC6b2x4SdF1TJL8zQIc6air63dLaKdewMS74YugtxYq3xTwApPPUqovHD0d7AkpYejly9IOYBFVbL+kdNiTuxjC6em+HAcdi5bfq+fWnj+ezqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916049; c=relaxed/simple;
	bh=OZlIIMlUht4XYhbukAIZUl5DVjNY9FcWhu1WB1zXhO8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjn3wbsccDDd6Ycerzx86oKGwi3ykOY8MRcLZmrArziKvzUQSOcfsOz6BO4zpaLxnPIFPgk3NIQBbqDda4Wg2o4jtdgPIkacCL1qNi5b3D0t6Gne6irSEDHnj3dlrc0p47dG6j2Myqy8ULHh5Z+MwiHJ2TLMJ/XV/F1dgd4w8HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5E2eXf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C14C433F1;
	Fri,  2 Feb 2024 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706916049;
	bh=OZlIIMlUht4XYhbukAIZUl5DVjNY9FcWhu1WB1zXhO8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=f5E2eXf1Ild/UMkfGx99IbLsTij/1GRs5ifwmhNvRkW/K++94QA58uN3l7ic5ZQsi
	 agVFB7axGJfjtI95n+uM9bJryBfV1IZZLvMz7SKFM/dzxdNKTL6fxiw0pGR1RSsrB7
	 PCpK2BVU2V6j7p1umI4ncoz4kY7PmYUKnGw4j4ADQHlh3yMjBo5GDzfkHUnGkWfynv
	 IF/WIiRZXD/umuoVdEzuVtFcmSGijqysTCf8vguztRT7ueTDAbaJUmwadeePS1+6Lw
	 AJVuaAsXSci79oOQjhgwnygnG+HamDu8UhPbX2f8xiOQyWPSic8ZOOFArMH0ooBr4N
	 599AZNBx/FTzw==
Date: Fri, 2 Feb 2024 17:20:46 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: Re: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR
 reg read
Message-ID: <2fwmzxfxm3eyrffmri2ybxicgk3n6rxckmyvvpxhmok62cqvzs@iaioxvhlncwu>
References: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
 <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>

On Fri, Feb 02, 2024 at 11:56:53AM -0800, Elliot Berman wrote:
> On Fri, Feb 02, 2024 at 11:47:43AM -0800, Unnathi Chalicheemala wrote:
> > Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
> > check return value after Broadcast_OR register read in
> > llcc_update_act_ctrl(), add it.
> > 
> 
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> You'll probably want to add:
> 
> Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")

No, this was correct in a3134fb09e0b, ret was returned on the following
line. The problem was introduced when the new 4.1 if statement was
introduced without considering that ret might be overwritten.

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")

Regards,
Bjorn

> 
> > Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> > ---
> >  drivers/soc/qcom/llcc-qcom.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index 4ca88eaebf06..cbef0dea1d5d 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
> >  	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
> >  				      slice_status, !(slice_status & status),
> >  				      0, LLCC_STATUS_READ_DELAY);
> > +	if (ret)
> > +		return ret;
> >  
> >  	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
> >  		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
> > 
> > ---
> > base-commit: 021533194476035883300d60fbb3136426ac8ea5
> > change-id: 20240202-fix_llcc_update_act_ctrl-64908aed9450
> > 
> > Best regards,
> > -- 
> > Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> > 

