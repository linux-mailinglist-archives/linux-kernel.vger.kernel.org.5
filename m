Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C77E15DD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 19:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKESe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 13:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKESe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 13:34:27 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E9BE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 10:34:25 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a87ac9d245so44878877b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699209264; x=1699814064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvGayJ1BF/k1YJFGC7YSBXZCpRxwJaGXYRvYu42m8y8=;
        b=UGhWCKoxue61eOIT4Iy2q2PBBHpVKp35oWjmtJTWC3uCk+/YcZA8bTFzWIhNQhYxfQ
         SEN3xtWLC/GUn99oB+25ccAC7sDlhvxkbc8ySVMOvq4mt6PXnC2YnSUw+G0DiMvXuXaw
         b0DOsDsVw4tBKKEFQKLAncDfvB2CeV3h2tnsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699209264; x=1699814064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvGayJ1BF/k1YJFGC7YSBXZCpRxwJaGXYRvYu42m8y8=;
        b=ZWQRMVdUPE7loaaazQYZH6RKIQ2hIxJN+gMI7H9oN3JcEq38Xofn1JQ1KBXjSnIB9K
         zHNftk4lN0ZWItYNl9yjMw/uijL2FKdYhs8T/S2UkEgTYfUtcLjnfjkhuleid/oKj9rg
         PP95+8fMJEUAijBzFDsaYU1tIC6FaD0g7nOrX9efuyLs/1ztTBqmmIEcMVhzXjW8N9RE
         S+eXe7qwIMRdraV5AiwpoVIFPYucQim5XL2psO/E6TTYHrgP+ybvJdivUkO3GCI+AZbO
         RSaz6GY2ULfmnXlMZMUeeQKoR+68DnRLg+6qovWQToOQr86jK8IM8Usi4+Se8JE/iyWv
         nNvw==
X-Gm-Message-State: AOJu0YykFw+3GEucwLfmqjHIOjbJN7XC3ByvaWhhi5Hkob/Fbdy3b1kS
        EwuOpM3xvC4w3pXpTaSPKkM928YLZ0nbaIurb5liZA==
X-Google-Smtp-Source: AGHT+IHIMxBkq+aYZo4QvSZUQBODfXq3hDiCzwZmQUx5eiL7U8JKC3j+G1fUNHP+/xqUTrD0QL5N8w==
X-Received: by 2002:a05:690c:95:b0:5a7:d368:bf88 with SMTP id be21-20020a05690c009500b005a7d368bf88mr9228801ywb.2.1699209264433;
        Sun, 05 Nov 2023 10:34:24 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id y13-20020a81a10d000000b005a8dbe385d1sm358058ywg.12.2023.11.05.10.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 10:34:23 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a87ac9d245so44878697b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 10:34:23 -0800 (PST)
X-Received: by 2002:a0d:d692:0:b0:59b:c0a8:2882 with SMTP id
 y140-20020a0dd692000000b0059bc0a82882mr8910647ywd.46.1699209262854; Sun, 05
 Nov 2023 10:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org>
In-Reply-To: <20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sun, 5 Nov 2023 19:34:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCt6kf6eJJ-9Cv8BB-=_ib4iYi=ekFG+D==6HvBmhOkSRQ@mail.gmail.com>
Message-ID: <CANiDSCt6kf6eJJ-9Cv8BB-=_ib4iYi=ekFG+D==6HvBmhOkSRQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping (in text mode :P)
