Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7FD785F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjHWSRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbjHWSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:17:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3801CD1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 11:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B936251E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A21C4167D;
        Wed, 23 Aug 2023 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692814628;
        bh=oVc34mgV3FCHCFRuWZIFh7s3iqRrh+uYOxu0gKgphbc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gbl8Ho+OIJFBCVGkffy0ZCht+2m9HlRKIBb+duA+VU3Ht+iJBwRrlDv1vyAcArPps
         Zt+17ndNPH54GvaNh/oBz8tlBp/nZAKHignXtbUKnNPqEXWmn3dDwp8IdgFhJ8dzMa
         HwHKIDXMJ/uqCIpdB9JTLjEwfbPOPgvWn/4EcmIItoiStt0TL5MgXoTiF6XzgsTZc5
         bigYmUMs41UnYcr88jWVP9DxRfX06OOqGxR7uKaYnhAJ8+iFtBDDtMzniXIGA81gaS
         OOFuFsMwDe2Y85oXpD1Z0ZR1GWeBrnQWqGy7cpsInsjF3Jm7lgOBAmuPeCPpGKTTQI
         BQMCMes+TQKog==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 2/7] riscv, bpf: Support sign-extension load insns
In-Reply-To: <20230823231059.3363698-3-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-3-pulehui@huaweicloud.com>
Date:   Wed, 23 Aug 2023 20:17:05 +0200
Message-ID: <87h6oplj32.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add Support sign-extension load instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
