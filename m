Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767B4811E68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441972AbjLMTNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:13:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:13:53 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9401E95;
        Wed, 13 Dec 2023 11:14:00 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso6034826a12.0;
        Wed, 13 Dec 2023 11:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494840; x=1703099640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DP3/rX8XS4GFefeHlxYO7e4nc2P3XZWDmzXbM/YjAg=;
        b=uz3XoKhXySgdK61SlpmkOoSAu/w+SMGt3YGMfHnV67RWlyw2KCThMdKKMeGdyC5p66
         VjQGkP+suOCRV/1090xHzq7uOYlcMtgKy/gFCg5whio/ZQo/NEBbS5XWhgkpzzRqyom9
         RWn86gVpfoI5V6eu7eWJ5NCrZWAcVx4cE/NXqgt36AIjXJhaZnH/HUatF0JzCmRyArf9
         AKZh35JaCXzySoHnieYRdLqt/sz7tAubJ/20NooM170sH8owrkmrGGZD1UAwvvN7kySy
         JG8qteXNUUAXuJULfXGn0MIaaeFRrGoac40rEeecibjNdZTP2C+Qoj8JNRNV1VnBucwM
         BUrw==
X-Gm-Message-State: AOJu0YxLAIvgFaH/JDCJCSweSvPdZp8R0ZPMdyPdY9El/rYxRMGvY0Hu
        DOqqXIWYQsEa0C27WLiAkE0=
X-Google-Smtp-Source: AGHT+IFVBUq4VGlL4SdERkPGjW5pC1rrG+mPJ05oPnGJJ69Hq2QIbDQIupZA5zRIk/6gItf+TYsBnw==
X-Received: by 2002:a17:902:e5c5:b0:1d1:cd8b:8bc2 with SMTP id u5-20020a170902e5c500b001d1cd8b8bc2mr9637633plf.33.1702494839983;
        Wed, 13 Dec 2023 11:13:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001cf7bd9ade5sm10887076plv.3.2023.12.13.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 11:13:59 -0800 (PST)
Date:   Thu, 14 Dec 2023 04:13:58 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Maxime Ripard <mripard@redhat.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vigneshr@ti.com, tjoseph@cadence.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        danishanwar@ti.com, srk@ti.com, nm@ti.com
Subject: Re: [PATCH v13 0/5] PCI: add 4x lane support for pci-j721e
 controllers
Message-ID: <20231213191358.GB988516@rocinante>
References: <20231128054402.2155183-1-s-vadapalli@ti.com>
 <isttx4vp7warwowlz46oo7y2zex7xuizfvovfse3yb4ww72e6u@nuev2jbkhnhw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <isttx4vp7warwowlz46oo7y2zex7xuizfvovfse3yb4ww72e6u@nuev2jbkhnhw>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

> > This series adds support to the pci-j721e PCIe controller for up to 4x Lane
> > configuration supported by TI's J784S4 SoC. Bindings are also added for
> > the num-lanes property which shall be used by the driver. The compatible
> > for J784S4 SoC is added.
> > 
> > This series is based on linux-next tagged next-20231128.
> 
> These patches have been floating around for a long time (v12 was almost
> identical and was submitted back in April, without any review back then
> already [1]), and it looks like reviewers are happy with it.

Having a glance, it looks good to me, too.

> Could you merge them to get them in 6.8?


Applied, so it should make it to 6.8.  Apologies for the delay.

	Krzysztof
