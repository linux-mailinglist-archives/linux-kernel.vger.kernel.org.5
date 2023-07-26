Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F45762836
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjGZBib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGZBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:38:29 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09B126A5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:38:27 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76ad842d12fso497623285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 18:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690335507; x=1690940307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbgWKCuCj/Omvba/7tqwaalVu90LErpD4j/GDLXb99c=;
        b=LoqBio8RQOAMQhcmOJcaLwZR7UcjmPZNKoe7hH+aPnkE6d1dz9BPAVh7NC5TAH2AAk
         hMWjvFcunsKnoNpl/N2bKrLgk7xF8bBFaTNe2lQtZB1/HhgH5AQaQojQHYk9Wb3GmHll
         xmvKZ8F+7bj8eP4f0duRQDmfQR3r8Es0L4JFGzUaCzYw92Yg0G0zzSU4FgQkx112MnNi
         ewquHnC0idqwbzxLCYZ6l1yJneyZYT6oByiP2OIeIfypJU+B3yr8QASxI66pkBLjb/LC
         SQyFp83Ns7IaRvicopGdBtI809JkOGs/D+rscfrgvpnfHu0y3n1WaBjkrg0UqQKVLh19
         A9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690335507; x=1690940307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbgWKCuCj/Omvba/7tqwaalVu90LErpD4j/GDLXb99c=;
        b=ZjydzVxz6kDrpG3UyvZF7xiGpKUOvbYoPdu0RtPUnQWd2TByLVlZIe8x8v7JTRtJ1U
         u2SwwL8NEf3wGHfz8r1sgJ6Dlh/c1uC/DT3QJc5armOuEZorgRs27Wv7YhrTbo8O0qKk
         zi8BqAr7p5cCy2ltyfjztDsbqEDOXAKoixhUp0MjMuUrMKeWcmfx3jbXI5h/iH3nophj
         YgBypdn6GT4TzvAyiHkRpXy9jUhDIIpgIqtM8UjJs5++xpsiWJQcMh8nxq5FhAxtlIgR
         D/98O6yMQ5zbdJkSTBbQvNel80YNDQ6A8eOOKKWbM4hB+dMLy7I5L/m4rYWWAnrhFnJI
         uWnQ==
X-Gm-Message-State: ABy/qLarXI/fAnEbyO4aLl3jtexutDYOlvaxp2BcbtUAR6zPD97GAu3X
        qe9OzS8RebtruJaI04BeFOZBJuh67lvfOAg78VySPQ==
X-Google-Smtp-Source: APBJJlENQF4ezVhy4E842gW8nERhoJjO63HZHSlEnPGEiUaMRktnohAfSIUQCOqjsJw/CrUTwgKfGehUfslxRGNq14c=
X-Received: by 2002:a05:620a:2f8:b0:76c:4d4c:7940 with SMTP id
 a24-20020a05620a02f800b0076c4d4c7940mr590338qko.72.1690335507122; Tue, 25 Jul
 2023 18:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-upstream-beaglev-ahead-dts-v2-0-a470ab8fe806@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v2-3-a470ab8fe806@baylibre.com> <ZMBmalZwaRCiy2BG@xhacker>
In-Reply-To: <ZMBmalZwaRCiy2BG@xhacker>
From:   Drew Fustini <dfustini@baylibre.com>
Date:   Tue, 25 Jul 2023 18:38:16 -0700
Message-ID: <CAFTh7p3m+4kLxPV+NXJWSRW-ZDZv930z=SbfuELmgcZFnQ4fig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add reviewer for T-Head RISC-V SoC support
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 5:30=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Mon, Jul 24, 2023 at 10:20:40AM -0700, Drew Fustini wrote:
> > I will maintain support for the TH1520-based BeagleV Ahead board so
> > adding myself as a reviewer for T-Head SoC patches.
>
> Hi Drew,
>
> Thanks for your interest in maintaining the SoC support part. However,
> maintainership involves active reviewing and maintaining the whole SoC
> support part and not just specific board part, although currently, the
> SoC support in mainline is minimal. I'd like to see your patch
> reviewing, testing and so on.

Yes, that is understandable. I was just adding a Reviewer entry as I
am supporting the BeagleV Ahead and I would like to test patches
related to the th1520.  But it is not too big of a deal as I am also
subscribed to all the relevant mailing lists that would receive
patches.

Thanks,
Drew
