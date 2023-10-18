Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4B7CE29A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjJRQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJRQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:20:17 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC05FA;
        Wed, 18 Oct 2023 09:20:15 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac9573274so7814911276.0;
        Wed, 18 Oct 2023 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697646014; x=1698250814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L0ftx8gbLC+xr2pL7y3oGFwZgyV4cm0SgTFI25QzVw=;
        b=H4ctBjfJOApHb2K06YBns1vSiagRI9hzPNaXtuMUyiIF6/9pzVQb9iLw9+cQYMcTnI
         qj/C+WpqbrsJ7/9Lp2So+Edvk0zw84KFRUKTXtxIPyBGkV05g9+rP7sV8f0zyXZsYowg
         VR4ZWZCsa2Q+3MOt2+SyWl4JZEa8J+w0dXzbIMTNxFgvHyRmRcR3r7zlagiYWcnsbqvq
         fruMyhQ8OCfmqvd70X0L25BGjuvuV+EGPWM03B9QyaAXqWItYKKwD3VlnTTeM9DvhSc7
         z2rQ5/yR+7gNL3xgKjrWSv6QdakdL5CdhGsimnGOWD1HSsC+xr3hBUqUDYTVtssGMyr6
         jTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646014; x=1698250814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L0ftx8gbLC+xr2pL7y3oGFwZgyV4cm0SgTFI25QzVw=;
        b=ZoFSlaHH0kp0SrrgBsqfiVBXqQNghDcm4oEIm/DS4LYK0uTMVy151B7HS1wlzIX1iD
         wEpsVqyuGQzbc/DfmO9n2SfyVKbxvi/3REBLlyMzA2r/f6+qyWw/jPA8aCktTv3saOyc
         HOsB3FsQ5h2AoAtmJXzZJyUTiikb1whWJb5+nyomEGoFvrQXmr8PaZTKXj+uWFutl3A5
         1DbJK5GItMdbxBnXBPc846+jRpye5bLr3gvfYimsq1tWO3zXNaFqmL0pzlkzHdE44uT/
         bQWu8K6B/YgEWOhU4lTAYZgqHGPd38J397nNln9AZu/EkOYzUMFQI+mseXCtxUTFCKFr
         5TvQ==
X-Gm-Message-State: AOJu0YymAQ68YMhpwhVRPtDxWdBcN/ow8+6+75h6nz1ZXf8MuHXcVjAX
        LBhfQ2yjq9P6VkCN74GKHq5Cdj842B1G6DBeevU=
X-Google-Smtp-Source: AGHT+IFjjYZkrXWdeKcUaLTuaPe4tFQWuJ/yaL9u2gDs+qgC4Ebk83MvyMHkPAPd8vqIYG6js+mqy4mojHTsTM2SKMw=
X-Received: by 2002:a25:f56:0:b0:d9b:90bf:e74b with SMTP id
 83-20020a250f56000000b00d9b90bfe74bmr5775931ybp.7.1697646014247; Wed, 18 Oct
 2023 09:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org> <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
 <CADFiAcLvrpm+HGotr=UWiqyLGG-Bp1vf1E7bwKH_-MTCc84Jjw@mail.gmail.com> <ZS-WjVVaoBXqdZgB@nataraja>
In-Reply-To: <ZS-WjVVaoBXqdZgB@nataraja>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Thu, 19 Oct 2023 01:20:03 +0900
Message-ID: <CADFiAcJYEdieGA6gFme26KqZA1A7UhKqDaY-jVDz1QL+gUkXRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Harald Welte <laforge@gnumonks.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald-san and all.

Thank you for the review and comment!

> So only in case the user intentionally configures their network to use
> the same IP address for GTP-C and GTP-U traffic one will need to start
> distinguishing GTP-C and GTP-U on one host/NIC with the RSS mechanism:
> Steer the GTP-C traffic to the control plane instance on one CPU and
> spread the GTP-U traffic via hash function to multiple other
> queues/CPUs.  I personally think it's short-sighted to use identical IPs
> for control and user plane, as it means you can never scale out to
> multiple machines without introducing some kind of dedicated load
> balancer in front.  But assuming some people still want to do it that
> way: Yes, then you need the feature to split GTP-C form GTP-U via RSS to
> scale well.

I don't deny that using the same IP is short-sighted. However, in
environments such as Private 5G and Private LTE, it is possible that a
small mobile core OSS (e.g., NextEPC, Free5GC, etc.) is placed. Even
if the addresses are separated, processing on the same computer
instance is a possible scenario, so there are practical use cases.

> agreed.  Though I'm not entirely sure one would usually want to treat v4
> different from v6.  I'd assume they would usually both follow the same
> RSS scheme?

Indeed, you might want them to be treated in the same way.
But this follows the existing design of Ethtool.
In fact, formats like tcp4, tcp6, etc... with the L3 version appended,
are given, and the existing implementation of Ethtool is described in
the format of IPv4|6 + L4. I don=E2=80=99t know why the existing
implementation is divided into IPv4 and v6.

> Don't worry, you were very clear in this e-mail.

Thank you for your kind comment :)

> Thanks for taking the time.  As stated, I think it would be best to have
> these or some other some brief comments about the different flow types
> in the source code (and especially the documentation) of ethtool.

Understood. I=E2=80=99m thinking of writing a definition in the Ethtool hea=
der
about this flow in the next version of the patch :)

> Based on your explanation, I agree that indeed those are all different
> flow types that occur in real-life on PGW/UPF and other 3GPP network
> elements/functions.  I can also very well imagine that there are use
> cases to steer all of those separately, including the EH and UL/DL types
> you mentioned.

Thanks. I'm glad you understood. I appreciate your review and comments.

I've been able to organize various comments and I think you've
understood what is operated by the patch I sent.

Now, here, I=E2=80=99d like to propose two policies for the next version of=
 the patch.

1. Keep this patch as is and write the necessary supplementary
comments (of course, nits fix will be done).
The good thing about this is that it can handle detailed use cases (as
Harald-san understood)

There might be something more pleasant than expected use cases. The
bad thing is the multitude of flow formats. Considering 6G, it may
increase a bit more.

2.Limit the rx-flow-hash flow type to gtpu4|6 and gtpc4|6, and rewrite
to implicitly execute the previous function.
we will add comments (There will be fewer comments than plan 1).

In other words, in Intel Ice, the proposal has the following semantics.
gtpu4|6: GTPU_V(4|6)_FLOW + GTPU_EH_V(4|6)_FLOW
gtpc4|6: GTPC_V(4|6)_FLOW + GTPC_TEID_V(4|6)_FLOW

The good thing is that it seems easy for users to use, and the format
of the GTP-related flow is less likely to increase or decrease in the
future.
The bad thing is that it may not be able to handle detailed use cases.

Please let me know which one, 1 or 2, you prefer.
Also, I would be happy if there is any further feedback!

Thanks

2023=E5=B9=B410=E6=9C=8818=E6=97=A5(=E6=B0=B4) 17:26 Harald Welte <laforge@=
gnumonks.org>:
>
> Hi Takeru,
>
> On Wed, Oct 18, 2023 at 01:49:08AM +0900, takeru hayasaka wrote:
> > I'm not very proficient in English, so I'm worried whether I can
> > explain it well.
>
> Don't worry, you were very clear in this e-mail.
>
> > Therefore, I will try to briefly explain the flow and what kind of
> > cases these are in a straightforward manner.
>
> Thanks for taking the time.  As stated, I think it would be best to have
> these or some other some brief comments about the different flow types
> in the source code (and especially the documentation) of ethtool.
>
> Based on your explanation, I agree that indeed those are all different
> flow types that occur in real-life on PGW/UPF and other 3GPP network
> elements/functions.  I can also very well imagine that there are use
> cases to steer all of those separately, including the EH and UL/DL types
> you mentioned.
>
> So I'm supporing your patch with all its many different flow types for RS=
S.
>
> Thanks,
>         Harald
> --
> - Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.o=
rg/
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> "Privacy in residential applications is a desirable marketing option."
>                                                   (ETSI EN 300 175-7 Ch. =
A6)
