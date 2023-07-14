Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C597536D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjGNJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbjGNJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:44:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DC710EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:44:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57325434999so14417177b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689327849; x=1691919849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQulSBzim5w5xsl3zfUAjtDmEmIk8kUKUMOuRvJ6ZCs=;
        b=DQpb4IPB+IEOr1+4EUQM2FmUBJw5xH7JV8ghu2wughEM1EpQiUxBQZ5zjqURzdywtg
         tTQXaa6b3GEFmZFpbMJYgihDJYXbins0NvNDWbPyFwdUePob9m927o2lx2j5Ob/BPSjv
         nMhdBDga2+kWHumNaj3xqYgTl03NBH5mjktuZ1BEs/tzloL8RpHiHHvIeUy1SM2Vg7id
         idOuWKpM9chwHBoRaScpj896NxhPaVjKVYqn/QBLqdqba0Gepx1461g1W/WXcNiXslMI
         llxiWcfZ8KGZXYjvApsptsIedYoxGdrh6HHfWmq+4cO7S6OLBmSHb4aH6QLdQXYrBAnb
         By3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327849; x=1691919849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQulSBzim5w5xsl3zfUAjtDmEmIk8kUKUMOuRvJ6ZCs=;
        b=Bbl2yId+x1/De/CQoNn7pfyNUMpHCJvkYaOil56lb9rc73mH/QcB7my8SFhAxM0DYJ
         HVYoB0qvdBZ3WhGTztiMryDTthzAjjuv6c3N3hrzqELl216eHdBAaejZKVzcP607cfoo
         Zy33q1KPED/3P+VmO3m/+UlcosqWpVf+kxseMW/ENYmP24D5A7m7c2txc3LAV6XiWVNA
         UoANznfcF+RoRhkwWPUIoAwl4371i9P2Yl9TljsstRq9F3wogA8EalInoNgJ11iiFREd
         W2nzJW/Z2JX+tNCyNWHtaTURZ59fLHqd9lET8mGh7sJC1mCTHVcwX7/mSoj07alj4kuT
         FY/g==
X-Gm-Message-State: ABy/qLbZLVsOa7mnFpeRXr0lFgy/MOpjCLXh7hjIrMwQWnOXiU8uH0D4
        OBqnRGdcZ1JvlpHZ05SbHn1zPWSFAU+UCTY=
X-Google-Smtp-Source: APBJJlFkOynd+DZBQ11JhDvwFzakuB2FgEeg8+O6Um/oHo+JsjuP3TedLZMe2EG99Wz7Gm+tf4lfq7SZ9BPMf/c=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:b3c4:0:b0:576:de5f:95e1 with SMTP id
 r187-20020a81b3c4000000b00576de5f95e1mr27471ywh.1.1689327849767; Fri, 14 Jul
 2023 02:44:09 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:44:07 +0000
In-Reply-To: <20230714-zeroed-v1-1-494d6820d61b@asahilina.net>
Mime-Version: 1.0
References: <20230714-zeroed-v1-1-494d6820d61b@asahilina.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714094407.2188895-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: init: Implement Zeroable::zeroed()
From:   Alice Ryhl <aliceryhl@google.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asahi Lina <lina@asahilina.net> writes:
> +pub unsafe trait Zeroable: core::marker::Sized {
> +    /// Create a new zeroed T.
> +    ///
> +    /// Directly returns a zeroed T, analogous to Default::default().
> +    fn zeroed() -> Self {
> +        unsafe { core::mem::zeroed() }
> +    }
> +}

I don't think this trait needs to require `Sized`. How about the
following alternate implementation?

pub unsafe trait Zeroable {
    /// Create a new zeroed T.
    ///
    /// Directly returns a zeroed T, analogous to Default::default().
    fn zeroed() -> Self
    where
        Self: core::marker::Sized,
    {
        unsafe { core::mem::zeroed() }
    }
}

Then types like [T] can also implement Zeroable when T does.

If you make the above change, then you may add my
  Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

