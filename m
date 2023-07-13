Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9F752CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 00:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGMWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 18:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjGMWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 18:23:43 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA3D30CD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:23:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666e916b880so819540b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689286988; x=1691878988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPJRqg7ajyeL4du6RG8R0w4sPMlBCtxY9hG6485AJxc=;
        b=tkAIp3Mxs21mO0syOvSfhIJnKbHEVEWbvFyzLoto2x01rHRZ8u1RSlARS0Jjlpqp60
         mwI0Ec4wbZb4Tb3Gl0z6J1C+dotBmDCo7JoSo5Q46IEFDvJy+Gw2H8Vsh8+z0So4FqQ/
         0ljRfD3HTiiUR3KT2bc+9DvNkkWRwCSMB1GL6eXyfF/ox2YPReN074r8Y6q63gDBPQUj
         ibJfaqcG+mnZ6j5SNPPaKgafx/W9hAED42Op91PlcJaZ7h5JlLZ1/P5I/i7xnu4eTbZY
         SNeV6g82RNy5LBSs826Z7HTv+YPXpWVnyR4UXj7Ci13ol3xKBgDH9gF0D0byBnGA7i4Z
         yhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689286988; x=1691878988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPJRqg7ajyeL4du6RG8R0w4sPMlBCtxY9hG6485AJxc=;
        b=HoE8F89hCo3/FTWCRFV95a7WfwkVgHEpIGvW1PjYWLppq/WSI94cgVD2VFySlCKLHp
         yuLhkuPxrBY1q+qGUXL3M+qcowIp6IlJtOlumY/jRZFOupdoBkzEWqByQLOkHPxxAhsl
         dWkjZJe+jx8DvUQCQO400uHaSuxBTXe5F6fqzIqocZsnCRLotqIcHWW5FXd1Cx86nl3P
         2man61o2FuoHEymizt4Byws+qNYrLBlS2u+n5cNn+X1hCkeBJg8gG1YrVfc5LxbcIKxK
         Z3rCgH2wPRCP6Nr1wg5U2bEEklYdqsLkSp4/Xh+Ch4FQkttPOuSTU6CB+wSQRX+SUaah
         jVKA==
X-Gm-Message-State: ABy/qLbZInlhA3YskfJqrINGyxSl+mNUGQ+Bl0tWFBM33hfnyasimkHb
        cZQ6W18hiIJZotOLvonDswPqCQ==
X-Google-Smtp-Source: APBJJlFHVWSKYJGwaAF7RyGQ4hb39qQwi3/2ZA1sbjnSW0v8O2cboYPbu0mc5q6Qgzb9OnBBytt9Ag==
X-Received: by 2002:a05:6a00:1a51:b0:657:f26e:b01a with SMTP id h17-20020a056a001a5100b00657f26eb01amr2433653pfv.26.1689286987833;
        Thu, 13 Jul 2023 15:23:07 -0700 (PDT)
Received: from hermes.local (204-195-116-219.wavecable.com. [204.195.116.219])
        by smtp.gmail.com with ESMTPSA id j20-20020aa79294000000b006833bcc95b0sm2482755pfa.115.2023.07.13.15.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:23:07 -0700 (PDT)
Date:   Thu, 13 Jul 2023 15:23:05 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Ziqi Zhao <astrajoan@yahoo.com>
Cc:     syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com,
        davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
        ivan.orlov0322@gmail.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        skhan@linuxfoundation.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
Message-ID: <20230713152305.153e7aba@hermes.local>
In-Reply-To: <20230712004750.2476-1-astrajoan@yahoo.com>
References: <000000000000b57ce3060025aa46@google.com>
        <20230712004750.2476-1-astrajoan@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 17:47:50 -0700
Ziqi Zhao <astrajoan@yahoo.com> wrote:

> The following 3 locks would race against each other, causing the
> deadlock situation in the Syzbot bug report:
> 
> - j1939_socks_lock
> - active_session_list_lock
> - sk_session_queue_lock
> 
> A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> the rare situations where a write lock is required for the linked list
> that j1939_socks_lock is protecting, the code does not attempt to
> acquire any more locks. This would break the circular lock dependency,
> where, for example, the current thread already locks j1939_socks_lock
> and attempts to acquire sk_session_queue_lock, and at the same time,
> another thread attempts to acquire j1939_socks_lock while holding
> sk_session_queue_lock.
> 
> NOTE: This patch along does not fix the unregister_netdevice bug
> reported by Syzbot; instead, it solves a deadlock situation to prepare
> for one or more further patches to actually fix the Syzbot bug, which
> appears to be a reference counting problem within the j1939 codebase.
> 
> #syz test:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
> ---

Reader-writer locks are not the best way to fix a lock hierarchy problem.
Instead either fix the lock ordering, or use RCU.

Other devices don't have this problem, so perhaps the unique locking
in this device is the problem.
