Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1897DE202
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbjKAODi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjKAODg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:03:36 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7310C;
        Wed,  1 Nov 2023 07:03:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1050002066b.1;
        Wed, 01 Nov 2023 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698847412; x=1699452212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gisn127HjRfCqlCw+GGWcrZ4rm16EE8igW2fuBilOVI=;
        b=Cngm8zDawke4xt581k6Sdq3qeqirK7LAldJUeDM9lCeJ7Ug3/4mxmba7pHZWpk66lg
         atrGpaKYoufiEAyEC+ow50yG9XgEgeSceIAzH4vmHVaBxMfhkbhU/gBIAIPjARKqFaM0
         QDHk1zaZ0GYxeOksHYebz6OxLf5mHOg6W8w/XhW3KpUWf0EHspxPHAud6ZcJt415T2Sc
         ajsHVpBn5CtWqFDy/QMWczmnN9h3EdFXiGPlofzAU+rMk5kgJpT7kNFOU1UTE/B6R4vn
         6+4QmZ3cJlusWZKqZJW4zDTXjMS3iyuMvOBo4lS6ht9RhaGG3OW9Z2sgoNvYNQZJsIqZ
         OWlQ==
X-Gm-Message-State: AOJu0YxZhozNMhOYfwPTp29GJ0aEBnUxWZWpYcRiebOlS/cU30GkM697
        h8QVf95hD9zrjfoaeznwkQFo7sApus2jAg==
X-Google-Smtp-Source: AGHT+IEV2Boyth/nieT2YIpyOSd7xpQoTtK8Nx/oZCoOmPIeu6bUdxKa1KTVU7d4gy65UJApHwxVCA==
X-Received: by 2002:a17:907:a0a:b0:9c3:e158:316a with SMTP id bb10-20020a1709070a0a00b009c3e158316amr2069997ejc.68.1698847411459;
        Wed, 01 Nov 2023 07:03:31 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id rn20-20020a170906d93400b009929d998abcsm2398281ejb.209.2023.11.01.07.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 07:03:31 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1047120466b.2;
        Wed, 01 Nov 2023 07:03:31 -0700 (PDT)
X-Received: by 2002:a17:907:764c:b0:9b8:b683:5837 with SMTP id
 kj12-20020a170907764c00b009b8b6835837mr1531634ejc.46.1698847411026; Wed, 01
 Nov 2023 07:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231101095533.45258-1-tom@baremetal.dev> <87o7gdbog8.fsf@kernel.org>
In-Reply-To: <87o7gdbog8.fsf@kernel.org>
From:   Tom Waldron <tom@baremetal.dev>
Date:   Wed, 1 Nov 2023 14:03:19 +0000
X-Gmail-Original-Message-ID: <CANjHDnCFMVayX7fHBYJc8GwdNS8wrnrJYMx-0ZrB++9kP2ojUQ@mail.gmail.com>
Message-ID: <CANjHDnCFMVayX7fHBYJc8GwdNS8wrnrJYMx-0ZrB++9kP2ojUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] wifi: mt76: mt7921: Add a new VID/PID 0b48/7922 for MT7922
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, nbd@nbd.name,
        lorenzo@kernel.org, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, it seems I missed some of the output from get_maintainer.pl and
only caught the last few lines. I've CC's some of the others including
Felix & Lorenzo.

Thank you for spotting this, Kalle.


On Wed, 1 Nov 2023 at 13:19, Kalle Valo <kvalo@kernel.org> wrote:
>
> Tom Waldron <tom@baremetal.dev> writes:
>
> > Add VID/PID 0b48/7922 for MediaTek MT7922 wifi chip.
> > Change tested on Redmi Book Pro 15 2023 (Fedora 38).
> >
> > Signed-off-by: Tom Waldron <tom@baremetal.dev>
>
> Should I take this to wireless? Felix&Lorenzo, ack?
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
