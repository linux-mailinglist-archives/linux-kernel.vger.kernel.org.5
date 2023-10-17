Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF77CCBF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjJQTOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344170AbjJQTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:13:50 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF3BED;
        Tue, 17 Oct 2023 12:13:47 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b2e22f1937so381687b6e.1;
        Tue, 17 Oct 2023 12:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570026; x=1698174826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p0kxY4gwKc//5ZmnF/ggeLrPmmpxhe1gSUrK4+qn6c=;
        b=NFodA4N9eLMaKwI67elHmBzWDhRo0WkwLDdW8FAkhJMCt3M862TF1tItw6+i4Uj1ZJ
         jtuBcAE4Fzmg0XBhOYKhHcAHALTZPkserw2hfayebsi265QZRuBf6ku5lFC0XjEhIUen
         4Vi9We8L8hQ6r10hu0SLzUBY1/3r3BSnfC1m5rlg9QZafaUDJR8uj1pHAolA3+W+UCwZ
         nmlBBwzf1smc7LQOmmM6Y8FbtGlrC98N9MrRUE018Sv2imLljLRp6ychciSiljs9sNgV
         kO9uC7eRqj4ITMCFFKMsW5i6zZqCKKdhb9coWLEfvKdFSQjs4j7Tkdub3NVH9KlRkjdc
         96Vg==
X-Gm-Message-State: AOJu0YzZZmaWdBqgnomxioEMb81tffKEjQFv04UMwujxTR9wbyEpN5/L
        DGTGLGKTrWTyATT7+xJOMQ==
X-Google-Smtp-Source: AGHT+IG3P5iru3/qAhDB9vARMywC6qwUxaoia+zyRzPU/qw5YD+aiVDkw0advvZ05zhFRaU+V0GWxw==
X-Received: by 2002:a05:6808:408a:b0:3a7:1e98:80ad with SMTP id db10-20020a056808408a00b003a71e9880admr3146263oib.9.1697570026298;
        Tue, 17 Oct 2023 12:13:46 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0b06000000b003a3860b375esm354399oil.34.2023.10.17.12.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:13:45 -0700 (PDT)
Received: (nullmailer pid 2531500 invoked by uid 1000);
        Tue, 17 Oct 2023 19:13:44 -0000
Date:   Tue, 17 Oct 2023 14:13:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 Document krait-cpu
Message-ID: <169757002397.2531435.15590671540784074185.robh@kernel.org>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
 <20231013173854.7399-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013173854.7399-2-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Oct 2023 19:38:51 +0200, Christian Marangi wrote:
> Document newly introduced operating-points-v2-krait-cpu compatible to
> the list of accepted compatible for opp-v2-kryo-cpu nodes.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v6:
> * Add this patch
> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

