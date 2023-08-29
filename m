Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED578CC92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238667AbjH2S6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjH2S6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:58:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02190193
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bed101b70so594756166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693335509; x=1693940309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XptbQaF/TmqMzXqMFitdSA+1Ea5JhH7OV4FqHHSEswk=;
        b=MzOH9ntoAa4tre9LGFBbm0kW96r5U6m0Hbco+L7dUsgXWOvDQcwCIAeoavMJ8m0o8F
         ycLlIzAUfuv54nMVhIvc3ZWLr8U3ITmw2eFLzswjLhhs9NiFEzn6u9ynWuCobMDrtaqq
         9ZARfr6rUoH/mZ0FV3yft6KM0QmsdqImsO0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335509; x=1693940309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XptbQaF/TmqMzXqMFitdSA+1Ea5JhH7OV4FqHHSEswk=;
        b=HTJCI6KXWrhc4kvN71uPdCe69WepKcMdBldS8RKjf3WcRqS5uwvQlUCNsw9r1/sHU4
         Rm3JOu4jVhc2x6lm+y5K5Varj1kupDK5rVuJftiExyvrlWVbZaj0C0Ho/ySgPiox0Ggh
         HYto3h65B+XKUfqVTC7kKgrC/3Mk9HomyxYazLFyPaM3IEm3qdp696pZgb4m9Y2nA1cX
         zZptBWchR3AX8xw0riRsRVHUfY6gUTgQ1wJZo3QbAjJtN8b0Uk0V5q4dRprY6l/MdBl0
         enXujB8ATUcxEFqZnig+kXYdTkNKNLINFC84n6ubokgWITv4pQtPksVxJ9RUiqhmY+eD
         Qomg==
X-Gm-Message-State: AOJu0YxFOoptwkPWja0Tf2E8Cf2dJx9UjI8w/MgRiMzGbmKEEu8BBJ7U
        Qsr/hN6uNrjE08j/7jMNxRsiPpO6sRpMkFfL3V75EkH5
X-Google-Smtp-Source: AGHT+IFLFUT7AuaTXSARXURwUN3ZjrKSqTGJPe8jt+aFf3MnHFjLBwpUHfpty1T9LxoimexwTmoMpg==
X-Received: by 2002:a17:906:209e:b0:99b:627b:e96d with SMTP id 30-20020a170906209e00b0099b627be96dmr24639058ejq.44.1693335509266;
        Tue, 29 Aug 2023 11:58:29 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u22-20020a17090626d600b00993159ce075sm6261972ejc.210.2023.08.29.11.58.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:58:28 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so6582400a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:28 -0700 (PDT)
X-Received: by 2002:a17:906:249:b0:9a1:cbe4:d033 with SMTP id
 9-20020a170906024900b009a1cbe4d033mr16078457ejl.53.1693335507850; Tue, 29 Aug
 2023 11:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230829103512.2245736-1-amir73il@gmail.com>
In-Reply-To: <20230829103512.2245736-1-amir73il@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 11:58:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVaYx8+S4KFK0h_PdvG_-WpTgUagTcmt70_13LbHas3g@mail.gmail.com>
Message-ID: <CAHk-=wiVaYx8+S4KFK0h_PdvG_-WpTgUagTcmt70_13LbHas3g@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.6
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 03:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next

Please send me a pull with signed tag, not a bare branch.

I know you can do that, since you've done that before...

               Linus
