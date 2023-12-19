Return-Path: <linux-kernel+bounces-4971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4265818484
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64779286BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1245C13FED;
	Tue, 19 Dec 2023 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diJ/hkN6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9C715483;
	Tue, 19 Dec 2023 09:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF84AC433C7;
	Tue, 19 Dec 2023 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702978408;
	bh=U0si4BVeCSiJQq+SvPLzBPq/0rnWVdMAwb6silgvIMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diJ/hkN62P4qdzRr/wU5FdQDJepCKZeR/rHZf26elSqu+g0nrWZ5YpW68h7meJo11
	 wsqkwkACqD5U16QYQY2hhduaS85Z2Yj+IUHM9G4AOjFmoHjHEXnuyY3Gd/AxttsRAK
	 b42v5Rg4GXubUUtAERAlGUVMk3YNuXzq30zK5sHptf4rZS+CWI4Lnc0QFeHZr7go3E
	 MVfUYGEbhWI8mITjdn4pYxpKT6AtwP0TuZ58quqAwK/cLgoUnLvGPdaOaGMpdiFddT
	 tvcA6h1w+8W2X8NNJ4RcgpdBKGxMbZ3xefiK8ujYs1ACHCBWhQC0ayCBYS8y3JKk6p
	 8fOyIUXPGayAg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFWTd-0007F4-1l;
	Tue, 19 Dec 2023 10:33:25 +0100
Date: Tue, 19 Dec 2023 10:33:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Lee Jones <lee@kernel.org>, phone-devel@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH v4 2/2] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <ZYFjZefdJej_vgwD@hovoldconsulting.com>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
 <20220719211848.1653920-2-marijn.suijten@somainline.org>
 <ZYFS04cznE5bhOeV@hovoldconsulting.com>
 <3lsapoxlqijes5m4nqcbhdfhhs4chq3mcq3jaty7v2zihsqnwu@nn67a4h6425k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3lsapoxlqijes5m4nqcbhdfhhs4chq3mcq3jaty7v2zihsqnwu@nn67a4h6425k>

On Tue, Dec 19, 2023 at 10:17:16AM +0100, Marijn Suijten wrote:

> Note that I have one more unmerged leds patch around, that hasn't been looked
> at either.  Would it help to send this once again, perhaps with more reviewers/
> testing (Johan, would you mind taking a look too)?
> 
> https://lore.kernel.org/linux-leds/20220719213034.1664056-1-marijn.suijten@somainline.org/

Yes, I suggest you resend that one too so that it ends up in Lee's
inbox.

Johan

