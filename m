Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D237B40DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjI3O00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjI3O0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:26:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED529C2;
        Sat, 30 Sep 2023 07:26:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F5FC433C7;
        Sat, 30 Sep 2023 14:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696083982;
        bh=yuwOzBUFuSwro3iLAXmu5vHp060VKlPzw+sS1DN/psQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gN6TdBPQW4a4A7FKUNC89QbM1sXXGeJ9DRdM/WQVvPWvCICxOc9h4CTptGmrH/yIU
         ZEftsQqfwDBVArdY/BNw4j27WzvwcWT7c5ygu+9jn7cwtw1k0P3Z/57qh7PbT9C+TV
         UJE2DL7RJicTHhod17AOLG3hEak5mlVR/2e5XpBmuBo3EFV8HRfG0CMhYucnfEnBVC
         UVCkULtPfoYY5IZ4mbIzYSsx2bF5jKiI3nNKh9motE+3xt9j8Rix0mGGr96/KcAgDW
         e0yAYexrCH8hkQEy8h2DDz6e6lsiiaGllHVQW83nw0ifBTgFxkqa6rpQvvX2Bv1bYu
         l6F56tUBt546g==
Date:   Sat, 30 Sep 2023 15:26:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Apelete Seketeli <aseketeli@baylibre.com>
Subject: Re: [PATCH v3 00/27] iio: resolver: move ad2s1210 out of staging
Message-ID: <20230930152603.6b188798@jic23-huawei>
In-Reply-To: <CAMknhBHLwWuuCDSCBZV1bB1MuqDa5ur4GEY+Yqofvn9MPGRcVg@mail.gmail.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <CAMknhBHLwWuuCDSCBZV1bB1MuqDa5ur4GEY+Yqofvn9MPGRcVg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:49:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Sep 29, 2023 at 12:25=E2=80=AFPM David Lechner <dlechner@baylibre=
.com> wrote:
> >
> > From: David Lechner <david@lechnology.com>
> > =20
>=20
> Ugh, an automated tool picked up my personal email on this for some
> reason. This extra From: line can be dropped from any patches that get
> picked up on this round. I will make sure to double-check next time.

Seems b4 picks up the second, correct From anyway which is handy ;)

Jonathan
