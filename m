Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6A175B04E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGTNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjGTNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:44:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95131986
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:44:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57a43b50c2fso8160727b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689860676; x=1690465476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUw718EqiyOItgwLRoWHschTDUolZNtcEeIulMXRuU=;
        b=Qe45Vgea9Eb6lR7WQMdTwnmQf8IRCSuAHhjorIGTWlHBqhWfzeyijpT5OgAiHcw5Hs
         PgcZM9ydmUS6rhORROj0FX3dxg7fHYAoo2UDvzSY9uSu4wja7RsRQA93RxTJ24pg9wpB
         LpnigSLz0auuL+KRAHJfFOjWkgH+AZKNeAcs6NMxAYiaR5D+Gq6nTdMwTvogm6bwNjbq
         OKXP2852kXFEg6DO51hM1sinDG8/mr5mYx94iv2TlC1Jl9bdaEzUiWN/+prDhRi4erZV
         HgakPHRBd+0MVwsC+HaBPJ838OSffS7i0ukpCHgu+aOvZV05NjwzI0GTpl6P/PbJ+PV6
         Fbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860676; x=1690465476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtUw718EqiyOItgwLRoWHschTDUolZNtcEeIulMXRuU=;
        b=iNJLLP4z+BHVpGALW1V/3/VdT54DD0tN4N1pF462sDH2QZ2i/q23wP2VY+6TsCrhoQ
         w1cx25vZUX4OA9KDaLP+qZyJohPCwnia9TAeEQlLKt45Zr3gjjA6TCvfykEwmLJnlYlQ
         xiytSNciQfZqxKs6QPxTRSrzMUW9RSxKKaNDXVKaTQ19Gu0fQHH8bg/V0Xr7Qx1KiKNT
         6LP2oZIqdga8FPdTXeAKuSbQ6MxEFOxVzKwz6fOEtCYpjzz+TfZv4vL5ZkuVMgmeO9Z3
         OwCMtDfMktrE5dDEPGy/Cph7oh6uiKmzuvZAMHz6qhF6iBxPKm/YY8EaPEr3HX/DHQkc
         HKSw==
X-Gm-Message-State: ABy/qLa4XEXOaMNFdo4sVTeUh9c/aL5sXSq07eManFyuai7laQKg43Ej
        4n5NXqxaqUPjZdLQ5TWqBgvzvlzqnPOhTrg=
X-Google-Smtp-Source: APBJJlFtGDZZbmerF2xp0urcimT532Xxqp7VKULGWvIydvDQxihP8tafHJbfMTat9HbGQhQ6KJ2SC2jq2gjZKmg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1709:b0:cab:e42c:876b with SMTP
 id by9-20020a056902170900b00cabe42c876bmr44853ybb.3.1689860675977; Thu, 20
 Jul 2023 06:44:35 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:44:28 +0000
In-Reply-To: <20230718054416.861412-2-tmgross@umich.edu>
Mime-Version: 1.0
References: <20230718054416.861412-2-tmgross@umich.edu>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720134428.3547917-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/2] docs: rust: update instructions for obtaining 'core' source
From:   Alice Ryhl <aliceryhl@google.com>
To:     tmgross@umich.edu
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        gary@garyguo.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

Trevor Gross <tmgross@umich.edu> writes:
> +	curl -L https://static.rust-lang.org/dist/rust-src-$(scripts/min-tool-version.sh rustc).tar.gz |
> +		tar -xzf - -C $(rustc --print sysroot)/lib \
> +		rust-src-$(scripts/min-tool-version.sh rustc)/rust-src/lib/ \
> +		--strip-components=3

I think this assumes that the sysroot path has no spaces. I would add
some quotes.

With that fixed, you may add
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

