Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361347ABB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjIVVdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIVVdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E9A139;
        Fri, 22 Sep 2023 14:33:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0320EC433C8;
        Fri, 22 Sep 2023 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695418392;
        bh=f1EVfyH2F01F5M1949Z7ivI+38rasZWWnGdFJAtx/Xo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TOFN5ujQr8NIPwy+7xqKsVpuinRJoPiuaLKWJUFdA7EMnOI8Crl+eeIQnxU+RWls7
         tGTF5BfsAJvbnZDHTMBYgnWDxWdhiaLBIawuyHOoRL9cP4AOYeMRCWlogFoLfKx46+
         AZc8xez7g0MxVFuGbY/b8dNlm3KSkfgiCQjATYV8pslQ6jxQqpDtks5w/qmqpOI/UA
         qcXBgvMTmMmOsX7el5cEgQtYhkldTyOAyL16CExmd0pXNfBgB+aU3e6Z42jr+XQYj9
         1aWTrs2ezQC2BPDSq9fEOBythhiQie+2mrDIm0xX5oR4+fHigUj4wutYqkPib5aWzN
         FNkzoVx8RkrHQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-503056c8195so4672343e87.1;
        Fri, 22 Sep 2023 14:33:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxmE9ArBoNwueSya63/YVb0qPGPD3HF2HFReFenSofbJdAABGwC
        TZe73SoIkH+ZCajzOGKt0pEhniMgRbXI4i6nK9M=
X-Google-Smtp-Source: AGHT+IF1CPGzSC9L0TIZ8p3JUVUggw4/KcS545hsQN+r94JwXovvQgxUIpbQ3V3cc7X1ZPedvqYjKjWuauu2cX100pc=
X-Received: by 2002:a05:6512:224e:b0:501:a5de:afed with SMTP id
 i14-20020a056512224e00b00501a5deafedmr603530lfu.37.1695418390252; Fri, 22 Sep
 2023 14:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230830092902.1236950-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230830092902.1236950-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Sep 2023 14:32:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4QNwL3+AXk8_ZNwgSAZj9k6Ce=tPmz9xPHwC+BjT=Dcg@mail.gmail.com>
Message-ID: <CAPhsuW4QNwL3+AXk8_ZNwgSAZj9k6Ce=tPmz9xPHwC+BjT=Dcg@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] md: fix potential hang for mddev_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
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

On Wed, Aug 30, 2023 at 2:33=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Yu Kuai (2):
>   md: factor out helpers to grab and put 'active_io'
>   md: fix potential hang for mddev_suspend()

Applied to md-next. Thanks!

Song

>
>  drivers/md/md.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> --
> 2.39.2
>
