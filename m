Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63775880B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGRWCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGRWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E41FCE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-765a5b93b5bso565419185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717686; x=1692309686;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rNBgqhbwS3m6bM0Sx4mFuoy8DGUxjMTmWp+uII1JX8o=;
        b=BCrdpvT0EtYv8uEi5CZ4oBTiadWO0/j6QFw/wO1ORmRcpGPA1NfDg8IQNLTnx8tTXw
         hjAEx8OUhLv5LTdmIk/w+3BSZz2TiWaUBo9gCnTTlt2pdBe84wjDNubgJ5W8lC0P1YA+
         XmD9Ivj+c19AEX9GJt64jWsKD9mBXPd9NjNX4vMDD+RjhUWlh98NBm9jzxyNnxsG8dQ2
         7Wk2oRTbyDneRiUWrBeumiNQ7lA5fjz0tiSSoFl7AgyGNpwGFiiWyug9zgM+2yMOcIKt
         vm5PxFm4H7ijvkBQCyZjiqFiZzTUFvPvblq92ekFp+pAapsbmeMiXqJkKJ17wn8cpJVV
         9+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717686; x=1692309686;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNBgqhbwS3m6bM0Sx4mFuoy8DGUxjMTmWp+uII1JX8o=;
        b=QQ/Wbm9aQvYz4hGNBPrvrW9V2x9BNc/GZQbRjsliBjiW37G1hOWbRgSIshtB7iLDtR
         yA5m99UQOzW6yIpBi/if5CR1P8hd2CFMCIrEseZKqpwRhNdkLYfNty/caRekyTCfF+Rv
         Vu+DfcG9dGEAqBp8jnOo81aCiBuVUDSRDagQ4ZE8ERvePYB6JgeSeU38/Fbni8214eGd
         ciP74vzMjahPBxeLflikbeGh/pMv7+2ECsmbX9xmlBvoA4/8c0zkIlPgXCDIfJqIVTSV
         KqbqNH0NxGe/yW/FOLpzNS+bVhJ+PjrFIiRKlQYEiZzSPo2yFOMdtS6aXXcPV/JqXPGr
         30IQ==
X-Gm-Message-State: ABy/qLZYxjYDBkM+9sXuKgjodg0sO2US9JEL/rw8inXWD6lAQTaM3J2X
        MxLxf1KI2Q+OPGcyteh7Al6V
X-Google-Smtp-Source: APBJJlGl5vbaXsutc56BsIHY4QBJ4VtDW3dC3kcKTyQT8SIb2I5XttMf5ZPcxUa4KB+fsz923atByg==
X-Received: by 2002:ad4:514b:0:b0:62d:fddb:1856 with SMTP id g11-20020ad4514b000000b0062dfddb1856mr14051160qvq.43.1689717686374;
        Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a0ce10b000000b006300722883fsm1024024qvk.33.2023.07.18.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:25 -0400
Message-ID: <5b5dcaa8860c3cd3f40b63b855cecd96.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 15/20] selinux: policydb: implicit conversions
References: <20230706132337.15924-15-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-15-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type for local variables, e.g. loop counters.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/policydb.c | 112 +++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 47 deletions(-)

Loop iterators ...

--
paul-moore.com
