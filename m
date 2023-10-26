Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760F67D7D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344194AbjJZHUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjJZHUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:20:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A943BD6;
        Thu, 26 Oct 2023 00:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B6BC4339A;
        Thu, 26 Oct 2023 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698304801;
        bh=TvTp0447ZplZUvjpNNEtL7P0KEDlEmQ4vFTRpwMCq7E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OVtwtnFD3bkam1hwkFWNt9rBPuuo03309zyBnAiQ/MEXqEru8YdWma6MS9qqGGToj
         oaK3/zvVbGGwM4TeaDFItEPC8uzfYz237OkrffjcnkEFk8ZBVmFjxcHyN2bIcFFRrq
         mGuWXczF3vd8bHfgq8KwC3uog6noofqzsollKNTdxm9NSn4m3xzxNaOTg1Ol4w+sRJ
         I4q04Rg6FG4325AYQsK1tcORcNYngAawnsqvx0f4LUubRUCHoHbaAUpAsbbfSNdTvi
         xQI5Drxg1UuwpOM4zyxMurEFOHrviJRw0EtiMVanxdHkj0qBMTv0XsRSBUL5NucVld
         j424bHOzBXyZA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9b6559cbd74so91586166b.1;
        Thu, 26 Oct 2023 00:20:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwCCfCTJt4ceUPCYY7PO6nOkQC6JYjTkfVVN2mzpeKTXRczRHz
        x6jof1coOYF/9xpSRd4KuDOuxWhpHyy/aMj1IC0=
X-Google-Smtp-Source: AGHT+IFC/a1Rtd/otXn8tvqvVomIZqj6pJc3oTD3YEarm4qKfL/tXONfms+N5lELqrKUWV9OBvAeq6ICalt/C0w+tjk=
X-Received: by 2002:a17:907:1b0c:b0:9b2:955a:e375 with SMTP id
 mp12-20020a1709071b0c00b009b2955ae375mr16658761ejc.23.1698304799579; Thu, 26
 Oct 2023 00:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
 <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
 <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
 <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
 <CAMpQs4Kug8dOWHD+nqAbGkmqkWU=y=k6+VwojETn8PEwf+MSPA@mail.gmail.com>
 <87wmvh5vyb.wl-maz@kernel.org> <CAAhV-H6g+eCj6B2S6HWhv-9AqWZkf9gaN-=TUmhHDe3Qx9_o+A@mail.gmail.com>
 <d0ab3e30-0b19-4a96-8fd5-c6937af1658f@linaro.org>
In-Reply-To: <d0ab3e30-0b19-4a96-8fd5-c6937af1658f@linaro.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 26 Oct 2023 15:19:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Kwb9xT8R0TTbqEhrLUEcnxkTcEy=RhAxD3basBvWxKA@mail.gmail.com>
Message-ID: <CAAhV-H7Kwb9xT8R0TTbqEhrLUEcnxkTcEy=RhAxD3basBvWxKA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof

On Wed, Oct 25, 2023 at 3:16=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/10/2023 03:56, Huacai Chen wrote:
> > Hi, Krzysztof,
> >
> > On Fri, Oct 20, 2023 at 8:18=E2=80=AFPM Marc Zyngier <maz@kernel.org> w=
rote:
> >>
> >> On Fri, 20 Oct 2023 10:51:35 +0100,
> >> Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >>>
> >>> Hi Krzysztof & Marc:
> >>>
> >>> Sorry for the interruption.
> >>> As said before, we tried to use the 'interrupt-map attribute' in our
> >>> Loongson liointc dts(i), but there are some unfriendly points.
> >>> Do you have any other different suggestions?
> >>
> >> I don't have any suggestion, but if you are still thinking of adding
> >> some extra crap to the of_irq_imap_abusers[] array, the answer is a
> >> firm 'NO'.
> > Excuse me, but as described before, 'interrupt-map' cannot be used for
> > liointc unless adding it to of_irq_imap_abusers[], can we still use
> > 'parent_int_map' in this case? Or just change it to 'parent-int-map'
> > to satisfy the naming style?
>
> Why do you respond to me? You received firm 'NO' about
> of_irq_imap_abusers, so how adhering to naming style or violating naming
> style has anything to do with it?
I'm sorry but of_irq_imap_abusers is to make 'interrupt-map' to work,
without of_irq_imap_abusers we can only use the existing
'parent_int_map'. We need your response because we want to know
whether you can accept the existing method since the other approach
has received 'NO'. And, changing 'parent_int_map' to 'parent-int-map'
can be a little better, at least it satisfies the naming style.

Huacai
>
> Best regards,
> Krzysztof
>
