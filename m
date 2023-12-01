Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF50800D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379151AbjLAOUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379117AbjLAOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:20:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE29D10FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:20:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957E8C433CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701440422;
        bh=qOd9AM9K/gG8oPIzpKuiLuGmEfVIuPhFKWAIbD8tI10=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VcfdcRI3QTLGPQIOy4xmQ6cos8oVyI2Lc0xH6E1W/j7yVYx8UJ5WeRtwQIkbrZVAV
         vtaAaZn1UlfkbAQuNGCw/Zb7uzTbOlVyB4+7wYq7iWRxlMDG64sjj5ro953Ptx9uD+
         MinNjhUdkCZy64zF3M+ZG/h3PSX1RthkxEsDHwGiM0ui+6+Bv9LbjcwFTa+dAh0e2a
         WVj35dBuR3ayUo12OhNF4hdTHWQKL8OhMF30dKxLvN85rP9JjmfATk3rIfJus8C3o4
         OFGVvIoh/0YQsrQIO+i+0IMe21WuxUpbTCX/3pQVC3TsiAMWydHKdLWElZQHOfQc9g
         l22QX7wEy+zUg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50be08b8fd9so57173e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:20:22 -0800 (PST)
X-Gm-Message-State: AOJu0YzjfR/+Q11HcFdaVQYdg0tfxDIbUgGkRnUQRisAObn0wotVccDW
        RfMCXHmpGyh7jhpjR+kOZUR7EV4BPckLf2QQjg==
X-Google-Smtp-Source: AGHT+IHzMYOdBohT4Ipc4Fk6L+StttLAf5Y1Vb7CVCsmtwZZRtrZ3Dnhyln3menNCZsN1eyU0atQjt57Gdq80qKAsqM=
X-Received: by 2002:a05:6512:3b06:b0:50b:d764:967a with SMTP id
 f6-20020a0565123b0600b0050bd764967amr984497lfv.94.1701440420828; Fri, 01 Dec
 2023 06:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20231115210245.3744589-1-robh@kernel.org> <CANiq72=VGJDcK=tVkOFCnTumxDNE9YfiyAVocmD534mnAd_1CA@mail.gmail.com>
 <CAL_JsqLcqpGa=sc9niVK=-4LtVyr3jtUBcQJ2pNsafc3PQpj_g@mail.gmail.com> <CANiq72=_VtkEYLYZxz9uyAgFuL4-ZemUAmfWYZR3bcWaDSB=TQ@mail.gmail.com>
In-Reply-To: <CANiq72=_VtkEYLYZxz9uyAgFuL4-ZemUAmfWYZR3bcWaDSB=TQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Dec 2023 08:20:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKUVC7ORMRmpPLYqVYhEAb8eiPWWJkesy6K3OiHcL8Kdw@mail.gmail.com>
Message-ID: <CAL_JsqKUVC7ORMRmpPLYqVYhEAb8eiPWWJkesy6K3OiHcL8Kdw@mail.gmail.com>
Subject: Re: [RESEND PATCH] auxdisplay: img-ascii-lcd: Use device_get_match_data()
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 7:50=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 1, 2023 at 2:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > Can you fix that up while applying? This patch has only been ignored
> > for 2 months.
> >
> > I really only care about getting the includes right so I can apply this=
[1].
>
> Then I would recommend saying that in the patch itself.
>
> If you want to take it in your series to go faster, you can take my:
>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> If you want me to apply it, that is also fine and I can do so.

Please take it. There's other dependencies already, so I'll be sending
the final patch to Linus at the end of the merge window or after rc1.

Rob
