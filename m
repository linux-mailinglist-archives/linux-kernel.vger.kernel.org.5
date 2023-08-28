Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7C78B1C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjH1NZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjH1NZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:25:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694DA7;
        Mon, 28 Aug 2023 06:25:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so243112a12.2;
        Mon, 28 Aug 2023 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693229107; x=1693833907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkmlxYRK4C8SNzQWjkO5iHFpd87CuFtJo6xJDyCW8cU=;
        b=M4KY2bVUGQfG2+6UDbaJ7G0gOzKmKRFaxNXSUKXXcdqWAgKpdvYIVw6P2Tb7EILz2g
         9yNoDHKQ9snwh7sSOTwx593Qjas6dBxOPbDGB7WB76MBBz8kNks0Q8wEMe3utmnBwqo+
         hBBgDhb3zn3uS98TJh+O2UXK/E2vagpGEeimt9/hhysteh+sT6VvtMUtaIo/VeVrzbrU
         i/bif1CasPEFdb5YnynrOOZkkLV7r2cZNEUqVe9pTRL3sPjbHFR2I12r6C+yhTqoefQB
         TKuLQjHW6YArP6564Yaau6PI8Nl1e+wa09poaDBcgue9knHA+C5Wm/EDdyKy7q6f/7/5
         J8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229107; x=1693833907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkmlxYRK4C8SNzQWjkO5iHFpd87CuFtJo6xJDyCW8cU=;
        b=MfUh81g/DrAMSp79sBTOoCnjVVT8rkZ3UfiTkIr8wCH19Z6njmd9uvvL8FWZqxDVCJ
         xu8lwvffuBM+OhE16YxPIcsP5zuxalPpJ4dmDVQbt6JloStGWBh2XbfLK8CO+1lJdPgD
         ab+punqA0TFJrsRTk/611o5VGfTJWivwJoSShN3mR2WokBJvWrV/ZfJxjnNrKwI42H7Y
         gCGvSXm3+RnffMo8GoEkpaTgLswD5AnSN4WTdoozadta3uJTS6WuNkGTADCuyndWOzw1
         mLuIda7qICI/St0keQ5+1l9yyQgtpMZBv2qE6EW+QRMHVpg7mr0sr/DuHf7paKBvmiXy
         On/Q==
X-Gm-Message-State: AOJu0YzVWp2ZkinH58UqslhuWdB7YvusR+IDvFN37P3igUn2plBWw5ns
        8MgddF4AVCKyebYibVAef6qY3+NzxV3Qd+27vuG4fSj4SHLnY8+P
X-Google-Smtp-Source: AGHT+IF0+VzmPjYqYpBFwjnYDJIQsNhtbzJtyEZBzv9OmMb7DPSrcdcEKf1ZptLxw7JUTnYrdqPbcF2tBg139qgof7s=
X-Received: by 2002:a50:fa97:0:b0:522:2019:2020 with SMTP id
 w23-20020a50fa97000000b0052220192020mr16715716edr.17.1693229107292; Mon, 28
 Aug 2023 06:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230828130223.89898-1-keguang.zhang@gmail.com> <ZOyd5V+7GCfIaLi7@alpha.franken.de>
In-Reply-To: <ZOyd5V+7GCfIaLi7@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 28 Aug 2023 21:24:31 +0800
Message-ID: <CAJhJPsVTJmdxyphBADSLzSUU-q8_gon1jNYKvrFADupfDfa+_Q@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Remove unused dma.h and nand.h
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 9:15=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Aug 28, 2023 at 09:02:23PM +0800, Keguang Zhang wrote:
> > Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> > unused platform devices"), no one is using dma.h and nand.h.
> > Therefore, remove these unused header files.
>
> I don't think so:
>
> /local/tbogendoerfer/korg/linux/arch/mips/loongson32/ls1b/board.c:11:17: =
fatal error: dma.h: No such file or directory
>  #include <dma.h>
>
Sorry for my careless.
I will send v2 to fix this.

> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--=20
Best regards,

Keguang Zhang
