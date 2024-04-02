Return-Path: <linux-kernel+bounces-127907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6789529D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD616B23364
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2076F17;
	Tue,  2 Apr 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcA7VeuH"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AB6A03F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059937; cv=none; b=NJ9Y0TNV4YTZScZGW1v/DrFmR8JJk5/FgwHRQxRqcvMNbfh5ve698w+zKf7QhC+bRZLOiV9DKH0nHKhKj6uESm3CVW8HnZlAWnk7yUA8jvnhm3g5hSuBwNvsQzi2XAtMWjz8ITmECI4vPX+kRZmpJ9uhglGQJ1Q4SffWabTIGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059937; c=relaxed/simple;
	bh=ZU19AXGy1gTKu3ZdKgEYCn04X7EzHEkd9RdcAo9TIfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPTb9cWNeRwfVRX3d9P3igaoHazq7BhOxqAJbx6gXCQBpj+6KKpXmZQjpN8Lz/LJ256SatTEoDXdVnjBO6/UvUYAnNc5BTm+IVzA6efJJqEFWodUJF3PyjFpwukLkqnKlPvmIcNx1wXwRlzGRyfyhIAP0tIPKfEWDuJwmwikDfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AcA7VeuH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc745927098so4770358276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712059935; x=1712664735; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=59+8zgH9nKJkFqI+MIO5KUM5XCs5xUxjBY89iFUie7c=;
        b=AcA7VeuH1lsru5Ic48tq2Mzw+fYeKQfYxFjlYwjbhNZqZiMZrNGnc49AfTH8KtU+0b
         DwDdB06Yx0nGgRNQr+uRvtwU83f8Hp8Q3YDSknC+GKmD/9yb6AB6eCA9x8viSNQueEZt
         uYM8BxMdZSBpD3/RlNksTZVVg7LbwVtnYBUo0fvBEt5o++7H3fmcd2+eG1yPEfDqc7T+
         1a2hctcRPBQCQPZ3M+Mo+QUefjmwhsdkQ3xpeXIZV13P9tReqlvrlhdMvX/0ta0IyCJA
         ipaVJnjftUGu38a9Mzynj+RSBpim/6yNCWqHBf5dNy/Y9Z+t1p63iXWoXgRy1kI0ZPin
         hawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712059935; x=1712664735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59+8zgH9nKJkFqI+MIO5KUM5XCs5xUxjBY89iFUie7c=;
        b=kHdnf8TLSUnR4yLaBaqlVkx3sCpRaOGz9YVcRKhA5/Gy/yRaZ/Bu1eD/dB1nZXAHhQ
         QJNfNi03DN7uEFj0VGdSo5S23O0pHwPugZbt64ktPDza6lR9atKtdHYXEnyf7UBDVPVh
         bXY7X3xtNrNKHzVH1/bME8o7b8AozEHA6XlQ33jmeBVRmInHHCftxKMGEpxFmrDUAvVu
         VWXj9kXd3Fl/4xCwaCOCsdimZhR8NcbB6DyXKc77j/f8Khw9+ajNkBCWgpTjKfrXgMM8
         G5sH+IOtcvmCu9MkNVqZ5/r4P+zwUoJcE+o0st2poRAlZprmM5V6H9AHDC6B3HZxckf3
         OZgg==
X-Forwarded-Encrypted: i=1; AJvYcCV888Un8xTE5Jm2zgB0nDtplqycjiWchiEaawBMx1UJElxQpKAYuIme58vxEVTN2bC6gJiKRR7bbPMwzoSTMrCg7P1OowgJx3gRiAPJ
X-Gm-Message-State: AOJu0YwB2VBdf9D3LKeHQoIgoeyDRwQ0GT+kSa2VDsfL+Sb9gckpvrRG
	7tfko0a5m1o2tw8YU18X6Slz5EfzMoAmxycH/Lyd4sVc2eiDabN4hklFIMogHLWiuEL4KvFYA70
	g/ZPKqNMEfTy0efttakBoza8A6ujfXit4HJqZzA==
X-Google-Smtp-Source: AGHT+IFkuZ7UzLaijf9AS20sbPh65/6NkxIIfNCV/NSfdOu3MxTu2vQNwQDFXF16gKf/9sOjZBiIcPSc2VfwYBA43k4=
X-Received: by 2002:a25:8590:0:b0:dcc:a5dc:e9d6 with SMTP id
 x16-20020a258590000000b00dcca5dce9d6mr10343762ybk.30.1712059935303; Tue, 02
 Apr 2024 05:12:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-4-quic_varada@quicinc.com> <CAA8EJpphk_kqzBE7cKb73ipdpTi29t9ZSOOdSfq7pAGSs5NKeg@mail.gmail.com>
 <CAA8EJpo=TMhu+Te+JE0cQzmjLOTDPi-Vv-h5Bch0Wfr_7iVi2w@mail.gmail.com>
 <ZgvlrbvvPNA6HRiL@hu-varada-blr.qualcomm.com> <CAA8EJpp2dgy0DcLoUuo6gz-8ee0RRwJ_mvCLGDbdvF-gVhREFg@mail.gmail.com>
 <ZgvqkhF2mTG82Rx2@hu-varada-blr.qualcomm.com>
In-Reply-To: <ZgvqkhF2mTG82Rx2@hu-varada-blr.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 15:12:04 +0300
Message-ID: <CAA8EJprN3TuMF-v5PeFW_JUKk+a+MxB7poccZbi9biZNniRnTQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] interconnect: icc-clk: Add devm_icc_clk_register
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 14:23, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> On Tue, Apr 02, 2024 at 02:16:56PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 2 Apr 2024 at 14:02, Varadarajan Narayanan
> > <quic_varada@quicinc.com> wrote:
> > >
> > > On Tue, Apr 02, 2024 at 01:48:08PM +0300, Dmitry Baryshkov wrote:
> > > > On Tue, 2 Apr 2024 at 13:40, Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
> > > > > <quic_varada@quicinc.com> wrote:
> > > > > >
> > > > > > Wrap icc_clk_register to create devm_icc_clk_register to be
> > > > > > able to release the resources properly.
> > > > > >
> > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > ---
> > > > > > v5: Introduced devm_icc_clk_register
> > > > > > ---
> > > > > >  drivers/interconnect/icc-clk.c   | 29 +++++++++++++++++++++++++++++
> > > > > >  include/linux/interconnect-clk.h |  4 ++++
> > > > > >  2 files changed, 33 insertions(+)
> > > > >
> > > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > >
> > > > Wait. Actually,
> > > >
> > > > Unreviewed-by: me
> > > >
> > > > Please return int from devm_icc_clk_register instead of returning the pointer.
> > >
> > > Wouldn't returning int break the general assumption that
> > > devm_foo(), returns the same type as foo(). For example
> > > devm_clk_hw_get_clk and clk_hw_get_clk return struct clk *?
> >
> > Not always. The only reason to return icc_provider was to make it
> > possible to destroy it. With devres-managed function you don't have to
> > do anything.
>
> Ok. Will change as follows
>
>         return prov; -> return PTR_ERR_OR_ZERO(prov);
>

I think the code might become simpler if you first allocate the ICC
provider and then just 'return devm_add_action_or_reset(dev,
your_icc_clk_release, provider)'


-- 
With best wishes
Dmitry

