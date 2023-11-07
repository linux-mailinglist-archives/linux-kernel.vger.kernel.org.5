Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E7E373B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjKGJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjKGJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826410E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:35 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b064442464so74870097b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348115; x=1699952915; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvjuRqYj93n2uUIvTj3Jv1uzls0LIa6+uQ6Sd8cCsag=;
        b=XzWngXNCt9rvqGq62JFTXvSXFT9wF8T8jmOGAHy5RO3YViXYUCsFBWSupY9OlujP2f
         YEEnbrB8icjEE/l6ChVc23dxBdrMPjVeZXkW5dSZZM6LdcxcDBxiMZZG55Ke7yUzCdmB
         ZJYNhhr579EKMW+QlCyVAsuSsPmkMM9w9Lfe3tqw9nsx05oO4Ige5IE4zLHCixdhCCEV
         3m8r6CPGfArqkef3m1ZYtJ4fFIC4zPyX7MprMXpmTJmmfQPmJni+KNIek/NK7TAEE9tM
         qpVPDJ5N1Q42sMPF5js0PxowDONWmAK/jPx2ZVUQYyFR1PDjEvdIfvH5YkQsxnf7MLtI
         Ey7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348115; x=1699952915;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvjuRqYj93n2uUIvTj3Jv1uzls0LIa6+uQ6Sd8cCsag=;
        b=AW7acPaLZ0cX54bfnPwlKIouvQlQtPgyZBlUY4hzOo7eilKe5E+qbs1YmVbA8fahB+
         zvb6XImDFR72RXS12w3/iVypnQgDqrUDROe+m1bz4kNyW0V66gfAoL18kbKpz4JYnLUE
         uvYkOvSnvdHq/8LZotn3URfJNVqsFL8yxpCSp1xlh6CwtBNt2E7lEEoXvjQJeJ/E05IN
         8FmOyaUffB67FX3onrklJaWQ3jz+UQd9Oc3ZT/5udeFfHC48pCzabv8w0PZo/2DQGcR+
         HdOEXUOr+F6jUqjSoiBcjrsMlgeCIRam3R+cyi4HuF2IN2xAtYVpSw/vE5vfpEnl9kr0
         Q2HQ==
X-Gm-Message-State: AOJu0YxMmySk/kNILI2sLI60yy2neaCOmBccUQYkSyOBDkYN4X2SHH6e
        axZIKTe1VLryC/53RQ7JxUfuX6UgL3neUVY=
X-Google-Smtp-Source: AGHT+IGj9TU8+lxLN687C+eTpgAC5em8F3D4i0httyo4p9RdDRKzcmQa2KJyiH1sOUtSlc285NcKDRrbp09OoQ0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:5254:0:b0:586:a8ab:f8fe with SMTP id
 g81-20020a815254000000b00586a8abf8femr255346ywb.10.1699348114971; Tue, 07 Nov
 2023 01:08:34 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:32 +0000
In-Reply-To: <20231102185934.773885-16-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-16-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090832.260044-1-aliceryhl@google.com>
Subject: Re: [PATCH 15/21] binder: relocate binder_alloc_clear_buf()
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
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

Carlos Llamas <cmllamas@google.com> writes:
> Move this function up along with binder_alloc_get_page() so that their
> prototypes aren't necessary.
> 
> No functional change in this patch.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

I used diff to compare them, and the diff was empty.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
