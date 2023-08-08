Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48507745AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHHSpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjHHSoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:22 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896BF3CD00
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:38 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99c1c66876aso816979666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=EePW+ss015g11YgFFHMy90Z5WBj/PCKy6a/lhF3ExOntSwvl8wOFfJQ1JbeQoQrrOx
         xGv9mUGakIoi++O8fmZPptc9lYFC2bKDg9uXW/+1Mxi9bbiHs3cBrG5MKCqPjOigSNk/
         6O3T2Scei8koWcY2M/Eaj3ZH5HH0kvS2OwUipqKRF44XHNPvdm7NRKse4GbRIsRU3CNw
         MHRQ4gStC0CIZh/3TmsijzYoIO2grgcREPRoC80135uNlMXE9RheTTzhehwkkqfMOILw
         IG+BZkUNI0ZVxYlQC6LMviOYgjd4hQSn16di8r9dqB6kv/iUsDpTXsLNS+LLy0b/jFrX
         XBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512570; x=1692117370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bw2MRgpkFm1vILiE0Y5MYyZNNxscMVN+eqSvqqHwK4=;
        b=OcKaT28zpA/VX1Qqs5brYjn9RRyXjznE1pXkW9Ysu8IcKFTjDXJSTdaQGtQlUKuAyp
         YB8nATh0sRmKQ9qdylEGr81GIFVg4OCMMwPmc6HAq5HaHUerUghs08BuBHR0WHI+YwYH
         jfaghMSHDX8p5gRDNZHIKfmqlACg2gd7h3x9kgRZtX0srgFuiXmN9PUHdLF2FH+at759
         naJAaf0OBD1fS+Folg87Pl4qnKBRKEZWk17O6ccVpAXq6snweswuoJaT/q8pKFz1PfWq
         AcdmcuA1w+JecGsXLKCCIb0tFPrnsDWg7VbdsNqbjZZuAxuaEK5zs+4pzJeQg0lpkdAX
         GqtA==
X-Gm-Message-State: AOJu0Yz/wQge3rprcvm8M3yrSFiBV1eHJsqBIHKrkBWX2OqN8F8q4XAx
        bVBjy5qubEZULC747WRa9Ba44n8nzyTAG0YYNNIvmQ==
X-Google-Smtp-Source: AGHT+IGyc5YFMEUdUm3mgxMUbhzIYZxUjCAeYEgPYwAXs5W80a27H3BIhOB0Da8QtwlqT/aZI8FmyxUNTteHqh8I214=
X-Received: by 2002:a17:906:217:b0:98d:4000:1bf9 with SMTP id
 23-20020a170906021700b0098d40001bf9mr85402ejd.65.1691512570147; Tue, 08 Aug
 2023 09:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-so-reuseport-v6-0-7021b683cdae@isovalent.com>
 <20230720-so-reuseport-v6-7-7021b683cdae@isovalent.com> <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
In-Reply-To: <CAP01T76fZhrELGxsm5-u85AL5994mS0NGZd6gw-RYaHE8vKfTA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 8 Aug 2023 17:35:59 +0100
Message-ID: <CAN+4W8j7Lyh4Zm1neabe2f+DJWbP4zRrATM4rwD3=EBS0s1CjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf, net: Support SO_REUSEPORT sockets
 with bpf_sk_assign
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Hemanth Malla <hemanthmalla@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Joe Stringer <joe@cilium.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:23=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Hi Lorenz, Kuniyuki, Martin,
>
> I am getting a KASAN (inline mode) splat on bpf-next when I run
> ./test_progs -t btf_skc_cls_ingress, and I bisected it to this commit:
> 9c02bec95954 ("bpf, net: Support SO_REUSEPORT sockets with bpf_sk_assign"=
)

Thanks for the report. I forgot about struct request_sock again...
I'll have a fix shortly, I hope.

Lorenz
