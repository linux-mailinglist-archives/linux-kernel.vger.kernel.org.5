Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC887C7ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJMHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjJMHqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:46:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A214BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c9bf22fe05so14235155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697183192; x=1697787992; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONEtd5adg39vVEfE7cPhn5HoULJU19wWn5zWrGwz3uU=;
        b=fOp/94yiVAo7XvvZKBug1mN0R6x+6Grt59ITgk/DQPREDZ/g8IkGiWvEEVlVGOnYWp
         0vOw+jqXA4HYjfi4tT74rKwFg79dta5bmaDD82ikuFrTPfXtI/JpS1LwW2mcgk3SfDbJ
         bszff/l11/57CboO8WV8I8cs6KOrDZTgefD1gAG9LbWUhwiX2Vzb3nsKrWoSsuIXwjW4
         Zh7fAXBJ8M9xPXYL4otRP8FkXFaxhkky+J5NY5AVNlZm6LLJI5A4Ruv+6D4WS2Pxe+ps
         nrLWEmbvSDlQXA1icCTxcaAjT5jmNQF26Lpt0FiAt3hQU9Mzk5LGEAyZ46WDh+3Mt/M5
         MR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183192; x=1697787992;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONEtd5adg39vVEfE7cPhn5HoULJU19wWn5zWrGwz3uU=;
        b=Slo9eXU+vAxLR1LF3qG1bAbtgTVvxYMpqvlV7k2clxUokm6vCcCqQKnLjHDFToKivC
         lha2hE2utTgCo0Oyc/6XLrpL1NCZxi7kWpDTthkbxC2HmhEau4/qVcL3oiSdiPKYVVvh
         XCE7bFRghLs4wu66sabsw8sVEJsGO4X7RZQjMhm0eedwgO1GjE6m3pEEA9F8FKPfbO5g
         m+B9lB6sj7fHXJRO77K5KdxXB5y1gmFjDI754A6QzmLlDw//4HEaVh2x9zFkQX0eZf7y
         xtMcvHCssrvLZ2I7rXnEOIxJSDox+/Z5tx/8pobDQtqjZooGj0luycgYtwP8HOZvfD+M
         oK8g==
X-Gm-Message-State: AOJu0Ywy8e9tiAr1xF4OsZ36U+i6UAMy2X8a8xFXSMz6Somum2WgCBnL
        +K7JEVwby+YZTYrABYXYTaR3Q7CGRwdyFA==
X-Google-Smtp-Source: AGHT+IHdj4hWI9QDZoRoom2rrLFcswJC3qktGs2uGiXeoRIN1FIsvldczfAxcufpP2JJo8ppli4oew==
X-Received: by 2002:a17:903:2441:b0:1c3:61d9:2b32 with SMTP id l1-20020a170903244100b001c361d92b32mr27275201pls.45.1697183192202;
        Fri, 13 Oct 2023 00:46:32 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id bj3-20020a170902850300b001c61512f2a6sm3175383plb.220.2023.10.13.00.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:46:31 -0700 (PDT)
Date:   Fri, 13 Oct 2023 00:46:31 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rts5208: Fix checkpatch macro warnings
Message-ID: <20231013074630.GB13814@Negi>
References: <cover.1697113047.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697113047.git.soumya.negi97@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:50:21AM -0700, Soumya Negi wrote:
> In the driver staging/rts5208, checkpatch.pl warns of possible precedence 
> issues in the header rtsx.h because macro arguments are not parenthesized.
> This patch set handles the respective macros differently(as needed) in 
> each patch to fix the warnings. Patches can be applied in any order.
> 
> Soumya Negi (2):
>   staging: rts5208: Refactor macros to static inline functions
>   staging: rts5208: Remove macros scsi_lock(), scsi_unlock()
> 
>  drivers/staging/rts5208/rtsx.c | 24 ++++++-------
>  drivers/staging/rts5208/rtsx.h | 66 ++++++++++++++++++++--------------
>  2 files changed, 52 insertions(+), 38 deletions(-)

Please ignore this patch set. Its incomplete & the rest of the patches
were not sent successfully. I have successfuly resent the complete 
patchset(unchanged) as v2 with an explanation after --- in the cover patch.


> -- 
> 2.17.1
> 
