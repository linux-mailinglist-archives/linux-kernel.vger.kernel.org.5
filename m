Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728197F0FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjKTKGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjKTKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:06:38 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9C136
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:06:35 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ac376d311aso44358237b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700474794; x=1701079594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DNEecYXDNkISAqeuDHyscyNZH+ll3zAc9H0rsEG8n/A=;
        b=G+W0JkTabZjzRg06iACmB6/FkqkGR0NbpYn2PvvZRPMxb8Uirl59ZxQJP0qVAfCO8g
         OVbFCB6RqEPRx8o9n79qK14HODSK9iOEKuRit6J0YUW/4mYA3PO+PuhsyWu8UM6m1iqV
         BW3EejeDVT872yAm/LsvqpBeJUtWNIlAn+ne5lb3XYpR+GxUwA4O8G07ljjF1wfsD3hd
         FeKdki4H4/iJ8sYSIpXk25vZPJg25XxTUrKtCyZidnGxWCTky/ii8/nH3/l+VEdL37gh
         w8OiP8JrBk5QlLW6u1rdTgamWjyQUas9p9DnLMlmTk3hc5wVeFvCM+xx1Wg1re3w8wfN
         5Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700474794; x=1701079594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DNEecYXDNkISAqeuDHyscyNZH+ll3zAc9H0rsEG8n/A=;
        b=vgfj8A6/98MCIsYWo9RIeqDmEwvyeDievwiOt5ArrsqYwiGqOJWzCQWGk5TK/6FciQ
         Yfj4Xw/OljElrVL1CUZcdNZvxhwD4fu7G9j9J4X5g1X4mvjMwDZdGnzD3+2kc6YS52S0
         hRQNvXC/wRa+IcagSPS15YzEP8LPSZmLogE2aByeheFxmQS/fn1fL2Jzh868UR04VC8y
         Kh45cpMuRFCyJv3QiBYpwp08HEU4Gdmy4rHZ8yaoUnjYrIBjNgwPATSKmRkXJ97AEvHy
         5yC7pQE8DPzKjp7yKSBxopTkAtJll2PpiofD7SSIAb5nXOZOiE1pGDtE1qoBprJfShyx
         Z3Ow==
X-Gm-Message-State: AOJu0YydTeaxGHAipYSDnvdk7plQbzlFJiFj5Gbh66q1TU9NLveknYRJ
        k56CIwCjVStBWQm3Fg+9G8nUYZjzu8oxcpgj/9dVcg==
X-Google-Smtp-Source: AGHT+IF0XirLyzu/r4rL0oP1ePR55mnYibQFUshEJp5OayiBeY5wdovdVMj6vSvI9qabpBBTQvCn0f9ryoVDfMNt9FY=
X-Received: by 2002:a81:5404:0:b0:5a7:e3f9:a1fb with SMTP id
 i4-20020a815404000000b005a7e3f9a1fbmr8128022ywb.42.1700474794228; Mon, 20 Nov
 2023 02:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20231114150130.497915-1-sui.jingfeng@linux.dev>
 <20231114150130.497915-9-sui.jingfeng@linux.dev> <CAA8EJprQq3aDhzE+yKGZ2-nsuHWcptzMvApsyOi9D63PgeiZ3w@mail.gmail.com>
 <1b59d647-c345-4260-b07b-22abb70ae17a@linux.dev> <CAA8EJppY2+ymX0kLY+cuR=SV1Po2J24r=NQecmb3ZhSE9NHG7Q@mail.gmail.com>
 <7b85d057-3d66-435a-a657-dd69067b6bef@linux.dev> <b9eacd91-8d6f-4265-931e-bc31cadd54d4@linux.dev>
 <CAA8EJpo1KhzTpaSqjbOuQvNKw4WGaqrtNBtNfdNLn28eZVgwhw@mail.gmail.com>
 <cf27d25a-3e51-4292-af63-37e5bc585d88@linux.dev> <CAA8EJprm6FL9_ZOr5uBXNXLBt=scs=FY2o6ZEv5r576iEM5KRw@mail.gmail.com>
 <954e2f85-7ed8-4768-97c4-970315afeec1@linux.dev>
In-Reply-To: <954e2f85-7ed8-4768-97c4-970315afeec1@linux.dev>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 20 Nov 2023 12:06:22 +0200
Message-ID: <CAA8EJprU7+Pwkxb+mHjv52V8Gbgkw--u+xSyEOAM78DN9E+92Q@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/bridge: it66121: Allow link this driver as a lib
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 19:36, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2023/11/17 17:03, Dmitry Baryshkov wrote:
> > On Fri, 17 Nov 2023 at 06:24, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> >> Hi,
> >>
> >> On 2023/11/16 23:23, Dmitry Baryshkov wrote:
> >>>>>> Then you will need some way (fwnode?) to
> >>>>>> discover the bridge chain. And at the last point you will get into the
> >>>>>> device data and/or properties business.
> >>>>>>
> >>>>> No, leave that chance to a more better programmer and forgive me please,
> >>>>> too difficult, I'm afraid of not able to solve. Thanks a lot for the
> >>>>> trust!
> >>>   From my point of view: no.
> >>
> >> I respect the fact that the community prefer generic mechanisms.
> >> If our approach is not what the community want, can I switch back
> >> to my previous solution? I can reduce the duplication of our
> >> localized it66121 driver to a minimal, rewrite it until it meets
> >> the community's requirement. I know our device looks weird and
> >> our approach is not elegant. But at the very least, we could not
> >> mess the community's design up by localize. Otherwise, I don't know
> >> what is the better approach to solve such a problem.
> >>
> >> Can I switch back or any other ideas?
> > I keep on repeating: create the i2c device from your root device
> > driver, which parses BIOS data.
>
>
> You didn't focus on solve the problem, You are focus on solving me.
> How does the method that parsing BIOS data can be generic and applied
> universally?

Parsing BIOS data is unique to your platform (as well as your BIOS
tables). However using and extending (instead of replacing it just for
your platform) is a generic item.

-- 
With best wishes
Dmitry
