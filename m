Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCE7998BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbjIIN6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 09:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbjIIN6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 09:58:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE539CC0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 06:58:14 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-569deb93999so2265704a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 06:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694267894; x=1694872694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qchtHR7zhGIMr/ysoIMSyHwPGpt0Wf8RVcq19XX2dq0=;
        b=OXuxGN55ayyBcOVpBb031XC9WQMrWtNoZ6SPvcQdSq+iPoccL0c968c5BYKp5fzOqq
         1bYP4fvlFVO13BHBbhILuF5Oqkoc8ozaiDpiysis0FrxZOESU0yZphIUqjSvYBxDAXR2
         uw6ddh7g8c5FcukSdft8FCpANf7jHd1UG9o5u4jT7KkrYYWPY/j9OPDfTQgBAq0EWkxN
         uuZiQX8KBpObMNIaVYVGF/LfHUdBsW5Bh3B976w9HbFGDVUP2CjzbdDJxL87h4mb6sq1
         8ZPiEGSvNr/MrQhWlblj8gBlubczA/O5hJwH6ujAYnE5ZDvAMdQrH3rG50zofrGQd67+
         8nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694267894; x=1694872694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qchtHR7zhGIMr/ysoIMSyHwPGpt0Wf8RVcq19XX2dq0=;
        b=hEI5qYQm+XdvxhgagC5OHpPU2u7x3rBcfzgMuz2tESGJM5n1qv1hoNoQ9dPv0Se/qZ
         s9TgCekCmpuct43gteuyw0r0f9bKsrtqdRQt2b3L2YcGorioxhun2MPthSl7YndPQvpB
         F8nePV8Xw7zZPhHytmOr639uP0Pan2e4uv5Q9Nd4ZywT9LpbBxR/Fs6CFoxh+07m3gDG
         qk42HtZw23kE/RI4Uvw4xGiw6v2SuUN7eNe/7cqf7y1tdhb5YEQ7grb7LP17/6n69NOS
         k1nR6e8/Ks77fle8vuW3H/QHzfxlDtk/g9X/W3oM6dE+LwWJJ35exrkSMZBRyboAgUym
         LCpQ==
X-Gm-Message-State: AOJu0YxuupAIze+HGN25iE7s0IRn4mmmG8tQ4l3uWH1jBBu+CJZ3PBH1
        ofOTSsIYus0sB4WasYIIcTzo
X-Google-Smtp-Source: AGHT+IFLRT3bHuBcTCK14edjBktGiNKcvwlxhAcGkqIYJMH9kSuMd9drFXH3fkHzPCtXiz7izcT/vw==
X-Received: by 2002:a05:6a21:35c2:b0:14c:d5d8:9fed with SMTP id ba2-20020a056a2135c200b0014cd5d89fedmr4565623pzc.54.1694267894030;
        Sat, 09 Sep 2023 06:58:14 -0700 (PDT)
Received: from thinkpad ([117.217.187.163])
        by smtp.gmail.com with ESMTPSA id v8-20020a170902b7c800b001b51b3e84cesm3292415plz.166.2023.09.09.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 06:58:13 -0700 (PDT)
Date:   Sat, 9 Sep 2023 19:28:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        avri.altman@wdc.com, alim.akhtar@samsung.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: ufs-qcom: Update PHY settings only when
 scaling to higher gears
Message-ID: <20230909135805.GA2864@thinkpad>
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
 <5722031e-96ab-48f6-9848-086be17fe5bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5722031e-96ab-48f6-9848-086be17fe5bf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 01:04:52PM +0200, Konrad Dybcio wrote:
> On 8.09.2023 16:53, Manivannan Sadhasivam wrote:
> > The "hs_gear" variable is used to program the PHY settings (submode) during
> > ufs_qcom_power_up_sequence(). Currently, it is being updated every time the
> > agreed gear changes. Due to this, if the gear got downscaled before suspend
> > (runtime/system), then while resuming, the PHY settings for the lower gear
> > will be applied first and later when scaling to max gear with REINIT, the
> > PHY settings for the max gear will be applied.
> > 
> > This adds a latency while resuming and also really not needed as the PHY
> > gear settings are backwards compatible i.e., we can continue using the PHY
> > settings for max gear with lower gear speed.
> > 
> > So let's update the "hs_gear" variable _only_ when the agreed gear is
> > greater than the current one. This guarantees that the PHY settings will be
> > changed only during probe time and fatal error condition.
> > 
> > Due to this, UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH can now be skipped
> > when the PM operation is in progress.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 96a7141da332 ("scsi: ufs: core: Add support for reinitializing the UFS device")
> > Reported-by: Can Guo <quic_cang@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> Would that not increase power consumption?
> 
> I'd presume that the PHY needs to work harder at higher gear
> settings to preserve signal integrity with more data flow.
> 
> And if so, would that power consumption increase be measurable?
> Or is it so small that it doesn't matter?
> 

Well, the power consumption won't be much. Currently the PHY driver supports
only 2 PHY init sequence, default one (G3/G4) and G4/G5. When ufshcd decides to
run at G4/G5, second sequence would be used and for rest of the gears, first one
would be used. So even today, the G3/G4 sequence is used when ufshcd decides to
downscale to lowest gear G1.

Moreover, on future SoCs the init sequence won't be compatible i.e., we cannot
switch between them. For these reasons, it makes sense to stick to the init
sequence of max gear.

- Mani

> Konrad

-- 
மணிவண்ணன் சதாசிவம்
