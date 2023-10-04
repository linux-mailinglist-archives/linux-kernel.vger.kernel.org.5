Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD6D7B81AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242766AbjJDOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbjJDOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:04:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E32A1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:04:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-533d9925094so3818414a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696428272; x=1697033072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih3CfAMz92qznR9krJdX9z6vkwyBn8t8x+cmpetFh0c=;
        b=dLytbwgM52DZKBegKBt34M93sndiSKahBPIcqjBr4gWDnSMixrLSCf8VMulGL0meJ8
         wM+dYJ6aATwJxiPVc+MTpI45kX0o1LOk4A6x/kf4XhYtdfmprmjvUUYaM6MW94v7wqX8
         Zr8H5W1S6sBDcmx0+Z5w62iDY0cHJQAuazFUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696428272; x=1697033072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih3CfAMz92qznR9krJdX9z6vkwyBn8t8x+cmpetFh0c=;
        b=M/Vod8g264xXsF9Ie9EQgR59rZNmWTqP6os1W2arAsQ4poy5rpQnoyfF5uMUIyDXZz
         8AQujyK4M020ya7OZ2qnlSFBi2Flbm8cOdlTGBtEEAl0RCImQIYIl4mHq/IWOuIcdp4v
         sXA0ZOEMmU0+tlPj+maQTGfWArN+/43VBTPrcPNmy26EzG5IFCamVr0foTTGJ9IGmkdT
         8/EDLi67DkcJUTeUvQL31QxajzgR4nOqjhbReQ//fwtL3Jd5WcQ4pwWudn8hG7KUdMVM
         a2qABsRkC6sgdfa6a0COCa9d94ryr5N+0a08F8TgLJyAu3/X+j+gaqRDLCQMkKAzefT6
         FqOw==
X-Gm-Message-State: AOJu0Yy5cJX3f+Oww/yI9fod9wdOEBarR+OawsbUSQqfd0eBlFwilIRP
        dd5OdRm52uvt6Qfdo3vWyscM30M5YzZwO8LLo6ykn7gs
X-Google-Smtp-Source: AGHT+IGMr1Z/gnWuemi2C/K8Qa6hUsQs+11jLdyw6viQKCO5P/c6IkkrLyLTVZmpByJ29CiYsaK0CQ==
X-Received: by 2002:a05:6402:160b:b0:530:bad5:248e with SMTP id f11-20020a056402160b00b00530bad5248emr2265155edv.3.1696428268936;
        Wed, 04 Oct 2023 07:04:28 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id x15-20020aa7dacf000000b005224f840130sm2483503eds.60.2023.10.04.07.04.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 07:04:28 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-405459d9a96so88965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:04:27 -0700 (PDT)
X-Received: by 2002:a05:600c:438a:b0:400:46db:1bf2 with SMTP id
 e10-20020a05600c438a00b0040046db1bf2mr101611wmn.2.1696428267648; Wed, 04 Oct
 2023 07:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231002094526.1.Ie8f760213053e3d11592f892b30912dbac6b8b48@changeid>
 <ZRr8r7XMoyDKaitd@FVFF77S0Q05N.cambridge.arm.com> <CAD=FV=UeeL9uycVeKpOm+eDm3xHrOnKi2frt6a1qFG1HX9yEUg@mail.gmail.com>
 <ZRwJKBZaYwF1rrur@FVFF77S0Q05N> <CAD=FV=WASz1uvTgwsu3H3cTr3smHk+E_XNUVnjoPpttwv095rQ@mail.gmail.com>
 <ZRxCCZxZWCG0NBur@FVFF77S0Q05N> <CAD=FV=Xk-OMKQPXxU9Z9HOcWwUxxrmLZ4vD0u5ouZRW_zDFDPg@mail.gmail.com>
 <ZR03liCodnTQWs7s@FVFF77S0Q05N> <86jzs2ofqs.wl-maz@kernel.org>
In-Reply-To: <86jzs2ofqs.wl-maz@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Oct 2023 07:04:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XasZR6dhKBjpbYfby4F1Nu_bsq1m_HP+NpufjsJi0COg@mail.gmail.com>
Message-ID: <CAD=FV=XasZR6dhKBjpbYfby4F1Nu_bsq1m_HP+NpufjsJi0COg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: smp: Fix pseudo NMI issues w/ broken Mediatek FW
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 4, 2023 at 3:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 04 Oct 2023 10:59:50 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Given you haven't seen any issues, I suspect those are getting reset to=
 fixed
> > values that happens to work out for us, but it is a bit worrisome more
> > generally (e.g. the LPI case above).
>
> It is likely that these SoCs don't even have an ITS.

Right. That was what we decided [1] when Marc pointed this out earlier.

Overall: we know that this firmware behavior is not good but we're
stuck with it. :( At the very least, any new devices coming out will
have this fixed. Presumably if old devices are working OK enough today
(as long as you don't enable pseudo-NMI) then they can be made to keep
working?

So circling back: what patch should we actually land? As of right now
only pseudo-NMI is broken, but it would be good to make sure that if
the kernel later adds other features that would be broken on this
hardware that it gets handled properly...

[1] https://issuetracker.google.com/issues/281831288#comment4
