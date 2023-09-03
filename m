Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEDB790D2B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbjICRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237594AbjICRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:12:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C73F9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:12:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a64619d8fbso86798066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693761063; x=1694365863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaJOEVNOlbi7frFT5+gMv19F3TfpMzKX+hhM1T9BpOI=;
        b=E51NLdQr6AB6lKv/8m6crE4+8+lBog+7j+kHWJqn6cczTdeWOcdk6MGYSLl3zHtM8H
         T2XyZJkMttm3hyAXngjH79pyp9kbIqU78RiQDQ0zuvxkLXs4cu4F2ajvs+K7RH/IWHoI
         1IbuXu17YlHLy9qnki1gANby2BwWYIWEiK8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693761063; x=1694365863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaJOEVNOlbi7frFT5+gMv19F3TfpMzKX+hhM1T9BpOI=;
        b=Doak0vIZfkE938tidogfkovmH8EUiwDalHwRyu/okU5Hs5QREP5RPyeOsBVkFQjHcN
         qB0PTdjy0RLoE9CJrD8WtkOvQ6wxwmUVlr6qCNo5kzkZrN82phucBfRh3KQtJSnZbovL
         G7+QNdTeu88FFRy1vexPhq5ehrD29QW75hFK6h5O2xXLB7HAOXr56n/0D3JxToZW6e9d
         9lIJ+wgMJyhZvQdL099UX2mJ5dTY9OySWNqMC6SM3JtcGQlHyi3+IugMX27i+GazMcy4
         WHcCRnSe0cMIxWGYyj/8uMMLxGtX6DNkr6XSjdTiHB38O1DdnivKLCwZ0hJWB09DoYPf
         funQ==
X-Gm-Message-State: AOJu0Yzd8kLckdh1V7+/ABjzUFc5NQ66mOIM4y7rcU8movZL/0AewhLR
        eEH+fpaOWruIRNUdI0/2fRGAUX0LqbKdxDm5V1J7sHFY
X-Google-Smtp-Source: AGHT+IFP5ABs6tnuTp4pemRKNCG1VHrLjQSb+RpyYTANYjQQogglQ5bFlIccsQfbeOPXH/E3Kv24IQ==
X-Received: by 2002:a17:907:2ccb:b0:9a1:e293:987e with SMTP id hg11-20020a1709072ccb00b009a1e293987emr6440420ejc.50.1693761063131;
        Sun, 03 Sep 2023 10:11:03 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id ja8-20020a170907988800b0099bd5d28dc4sm4921681ejc.195.2023.09.03.10.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 10:11:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c4923195dso116862366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 10:11:00 -0700 (PDT)
X-Received: by 2002:a17:906:301b:b0:9a1:ec69:23ec with SMTP id
 27-20020a170906301b00b009a1ec6923ecmr6805520ejz.17.1693761060082; Sun, 03 Sep
 2023 10:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230901184136.73b2833e@xps-13> <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
In-Reply-To: <CAHk-=wgUntc0u-6WQ9U3OmNHTqB=cZQoWcTOXaipB+gixV5NPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 10:10:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDaQos9fWrmGewWg_ECPNSKXDy+155T+YpjpzO+P0B2A@mail.gmail.com>
Message-ID: <CAHk-=wgDaQos9fWrmGewWg_ECPNSKXDy+155T+YpjpzO+P0B2A@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Changes for v6.6-rc1
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sept 2023 at 11:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I pulled this, looked at the "summary" in the fag, and decided that
> it's just not worth it, and unpulled it.

Bah. I came back to this, and tried to make a summary of my own.

I might have missed something worth noting, but at least it's now more
of an actual overview than a listing of details.

            Linus
