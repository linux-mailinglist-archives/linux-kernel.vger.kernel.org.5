Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27E57C55B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346943AbjJKNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjJKNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:42:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0ECB8;
        Wed, 11 Oct 2023 06:42:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53458C433C9;
        Wed, 11 Oct 2023 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697031722;
        bh=mSk8o+BiKqX77VnA72nXp5vG9qlNWlmD9Z4BUat/zB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jq2Mxcwhp49ndNiggadYYEhRxTk2+DySNHo5j7yVlYLQkz6Sg7LjTnKXrpIOwYfxP
         ZqdPUoEgrT5vDg703LNkqKPZUUE8kAPrm0M4VDtRS6S4tRetGouqJBDoUG1KM7uORH
         09Hm+Sycwg44ULwQWaZHlaZbdhyLWt+7f1vrzlYZkJYqhWkEEfhL+VFb/Yg26bZQrM
         d6qrVMzmqELJCEXwdvCkIjKQMXfxt09ZABEaxmxvjNt3TMXo9R+nHMm3NRmLq4qjPV
         wcuy9VYdnQBV6waCxVofAetp/lVVzWbfMU6PdXUAoCwjydDjlJejhgcrilMGA2++pf
         yWMyi6UUa3Q2g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50325ce89e9so9085507e87.0;
        Wed, 11 Oct 2023 06:42:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxW2JRxIwqqubmyfI4l3v+xg5XoBD8pUkLm0Lta/q+MHsR9m6gj
        nhEGsKUuwwx8iE5e6Vo78CgMScIQUQT/fOGNsA==
X-Google-Smtp-Source: AGHT+IHF8pxG87aa7jZPAwceOtmCHZA7vY0JBMhmD9L9PUTg/EUg+AOaBFcnBF6OkS4wbMgnr7u7Hmmgj538DP54J3o=
X-Received: by 2002:a05:6512:4002:b0:504:369d:f11c with SMTP id
 br2-20020a056512400200b00504369df11cmr21422457lfb.34.1697031720514; Wed, 11
 Oct 2023 06:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231010145412.4a758f9d@canb.auug.org.au>
In-Reply-To: <20231010145412.4a758f9d@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Oct 2023 08:41:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJkEutiwWdNe336pWbcLsHK9tNxHNYVOAACt_ncaBdBXQ@mail.gmail.com>
Message-ID: <CAL_JsqJkEutiwWdNe336pWbcLsHK9tNxHNYVOAACt_ncaBdBXQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the dmaengine tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:54=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the dmaengine tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/dma/mmp_tdma.c: In function 'mmp_tdma_probe':
> drivers/dma/mmp_tdma.c:638:36: error: unused variable 'of_id' [-Werror=3D=
unused-variable]
>   638 |         const struct of_device_id *of_id;
>       |                                    ^~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   a67ba97dfb30 ("dmaengine: Use device_get_match_data()")

FWIW, my patch has the above line removed. Seems it got dropped when applyi=
ng.

Rob
