Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6481251D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443019AbjLNCQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjLNCQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:16:00 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07FF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:16:06 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d8029dae41so5880055a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702520165; x=1703124965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bKy6ddO4gp01JzNWFRSzHBN4v96Bqr/tTFeo7yrpzxk=;
        b=UrJ4npHwWRlC610HPjAmSCPszbaCncbJXSma8gln3xbQGnEAgDr/p3bg4m5qe/yviY
         Z0OXZzzIB9wKjYuHJ2xUONKz+QSdS0gAOHCMucko6k7oG18S3n5SvNNy7+hEBGsjRUva
         EUUca/7NFxSZ+koeP50MFZOd/Myzo7FtKUb3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520165; x=1703124965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKy6ddO4gp01JzNWFRSzHBN4v96Bqr/tTFeo7yrpzxk=;
        b=D7Z9ePgBklf34JK/mG+EUnYpqLU1Iuv/7S/P4koF+QbLqaBgpE7QnnRHkV3gBr1i2L
         /Do46GLf17i5ZRDzdY/EOi9Z3GMpgFQXKe7lGG9e72LaNZz/6g7P2Cc7y1xOudvbY0Vo
         hnIrBnqzSXlIb8KantRXp2UWDbpPXC5E5tUhvRmSuv2/N9Vc9eQLDcd2b77CqJlUmJIc
         xb9po8PVQNVv02OfK/dsY/kIFiCvpKrBZlqTmsxXNDztS9MoOgBdCgCWwKHKhlKnZa5L
         7q3emangZLQKwDBEcKVdHvc1uIy3XjqQDhWprzWrlj8bEZRVPb70CK6YM+SlI30Rw3Ia
         6lAA==
X-Gm-Message-State: AOJu0YwcFy5sD/SS/w4JaVEtYHpJCSryeLaglSHwbyxqjosWM4jhn4bY
        G7AYjMt7lzlJMx/3nTpS6LS/dg==
X-Google-Smtp-Source: AGHT+IE20mauZNNkNMzNEKcWHs0secflReTu1AcUqWIB9Y68lbxPSRlPLpUckUArm98zZ6LW+CAc7A==
X-Received: by 2002:a05:6830:2b23:b0:6da:314c:475c with SMTP id l35-20020a0568302b2300b006da314c475cmr3485807otv.12.1702520165579;
        Wed, 13 Dec 2023 18:16:05 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:17f:673b:ab18:3603])
        by smtp.gmail.com with UTF8SMTPSA id x7-20020a056a00188700b006cdda10bdafsm10645660pfh.183.2023.12.13.18.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 18:16:04 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:16:03 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [EXT] Re: [PATCH v7 04/12] wifi: mwifiex: fixed missing WMM IE
 for assoc req.
Message-ID: <ZXplY3Gi6Fv19Y_t@google.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-5-yu-hao.lin@nxp.com>
 <ZWmzAWlh7o4bLZB8@francesco-nb.int.toradex.com>
 <PA4PR04MB963816B99845D943B4D061E2D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB963816B99845D943B4D061E2D181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:47:41PM +0000, David Lin wrote:
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Friday, December 1, 2023 6:19 PM

> > On Tue, Nov 28, 2023 at 04:31:07PM +0800, David Lin wrote:
> > > Remain on channel must be removed after authentication is done.
> > > Otherwise WMM setting for assoiation request will be removed.
> > 
> > Same comment as patch 2, this seems a fixup of commit 1, you should fix
> > that patch, not add a followup fixup commit.
> 
> So you think patch 1 to 4 should be merged as a single patch? In fact,
> patch 2 to 4 is issues reported by our QA for patch 1. If you insisted
> merge all of them, I can do this for patch v8.

In case you didn't get a sufficient answer elsewhere: yes, probably? We
don't care to see:

  patch 1: introduce feature
  patch 2: fix bug in patch 1
  patch 3: fix bug in patch 1 and 2
  patch 4: ...


Just ... actually fix patch 1, and send 1 patch. (Or more, if you have
several logical changes. Be sure to read [1].)

In case you're used to GitHub: we don't work like GitHub, where people
tend to stack a bunch of incremental changes during review, and then the
changes get squashed together before committing. We expect each patch to
be a good commit, and that it will get committed as-is.

If we're interested in the history and evolution of your changes, we can
look at the mailing list archives.

Brian

[1] https://docs.kernel.org/process/submitting-patches.html#separate-your-changes
