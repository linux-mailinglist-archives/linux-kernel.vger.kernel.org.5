Return-Path: <linux-kernel+bounces-49854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F4F84708A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E28B240F8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5945B1FCA;
	Fri,  2 Feb 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exJwTRay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AF17E1;
	Fri,  2 Feb 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877801; cv=none; b=TfXQYYF+ddcvj11f3LpiH205Ca33ZpOBRqTB7kKcLobbxN1TkRlvHaqjQEqJaOw45ypsJlgQpHizNkAHGrKNdp8vGjSBsGIxDcVZNSG/rh/PfKp4DIQ877fcqg3G4PwmDMMWJcxmlSut1zOx3DZB+eQ78COm0+m5EffF2yGoOcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877801; c=relaxed/simple;
	bh=FxMD+SzcZbcxoJzxVHTVVUD+rGEixm5Ui8tDKJG2+PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUsOiVSnGvvvwM6dGsA1SlyCNHt05x3k47O3Ot1buhB1EKy8OjlHRRNe/LlPV8FMRil2H3z2Csmh47L62kIKvcLLNZh0GDHZPukjWZN+2ygurNwMdoKkEXqbfW8PYmj2Ensc586t4TxTgGJ5RC+4abB4b77vmHiT6d+zJTyQkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exJwTRay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAD9C433C7;
	Fri,  2 Feb 2024 12:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877801;
	bh=FxMD+SzcZbcxoJzxVHTVVUD+rGEixm5Ui8tDKJG2+PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exJwTRay0Nes53dtalL1y2sMLtxvzyhURVm6EmfwghTJH716UbskcT0OHWY0Ihp5n
	 qS2jxO1phSrgmYkLNq9fMF1JJuYUheVyJsQywhD/VartAAt6U6dZLrfiXmPpJPnn+M
	 lpbFThhZ0VopxB4tUU1L9vxSq6ZmsBeMgKJCMFZXspDWx+RZFepCwtjCo6q9FLSl4O
	 QIjkFz/ibmltiLaGTzJJeD8G45egtVl9RJ6zzjpwXcB18WRBZ+bzRUlYZeL1RdDuOX
	 4XPydusYae0rLw8XeFHPtem/JuAjVO4IBEF0PEDSjYg24WjVzGW2p2Zk2LLkpNj6dt
	 fqWAcNbQeL50A==
Date: Fri, 2 Feb 2024 12:43:14 +0000
From: Lee Jones <lee@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
	thierry.reding@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, luca.weiss@fairphone.com,
	konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
	quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: Re: [PATCH v8 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <20240202124314.GD1379817@google.com>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <20231221185838.28440-4-quic_amelende@quicinc.com>
 <ut6jbawqqdgfyoxmt76hm67rbnv67x54eho3nae2dd2szbejfb@7joy57g4i3qt>
 <20240131085842.GF8551@google.com>
 <kfs2nkkrwsa2enz67vfb5nenv2obzuomekqjdzaksldd75lows@3mcfd2r55fc3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kfs2nkkrwsa2enz67vfb5nenv2obzuomekqjdzaksldd75lows@3mcfd2r55fc3>

On Thu, 01 Feb 2024, Bjorn Andersson wrote:

> On Wed, Jan 31, 2024 at 08:58:42AM +0000, Lee Jones wrote:
> > Intentional generic top-post reply.
> > 
> > Please work quickly to resolve Bjorn's comments.
> > 
> > I'm being hounded over a broken LEDs tree due to the missing headerfile.
> > 
> 
> I've merged the updated patches into the qcom tree.
> 
> I presume though that you'd like to have this build issue resolved in
> your tree as well. Please feel free to pull the branch:
> 
> 20240201204421.16992-2-quic_amelende@quicinc.com (5b2dd77be1d85ac3a8be3749f5605bf0830e2998)
> 
> from https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git

Great, thanks.

-- 
Lee Jones [李琼斯]

