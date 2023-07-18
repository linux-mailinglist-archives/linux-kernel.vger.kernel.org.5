Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E06A75856B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGRTTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGRTTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:19:16 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9DF198B;
        Tue, 18 Jul 2023 12:19:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-440bb9bad3cso1925663137.0;
        Tue, 18 Jul 2023 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689707955; x=1692299955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ka+h1AwDZ7wd2kMZ1WG3CJg2grD7MqdarHGbW5wU5Y4=;
        b=QktrLhRT3zfbV/H0lv2tZwRpZSBvnmRka7Y4l/rOuIjB+GRtv+MNkAJzmEeH2hAhH0
         CR24Am0i8EnmlGntBZDui0YA3alxNFko3q3bvHQrEKAv9s1iznXzHVNllkg4bB0bL4yE
         hyJCj0WFuwhSkWq+9GQwxiKZSLvV3B3B6DfuXPQmf2CBmciVBpuSvg7KIhGozA4XzEW6
         /7zzCkHtkhbNokpYOmAMBKqUBaPiXxrLcpVXlPg3GgiqadIvc0AoWDikt6y4T3drHYJo
         fhjqhERxmWdQLHC2oRo0kWb2HqFP6F92KUROVPx4ATJVmvW1lANGP38TJFbWhBN69pF+
         t7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689707955; x=1692299955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka+h1AwDZ7wd2kMZ1WG3CJg2grD7MqdarHGbW5wU5Y4=;
        b=eeFSGEORmI4YiV4WkfXh+OnAWAMyRgBqhbUvQvCuAy3Fw33h8J0UnvHLRkKv/sElVQ
         +ZT2Kgm6pfjVy+ydLjwwgD/3AI4YRrLNwjEPHHAtF3LzcGvvLnGMTfgLJ/F64+sfw8+N
         Tvv/fmt6aPJw9oAxy5+DBzYGNLN6A4fyU6/0sTukmTRCFz1x2uBoBCrQhshWUVtv4N2y
         WQD2Tu96Tv80cioLlhmgDiQNcz/jluSvOpFJbYyusVZQMZjqaOZZDu0SZd8S6IWnU3oE
         zeR9fYpBJcfDWY3aN0qub2nQD7D4jcH+87knwRkLNNHkiJuWaCE8ul3C6OkbXoDCGsE+
         gHyw==
X-Gm-Message-State: ABy/qLbnBbURRuNj6r71Je2FOFeUpnbwH9yEzkZ7HovirVoDLxo9fA07
        o7kesZFP35Cd+UrYQNOOJzc=
X-Google-Smtp-Source: APBJJlH6yGZest7hdrsUtNnwQKOPUpN3e9kLHUAUeNzhj1B56NskbQPjGSNXLDHZILID0nm/2sd6Lg==
X-Received: by 2002:a67:ffca:0:b0:436:57fc:ffa3 with SMTP id w10-20020a67ffca000000b0043657fcffa3mr7515892vsq.23.1689707955012;
        Tue, 18 Jul 2023 12:19:15 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id m1-20020a0c9d01000000b0063623c266easm958028qvf.3.2023.07.18.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 12:19:14 -0700 (PDT)
Date:   Tue, 18 Jul 2023 15:19:13 -0400
From:   Benjamin Poirier <benjamin.poirier@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@leemhuis.info, broonie@kernel.org, krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <ZLblsQe1fLLhZzvU@d3>
References: <20230718155814.1674087-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 08:58 -0700, Jakub Kicinski wrote:
[...]
> +Reviews
> +-------
> +
> +Maintainers must review *all* patches touching exclusively their drivers,
> +no matter how trivial. If the patch is a tree wide change and modifies
> +multiple drivers - whether to provide a review is left to the maintainer.
> +
> +There should be multiple maintainers for any piece of code, an ``Acked-by``
> +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
> +enough to satisfy this requirement.

This sentence seems strange. Were the first two words swapped?

Given the latter part of the document which recommends to have multiple
maintainers, maybe this sentence could begin with "When there are
multiple maintainers for a piece of code". That sounds less speculative.

[...]
> +Non compliance
> +==============
> +
> +Subsystem maintainers may remove inactive maintainers from the MAINTAINERS
> +file. If the maintainer was a significant author or have played an important
> +role in the development of the code they should be moved to the CREDITS file.

         If the maintainer was a significant author or played an important
   role in the development of the code, they should be moved to the CREDITS file.
