Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D57F4028
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjKVIce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjKVIcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:32:33 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5A0109
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:32:29 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5c8c8f731aaso49017727b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700641948; x=1701246748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKD7ps1yzVN9YyslM/iBpqLP523I7QRimM6aSYFE9qw=;
        b=xl9atxrtCs/O7Rljt3oJ7A8T+hwiYAonhbMg3odgk4h25Y70BWpEwUph5hmpQuDN7D
         DUWnVyLcwiSSADhUFGdJq5rftQnd9Trcj0BGNq5DQbYuMsLr7sLS5oUEqiZMCarvCSFs
         OB37XZKqRJW/308+NwTes7JnLDTros8r07dI0uAofJK4r+o7ajBTa0+NNejjJhDX1kSz
         LY5lhUAkLjU+FRNNck1CdFuk6uSALy/bjV4cVQzpCukH1wjpTZxBHWSvsJiNSakcf5oY
         nn4scrcYucAWZ7DB5V8X9B2MYZfc5e+G8K90/zSEjVhUmbm8deFJ18lSQ/zngwGiFVWy
         QqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641948; x=1701246748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKD7ps1yzVN9YyslM/iBpqLP523I7QRimM6aSYFE9qw=;
        b=T7WpaQuYiQhDMz04pjmlcwhSfqiQmucMKYdCW6nGoUI6rse8JlkDvL7rqLF1XXMvrw
         9uzv+p8eZK8OOfZJh/KqdJyvSpV5Ocmh5iMfyi5V9YHW9bevAG1bFlrr5xC0YfJdcar0
         SV+IQk11mKiLM4cagVwhW1vxHwzsyF+YYao4PpVqxe9B/4NmF463Wm8M4bb1Yh6BtupO
         aWW2M3tx5jW7oUmvg5lKa85CUGhJviDCJMIN2jQIF8US3hVJqNGiJv3sd6ws+YjuQ2UU
         +drSM7cjzrVCbxNTXm9GJo0+sXPC36/WBNLofV6cMT76MK1W/1mWns5J82GhPNXCV4da
         2uGQ==
X-Gm-Message-State: AOJu0YyyuUY9Zpx/IWQRfBKewetC4zu+dErlHb6q8doyWSAy0pc02ShB
        m6JyVxY8vjhQsWuXXKod/1ekD9jBAtcNfDwwHlVK/Q==
X-Google-Smtp-Source: AGHT+IE5g6LemC66GK6J4NtBnEPhGvTXAOLhtI7zh/ZTgg1uxNkugF5SAUnxnXKq9zo05CTFg+SDAeASJdL8+iGTQBU=
X-Received: by 2002:a05:690c:4782:b0:5cc:7431:871 with SMTP id
 ha2-20020a05690c478200b005cc74310871mr699694ywb.25.1700641948499; Wed, 22 Nov
 2023 00:32:28 -0800 (PST)
MIME-Version: 1.0
References: <1700637042-11104-1-git-send-email-quic_cang@quicinc.com> <1700637042-11104-9-git-send-email-quic_cang@quicinc.com>
In-Reply-To: <1700637042-11104-9-git-send-email-quic_cang@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 22 Nov 2023 10:32:17 +0200
Message-ID: <CAA8EJpreEqStpjkN5z3+ufiFXP22-PcW4U+wR6Y7LK7QMT_Ktg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
To:     Can Guo <quic_cang@quicinc.com>
Cc:     bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 09:11, Can Guo <quic_cang@quicinc.com> wrote:
>
> The registers, which are being touched in current SM8550 UFS PHY settings,
> and the values being programmed are mainly the ones working for HS-G4 mode,
> meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
> However, even consider HS-G4 mode only, some of them are incorrect and some
> are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
> SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.
>
> Fixes: 1679bfef906f ("phy: qcom-qmp-ufs: Add SM8550 support")
> Signed-off-by: Can Guo <quic_cang@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  .../qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  3 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 28 +++++++++++++++-------
>  2 files changed, 22 insertions(+), 9 deletions(-)


-- 
With best wishes
Dmitry
