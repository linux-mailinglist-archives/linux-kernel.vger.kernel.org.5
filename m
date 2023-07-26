Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432B762AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGZFNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjGZFNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:13:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC41FEF;
        Tue, 25 Jul 2023 22:13:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb9e6c2a90so23807735ad.1;
        Tue, 25 Jul 2023 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690348399; x=1690953199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DtrEaFfo8x6emOs1D//fwh86nl0OQq9+shDvNUTzzI=;
        b=ecAWAFxF4vH+F1u7hfSajjUYFXZD+mYyTqPNCcv9r0xCL8EvmblATmsk/oZnRjQZ6w
         c++tOw/zs3BjRGQ3InNSuprYjIbsMy7Wv/l1BDPJJKtmqilqAjSvYoLv5hNefnIkH0NZ
         ceoZqReVNr5UaZd8KVemETcViPenSYUtXaKZHQgvEEDarzb8ToNCJ7PaxP2daiNji4DI
         AS4Lgb43qMbEFsIyYAnEZowjO5TLz/CqihaEn8zOU6f/Z1r6ZS4kpvpszokzPXPpzPNk
         VZ8H/cBk7cPdh39cqqQEBocMEhK8a1nNr8QaTWQh+55e0+4kBheszS92cHFSnYwWWO1a
         ijmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690348399; x=1690953199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DtrEaFfo8x6emOs1D//fwh86nl0OQq9+shDvNUTzzI=;
        b=eEoBlC6oBqJRDknrG17+yH2yZbbcQc0Ly0Sd65cX0RcY6hm8/e3LmTov1SFCmDOt5s
         91t8m5GL4F0ggFO4r0DTaANZqQufUFn7V9Lg4SUNEr9uxwy7cg5Dq7ELZe6yBj1IrYne
         TQhIhJKvCeWhkZjjNexXOflyr9NR7AzjyEzkZOUc7RkE+iy7OU/e2W3f9dzPqCpnQncr
         enT2SS/1oK0/FYkrbNvqhZq45tPHmLjTKTp0q4B2hzmHIwixO5kosuv4c0Rkdmlcmi/3
         umeODBG29TEPco0Y3J3DhEYzgcTivrPVJsMxolnsABbJdxIhCVDpV0YV5rr/ejQdx83C
         rUpg==
X-Gm-Message-State: ABy/qLZOLE/O6UUOrd+xwXVRRauH5/y2Np/TFAS++q3nINHt6GLxqO1Q
        AvtbPia2cjPFT2TdRSCViKM=
X-Google-Smtp-Source: APBJJlFm+PJcebLguiskJ7NqyqvZQ9jS0sDg0FiNxWGKpPfh7zilLcfbX7YgOc+IdyFSbHEcqa2zvw==
X-Received: by 2002:a17:903:41d2:b0:1b2:a63:95aa with SMTP id u18-20020a17090341d200b001b20a6395aamr1390892ple.54.1690348398510;
        Tue, 25 Jul 2023 22:13:18 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:83ca:1b31:2c:d986])
        by smtp.gmail.com with ESMTPSA id bf10-20020a170902b90a00b001b8c6890623sm11985979plb.7.2023.07.25.22.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:13:18 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:13:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jeffery Miller <jefferymiller@google.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Jonathan Denose <jdenose@chromium.org>, jdenose@google.com,
        Andrew Duggan <aduggan@synaptics.com>,
        Andrew Duggan <andrew@duggan.us>, loic.poulain@linaro.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: psmouse - add delay when deactivating for
 SMBus mode
Message-ID: <ZMCra8UjEhJsEc9S@google.com>
References: <20230726025256.81174-1-jefferymiller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726025256.81174-1-jefferymiller@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:52:48AM +0000, Jeffery Miller wrote:
> There is a period of time between the psmouse deactivate and the
> ability to communicate with the SMBus companion. Insert a
> sleep after the deactivate to account for the delay and ensure
> the SMBus companion is responsive.
> 
> Attempting to read from the SMBus companion too quickly was causing
> the touchpad on machines with an i801_smbus companion to stop working
> after a sleep/resume cycle.
> 
> On resume the rmi4_smbus would fail with errors reading the SMBus version
> number:
> ```
> [5454] i2c_i801:i801_check_post:414: i801_smbus 0000:00:1f.3: No response
> smbus_result: i2c-0 a=02c f=0000 c=fd BYTE_DATA rd res=-6
> rmi4_smbus 0-002c: failed to get SMBus version number!
> ...
> rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -6.
> rmi4_f01 rmi4-00.fn01: Resume failed with code -6.
> rmi4_physical rmi4-00: Failed to suspend functions: -6
> rmi4_smbus 0-002c: Failed to resume device: -6
> ```
> In this case the rmi_smb_get_version fails with -ENXIO if it happens too
> soon after the preceding serio_resume -> psmouse_deactivate call.
> 
> On boot this issue could cause the touchpad to stay in the limited PS/2
> mode. This only reproduced in 1 in 10 boots on the Lenovo T440p.
> Failures in the log on boot would show up as:
> ```
> psmouse serio1: synaptics: Trying to set up SMBus access
> [122] i2c_i801:i801_check_post:437: i801_smbus 0000:00:1f.3: No response
> psmouse serio1: synaptics: SMbus companion is not ready yet
> ```
> 
> Experimentation on the Lenovo T440p showed that a delay of 7-12ms on
> resume allowed the companion to respond.
> 
> The 30ms delay in this patch was chosen based on the linux-input message:
> Link: https://lore.kernel.org/all/BYAPR03MB47572F2C65E52ED673238D41B2439@BYAPR03MB4757.namprd03.prod.outlook.com/
> 
> Signed-off-by: Jeffery Miller <jefferymiller@google.com>

Applied, thank you.

-- 
Dmitry
