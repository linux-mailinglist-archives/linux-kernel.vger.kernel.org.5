Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962A3812895
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443274AbjLNGwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjLNGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:52:04 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADFD19AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:51:42 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5527ee1b5c3so92011a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 22:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536700; x=1703141500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=QmlWytzqVq06JId4vvsAOd+KdSEMS5c/WnxMvozmd9Zc/rUYhH8nxf4/SprTqo/PAa
         FMril3eTCi3P/YNopFkbvrEvvzTmEVc/LTb3Flt3HTnYp4rAMqQZpdWE8/41UgnH91RF
         X/P0hv+qANB63ijvGrWatEI9eOLQvo1NcYunqeaaTHFkm5Cj7IXU0tdS/RKS+TnHNT+j
         92ATNsZ4ep7rG4CifKFxkThBmoou2WoJA6OQ8U8VntHiRJd5RoFUvOkFIluDSiREftNY
         k2/pMlonAvWFk2Y+ADnAA4unKBQ9qZuuns4eDTaOGv17odY/u+Of9a7H+hVaZtA0EKgU
         Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536700; x=1703141500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=doY/H34uP8F+vNxlGht2DpHIrpI6rWAV3tGOBP637jpOfTMo+SfIwQwlr0ZxE4Wqft
         O/q6TACdgbWL+DNnzWsRMQyAQgVYisGayEIu5tk2VqdP6nV/BHwYYfwlWLqSX0g6XVvH
         ByVj+oSPw2pz4B791CR3OXD0PPEZ+SPXmuJmf6UoTSaMYZImQgcXbl+VKv4KRNO1pn3w
         83IQZWLEhmnySC7Rs/I0IuURdFFjHrtWcgf36K3uP0Kfk9ueDHvTA9r0B+6FzLgZGISM
         MgSkwyXk+k8P/9tKPgYzoRmGI3DxdqOJX9DNYUjc32iDRHKq0mU3KgxXS0T2K1kIJpAO
         C7eQ==
X-Gm-Message-State: AOJu0Yz4O9+3KY/dk5FQYh6LbPd648n3jQ6YRxjVzn6UdoAe4l2XGERj
        sPmrATtprqkcC0/vTxwkAabZb/nSPVqI7DEn1NnJOg==
X-Google-Smtp-Source: AGHT+IFhKjoYARnFGO13ApN7eSk09nSCJTSeKyT66yoX39zQ2bSsEmHScKXeMW+UKEwtUalYt70IEOQCcn29bH3NZ24=
X-Received: by 2002:a17:906:5197:b0:9ee:295:5693 with SMTP id
 y23-20020a170906519700b009ee02955693mr8600960ejk.7.1702536700141; Wed, 13 Dec
 2023 22:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org> <ZXqlWT2JYg0sa7IF@infradead.org>
In-Reply-To: <ZXqlWT2JYg0sa7IF@infradead.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 13 Dec 2023 22:51:25 -0800
Message-ID: <CAHS8izNCvxuTsKV73oTu3xS7ZVr0riBdYGbKnsHptVe_e-t5MQ@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To:     Christoph Hellwig <hch@infradead.org>
Cc:     patchwork-bot+netdevbpf@kernel.org, shailend@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jeroendb@google.com,
        pkaligineedi@google.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org,
        willemdebruijn.kernel@gmail.com, shuah@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linyunsheng@huawei.com, hramamurthy@google.com, shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:49=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.=
org wrote:
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
>
> Umm, this is still very broken in intraction with other subsystems.
> Please don't push ahead so quickly.
>

The bot is just a bit optimistic. Only this first patch was applied.
It does not interact with other subsystems.

  - [net-next,v1,01/16] net: page_pool: factor out releasing DMA from
releasing the page

--=20
Thanks,
Mina
