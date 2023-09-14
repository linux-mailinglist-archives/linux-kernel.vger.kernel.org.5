Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2627A03DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbjINM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjINM3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:29:15 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EA1FC9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:29:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d77ad095e5cso962892276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694694550; x=1695299350; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtLDd3fxzJ2qWrurLeB9pHYuc3+Ev2d1hMk3Oahu1Wo=;
        b=eZiVWtqHfj9kvHKThEITGuUn41nfbpcr+VFfJAISZm7A2GMCm33W2qMKBKVMlJjXyF
         TKqufbNXUWPDsewBTbFg/WgRLEsIiEhd1BenNJQi3bmyDLys2a1wBsTWMtfaCwfQszXX
         yLf7QoOOXCj5YDkJj7WRX9Qn/if5SVDykKZeY9me2i9DuLuLDcx8mLCSdFBT1x+nBND9
         B7n9tmiaigyS7vX9q1b+dIQPL9Aayk2J+0k8C19TuwD1wyEtZHRnxk7O2xxjkuQbfVgO
         AqLE9UdjxE5ovmPFMLzf4gw7dEC7p5333Bp8K0hvgVB+CaHpiWX0p1b2NyDgt7t565k3
         KzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694694550; x=1695299350;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtLDd3fxzJ2qWrurLeB9pHYuc3+Ev2d1hMk3Oahu1Wo=;
        b=C59zmO5IKnryNbVianXfmF1jBAhgkYy29IFCh3e7Di0GiK85Ai9GPQT+VGz6AMrua0
         hg5IW51foEkgoOHMT0icGgH25W9uC6huTQiUtcK6Lu1/sJZdZdsa0lT2pxN9Lo0dGPBo
         mjBZV30BEBnNufJ45JI5HiUP77s8ULd/+aYBrQ2afG7Ie5jOL0owsHswKdmYKUsWqhnK
         wvBQhEVS+PvgnxIwQgmli45IBTNjykhoij6YzCssPbe81Vvsr+tGSHHPC564o1LZesLq
         n76bqun4MvKVzXRRv+c9epQj+uorCWhzO3GdUguxM9ko8tEC9wOQDFbDzz4u1DtFiXac
         xRfw==
X-Gm-Message-State: AOJu0Yzh4ND7mhQ5cZ5m8ergnF8Amc6z2ZcQINtKa9jre1ilNrT7Awzy
        COM6VL6IIghrvl3MUh2G1uarRYsfoQPzphDW71LS+w==
X-Google-Smtp-Source: AGHT+IFKzxsuOJHD2I2G9JidYU6beywYTq4S1b179IHAIq/bnk1xXw7mkm/fBLJ/vc1OHT+Dq/2wiGVPBeOWWrBBbDg=
X-Received: by 2002:a25:40d:0:b0:d7b:3917:4609 with SMTP id
 13-20020a25040d000000b00d7b39174609mr4683812ybe.19.1694694550698; Thu, 14 Sep
 2023 05:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com> <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Sep 2023 15:28:59 +0300
Message-ID: <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
Subject: Re: [PATCH 4/6] phy: qualcomm: phy-qcom-qmp-ufs: Move data structs
 and setting tables to header
To:     Can Guo <quic_cang@quicinc.com>
Cc:     mani@kernel.org, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sept 2023 at 09:01, Can Guo <quic_cang@quicinc.com> wrote:
>
> To make the code more readable, move the data structs and PHY settting
> tables to a header file, namely the phy-qcom-qmp-ufs.h.
>
> Signed-off-by: Can Guo <quic_cang@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 802 +------------------------------
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.h | 805 ++++++++++++++++++++++++++++++++
>  2 files changed, 806 insertions(+), 801 deletions(-)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.h

Is there any reason to do so? Other than just moving stuff around, it
doesn't give us anything. This header will not be shared with any
other driver. Just moving data tables to the header (ugh, static data
in the header) doesn't make code more readable.

If you really would like to clean up the QMP drivers, please consider
splitting _common_ parts. But at this point I highly doubt that it is
possible in a useful way.

-- 
With best wishes
Dmitry
