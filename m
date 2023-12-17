Return-Path: <linux-kernel+bounces-2672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC35816043
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB81D1C21BB7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F0645974;
	Sun, 17 Dec 2023 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-watchdog.org header.i=@linux-watchdog.org header.b="A5nmn24K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4844C88;
	Sun, 17 Dec 2023 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=linux-watchdog.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux-watchdog.org
Received: by www.linux-watchdog.org (Postfix, from userid 500)
	id AE07240A00; Sun, 17 Dec 2023 16:33:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org AE07240A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
	s=odk20180602; t=1702827198;
	bh=+l0EOLKa0Bl3ZTWz3jGKaliU0ki9maj1BDrJAnID99w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5nmn24KcJNSDhVfY9QidGiyMapfWTt138hl4+Oj//u0GhFO0wjHMJ3zVi0sUypae
	 w7RC7V1Xl+ZjfbhpSVFKJdbQ3yfmIXDjEiH+W7ugZvdBMqRMvqtqZeYsvlT3u8fsA0
	 JmnVrAAgFogL1Jj9qDNW6hJhRh2kFdRO7x3Oat7M=
Date: Sun, 17 Dec 2023 16:33:18 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, swboyd@chromium.org,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] dt-bindings: watchdog: qcom-wdt: Make the
 interrupt example edge triggered
Message-ID: <20231217153318.GA6196@www.linux-watchdog.org>
References: <20231106144335.v2.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <20231106144335.v2.9.Ie30c1d3f780666f6906fd2fd7c437632c229d987@changeid>
 <CAD=FV=XsPGvNggpJPCpF=xhkm3dOHsStycZvuVttA=ZH6=EUmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XsPGvNggpJPCpF=xhkm3dOHsStycZvuVttA=ZH6=EUmw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)

Hi Doug,

> Hi,
> 
> On Mon, Nov 6, 2023 at 2:44 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > As described in the patch ("arm64: dts: qcom: sc7180: Make watchdog
> > bark interrupt edge triggered"), the Qualcomm watchdog timer's bark
> > interrupt should be configured as edge triggered.
> >
> > Update the example in the bindings.
> >
> > Fixes: 7c631cdff391 ("dt-bindings: watchdog: qcom-wdt: allow interrupts")
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I saw Bjorn landed all of the dts patches from this series but it
> looks like the bindings patch got left behind. Anyone want to claim it
> for their tree, or Ack it saying that you'd prefer for it to go
> through someone else's tree? I assume Krzysztof's Ack means he's not
> intending for it to go through the DT tree and Bjorn doesn't seem to
> intend for it to go through the Qualcomm tree. Guenter/Wim: it feels
> like this could go in the watchdog tree?

I picked it up in the watchdog tree.

Kind regards,
Wim.


