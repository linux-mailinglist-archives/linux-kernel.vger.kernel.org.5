Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D92791684
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245368AbjIDLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbjIDLzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:55:25 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18520197
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:55:22 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so521964241.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 04:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693828521; x=1694433321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sSGdH7aN8yTo6ZaPJwceLOZ7XnBN+We7swViqH33ceo=;
        b=HC7LsiZdeAITp7dGFoUxwxeqJOXv1zAbmBLUiEGhUU2rUK1dJ7BMQodbrlukJ5L+Qx
         sAb/wna4TytVXibq8NPoVaOoFcjIylXyMC6nEaPnIvQ+QNrGWr+ppUxDZa0WfvgFIZTD
         TObvCgsApZJ+ZA9sm4BO4nAWu0qn9cPaieets=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693828521; x=1694433321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSGdH7aN8yTo6ZaPJwceLOZ7XnBN+We7swViqH33ceo=;
        b=K1736EmCIAvFZm2aSMssVfpqm+iohGYn4/iqztgeIWrjLIMRaVrZK+14JQyKrafbeU
         jIFGWdoIsjZsE6SlWH+Ue5YTAgyMN6HeiQV6rCEMuJAkwhHz6mLPw9W7NxWb/L/gBnZ+
         TszaOaEmX2d2AqXVk/au0m+d6mJd/9IVUl/nYeRsvsBO7yw7OePPgRW/gjcaOLFgc2bn
         WmgGeAyDFBgH9kHWrPN4/zvWx8cj94PLlLLCAnuZc5FrauOHV0MPi5xbee9fLWLyE/T0
         SozmUYDsFMDsyp30n06sqh4jEbU3ue5zE1rDlSxg67MZKImSbmI5YxidCgM7Ie5qYL7M
         firQ==
X-Gm-Message-State: AOJu0YzW+2MuNCaptSMfEb8TfH3w63GEmsAnzQrTI3cuKyMYk/mTZ2rz
        IohXqCveqDNTZtLzYRer4UjaahfFf85MFiELLx4=
X-Google-Smtp-Source: AGHT+IG2fs9D0k2EorkPahQxD6W7y7+LiCsT0Wqe8z+HWkKs1TDYDKWcuwlRcVrX/V5bltctAreq+w==
X-Received: by 2002:a05:6102:493:b0:44d:f177:279e with SMTP id n19-20020a056102049300b0044df177279emr8456203vsa.22.1693828520992;
        Mon, 04 Sep 2023 04:55:20 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id d19-20020a67c113000000b0044d5e0b2619sm1671728vsj.21.2023.09.04.04.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 04:55:20 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-490cd6db592so372381e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 04:55:19 -0700 (PDT)
X-Received: by 2002:a1f:4884:0:b0:48d:1e9:2707 with SMTP id
 v126-20020a1f4884000000b0048d01e92707mr7816746vka.7.1693828519402; Mon, 04
 Sep 2023 04:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org> <CANiDSCtC2zOKtopkuuqJYqi6+FQ1Kav6LfMH5gGhKrnDeG7GYw@mail.gmail.com>
In-Reply-To: <CANiDSCtC2zOKtopkuuqJYqi6+FQ1Kav6LfMH5gGhKrnDeG7GYw@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 4 Sep 2023 13:55:07 +0200
X-Gmail-Original-Message-ID: <CANiDSCteBUraA0UrLM-cU_GqDSWcWERJNV_xhsi3LNQZNvX5dA@mail.gmail.com>
Message-ID: <CANiDSCteBUraA0UrLM-cU_GqDSWcWERJNV_xhsi3LNQZNvX5dA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] uvcvideo: Fixes for hw timestamping
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again

This has been waiting from March, and it has been already been

Reviewed-by: Sergey
and
Tested-by: Sunplus

Is there something that I can do to help merging this patchset?

Thanks!

On Tue, 15 Aug 2023 at 13:26, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Laurent
>
> Could you give a look to this patchset?
>
> Thanks!



-- 
Ricardo Ribalda
