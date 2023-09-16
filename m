Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE77A2E08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 07:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbjIPFSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 01:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjIPFSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 01:18:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9701BCA;
        Fri, 15 Sep 2023 22:18:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2745cd2ba68so2323042a91.0;
        Fri, 15 Sep 2023 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694841493; x=1695446293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qdYiZ8LF0tnKSZBA/euKOT4dE27FmTPvneuvwGAtB4=;
        b=k7Zl+NS0nW91td44ZPci9WfG0wc8x70mOEIEPeBAcEtIWdTB6PLysFXv9hnOh77wYp
         i0a+tSeX1yfcryElX5orRWtphblRx4S6d947rTG9fGw3Cg+UMbaG+GtWS+WuXmPA08G0
         FRb49Yt+4Bv2rC7u+hmE7lC1EwoA26sRsTdtgOhPToGfdTdK0cgN3UhThlL+lejtpB30
         SOSQ1D+QyldBTEWZf45vlWTiYEg9u+3irmS3wf/HwS91STUq5hBHaqKL6vX4jHpaAroQ
         Tcfv1EHuivpI6/jkmhTrO1DEhUGfW1JXQHbMoKUWnyzqTb/jrmUM1lQRX0o9WpetYPpd
         XlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694841493; x=1695446293;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1qdYiZ8LF0tnKSZBA/euKOT4dE27FmTPvneuvwGAtB4=;
        b=VD4f+Tmx2IAneeS3JnGEOIeEc1OtOvn++cD4ci1LoWMHfUH8/bG8oEnNE+eiKxw5tC
         ZGkqJiWwqc2s0dbDwOhLBYqEcAj1tGHUNlyKmgIiEkV6s+VnBcCVnG7xO+mAX5D1QBXR
         duQel+Nz0xoYZuslOP4DCzSjBZq6Mi56X6Zef0MbDwUBFvVciEZmXMQ1XcB5FJ8SE1TS
         2I+TFR8Q67nuT1YvxESzAXNXtoUWpZXOAinP00g4risbslAhNmTv2IGrSGYDFIHycYyp
         ZE73RwvWDEcjNISsP2paqTIijwPKR1RjDqksncoaVoBW9JixexW5PSJPwLO7Bwa1Y7MK
         Tg9A==
X-Gm-Message-State: AOJu0YyoDTz9pbeOIQT6CtCOusmw37ESsF/TnhO84a6R0UZL0KqDpUAM
        auy66dj8s8i5sPS4Clv6K20=
X-Google-Smtp-Source: AGHT+IHdVfenN52p2XAOd1T6Tm4wVogq0iXsaKupgPDHdMKw528Otc/dSSu/9b9aAGUZo4iSklnRww==
X-Received: by 2002:a17:90b:4d83:b0:274:5638:2a03 with SMTP id oj3-20020a17090b4d8300b0027456382a03mr3239453pjb.20.1694841493383;
        Fri, 15 Sep 2023 22:18:13 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:c4b6:ed28:95c7:9a77:34ba? ([2401:4900:1c60:c4b6:ed28:95c7:9a77:34ba])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a438100b0027480345180sm3451992pjg.2.2023.09.15.22.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 22:18:12 -0700 (PDT)
Message-ID: <916720db-0d36-2587-9b91-69ec6f70d64c@gmail.com>
Date:   Sat, 16 Sep 2023 10:48:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.linux@gmail.com
To:     Georgi Djakov <djakov@kernel.org>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, vkoul@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update Bhupesh's email address
References: <20230915191600.3410862-1-bhupesh.linux@gmail.com>
 <facce62d-07cd-4899-866b-c9d7eebe38a8@kernel.org>
In-Reply-To: <facce62d-07cd-4899-866b-c9d7eebe38a8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/16/23 2:07 AM, Georgi Djakov <djakov@kernel.org> wrote:
> Hi Bhupesh,
> 
> On 15.09.23 22:16, Bhupesh Sharma wrote:
> > Update the email address for Bhupesh's maintainer entry and fill in
> > .mailmap accordingly.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.linux@gmail.com>
> > ---
> >   .mailmap    | 5 +++++
> >   MAINTAINERS | 2 +-
> >   2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/.mailmap b/.mailmap
> > index a0a6efe87186..a69dfc6bbf1f 100644
> > --- a/.mailmap
> > +++ b/.mailmap
> > @@ -94,6 +94,11 @@ Ben M Cahill <ben.m.cahill@intel.com>
> >   Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
> >   Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
> >   Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
> > +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
> > +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhsharma@redhat.com>
> > +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@freescale.com>
> > +Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@st.com>
> > +Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
> 
> This line looks like an unintentional change?

Oops. Indeed. Let me fix this in v2.

Regards,
Bhupesh

> >   Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
> >   Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
> >   Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fa7487b7729b..620301a2b5ef 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17740,7 +17740,7 @@ F:    drivers/net/ethernet/qualcomm/emac/
> >   QUALCOMM ETHQOS ETHERNET DRIVER
> >   M:    Vinod Koul <vkoul@kernel.org>
> > -R:    Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > +R:    Bhupesh Sharma <bhupesh.linux@gmail.com>
> >   L:    netdev@vger.kernel.org
> >   L:    linux-arm-msm@vger.kernel.org
> >   S:    Maintained
> 
> 
