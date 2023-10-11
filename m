Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B567C47F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbjJKCrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344822AbjJKCrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77E9D;
        Tue, 10 Oct 2023 19:47:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C07C433CA;
        Wed, 11 Oct 2023 02:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696992446;
        bh=+UKaoL+7oBJzKwzknHc34VhNvMGcB5W89Xony6QnyQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I/yTkR/GwUX6TQ+lCufpljE4qr1OcmVLzX7/g72BIbyMXcTpJ68K0jIvDyy8BzelZ
         Ol4VT6EJ/ojW3LQ7AMeEJURplAGSWyG5lBHldo+Gq6gXThC4vJrD9cYUSmbIJZN+5l
         2cXPY4VbyLPnlL/6wJGoG333j1GUZ2OUln3jZP1gBiAE8QJAz+aIaTqPvdLc8N68vN
         VMbNOSciPk3gLYARJ/9HUsEsCKBuA5LE325oAJvGKumGe/0knVrvLRBg8pWQXCJHeU
         9TIA88k8VEVZjC5sdHbXPCDrxjjVVw6h2lvosEfN/Kp8gunNh83Gh09C3kQNdNhx6A
         qs6VkDxSvXwjw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5068692b0d9so5735802e87.1;
        Tue, 10 Oct 2023 19:47:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4CRwg3i+oBkJCJOW2+YFJj4uHJXTku4gehv/54/CMkeGhjVDq
        MyynutihJ+0hKwQW6LeMdhya1xiaPQAguJQ+CLg=
X-Google-Smtp-Source: AGHT+IEu147bL0rba0AQcunnSzq6IvPgVmYyoTctPrY6AiS4lHCJRgkPJ305pC8NQb/KC7caDq18l1Ks4FmNaz7vHl8=
X-Received: by 2002:a19:8c5a:0:b0:504:7f2e:9391 with SMTP id
 i26-20020a198c5a000000b005047f2e9391mr15506156lfj.34.1696992445140; Tue, 10
 Oct 2023 19:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231010151958.145896-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231010151958.145896-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 10 Oct 2023 19:47:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7A6_YFHtYb6=KUCdm-zf_Rj+UY1hG2_ZFbW6QSVnyCDA@mail.gmail.com>
Message-ID: <CAPhsuW7A6_YFHtYb6=KUCdm-zf_Rj+UY1hG2_ZFbW6QSVnyCDA@mail.gmail.com>
Subject: Re: [PATCH -next v4 00/19] md: synchronize io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:23=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v4:
>  - add detailed explanation of backgroud and design in cover letter;
>  - merge some patches;

Thanks for v4!

I applied it to a tmp branch (md-tmp-20231010) with modified cover letter
as the merge log. Please let me know what do you think about it.

Thanks,
Song
