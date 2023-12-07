Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254B1808BE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443485AbjLGPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443511AbjLGPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:31:27 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86010E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:31:33 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso8431791fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701963091; x=1702567891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtiqskbcnjDsrUAbUuslefnc5brEtYif6q3+FyG2PFY=;
        b=jCyaOTKkw5F46rIkMqCj08yiy4EOcJmeFOCfGoux3CKP4CbWwdi2Rzyrj+BdXfnGTv
         ZEUWTWC7IA7iOPTj+Q0IFe8TqYvCypmgUsM9hQeDWwPkFkrsjdvCfpSHFLNn/sXZqdqD
         iJbLco53IlI0bBiMQyfMupIoyJZAKjvbeOpt5uL/vLIF/d54iv+6UvpF0y167zDuw4m1
         Iz9Zid7dXWxVaWBRx2ob48PZNn8sd5QM2tKZC+8Dxl8VRj4Rczu2GzdT3l2Cblx6VhDZ
         oWxJTIpYEhhZZMg3jTTcCM9pc+gK9pbTKwZ8b7R4oFeMZEyo5PO2kUtGXaAgzKt50K4M
         99eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701963091; x=1702567891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtiqskbcnjDsrUAbUuslefnc5brEtYif6q3+FyG2PFY=;
        b=BVi8OUP+4Qn2pr9M1QhWlKBAV54edZGRZw3Sm3uSnUgxFQHlJyKi/oIkst++GXSBg1
         d/IGjYHDNtxckVWtaLoXdflh11rd6IYSGz+gslF+b42KKr6WwhKkKlxs7CjvsSILxduT
         LrMW4u3pRWWsuUzLQrcIyeIUk5pJEdXTVlQ0ToKWbYZ49BB1TrLZh5ObxclyyeoRKU11
         ur/E88rhJzLpU0VyfBDkznTA0IOqbtrYL8TU3OzsxM90JXX3nl/G8pkhozOK97FXdA4q
         uO2B4e4eainBEoZwR6/FZsRmHvNp7nK7OcJUWHZ8++K0jAsf5Vc0+eNsH/rNvP/TJht9
         PYvg==
X-Gm-Message-State: AOJu0Yyhq/lKHQMB8xBe2PHJNpUIif2xgdJHFkUSgx1V5dY6EVXWW3DK
        SLzH3jiXY1511rGDHsPrQ+rbHJ9a3opV945h+H5KyQ==
X-Google-Smtp-Source: AGHT+IFlA9HTmihxqP9eI8R5gPdPM/Z8JG8U15RyZk88XiZ+K7z6TR3eNC4WO8VGtec4ngEHJsTq9LU+nvqWPHIWwIA=
X-Received: by 2002:a05:6512:4015:b0:50b:f52b:e337 with SMTP id
 br21-20020a056512401500b0050bf52be337mr4185096lfb.1.1701963091444; Thu, 07
 Dec 2023 07:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20231206074155.GA43833@sol.localdomain> <mhng-9f5b6a98-57f4-40a8-becc-93319bbed97c@palmer-ri-x1c9>
In-Reply-To: <mhng-9f5b6a98-57f4-40a8-becc-93319bbed97c@palmer-ri-x1c9>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Thu, 7 Dec 2023 23:31:19 +0800
Message-ID: <CABgGipVad0ohfhWc4tA0865atKLMLazwJ4u-3e3MF=aesVKQSg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] RISC-V: provide some accelerated cryptography
 implementations using vector extensions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     ebiggers@kernel.org, jerry.shih@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, Conor Dooley <conor.dooley@microchip.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>, heiko@sntech.de,
        phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Thu, Dec 7, 2023 at 1:07=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Tue, 05 Dec 2023 23:41:55 PST (-0800), ebiggers@kernel.org wrote:
> > Hi Jerry,
> >
> > On Wed, Dec 06, 2023 at 03:02:40PM +0800, Jerry Shih wrote:
> >> On Dec 6, 2023, at 08:46, Eric Biggers <ebiggers@kernel.org> wrote:
> >> > On Tue, Dec 05, 2023 at 05:27:49PM +0800, Jerry Shih wrote:
> >> >> This series depend on:
> >> >> 2. support kernel-mode vector
> >> >> Link: https://lore.kernel.org/all/20230721112855.1006-1-andy.chiu@s=
ifive.com/
> >> >> 3. vector crypto extensions detection
> >> >> Link: https://lore.kernel.org/lkml/20231017131456.2053396-1-cleger@=
rivosinc.com/
> >> >
> >> > What's the status of getting these prerequisites merged?
> >> >
> >> > - Eric
> >>
> >> The latest extension detection patch version is v5.
> >> Link: https://lore.kernel.org/lkml/20231114141256.126749-1-cleger@rivo=
sinc.com/
> >> It's still under reviewing.
> >> But I think the checking codes used in this crypto patch series will n=
ot change.
> >> We could just wait and rebase when it's merged.
> >>
> >> The latest kernel-mode vector patch version is v3.
> >> Link: https://lore.kernel.org/all/20231019154552.23351-1-andy.chiu@sif=
ive.com/
> >> This patch doesn't work with qemu(hit kernel panic when using vector).=
 It's not
> >> clear for the status. Could we still do the reviewing process for the =
gluing code and
> >> the crypto asm parts?
> >
> > I'm almost ready to give my Reviewed-by for this whole series.  The pro=
blem is
> > that it can't be merged until its prerequisites are merged.
> >
> > Andy Chiu's last patchset "riscv: support kernel-mode Vector" was 2 mon=
ths ago,
> > but he also gave a talk at Plumbers about it more recently
> > (https://www.youtube.com/watch?v=3Deht3PccEn5o).  So I assume he's stil=
l working
> > on it.  It sounds like he's also going to include support for preemptio=
n, and
> > optimizations to memcpy, memset, memmove, and copy_{to,from}_user.
>
> So I think we just got blocked on not knowing if turning on vector
> everywhere in the kernel was a good idea -- it's not what any other port
> does despite there having been some discussions floating around, but we
> never really figured out why.  I can come up with some possible
> performance pathologies related to having vector on in many contexts,
> but it's all theory as there's not really any vector hardware that works
> upstream (though the K230 is starting to come along, so maybe that'll
> sort itself out).
>
> Last we talked I think the general consensus is that we'd waited long
> enough, if nobody has a concrete objection we should just take it and
> see -- sure maybe there's some possible issues, but anything could have
> issues.
>
> > I think it would be a good idea to split out the basic support for
> > kernel_vector_{begin,end} so that the users of them, as well as the pre=
emption
> > support, can be considered and merged separately.  Maybe patch 1 of the=
 series
> > (https://lore.kernel.org/r/20231019154552.23351-2-andy.chiu@sifive.com)=
 is all
> > that's needed initially?
>
> I'm fine with that sort of approach too, it's certainly more in line
> with other ports to just restrict the kernel-mode vector support to
> explicitly enabled sections.  Sure maybe there's other stuff to do in
> kernel vector land, but we can at least get something going.

With the current approach of preempt_v we still need
kernel_vector_begin/end to explicitly mark enabled sections. But
indeed, preempt_v will make it easy to do function-wise, thread-wise
enable if people need it.

>
> > Andy, what do you think?
>
> I'll wait on Andy to see, but I generally agree we should merge
> something for this cycle.
>
> Andy: maybe just send a patch set with what you think is the best way to
> go?  Then we have one target approach and we can get things moving.

Yes, I think we can split. It will introduce some overhead on my side,
but at least we can get some parts moving. I was preempted by some
higher priority tasks. Luckily I am back now. Please expect v4 by next
week, I hope it won't be too late for the cycle.

>
> > - Eric
