Return-Path: <linux-kernel+bounces-123451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2658908DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE4D1C2B0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF330137930;
	Thu, 28 Mar 2024 19:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsfSL6SA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B03BBC7;
	Thu, 28 Mar 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711652991; cv=none; b=DetpGr+oIdfhkFDhvXEZpuFpCJW3sMbdDVEF4U3WINzUwcqSBHxImHLTDJJfXRSEbuq0fyKyCXImz7sgNEMKg7+30juD2VthheHzFQv8QTufWn8wEWwJBq9tEUErqMsNaKmkj042ByXnSGZm07lG0Mh/bbtJqL6ZC+3+d1HXMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711652991; c=relaxed/simple;
	bh=TMEu0+59Wnpc9lTJ7rgOQpvFhUV4iddHo0yol/6QleA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMW1jYooNU7LFFrZ0gqj1G4UPm0dNMm8sPnMhr7Lg3Z4SPP4O/qmjCX4u71OR2cgcxIPgAujk+39FTDbsu7oTfHe20JQkDItwPQ2Ds72wOfwrvNs3pYVSVihiTIgiFsZGKxP0x0K2CuoWRQMAFUBPSTSAIDeASuVNbyiTZh+DFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsfSL6SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68186C433C7;
	Thu, 28 Mar 2024 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711652990;
	bh=TMEu0+59Wnpc9lTJ7rgOQpvFhUV4iddHo0yol/6QleA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZsfSL6SAEIvmGd/G6gIk+Ub44Yfp4ePHgsHWG1qsAu9ZbVG6Xmfjyk6U3c0EXV8FL
	 7mSv7BrntwCF013gkD26eEd7ViKb1pH9fSBXskn6HuKUH6v0OIMMIvIXDb/zPhSJNP
	 5eNRO0nVVY5VcsqSC0j8fB04JzzCUDgjZC6i/bmcENRjZEld3A5O/pIim/D+45e95j
	 qNk0PoL6pNIZHGed1wtBNs5y51KGT44u+dnDE5Fo2LACwR8cZcWqDEfkZqn0h6eUUy
	 z7Taib4nQOSLuFhFHfz3WF3zpqu/jQnbnPlVOPh0mD4xM8zJYuvL3fWXO3KVrlQjij
	 5DlXvgc0MIzuA==
Date: Fri, 29 Mar 2024 00:39:45 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/2] phy: Add Embedded DisplayPort and
 DisplayPort submodes
Message-ID: <ZgXAec_utD_8yIs4@matsya>
References: <20240324-x1e80100-phy-edp-compatible-refactor-v5-0-a0db5f3150bc@linaro.org>
 <20240324-x1e80100-phy-edp-compatible-refactor-v5-1-a0db5f3150bc@linaro.org>
 <CAA8EJprPgZJ7hZooJEs1ysn2Py=M_rJguuVdXFuBK757q86ZAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprPgZJ7hZooJEs1ysn2Py=M_rJguuVdXFuBK757q86ZAQ@mail.gmail.com>

On 24-03-24, 23:26, Dmitry Baryshkov wrote:
> On Sun, 24 Mar 2024 at 20:50, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > In some cases, a DP PHY needs to be configured to work in eDP mode.
> > So add submodes for both DP and eDP so they can be used by the
> > controllers for specifying the mode the PHY should be configured in.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  include/linux/phy/phy-dp.h | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Vinod, we'd need an immutable branch or a tag for this patch, so that
> we can merge DP changes during this cycle

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy_dp_modes_6.10

for you to fetch changes up to 6078b8ce070cad3f9a8ecfce65d0f6d595494f02:

  phy: qcom: edp: Add set_mode op for configuring eDP/DP submode (2024-03-29 00:30:16 +0530)

----------------------------------------------------------------
phy_dp_modes_6.10

This contains the dp submode definition and associated qcom driver change

----------------------------------------------------------------
Abel Vesa (2):
      phy: Add Embedded DisplayPort and DisplayPort submodes
      phy: qcom: edp: Add set_mode op for configuring eDP/DP submode

 drivers/phy/qualcomm/phy-qcom-edp.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------
 include/linux/phy/phy-dp.h          |  3 +++
 2 files changed, 59 insertions(+), 20 deletions(-)


-- 
~Vinod

