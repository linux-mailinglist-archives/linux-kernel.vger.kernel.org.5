Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC5B7DB6D8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjJ3J5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjJ3J5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:57:24 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C515125;
        Mon, 30 Oct 2023 02:56:35 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so3574900276.0;
        Mon, 30 Oct 2023 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698659794; x=1699264594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvScWoVnKDPSWV1dAHWMOmr+PITzURyuLxHTYAjlzQE=;
        b=dR1oVR/QbCDNx9WboS8oQRipd+F9ueSunFwiJ2TBZcSrMMMQE3C4P3kF2Xt2YyS2hJ
         83HqX0Xyx6OYco0+0wlJN+gmm5T/hXCtxAHy83NHieHZ/xwpqOlE5azui/Uc/BcP1bul
         TWvn34ySnmDlqJl4Ebnh7JI1PGKP7dUI00gXdZNbyyhf/pgL9sO/Pptr5SMaxgPDNVXP
         k93D6Vvst/qKZHTRYJXv0rXmCeOLqfNvOG80EesL/Fv0ctyx33eTg7fW7lXG8T5XFtGE
         U+1UhNYzhn48Lb4VDqAmS529JZNo7Vqpqkspq2gmqvPZ9rRqVtqdQ+rZbVw3xHX+k4gr
         hq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659794; x=1699264594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvScWoVnKDPSWV1dAHWMOmr+PITzURyuLxHTYAjlzQE=;
        b=CHDBI/q0jah4Lbg5xB/pcZvqKRTWKqYA6FW5TKbKZGcxQKgMW+A2gRd42pIEXbqaVO
         NpASvzilEP4vN6oJLOl5Mkq+NFrmX0kxE+ANl1Ik8qDYNyV1ZMlu3po0sTWd1IsO43vj
         VvhRL4gy219xK2trCUKPKRKi4g56vcTaogPxWFOhj+jzHJx7nyYFoJOYHkVkCdDHId/q
         O+CM2voVrs/pPFOL9qqO7x9Xj6aLk2PrS1HA36webSrTuKmjdYFKRSMOBaxkxjgbvbnf
         6udnoFg2l2Cms6s5MCMAuKF/FIF7zCaRmzQpf9QcP6gk6enrqrrBTeZ0jStA35xtXpn1
         TBXQ==
X-Gm-Message-State: AOJu0YzYZS5QVPq1a4nV0vWVAiDz5W115vUx4OWcQdjK5TE9YdZ55iBK
        EnPWW0T/6wJtOuxNNTU1HjYkMyGOOQb3YBNCWQUO46VSOamTPPFV
X-Google-Smtp-Source: AGHT+IHq5pz2chz0pt4KB1IUqwD7/2/MTBAcZ0f8iyTiARw7tee0RdVTzu4zUsY3maFk1njO4qjJv/01rg6CYJnDSg8=
X-Received: by 2002:a25:8747:0:b0:d9c:aa29:6180 with SMTP id
 e7-20020a258747000000b00d9caa296180mr6344305ybn.46.1698659794572; Mon, 30 Oct
 2023 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
 <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
 <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
 <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
 <CAMpQs4Kug8dOWHD+nqAbGkmqkWU=y=k6+VwojETn8PEwf+MSPA@mail.gmail.com>
 <87wmvh5vyb.wl-maz@kernel.org> <CAAhV-H6g+eCj6B2S6HWhv-9AqWZkf9gaN-=TUmhHDe3Qx9_o+A@mail.gmail.com>
 <d0ab3e30-0b19-4a96-8fd5-c6937af1658f@linaro.org> <CAAhV-H7Kwb9xT8R0TTbqEhrLUEcnxkTcEy=RhAxD3basBvWxKA@mail.gmail.com>
 <34c33fc5-7b54-4f5e-8af8-2dce062a7968@linaro.org>
In-Reply-To: <34c33fc5-7b54-4f5e-8af8-2dce062a7968@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Mon, 30 Oct 2023 15:56:18 +0600
Message-ID: <CAMpQs4JUZzUk=ZucC3aE7+tZB35_FSu-kioU_HR1AatssAqaLA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 1:42=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/10/2023 09:19, Huacai Chen wrote:
> > Hi, Krzysztof
> >
> > On Wed, Oct 25, 2023 at 3:16=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 25/10/2023 03:56, Huacai Chen wrote:
> >>> Hi, Krzysztof,
> >>>
> >>> On Fri, Oct 20, 2023 at 8:18=E2=80=AFPM Marc Zyngier <maz@kernel.org>=
 wrote:
> >>>>
> >>>> On Fri, 20 Oct 2023 10:51:35 +0100,
> >>>> Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >>>>>
> >>>>> Hi Krzysztof & Marc:
> >>>>>
> >>>>> Sorry for the interruption.
> >>>>> As said before, we tried to use the 'interrupt-map attribute' in ou=
r
> >>>>> Loongson liointc dts(i), but there are some unfriendly points.
> >>>>> Do you have any other different suggestions?
> >>>>
> >>>> I don't have any suggestion, but if you are still thinking of adding
> >>>> some extra crap to the of_irq_imap_abusers[] array, the answer is a
> >>>> firm 'NO'.
> >>> Excuse me, but as described before, 'interrupt-map' cannot be used fo=
r
> >>> liointc unless adding it to of_irq_imap_abusers[], can we still use
> >>> 'parent_int_map' in this case? Or just change it to 'parent-int-map'
> >>> to satisfy the naming style?
> >>
> >> Why do you respond to me? You received firm 'NO' about
> >> of_irq_imap_abusers, so how adhering to naming style or violating nami=
ng
> >> style has anything to do with it?
> > I'm sorry but of_irq_imap_abusers is to make 'interrupt-map' to work,
> > without of_irq_imap_abusers we can only use the existing
> > 'parent_int_map'. We need your response because we want to know
> > whether you can accept the existing method since the other approach
> > has received 'NO'. And, changing 'parent_int_map' to 'parent-int-map'
> > can be a little better, at least it satisfies the naming style.
>
> Indeed, interrupt-map might not fit here. I don't know whether your
> custom property - purely for runtime performance purpose - will be
> accepted. Initial description of this field suggested that it is OS
> policy, not hardware choice. But sure, propose something with
> justification, so we can review it. The proposal must not break ABI, so
> you must support both parent_int_map and parent-int-map (or whatever we
> call it) properties. The first we will probably deprecate.
>
Hi Krzysztof:

Thanks a lot for your reply and suggestion!
I'll try to split the change points into separate patches in the next
version, it might be better understood.

Thanks.
Binbin

> The way this property was sneaked into kernel bypassing review is still
> disappointing.
>
> Best regards,
> Krzysztof
>
