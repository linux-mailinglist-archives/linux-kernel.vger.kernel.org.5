Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71087FCA77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjK1XGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1XGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:06:01 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D51182
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:06:07 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2ea3a944so3955363a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701212767; x=1701817567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlezK+L0MEYj7NA+OEHtCLMWF8WHQ+LQUZwspbuoAgg=;
        b=F/f3XSlGv/Ca0KM7IdFyg3+Z6uN0ZCfTFvPdgVchHxy/mR6lQn90ivZXQHWa2/k2Yh
         jJPBwss1O71yAv+KOBLuhs9iyIm+xFDYjDeOZhluExwICdcqIZiB3mlweMhRzKgf4LwL
         sum4QDHUgZ864Q0dNiMvqT72umnpv1aG5nfrZ/Y08gkHmZaiHDZji4sdeu+cg1vHTzH/
         I0EzMqZZ+gbykH9vOM1yQzF9rPVxtwTTVPf38hGIP/v1i0EGYx4XIfla7A/UjGPiSP0M
         ySo6ztzOC5a5a4nJ6xNhcph61pW88bUeOFXdjT3lYtXcKb1W1MRXpMPH4B5SGf49Zv0Y
         Mo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212767; x=1701817567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlezK+L0MEYj7NA+OEHtCLMWF8WHQ+LQUZwspbuoAgg=;
        b=okB7uAzbXB4cgYb0CNbtlspWM8DiCP12yyPclghZjIu/tFj4oyhmi2eCeUxeEB7qBt
         6IH/Me8uawbFVemiGv7vA8a4AmxmMN4B1H1CYMoZFS4BUIKZ70uLekuE1iARA1gswRx6
         VSUZRMiwVPR7loc56ZKLP57Se2sMocelqba+m+Xi38LmuHjMxA91Uk1m2VaI+WXSvmcr
         h5ss8IqCtQmDJmYo+b74T8fYLf875VDC7D+ztP2hSOQLt0W9bnP4P9AmXSO0juXXIcM9
         23jvPe7T8ty3ld1ml8KfVnTnU4Egpq0KhHFBXBVy79+wI1/IX0FivdAMhVpfTZJR99oD
         3yvg==
X-Gm-Message-State: AOJu0YxpiBS4bSkH4AGbrP3PLi/hPX+4bG/fz3+AOZLST4gNDGlNOuq/
        dYw6Jo7PvN171w7oV1vrCBLBxoljWWrnl4/Qir99cA==
X-Google-Smtp-Source: AGHT+IFXDuUhIgrRcx7y1YTd1r6TBsPGIELClRxhPpcmvFBhJRWHsxyoP4eQdSQZ0KPqaaRkowPDkiFhC0wSu6NGjKc=
X-Received: by 2002:a05:6358:2612:b0:16e:147:f018 with SMTP id
 l18-20020a056358261200b0016e0147f018mr18277338rwc.28.1701212766950; Tue, 28
 Nov 2023 15:06:06 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWRdG49vlGzSY_Uj@tiehlicka> <87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWW95JPQ1B0cVPY-@tiehlicka> <ZWZtdQKSSnLC8kZ6@google.com>
In-Reply-To: <ZWZtdQKSSnLC8kZ6@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Nov 2023 15:05:29 -0800
Message-ID: <CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 2:45=E2=80=AFPM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Tue, Nov 28, 2023 at 11:16:04AM +0100, Michal Hocko wrote:
> > On Tue 28-11-23 09:31:06, Huang, Ying wrote:
> > > Michal Hocko <mhocko@suse.com> writes:
> > [...]
> > > > Right. On the other hand we could be more aggressive when dropping =
the
> > > > swapcache. Is there any actual reason why we cannot try to folio_fr=
ee_swap
> > > > even when mem_cgroup_swap_full =3D=3D F?
> > >
> > > If there are plenty free space in swap device, why not take advantage=
 of
> > > it?
> >
> > Maybe a stupid question but what is the advantage of keeping around in
> > the swap cache?
>
> If the page is shared, we avoids addtional IO to bring them back so
> swap cache.

I think this case is actually necessary for correctness, not just to
avoid additional IO. Otherwise subsequent swapins will create new
copies of the page, right?

>
> If the page is still clean on reclaim moment since swap-in, VM doesn't
> need to write them out to the swap disk since original data is already
> there.
