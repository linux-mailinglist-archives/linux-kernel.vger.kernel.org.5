Return-Path: <linux-kernel+bounces-89554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1261886F1EF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87D1282D9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C336AE4;
	Sat,  2 Mar 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVx2aGn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4D376EB;
	Sat,  2 Mar 2024 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709404907; cv=none; b=tVpHUjdm/Zx9xZxeuCpabyjfxz+hEyzXNO1eRWWUajdBMl0viiZbULaNcp4eugiBAsPszNHRcNWWTVm3Xt35lCCdVEY9rmJ6VI4ysFrQUebbwQwQss9eTfolXQfUDkAkNRPlAedlkxWx38EZLintyBuFEwxxIeOvcgf3YlCs6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709404907; c=relaxed/simple;
	bh=LVXdkM0Nxq6bVW0IsDj2dHOFAaUWxzw+WVZYqgrnLvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PI5TQh9BJTTPSBE2I4XzbRBkaCDESZhedZkjmJvt+VncVkdQUJ7Bawecr9A2pOpZff0Smb6rEfWaJaPGhiHypiKQFg/ojMGjbVQGRCZC0Euwyo+8jQgllQ0QQElksz08xSdneyLgak3yRnbMaFJ9bOum39sS44b08Z6Sl04lCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVx2aGn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276F5C433C7;
	Sat,  2 Mar 2024 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709404907;
	bh=LVXdkM0Nxq6bVW0IsDj2dHOFAaUWxzw+WVZYqgrnLvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVx2aGn12Ppv2HW9eOqIN8bs40TVMQ///mkMRM/ewkk29DnDj87Qn+QsVgR8ozbqg
	 B4WcYL6P3FEV6H7+ae797s2XxDnCJd4lcahrNwAPsof3Uwd8vGZUwMWOdV41hsCg2N
	 Ppj7K5liIo5MuJbS5XDF10CDpx5IchWxbr/ryfYWyavfRP3P3sQsDSjB/7VkvIequh
	 4EKUiRC8af7rGk6CoBp8owGojk5yK0PRVLaafUijxJ61vJ38k5KNc5Z2rcCf7HrGXo
	 ktmQp5XvbepgWHkdKfuBaj/MlBP5Cq6qEC1+mHUnFsA6KafYWNqy7Z7F18BnWZz1sA
	 CsdQ4NGO3CzgA==
Date: Sat, 2 Mar 2024 12:41:44 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Gabor Juhos <j4g8y7@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
	Varadarajan Narayanan <quic_varada@quicinc.com>, Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
	Devi Priya <quic_devipriy@quicinc.com>, Anusha Rao <quic_anusha@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Georgi Djakov <gdjakov@mm-sol.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] clk: qcom: gcc-ipq5018: fix terminating of frequency
 table arrays
Message-ID: <35zcbdj7sk6y7cdpqs7s3exsouzftzlgj6lvuglnyvuxfshvgs@m7rz5owrinud>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
 <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
 <ZeGic5cG8lneKJXp@hovoldconsulting.com>
 <91b36da5-637d-4156-8be4-5aed55fc3c5d@gmail.com>
 <ZeHgI2nsADrkecC8@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeHgI2nsADrkecC8@hovoldconsulting.com>

On Fri, Mar 01, 2024 at 03:03:15PM +0100, Johan Hovold wrote:
> On Fri, Mar 01, 2024 at 02:37:01PM +0100, Gabor Juhos wrote:
> > Hi Johan,
> > 
> > 2024. 03. 01. 10:40 keltezéssel, Johan Hovold írta:
> > > On Thu, Feb 29, 2024 at 07:07:46PM +0100, Gabor Juhos wrote:
> > >> The frequency table arrays are supposed to be terminated with an
> > >> empty element. Add such entry to the end of the arrays where it
> > >> is missing in order to avoid possible out-of-bound access when
> > >> the table is traversed by functions like qcom_find_freq() or
> > >> qcom_find_freq_floor().
> > >>
> > >> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> > > 
> > > Good find!
> > > 
> > > Looks like these should be backported to the stable kernels as well so
> > > someone should add:
> > > 
> > > Cc: stable@vger.kernel.org
> > > 
> > > to all patches except possibly the sc8280xp one (that camera clock
> > > controller was added in 6.8-rc1 so that patch does not need it in case
> > > you can these fixes in before 6.8 is released).
> > 
> > You are right maybe, although I did not find strong enough reasons for adding
> > the stable tags.
> > 
> > Only the changes of the gcc-ipq5018 driver has been tested on real hardware the
> > others are not. So those does not fit into the "It must be obviously correct and
> > tested." rule.
> 
> Since this looks like a straight-forward and obviously correct fix for a
> bug which could have bad consequences, not being able to test each patch
> on actual hardware is not a problem.
> 

I agree, and I'm adding the Cc: stable while applying the patches.

Thanks,
Bjorn

