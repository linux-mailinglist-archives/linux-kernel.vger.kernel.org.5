Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF175B5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjGTRtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGTRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:49:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B8269A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:49:35 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8baa836a5so7937055ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689875375; x=1690480175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8yROjrlp1PPFH0to9KuHuG8CxyzdAeh3ld6lplKCpw=;
        b=fyS7XMJPOaTP42oTe22seQohWF8aMbOeiPkaE4J2rWqXd1fUC0RtFqF+vTZPIJmLNL
         ri3EdeoE1FnRx13n5l+ni8jjeBnGqlLcaqfa1g4UteZwo7zVvXz2VCqdEf4edxKk0Lmp
         W24+7P6VC8EKDRSLRTzjFybQKN16HrMn+ukzGKtFc5+Q9gZIrIKaewXZXAFyEKYdK5F5
         gcp+xF0dnH6zhzNovfCSS4QhbIUL1na8WmipAbtF3FF/YRpO6YXrF1YjoeZtuG4Z7mNA
         fxflv1CyeRy/DmOw1Hm9chGK0mBPDP7svtXQYfW1EWYsP8X4JECAT43UnDtGkdcO4TgN
         L/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689875375; x=1690480175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8yROjrlp1PPFH0to9KuHuG8CxyzdAeh3ld6lplKCpw=;
        b=QGmw3C6oEgIEzxjaQyT6jCIsteoZCEerklUAm+ICFOcR20oCtYdz23JPPVE2pdBno8
         jKGmPG5kmzi5TjLTI+IzXwUGttjPnrHtpt2Wbsy8m/HOi3UlhMD3Dnu3T1/pTDiGdxT2
         VfDnxic7znp2LMT5jxctUxVm9MsyXzfzkJB4RuEiCXAiGfOV8w50BMAm3Vym0FfgF9p5
         TOG5Cur4xegaBba9L5wdFM0pn+nP9V+6PSj2emwDENd14PQekp6Lwo8yJ5SuGSg4iv8W
         YBuaKVjSFUmcrOC9lyZW7IGG+AxZF5c7Nm/ydk0FuHr9UJuGANwC/hzlaBp0ITSgmxXV
         kNfQ==
X-Gm-Message-State: ABy/qLa1zmNQvPa09yRDIjbvSZALYL9idxi4nZJRz2IN6yUMI6CwrUI2
        rWxDQWNFpHHLtFkbfFY0j2wqaBWHzEIUDQB2ji2gpw==
X-Google-Smtp-Source: APBJJlEznZxAu+zz9Hq/h2JamBEIRqdk1o93ouW8Qs8XupLnxLYmEqfyZR8bRDDrnYiuby2sGUoNd8RNY4w9bloJSpg=
X-Received: by 2002:a17:902:a415:b0:1b3:f8db:6f0c with SMTP id
 p21-20020a170902a41500b001b3f8db6f0cmr94423plq.58.1689875375330; Thu, 20 Jul
 2023 10:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <1fd79e5c53d9d6ed2264f60dd4261f293cc00472.1689792825.git.tjeznach@rivosinc.com>
 <d766f11f-45a6-9d47-3bfb-b3632a0b0f0b@linux.intel.com>
In-Reply-To: <d766f11f-45a6-9d47-3bfb-b3632a0b0f0b@linux.intel.com>
From:   Tomasz Jeznach <tjeznach@rivosinc.com>
Date:   Thu, 20 Jul 2023 10:49:24 -0700
Message-ID: <CAH2o1u4Y5R16QQsed4TuKKiv6ir+uWB98A3Z5adBaF8pPLQ5Eg@mail.gmail.com>
Subject: Re: [PATCH 06/11] RISC-V: drivers/iommu/riscv: Add command, fault,
 page-req queues
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 6:18=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 2023/7/20 3:33, Tomasz Jeznach wrote:
> > Enables message or wire signal interrupts for PCIe and platforms device=
s.
>
> If this patch could be divided into multiple small patches, each
> logically doing one specific thing, it will help people better review
> the code.
>

ack. I've got a similar comment regarding this patch already.
I will split and add more notes to the commit message. Thanks.


> Best regards,
> baolu
>


regards,
- Tomasz
