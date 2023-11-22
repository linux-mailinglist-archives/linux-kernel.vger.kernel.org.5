Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAE7F3E64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:52:56 -0500
Received: from mail-108-mta152.mxroute.com (mail-108-mta152.mxroute.com [136.175.108.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F881AA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:52:50 -0800 (PST)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta152.mxroute.com (ZoneMTA) with ESMTPSA id 18bf5cd7b19000190b.002
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 22 Nov 2023 06:52:46 +0000
X-Zone-Loop: 2f166679aaef94e8dcc9a33d71af4f0b95f18c5e77ce
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kelvie.ca;
        s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:
        From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QfrsEiNiDvgOHqYQ6HeW1TuewuwattdZa/64hKuNSYg=; b=g59WxPJOvbYMAlOnH2lNEavL0L
        rpgqZLJChp9ZYW1rFpk4PqPO9oawZKbvlWr2xwILPTUy0OTM1cmc6/IkKCQO697UI8PwZafyo3EQ7
        3x65ulcIxBc3lw2xGaPs3JE4V7QjAdhj0tM4ayaX/TbW2pupDYb7zkJA9yQw7wCGuE/zxf9QLep//
        3tyuJnfCDeJLGZc3WZT5P012jD3AN6rjrmzOvARSfx8+oJWJi3dDCdS2zXR2B3ofn8AX+oYJlyjN+
        UimljwkyfYHWRcLbjzyffWBOSSbYsSqWr8UAG+s5urfdIzoFebDLHbHD/wd5+xNyk/EAq8tbiSlyp
        uEa1biNA==;
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so6066129b3a.1;
        Tue, 21 Nov 2023 22:52:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwDOptQtwhilgpDMqURbQrKviT2ESo3HiHwEU9GIece9wdR1NWT
        ke18NJ+t9jOf4euByBrRc4KZCvb5DSDOcnEOQqg=
X-Google-Smtp-Source: AGHT+IG+koEkX5ZF3q/yCEz5nlwSSt/P6D1AYVNMSttJf3wGncmvkqPTRcwXVi3Fx4veG0d9n3GznYuniitZ7alXzQg=
X-Received: by 2002:a05:6a20:2694:b0:18b:f77:7bbc with SMTP id
 h20-20020a056a20269400b0018b0f777bbcmr1006135pze.62.1700635964093; Tue, 21
 Nov 2023 22:52:44 -0800 (PST)
MIME-Version: 1.0
References: <20231114022503.6310-1-kelvie@kelvie.ca> <a66a805c-3e1f-4b9a-a38e-aca84b8678a6@infradead.org>
 <CAHC9VhR6mr0XRrq=Apy00HD3tdgpKi4RyMr8f5kdx2sjA0sfig@mail.gmail.com>
 <CAK2bC5rN_P7WP_E57wJjz+7icVjrwS0e6fqg_5uNaPhy3YR2dQ@mail.gmail.com> <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQeQcEKFKWi2pvGE-DhkaccqBn9Yf_+r7JbZ2UPN+z3-g@mail.gmail.com>
From:   Kelvie Wong <kelvie@kelvie.ca>
Date:   Tue, 21 Nov 2023 22:52:32 -0800
X-Gmail-Original-Message-ID: <CAK2bC5p94wfyzixC_bg5PMAJjM5J0vyBVt1ChN6vz53+_HRRwQ@mail.gmail.com>
Message-ID: <CAK2bC5p94wfyzixC_bg5PMAJjM5J0vyBVt1ChN6vz53+_HRRwQ@mail.gmail.com>
Subject: Re: [PATCH RFC] Add a lockdown_hibernate parameter
To:     Paul Moore <paul@paul-moore.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: kelvie@kelvie.ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 at 20:53, Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 20, 2023 at 10:07=E2=80=AFPM Kelvie Wong <kelvie@kelvie.ca> w=
rote:
> > On Mon, 20 Nov 2023 at 13:12, Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Nov 13, 2023 at 11:01=E2=80=AFPM Randy Dunlap <rdunlap@infrad=
ead.org> wrote:
> > > >
> > > > [add security & dhowells]
> > > >
> > > > On 11/13/23 18:23, Kelvie Wong wrote:
> > > > > This allows the user to tell the kernel that they know better (na=
mely,
> > > > > they secured their swap properly), and that it can enable hiberna=
tion.
> > > > >
> > > > > I've been using this for about a year now, as it doesn't seem lik=
e
> > > > > proper secure hibernation was going to be implemented back then, =
and
> > > > > it's now been a year since I've been building my own kernels with=
 this
> > > > > patch, so getting this upstreamed would save some CO2 from me bui=
lding
> > > > > my own kernels every upgrade.
> > > > >
> > > > > Some other not-me users have also tested the patch:
> > > > >
> > > > > https://community.frame.work/t/guide-fedora-36-hibernation-with-e=
nabled-secure-boot-and-full-disk-encryption-fde-decrypting-over-tpm2/25474/=
17
> > > > >
> > > > > Signed-off-by: Kelvie Wong <kelvie@kelvie.ca>
> > >
> > > I would feel a lot better about this if there was a way to verify tha=
t
> > > the swap was protected as opposed to leaving that as a note in a doc
> > > that the majority of users will never see, read, or understand.
> >
> I've got to warn you that I have an allergic reaction to arguments
> that start with "the right solution is really hard, so let's pick the
> easier, worse solution." ;)
>
> I guess I'm still not sold on this idea, I'm sorry.

Not a problem, thanks for looking.

I do hope that hibernate on lockdown is one day properly supported though. =
I'd
imagine that lockdown will eventually be the default for most distros, and =
it'd
be a real shame to have to sacrifice hibernate for it (which is, in my opin=
ion,
indispensable for laptop use).


Cheers,
--=20
Kelvie
