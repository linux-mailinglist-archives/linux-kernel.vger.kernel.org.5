Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B777FAABC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjK0T6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjK0T6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:58:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75519D5D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:58:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-285c3512f37so1500417a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701115128; x=1701719928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wvtz8hFb/yx3lKmNY3HOChTP73hRDDy5ioYhUvYduCI=;
        b=Qsi5dNFgPv7CahgMZsB0dLWt6kuGel3mlcq62JuWmxeCTJdDkFuAcGY0IUH3B2mjE7
         0LCvCYtIKCxT2nMUuKSQonkabv4P1oPbpjWBj+EwCyv/+EtABi933wvd1VepT0bEusoF
         KzGzpZ78D3hAICTe/QnnqSavN0xU9SuwS7G6YEbyMxm+jNa7l29lgSduwxHL2DoUZxn0
         S5ecR365LCkbpo59QG6HBzZBr6cHqVAMmhen2DPdjwBk0pGPHsFpdO8fyYBjbUnvVOkj
         Hu3/43xGxlDAF0r6NNn0gTpt638LqK+JUy/K9P7hYvxZILQ9fdQgQBhG6z3JWCOM2v5H
         BQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701115128; x=1701719928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvtz8hFb/yx3lKmNY3HOChTP73hRDDy5ioYhUvYduCI=;
        b=OZryb5otghoweekRUU5hBKaWGNB2oxV5CDmIjz8p5/H5jqLVz1OQdyMds5Qsyie/ts
         /mzgM98TNdaadyUXv0EB7arG2K0LSMDdCr6YEYO2l6O6u3Gkc/DBNsGi2LKhndEDg0R4
         NN9OXXWYAOOiCgHxjDG0T991TXjI9Ya1CrWuqBjhlEDpkMpND9/4X4r49+LORT4dMvC8
         YgIkuVrqGT+DhOfSELiWYEkLd69vSCufg0FHvWHFKMm4D6culqB8dbQpNrWE4v2k2+q+
         pIcXg4d10QYXZszMCG7Nshg+4XAZ9U8wyxpiDJ0D00oQtD6ESwH+KjfsJKjbOG59IEaY
         wpvQ==
X-Gm-Message-State: AOJu0Ywu2iFXUNhaK4eDtCGr7JqvcGaUOCJSTHIlU7VZWFi8wyRzKIxy
        wbWQLoN64wg+cV30R9SV2uevHLWsp1qzVZioNskrXCvZUg0dHJ98
X-Google-Smtp-Source: AGHT+IEHpjlxS92lzYOoa/eDrMbaJyqFjmYdotNizFE5U/qfk7jh7OU4jMohaE6RNuc5feTPQ3LghJYuOCQ7zd/PBOQ=
X-Received: by 2002:a17:90b:4aca:b0:285:a179:7177 with SMTP id
 mh10-20020a17090b4aca00b00285a1797177mr9939075pjb.44.1701115127846; Mon, 27
 Nov 2023 11:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20231121101331.22837-1-naresh.solanki@9elements.com>
 <ZV9MNdOCkIpLB+6Y@finisterre.sirena.org.uk> <CABqG17jRbqcw=QioyZTPFTidUDiPDgBFbm45vfvG2Sc5TOznvw@mail.gmail.com>
 <ZWSj4+Ag739Axe8O@finisterre.sirena.org.uk>
In-Reply-To: <ZWSj4+Ag739Axe8O@finisterre.sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 28 Nov 2023 01:28:38 +0530
Message-ID: <CABqG17i0cFLoZdU==bkzveKem4wMwYz3eMVE2Y51BHsKEsUXsg@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: event: Add regulator netlink event support
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On Mon, 27 Nov 2023 at 19:45, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 27, 2023 at 04:07:45PM +0530, Naresh Solanki wrote:
> > On Thu, 23 Nov 2023 at 18:27, Mark Brown <broonie@kernel.org> wrote:
>
> > > I'm also not clear on where the 15 byte limit comes from.
>
> > I felt 15 characters would be sufficient for regulator names.
> > Would need your inputs to make sure here.
>
> It does feel like it might be a bit tight - perhaps double it?
Sure. Will change to 32.


Also there is a possibility of regulator name  duplication.
And below mechanism is already used in debugfs:

        const char *rname = rdev_get_name(rdev);
        char name[NAME_MAX];

        /* Avoid duplicate debugfs directory names */
        if (parent && rname == rdev->desc->name) {
                snprintf(name, sizeof(name), "%s-%s", dev_name(parent),
                         rname);
                rname = name;
        }

I need recommendations here.

Regards,
Naresh
