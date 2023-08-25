Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BAE788BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbjHYOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjHYOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B9210C;
        Fri, 25 Aug 2023 07:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A7C63F04;
        Fri, 25 Aug 2023 14:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83ED8C43391;
        Fri, 25 Aug 2023 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692974180;
        bh=knPl1hvtXXOjW5o0nQigNWOkQl6U4T8rtkIhWnxCkgU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Lky+ur3wsG3xveAIsYAcjn3zVNavCDNBMJuDiu0umIjTk9e+635csWC1j1G9IX1sY
         FtPkF01nFjUEUUSLHwXowU2m0Aa/eAIZlK6krD+kcZTkujEjI3Hkg4frPoizCaJmfl
         4rweiJJ0H/CZ5u7xzavhoK+Y+EK+7zRk5RsppnRnYfqxkHEgYCd4YOSP6S0pcdK02m
         U73ZPzAbCLuflu0LkhIKnvhLulr8Z5uCuojZc/T31H4Hh0Zqc13p7pddjF4Dg0DXWC
         BE1KENsWcNN4jpznUb5XM1QeTaCas1EiphiWHNRQMaSA9lFB+/vwbjSiobImxeU5kK
         r816/KsuI3TBA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1cca0a1b3c7so630548fac.2;
        Fri, 25 Aug 2023 07:36:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YynPodAQ0mOitmDHRRXdNndNOXLbjtU6zX6a8gMGS4lAUDm6zvd
        VqyKvfu28yREoHEpf73CH3mqXAP9Of3YEUOc3CQ=
X-Google-Smtp-Source: AGHT+IHQkXmrF3v5TxVMnwg1gH+qWgOF00qaJOiId0hGcAQ+sDMQsibx/zmS4VIpoPHFKj1Q3kXtTDYZxQA5+iomQdY=
X-Received: by 2002:a05:6871:828:b0:1c0:1424:5e79 with SMTP id
 q40-20020a056871082800b001c014245e79mr3517602oap.42.1692974179652; Fri, 25
 Aug 2023 07:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1186:0:b0:4e8:f6ff:2aab with HTTP; Fri, 25 Aug 2023
 07:36:18 -0700 (PDT)
In-Reply-To: <20230821082903.26423-1-yang.lee@linux.alibaba.com>
References: <20230821082903.26423-1-yang.lee@linux.alibaba.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 25 Aug 2023 23:36:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ac_X+n=Sn8KSFna8LSZ2CAvOx-KHu+t-2xbwzOd-GTQ@mail.gmail.com>
Message-ID: <CAKYAXd9ac_X+n=Sn8KSFna8LSZ2CAvOx-KHu+t-2xbwzOd-GTQ@mail.gmail.com>
Subject: Re: [PATCH -next] ksmbd: Fix one kernel-doc comment
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-08-21 17:29 GMT+09:00, Yang Li <yang.lee@linux.alibaba.com>:
> Fix one kernel-doc comment to silence the warning:
> fs/smb/server/smb2pdu.c:4160: warning: Excess function parameter
> 'infoclass_size' description in 'buffer_check_err'
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Applied it to #ksmbd-for-next-next.

Thanks!
