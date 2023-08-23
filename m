Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DD9785598
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjHWKlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjHWKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:41:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6886210C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:41:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11225796a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787286; x=1693392086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luKSEkNHiJRZAB6CryJlC1Oxi9BGNpClACXQ8Byw5Ic=;
        b=WHVr3HZgyTJ7JTawR9mmUrc1TBY0MrtURZADRnta4gzWZO7eB/iKdw/160bcKpvl9i
         ePJ/+1R77StPY720Ub/DLd8J2s4ExkC+t+F6cAZ88n8WQUZLGzGd3YuERdpFrb0swovf
         gYGnlWMnZH0kdywLOqv98SjUIeCeh3vDZk87dI3wGnXqeHwq9Po3dOrE8w6T0lSeCFyV
         bhc/qB36yhxxB8EOt9onU+ppY5F4xD/RiTjbbk3Uax+/+16BcmaH47xTpIApiD/x6RDl
         GCKouXspBDwi38Az3oGZ3usxD+wBli+9/0o2gekVGDpAUgbgEIe1jtOeSAhHqU3ClGjW
         lHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787286; x=1693392086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luKSEkNHiJRZAB6CryJlC1Oxi9BGNpClACXQ8Byw5Ic=;
        b=W8RWUINOozBXm2geFmwuSRzfTMwGZ56WkpZtyO2OogKsEzs7DyoXpSF9NO0MFivFWE
         RXcOAGvF8JcyXjjcXes4rpSS4pUVdWYsCYKsDqtHLC3aU9c+wFZA1GZdqRvKuapVThhz
         /qsfILkL7tLJMITSvPmGtHV+iKdTSIRDDKcedzsIkmw/TVHqLVp5xP9SX0TBnk3I9E5d
         ms2qWMNK3dhbE0MCvL1AFkkjDLbnrVLZEp4nCRIafoEuwPIkVJr1Awvm5TYdcu4eByOo
         M7JeXGIcL2RMjBVK9dTSVdrzkGJMvIRs+vJEroxeq7+GoqzfVv3ON5vn11K0DQqHsyr7
         gjGw==
X-Gm-Message-State: AOJu0YwkuSNB+rjAsRTbVJ7L3CYmNE6ScrFEts5ud795RiznR3hTfb0C
        Zi9in3Y6VHvYfPYdN4IAbauOyg==
X-Google-Smtp-Source: AGHT+IHk9k1hH/H67+GxhAgsuEhHp0Vfnm4zlNLJH/6uPQbuzNozS/abWV6JKzOj29LYEWBxLKGysA==
X-Received: by 2002:aa7:de12:0:b0:522:3149:159b with SMTP id h18-20020aa7de12000000b005223149159bmr14808420edv.2.1692787285921;
        Wed, 23 Aug 2023 03:41:25 -0700 (PDT)
Received: from linaro.org ([84.232.191.92])
        by smtp.gmail.com with ESMTPSA id s10-20020a056402164a00b0052a3c7c9e8bsm453069edx.56.2023.08.23.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:41:25 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:41:23 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
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
        Jagadeesh Kona <quic_jkona@quicinc.com>
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Message-ID: <ZOXiUzxfs1cj3SWT@linaro.org>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-16 19:56:46, Konrad Dybcio wrote:
> On 16.08.2023 16:57, Abel Vesa wrote:
> > From: Jagadeesh Kona <quic_jkona@quicinc.com>
> > 
> > The current HW_CTRL flag switches the video GDSC to HW control mode as
> > part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
> > give consumer drivers more control and switch the GDSC mode as and when
> > required.
> > 
> > HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
> > HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
> > 
> > Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> Do we have any use for the HW_CTRL flag?
> 
> Perhaps it should be renamed to HW_CTRL_ALWAYS?
> 
> Or even better, *if and only if* that is necessary, add a common
> property like "always_hw_managed" to the genpd code?

The HW_CTRL flag is still needed for the consumers that expect the GDSC
to be have the HW control bit set right after it gets enabled.

AFAIU, for the HW_CTRL_TRIGGER, the switch to HW control will only be
done by the consumer (not on enable).

> 
> Konrad
