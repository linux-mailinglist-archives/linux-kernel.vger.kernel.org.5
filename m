Return-Path: <linux-kernel+bounces-6542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024F819A24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D2D1C2579B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BD21A723;
	Wed, 20 Dec 2023 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCwELj+1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F81C69D;
	Wed, 20 Dec 2023 08:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F31DC433C8;
	Wed, 20 Dec 2023 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703059801;
	bh=C/bmxBnTXGzZ1vjtmSYYuEX2ZVG/w7ytPsXTwf5j/S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCwELj+19lZxVgrIZLX+EQptxFmWECHHiOXtNEShl+yXmtQ0b+WmPOTg9wtRPwbOs
	 sYowz0It0lgncI0jceH2ZJCij97kt/JqQyqOFH8kQSX82rLEL7Xg9vGHPZ7FqD4xA4
	 JZ5/DVFeDCU3wPBXTxWrM6VsJhCZYHxi6I8BLrjnLPISs6EKWkUfLKsJyGbRYH80Oo
	 NDiJKGc4ppCPsCaXRtF1n0+Aje9IeaOwTmka7hp4BzeH601/DOyRbcIjj211Yy2ebO
	 M0JJigKSK3z0FdXnsb5Owp9WprZQ8nCgFpbt/Hc113k+Y4STJPeZS7RhzvggCJPTIz
	 AzzyCX0HU0knw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFreQ-0000nD-1l;
	Wed, 20 Dec 2023 09:09:59 +0100
Date: Wed, 20 Dec 2023 09:09:58 +0100
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
	Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Satya Priya <quic_c_skakit@quicinc.com>
Subject: Re: [PATCH v4 2/2] leds: qcom-lpg: Add PM660L configuration and
 compatible
Message-ID: <ZYKhVlgrlvq3HbFt@hovoldconsulting.com>
References: <20220719211848.1653920-1-marijn.suijten@somainline.org>
 <20220719211848.1653920-2-marijn.suijten@somainline.org>
 <ZYFS04cznE5bhOeV@hovoldconsulting.com>
 <3lsapoxlqijes5m4nqcbhdfhhs4chq3mcq3jaty7v2zihsqnwu@nn67a4h6425k>
 <ZYFjZefdJej_vgwD@hovoldconsulting.com>
 <xkmmbgbg2japfunuure2kktbxdkotteawwgzsjq6giafmwuosz@3no7qov5nzei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xkmmbgbg2japfunuure2kktbxdkotteawwgzsjq6giafmwuosz@3no7qov5nzei>

On Tue, Dec 19, 2023 at 11:06:08AM +0100, Marijn Suijten wrote:
> On 2023-12-19 10:33:25, Johan Hovold wrote:
> > On Tue, Dec 19, 2023 at 10:17:16AM +0100, Marijn Suijten wrote:
> > 
> > > Note that I have one more unmerged leds patch around, that hasn't been looked
> > > at either.  Would it help to send this once again, perhaps with more reviewers/
> > > testing (Johan, would you mind taking a look too)?
> > > 
> > > https://lore.kernel.org/linux-leds/20220719213034.1664056-1-marijn.suijten@somainline.org/
> > 
> > Yes, I suggest you resend that one too so that it ends up in Lee's
> > inbox.
> 
> I will rebase, test and resend it too.  Just asking if you notice any glaring
> issues with this patch, as it won't be the first time it has been resent after
> not being looked at for some time.

I haven't look at this code before and only skimmed it now, but your
patch looks correct to me.

Johan

