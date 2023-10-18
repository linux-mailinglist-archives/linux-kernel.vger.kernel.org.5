Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21E7CD208
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjJRBxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJRBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:53:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2AF7;
        Tue, 17 Oct 2023 18:53:14 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d84f18e908aso7166644276.1;
        Tue, 17 Oct 2023 18:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697593994; x=1698198794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmlrBpe9ja03gtHjG3w9pmjyrdRPZCOV3DdXdWIw+HI=;
        b=DYnFO0okE3vHgcUo7mhsRWiu8Sjvt9ZJNP6SOQLMhX65ZLiVW9cpOjiclhP1DY6HLi
         PoeTjScTytd0zTg76fMDaquno8tO9bMawDrAHFkl7+KKArEbLy/HWinNo8vpPI9y3mk/
         cUIjSpqnxhX4Wl4RRLHjSPoLyVaagyIJ74CWRlZYVKZ67aYIBo4bhSIqpGPeE0dyd5XG
         jCI9ZwIDuw9vPJFTdpRz4LLI/FQGHfLbp9BZVQtDdNeSCVLmxmGx/u+QjBZ/i+JLbhIk
         f1klFJgaxWBt3aWEHZ7yn1FK22/aPVMo7WPu7/eL8HAgun1zgGK/XXycygWi8hn/DLpn
         K+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697593994; x=1698198794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmlrBpe9ja03gtHjG3w9pmjyrdRPZCOV3DdXdWIw+HI=;
        b=ODOSH+PD+CAu8Z5jzdD03tfkjfzAGzF3Unx9zcaGggoROV3oIcgI8iF431tNnIF4WD
         zLiesmE1TYBqwAXDdM93BvhwQkOx+XCmKvUzJikcwdtU1IPyr88mNRV3WaawTEQkUe50
         EG0+JyCPzGFs9yiVzYoooYgaAo6hnMcZHmmlRN5NM1dTocO2UgS+SnFhht6v6CX9A6CW
         1Dtq6Wi6yVO/ITrge/3RH0J6tZX9rvzgVNrAQtiiyOTYWdufmKKvui/RbXdNd1uekcBj
         TEUpFgn6rqXoPDUb1qK8SXdfBkAu4od+21Tgs3OTyfS8QyWb6PJ1dCWs5eEC7BjmCe6Y
         w5eA==
X-Gm-Message-State: AOJu0YzV0twIDsG2hPV8zhHJn7i7LAOfRcUeWvXpYNduCdLQYau3n6jF
        xMfXjSvBpUr3Dpj/T21D9pANDsQe6lFAaWyXvEg=
X-Google-Smtp-Source: AGHT+IHsZJ7wGCRzt9Djq/g4QJsVfvZdmXlQJIIyKW6pnkW6E35wuoGTDrDDWXdZqnDJq3ZDx7ObAekxxiZAN55LiUc=
X-Received: by 2002:a25:df09:0:b0:d9a:c56f:a46e with SMTP id
 w9-20020a25df09000000b00d9ac56fa46emr4086505ybg.56.1697593993635; Tue, 17 Oct
 2023 18:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012060115.107183-1-hayatake396@gmail.com>
 <20231016152343.1fc7c7be@kernel.org> <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
 <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com> <20231017164915.23757eed@kernel.org>
In-Reply-To: <20231017164915.23757eed@kernel.org>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Wed, 18 Oct 2023 10:53:02 +0900
Message-ID: <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
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

Hi Jakub san

Thank you for your continued review!

> I may be wrong (this API predates my involvement in Linux by a decade)
> but I think that the current ethtool API is not all that precise in
> terms of exact packet headers.
>
> For example the TCPv6 flow includes IPv6 and TCP headers, but the
> packet may or may not have any number of encapsulation headers in place.
> VLAN, VXLAN, GENEVE etc. If the NIC can parse them - it will extract
> the inner-most IPv6 and TCP src/dst and hash on that.
>
> In a way TCP or IP headers may also differ by e.g. including options.
> But as long as the fields we care about (source / dst) are in place,
> we treat all variants of the header the same.
>
> The question really is how much we should extend this sort of thinking
> to GTP and say - we treat all GTP flows with extractable TEID the same;
> and how much the user can actually benefit from controlling particular
> sub-category of GTP flows. Or knowing that NIC supports a particular
> sub-category.
>
> Let's forget about capabilities of Intel NICs for now - can you as a
> user think of practical use cases where we'd want to turn on hashing
> based on TEID for, e.g. gtpu6 and not gtpc6?

of course!
There are clearly cases where we would want to use gtpu4|6 instead of gtpc4=
|6.

For instance, there are PGWs that have the capability to separate the
termination of communication of 4G LTE users into Control and User
planes (C/U).
This is quite convenient from a scalability perspective. In fact, in
5G UPF, the communication is explicitly only on the User plane
(Uplane).

Therefore, services are expected to receive only GTPU traffic (e.g.,
PGW-U, UPF) or only GTPC traffic (e.g., PGW-C). Hence, there arises a
necessity to use only GTPU.

If we do not distinguish packets into Control/User (C/U) with options
like gtp4|6, I can conceive scenarios where performance tuning becomes
challenging.
For example, in cases where we want to process only the control
communication (GTPC) using Flow Director on specific CPUs, while
processing GTPU on the remaining cores.
In scenarios like IoT, where user communication is minimal but the
volume of devices is vast, the control traffic could substantially
increase. Thus, this might also be possible in reverse.
In short, this pertains to being mindful of CPU core affinity.

If we were to propose again, setting aside considerations specific to
Intel, I believe, considering the users of ethtool, the smallest units
should be gtpu4|6 and gtpc4|6.
Regarding Extension Headers and such, I think it would be more
straightforward to handle them implicitly.

What does everyone else think?

2023=E5=B9=B410=E6=9C=8818=E6=97=A5(=E6=B0=B4) 8:49 Jakub Kicinski <kuba@ke=
rnel.org>:
>
> On Tue, 17 Oct 2023 23:37:57 +0900 takeru hayasaka wrote:
> > > Are there really deployments where the *very limited* GTP-C control
> > I also think that it should not be limited to GTP-C. However, as I
> > wrote in the email earlier, all the flows written are different in
> > packet structure, including GTP-C. In the semantics of ethtool, I
> > thought it was correct to pass a fixed packet structure and the
> > controllable parameters for it. At least, the Intel ice driver that I
> > modified is already like that.
>
> I may be wrong (this API predates my involvement in Linux by a decade)
> but I think that the current ethtool API is not all that precise in
> terms of exact packet headers.
>
> For example the TCPv6 flow includes IPv6 and TCP headers, but the
> packet may or may not have any number of encapsulation headers in place.
> VLAN, VXLAN, GENEVE etc. If the NIC can parse them - it will extract
> the inner-most IPv6 and TCP src/dst and hash on that.
>
> In a way TCP or IP headers may also differ by e.g. including options.
> But as long as the fields we care about (source / dst) are in place,
> we treat all variants of the header the same.
>
> The question really is how much we should extend this sort of thinking
> to GTP and say - we treat all GTP flows with extractable TEID the same;
> and how much the user can actually benefit from controlling particular
> sub-category of GTP flows. Or knowing that NIC supports a particular
> sub-category.
>
> Let's forget about capabilities of Intel NICs for now - can you as a
> user think of practical use cases where we'd want to turn on hashing
> based on TEID for, e.g. gtpu6 and not gtpc6?
