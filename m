Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B87A6889
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjISQDD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Sep 2023 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjISQC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:02:59 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3109C;
        Tue, 19 Sep 2023 09:02:53 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59bc956b029so56165547b3.2;
        Tue, 19 Sep 2023 09:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695139372; x=1695744172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ60uW+tbu6+KHWBtVlQ7lvtyHPfNfut3/R5HxH+TlQ=;
        b=EhLPKbnipCxGrur+cH89SwPFmZv3penknzX5Pwp4yZ/yrSyWWp+RTRuFWzWls6FAH6
         HfDRGhplxXu34KU1vAD8jEw+ym3OOxR8aB6dEYmThNNtrulOCYhi1qNRQvqF0Md4Q6rR
         tfFAzf64gkO1CGhVMzmuPHr/2LehZ2fyObM2FstW77yTir4TZnv++RSpuXK/ndE+B1Dd
         xTWEEaU0IU1gAZOXyvwDypiCQf4JMQWlq2OIFkSasmiRAmBNSKikfv+5KQqSc/lG8kIl
         NoT9zbjmrK26isaUqo+Nkp1Mi+0NK7vOOYgYv5LTOCOsitJ1SmmKJtRKwmiELOIYdiOE
         j2EQ==
X-Gm-Message-State: AOJu0YwA1hgf3Z2c2N/3LjLVxn6l/9BQSdUBLfG8+tSvfaXZh7vIiFHk
        XkXwtpyIk9yXtQ3f3OAtBjVePUGt/d/RDA==
X-Google-Smtp-Source: AGHT+IGp8/r6mSnh2QLUsGRUkDr3aiqVUgU4pbK2PzX3Z82P4TxXuFdMPITwTcu2UCLrWjwfj3nxDw==
X-Received: by 2002:a81:89c4:0:b0:55a:574f:327c with SMTP id z187-20020a8189c4000000b0055a574f327cmr13602407ywf.13.1695139372173;
        Tue, 19 Sep 2023 09:02:52 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c80-20020a814e53000000b0057399b3bd26sm3267782ywb.33.2023.09.19.09.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 09:02:51 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8521c7172eso1854355276.1;
        Tue, 19 Sep 2023 09:02:51 -0700 (PDT)
X-Received: by 2002:a25:cb0f:0:b0:d7b:8d0c:43ee with SMTP id
 b15-20020a25cb0f000000b00d7b8d0c43eemr12315ybg.37.1695139371557; Tue, 19 Sep
 2023 09:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230918175529.19011-1-peter@n8pjl.ca> <20230918234108.GN19790@gate.crashing.org>
 <20230919000026.7409-1-peter@n8pjl.ca> <20230919151630.GO19790@gate.crashing.org>
 <20230919155832.4179-1-peter@n8pjl.ca>
In-Reply-To: <20230919155832.4179-1-peter@n8pjl.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 18:02:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Message-ID: <CAMuHMdXQ=xpeY3tmLXe1kgJbRtmVAn62rEhvzO+VB7GCgy4F8w@mail.gmail.com>
Subject: Re: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     segher@kernel.crashing.org, anton.ivanov@cambridgegreys.com,
        ink@jurassic.park.msu.ru, jack@suse.cz, johannes@sipsolutions.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux@armlinux.org.uk,
        linuxppc-dev@lists.ozlabs.org, reiserfs-devel@vger.kernel.org,
        richard.henderson@linaro.org, richard@nod.at,
        tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Sep 19, 2023 at 5:58 PM Peter Lafreniere <peter@n8pjl.ca> wrote:
>  2) Stops building an obsolete and largely-unused filesystem unnecessarily.
>     Some hobbyist targets like m68k and alpha may prefer to keep all filesystems
>     available until total removal, but others like arm and UML have no need for
>     ReiserFS to be built unless specifically configured.

As UML is used a lot for testing, isn't it actually counter-productive
to remove ReiserFS from the UML defconfig?  The less testing it
receives, the higher the chance of introducing regressions.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
