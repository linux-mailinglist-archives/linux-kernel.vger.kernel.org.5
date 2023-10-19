Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DEB7CF5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbjJSKxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345285AbjJSKxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:53:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506A2121;
        Thu, 19 Oct 2023 03:53:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so95111741fa.3;
        Thu, 19 Oct 2023 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697712782; x=1698317582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a2iJFIQZU3dMWJmF9fQqJT6sOJuhpG2IbdIzEIIeAV0=;
        b=dMz2uwuSU7lYXT/hKRJL5HQ3W8Td6np6Idc0NASEawoS/cOZNPXZUZ70fPb0EkSMY3
         /4nLqK4ym4DzImgE1lATwjbumLMqzZv1iTht9+HtDJb7XpNjQuX52HVsPvYLklOgo9/Y
         VksStneetXYJSbyqPa1+ZPH1vyyHa6zXLZkKuAklvGvkmknT5YQHVTynKEK2eGQtES1z
         62qNgWuJedYkJa2PlCPrkx8XQ6gzctVYIrpvxUdgb5eGOa0R2mD6CoSpta+ELwhVKj5J
         OIkQZxU6ysIdJyAsuea+NBMKEcmcDTyVvYDPU169IfxvTzOvlrKiir/Nnr+1Q8uvscv2
         f1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712782; x=1698317582;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2iJFIQZU3dMWJmF9fQqJT6sOJuhpG2IbdIzEIIeAV0=;
        b=iqxGzS8Ha1W2i0SREbYt6KLDaZ4lSOdSLwAuy7oSAsolVTqHFFsHNl0qVyqbdY+c8U
         2VPNXT+bzrEBsDCxad2bq0Fy15838jwdsV+RU8BZ/N/Ox2SDrHB7fwjn59bZIXxMjCjK
         bYhhNYgeKHeujj1p+2H+y/2CSMgvBe4BvGzVM7fS7Lc2z5JtOGkHQ62J00qU9rpsi1cs
         G98lqH611mt7mArPM1KpPlMCs/gxUIInaXYfxh7QSCXyxJYmaJIJNFH1s1ulMZki1PcA
         bi+d6ZQfjZt1WIc/uOP1fK7TkgGeZs/fV/eZ5881jcb8A0vIgGVz7Vgdurp/gp3aJpcr
         1gKg==
X-Gm-Message-State: AOJu0YxDpRQ91ZH6fmGQlZYimEUOBXUor4lHosqIWyEg3Sg4vTDxgSDb
        AMzj61w2aGI/HNvZqoHSWl8=
X-Google-Smtp-Source: AGHT+IGzZ6w/a2I2t2hj+OoCFUEN+jp/x1/0jBQjv+5/Krw0aEMmBE8FvF+3HQVEJYZ7RYhQGJX34g==
X-Received: by 2002:ac2:5194:0:b0:503:9eb:47f0 with SMTP id u20-20020ac25194000000b0050309eb47f0mr1122559lfi.59.1697712782192;
        Thu, 19 Oct 2023 03:53:02 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id fb21-20020a056512125500b005031641b40asm1043740lfb.159.2023.10.19.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:53:01 -0700 (PDT)
Message-ID: <65310a8d.050a0220.28bdd.4114@mx.google.com>
X-Google-Original-Message-ID: <ZTEKiUCiP/fMJUdl@Ansuel-xps.>
Date:   Thu, 19 Oct 2023 12:52:57 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] cpufreq: qcom-nvmem: add support for ipq806x
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
 <20231019064653.feqpjdmblm7mmsug@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019064653.feqpjdmblm7mmsug@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:16:53PM +0530, Viresh Kumar wrote:
> On 13-10-23, 19:38, Christian Marangi wrote:
> > The first patch of this series was split to a separate series as it
> > doesn't depend on [1] and can be applied right away,
> > [1] introduced some breaking change to function that ipq806x, ipq807x
> > patch was dropped to permit an easier rebase and merge of both.
> > 
> > This small series adds support for ipq806x qcom-cpufreq-nvmem driver.
> > Special function are required to make use of the opp-supported-hw
> > binding by hardcoding custom bits based on the qcom SoC ID.
> > 
> > The qcom-cpufreq-nvmem driver had recent changes to also improve
> > support for apq8064. Because of this, this series depends on a
> > just merged series.
> > 
> > Depends on [1].
> > 
> > [1] https://lore.kernel.org/linux-pm/20231010063235.rj2ehxugtjr5x2xr@vireshk-i7/T/#t
> > 
> > Christian Marangi (4):
> >   dt-bindings: cpufreq: qcom-cpufreq-nvmem: Document krait-cpu
> >   dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt
> >     property
> 
> Applied above two. Thanks.
> 
> >   cpufreq: qcom-nvmem: add support for IPQ8064
> 
> This doesn't apply/build anymore.
>

Hi, I sent v7 that fix the conflict problem. I dropped from the series
the 2 applied patch and added the 2 dependent patch since it seems
fixing the problem in the series might take longer times.

Can you check? Thanks a lot for the help in accepting this series.

> >   ARM: dts: qcom: ipq8064: Add CPU OPP table
> 

-- 
	Ansuel
