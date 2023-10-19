Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284F7D0263
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbjJSTVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345878AbjJSTVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:21:20 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96522114;
        Thu, 19 Oct 2023 12:21:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d129e2e7cso71415a91.3;
        Thu, 19 Oct 2023 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697743276; x=1698348076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HI2GVWsYasNpFkCUuFSfyfrgfawERt55U8XyVGdh4SA=;
        b=Ovci2yKXiQ1jgKsGCoSxXz/PI+mDEm06VI1sUUvZnF+NsvhGIrnqeITtc447fue2jr
         IyPjwX8XurfX3a/HeEFoe6wsfGokRa5foPqJcHv1517tmN59gIFLGWPn1jzY/PUdreLi
         PsRpsfhqlUxHoTooZtNKiLp/v7TctG3owlFMdYSSx9S+r0f9vFUaMTAPhXzKCSPrI68x
         KopxamLzKwDSFdzN2mkwiJkbrbTHCadHQdMKhIgJ0InJ0/8mME1jBfDaRqRKpv3eQIO1
         3eDvjvS8zJVqQJgSQ17ok66JiMGrx51jaLFwWpuGV7WVILTjIBqXp25HElmDEAc9BQc3
         62Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743276; x=1698348076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HI2GVWsYasNpFkCUuFSfyfrgfawERt55U8XyVGdh4SA=;
        b=OfBkBkiLWnyYvv3NwEQhBg2u+3wI5hhxy565wZICSohErGw28WF8iEStbxx+PvNjnA
         GGpwQB77Mj5TIygFPHCtMF+JgMgBkJSBCVM6qslmQZSfFj/4FALCrivaiu9JVYt/l1Nk
         5e4t5a9OBEu3KyvhKiz0IxIrX2dNw8Tb3Yb/Od6Ml8mH61jpi6iZTf47PaKVDmSoGacY
         x3gPBQ5vtFvjXROg4bqm+xk/au+mfKATT86oL71qIrxzv+zJ+vqx8C/mgSVdGym8Xvek
         u/5Kpn0dW/qy/mkiOkStmc7OHgPe9+QAXgxWw2IBCknRPiPyB+pMjqyMJwwkwrGAHmqz
         TX9Q==
X-Gm-Message-State: AOJu0YxmnjT5UXcqfyx0jSq5elfkgd9h5cvRIid2ru5wmGkSOPqrYPWu
        16IUi2ZPu5NMzKOgrNPK4+ZNnElT52s=
X-Google-Smtp-Source: AGHT+IG6uLhIiISw4NsI2oZ3knWAOF7551FfjEQY1Xf9H8/u/9rkw7UwL9aAGqUk9V7ANx7JwR5qLA==
X-Received: by 2002:a17:90a:196:b0:27d:8d42:6def with SMTP id 22-20020a17090a019600b0027d8d426defmr2975229pjc.34.1697743275856;
        Thu, 19 Oct 2023 12:21:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c4c4:bbd9:2220:727f])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a7f0500b00267b38f5e13sm134133pjl.2.2023.10.19.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 12:21:15 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:21:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZTGBqEUzgGCcZP1B@google.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:
> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been broken and hence lost a bit of sense. Restore debug
> messaging in gpiod_find_and_request() when configuring the GPIO
> line via gpiod_configure_flags().

Could you give an example of the before/after messages to show exavtly
what is being improved?

Thanks.

-- 
Dmitry
