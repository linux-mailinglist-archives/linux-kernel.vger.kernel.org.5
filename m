Return-Path: <linux-kernel+bounces-6547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065FB819A34
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386101C222F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11B718E3F;
	Wed, 20 Dec 2023 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unId8uUO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159661CA8E;
	Wed, 20 Dec 2023 08:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A21BC433C7;
	Wed, 20 Dec 2023 08:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703059962;
	bh=BHRiKQEvoPIgw/Ei788HQtUg9h30YDWszt+pYb2kLqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unId8uUOjR9Qvz0tGmgTzCv8tRcQNsP1sTPJ6jq8l85UCjPAkC59QC1JqJNyf5xEr
	 FWoJceorXNGzjFDeGhSoMdJEFoL9YddSutqAMNTobs7zH7Q/RR9aE2fhCQQL+rl/ag
	 IUMvq7dO7VLLHLXoE0568+k3Uc/1XW8BLmNpMK2j9c7VR3EM/WJEuyK4XiFht0O7d+
	 yDGLhwoeBhinZG+5c6IWIBW44YPfVFp9bP8VwlKkXq3VnB9SgvVr5KuBIiap02Sicy
	 egd36i3OHruOWZlTK3bBgSVKFf8IU1Ew0kLrq9LDCnCTvWPyXiO7dK2Eix9juwvYVD
	 nn+xTYZKR/cig==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFrh2-0000pH-1C;
	Wed, 20 Dec 2023 09:12:40 +0100
Date: Wed, 20 Dec 2023 09:12:40 +0100
From: Johan Hovold <johan@kernel.org>
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: phone-devel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Martin Botka <martin.botka@somainline.org>,
	Jami Kettunen <jami.kettunen@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] leds: ledtrig-pattern: Use last_repeat when
 applying hw pattern
Message-ID: <ZYKh-F-1psKpm1JA@hovoldconsulting.com>
References: <20220719213034.1664056-1-marijn.suijten@somainline.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719213034.1664056-1-marijn.suijten@somainline.org>

On Tue, Jul 19, 2022 at 11:30:33PM +0200, Marijn Suijten wrote:
> `last_repeat` holds the actual value requested by the user whereas
> `repeat` is a software iteration variable that is unused in hardware
> patterns.
> 
> Furthermore `last_repeat` is the field returned to the user when reading
> the `repeat` sysfs property.  This field is initialized to `-1` which is
> - together with `1` - the only valid value in the upcoming Qualcomm LPG
> driver.  It is thus unexpected when `repeat` with an initialization
> value of `0` is passed into the the driver, when the sysfs property
> clearly presents a value of `-1`.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Looks correct to me:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

