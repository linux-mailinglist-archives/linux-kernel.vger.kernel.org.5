Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347C57CC902
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjJQQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJQQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:41:44 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694AF0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:41:42 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49dc95be894so1736076e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697560901; x=1698165701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4dXCiXm+nSlYIXlVAe0G7HZWfsMN4hgxzFI7RqAkXQ=;
        b=sgbSyGDSPx+RQ3Uw9a6/Gg+1hiArsGnPI1U1dm75KvENcmZw88kMkIrTqX8sISvduA
         u3hl858KyIA0wz3Yie9jMMz5rEMTBMoVzpHewp5AdnTdUpisBS4wlrlv+l7TTuxbZwrq
         8Or7qkBPsmBnc5Ti4HKBjNn+VONC8+/sB+gr7cV6yS3W2gYj3g/d2WZwU9PhkSxsoN+n
         IdME21EVQx6LUpkqUggsdbcc2I7je6Wxt86n7kaGDCFviQlcPW/O4t3DEogaukghJXal
         W2Zdnw9EOBeDPcB64/FADIRDklpNz1WfOkSfcEXHZ6T5XEWtNFL2vBoS1owo7P5snuKf
         G04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560901; x=1698165701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4dXCiXm+nSlYIXlVAe0G7HZWfsMN4hgxzFI7RqAkXQ=;
        b=nb59g8M4w3wqCR6fRtKOWmYBkdooBuMccyQV4QvoKFM0uaHOmtPJUo5dsL7s6kGT3N
         mi93pm3MY2J/0LU1WiCrCp7TrBUzod7I0yD0lckfZIKvMvXzkBYtTi/z81IxrInW8kyU
         8mcFOscJjI3HukWvtCjNcfOuH9mb1a/CVkVwvM5bXLiOgGradONLePy647JTmkx04FOw
         VCkopZt8+ZBWk45r4RXI8ITRZksvv00H4K1vaASyca+FLK+Hw2ny3IIVpBQ9FKAqeTTY
         8dbOlVhxjDia2f+r2xINZfnunaGVwanGN/YinD/PPwMRKg7Rm35nFSYOk+pGPanc8DQy
         LjMQ==
X-Gm-Message-State: AOJu0YxsBNWl7FaErmpFhSsZQ1iW8lsXpKMbme9rQzbo4Ds2MY+Dw0AZ
        VYwtuo14F4ae48rctNyg5l5aL681lIzOit+rMaUvwnGsVxZfvM8DnoPWib/Y0OuaHzlDW2guBwB
        7UupAzB/K/0TB+gQPRPbLRtz7iWkIEZ0=
X-Google-Smtp-Source: AGHT+IGrkqBPcTiMViMm0E1Xu6HZCof0/IK+kGAiWbbAIxwaj1pzd+mxP43jrI+npVT1i/85Cm1NXRGfroCTQBWMVMc=
X-Received: by 2002:a1f:a28b:0:b0:49d:9916:5740 with SMTP id
 l133-20020a1fa28b000000b0049d99165740mr2464736vke.9.1697560901500; Tue, 17
 Oct 2023 09:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231017162800.24080-1-larysa.zaremba@intel.com>
In-Reply-To: <20231017162800.24080-1-larysa.zaremba@intel.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 17 Oct 2023 09:41:30 -0700
Message-ID: <CAKH8qBvrAQKhd=J+5HzVzrjmexk6ENwFjyGyxGV6e_9sRQg7Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add options and frags to xdp_hw_metadata
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ccpol: medium
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 9:35=E2=80=AFAM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> XDP hints and frags together").
>
> The are some possible implementations problems that may arise when
> providing metadata specifically for multi-buffer packets, therefore there
> must be a possibility to test such option separately.
>
> Add an option to use multi-buffer AF_XDP xdp_hw_metadata and mark used XD=
P
> program as capable to use frags.
>
> As for now, xdp_hw_metadata accepts no options, so add simple option
> parsing logic and a help message.
>
> For quick reference, also add an ingress packet generation command to the
> help message. The command comes from [0].
>
> Example of output for multi-buffer packet:
>
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[15]->addr=3D10000000000f000 addr=3Df100 comp_addr=3Df00=
0
> rx_hash: 0x5789FCBB with RSS type:0x29
> rx_timestamp:  1696856851535324697 (sec:1696856851.5353)
> XDP RX-time:   1696856843158256391 (sec:1696856843.1583)
>         delta sec:-8.3771 (-8377068.306 usec)
> AF_XDP time:   1696856843158413078 (sec:1696856843.1584)
>         delta sec:0.0002 (156.687 usec)
> 0xead018: complete idx=3D23 addr=3Df000
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[16]->addr=3D100000000008000 addr=3D8100 comp_addr=3D800=
0
> 0xead018: complete idx=3D24 addr=3D8000
> xsk_ring_cons__peek: 1
> 0xead018: rx_desc[17]->addr=3D100000000009000 addr=3D9100 comp_addr=3D900=
0 EoP
> 0xead018: complete idx=3D25 addr=3D9000
>
> Metadata is printed for the first packet only.
>
> [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
> V1 -> V2: drop gen_socket_config(), remove extra spaces in help message

Acked-by: Stanislav Fomichev <sdf@google.com>

Thanks!
