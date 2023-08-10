Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD79777333
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjHJImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjHJImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:42:09 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C6211E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:42:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so584158276.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691656928; x=1692261728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weORogC0MVWRhV6ssfye+wxDML/n1t2mu4TTWlqW8ec=;
        b=KIg6LL86oXZugWxeJFc/04PLXxcZCxDTyGJBSCGNyXf+QiGiyjsjxzhIpk8hz/hmln
         m480YoipQH26dAyoeP/oh8dSQ5NT2UONX8TmCS/PVnA8B71mzxOyKcyn0h9TuF6+HmBn
         gDo/JIfg6olCnO0SF8mjEskOP+H2Flxoh9VlRcuZo3WIw82SP7JyP+9K1+HDRTa65AFY
         59Own3Xs5PZs6ePAbhzjNesDCKkKDH/MX23MFmq9WBhjSldO9/4ajEaBRf99RxM9sLP8
         B4ywy3ME75XhgD3k0XjoGHHy294Ad4Z0GXyZGRge6SgGZNQ6leNme/IlvZaps2bloYyS
         K/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691656928; x=1692261728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weORogC0MVWRhV6ssfye+wxDML/n1t2mu4TTWlqW8ec=;
        b=VtnerIEkIa0oH5kSyGDZ35Kgb182ekyWnnj+FSRlxdI9k4tBQcN+d2cQ8wQZTM1OtI
         4qGq1MW2J4DPMhzpsRMrr1pbPCmkTXVV4kZMOSIwwgLFpvl7Mkb78V4wTER7Q45NA4lE
         grl9VLnCnFaaCqXcZYG5IwsOMjtpZKJsp4mWjrLEsvltPhcODTX5H3xW48wAgA5ns5i/
         h/3punchg3SopHiXtqnHNJmWu4kGWJ5JFZhwssR7rVIfeCFIGEIZCWuhbwOF/MxpUPoZ
         zjkR/R1xC0F9rLYElpYTa1R4S8LHHjaRng7G2pquPFrToTS8SLwymHD4XNOwt8WRsi+E
         WaMQ==
X-Gm-Message-State: AOJu0Yyy3x3pP5LN2I59Hrx+8EQpDMEZ1mjYh2v5PAuHtARzxhXfJ9Ti
        x/rbwlcNEgwrD2sEgowzxp7X5S/nd96xPWYo4lY6vg==
X-Google-Smtp-Source: AGHT+IF9Tb7QX6+7PoBWglP+hIJ2WJkSQPVgQQHuclqmq/vh7Jz6qT2/SGQEz7MoFPymQ9gtliw52JMmLAsOIZexa1s=
X-Received: by 2002:a25:e7d0:0:b0:c39:9e09:2c71 with SMTP id
 e199-20020a25e7d0000000b00c399e092c71mr1844510ybh.41.1691656928030; Thu, 10
 Aug 2023 01:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230808180733.2081353-1-florian.fainelli@broadcom.com> <20230808180733.2081353-3-florian.fainelli@broadcom.com>
In-Reply-To: <20230808180733.2081353-3-florian.fainelli@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 10:41:57 +0200
Message-ID: <CACRpkdZF6Wah1DcZ8ZLEJ5NCEVBRKcrTbJRAP69qBQK6WSuZgA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] pinctrl: nsp-gpio: Silence probe deferral messages
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 8:07=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:

> We can have gpiochip_add_data() return -EPROBE_DEFER which will make
> us produce the "unable to add GPIO chip" message which is confusing.
> Use dev_err_probe() to silence probe deferral messages.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Patch applied.

Yours,
Linus Walleij
