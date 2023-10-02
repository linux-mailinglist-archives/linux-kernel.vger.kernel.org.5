Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B238E7B5521
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbjJBOSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbjJBOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:18:48 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB101B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:18:45 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3526ac53d43so1238395ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696256325; x=1696861125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+34LDoTek3JRUSIAM6KDSijBBHBBjrZu1S4WYS1QpgU=;
        b=giSIr59lQT8dLYQthQzLRplahXjIQiAhvYdDwqaLrmNu51ryOooE82HeyiBYHKnqRk
         ZY0AMpQTXhdNnfUIJDMHe5Sv6gp0ZXZgZrSrs7xXaKvX2g6uK8+pM25DklSOhrlpP/FV
         34reos4nq6xxZwvtxDJCYQ9VDpxwV+DS8E7VMxfaAUWUPtJgZ3SP9cNGE19I9zFbdNZW
         DBGLd6yyB+R3W+aIGbwP5mO+5ZbYvnlAbbwcc781eVH9pdByM3nvTHv6OR+AamT5U1u7
         CyvPB+Sw1nlx2mxPL8fuSV0zaoDItrPx0y41mfBrpvv9BJdoO/+D4VUMtrki85PSYp+N
         igdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256325; x=1696861125;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+34LDoTek3JRUSIAM6KDSijBBHBBjrZu1S4WYS1QpgU=;
        b=OnAL7FtXMO76onfB8yvPtVb9o6G5Is3MuvS2ZlA6VhI6ooWIqHxSiRDbUf4YwiyN5Y
         Y7Gk1lJPhSoNrAWjunhPR5Cz9gt73CPIdELCuFuXmsbeXOaVDf31ePn6Jb658i1CgVVz
         GHzMGLd4Cmq9/caw26NNd73ty0MSuOKNVZMw7X8+vpl7O2E1xq0P8JJNA9jWfLGkEb6Q
         JM2lXZPISH2ylpX77KoGGViuGvp/PAwM61loRVDxUuUn45D5KqYA9ooGbK4w5jtzzxgu
         R7M1oIOIskJ/7sOCgqyxBFlC4S9hfwX6eCZlX+KWzrE6h4sFD8X1hbuAB21JGpm5ieEP
         dIjA==
X-Gm-Message-State: AOJu0Yx7lXWCKrGRL48gaTLIxLxo4HllCTLRIv+CiKpouxWzEgdh+lcn
        vQr8GnmMjMk6PhBwgD7Hx4LP+MD/nhD9+NtTBFk=
X-Google-Smtp-Source: AGHT+IFCYHlErqimI384DJ39KVKse8uWlacl7CVvgR+Rt042Bj007XYfwjJapIAuK1ey9v/mrweUea9qbjIysDfVmiE=
X-Received: by 2002:a92:d487:0:b0:34f:7ba2:50e8 with SMTP id
 p7-20020a92d487000000b0034f7ba250e8mr10689102ilg.2.1696256325111; Mon, 02 Oct
 2023 07:18:45 -0700 (PDT)
MIME-Version: 1.0
From:   Root Mailer <myrootmailer@gmail.com>
Date:   Mon, 2 Oct 2023 16:18:34 +0200
Message-ID: <CAGroX2gtc3jEFp8i2cQGzbQascHAsiXeQK-BmumBk+raeREg3w@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Avoid spurious error message
To:     saravanak@google.com
Cc:     dmitry.baryshkov@linaro.org, gregkh@linuxfoundation.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit message it says

"So, avoid printing an error for these cases."

yet dev_err() is used instead of dev_warn(). As it is harmless,
dev_warn() should be used here otherwise this confuses people.

Best regards
