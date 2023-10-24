Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78F7D44E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjJXBXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjJXBXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:23:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF4DF;
        Mon, 23 Oct 2023 18:23:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d087c4276so2611615a91.0;
        Mon, 23 Oct 2023 18:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110599; x=1698715399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYOndzIpuEL83u15EiH7sCgfXyoXizSioINfOe3jxuk=;
        b=bcgD6RVLbUJw9PSfewsfvUhdR69rErd4zQUZsYP3W/Py9dfLwm5EmNDREkQolOR1aO
         Eg30fb8Z1vTyCLzVq/rmOPZfOntWWn+gDs413nAfu5ToVPqUkrhW7DsPyRcwR7Lb8pMA
         nbjhDzmkmcy7FinO7MUPFE4U+SLKXAbgFP+uarvpar9gy0R7r9mbzft65onZkC5m81p/
         x2yX7ghtrUnFbltliDimUNPz5IKvaTA4n8iQRKt4Zzbj1Sctj196Bl+HojFxUjwloHEH
         ETdQrnWc3jkxdHs1HkWnVUNB+Tx5zf0zBseWcn0Rm9qHdSOrQnAKzCGkRTIr7qbtiFqV
         wuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110599; x=1698715399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYOndzIpuEL83u15EiH7sCgfXyoXizSioINfOe3jxuk=;
        b=fOGXq3E6foEYapRj8qKlod8z+Tg4WC1U+x38Qr0dmSeL6AmcxZX4vKHdfqj6GS+uUz
         27Fcr93M2hCrEP0O0DQug80bWPrkUnlBBz/5TYtZmDhtM34V/D+ZP6cIDKfhsjB0x8HY
         OrEcc85S8So8ohCz1+BDQD6DqtHSMwMr2slnAlQIvbInGp19kSjLygQylF+WGe4mUBiX
         14iZGNOyaw89rZXICIHrZ5r9bAn9pIcYyoZU4Oy7i4yXGTDeum8S4HOix9Dsw8URZbWJ
         4/p3iD7qmxLkvTwVnSWjlviScjjkZQaOyS6Ntsh4c/d3VV58k7nA/aIVENUua457f2Wh
         PNjA==
X-Gm-Message-State: AOJu0Yz9cBiZDI/9gwDZQpB4zEyyR0rIKGOkMlMR2qBspS/cfloV6cQr
        DmCBhog2LcFaXOaSISVYXWG5GkJJbJvcHsMW2GQ=
X-Google-Smtp-Source: AGHT+IFpIeTR5/sTyvIw57AfyLkT4AEfiRKMwhPVd2sb9kyvuliDvL+EB5nLG9797cHjZ5Vg1IbjvggeEOdZEcWEXJs=
X-Received: by 2002:a17:90b:1191:b0:27c:f1f8:261f with SMTP id
 gk17-20020a17090b119100b0027cf1f8261fmr7665444pjb.20.1698110598927; Mon, 23
 Oct 2023 18:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231022151911.4279-1-aford173@gmail.com> <97e1f76a-3505-4783-838a-10b9cacee8bd@intel.com>
In-Reply-To: <97e1f76a-3505-4783-838a-10b9cacee8bd@intel.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 23 Oct 2023 20:22:58 -0500
Message-ID: <CAHCN7x+ttO7yLkrc80issyjum_P1rcK9d5Keoyfxa-3krz8ssg@mail.gmail.com>
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org, aford@beaconembedded.com,
        Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 23, 2023 at 7:14=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 10/22/2023 8:19 AM, Adam Ford wrote:
> > Currently there is a device tree entry called "local-mac-address"
> > which can be filled by the bootloader or manually set.This is
> > useful when the user does not want to use the MAC address
> > programmed into the SoC.
> >
> > Currently, the davinci_emac reads the MAC from the DT, copies
> > it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> > it by reading from registers in the SoC, and falls back to a
> > random MAC if it's still not valid.  This completely ignores any
> > MAC address in the device tree.
> >
> > In order to use the local-mac-address, check to see if the contents
> > of priv->mac_addr are valid before falling back to reading from the
> > SoC when the MAC address is not valid.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > V2:  Rebase, add R-B tag, and post stand-alone for netdev branch, since
> >      the device tree patch has already been accepted via the omap tree.
>
> Looks like you didn't add the tag for which tree. Given the context, I
> would assume net-next.
>

That was my intent.  I sent the e-mail to netdev and CC'd others.  I
thought that was enough.


> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
