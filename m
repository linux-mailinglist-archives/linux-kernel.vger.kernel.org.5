Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E57D5F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJYB42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:56:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6377B10D4;
        Tue, 24 Oct 2023 18:56:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6874C433D9;
        Wed, 25 Oct 2023 01:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698198984;
        bh=+Ke3Py58KPo3fESPPIaGbDvnIdqyhoEV9dsK/zBAFes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2Wz53+fv+kMQXAC8g8UKH51fJKka53EryWc+nlhdqehGcVmChIc4HtWFCUGjMzJR
         EOFTSm9pT6SWS4ixGuVGREm75RCw47/sTutHGwT50t4Z6lCIDcptJMEQiig0KKQHwQ
         aGqV8dhwjPhNSrAB2NzSFGEcu06xp3H7mKMbwXs6ZycaIKhR/ucGheJmxM8uJzUBze
         YofpSEcHkVk5ZR3cjCJ6JuiQQoq85tYd44dMwxnr6KeeTF67ekIMzH9qpU6ALGuirx
         QKOjzMq5TKOClr0LBFcHMeUyUUeW8pG0h4N3JQLbCByKZR9f1vj3A8lrZHW7HV24sF
         ZSu9/3i7mPDfw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9c2a0725825so757149866b.2;
        Tue, 24 Oct 2023 18:56:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwX1fqYgYc1U7hEelZXtlzNLN+M5dS634xLWC63UZATk1xIvTg6
        ELRJxlKFPglst1qvzKjsQqBb9CFQgXppVM3UQAo=
X-Google-Smtp-Source: AGHT+IFS7k+iLv3jg6MtAyOtyKsAlec2Gf+Ao7RAz0P+99Tc54bsF+lUQZf3/VG0aVihpzZ4AeWaKexyxa4kzH4w3jc=
X-Received: by 2002:a17:907:934c:b0:9ae:64b4:18b3 with SMTP id
 bv12-20020a170907934c00b009ae64b418b3mr9805577ejc.37.1698198983263; Tue, 24
 Oct 2023 18:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
 <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
 <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
 <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
 <CAMpQs4Kug8dOWHD+nqAbGkmqkWU=y=k6+VwojETn8PEwf+MSPA@mail.gmail.com> <87wmvh5vyb.wl-maz@kernel.org>
In-Reply-To: <87wmvh5vyb.wl-maz@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 25 Oct 2023 09:56:10 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6g+eCj6B2S6HWhv-9AqWZkf9gaN-=TUmhHDe3Qx9_o+A@mail.gmail.com>
Message-ID: <CAAhV-H6g+eCj6B2S6HWhv-9AqWZkf9gaN-=TUmhHDe3Qx9_o+A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Marc Zyngier <maz@kernel.org>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi, Krzysztof,

On Fri, Oct 20, 2023 at 8:18=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 20 Oct 2023 10:51:35 +0100,
> Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >
> > Hi Krzysztof & Marc:
> >
> > Sorry for the interruption.
> > As said before, we tried to use the 'interrupt-map attribute' in our
> > Loongson liointc dts(i), but there are some unfriendly points.
> > Do you have any other different suggestions?
>
> I don't have any suggestion, but if you are still thinking of adding
> some extra crap to the of_irq_imap_abusers[] array, the answer is a
> firm 'NO'.
Excuse me, but as described before, 'interrupt-map' cannot be used for
liointc unless adding it to of_irq_imap_abusers[], can we still use
'parent_int_map' in this case? Or just change it to 'parent-int-map'
to satisfy the naming style?

Huacai

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
