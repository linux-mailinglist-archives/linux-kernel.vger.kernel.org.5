Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E07D164C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjJTTfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTTfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:35:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49720D52
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:35:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7c95b8d14so13315657b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697830532; x=1698435332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lE8sc7lMxPUTiCNze+DpXwWn8FTfkpYeh3kEHU1GTO8=;
        b=EDVoRq/HlEm8eLCzq1tmhJjgtBU/CJsO9EJh1KQ07TsH2jMAJ3UevR+jp3tzuaZLok
         v0CM4m8tO3Twjl7pup4/UeIqf3eobG3uP7eSd4yN4SvBWpKsRT8DoKuwLiKNL3tHC9SV
         MK+R8awfM0PU0y1zhVEsZAKqcesUBlSNUdiKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697830532; x=1698435332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE8sc7lMxPUTiCNze+DpXwWn8FTfkpYeh3kEHU1GTO8=;
        b=AfcgY5VL/I4bjqQwzg+O5qdXsW06KfZ/kvnrLtXGwokAi9bRhNo5VB17+SsI6ZKlgU
         9S0APk46XazdUFzrHMZa79KexHHa+VczbGfPmhpmVxjA9VA+G0CmbUKvQZhqgpJvssLl
         z6KHektIAn0B5sxFLFAxFlS1ys1wG1mfoujflej+JF+LnEvY2E3mvxK9eNOYGU+LVnX1
         7UJSOWIdlDuAeytvBAhz70SVJJnOUOWdWFI5oNHwH+GNq7s1J6dxbgDjyGWo49J3bh0J
         2V5YDQRdawkpIPBLf7kYpRFYgYz1zAvBQ0K+WzH9zR68xik4Chcu53fMbvhmYvh08adm
         YmCw==
X-Gm-Message-State: AOJu0YwgdI951s45RNMGow7RduaBOoOFyIJ4feyngCna1VsQQapar1ct
        yGnCjnonzrlh09jOttcfTS9r6YsA+N9EwygQCNbRTA==
X-Google-Smtp-Source: AGHT+IFFR6JbKQHRmgDymH+yYcdqV4a00GQtxOE+bW1LRTtg43H8mRXY8EcQ+QbZtDleHGFGavx90BozcrWErCODPls=
X-Received: by 2002:a81:65c2:0:b0:583:3c54:6d89 with SMTP id
 z185-20020a8165c2000000b005833c546d89mr2795753ywb.44.1697830532450; Fri, 20
 Oct 2023 12:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231018235944.1860717-1-markhas@chromium.org>
 <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com> <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
 <5bc82aca-04f2-463b-ba52-34bcae6724d5@linux.intel.com> <CANg-bXCaUOxSTfR1oXKrdnDozA9Hn-NL7mqg+zvLASLQyouChA@mail.gmail.com>
 <80f8a742-4a60-4c75-9093-dcd63de70b66@linux.intel.com>
In-Reply-To: <80f8a742-4a60-4c75-9093-dcd63de70b66@linux.intel.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Fri, 20 Oct 2023 13:35:21 -0600
Message-ID: <CANg-bXBbQVEJ-SwLoHfnu30pCkFcJb9Dywxf603cwUOD6N19Bw@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org,
        Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There's been multiple rounds of discussions with Curtis, we introduced
> DMI_OEM_STRING but it's still not good enough, and now the previous
> conventions are not being followed on what is a relatively old platform
> already...

Thanks for pointing that out. ChromeOS uses the fw_path module
parameter for JSL boards so I missed this. The DMI_BIOS_VERSION should
be consistent across all Chromebooks assuming 3rd party firmware
wasn't installed. I'll throw up another patch addressing this.
