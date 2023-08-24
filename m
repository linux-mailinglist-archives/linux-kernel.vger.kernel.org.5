Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363DF787736
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbjHXRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjHXRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 13:37:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D819AC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:37:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bec3a81c4so96928b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692898673; x=1693503473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZX9ZEXWSiOCvJp9CFzqaquNBXaibHiG0dOL3pBL8NU=;
        b=JvA5CGXp+uTaxLRysTcu+2kc4PlKUbDvleVAikSv2cPKAulLMqwu676lH6n+oYrmpc
         z90tCuKD0sQgAGr+U0/sEzDhQDe1ioKhBpxVfMYqeL+PTWw1dLn2VOMNCRAQcFRwq4wC
         WVdK2566XCEI50XN+Yh/Q7IP5TN3IP2Mnhg6xGrwZP3PcCaDmF+liW+Kk/W/i47R1dZV
         2+XfI2IYrY4qCFl8doeeC0j41WrGbG2PcjHrnR7TMBaERDa+QMd/IB4ibcI8H4V7R8rC
         /EtXsuEllJJKZd3egu3r+2Kx0BdU4lyx9EWfeJ3dDMGZZYX8PJ/8XfzrQFC+KZMfPLby
         C+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692898673; x=1693503473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZX9ZEXWSiOCvJp9CFzqaquNBXaibHiG0dOL3pBL8NU=;
        b=eiKuTkScJ60YUE1015+VhAdwl1lJvT4Q+pQ3RA9buiuEMEeb0sSFuak75Hv8FPBq5n
         BWhAVJYX5vxZVO6tZebsRn8o7NUj9E8TcY/Wlfm0c+ZUSZWa2C4HziMXfDc4SyeNkEqx
         oLjlUjNnQh1ZwpPgqOpmHQMFoFDEpYkDUFVTNN0GUSmLzSwLQUTNIt8utFZpl0/VQ4ZF
         hgAQeucNPH9apmcWOT4ea4LXferJjV+KCL+2emNj7S5UzrBJ1iTI7F92EbRIKs8S2SjZ
         pd/U7nhz3xL7M+H2MqGqcPSvXzExvy/0bBkyapDknXHnJMsz2I5kjIWGhXM3IL8Qk3QL
         9KEg==
X-Gm-Message-State: AOJu0YwGgNgTe8TU+qZUdb+rW3EIOfw/2/WqeBC4aSkvdo6PN85au3ct
        S1dARMiUl3pZRq4K1ra6rGg=
X-Google-Smtp-Source: AGHT+IE2S3owUZ8hfhM8ym+39zpLUlWI0vP9zliq1J0ii6d4atS7e7AgsxdU2xhH4u4B7jRnu4sBrQ==
X-Received: by 2002:a05:6a00:2d83:b0:68b:e8b8:b9ee with SMTP id fb3-20020a056a002d8300b0068be8b8b9eemr5614968pfb.11.1692898672788;
        Thu, 24 Aug 2023 10:37:52 -0700 (PDT)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7800c000000b00687dde8ae5dsm11774pfi.154.2023.08.24.10.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 10:37:52 -0700 (PDT)
From:   SungHwan Jung <onenowy@gmail.com>
To:     fabian@ritter-vogt.de
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        onenowy@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for mute LEDs on HP ENVY x360 15-eu0xxx
Date:   Fri, 25 Aug 2023 02:37:18 +0900
Message-ID: <20230824173718.7992-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <4504056.LvFx2qVVIh@fabians-envy>
References: <4504056.LvFx2qVVIh@fabians-envy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:57 AM Fabian Vogt <fabian@ritter-vogt.de> wrote:
> I see that SungHwan Jung (CC'd) recently submitted the same fixup for
> a rather similar but different model as
> "ALSA: hda/realtek: Add quirk for HP Victus 16-d1xxx to enable mute LED"
> Does your HP Victus also need the ALC245_FIXUP_HP_GPIO_LED? Then we could
> combine the quirks.

These victus laptops don't need ALC245_FIXUP_HP_GPIO_LED, but we can make
alc245_fixup_hp_x360_mute_led and alc245_fixup_hp_mute_led_coefbit into
one function.
