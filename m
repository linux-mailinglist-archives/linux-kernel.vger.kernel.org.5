Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5617F621A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345946AbjKWOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbjKWOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:54:10 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BCD54
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:54:17 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5ccf64439bdso9014087b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700751256; x=1701356056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQCVfDsgWY/zTEVOFXIzheR2Sa3G525xrhmxUR9vYaY=;
        b=xTY/PLMpFbaFomzwHNSLOdlofBOgPClhPWKODikwkx3YFfRsqgS+hI9UCEW93DJ7KX
         h+8y1RKlHZpt5yFkzM+BbuXjzOQpFZjqlpwn5+XH14+N7o4iWLF9PdS15kUTE9n+Unmy
         8rqxy31EHiZCU3XyG8fF5G98qJEDPJg+wYq2LClQKmNd/MC9zbrEdtPRx5JrATlAfxNa
         X7cunmGJp3VNOramYg2XGSSsQmpOgff+KeGnbTJXSLWr/YtajIxNDcab080kwfd9PLoZ
         VGgVg+xLwIdHJK/DcNT+mwCGqx4yT2PhAdq+2hhbJHz7bInb346istmKe+DreM5/mpaO
         Xrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700751256; x=1701356056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQCVfDsgWY/zTEVOFXIzheR2Sa3G525xrhmxUR9vYaY=;
        b=Xuccd3j18hWst1ivC0GXqp8LPA7SDnW+obRXbq9J6ZrRCOLkDWoE1n9XZSmDDuhutM
         owgqYECLkUNoG3/umvCrISEInbIihP3wo1lG8H+/42Y8NiVEDw1J/w7zhJTEkLnWlVkg
         iVcBo1sYa9lX1mSjJHwwU5GH6inMpbO8aTM5BD4r5iWK/QpBPotAk1Sy+ASk1jqgfTPG
         GpBLNHnx+DhK745X5U9axoapT/XHjGnYNgvSxPRgO7eCMXQns8S4uctwfl4WijLyu+ql
         q3fYPvhDyLEJfnQtKDIQcEr5WtvaCmdv2X+shj6WgeI2/nQuRprMp49/FCNSKnRCf5ck
         Oe3w==
X-Gm-Message-State: AOJu0YxOWDHymEojZ7iJPlohr6xjSJqTIe1C+UQKlsL2i2Q0t2VqWurM
        8yX1hJWKS0l3HRVq6CLZX8OyquT7DQ/A+N2C5vDv8TcuqWO4ctFRxZg=
X-Google-Smtp-Source: AGHT+IH7Rd4xWDlbVC5YrXQiBqLegP0WAhDlB1Gbob2IIRXsUjvJ1TZmETFwS+DNwRNcvADWUlL5b8s7EMfqmgNxeBU=
X-Received: by 2002:a81:4fcd:0:b0:5cc:dfdf:7f40 with SMTP id
 d196-20020a814fcd000000b005ccdfdf7f40mr2326675ywb.2.1700751256151; Thu, 23
 Nov 2023 06:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20231122175039.2289945-1-andriy.shevchenko@linux.intel.com> <20231122175039.2289945-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231122175039.2289945-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Nov 2023 15:54:04 +0100
Message-ID: <CACRpkdY8Crm1TVf_6kCZ1EhizymaxU6g4ik2UOYBoqLf8XBCLA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] pinctrl: baytrail: Move default strength
 assignment to a switch-case
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 6:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> iWhen ->pin_config_set() is called from the GPIO library (assumed
> GpioIo() ACPI resource), the argument can be 1, when, for example,
> PullDefault is provided. In such case we supply sane default in
> the driver. Move that default assingment to a switch-case, so
> it will be consolidated in one place.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
