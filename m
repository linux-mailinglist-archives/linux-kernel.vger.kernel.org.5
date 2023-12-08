Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76880A54F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573947AbjLHOVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573924AbjLHOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:21:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F1FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:21:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d05212a7c5so15614495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1702045274; x=1702650074; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCd0FA+bVQeIcvXDa2TD93zB2DHUHCGJqjnMlAyvxpQ=;
        b=Q58QdoEO7IZqcj+XAVjmCWJ/0Uv3IfW6ctWelx5o+/ujY36mWDdtrjcCL9UmbnzZJq
         q5PDMcwWvKMH+Ytz+gV81Tg+bVbQHfMjhRGiFa5E+iUNb2LyJZ6wOqnkXkx3DKxNqXuH
         xejGfxfwk2vUXC+5fm9PS81liaCUouU9cTfFV//6JOZ/Ogc58behztEyrFDcP8Reoh9G
         dcIp7pJR2m5UUkNsNhQqEGrYHThsiu1z7+95cJ1ZnhbIHLRXx8d8eYzMTaplPt8vKeoP
         drgn5FePdQ+m2+XngSL5jVJ+Z/gPELBDXgfw9BjKy4BW0q+CWThuy9slPrAdBTfRaN8E
         2P9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045274; x=1702650074;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCd0FA+bVQeIcvXDa2TD93zB2DHUHCGJqjnMlAyvxpQ=;
        b=AR2eqV2Qd6IPlUmXPD8/S8F4Hwg0lNWKwaLqgprq69ZZkIM7sPZVKxTslVEyPSlrYV
         4h7r27DOgSSa+L+dAtDli5XQAAdfFjkp3LYdNPQGtYMEtx5w4o6NSeGPWICA2aSGbpC1
         vx8n26NHATSa7OjGChZkjIqxOeAYtxYrtcXHMpnItzD/kKUWiN4sl6MBmkR6Qt9dXe77
         WE098AfiFKXmiha1lNeIjHNg5/jK9k5DxclpolxvHTacs3DWU93OIuit4qqb0JRvMuFc
         qh3UFNgiIU9NKGsyL8b/ZXP8u8tkJ2Q3/uRjuGVx38lRUIFKHHK8iSxSEhLc9x9KUGd6
         jvNw==
X-Gm-Message-State: AOJu0YyvxsI8BHsC7VCqVXXs/So2+FL3IpPKdLtQzknX0fqs9HLEciwU
        kmx76iaRmJ+2UwAoH3gCaLOCNg==
X-Google-Smtp-Source: AGHT+IHwlumcMpdbuU+t6ciZZNA+aqEFVTpJfmu7mhj0VYxM8wQq6xWIe5iNguZcs2PTZrDQw5McbQ==
X-Received: by 2002:a17:903:40c6:b0:1d0:9c54:2fa5 with SMTP id t6-20020a17090340c600b001d09c542fa5mr92862pld.25.1702045274612;
        Fri, 08 Dec 2023 06:21:14 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:63d0:ab90:b485:daaf:65e2:834])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b001b53953f306sm1755818plb.178.2023.12.08.06.21.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2023 06:21:14 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
From:   Gianfranco Dutka <gianfranco.dutka@arista.com>
In-Reply-To: <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
Date:   Fri, 8 Dec 2023 09:21:11 -0500
Cc:     Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6EE460E1-BDC2-4AD5-B5A9-34AA0692BA05@arista.com>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. =
I am in the process of improving dynamic CPU isolation at runtime. Right =
now, we are able to do isolcpus=3Ddomain with the isolated cpuset =
partition functionality. Other aspects of CPU isolation are being looked =
at with the goal of reducing the gap of what one can do at boot time =
versus what can be done at run time. It will certain take time to reach =
that goal.
>=20
> Cheers,
> Longman

Thank you Waiman for the response. It would seem that getting similar =
functionality through cgroups/cpusets is the only option at the moment. =
Is it completely out of the question to possibly patch the kernel to =
modify these parameters at runtime? Or would that entail a significant =
change that might not be so trivial to accomplish? For instance, the =
solution wouldn=E2=80=99t be as simple as patching the kernel to make =
these writeable and then calling the same functions which run at =
boot-time when these parameters are originally written?=20

Thanks,
Gianfranco=
