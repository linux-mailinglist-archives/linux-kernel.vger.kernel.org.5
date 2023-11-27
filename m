Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF947FACC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjK0VsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjK0VsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:48:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70DC1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:48:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so6551100a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701121692; x=1701726492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKKlccevI+V8zjbSDJyAdH23CW5Jz9/+6agZp8F66zg=;
        b=jH5dOasFCxL1Ly06bltGrzQc87ISW3s6HTGtWenqJmueaAM0phwUZ/ctDh0S4DvEsh
         sn0BxRsMVuP3q/eM+70vj7Q9h9BlwTSko2CigYUSkMwKiDhpFqhRHWTYDdOe0iwkziXZ
         RkGqy3ZEUOueYYyZ1WjidZy2x/8QbZqlKBgAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701121692; x=1701726492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKKlccevI+V8zjbSDJyAdH23CW5Jz9/+6agZp8F66zg=;
        b=F636LcYDtQG9KLGJl9zVe81KAGgrI4mpgMfG53sBz+OwUejIqzE5ujmEpHoxVmaOmZ
         8iKKtlqwdcqyb148skXZboTyU8R0YzqI16YotcrLV0H0OIAz38aqmIkKBJDOX7f7qGdN
         Z0m2qjkkg04Q28oH9YoiuMBMy1LMeA21VAZmgV5v6k1eWzOSlkBE2qKTLMflIfUYI0Uu
         ZcKnG/zAjGmsn6tkhkPNONOLLJOMBSjdJNh23G1OhvTlMM1W0OSXDQIhuwpUO7xLfI/4
         PGkqd78qW0+rgCjWXXr1uPJI/1yS1PrPHnRuN9JXEmXEUjT+afLnKD9+Pc8zEUKUvqZQ
         b+MA==
X-Gm-Message-State: AOJu0Yyaaf+D8aCiNSTHae8ErtBNfZyrXe0Vo9MQwkcJsad/NpW+gFW1
        BTMKiWK9LVc0OTdQx8xaZfF4ybmqIoXp942OQZQavA==
X-Google-Smtp-Source: AGHT+IG9H+0FWmYQ1XnTD5CMnPQWW4cAQPVt0IyMmo0eDOoe/yBU2HPG7hkjo6PQxpmfzuxSGulUVw==
X-Received: by 2002:a17:906:518e:b0:a12:b06:fa39 with SMTP id y14-20020a170906518e00b00a120b06fa39mr940541ejk.73.1701121691749;
        Mon, 27 Nov 2023 13:48:11 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id k18-20020a170906579200b009ffe3e82bbasm6109317ejq.136.2023.11.27.13.48.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 13:48:11 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so2905e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:48:11 -0800 (PST)
X-Received: by 2002:a05:600c:3c83:b0:3f4:fb7:48d4 with SMTP id
 bg3-20020a05600c3c8300b003f40fb748d4mr678223wmb.3.1701121690971; Mon, 27 Nov
 2023 13:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20231123084022.10302-1-lizhe.67@bytedance.com>
In-Reply-To: <20231123084022.10302-1-lizhe.67@bytedance.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Nov 2023 13:47:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ux09EUZwpW3tYFEYG=LfYDibmHrgczF03_EszLykagUQ@mail.gmail.com>
Message-ID: <CAD=FV=Ux09EUZwpW3tYFEYG=LfYDibmHrgczF03_EszLykagUQ@mail.gmail.com>
Subject: Re: [PATCH v3] softlockup: serialized softlockup's log
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, pmladek@suse.com,
        lecopzer.chen@mediatek.com, kernelfans@gmail.com,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 23, 2023 at 12:41=E2=80=AFAM <lizhe.67@bytedance.com> wrote:
>
> From: Li Zhe <lizhe.67@bytedance.com>
>
> If multiple CPUs trigger softlockup at the same time with
> 'softlockup_all_cpu_backtrace=3D0', the softlockup's logs will appear
> staggeredly in dmesg, which will affect the viewing of the logs for
> developer. Since the code path for outputting softlockup logs is not
> a kernel hotspot and the performance requirements for the code are
> not strict, locks are used to serialize the softlockup log output to
> improve the readability of the logs.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
> Changelogs:
>
> v1->v2:
> - define the lock outside the scope of function
> - add precondition 'softlockup_all_cpu_backtrace=3D0' in commit message
>
> v2->v3:
> - define the lock inside the scope of function
>
>  kernel/watchdog.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
