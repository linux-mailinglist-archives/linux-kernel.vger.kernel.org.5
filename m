Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B26753C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjGNOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjGNOCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:02:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2431989
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:02:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c83284edf0eso1698217276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689343323; x=1691935323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RX/r2ODC8fCu29Ed3cujFRc453JSyfT5sPImsob4JU=;
        b=BwbXGxAdGDSa8Hh7hYoUt1tjxNITodRy4Ie5C9Ve5VjqA6Jp+nyRz/A8pfmVILcQ64
         waqrj3jD33fIlouxPLj8xVZ7jMJXPFpzZZfFIhJRa14Ko7B0PJ9XRY1ZTwTG/bpqLs6Y
         BruFqcKyT0EUFnXIdp0TIxtA3LQR0nYcxTlVMiwkz4IRgvYemxzWVSA3T8g404mRVp3+
         3dri6WPbfsCB8AwLXDoA9muP0F2W+o/cAaLBQOFQLs1sYckvS7fBVKqH65bEOBGc7dsw
         FK3QzCp5BfBLk4FUwZ4FZA1gNaX3R8wrbNX3RrAAV2tNGAFQZlGdMBItHrESM9ihMcph
         sZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343323; x=1691935323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RX/r2ODC8fCu29Ed3cujFRc453JSyfT5sPImsob4JU=;
        b=lAtBpE6CXhK11cK4kbL2qnsXq7tK6nSSKBYmnshGY1cZJNz+0wqf+WcWCuyLdPr5K6
         y+nCf/ZEuVX1wQG93hO6eU/KnYjZqh+wyd54TFt0Vlk7KxG13pfiwmZYlO0VEbrkqxFl
         pv9/3Sm341ICbOKiLIz+ruy4V8zwKrA7WE/4hwtb+zo05LideqtWfgQN0Rw9mFuimsPR
         AYttU/K0o/apHj8SBM3f4pNeDrY96p/iQU6F2Gpml3i+4DkcHbJ5nxHkVevjMszHAv8d
         tFswlU3FoVguUXRxy691UFvBUpugHv2SQOPuJ+2FFezPsokNpZRlGn7H6qbScvw29lCh
         0q3Q==
X-Gm-Message-State: ABy/qLamAojypK6U2srBHCHAgKAfcL9jSH0/+ixmHF/Tri9iNpsXb7Xs
        c2Hfxu40B46gJH0ZBAcbAI4cKz4f16GUflg=
X-Google-Smtp-Source: APBJJlGzu1LO19CXBMx8FKjaV6KIVSfUtdfZqayTOkYrzFmODQN5OrWCNNNYNkUzckjgrty4qCCNo3lYvl3ikgU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:d8d6:0:b0:c62:d787:3acc with SMTP id
 p205-20020a25d8d6000000b00c62d7873accmr25193ybg.2.1689343323690; Fri, 14 Jul
 2023 07:02:03 -0700 (PDT)
Date:   Fri, 14 Jul 2023 14:02:01 +0000
In-Reply-To: <CAPDJoNv1HW-5uCj21PX3t23rJ+sbTL4Gm5pDis8HGJ-VTr4dug@mail.gmail.com>
Mime-Version: 1.0
References: <CAPDJoNv1HW-5uCj21PX3t23rJ+sbTL4Gm5pDis8HGJ-VTr4dug@mail.gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714140201.383439-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
From:   Alice Ryhl <aliceryhl@google.com>
To:     ariel.miculas@gmail.com
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, lina@asahilina.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asahi Lina <lina@asahilina.net> writes:
> On 14/07/2023 18.48, Alice Ryhl wrote:
>> Asahi Lina <lina@asahilina.net> writes:
>>> Trivial implementation.
>>>
>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> 
>> The commit message is a bit short, but the change itself looks fine.
>> 
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> It's so trivial I just didn't know what else to write... suggestions 
> welcome (for this or next time I have a patch like this) ^^
> 
> ~ Lina

Adding some sort of motivation usually works quite well, e.g.:

Make it possible to use a CString with the `pr_*` macros directly, that
is, instead of

	pr_debug!("trying to open {:?}\n", &*filename);

we can now write

	pr_debug!("trying to open {:?}\n", filename);

Alice

