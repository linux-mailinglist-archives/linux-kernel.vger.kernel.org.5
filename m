Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE89807C7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjLFXmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLFXmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:42:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD3A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701906175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
        b=aw7ZSKVRhc+Cv6WYcyTcci+vEVhwrIlKvpLcN4cIPtobzKNcswMYCqdnkLlyXFT1trqMi+
        DsasMXxC7IgWhXqVKms3KuBeDN8QusASudWU0+cvRG4BpXqGB7lHNOJGqlf0uIvAYgKWLv
        cIJRnkbc+wTImz1kCaWCMh3UDbK6KgU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Yl5_rA-qMV2etVc0_SZVDQ-1; Wed, 06 Dec 2023 18:42:48 -0500
X-MC-Unique: Yl5_rA-qMV2etVc0_SZVDQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c504e5fd0so174363a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906167; x=1702510967;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byKhWzYdmi5fEDA2bFIRQYvHyYjTkEKHVH1O6k33LAM=;
        b=L7tvV0ydh73VZxxK5yirU7P9t365/d/gtQikGJqsEGnBjTsptfcs04BQ6SnedyAkSH
         S8s2pZoP/tQv70p0tQVF9rIOWS78xaLl6Hn5sQDmf1x/zmDfwSBlvdYPMIPwy4k9FE+/
         0GzLndI3y/nzHNLWJ/WscMu55kILKYPx9DR5cWABvButilrhen0ORpCWKUdiqXBmJtPA
         c9LDM/zxT77RhjveQj5r9OO6wBdHI5a4RRDpC0da6vh1HxOERx1ELVhh1dsjdSMIWDMv
         gab+nD8rWvai50Ec+PkAv0VlFsc1kiaU0Xa38K6zAaGcN1vCnk2C8JdpSPLaJ7PLdQIN
         bEEg==
X-Gm-Message-State: AOJu0YzEojr6PTrc/lhrmwUbVceNio0+bRAbD4wwincbWHSmAm+UUccQ
        uTMyGyQhEbffkKBBcIT9lBET40/CA7WqpP3JqBBod/gHI08zqBKSud2DU6nHGo8JgfPOBqLBLaT
        5iKtw+MYYtcIvlEh2cS73T4fD
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226998edd.29.1701906167715;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7vRlA+d/H97Tnlmdjl2ipDcurwnvVNGgVnqnqh+mn1wCaJMNyLFxRFkKmPIdyJdpL930WWw==
X-Received: by 2002:a05:6402:51d4:b0:54c:793b:8e29 with SMTP id r20-20020a05640251d400b0054c793b8e29mr1226972edd.29.1701906167447;
        Wed, 06 Dec 2023 15:42:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u21-20020a509515000000b0054db440489fsm80993eda.60.2023.12.06.15.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:42:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2CC53FAA7F4; Thu,  7 Dec 2023 00:42:46 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cake@lists.bufferbloat.net,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH 0/3] net/sched: Load modules via alias
In-Reply-To: <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
References: <20231206192752.18989-1-mkoutny@suse.com>
 <7789659d-b3c5-4eef-af86-540f970102a4@mojatatu.com>
 <vk6uhf4r2turfxt2aokp66x5exzo5winal55253czkl2pmkkuu@77bhdfwfk5y3>
 <20231206142857.38403344@hermes.local>
 <53ohvb547tegxv2vuvurhuwqunamfiy22sonog7gll54h3czht@3dnijc44xilq>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 07 Dec 2023 00:42:46 +0100
Message-ID: <87sf4elwy1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> On Wed, Dec 06, 2023 at 02:28:57PM -0800, Stephen Hemminger <stephen@netw=
orkplumber.org> wrote:
>> It is not clear to me what this patchset is trying to fix.
>> Autoloading happens now, but it does depend on the name not alias.
>
> There are some more details in the thread of v1 [1] [2].
> Does it clarify?

Yes, but this should be explained clearly in the commit message
(including the reason why this is useful, in the follow-up to [1]).

-Toke

