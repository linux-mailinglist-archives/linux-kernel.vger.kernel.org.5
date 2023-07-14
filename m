Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6771F753C75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbjGNODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjGNODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:03:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1670D269D;
        Fri, 14 Jul 2023 07:03:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so3263658e87.3;
        Fri, 14 Jul 2023 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343411; x=1691935411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyQ1wGKSe2LrCbJ8+PGAoDQN+cMjfuvHbZJDVsfUq3s=;
        b=A9TSLjm8DLMh4IJZWlhx4doiL0KL7691+0vW5RvqK5TOkPE/HPC+bzPJaBzSVyN0ph
         2T2NQdfKIZjchk5xPvQmuNkTqlInB0kEYbO7rm2tUZ+g3FhJVdLeV75QYSdwTcKcftuB
         mBK/wWZtlpgMA9Thas2wmNj77AHJLIki7ohLNQ1xTcb9KzV5PI58boJx7S8PqKuf11LK
         ZHpsTL8PgVHSJ0vMHhFQekRjR/xa73nGhFZMPEnmjjwDgwo8+UtrcWZ/fZBPpI3+g9Vw
         t0azTYqHB7TLu6C2wA+woKZbdOf2AqCd1AmbpOi5TN75EzpRZVFAtorQ2ZskHwOe7yy7
         01ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343411; x=1691935411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyQ1wGKSe2LrCbJ8+PGAoDQN+cMjfuvHbZJDVsfUq3s=;
        b=QtH5GRqZURIJIA5rO7SL/TDI5HhxH0ihc6LrBQwEBsU+P6CfxY5APEfSJ0wLtd9Qu9
         2P4RDp/z6Olnd4WOAI8lIGQfBS8A1y9xRBdYVcfJdFQwd1I7ZlH03BqBvbsu2hR8HMKA
         f7/d+YBiNi5iFxEswfSOUSX5PuD98Cf+Q5c0qeFiy3H6q+iXwgdARsr7oBynk8/unKNc
         I28CnuHWXTla/jY7VA4oWntGb6BKrI3YMoyeD5MkaFe4ipc9RrAIiiVzghjGU5XUoqEF
         JjroLuj1EWt8DoqJQH/V8W3yQVvBXhfZ4P2jX6hGjSUVDe8OB0U4uojjtUpU7fdEWRDG
         kudA==
X-Gm-Message-State: ABy/qLbzhu5tG7ai0Afc+qbQ4jR4/6igZ9iYp3krJQOdjoTYoEe5J+Xt
        kIxWpwZOwE+C7eKAeprcuHk=
X-Google-Smtp-Source: APBJJlHWMRotCK7ug2Ecga/I3rrVqZkCSnwzQ9itwO214u6fluik4f7pE6hByYuBuBhYHrfrDSxvYg==
X-Received: by 2002:a05:6512:3b2a:b0:4fa:9817:c1da with SMTP id f42-20020a0565123b2a00b004fa9817c1damr4573678lfv.21.1689343410723;
        Fri, 14 Jul 2023 07:03:30 -0700 (PDT)
Received: from mobilestation ([85.249.18.201])
        by smtp.gmail.com with ESMTPSA id u4-20020ac24c24000000b004fb7cd9651bsm1512901lfq.98.2023.07.14.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:03:30 -0700 (PDT)
Date:   Fri, 14 Jul 2023 17:03:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
        kernel-janitors@vger.kernel.org, ntb@lists.linux.dev,
        Allen Hubbe <allenbh@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Jon Mason <jdmason@kudzu.us>,
        LKML <linux-kernel@vger.kernel.org>,
        Minjie Du <duminjie@vivo.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <gkiohfwsrxclkgkrlvfu37kvbv72tahc6c4kvz34uh6hhwrunk@surqby5talzt>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:44:11PM +0200, Markus Elfring wrote:
> > > It is expected that most callers should _ignore_ the errors
> > > return by debugfs_create_dir() in tool_setup_dbgfs()
> …
> > The patch itself is correct for sure:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 

> How does such information fit to the Linux development requirement
> for imperative change descriptions?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94

Well, the patch author does follow that rule in the subject. Regarding the
patch log body it is impossible to use the "imperative mood" always in the
entire text. In this case the explanation is pretty much clear and doesn't
use the patterns like "This patch", or any personal pronouns so IMO it's
fine to have the log as is.

> 
> 
> How do you think about to add the tag “Fixes” because of the deletion
> of an inappropriate error detection?

It doesn't fix any real bug. So there is no need in the tag.

-Serge(y)

> 
> Regards,
> Markus
