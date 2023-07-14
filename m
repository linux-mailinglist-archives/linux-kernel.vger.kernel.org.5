Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF8753FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbjGNQrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 12:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjGNQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:47:42 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86EF358C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:47:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-401d1d967beso5971cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689353261; x=1691945261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QYU5LL8RJdkL7BFoOlbSKFeuoDzmVYj/8JTm9uv8m8=;
        b=X3mMrAb5dVNHXi17Np9apu56ox6VjgIKZ00SE3jwQlcIe3deuqboVajcZLIdu2jVag
         0ZF17PAzpggHvA72ApLakmf/ftIEQmsfrkrPxZ0o1jRGlCoMkOXm68KkVOSjWso+PRVJ
         yfJIY4gfzsxpzqlevGaVLvV9dx4ZbiP5c6LXFHsBxJwLp6TrdRbaM7RGfo5chMvXeo7g
         zhjs+rQptZjIYkqYpg53eFx1yyy99dxvB3CCk/7GcEEFRFVGpwBQ+LPtNy+iOoTH1DFc
         uIN0iby1TxZ3dH5LpDpxCG89RGD9URqf6eB/lfdvfcRZDYI3n53ZYYsyBmf/RzWGZ24y
         FE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353261; x=1691945261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QYU5LL8RJdkL7BFoOlbSKFeuoDzmVYj/8JTm9uv8m8=;
        b=Ubdwx8zekF3XmuTvZBzU3ROBI+PrYSu3iDFyIe+nl7a/+RL+0ZYYRtE2+HVudzBc+S
         G5epmZFAroonkxyiG7PRCoNLqsEEwvsGLaGZjxL/nNLSFcg8E/Tuo9DDHBe//fah/2ML
         roweWpxr0CWAABm8FXGVIe88REOuT2dzPu6AkR7Jx6olerqXrx1ktT1+1c8w2itMHlZu
         xaolub/U4LcWVB2XWa0glQB+w2Vs64QXwZt6OhwerLPlahd34qxMPhlEbMdInYzdTiBf
         BNN88d9uALTKEYzUgJCFzzW8IzVS2zLaLV/A3+PiZ8crhj4TptDpUhf7dJNd+Rw/OUL/
         bvvA==
X-Gm-Message-State: ABy/qLbc0Oo9sdRC5VRYUn5xFBANMb7gjLgyjVEviJhxmupMv+gKNSos
        76SQtPr9CV2+63MmapDFpfGq57W7ZD9XjM0w8wqqaA==
X-Google-Smtp-Source: APBJJlEeUaa71wKBwk+bfOPv+6l8wJuJT6Kr4Hh0GSDLWORC/ckCgpeescAjesgTFN/kWKaVfYYnZx7PWR5qJYkY+go=
X-Received: by 2002:ac8:5b0b:0:b0:3ef:4319:c6c5 with SMTP id
 m11-20020ac85b0b000000b003ef4319c6c5mr887225qtw.19.1689353260931; Fri, 14 Jul
 2023 09:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com> <20230714161733.4144503-4-ryan.roberts@arm.com>
In-Reply-To: <20230714161733.4144503-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 10:47:04 -0600
Message-ID: <CAOUHufZJtiTV4yb=9qRcYCCjotTWSeNiHQdapb7uQuoGuSNPDA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: mm: Override arch_wants_pte_order()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Define an arch-specific override of arch_wants_pte_order() so that when
> FLEXIBLE_THP is enabled, large folios will be allocated for anonymous
> memory with an order that is compatible with arm64's contpte mappings.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Yu Zhao <yuzhao@google.com>
