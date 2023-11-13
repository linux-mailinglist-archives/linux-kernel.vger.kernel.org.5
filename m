Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF07EA57A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjKMV2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMV2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:28:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CECED4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:28:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so7608619a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699910883; x=1700515683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2LnSTVOTPPVJhBUs4pemeY6xH9iz5VSZGq6s+pwtCI=;
        b=YsvI/kttUWq1dy4BQXd1b67xCBOO8MnwK1obzC8h+WGdotWIFS7uYBbZrnT9/z6+sw
         X/xe4RSfyJdmRFkMs6GnOirjMKDC/407qg/r1q/J4O50RrMXy+7hVIhxTQ/4YwJbhy9u
         L8GNJlG0O+6AZaZ+Ah+ZlgcbAlXzR19dt1gi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910883; x=1700515683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2LnSTVOTPPVJhBUs4pemeY6xH9iz5VSZGq6s+pwtCI=;
        b=pugmML2D+JHxtW+5XsWyuPhUjwh8BFskUF8IIte09usfYY+XKn48eFoNEziaS0+aO7
         6AM5MM0FX44tatew6JbMLOPToYnOg/fRQ63LzxEzYSxvWWpVVgklScRakAAn59Ioypdn
         0QSjWtLMT7JV+NRC81c3yqueGQ4E1iVa4DfKhmsrd+DLTkzmd0N70+AUUmacJffGWlHV
         DAkdVLhJlxG/x4HDrnqIzylRogRSVXlZ2jDRARJ3zSSZ+0Xg2xZx7lUUDL7sTpLIODF8
         My5VRLtlGL+2EdU7jbmO8b/Zf5AeuCV/jPPrN/a6AgyFQ8sz+mcAAk9f3ssxmIc9HIJL
         /fTg==
X-Gm-Message-State: AOJu0Ywx6fJ0xgYjPjqQaoH5WlAZEMBakjC2I+n6NrRGBQn6J9jjmeGQ
        ELNwNItwz5XtcR7A6k/24Tmkc8TkGu/TTkWdZvUttA==
X-Google-Smtp-Source: AGHT+IGFcP5zEQYJgWBbhb7mO1Is5m/8eMpwuPhN400QPTsn7cdsDjd85DSajWbQpoqcJEWA4C/ENQ==
X-Received: by 2002:a17:906:f197:b0:9bd:7b0b:2657 with SMTP id gs23-20020a170906f19700b009bd7b0b2657mr5632558ejb.61.1699910883430;
        Mon, 13 Nov 2023 13:28:03 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b009ae587ce128sm4551772ejb.216.2023.11.13.13.28.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 13:28:02 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so7608586a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 13:28:02 -0800 (PST)
X-Received: by 2002:aa7:de02:0:b0:543:512c:49b8 with SMTP id
 h2-20020aa7de02000000b00543512c49b8mr6092594edv.1.1699910882618; Mon, 13 Nov
 2023 13:28:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whuO0zmuxp_yorYFWdcrALpqjRPhWkmEy+7wcCnnDcPNA@mail.gmail.com>
 <a00ad0e9-8ce2-4704-bbdc-6b0237e27aa3@roeck-us.net>
In-Reply-To: <a00ad0e9-8ce2-4704-bbdc-6b0237e27aa3@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Nov 2023 13:27:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8_w87DraqHcPaudE9+nbWgH1p0jOVA9_=6XdM0ga0QQ@mail.gmail.com>
Message-ID: <CAHk-=wi8_w87DraqHcPaudE9+nbWgH1p0jOVA9_=6XdM0ga0QQ@mail.gmail.com>
Subject: Re: Linux 6.7-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 12:13, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 155 fail: 0
> Qemu test results:
>         total: 530 pass: 530 fail: 0

Whee.

> I don't recall ever getting zero failures (or warning backtraces)
> from my tests in any -rc1.

Don't jinx it.

           Linus
