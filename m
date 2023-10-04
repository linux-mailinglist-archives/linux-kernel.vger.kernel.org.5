Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9447B83BC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJDPhr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjJDPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:37:46 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58C5BD;
        Wed,  4 Oct 2023 08:37:42 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59e77e4f707so27953757b3.0;
        Wed, 04 Oct 2023 08:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433862; x=1697038662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYlbLmaEB096eu5KOHkpc83S+3akyKuaBcHKlJ33Mfw=;
        b=lYYfVgXxMptnt6Ir/CWfpOXatc0gahTLlnuyzX/SPVvaOhzSwyDyovoy18uq4kWhjJ
         mu+jgj67YPtdVDJ7XOuTfECmcsWjqS8NMQAYm5Q/EsTQj1Z89YEP26y8QbC2G/UcXI/T
         EsAxG0XQnCQtG6dRQFQU8KdqLksyKIMWdKS90NTRaulNRKu30IwNBcSvm9KtUnnOVCE/
         xDdnl2H2HuBHM4m4RN5y8QuaOx5Qf+dBDode6Bj0jaLl7edg05LCs02qUCNKuhCDCaSQ
         rYblNgY76nDTagGuTvumIBLyEK/gHHGEtqNYViJnZkYpThuadPev/HaqT/1Gx/j95A6N
         iKYQ==
X-Gm-Message-State: AOJu0YzJ0Aq+sn04tBhxRYiZniD0MTHfuAtLsSv4OJdJZYO7jPO1WHKW
        iE+fKwf2MQKejGrZXPnIb3Ih0hQU330fIg==
X-Google-Smtp-Source: AGHT+IFWrFUprdLQ8/KGUNk7xYLQl7Ne5co20rHcciP0oADoUZJFOQm6uwu+k5/Kotg4m9qadgaMrg==
X-Received: by 2002:a81:53c2:0:b0:594:e2e6:25e8 with SMTP id h185-20020a8153c2000000b00594e2e625e8mr2619383ywb.48.1696433861803;
        Wed, 04 Oct 2023 08:37:41 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u66-20020a818445000000b005928ba6806dsm1216455ywf.97.2023.10.04.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:37:41 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-59e77e4f707so27953607b3.0;
        Wed, 04 Oct 2023 08:37:41 -0700 (PDT)
X-Received: by 2002:a81:7245:0:b0:59a:e672:5a03 with SMTP id
 n66-20020a817245000000b0059ae6725a03mr2962158ywc.44.1696433861169; Wed, 04
 Oct 2023 08:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231004152751.3917-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20231004152751.3917-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 17:37:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXizSWkMnHJ6FKkyRQa5zpRZ-bpLJ1HDkothq2ont0Dpg@mail.gmail.com>
Message-ID: <CAMuHMdXizSWkMnHJ6FKkyRQa5zpRZ-bpLJ1HDkothq2ont0Dpg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: document Ebisu-4D support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:27 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document properly that Ebisu-support includes the Ebisu-4D variant, so
> there won't be confusion what happened with support for this board.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>
> Changes since v1:
> * fixed RTP numbers for both boards
> * added Rob's ack (thanks!)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
