Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9C78DEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbjH3TV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245648AbjH3Prf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:47:35 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2612122;
        Wed, 30 Aug 2023 08:47:32 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d72cf9156easo5168822276.0;
        Wed, 30 Aug 2023 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693410452; x=1694015252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+vRA8fiqqKSvK3ovxVxc+SFq+G/rf7AvCWwDoElCXM=;
        b=Q2TCCtfrMoJxFqdwOOnpwIitMBTAkBA8M9AVESug7HgA4tdDWblrj36u3s/2ck+Gv6
         QGaOI9qozMEtb7IxBNUPy9l9It/D5ISOOioPqjkmnXTHYH1+sBljQsFE7v0aDjwnadiW
         gEuu/x+kdsV1vIwhVi8iooDK4bNMvcmGtcOrOK1n4sKRemlpu4rYoUiRjmf2zrukYYJ8
         rwSp8dA70kImPdXVyiDPmqbOdjR4DKSUF2Cp+Hq34Y49O6ej/elfz2lDmgKx5gcOyQt/
         Bak+TQjxa6Hm/WYGkrgHmO9qlEuvlYPuIsxRBMYuE8LFClP8gLDJX5b+EkRp9qM58x2z
         LBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693410452; x=1694015252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+vRA8fiqqKSvK3ovxVxc+SFq+G/rf7AvCWwDoElCXM=;
        b=SmioqBUl7WnMBn59TAI+s7na+VpfuQ0LLSpNSoa+yC79DLjIIs2NJibNMxGR34+cB4
         BsmxFBGJltrZoUrvpSge6khuyBVYlh2Me2FCMlisko3+Q/xviovRHm0fYvwyAa3sNi4r
         ZmsiU3XhIc7lOtvvhfTs4UdPJ6bvACf2B0w5AEKGw75SdMI6f376RDNfyhKzNEUK2Ncx
         YyGBR2VXvJ6ciNtojby7L5PWCZD8VPva/D+OghjRDZpQKJuzlSN4cmTpHtYBv9IwYn41
         vGKPM6K8kpvZgGXzNMUd4ilmRXeVzlImRsQmCnw7odwAJmlkMzmSK00SWt2C8NqHQ+bH
         54LQ==
X-Gm-Message-State: AOJu0YyI/OhbYy5qAfehko92N0MQX9P5WniohfsnNSQtWfzwot2/1oT/
        hdPb7YTOU6IPbNVDox+g6ZiyAGkr7k8DKJtaTQA=
X-Google-Smtp-Source: AGHT+IGZ7R7bgow3L7I+yjZjSlqP8IeeyYXC/xu2e+0Ty5H9Tpgf8Dzlz7Nr86qo05OJh0yDaxlKryTrK9g5LKNIWNI=
X-Received: by 2002:a25:c5c4:0:b0:d62:d6c5:f5ee with SMTP id
 v187-20020a25c5c4000000b00d62d6c5f5eemr2743544ybe.58.1693410451750; Wed, 30
 Aug 2023 08:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230830150136.3798414-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230830150136.3798414-1-azeemshaikh38@gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 30 Aug 2023 11:47:21 -0400
Message-ID: <CADmuW3VmbjBpy9CG2h_7LJp3Vw9F39LEarEtvZOwHstEejuwWA@mail.gmail.com>
Subject: Re: [PATCH v2] kobject: Replace strlcpy with strscpy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       len = strlcpy(&env->buf[env->buflen], subsystem, buffer_size);
> -       if (len >= buffer_size) {
> -               pr_warn("init_uevent_argv: buffer size of %d too small, needed %d\n",
> -                       buffer_size, len);
> +       len = strscpy(&env->buf[env->buflen], subsystem, buffer_size);
> +       if (len < 0) {
> +               pr_warn("init_uevent_argv: insufficient buffer space "
> +                        "(%u left) for %s\n", buffer_size, subsystem);

Please ignore this patch. There's some weird indentation that I
noticed here that I'll fix in v3.
