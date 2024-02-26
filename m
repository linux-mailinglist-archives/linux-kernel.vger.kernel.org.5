Return-Path: <linux-kernel+bounces-82231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8BD8680DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86336297667
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA412FB25;
	Mon, 26 Feb 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXAmNPaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59E22069;
	Mon, 26 Feb 2024 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975350; cv=none; b=HLqbaL9AJyKkkViul0wUsMUjTu3X9jKgvKeKp7omonSOChTPbHXLZtZOq5fE20iRXF6ZugkdRxx2FrRZRF5j66dl6OmtbL8VoGZ+t78fuS+5sXJV4uIOOiiPWrGt0kBL+u0bsVT+kWyekebqI7NIzUFJBw0lOwoj9ttgzLxLAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975350; c=relaxed/simple;
	bh=uzYDC3PkR80LhMG2R+USCB1BJyZffPH+9Bnan3Tu8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgTbUSu1Kn56Hh0ffLinzxWl36TtHOM5XFwi0C6fMGzl/VNBmIywC8tDoV22l505auHri92mSnDY47TgdMusaHT4CbckZuDLsl5TkgUdmJhlpyqDNCrmIEoiWdeHE8LRRLESJcm9vIahAKy8ecWdPyjejOzTPCWgGJnOqJo66E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXAmNPaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63742C433F1;
	Mon, 26 Feb 2024 19:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975350;
	bh=uzYDC3PkR80LhMG2R+USCB1BJyZffPH+9Bnan3Tu8O8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXAmNPawBHwE0OWHHXcTAEzMRYTtG7VFX94c7mvMgP1XnzOHKjtj7cQScgNu4eAwS
	 LziM/qxkmh4mrZUIE9ykVl04O7pSIKZj0lJ0sfFV8PjD6PLNn8t1hHZBLyaSMqEJvo
	 b7SqV7eT/2AKaOMSckXF8bpJf06VnwcYftZ2Euc6BrEhTXBY/Bqb5BlUfU2V2e3Z6X
	 cRO6u1gIbNmXoc+qJYGjYDjo5Wkw9smivgplHDxoRnKBgPN8wzCC8iX4wnaDw+lz6F
	 Q5eXoU3XDuoF43wWwB2Jpv7hBOQ5aMJd0XafoPWy6TMBVO0OFxlHFNYuSXGHr7uqeh
	 3EmGxFtG1j5qw==
Date: Mon, 26 Feb 2024 19:22:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: drop unused kerneldoc
 struct pm8xxx_chan_info member
Message-ID: <20240226192214.61fbdf74@jic23-huawei>
In-Reply-To: <CAA8EJppAKRiSoHi3icFymSQjP-TQrOF2LcMEnE=BmK+=nv330w@mail.gmail.com>
References: <20240225202744.60500-1-krzysztof.kozlowski@linaro.org>
	<CAA8EJppAKRiSoHi3icFymSQjP-TQrOF2LcMEnE=BmK+=nv330w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 22:46:30 +0200
Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:

> On Sun, 25 Feb 2024 at 22:27, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > Drop description of non-existing 'struct pm8xxx_chan_info' member:
> >
> >   qcom-pm8xxx-xoadc.c:386: warning: Excess struct member 'scale_fn_type' description in 'pm8xxx_chan_info'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  drivers/iio/adc/qcom-pm8xxx-xoadc.c | 1 -
> >  1 file changed, 1 deletion(-)  
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> 

Applied. Thanks

J

