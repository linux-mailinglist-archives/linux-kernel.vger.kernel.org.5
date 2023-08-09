Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1328C7754BD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjHIIFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHIIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:05:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881539F;
        Wed,  9 Aug 2023 01:05:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe655796faso5624934e87.2;
        Wed, 09 Aug 2023 01:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1691568338; x=1692173138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k8g7ZDuI5klivpIjPTpv2Wf98D/Ju1M5+69BmYKc4d4=;
        b=JT7n7X7dn/pi83oh1ZTrHlmn3jnxvICJRizVR4Big6kBGUYAKOPVxdOJXLhulbBsAS
         R0txVElZEhQprDeXp2JyRpO0W5qd4JpMghfIDV9rw+kg7zcG6Pj8qEU3Al9FpaLJFbB0
         vMKsXoiDIWZzMAu/EU6oKdnjKD/3s1dqFoQL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568338; x=1692173138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8g7ZDuI5klivpIjPTpv2Wf98D/Ju1M5+69BmYKc4d4=;
        b=gyTnftbhR7rmIvE+o7frYj94d9MQOfcmGmSBU1PTMicTtcsTKabRSqey4dm9VXBFLH
         Z6i2681cssz27RMBjK5OGdLl+saBxarQQqnWktEPnZNhZJCnW7R5MeLTkqyuCe+7whBI
         RMw00v2LhsthBv1DlWhNP1akn1hotJyF8bX6PnjHkjnYZ/E0FHvOjHgThjGiblA43a3e
         XN8O6VWMIM5rG3y78nV8GpUyluq//+CvGJVhjCdKBxKwtJVLgvfiiy2TWj/Xj+LMPQig
         KNQrefgbXPyOM0nzjC59hPr8U0EcOiADxl4EAJ1tQk3Xvptx25wQmr6A0ExtR/cy8Zgx
         B70w==
X-Gm-Message-State: AOJu0Ywd1NrAFpKY5YSWUo/anqP/mEAMg+WPQ8S+kiWTS9fbBz70TrJS
        j3z3xBC+nDzT2HOM+RaOSEvNFphYnO8RxTVMK1o=
X-Google-Smtp-Source: AGHT+IHsqhVUq0NHt6QqmnH2mXEw2idt+PEpuWYbmi1YQ6ByuM5q7ik12m+ONKXBFeqIa07ae+NafB4f6H3z6ktgnZ0=
X-Received: by 2002:a05:6512:2392:b0:4f9:5404:af5 with SMTP id
 c18-20020a056512239200b004f954040af5mr1398117lfv.46.1691568337444; Wed, 09
 Aug 2023 01:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com> <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
In-Reply-To: <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Aug 2023 08:05:25 +0000
Message-ID: <CACPK8XfFWC-wxCt4DwNRNctXap5qiZUz-utcbpnp0vj=Z46=9Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 08:43, Delphine CC Chiu
<Delphine_CC_Chiu@wiwynn.com> wrote:
>
> Add linux device tree entry related to
> Yosemite 4 specific devices connected to BMC SoC.

Convention is to mention what kind of machine this is, to give us some
context for review. "This is an x86 server" or similar. Take a look at
existing aspeed device tree commits for inspiration.

> +&mac2 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii3_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;

None of these are properties that mainline Linux supports. Do you plan
on sending patches for these?

> +};
> +
> +&mac3 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rmii4_default>;
> +       no-hw-checksum;
> +       use-ncsi;
> +       mlx,multi-host;
> +       ncsi-ctrl,start-redo-probe;
> +       ncsi-ctrl,no-channel-monitor;
> +       ncsi-package = <1>;
> +       ncsi-channel = <1>;
> +       ncsi-rexmit = <1>;
> +       ncsi-timeout = <2>;
> +};
