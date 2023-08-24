Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74F786A83
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjHXIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjHXIpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CC21BC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 01:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14EED667D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3449C433C7;
        Thu, 24 Aug 2023 08:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692866689;
        bh=WjEYwIQ+ih0hWZawOakYEwJaByLhV4TUxI5aS7GWA/0=;
        h=From:To:Cc:Subject:In-Reply-To:Date:From;
        b=Kuw5XgYtBdePEfpDXm+rMna34IdIqO6nIntgkMaZ0tQ68B8B1hPt7xm9wEhMFaERm
         N2pnkKF6MkAGGbESHjBvdcAJPWyQfe5ibVSsBZ4buLdtsb9+mBIn5sa6v6PCyBp8Ac
         OwMzgjzf3jf61kmzLquG0YRKp+AsLpUyYjGDKLNvksPIH+BVdGtjgOzawgpfjzPYR3
         wy89wH1bj77qt+GyXtZ8hocYhI5hYqFXfkdIL6GPqKQ2xRdrUw4LmhmOeaEQzWP9im
         CxYeg+OPCQfIxeYIEyO4kqPTFUAcl+MKEv1/iLrXtaCma6hgCbYQdAKfsdr2dGN7Ci
         KCnZ3rJYuVpAw==
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
Subject: Re: [PATCH bpf-next v2 3/7] riscv, bpf: Support sign-extension mov
 insns
In-Reply-To: <20230824095001.3408573-4-pulehui@huaweicloud.com>
Date:   Thu, 24 Aug 2023 10:44:46 +0200
Message-ID: <87zg2ghls1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Add support sign-extension mov instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
