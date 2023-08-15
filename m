Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4535677D205
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjHOSjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbjHOSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:39:21 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8F183;
        Tue, 15 Aug 2023 11:39:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc83a96067so35392635ad.0;
        Tue, 15 Aug 2023 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692124757; x=1692729557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UY0hcbqXkGu4hQCXduSf+UdTZqnAteMXNS0OUvIID4s=;
        b=ZW6VNxPUeqoIZbeoqBqk0wvZbAGTgOBhXM6+1JuGOJglarFKtoFMqlxsN090Qx3LM5
         vjLVoB9rfAFsHWKFSFDh9p2c5mKkY6pwufZbkdM/NL1wTpFMczI+Z75wTSREixHlmEJp
         rAx49jbXeaDftfhbEdS2RYKaoN67x789Ci830p1pgRxdu/UcspSDvVPw1l6FF60TB4Qn
         BJDAb2g5nVuxx89T9TDAhrDFUZSVJV8Pk3UxVtUFL06RCuKh+wg8CH09ESKjbGJPo4qL
         /EM+YqXzvIHea/ciZEI14RFtKWJjygTAx+PfzBspfCx0FcvUpgvmHbT5oKl8MqRvdP2b
         TAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692124757; x=1692729557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UY0hcbqXkGu4hQCXduSf+UdTZqnAteMXNS0OUvIID4s=;
        b=NyBc77BRDflqcE8PI2P4PmraDM3RZx8ycqGTZfSai+5yJC8lM8EYZV1VzUv6UNiy8k
         +Qj5/8LvW4uw/7MHo4OjScCReeBSccrg+8zC90dmK/5RHqvZW5YcCqJCM/f54hc8vq1B
         R8xEyuR6nwmylJJrHL6qZ1RzaLiSDTtygkUr17rMcapJ3tXIXi/72LaAPWc3bo9moW5H
         Lw3krLJIc2HwFHe88T0B4C0MW5HdZShNGXik4kp/6Di7SKnO4yvMhcRCj8kTTiV6K6sM
         YrFu8bSwKLBtrudIyYu85Z74vTspclF8dkAElIrh4hLhsMHesMxpaB6iVK5pbXgDiAi1
         1h8g==
X-Gm-Message-State: AOJu0Yz+Y9wzh3aZzCFj0uVy1G0fySvVS/IMubE6HGL5AwlyhCkLwg7a
        LOl2SpHXnolnXUEnBzICAFE=
X-Google-Smtp-Source: AGHT+IHbmeLEyPYNBRfP+z3Wig5BBPHQX/1nvhkQOBJwzEvXlIankVnjcK4YDvXeTnHZGQMStVY8tg==
X-Received: by 2002:a17:903:22c7:b0:1b8:9552:ca with SMTP id y7-20020a17090322c700b001b8955200camr14039440plg.45.1692124757148;
        Tue, 15 Aug 2023 11:39:17 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e30b:29e0:bebc:3d56])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001a183ade911sm4938894plz.56.2023.08.15.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:39:16 -0700 (PDT)
Date:   Tue, 15 Aug 2023 11:39:12 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Felix Engelhardt <felix.engelhardt@eidu.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input/touchscreen/goodix.c: Add support for ACPI
 ID GDX9110
Message-ID: <ZNvGULYiPb3nqiu7@google.com>
References: <20230807124723.382899-1-felix.engelhardt@eidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807124723.382899-1-felix.engelhardt@eidu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:47:23PM +0200, Felix Engelhardt wrote:
> The Goodix touchscreen controller with ACPI ID GDX9110 was not recognized
> by the goodix driver. This patch adds this ID to the list of supported IDs,
> allowing the driver to be used with this device. The change will allow
> Linux to be used on ~1 million tablet devices used in Kenyan primary
> schools.
> 
> Signed-off-by: Felix Engelhardt <felix.engelhardt@eidu.com>

Applied, thank you.

-- 
Dmitry
