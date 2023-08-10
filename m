Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CCA776F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHJFeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHJFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:34:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4551E10C0;
        Wed,  9 Aug 2023 22:34:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so386736b3a.1;
        Wed, 09 Aug 2023 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691645657; x=1692250457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ/qlSLIcUxObxGvaa3+l+dyeznB23BNm5Ew/rAC/3E=;
        b=PbzSQIZgaHMyqYIiTzTtaLNvgEWOfUaqcUUgWPFNfggsyfMCw4uYCuHH8jyQp8yPL2
         6g7TckppbfKe1/EdP+iL7DHyKvNZbXFNuHwwSQ5Ry5WA/ccAO2HYX1WLT3A02pvqLpkV
         yQBdNWOFa6eAxPqmPj3cywvJ0J0V94hxS4/OGSeH9H7msw/m5ne61RVAPyfbDLSEFrIg
         ZYIM3pXGN6Bn7gF5ZxINsTZRJIsGdkXIgKxXXAnUbR5o2Xi92ohnrFBya2v0nwutql14
         O4gKuPaa81QMNg/G2v1ZkpbmIWiW48mAxMpVSvxS1csgXCedULy5dJDikb28Ydz35q6Y
         p3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691645657; x=1692250457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ/qlSLIcUxObxGvaa3+l+dyeznB23BNm5Ew/rAC/3E=;
        b=PSSd8WYD+JbpPx1DZycgK2+eM/ecF7CXL5icKssS/s8tSHvBa92I9qJF2TILVUmKBi
         2HyEcLCD2xEE2orOensk1vnqy8JDYhvHBfj95V8XxQO0ZdRbHczXWvupvdB2N1QaNB9v
         ISKVrLIbV3R1EsI0A8FKo3EU1rN4kZ/u9CBUdzQiFOH/FXcvyhDU5tdkb+Wep7NLg1XG
         OEfcsK1orX/DzsbA82ADbTiFBnN3XSRT6y1Clz0TCqYjV6GJGE/kb1YbXdb5yQu7ni/e
         sQEXozTwTWAZjDTWXTG1p3z0PSl4oGgmq1LRCpoT8PsKVKjYKT+Owme7Yy7kQ8AcwFzc
         ZS0w==
X-Gm-Message-State: AOJu0Yze9W3khWImemgNmX2iJn4h10Qh9ULLmVLnz1AUzOH3mHwzPeAT
        3AdQSyu5Zj1reDNpSTWua4U=
X-Google-Smtp-Source: AGHT+IHh16fXJbza6krjS7CGESW9rSgpuPrLYYWfJLz6uxyHaFLZorobjYqBAFF1zYJq2ILEvNtejA==
X-Received: by 2002:a05:6a00:17a5:b0:666:b22d:c6e0 with SMTP id s37-20020a056a0017a500b00666b22dc6e0mr1446781pfg.11.1691645656636;
        Wed, 09 Aug 2023 22:34:16 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4 ([76.132.59.39])
        by smtp.gmail.com with ESMTPSA id c16-20020aa78810000000b00687933946ddsm569271pfo.23.2023.08.09.22.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:34:16 -0700 (PDT)
Date:   Wed, 9 Aug 2023 22:34:13 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: Fixup Wedge400 dts
Message-ID: <ZNR21UVdfxlvpZAt@taoren-fedora-PC23YAB4>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
 <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcFL7kM1yaA0+ZRSt27a0yreO+AH5cXtSk1TyjqyjH1WA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Wed, Aug 09, 2023 at 08:08:12AM +0000, Joel Stanley wrote:
> On Thu, 3 Aug 2023 at 23:03, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series fixes a few entries in wedge400 device tree.
> >
> > Patch #1 sets spi alias in ast2500-facebook-netbmc-common.dtsi (included
> > by wedge400 dts) to make sure spi bus is consistent with flash labels in
> > flash layout.
> >
> > Patch #2 enables more ADC channels in wedge400 dts.
> >
> > Patch #3 sets eMMC max frequency to 25MHz in wedge400 dts.
> >
> > Tao Ren (3):
> >   ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
> 
> I wondered if we should do this in the aspeed-g5.dtsi.

I also hesitated if I should do it in aspeed-g5.dtsi, but I didn't do it
because I was not sure if others care about the spi aliases.. Should I
send out v2 to move the alias to aspeed-g5.dtsi?

Cheers,

Tao
