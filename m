Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121EB798A23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbjIHPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjIHPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:43:14 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470841FC7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:43:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0e7e3d170so135845ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694187790; x=1694792590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejXqpKu8kQzY2C9Hwied0dLrXN/PvCiO6ZeCOYXfoyo=;
        b=eCEdDyXxGHpTTwIs90Wj/Fy/4ROMIrK23vc6InO3ftkAW/p80gkP+d9HnxawZnDpQE
         D3HoP4mm+wrsQf5mzZ5h21jdlstAkJuEyPRU0LfeWEjzBURvdqTAli55+IAKQQYSnsAG
         NB2F5WqAapAMsgooYBd3zRhPHBkVR4L2xOsNfHfgQmTqhvDPUy+/VYzgdZGaV1xyz44M
         nF6D71OBsY4sbUpTYv5TsG0+2/zOLEWQlA430OKJOQdwkGg+cyAUKTBXAOx8gjUY80px
         vCnXVPzIGyUMUlN3l7hObOhfrMxp7QESUuYuDGLIdOlbcUp0qISnIRSzO/SoGag2rji8
         grFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187790; x=1694792590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejXqpKu8kQzY2C9Hwied0dLrXN/PvCiO6ZeCOYXfoyo=;
        b=wTDilfsx0SLF9cHz9ySxmo7Apy/dWzcfNj2xRTd2dNdR0UwsEvDn6ri2KaT1dyaunh
         Si8gYv8AtGNWwnlHoRyuVQQRxjMimwKR00tKCollEgrHKqmMs/H73sZNYmp0Ct4opSh8
         0bDaBeGq3PWMsU1GLteFURq6SUJzO1oGA4w9StzNAi+grS+CEdFA9AepFS481uMffXRa
         GRFvDaFkHWIKb24FgFQQ3Tz/yKVeSgMO2eHu4JWyp3d3rzFPIw/6Zk3+w/SF8sL0y3/n
         4bsTOqpNd+QkvrTpLLb6PRAdqceQzZc1DJe+m+ea1WU+XA1Z0NB7y6vdhuWgQRMlBOGs
         n7Lg==
X-Gm-Message-State: AOJu0Ywq3GjcfsEG2MLWCGooukmKY6pfYSd+LX/Sp+oMYZHU5P8qsCvs
        miZ77j8zWCmMAK+wKKA9MO637RTRFiJLqBqHQjrkJQ==
X-Google-Smtp-Source: AGHT+IGF4KgcARS3ELwU3djcOgRsJ8LUV9Z2iRMZaHkfbRj2AhZyzhZsFu8/E8c4GO03km/XfNifFFOFwPf3OCxHkGA=
X-Received: by 2002:a17:902:d2d2:b0:1c3:39f8:3e72 with SMTP id
 n18-20020a170902d2d200b001c339f83e72mr272217plc.22.1694187789585; Fri, 08 Sep
 2023 08:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com> <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
In-Reply-To: <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 8 Sep 2023 08:42:58 -0700
Message-ID: <CALvZod6zuPy5p6m5ins2+BQMwmEeAWiz+C5vtF7pVZdcmKNGcQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on alloc
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 8, 2023 at 12:55=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Friendly ping :)
>

Sorry for the delay, I will get to this over this weekend.
