Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB79678A686
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjH1HbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjH1Hao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:30:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A31A2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:30:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bfcf4c814so364725766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693207831; x=1693812631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHa0HVCjRRwz9x8YQh2seHVH7TP0dnCcmAnXVZioCXg=;
        b=DHNj8tl5xcvW/Ucy9pUawhwEahutH8EEW//WITttZs8bMpc0b9BJaiBli53QILsKZA
         qAUQgvk+TqO768yUBilIHGG4R+cg/LpCDKdwWnAVtJlDehJMFlz6+1QQn6x65UFCrRsT
         OPtttFLdmH0W3faHG6hzx/6O5ZaWIZVQpguIQtEhasfGt7oKIvUsb8QwDgshy5eI2lVG
         rNPBpYIQtcQL51OYsEZOgYLQ9CgY0LFpVOftoEbrASpHwriu6slnF0OTEa1P3PykDj5Q
         Wb9/v3zNdAMG40jB7M4FXHqNJxHOoXQbfk8yhVLu7vw57LXtyGiX6sIXofWq2cjvgCFC
         ol5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207831; x=1693812631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHa0HVCjRRwz9x8YQh2seHVH7TP0dnCcmAnXVZioCXg=;
        b=bjG5ueuyTEdSZno2tylTVifE6RMmMs0jgpII9+M6gEjflKIkprBUUnzc/V46ASsTaW
         LugfKKpHdeULJYzalazTUcZPULkQ2ORClKUmbT7SWLyyMwo+H7B6XyiaNFjDpkRqOQc4
         8JtSgTO5KXZiYbBhF3hQuXOd14NiPPyN/iXgWy9VzHBXwqlQsrO57PldeeIB6nI8s/O5
         sdDwdXmA58qIgOnRbHoPg0hEYwF8wZhqbX97MCQjk6ntNRFz8jqMWHYyMSi6B8xdxAmf
         PrPaSDxEErIByno+8/sozveZinUU7ne3mXWVoc4Pkq8y4a1xEWaxirhcvs5YmiJhttHM
         7l3Q==
X-Gm-Message-State: AOJu0Yzm8ut+t8fdIBJgpSPE/mhgoHr2CXzQsDrD/Jt0mIOo0xY48x/r
        o5T48RScR44hRlsdL1Bp40qWnA==
X-Google-Smtp-Source: AGHT+IFNYvZ+2QAqiHBlUuRvGlyfuzJy6GBwSY4PegrCXjPAErtwa83fzStvRhYrm810XMf5Idt+Dg==
X-Received: by 2002:a17:906:1da1:b0:99b:d580:546c with SMTP id u1-20020a1709061da100b0099bd580546cmr19463883ejh.23.1693207830903;
        Mon, 28 Aug 2023 00:30:30 -0700 (PDT)
Received: from linaro.org ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id ju26-20020a17090798ba00b00982a352f078sm4306817ejc.124.2023.08.28.00.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:30:30 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:30:28 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Message-ID: <ZOxNFPRZI/N3a7Kr@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
 <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
 <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1439f8-4a9b-53b4-34be-1229b39d2310@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-28 12:18:30, Jagadeesh Kona wrote:
> 
> 
> On 8/26/2023 4:17 PM, Konrad Dybcio wrote:
> > On 23.08.2023 12:41, Abel Vesa wrote:
> > > On 23-08-16 19:56:46, Konrad Dybcio wrote:
> > > > On 16.08.2023 16:57, Abel Vesa wrote:
> > > > > From: Jagadeesh Kona <quic_jkona@quicinc.com>
> > > > > 
> > > > > The current HW_CTRL flag switches the video GDSC to HW control mode as
> > > > > part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
> > > > > give consumer drivers more control and switch the GDSC mode as and when
> > > > > required.
> > > > > 
> > > > > HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
> > > > > HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
> > > > > 
> > > > > Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> > > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > > ---
> > > > Do we have any use for the HW_CTRL flag?
> > > > 
> > > > Perhaps it should be renamed to HW_CTRL_ALWAYS?
> > > > 
> > > > Or even better, *if and only if* that is necessary, add a common
> > > > property like "always_hw_managed" to the genpd code?
> > > 
> > > The HW_CTRL flag is still needed for the consumers that expect the GDSC
> > > to be have the HW control bit set right after it gets enabled.
> > Guess the correct question here would be.. Are there any?
> > 
> 
> Yes, Display GDSC(mdss_gdsc) is required to be controlled always in HW
> control mode when it is enabled.
> 

Actually, since all the GDSCs that support HW control are by default
switched to HW mode after they are enabled, we can't make any changes
with respect to that since we risk breaking consumers. Therefore, the
new flag makes perfect sense since we can switch GDSCs from HW_CTRL to
HW_CTRL_TRIGGER per platform/consumer.


> Thanks,
> Jagadeesh
> 
> > Konrad
