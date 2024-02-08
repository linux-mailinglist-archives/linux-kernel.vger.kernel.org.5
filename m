Return-Path: <linux-kernel+bounces-57952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A984DF70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9F61F25437
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD16E2D1;
	Thu,  8 Feb 2024 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7t8WJ1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318F149E07;
	Thu,  8 Feb 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390476; cv=none; b=bajKyLd1IORxZIOaX1SyhQ2+yqfPoIyP2e28/d/Iv2CSTIoeOWoS9MGXU9PFoVvZbGp4aUQCjfBhRIMf5PKSihlT9O5+mzPu2J+zr/uEBjNOkLyZNrJgSOJ4Eo7WcXCin01Cjen1nvBsb5+wf+hs1eF9Z9QjL/8IvtVGN7SMOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390476; c=relaxed/simple;
	bh=ujURS2neRaUd5ZKpRM1zlGv0v8GhWHc6x9dflCr5BnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCedLmRPiACj0wcKAlMaQGO109AWmQtdjTKuyW9EweTPa1BqRZZ2VMTmZ1sJnn+IHpxc/diM5RVe/qgDGTQcnzJj+Xoh/QbC58pqqp4m7quT14d5L9gc9sRJVEKGK4H7t4zZwxL2HUWABzGnDjnrSL/FlW/JrLMPs0o9aWMw/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7t8WJ1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004AC433F1;
	Thu,  8 Feb 2024 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707390475;
	bh=ujURS2neRaUd5ZKpRM1zlGv0v8GhWHc6x9dflCr5BnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7t8WJ1SVX8b/ErL8sGqgMl0NlOmUKdepTeR/WlNB/nUPv5Ehlv2fIX2IHn+Xn7P/
	 HR92/QJcYuab6tDlooZ2RHYLBWHq+Y/9CjhfPmuPQTJe8/T4hE3HugdPi5GHWjoZrq
	 Srq/bByKuWynWHiNuTybw+p9qhDw7SHKxGKro8SGXLLWhKawjRHExtDCec++Amhvyk
	 JuvV5w/WHV5ZZ7nU/uggZet/5aptnQ3Q0M5foOeEC9ygRUipd+94K1scUDS8rOGrHg
	 zr2+jYcEL/Wjqg+O5fLk3U8AocUbdY8qNchzieb6h4jlkhb6vJpykjc/EyipPi/cSs
	 gr9nNECQiWjVg==
Date: Thu, 8 Feb 2024 11:07:48 +0000
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
Message-ID: <20240208110748.GJ689448@google.com>
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

Pulled, thanks.

-- 
Lee Jones [李琼斯]

