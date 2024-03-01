Return-Path: <linux-kernel+bounces-88531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52986E2F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284962825B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996FD6EEEB;
	Fri,  1 Mar 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQHJigX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73016E60C;
	Fri,  1 Mar 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301784; cv=none; b=FkY8/jxLDYDS60L3/+mF7opqyTC8euBMNhaxVXPB1q0t2ZNdgiaB2Q9E4LbyvvHhLuZeXxYavk+sOHRvuRlFY6TiB6XzHZrqS6Zv/p0tEThpkK8OMt887qUKJd34uddLh8HLJk4oh+6eUp97dD/rAoSrahrZ3rJndYcmf0wyMcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301784; c=relaxed/simple;
	bh=0zgjWQSZJu5FIVJHU/jQgShZVUpbLN0aAKYRK+7+DyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNAH9iDhl8Bx/uZnPiGPn8ztqDLX43PSlLBIJQwz0kqxN1W43jNmK1qXs5jYajk98wr/6rNx7F+HtIbyOzOxJEtk4OVaZlT2A5vPAyDvipHCE6OCIinIwZMe4QOB6c3yfbeytQA1dsUeMYK1NerdrzMrdb14nrJ4nwnhonrgqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQHJigX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D61AC433F1;
	Fri,  1 Mar 2024 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709301783;
	bh=0zgjWQSZJu5FIVJHU/jQgShZVUpbLN0aAKYRK+7+DyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQHJigX/2HJz/xIXEi3vh311K81ea1fNXH82TV47vNBN5vfvLalJkPJwkJ3Oe7doH
	 xnGMuoNjs98iO3V2VBfhe10MpB6eraCKKII1WeeNoiiJvjHdmgU3HjU3dCwZqJcnAf
	 Hnbsjh64tErTWssu9pgT3ACEsQc2pQ71rCHWFhqPCAaE+S/mN9sioiAirOPR2PxKqj
	 PjDP+X2HGeR+5+Rn2dr9oux5eRYvubutmAX0Q3ZbIAPORacEvZuI3j/9OSk05G+EL9
	 hwlhNLfIKrr2TA0D7q+GomqVNSk+W095TcB2fOqhj4ZqhGJLwjf1zLS7O8ZgI/64yR
	 3Cuy4au7n2qgQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg3Tn-000000001Qd-0bmX;
	Fri, 01 Mar 2024 15:03:15 +0100
Date: Fri, 1 Mar 2024 15:03:15 +0100
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
Message-ID: <ZeHgI2nsADrkecC8@hovoldconsulting.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
 <20240229-freq-table-terminator-v1-1-074334f0905c@gmail.com>
 <ZeGic5cG8lneKJXp@hovoldconsulting.com>
 <91b36da5-637d-4156-8be4-5aed55fc3c5d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91b36da5-637d-4156-8be4-5aed55fc3c5d@gmail.com>

On Fri, Mar 01, 2024 at 02:37:01PM +0100, Gabor Juhos wrote:
> Hi Johan,
> 
> 2024. 03. 01. 10:40 keltezéssel, Johan Hovold írta:
> > On Thu, Feb 29, 2024 at 07:07:46PM +0100, Gabor Juhos wrote:
> >> The frequency table arrays are supposed to be terminated with an
> >> empty element. Add such entry to the end of the arrays where it
> >> is missing in order to avoid possible out-of-bound access when
> >> the table is traversed by functions like qcom_find_freq() or
> >> qcom_find_freq_floor().
> >>
> >> Fixes: e3fdbef1bab8 ("clk: qcom: Add Global Clock controller (GCC) driver for IPQ5018")
> > 
> > Good find!
> > 
> > Looks like these should be backported to the stable kernels as well so
> > someone should add:
> > 
> > Cc: stable@vger.kernel.org
> > 
> > to all patches except possibly the sc8280xp one (that camera clock
> > controller was added in 6.8-rc1 so that patch does not need it in case
> > you can these fixes in before 6.8 is released).
> 
> You are right maybe, although I did not find strong enough reasons for adding
> the stable tags.
> 
> Only the changes of the gcc-ipq5018 driver has been tested on real hardware the
> others are not. So those does not fit into the "It must be obviously correct and
> tested." rule.

Since this looks like a straight-forward and obviously correct fix for a
bug which could have bad consequences, not being able to test each patch
on actual hardware is not a problem.

Johan

