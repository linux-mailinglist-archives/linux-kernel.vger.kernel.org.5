Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE3759CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjGSRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD51FC1;
        Wed, 19 Jul 2023 10:55:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5255D617D2;
        Wed, 19 Jul 2023 17:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34B8C433CB;
        Wed, 19 Jul 2023 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689789308;
        bh=VAHpwDmbVb7vAmsueO0gxYld9Kz+/rC90JncY/i+0Z8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pUtLQqEmUh6jrfGRA9xHjt27XPhzYdfbSDgpz8mdy3PCA3IPTuWwydcfqHkfDveHB
         qAxdNREGLUGdYWYdl7QKIoXLvV+zmEC9IwW1N0D4EUuLtSVTxwjCQpQtnoRwLo2Jhg
         nlPgMrMD+gnyCrWkquB+7hI/1Qcd6WKQkOGGtf36q4LlIyJ1UrjNiuJz1+rJ3LkY3i
         KGn9QzJWPYUnyOmE9+F0opil4iPTVx52VXVI79bHt3C5adIA+0xaujCQb+agz0evf8
         aXDsWWsn6O+hPrxqh0lm4XuEZa7/oBrPTxiaPMtRmlRyejxHZzhG5ltF7XXAFg/k/w
         aXKlCAekLo8PQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso106457761fa.2;
        Wed, 19 Jul 2023 10:55:08 -0700 (PDT)
X-Gm-Message-State: ABy/qLZNIV0LKMXvNar4J8WjtznIksPbpowl47En8ulxPUx7jqybpEHE
        39jztkQTSuKTq6284rYPCm1bbD8YvXU+IRF2sA==
X-Google-Smtp-Source: APBJJlGL/kk3oHY6k1yfq7SsCPop3Wy3YQQE6Qzgt85P636iSCY98TK7gwsRHy3ktZQQSAMhuBPDa2ZKFWJ9nqnLjNM=
X-Received: by 2002:a2e:97c8:0:b0:2b6:a3b0:f4d3 with SMTP id
 m8-20020a2e97c8000000b002b6a3b0f4d3mr440245ljj.26.1689789306681; Wed, 19 Jul
 2023 10:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718155814.1674087-1-kuba@kernel.org>
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 Jul 2023 11:54:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
Message-ID: <CAL_JsqKBbP_dXZCbyKtgXVDMV-0Qp8YLQAXANg+_XSiMxou9vw@mail.gmail.com>
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     corbet@lwn.net, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        linux@leemhuis.info, broonie@kernel.org, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.

I think the split is great. It would be even better if this
distinction could be made in MAINTAINERS and then the tools could use
that. For example, on treewide changes on Cc subsystem maintainers and
skip driver maintainers. The problem right now is Cc'ing everyone
quickly hits maillist moderation for too many recipients.

Rob
