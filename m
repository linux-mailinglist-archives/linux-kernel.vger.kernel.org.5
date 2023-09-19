Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF947A5ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjISHUQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 03:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjISHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:20:15 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F7102;
        Tue, 19 Sep 2023 00:20:09 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59ec6d7bb89so10536687b3.2;
        Tue, 19 Sep 2023 00:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108008; x=1695712808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo6GeNFpLlGOQI2skflDC69t+uMur/RFCpLqTRniHYk=;
        b=TyGGjzmSGJZEldzjehK54K/s8hzTrWAPt+d4jVGaWDh72hx84pyS+GgRbl7DdIhchp
         ZvDFVk5SmGy9HhNoGY7Riz0P2sktiIM4c+q3z6rP2XynxEVYUiK8Ti6i4tHP3fOtVkGj
         UNHIWbFYhUKB/Wp/zjIyigkqP2aOQhMuOUWXijtidKh+Fl2fy+wWNctbKAXlIpYJns1W
         zojJa0asrSqcQihHsk9XatgJU20kFOZY7vtctX2LtfKg6McEBRRAVYd/aC5RE3txxod2
         0yivDbaXEKBYoNJ9gbKt9ZoTreSa1DjuFbG6D6V9BhfCHcCkLzrGGvVY8XiCNcWG+FHy
         Hvpw==
X-Gm-Message-State: AOJu0YxPVpojtEnpjYq6lZjH5dh0uVy26vbchi+u0ISDkEBpCDI2DQF3
        INfN18qgGWyEloxCSVddZ1nIsxDS0nZCEw==
X-Google-Smtp-Source: AGHT+IGr3jxIj37/Mu4rv7iXYA2sJBS9RCoxRtz3Y3n/qoElqL6+yqJVOSi28j1UqGOVjpbbAJ2CUg==
X-Received: by 2002:a81:df06:0:b0:599:b570:2db7 with SMTP id c6-20020a81df06000000b00599b5702db7mr10420183ywn.30.1695108008315;
        Tue, 19 Sep 2023 00:20:08 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id j124-20020a0dc782000000b0059af121d0b8sm3080319ywd.52.2023.09.19.00.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 00:20:08 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59e8d963adbso22485717b3.0;
        Tue, 19 Sep 2023 00:20:08 -0700 (PDT)
X-Received: by 2002:a0d:db50:0:b0:59b:cda7:893e with SMTP id
 d77-20020a0ddb50000000b0059bcda7893emr11229694ywe.15.1695108008002; Tue, 19
 Sep 2023 00:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918175529.19011-6-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-6-peter@n8pjl.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 09:19:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQaBBZgSsgZyNR2HxMsck2fWNjG6fK93eBFFeyDz0Hkw@mail.gmail.com>
Message-ID: <CAMuHMdVQaBBZgSsgZyNR2HxMsck2fWNjG6fK93eBFFeyDz0Hkw@mail.gmail.com>
Subject: Re: [PATCH 5/7] arch: m68k: remove ReiserFS from defconfig
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-m68k@lists.linux-m68k.org, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Sep 18, 2023 at 7:57 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
> ReiserFS has been deprecated for a year and a half, yet is still built
> as part of a defconfig kernel.
>
> According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
> filesystem is slated to be removed in 2025. Remove it from the defconfig
> profiles now, as part of its deprecation process.
>
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>

Thanks for your patch!

Given these defconfigs enable ReiserFS as a module (not built-in),
and that ReiserFS is still available upstream, and enabled by distros
like Debian, I would like to keep it that way.
The m68k defconfigs will be updated after the removal of ReiserFS,
as part of the regular defconfig resync.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
