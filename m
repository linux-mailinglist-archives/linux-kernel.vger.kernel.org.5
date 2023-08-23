Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E07854C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjHWKAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjHWKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:00:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A403493;
        Wed, 23 Aug 2023 03:00:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so8279108e87.2;
        Wed, 23 Aug 2023 03:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692784813; x=1693389613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7VHCNyxaZNPU4FyyEuB/AUclDUQkc0xiHJpU5W0gcM=;
        b=DdRC64F7TsIqvpbURAmjmkXHNfUOXPKAzFNkwftE/JYO2mn6+EIJz4h5vUusHNSInk
         ihpZMYIoHmNcIqvOfo/aA45XdLGOqKyLDFidZEUGAFYVndU+OgexWr0XhjDbiJyaoe3e
         d2rTeB64fxD21JyVBvxGgckJv7UYM3mool0AbfUxhdmTYaAxf0CEsbt703bUf3/9ylLS
         vM1O5Io6v5Phkat83ZapzexKAzZ6tOwiIkS+8f/Vm+Exxs3TY5OkLYAv3oFKbiHQkqTZ
         wL6jkqX6n/2lqsov5XOl0atK2yo2Z5k3wdeSFrAIr5k7P8hw8rEcQiJkg0tm8+CWus5Y
         Fu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692784813; x=1693389613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7VHCNyxaZNPU4FyyEuB/AUclDUQkc0xiHJpU5W0gcM=;
        b=P7OTrvPS8IMruq4SBAF2YWv84x4/HN2/svp6yiEJtsxQn4bf0V8mcSf910vfxWyALd
         3MGuvxTz+eyDo5QlTiOV3qvOPDUTrQcgnRzL3Nkz9QvhPo49Ie1ITkS5RxOM+f22BNz9
         H/ew7jM3bdO96tUt4HI4VkDzMMYy/Yv2HbydN5DQYeHt618VUyG2hvSR46w80G83doXd
         9Vg1+aoHdRVUXTz2Z2pkCNe1+4vg1eaoaweWKw0dSCt8HM/xLGdzWqVFJ4AUDrn4Gfyn
         rCSPFiQER4JieUp4aecUws3ukROUe6OBCGZYhbC8S9s9s976pHGQnyIUC0tYEXqC6YiX
         XPnA==
X-Gm-Message-State: AOJu0Yy4vbtFbUE4WoxNh/SAYkBDWymODEbKoSZCx1kwYl7UVkfWh0tt
        Merx6WMFImlhEzqLIaJSR28=
X-Google-Smtp-Source: AGHT+IFWKdHrFCphsDQXjanEbkwZOxjJGhc6zJjHuGkpv8q/4gqZ5pti/2VT7HTAMlTRGfXSuLIDJA==
X-Received: by 2002:a19:7617:0:b0:4fd:f77d:5051 with SMTP id c23-20020a197617000000b004fdf77d5051mr7774975lff.26.1692784812522;
        Wed, 23 Aug 2023 03:00:12 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id c26-20020ac244ba000000b004f61187363asm2603076lfm.66.2023.08.23.03.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:00:12 -0700 (PDT)
Date:   Wed, 23 Aug 2023 13:00:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: snps,dwmac: Tx queues
 with coe
Message-ID: <l7yajzhpuotn62pjkxk43qtcn3u4zltpyqcvo224737bjg3eab@bzu6pirxbvh2>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
 <20230819023132.23082-2-rohan.g.thomas@intel.com>
 <20230822171525.692bd2df@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822171525.692bd2df@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 05:15:25PM -0700, Jakub Kicinski wrote:
> On Sat, 19 Aug 2023 10:31:31 +0800 Rohan G Thomas wrote:
> > +      snps,tx-queues-with-coe:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description: number of TX queues that support TX checksum offloading
> 

> Is it going to be obvious that if not present all queues support
> checksum offload? I think we should document the default.

This question is debatable:
1. By default the DW xGMAC and DW QoS Eth IP-cores are
synthesized with only the very first Tx queue having Tx COE enabled.
2. If TSO is disabled then the Tx COE can be individually enabled
for each queue available on DW QoS Eth controller and for the very
first N queues on DW xGMAC controller.
3. If TSO is enabled then the Tx COE will be automatically and always
enabled for as many first queues as there are TSO-capable
DMA-channels.
4. At the current state the STMMAC driver assumes that all Tx Queues
support Tx COE.

The entry 4 can't be changed since we'll risk to catch regressions on
the platforms with no property specified. On the other hand it partly
contradicts to the rest of the entries. I don't know what would be a
correct way to specify the default value in this case. Most likely
just keep the entry 4 and be done with it.

BTW I just noticed that but the suggested "snps,tx-queues-with-coe"
property semantic will only cover a DW XGMAC-part of the case 2. DW
QoS Eth can be synthesized with Tx COE individually enabled for a
particular queue if TSO is unavailable.

-Serge(y)

> -- 
> pw-bot: cr
