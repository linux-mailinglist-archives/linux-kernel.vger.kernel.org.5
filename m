Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787F75B051
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGTNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGTNpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:45:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDC1986
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:45:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5707177ff8aso7493687b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689860723; x=1690465523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knRbu80OJ8CLJhnQO5wWqGTxy3faZAYp+dQGDLVzoX4=;
        b=zxZpchrshqL9I6eRR0BSKpc4nlBOwFpJNgyzgAgyo8mdlxp4vOYkBJ4BXuZc9IRmq1
         axPzkYA2cII3XkAGh5UNoEuQtecPd46bK/AI5xTCpC6gyiYWR3HqJuyq0MB9qrMb8SzU
         9LA80ZPYiDXt/qzAOphsh0rEzLM1fVaqk0lHNc+8tjmcO2GNPKZ/sSFKzypfD6bmqmwD
         05qWWPNMy7fWLXeLSFKPsNDTLIj05DIcCYhgJDfslWBWgPBs1QXdafRPpoRimlViandm
         ul4P5w7SHX3ExnXrAXJv2pMqND95cC0LNFTU3u7Uog5PUKlg1PovZU6EKvs/Il6Ehkw0
         qTow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860723; x=1690465523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knRbu80OJ8CLJhnQO5wWqGTxy3faZAYp+dQGDLVzoX4=;
        b=V6LwNTqVWVArA+ANSKe51QCWVRCWDhBel2tmIVAF9FwqpSrp5r8DV9wbQOgs3NK9Ko
         7/TXfNcj+JOiCkpuLnOx9o9FuraZTH6KaQm97wLp2yCt/sewZ23Uaj+DUIrUcN9hwWrl
         L5mcwKyWtkRL/Z4Fb+ppO26owmwtaFXbuSBHPt4vYCFSwm13ej4ya3rhaJNKybKOHysM
         Xqw5L5nvDs5D3EC1xocQO7ELJybjgjznLjsQ3tz3hryqhpPhiw3hn/0fxgosUMGN6BvN
         7HfgjzVnBWNoobShGXQqyuOSwK3pNhsyQYPctTrjeXmCUr2rnx1x9FBD8cYrpQ+JqBpD
         EcCA==
X-Gm-Message-State: ABy/qLbPdJsRhtnHicU7woOceSBhKC3ycnuWnqRNS4NpktLKPq2RlWp+
        KWTDcm55EC3Rf6qsjGkhCo7ypVNl8y8eMrw=
X-Google-Smtp-Source: APBJJlGplpoVryvURkn9ZSMo+zrTMcglju2HavshLybsiFTib7Swl5mhM9Plg6FME4ZvmaeT9vcCZhCdLZ5Du9Q=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:b70d:0:b0:581:7b58:5e70 with SMTP id
 v13-20020a81b70d000000b005817b585e70mr59909ywh.5.1689860723759; Thu, 20 Jul
 2023 06:45:23 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:45:19 +0000
In-Reply-To: <20230718054416.861412-3-tmgross@umich.edu>
Mime-Version: 1.0
References: <20230718054416.861412-3-tmgross@umich.edu>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720134519.3548499-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/2] docs: rust: clarify what 'rustup override' does
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The behavior of 'rustup override' is not very well known. This patch is
> a small edit that adds details about what it does, so users have a better
> understanding of how it affects their system toolchain (i.e., it does
> not affect system toolchain and only sets a directory-specific
> override).
> 
> Signed-off-by: Trevor Gross <tmgross@umich.edu>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
