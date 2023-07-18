Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157037587F2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGRWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjGRWBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDDA198D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765a4ff26cdso574054585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717675; x=1692309675;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4IjGZohETdjPHZY0jgJlCHUZfh0j2caOQw0qpHSDuUs=;
        b=Egpx/3mU8nHxuwS90A737HBe/wb3ru2UpMAjRsdRg9x1/YlYYqSuZOJs+qkRF2LX9f
         YnkAfHqW1XPrto0fHK1qxXzbMpu58JZdDGrdc+s4CTzQIQQKNWgcKcakX8XMoFRKaTiX
         BlyhT1kHQUFzvAnf4k4k/AyINf+zgCYrjlrpQ5ydvWHpSIZYTtjhPWdrzdiJ3IUNC/7o
         4Hl8r2coMYHVxZSxZV6T3aXjKAysyTfXXdPPygaRznbVGAWof4nWIR3ydae0j5kkF2K3
         Fot99/HlntMXPJURhaijWrRIb4NjvX8B5jsSrXBUcCHuW7bJJR1Oeku9yRcX3ZyqbrwP
         jU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717675; x=1692309675;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4IjGZohETdjPHZY0jgJlCHUZfh0j2caOQw0qpHSDuUs=;
        b=QwxXotcQF1YMAppbP1+fvaUnH3Q0OdSF6JJ1DHbQl7UbUj78Gf1CMHZPEy9nngnE9I
         j6FkTScSQLLc+65PlfoViokvGu3j380Rahb7isUY66I/p5KBRE6u5u9Xd1+5J+I1nRnF
         0v8jtjybv1aOgO3kOHZzKvtHZ4Hxyo6ndxhniJZSH2EFZH9EE6ODqHxMROd3zjXHVrmm
         waoU+p+5SpuRj339p4D/Ry55JZj9Hkf13xPWtSe3fI16aFoXdpGSTK6kL9pQs01QGEnd
         /kD9lJIU2opCnqx+a9Y6kEuQAEFYA93VkJ76wV7E6epbCr9H9PkiEMgll+ueGUb7KdSs
         6UDw==
X-Gm-Message-State: ABy/qLZZmkxn8nIIMCmz6yg5r+3Lz1dISTknPKh1Ayz95HuBWD2AgqUC
        tc8cf4oauGdUAGGGH0FxgjFA
X-Google-Smtp-Source: APBJJlGx4IU9+zM6kx05Ik9M0KN19dtlnJCgZkzHF+W/3Owaw+2ZzuGTFIJ7zOhdg0y+Y/xBZFJgDQ==
X-Received: by 2002:a37:5802:0:b0:768:2193:6023 with SMTP id m2-20020a375802000000b0076821936023mr5935731qkb.58.1689717674926;
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id a26-20020a05620a103a00b00767b24f68edsm890832qkk.62.2023.07.18.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:14 -0400
Message-ID: <04dcd1f6040e03c5533b3259629988f7.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/20] selinux: avoid avtab overflows
References: <20230706132337.15924-3-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-3-cgzones@googlemail.com>
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
> Prevent inserting more than the supported U32_MAX number of entries.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks!

--
paul-moore.com
