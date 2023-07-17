Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7475684F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjGQPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGQPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:50:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50E138;
        Mon, 17 Jul 2023 08:50:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so6688374a12.0;
        Mon, 17 Jul 2023 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689609044; x=1692201044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flaYrpI0UPSd0fXZsjJuCTiwEJDKtwTVCh1Rk064fNs=;
        b=BQK7SrxMub7yjePhHMRRl9jSwX0pnxyUSe4jCPrbz/hAGXY+1BThoPuSbH/XxMTAfA
         WJ89L41LrRt5eHZnUx1xP9l0AaDDlg1GYLwHgwsoKGYyXNT4OZ0ubjEK4eVWJ0QxaVW9
         hr7esmxiSJjCFZcmDCHkLV6tnfcPEKr7BjjOL7/dvOMfU33gjJslYxF/fMdaaw2H5WJv
         FllG7jf/TZhlW6B70vBPvIi4Hzq3yy1BPniNtnhyVvrbKkPw+Gl7esc2zoG9LWUFh0fL
         jzTsky42Ge4FOPLdkVkKlRKxFm7y1N+xYH4Sf/PpUtzPiq3xiNu9NxL2XvUJ0lAhLnT0
         E/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689609044; x=1692201044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flaYrpI0UPSd0fXZsjJuCTiwEJDKtwTVCh1Rk064fNs=;
        b=aPhpivUile+9EWi9GNWul4RGdLrf3S+TDn07ruhDAs8XjnjFShpLnJ5I88ad4oCSIQ
         J2cO1LtcUOIr+iCeu7C4TzuRS+5kc+vBkNK7Jbuls6nVzyX8bPeiMlG4zPth1ciztWka
         np6a9uJnCpr0qRmDoYaPziKGdG8H/XgAeFlEPHt1aNSo5VF+/GxCOHYkGRT8DCYIUKqS
         75LfxGxwzfweoHJqMe4/ZOtm08XvIH1+i1tXc3Smlr+A11aGJlqjZ2mTgXuhBxH1Vbe5
         HNZBS3JUMJbOKhYVNfuNjmSERAoKEGbsuvGD6NJzrhyVtvXuW3eyDRM1Abvhojuqo9gE
         55/Q==
X-Gm-Message-State: ABy/qLZ8e2trGy4oy5PJFwbEMAsg8q8k1PLLD9iU44EJoU3tdebEeuRw
        pZdeRQEUyBEDSggUYH2/ewTM5i1GmAhw+tEunIgcOCB/Nvw=
X-Google-Smtp-Source: APBJJlHa5x8Hixl3P5B/fH3zB92uTaTlucvbrAhvAmfNBMeqefGonoQsmRUfI0qGGv80PmCSJWeVAhV48qetdOARHhE=
X-Received: by 2002:a05:6402:14d1:b0:51e:fa7:a292 with SMTP id
 f17-20020a05640214d100b0051e0fa7a292mr11182199edx.12.1689609043857; Mon, 17
 Jul 2023 08:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230714175042.4065815-1-robh@kernel.org>
In-Reply-To: <20230714175042.4065815-1-robh@kernel.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 17 Jul 2023 16:50:08 +0100
Message-ID: <CADVatmNtQ8HW24QUumzn_w=wQaRf4+5Yj+JBHy9WkKHoXk=ckg@mail.gmail.com>
Subject: Re: [PATCH] parport: Explicitly include correct DT includes
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 18:51, Rob Herring <robh@kernel.org> wrote:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
