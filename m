Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2B97705F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHDQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjHDQ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:28:41 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8746346B3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:28:38 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44756c21105so1519449137.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691166517; x=1691771317;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CmP6zS1uXQ/K4lwCiJguuc04GVnNi9A4y0catAtEmbc=;
        b=sW9yq5KzPS0L46lWKz5VGV38bjUrHawEujFHjlMsubd/4Hqs3gHprOmO4gNbRr5D9j
         bF14WYricFRhWf0RpG7+XjtjygcHTfFEA5NAXecROdNgaMMVevu1CBZfZmnKV4tbVtSI
         3biRnPq6hyMii/k8zEj6YNUBeOWrhTWHVYjBcS9Q9KoJYS0gEemky9i14HCPVj8c90Gj
         tpDxYLUGTg3z8ImpwN4ERkgGoG/gvUa7ZuvIKpLyndXieNsNunV6JM58UxK8RJ+93xM4
         KnJMdzrBQXcGsI4sVicBtIqKlggrB5jDoIRhBzVUeZDo+hBCXfOuqvrP4k9SsE0S89HS
         Dp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166517; x=1691771317;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmP6zS1uXQ/K4lwCiJguuc04GVnNi9A4y0catAtEmbc=;
        b=DJ1y9FI+VjQ3MQrw8uYqGYg+aFG8ocJCRbYUEilhLS5+oEDrZgfMC2/uhWChgHjEO4
         FS2VavWc1YCFlJnMJHXeU3ewe7r+k3sBu6OCMKuCB8n8DADMOSJmz/k7J44bVWBbHt83
         /OQdsXH986q7kdSmgl3teZ0VuUQo6A/2HT6s2HO+eci/kPXxLP6tFghxI/p/JBVe0IHc
         Rj4fZ+WQR2ATI5KXeFtKZQqmJ5IPKyAet8gVKpvXTYRPdsXev9rt7EscHi0gPWwuzmka
         LcA6BGhOWVRJTtN0va2xErw6s6agk5aQ1OJOkytexpmGgPULemmfLdmcJgRGsHKgu6qI
         FL+Q==
X-Gm-Message-State: AOJu0YwaR1dly87+6olFMf39qKyj3bDjinOiXKKLKjks7WHNPy82tOte
        RqKtbkU/93ZhQXpyh2RgAtTheUiezF0Q7OPmsyjUUA==
X-Google-Smtp-Source: AGHT+IHtQ9SnoRs+JPYtT5RMH212OiXnM2yKMpz4zFAz0pvLJ97XKzr3dhy2e6GbNWkDQAh9094YSIW9rpR1kW4fGuk=
X-Received: by 2002:a05:6102:3127:b0:447:c2f5:ee09 with SMTP id
 f7-20020a056102312700b00447c2f5ee09mr134792vsh.2.1691166517567; Fri, 04 Aug
 2023 09:28:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:28:37 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com> <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Fri, 4 Aug 2023 12:28:37 -0400
Message-ID: <CADyTPEwvxrEUnHtMq==nUC7ai8AR-N_1CHXErkQo4Pbfcx0OKQ@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-04, Nick Bowler <nbowler@draconx.ca> wrote:
> As far as I can see, this is supposed to be handled by the code in
> drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
> and I have that set to "y", and it appears to be getting compiled in (that
> is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

Correction: I typed zynqmp-reset.c but file is actually reset-zynqmp.c.

Cheers,
  Nick
