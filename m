Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494C27E0EA9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjKDJo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:44:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940EFE5;
        Sat,  4 Nov 2023 02:44:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so7735363a12.0;
        Sat, 04 Nov 2023 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699091092; x=1699695892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yl19HlNI8a/5syuIt55FrNMo/bRs5+2pNvxXrTqIZSs=;
        b=LK4dz8LDMmBZmLQmZg7dr9Pl8oy8siJrowils4/Iu7LDQyk+0EE3XPjQoi0ed/JsQ4
         bJc5Ha+/Jn4nnv67Xn419tfQr5QbnZfZTjSg2HdURGGRs2CADq/pS1CBqN9s+DSH4/9W
         4zmYeFjJJXIQWXuE8K4D0iGycBvqynoM7LRdtvNf0mRgt/rlj4vV1nVe05LUB6JNX2gQ
         GHnUzpgiLCDkOhHHjQ45oUBMC2zlv8AMIA8ck43MwcNo2utsrLvAu9WrSUHvcKF3bu2I
         V9DYDnBs/r4Vsa7snyGP3U9IUdSd3qFofyUfXgltueemJ3oFTA7Q+wEFEWJJGzIRdcza
         lCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699091092; x=1699695892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yl19HlNI8a/5syuIt55FrNMo/bRs5+2pNvxXrTqIZSs=;
        b=OSQ5x9lpu1VlOM9Ruj+8FTEZCGL7eWTPnUPct+E+XN6BSPp8IZ4vvj97E1n83DlZMu
         iDjYa6mNEsii0dU9XUuaEtM7eyEODiiyue0mLnGplxlvloJ1i6533o9zIOXiCkQ/XJM/
         3uc6pXYMj6B/J1wTenTZvZrMTrR1LY0ZjC7Pjm7vcr9Qt0cotCjQNLyxD6bMFhRxrbGq
         FTknnaVKKgk7g5AtVQ3hcDk8IfNREYx8K1dcUVQdIMCPNLCFxpK24BDuf9y/W0mItSr5
         HTEvW5ucpJGESYVxDL22qdr5e4olCa8o+cC1WaIJYnWvR+4JEUqTbwO0mYpf1VwPMiP4
         vs8g==
X-Gm-Message-State: AOJu0Yx/wpRvvx1+T4n+1AKUi6V5g4fXoyXIpiZUHXEaI8ZHdcBouwIb
        A3sVHzbT5zHjcwIc9SMdbUz2dckVDrUB2JO2HaM=
X-Google-Smtp-Source: AGHT+IHsHPR7tE7sQLbpjhqtOkStwWfFQF8OiLvGANkbQPw/3j9jiKa3OEWpHjBFWfyG76ePs87vM5V0UDCEKtvWZhc=
X-Received: by 2002:a17:907:97c9:b0:9bd:a029:1a10 with SMTP id
 js9-20020a17090797c900b009bda0291a10mr5201681ejc.32.1699091091665; Sat, 04
 Nov 2023 02:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <AS4PR02MB790389C130410BD864C8DCC9C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
In-Reply-To: <AS4PR02MB790389C130410BD864C8DCC9C4A6A@AS4PR02MB7903.eurprd02.prod.outlook.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 4 Nov 2023 09:44:15 +0000
Message-ID: <CADVatmMpB6ZZx5iO4iD0fxNsXFQzCv007bSY+V-MQOeAMRy=yw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] parport: Add support for Brainboxes IX/UC/PX
 parallel cards
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sudip.mukherjee@codethink.co.uk, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Cameron Williams <cang1@live.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 at 21:11, Cameron Williams <cang1@live.co.uk> wrote:
>
> Adds support for Intashield IX-500/IX-550, UC-146/UC-157, PX-146/PX-157,
> PX-203 and PX-475 (LPT port)
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please take this after the merge window is over.

-- 
Regards
Sudip
