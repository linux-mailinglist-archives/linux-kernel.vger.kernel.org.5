Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75B37B1331
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 08:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjI1GiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 02:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1GiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 02:38:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDCC99;
        Wed, 27 Sep 2023 23:38:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715D9C433CA;
        Thu, 28 Sep 2023 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695883089;
        bh=SQgPQA2T99O0hjIQVd2pucP09vuZe0kNNk0DPrRkGjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bVEHcGsopDnyIrJjCX4z8hlMONnTTQYxTf9T47LJVrOz3CqNiTtTCW6mdF9TcE/Hk
         u3/xHhHOvesxLKh4nj4EUcfoIDVLWF5BJblbOg4dwMQnTR160WVGpK6zji9xZK9vzR
         HbWGxSPFj/Eml3i11cm2gvGnmaicdOx4HuM6h9J1CF8fD7U15XVatmJCJEybXYv8QM
         AWNYGgD+GS+xDjfGKVADNEA8PYLfI0DCzK++ff+n33MPX/qpoGA32BArhq5mKNwQ9w
         7S9zSrhdKcu6dGjo1TMvCTZZs2KtS2QTG7omApRgz0zZy/j4zt75+wFL1B9FCk+VR7
         fHtKagmRJbFEA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c022ce8114so204531301fa.1;
        Wed, 27 Sep 2023 23:38:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YygQfQsWdgdgQHQSgbxqsVUKTeuuDL2rqLyW8drfhHB3cqeuu9X
        WCfzJpYyciugKyw4YXJoung6D0d42S+31hTE9BM=
X-Google-Smtp-Source: AGHT+IGoLPc04vFU8OutAQ0apv3mlkrdV2V3sHJnCfjqyKIjDPHo4S4ZNo/aUszPId56Ifdkw6tpqqj8tymtzYvXv1s=
X-Received: by 2002:a05:6512:2386:b0:500:7f71:e46b with SMTP id
 c6-20020a056512238600b005007f71e46bmr397519lfv.1.1695883087650; Wed, 27 Sep
 2023 23:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230927061241.1552837-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 27 Sep 2023 23:37:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5O=htDUM+McnxGgy=7MnsdDQh8ap=6b-2LQmngTON8Yg@mail.gmail.com>
Message-ID: <CAPhsuW5O=htDUM+McnxGgy=7MnsdDQh8ap=6b-2LQmngTON8Yg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] md: simplify md_seq_ops
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Tue, Sep 26, 2023 at 11:19=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v3:
>  - rework patch 1, because the condition is confusing
>
> Changes in v2:
>  - don't hold lock while show mddev in md_seq_show
>  - add patch 1
>  - add commit message

Applied to md-next. Thanks!

Song

>
> Yu Kuai (2):
>   md: factor out a helper from mddev_put()
>   md: simplify md_seq_ops
>
>  drivers/md/md.c | 129 +++++++++++++++---------------------------------
>  1 file changed, 39 insertions(+), 90 deletions(-)
>
> --
> 2.39.2
>
