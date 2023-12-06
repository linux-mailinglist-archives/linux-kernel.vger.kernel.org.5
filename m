Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD1180708E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378420AbjLFNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:10:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE0AC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:10:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-425427286a8so5409381cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701868219; x=1702473019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pt/oMfKEoVvZOs+7PtxgU3lL9BlJV64pat4giYOfloo=;
        b=VyouUSNz7lObsDlIxiFkNVNrje85/ifEopn61t9jrtHNWhbMDqcWDqcDLnIazw8JHX
         hY5fnLOPUpRU/O4qVXdO7KlUjJwNfrpnyL2UgD1ADir23NuHLHhGWJQ5CXnnxH4sh/uo
         YNkILWU2+ABjQ3/r1M8pglvTgeij+87ZbKrkWJkhsHHATs8inGnejdsT4I2NACJZ6P5x
         OhwRGyD3umhxmdClHVJzrUWJ1mSDToMvt/xe7Yq8PSDUNu+tU21y9wvY7BM6FmnrustK
         BNrsB9vAtoD6MS5Z6eAUYfkUlAswkJ9fp/MZiUkx5Z3mqCwpZSgyD0PyOIat7RyXmdSs
         tS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868219; x=1702473019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt/oMfKEoVvZOs+7PtxgU3lL9BlJV64pat4giYOfloo=;
        b=ZKaEBl5DOzoaCEDke2EgXq1tzEwkG4lezoChge7I79/xkXoiYrCXPlSB0ZqWX95ySN
         tuQOM7HFuBeOTTtw8M2Ba56B0VVl9uw+v9gSH7Jk1cp1eL5oUtpkduvtCa0SKBdCUz63
         +mzTLX1e/qmO6ZMPcUAupXpMYr9VDQwhBNlXmeFd50FbOvBj0pcm1r3V0vkwDFkWiTr9
         qEDTMImFHVwdX7t9RmCVZid+WmJ3jFYwdrjhphQ6mEOPS1sShkD57Q3MXtuMhRyh32aC
         XdYI85N2GJRau2d3uH176k7q2iLBoJh1zB9hY7PnY+ARgQZE9tAasPkzPUJwfuk9eA3n
         hFzg==
X-Gm-Message-State: AOJu0YxYkCGSwo1h8OPz/CTcSKL2+IwK0/gVzpxqpF7BKslu8Lt7GgVY
        ejNZfEBGCvOThuJXcp5fhs9y
X-Google-Smtp-Source: AGHT+IEb4yi9gh7VHo+zZIBCifs1fd4gKseVxyxJ41S1V0cBHCI6vFd8Vt9p32/kxIhAFm7YSoNr0g==
X-Received: by 2002:a05:6214:76a:b0:67a:bbfe:4edf with SMTP id f10-20020a056214076a00b0067abbfe4edfmr868908qvz.30.1701868219103;
        Wed, 06 Dec 2023 05:10:19 -0800 (PST)
Received: from thinkpad ([117.202.188.104])
        by smtp.gmail.com with ESMTPSA id c9-20020a0ce7c9000000b0067a97f6b0c6sm5052738qvo.32.2023.12.06.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:10:18 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:40:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_vpernami@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: qcom,qmp: Add PCIe
 qcom,refclk-always-on property
Message-ID: <20231206131009.GD12802@thinkpad>
References: <20231127-refclk_always_on-v3-0-26d969fa8f1d@quicinc.com>
 <20231127-refclk_always_on-v3-1-26d969fa8f1d@quicinc.com>
 <78815f1b-7390-40de-8afd-ac71806f4051@linaro.org>
 <24fae40a-453b-b14c-923f-88758a246aa7@quicinc.com>
 <20231201060716.GJ4009@thinkpad>
 <166d307e-7d1b-48b5-90db-9b6df01d87c2@linaro.org>
 <20231201111033.GL4009@thinkpad>
 <f844cd1e-7e4f-4836-bc9a-2e1ed13f064f@linaro.org>
 <20231201123054.GM4009@thinkpad>
 <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a7376aa-18a2-41cb-a4c9-680e735ce75b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 02:25:44PM +0100, Krzysztof Kozlowski wrote:
> On 01/12/2023 13:30, Manivannan Sadhasivam wrote:
> >> What I said before:
> >> "Again, third time (once from Bjorn, once from Dmitry), rephrase
> >> property name and description to describe the hardware issue. I see
> >> description improved, but not the property name. Again in the end of
> >> description you say what Linux should do. Bindings do not describe Linux
> >> OS."
> >>
> > 
> > You didn't answer my question:
> > 
> > "I see a plenty of properties similar to this one instructing the OS to keep some
> > resource ON to workaround hardware issues. So they are all wrong?"
> 
> They are not the best, but it all depends on the individual case.
> 
> > 
> > If you say they are wrong, why are they approved in the first place?
> Because we don't have time to keep digging what the driver is doing and
> what is claimed in DT. Some people don't even CC us on the driver.
> 

OK. How about, "qcom,broken-refclk"? This reflects the fact that the default
refclk operation is broken on this platform, so the OS should be prepared for
it (by keeping it always on).

- Mani

> 
> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
