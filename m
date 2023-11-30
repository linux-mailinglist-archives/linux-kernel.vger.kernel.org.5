Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD87FF32A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjK3PEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346087AbjK3PEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:04:38 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33161B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:04:44 -0800 (PST)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0A6A33FA56
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701356682;
        bh=FPCmM4heOBQnergRut0J3YYhJg2qbq6GVBQzZL89KsE=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O9h/3Qy/1vfabHMfk/ZnQYOnkTyOsdIhV55HA+wyx2KmqcYkaLsUGW280z/ama6Tb
         PkqlX+diaUp25Y2KnXLPDze5CCegGl5cFy0AG0uQ3B0ihgi3I2OF0GhedOYSkLsOYi
         lWTfhnA/27Lmz15tAqhlGFj88xFZHKOLPWaLE6bZoTQjU5Im6epxDrdlnYGW55guw1
         JLniHMNruhvQQkteJVCFyzqB8DOywFkpQ7QGOZ1r1Lh938S0YN0LySKEO9EucmKurO
         KF6QjKaJ3N4vek3lcCwAubihjGoHgoEYoHx9cEUEjt32jFr4g3BgTiUOywxLTKBfuF
         62nhITdg5cFSQ==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41e1d05a5d7so11012131cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356677; x=1701961477;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPCmM4heOBQnergRut0J3YYhJg2qbq6GVBQzZL89KsE=;
        b=YF10mGrHfpPbPGE44FSFUghPYjZuvDViqUpsKtHsJCne7MghaVUnNdmS/gedyCiVyc
         epuXXutdYTaPKWkVePuTXFH/A2/nlFOnCC1sU912hJ1EngqKg+GqQjCNf9Me7qRftRXg
         nhmWI/Wx+CIkJb0vTWafQS68K6cGdNNZcNl4v8S39qmmJklvi/hCES/9PqwuseBNZlTY
         w3cFMfnUNXdAUOUqV3ibFNgCK+JVO2iCzhFNVLjaUGk0eQlIov/KDHuVfgetXr1tlWuC
         Ygq1tClRv74XVgs5syAwCipfJ+ovTaENxj3E6KLKBIkTfWtICaH29xNE8QQmvZ+XL5Md
         501w==
X-Gm-Message-State: AOJu0YxCjZkdNXRNO93bh6KGAXpEJf8GagBaLvcVWPf5pC6znoc4cX0L
        FWQlHJ7oWvrY7vZrOc7WFI7vh81Zni6O8Dy7adiCzEN9yih4XyxizX3zlZk0hWXU/LJgFQvNoTY
        L0+C3llkMXJPYHf38tAgJIWHCL7mw5DWHt3jsLKOzazSB978kCfPma1tl1g==
X-Received: by 2002:a05:622a:22a8:b0:423:991e:8589 with SMTP id ay40-20020a05622a22a800b00423991e8589mr20147213qtb.33.1701356676671;
        Thu, 30 Nov 2023 07:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9k158ZXjtgNdDUlZzVCNCmNLqRi+AOk+q/iadsE/+/aYALRFnyCxg84z0xW9r9HHy2iLKzeqhcclFfe7hrr0=
X-Received: by 2002:a05:622a:22a8:b0:423:991e:8589 with SMTP id
 ay40-20020a05622a22a800b00423991e8589mr20147170qtb.33.1701356676224; Thu, 30
 Nov 2023 07:04:36 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Nov 2023 16:04:35 +0100
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231130-skating-shindig-af43058fc8ff@spud>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com> <20231130-skating-shindig-af43058fc8ff@spud>
Mime-Version: 1.0
Date:   Thu, 30 Nov 2023 16:04:35 +0100
Message-ID: <CAJM55Z_EPMuCbX-_8ABKwT27xdtDX7X2y_nv+o4knVL0DoK2xQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Add JH7100 errata and update device tree
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley wrote:
> On Mon, Nov 27, 2023 at 12:27:38AM +0100, Emil Renner Berthing wrote:
> > Now that the driver for the SiFive cache controller supports manual
> > flushing as non-standard cache operations[1] we can add an errata option
> > for the StarFive JH7100 SoC and update the device tree with the cache
> > controller, dedicated DMA pool and add MMC nodes for the SD-card and
> > wifi.
> >
> > This series needs the following commit in [1] to work properly:
> >
> > 0d5701dc9cd6 ("soc: sifive: ccache: Add StarFive JH7100 support")
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=riscv-soc-for-next
>
> This stuff all seems fine to me. I'd like Palmer to take the first
> patch, or I suppose I could take it alongside the cache driver changes
> with an Ack.

Thanks, makes sense. In addition to the missing Signed-off-by I also forgot to
update the commit message for patch 4/8, so let me send a v2.

/Emil
