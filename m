Return-Path: <linux-kernel+bounces-64063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05515853993
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30B7282981
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091B9605C6;
	Tue, 13 Feb 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpaXiTQR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E59605A9;
	Tue, 13 Feb 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847926; cv=none; b=q79Hy4CSTPg0NCcAnxypbV2zw1UjgozCjNEMXJPx/pnnIO2UxgE9RG+lo3Lk6CgqSIRYUShXMWhi1oanl5lWFxTJmzjBcnD8eFA+XKf7BjqxzjD4QC+5MJ+bX4iOz0/t/bj9OgKgnkdK+TeaTDIT38WdogNXbK3LDw5hlCUD5Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847926; c=relaxed/simple;
	bh=iKy4z4zbKIkEBLCIqbOOas6HQLerzLx+0jCCkBHBKZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DbrJ2evyg/xfgSGHgV1cUNjUEby8d6BEKZboE5seiA+zBHovIVGRc25YPfV+wKp0pT3k2IOf1WJNRwv6pwENRFThRmkG0fLqf35KVYgf/5jCvfjdYeoy/D6JUnC4xctbMbXSeP6MsQ3lHi1qK3SBv8iWM489iEqdC5MTFh9WJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpaXiTQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FEBC43399;
	Tue, 13 Feb 2024 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707847925;
	bh=iKy4z4zbKIkEBLCIqbOOas6HQLerzLx+0jCCkBHBKZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VpaXiTQRZg0ZnhTOPSLiTS1eVkEjhPem+tuLW+dpBxbdW1/zwKPLqoD5WcVrKV9GN
	 KAmQnYLIKVPtJ4cVaRg0y3MyYaa/HG7w5plt0NU7g1CrfkjiY5C1vMP+0mlPQI9lbc
	 uCNk4tkjvAtodbZVXzC44ulWdQEC2PdpqUyzjIUfzf3cuO6ddcm/0Yh9e+6gigtUL4
	 yX1S3zHv5DaXqUO5jyldY1ynnS9ao8JpUr8rOwM1oPlf1v6fzC3yZE34/s/TCczVwS
	 cavEw7tRNDQiVG5HPZ9+gTjDiBuv4qYNrBpYdwh+sV+RMREETZiT80tldloTh+H/LY
	 dHqfKk6i/GcIQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso26444361fa.1;
        Tue, 13 Feb 2024 10:12:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcoy0CMjwZYNdrLramCnrNtWb7qQMcFREcQ6Y3L2IibcPmrzAnQI9BUSTJJpDHhVSEOxpGxnOZaT/ndyKmu6yYVb1Zmws3vFWMXW776yU4dGC2007xVBRGZf7bRk8eJPuccVuXdRyG3kWMpOsaZrk6pocdIGuiyRgBlo2GYJLMHzmhlzuKFP+ztsNv4SqbN94ECuw/hSI1KDCfr3y6YtT1hRVZjz1KfwtXgGi7UrO+8txxtPMTRZAp0IISpb4NNgYK
X-Gm-Message-State: AOJu0YzlTxJ9ZSB0K9C56uq5c4j33vw5vIQYC8R477tSNFoC2Of0mRuO
	vQpJDX+068svuqvFjxXgubAehU1mm/+/v+GghhAFV3tNUdp3jd4LnaqKRy+tgMUaLItn5c/3xBt
	RgFJFMQ2laVpwsCh2R6WlG0VsJw==
X-Google-Smtp-Source: AGHT+IFoI2nIw8HIgZSb58YNqQnldThBVqDuYOeRmmQBRueJPhHiaK9E85g01QPZR04/VBn2+u4CxK0TcwjK6Jta0Xg=
X-Received: by 2002:a05:651c:b07:b0:2d1:1440:56f0 with SMTP id
 b7-20020a05651c0b0700b002d1144056f0mr30600ljr.15.1707847923891; Tue, 13 Feb
 2024 10:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-sm7125-upstream-v4-0-f7d1212c8ebb@gmail.com>
 <20240121-sm7125-upstream-v4-2-f7d1212c8ebb@gmail.com> <20240212222232.GB2655166-robh@kernel.org>
 <CAA8EJpoymmOBc3CfNHJKBT8BNje_s2a5uGPde3QHYv3vQ97=-Q@mail.gmail.com>
In-Reply-To: <CAA8EJpoymmOBc3CfNHJKBT8BNje_s2a5uGPde3QHYv3vQ97=-Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 13 Feb 2024 18:11:50 +0000
X-Gmail-Original-Message-ID: <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
Message-ID: <CAL_JsqLGVBjiYt5tG0GFxxeHmNDD1PgJx3ab-n2x0nHPEaX9iQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: ufs: qcom: Add SC7180 compatible string
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: David Wronek <davidwronek@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
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

On Tue, Feb 13, 2024 at 4:30=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 13 Feb 2024 at 00:22, Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Jan 21, 2024 at 05:57:42PM +0100, David Wronek wrote:
> > > Document the compatible for the UFS found on SC7180.
> > >
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Signed-off-by: David Wronek <davidwronek@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> > >  1 file changed, 2 insertions(+)
> >
> > Should have been picked up by SCSI/UFS maintainers, but it
> > hasn't, so I applied it.
>
> And it now triggers schema warnings, because sc7180-ufshc has 7 clocks
> and 1 reg entries.

And now dropped... Perhaps the dts changes should be too.

Maybe QCom maintainers should require a report of dtbs_check on new
boards. My comparisons of Linus vs. next warnings often show an
increase in QCom warnings. Like right now:

linus: arch/arm64/boot/dts/qcom:1990:265
next: arch/arm64/boot/dts/qcom:1610:298

First number is total warnings. Second number is unique warnings
(stripping dtb name). Some of this is just mismatch between schemas
and dts changes showing up in next, but it doesn't tend to go to 0 as
the merge window approaches. I've seen this several cycles. All the
data is available from my CI jobs, and I regularly look at the diff
with this:

$ less ~/bin/gl-diff-dtb-warnings
#!/bin/sh

[ -z "$1" ] && { echo "Missing arch!"; exit 1; }

arch=3D"$1"

job=3D"job-dtbs-check"
logfile=3D"platform-warnings.log"

# url <branch> <arch>
url() {
        local branch=3D"$1"
        local arch=3D"$2"
        echo "https://gitlab.com/robherring/linux-dt/-/jobs/artifacts/${bra=
nch}/raw/${logfile}?job=3D${job}%3A+%5B${arch}%5D"

}

curl -Ls -o orig.log $(url linus ${arch})
curl -Ls -o next.log $(url next ${arch})
meld orig.log next.log

