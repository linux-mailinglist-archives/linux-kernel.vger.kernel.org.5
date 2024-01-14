Return-Path: <linux-kernel+bounces-25400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E282CFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655511C20F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 04:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FB1851;
	Sun, 14 Jan 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eN5vLx0x"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB571848
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3606f3f2f37so43441945ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705208047; x=1705812847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+nZpplFtDyf9HT1zuGlQzwp4NeGzUTTxIdAtIlnQho=;
        b=eN5vLx0xFlf8aQCdtCJcASa/ESbcoLEhN6GmMAsGdJO3RfT57aAlOQNod61wMFIgLs
         2HxJMSahpFWteD5diI7fdkogz0UV5x6UXKocpslVAB0hMXc2jjQs6ZIyCF5t1OYS8k7k
         +jDzI4Ty6nsW7ms/WpGEBzP9frn/C5zGYhF8al5TaaYJxR5LQ/zGwBsrVM+V4PGh0njR
         jkY3VN3v1yxLb0aS1ViotacMHOqvALbJdNDYkvM9FZaIMOh8lObmm9DW1VnoCGSGKBAa
         ZZk3Id5Nd2PGRoWCotAGC+E9YKdsOhXYuk2Yf+AwBah/r4SHUFPz2IfRi+a+Q5i5+LFt
         HzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705208047; x=1705812847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+nZpplFtDyf9HT1zuGlQzwp4NeGzUTTxIdAtIlnQho=;
        b=TD+bAsvQRHsQhpggb+P+UE40OLYKkp+CPWZrXWPDadawhC/fnxW2NhrHirbthGC96k
         yN0XpEddqCxNbRUDAUUtqlYJYqhxkD6KtKNAobLPWh/F0gbLlrEOeyp30SxlC0ZC5sps
         RkgvsXp8zYP39r3xeBvMnCwGQU/Rjoa/LkS92qhQy6DFQ8NzYnNwqYkEMAXkxrkuOnVt
         eetYBSSBosnYVz/3JZN721g3MUtD+8hrUolCHNcO346rxlQTZi7fqRFkCzJrSvH1IDgB
         vdAJf9zQZggFMD+4MrZr9dl885NpTVmZp1n3nDjZiLCcxZYJtlB9WXQRvhMp0Li9dy0r
         0DGw==
X-Gm-Message-State: AOJu0YxV/UpDdGY4e58rxa0+kLzi9/2CqWhQXm6+OII7Fm2wMViQSf79
	vAKFvaDT/uDkmZw2/ls9epv6mN7b1apH8EJdWzH74SRPY852iQ==
X-Google-Smtp-Source: AGHT+IEBDEYpuSs+yR1gLtlKicR6M8ikYIvpUonqJtgtPwzyhoOZ622GCEj8y7gg+8KQwltDBVsrLZorHExb5WkFaoY=
X-Received: by 2002:a92:d410:0:b0:360:97d9:309f with SMTP id
 q16-20020a92d410000000b0036097d9309fmr3388713ilm.5.1705208047302; Sat, 13 Jan
 2024 20:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 14 Jan 2024 06:53:56 +0200
Message-ID: <CAA8EJppjxT=qri+bhfa=DbX09aCiFVp0vO3P0OD=TNiYJAd1-g@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] Unregister critical branch clocks + some RPM
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jan 2024 at 16:51, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On Qualcomm SoCs, certain branch clocks either need to be always-on, or
> should be if you're interested in touching some part of the hardware.
>
> Using CLK_IS_CRITICAL for this purpose sounds like a genius idea,
> however that messes with the runtime pm handling - if a clock is
> marked as such, the clock controller device will never enter the
> "suspended" state, leaving the associated resources online, which in
> turn breaks SoC-wide suspend.
>
> This series aims to solve that on a couple SoCs that I could test the
> changes on and it sprinkles some runtime pm enablement atop these drivers.

Probably it is out of scope for this
I wonder if it makes sense to route (some) of the clocks properly.
Should we use GCC_foo_SLEEEP_CLK as a sleep clock for the
corresponding device?
I'm not sure about the AHB and XO clocks.

Another question is regarding the suspended state. Wouldn't leaving
GCC_foo_XO clocks enabled keep the XO enabled as well?

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v6:
> - Rebase (next-20240112)
> - Reorder qcom_branch_set_clk_en calls by register in "*: Unregister
>   critical clocks" (Johan)
> - Pick up tags
> - Link to v5: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org
>
> Changes in v5:
> - Change the "Keep the critical clocks always-on" comment to "Keep
>   some clocks always-on"
> - Add the same comment to commits unregistering clocks on 6115/6375/2290
> - Link to v4: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org
>
> Changes in v4:
> - Add and unify the "/* Keep the critical clocks always-on */" comment
> - Rebase (next-20231222), also include 8650, X1E and 8280camcc drivers
> - Drop enabling runtime PM on GCC
> - Improve the commit message of "clk: qcom: gpucc-sm6115: Add runtime PM"
> - Link to v3: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org
>
> Changes in v3:
> - Rebase (next-20231219)
> - Fix up a copypaste mistake in "gcc-sm6375: Unregister critical clocks" (bod)
> - Pick up tags
> - Link to v2: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org
>
> Changes in v2:
> - Rebase
> - Pick up tags
> - Fix up missing pm_runtime_put in SM6375 GCC (Johan)
> - Clarify the commit message of "Add runtime PM" commits (Johan)
> - "GPU_CCC" -> "GPU_CC" (oops)
> - Rebase atop next-20231129
>   - Also fix up camcc-sm8550 & gcc-sm4450
>   - Unify and clean up the comment style
>   - Fix missing comments in gcc-sc7180..
>   - Drop Johan's ack from "clk: qcom: Use qcom_branch_set_clk_en()"
> - Improve 6115 dt patch commit message (Bjorn)
> - Link to v1: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org
>
> ---
> Konrad Dybcio (12):
>       clk: qcom: branch: Add a helper for setting the enable bit
>       clk: qcom: Use qcom_branch_set_clk_en()
>       clk: qcom: gcc-sm6375: Unregister critical clocks
>       clk: qcom: gpucc-sm6375: Unregister critical clocks
>       clk: qcom: gpucc-sm6115: Unregister critical clocks
>       clk: qcom: gpucc-sm6115: Add runtime PM
>       clk: qcom: gcc-sm6115: Unregister critical clocks
>       clk: qcom: gcc-qcm2290: Unregister critical clocks
>       arm64: dts: qcom: sm6375: Add VDD_CX to GCC
>       arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
>       arm64: dts: qcom: sm6115: Add VDD_CX to GCC
>       arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
>
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi |   1 +
>  arch/arm64/boot/dts/qcom/sm6115.dtsi  |   3 +
>  arch/arm64/boot/dts/qcom/sm6375.dtsi  |   1 +
>  drivers/clk/qcom/camcc-sc8280xp.c     |   6 +-
>  drivers/clk/qcom/camcc-sm8550.c       |  10 +--
>  drivers/clk/qcom/clk-branch.h         |   7 ++
>  drivers/clk/qcom/dispcc-qcm2290.c     |   4 +-
>  drivers/clk/qcom/dispcc-sc7280.c      |   7 +-
>  drivers/clk/qcom/dispcc-sc8280xp.c    |   4 +-
>  drivers/clk/qcom/dispcc-sm6115.c      |   4 +-
>  drivers/clk/qcom/dispcc-sm8250.c      |   4 +-
>  drivers/clk/qcom/dispcc-sm8450.c      |   7 +-
>  drivers/clk/qcom/dispcc-sm8550.c      |   7 +-
>  drivers/clk/qcom/dispcc-sm8650.c      |   4 +-
>  drivers/clk/qcom/gcc-qcm2290.c        | 106 +++--------------------------
>  drivers/clk/qcom/gcc-sa8775p.c        |  25 +++----
>  drivers/clk/qcom/gcc-sc7180.c         |  22 +++---
>  drivers/clk/qcom/gcc-sc7280.c         |  20 +++---
>  drivers/clk/qcom/gcc-sc8180x.c        |  28 +++-----
>  drivers/clk/qcom/gcc-sc8280xp.c       |  25 +++----
>  drivers/clk/qcom/gcc-sdx55.c          |  12 ++--
>  drivers/clk/qcom/gcc-sdx65.c          |  13 ++--
>  drivers/clk/qcom/gcc-sdx75.c          |  10 +--
>  drivers/clk/qcom/gcc-sm4450.c         |  28 +++-----
>  drivers/clk/qcom/gcc-sm6115.c         | 124 +++-------------------------------
>  drivers/clk/qcom/gcc-sm6375.c         | 105 +++-------------------------
>  drivers/clk/qcom/gcc-sm7150.c         |  23 +++----
>  drivers/clk/qcom/gcc-sm8250.c         |  19 ++----
>  drivers/clk/qcom/gcc-sm8350.c         |  20 +++---
>  drivers/clk/qcom/gcc-sm8450.c         |  21 +++---
>  drivers/clk/qcom/gcc-sm8550.c         |  21 +++---
>  drivers/clk/qcom/gcc-sm8650.c         |  16 ++---
>  drivers/clk/qcom/gcc-x1e80100.c       |  16 ++---
>  drivers/clk/qcom/gpucc-sc7280.c       |   9 +--
>  drivers/clk/qcom/gpucc-sc8280xp.c     |   9 +--
>  drivers/clk/qcom/gpucc-sm6115.c       |  53 ++++++---------
>  drivers/clk/qcom/gpucc-sm6375.c       |  34 ++--------
>  drivers/clk/qcom/gpucc-sm8550.c       |  10 +--
>  drivers/clk/qcom/lpasscorecc-sc7180.c |   7 +-
>  drivers/clk/qcom/videocc-sm8250.c     |   6 +-
>  drivers/clk/qcom/videocc-sm8350.c     |  10 +--
>  drivers/clk/qcom/videocc-sm8450.c     |  13 ++--
>  drivers/clk/qcom/videocc-sm8550.c     |  13 ++--
>  43 files changed, 234 insertions(+), 653 deletions(-)
> ---
> base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
> change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>
>


-- 
With best wishes
Dmitry

