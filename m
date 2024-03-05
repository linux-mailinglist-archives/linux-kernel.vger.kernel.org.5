Return-Path: <linux-kernel+bounces-92856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98AB872702
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4817282F92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30E3FE24;
	Tue,  5 Mar 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR0Eeyjp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7381B957;
	Tue,  5 Mar 2024 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664816; cv=none; b=puND4GPBe5aTJWnkSskAt9FzPYnDb1p+vE16DwxviMmg1I7gjJBl7efEfOPhjHJxc41aXr3SzwO9NNDRrYeql32FEeYmXIVWksm+aQrngy9VeYd79DK8fP6zDLFEy6iuaKtq2GH7bSs6lmwi9qJXhNtQdLUXt0Dg8tnpGUYwz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664816; c=relaxed/simple;
	bh=UxSg3J7pmXgouiW5qzsuGHpZBdYmHL4bL7FyvyMHf+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlfNDkuxZS5yfGzVWiV6/+JgjqsYMCyRSb7M8C/uk4AgWQJoIL1B3fFOknn1l/+9WyTTbCq8EoBQXuo7fCPdjPUHOg3UsvCa6uE2K/cYveXPci9f0zzC6OMOMSJDGwXi6QBcVRn4QGy9rlUG+lv1vhItd6eZZp6eWSF3pzZfOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR0Eeyjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390B3C43601;
	Tue,  5 Mar 2024 18:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664816;
	bh=UxSg3J7pmXgouiW5qzsuGHpZBdYmHL4bL7FyvyMHf+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VR0Eeyjp/78+DsOUI5efdN9B5bRcF6HFxoyvC5bWeVElq/VWUrAW0m3CZKkWd+/7m
	 EWOsjMwJjrbelAFQUOJd4gCQmEYpb8qQ9o6GAEuNUC4gFQSvpshLsHCOHWJnfuabzm
	 09ANuKESfkHOchOjLYVen0ph1WGHj6dRrgJfEcADIWSzTdYzj95l1MFd+dM71Lnert
	 5UuVIzk/H2GE0K6qCuwKYph1b0GYbZiDzD55PIfVSD2Q6I9awi3YtDqTplCIGvB3C1
	 qCE1U07l+G7WGbfteb5WeCDHyxuR1JjmfzFZTmAwysC+rzXhrRdFSvTrvdqsKZAPpQ
	 aT7NxkPqiKRMw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d309a23d76so496691fa.1;
        Tue, 05 Mar 2024 10:53:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWyTkNS4fgL/XwUPQNXbZuW2tUyJugvB98cJOC1RPXO4sMCq6WsuVL653k7wEV2XOOPC5JeyArt3XmpiC9Icmqpz223swFBeY6ZjtCTADSxbbvbu0HCkDDq5ew9AK8pFj/O7QBGvCAASTJOk+31wgEaevBD41P1rQZdc+kO0cjt0y9DAm8TJNAZHL4TGyCMIvwc6x0e/fdKRwaLD9YnDrnVEHEc8OpPkApA5Apt4Px2WCpUZQskiECuXSNDCPVLcEo
X-Gm-Message-State: AOJu0YzRssHPDILbq6mTXwSdr5hwY3RePeXdNy081lFzXiYQjpr22LV1
	kg9A+AWxu1d2q/pJyuja7xjfEjbwJM6irLN7ncKm9Rqd/Q7JNccyR7QdRMDboFpsB5JZft90Je+
	eqCaYmBTM6ea8VU3ucjrtBjOcBg==
X-Google-Smtp-Source: AGHT+IEU/KBPArFsCWKj4b5nW5QhpIEG3gfe02KIC5UhsfknOlWHT6QJ/okiHavM97I63ii3T7OjJZvBcaAb43h3RQs=
X-Received: by 2002:a2e:91d8:0:b0:2d3:9cc2:fca4 with SMTP id
 u24-20020a2e91d8000000b002d39cc2fca4mr971547ljg.15.1709664814125; Tue, 05 Mar
 2024 10:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com> <20240212222232.GB2655166-robh@kernel.org>
 <CAA8EJpoymmOBc3CfNHJKBT8BNje_s2a5uGPde3QHYv3vQ97=-Q@mail.gmail.com> <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 5 Mar 2024 12:53:21 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+wdu20iU5c-j6-V61nm6zuBOfDDqGdunjaGQLbc9BRmA@mail.gmail.com>
Message-ID: <CAL_Jsq+wdu20iU5c-j6-V61nm6zuBOfDDqGdunjaGQLbc9BRmA@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible string
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, David Wronek <davidwronek@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-phy@lists.infradead.org, ~postmarketos/upstreaming@lists.sr.ht, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 12:11=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Feb 13, 2024 at 4:30=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Tue, 13 Feb 2024 at 00:22, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Jan 21, 2024 at 05:57:42PM +0100, David Wronek wrote:
> > > > Document the compatible for the UFS found on SC7180.
> > > >
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Signed-off-by: David Wronek <davidwronek@gmail.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > Should have been picked up by SCSI/UFS maintainers, but it
> > > hasn't, so I applied it.
> >
> > And it now triggers schema warnings, because sc7180-ufshc has 7 clocks
> > and 1 reg entries.
>
> And now dropped... Perhaps the dts changes should be too.
>
> Maybe QCom maintainers should require a report of dtbs_check on new
> boards. My comparisons of Linus vs. next warnings often show an
> increase in QCom warnings. Like right now:
>
> linus: arch/arm64/boot/dts/qcom:1990:265
> next: arch/arm64/boot/dts/qcom:1610:298

Still a bunch of warnings in next. This binding should be resubmitted
with fixes or the dts changes dropped.

Rob

