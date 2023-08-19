Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E7781B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHTAKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjHTAJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:55 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A071D64BC5;
        Sat, 19 Aug 2023 12:54:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca6c06e56so1683072a34.1;
        Sat, 19 Aug 2023 12:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692474889; x=1693079689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZjE8kZgNc/2peCEGxpGthGspSepgouXUpBqBmqmTiQ=;
        b=kjAOR3MFoCfhUIxPdWOTChXNrwaU7m/4RueDc+xLic2kVYntr1USabXfkApme14YOY
         VLa25RTDTM5NopiwDkqDFSthvL2OsnBU2Yh8t7xlMlvoooF4aMNqy9Edc0Zgw8+3THSm
         LhVLEj+PDhG9v8MSYmAaR4HR0wy77Vc8458Rro2kzk15mtsO4OX4cjZb78aZJgsP9Q81
         9s6l/ujyRxcLBCbbsNPbM2f9x6WXr93mlzLaQs4hD4v70bWQ1dX0nHnD4Ro39vIarVDh
         3PTyUgYf7SQYQsXuBgVN3ByZJqOryovy6biQnVn3yn4xlBdpmpmq+PfXEX9ye9/x913O
         6pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692474889; x=1693079689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZjE8kZgNc/2peCEGxpGthGspSepgouXUpBqBmqmTiQ=;
        b=Iig0Fra1ZtcI8uh4YJfKmyMcSJfvsDgRZ93TPrZ12nUM11okKGQDOxO9Zcv2Z7hnIG
         Zz5FjgwM/vmFgnbz2p5cOVm+R4cIdZC8mQkce7dsNi83azBF9kW8d04eUo5EcLNM2tsa
         lWT0Ep5HS/ReDafs08bZUkYk/7ptmMEUJ6pfnyuaOG08CHDu39zARQiTY85XqgbWQtfN
         KT/NwtyMkLqe9prebWpt2GJzEThYeGNk/VdQBUjZ2jR1W56JtsQrjny+1d4y0gcX8OQ0
         L5VrPJ3RFmO1XmFpRF58VEut8NRWeXPmeeS9vvxuLFsHUJfqWESQk8PAYL3sX6o/21oO
         0avw==
X-Gm-Message-State: AOJu0YxPqmF0/rnV6uOlN/vAx4hyIg4W6DWWBGFgfEaoOUZs1tZVOrud
        nh/6nOdbJR5AhVXxX2TWgElyzVVxmT+Re1hzrLg=
X-Google-Smtp-Source: AGHT+IHzRDOAfCLKzSWZcp0ZIYH7cietFB0BwXPWVyn7DtQOBhvWAZayzusN4aeGpNSgtbzEklyE2PVQFqsTTOmUQtQ=
X-Received: by 2002:a05:6870:819e:b0:1bf:acf:c1bf with SMTP id
 k30-20020a056870819e00b001bf0acfc1bfmr3963862oae.38.1692474888896; Sat, 19
 Aug 2023 12:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230816124221.GH907732@google.com>
In-Reply-To: <20230816124221.GH907732@google.com>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Sat, 19 Aug 2023 15:54:12 -0400
Message-ID: <CAJFTR8SW=csT9o6iFdaVn7L8P38xYwcf2oU0Qd762=kOtrcs7w@mail.gmail.com>
Subject: Re: kconfig: list unknown symbols in the old .config
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 3:37=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Hi,
>
> We recently were hit (unnecessarily hard) when after kernel uprev we
> figured that something wasn't working. The root cause was a rename of
> the CONFIG_FOO option between kernel releases, which make oldconfig
> doesn't warn/notify about.
>
> Would it be possible to add either a new --listunknown mode to conf or
> to somehow make it conf_warning("unknown symbol: %s\n", line) when it
> reads a line from oldconf that it cannot sym_find()?

This makes sense and I brought up this scenario a couple of days ago
on a recent patch.
I can make a patch for this if needed.

Thanks,
Jesse Taube

>
> That would save a ton of time.
