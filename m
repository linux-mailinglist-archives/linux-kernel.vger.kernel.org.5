Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B57CCA51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjJQSEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjJQSEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:04:51 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3512993;
        Tue, 17 Oct 2023 11:04:49 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6c63117a659so3633288a34.0;
        Tue, 17 Oct 2023 11:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697565888; x=1698170688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQMZZNtwxKp6PHrZvBpFDkR2RCeELkDJh7t0tRAV+Uk=;
        b=kfL9BHl1EzWyPNBXPsIcguFKKkMYU87ArwX2jjS4aglNvvJ4pYsFEGQCYcQszL8KU3
         c9MOFVCQAlrQ0bh1Jj8v06p4YOxpcT3G6TXCpRUgPHkkT7u8X9oLelEWF8dAs/TU5ltD
         IWqmlgiXG1kgiNWWsNOpILKnBYu6Yb1pWeUEI4XxicUSUWCqTqN9b7BI7rmCbnyoXiVs
         3v52qLhQqhMMnvbUr1XFPWWliLhLacs+sWX/QV5a/s6rggNI03lkQ7RX6i8IrdXsry8y
         DCYcpuzhm3ibhZXdhpu2MjP6nFBKcKZ0RkR2buCoY38uc8lqMLxVt8NkKlU1cZAKlYZB
         Ralg==
X-Gm-Message-State: AOJu0YwTOzjKFqRt/1oDr6hBrwYgwAHlLt9FhzlLt4m6OV2jL+MMbLId
        n9GaqihJ7IxcvkOmdmO0Vg==
X-Google-Smtp-Source: AGHT+IEIu8IPZQgV4rX5TrvEag75rqOcwwjFqP0xMOKHnwKuurJMGdtfsuM15VDdYSV6q3G4M5GkGQ==
X-Received: by 2002:a9d:65c8:0:b0:6b9:c49f:1af7 with SMTP id z8-20020a9d65c8000000b006b9c49f1af7mr3029577oth.20.1697565888470;
        Tue, 17 Oct 2023 11:04:48 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a056830104700b006c6311b15f6sm338959otp.38.2023.10.17.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 11:04:47 -0700 (PDT)
Received: (nullmailer pid 2258965 invoked by uid 1000);
        Tue, 17 Oct 2023 18:04:46 -0000
Date:   Tue, 17 Oct 2023 13:04:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     dri-devel@lists.freedesktop.org, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Helge Deller <deller@gmx.de>,
        Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v1] dt-bindings: backlight: add brightness-levels related
 common properties
Message-ID: <169756588486.2258419.14570431419592615885.robh@kernel.org>
References: <20231016150554.27144-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016150554.27144-1-f.suligoi@asem.it>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 17:05:54 +0200, Flavio Suligoi wrote:
> Both files pwm-backlight.yaml and led-backlight.yaml contain properties
> in common with each other, regarding the brightness levels:
> 
> - brightness-levels
> - default-brightness-level
> 
> These properties can then be moved to backlight/common.yaml.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  .../bindings/leds/backlight/common.yaml       | 17 ++++++++++++++++
>  .../leds/backlight/led-backlight.yaml         | 19 ++++--------------
>  .../leds/backlight/pwm-backlight.yaml         | 20 ++++---------------
>  3 files changed, 25 insertions(+), 31 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

