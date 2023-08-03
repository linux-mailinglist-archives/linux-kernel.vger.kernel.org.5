Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87C76EF66
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbjHCQ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjHCQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:27:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3F3A9A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:27:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso987357f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691080068; x=1691684868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oivLDNLKkbgHfQKfV5yU0mJN6s95zYt0ChN5nVAL+kg=;
        b=iErEyWVcm5qD8UsitXkSDWAF0kha9IVb7gVXRvZ/wTty/v33XUnluYoS2Z9ksAtBds
         gen7aj3jFAW810VdGF+aigl979PWnjEBZQEvMGT9Z+04eeI8X69bhW03SsM/ZpMICc9g
         fISVYSz3Oj1EBkrrJLHlB49eklecv1fLYgCwVW828K4W42/y8CmVXlWQe5zZeUcqI6m3
         +ksucjVIEVkwVIR2mvTuM7LlMvNP+OXio3RrE6u0qMtMIYy7uc93vhAFF/oohiy6J9fn
         GXFYiejB707p9khJSjRJKas8Ks6Z1G9zlT/CIvl0T+1MJtp/oG7dBfPQbet54j0SvgMA
         1HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691080068; x=1691684868;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oivLDNLKkbgHfQKfV5yU0mJN6s95zYt0ChN5nVAL+kg=;
        b=VzGiX3Pk5Ym0RrL8yJKy/uE9omxtF2cGoFjoaFdGZrzX/nNBEt3IiSeKcwF+WQR+It
         xjDiu7DRDAfwk5zCQv+RWfJZj28rvlvKpv3SyDNwSdQeByt8fwuaIYQWyYDBMPaIrU+C
         E3tQ97lK/Fth4WURr3tWWPRX+R2YgzeStDRKXP7Cn8qFB1qxJXluydbe2wnQ2DIeMCKI
         N+FCkIMFEPc3cAdCXWdbBqmGhDifjzmbRfbIfRl1BDc0uvtoalfcMavtY6HAymRuy+13
         T79g0bpQvfk153AJyGZzpOnIs/XaGRDJm+4fXh3fkfRfD2clcIUVdEcJfIp+vat9nUBC
         yXtw==
X-Gm-Message-State: ABy/qLZDTKUv46TZa/D4nAXScKwDIo5tGmqwF18IwaDE6MZYMI3vql2Q
        CBtmk7OG3H47AYnAdSv/QyfHfQ8YvUZALko/5nKESbQS
X-Google-Smtp-Source: APBJJlGiRMsmYRdqHCoU9ATM7nk/5tBK6TRxPWlfPRz0TrDPQ/mGmPFDHXr42BSQVKQLr8hpCIFfgA==
X-Received: by 2002:a5d:4c8d:0:b0:317:51ff:c249 with SMTP id z13-20020a5d4c8d000000b0031751ffc249mr7649766wrs.13.1691080067890;
        Thu, 03 Aug 2023 09:27:47 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d474a000000b003141a3c4353sm253167wrs.30.2023.08.03.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:27:47 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/4] mptcp: more fixes for v6.5
Date:   Thu, 03 Aug 2023 18:27:26 +0200
Message-Id: <20230803-upstream-net-20230803-misc-fixes-6-5-v1-0-6671b1ab11cc@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG7Vy2QC/z2MSw6DMAwFr4K8xlLKx616FcQiBEO9IEVxqCoh7
 o7FguW8p5kdlJOwwrvYIfFPVL7R4FEWED4+zowyGkPlqtq9XI3bqjmxXzByxntdRANO8mdFwhb
 JNRQo+GczEFhqTXydVurAROiP4wQmfvYXewAAAA==
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=hgCwEKZgy/8nY7p2tutm9i8Gq8mlRZAT01grbY/3qkY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBky9WCazqpy0eFdeJz/pfyJ9oT+4Y4qjuQQMuHU
 YsGuqL+9YGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMvVggAKCRD2t4JPQmmg
 c4tpEACMT/28Wn9oxoeqlckZ63o6dknucVWGKpYJfLf4KZFUEjwqVBxmJanigxdgq9DmJ1M3gtd
 ustvow4UL+TaqKrnvnj7Gan1MepJpoo2V8gI3YYIPUeW+lyf3CNwdlVl/5YMkk86Hqs+1uVqCGr
 7bPAU0WyCLVdZcFwqoNKWac68WKTLEESOjWN8jb3RSz9yjrqTnpz9JcrZMI5wqbm9ttg3JcYmlU
 E3UPkEVI10F34ybTjGlyGq5JrZI0tqQwvK9WqgECsDD5qYG/rlgVyeH7oYY0e7uzaFdyk94iPcx
 LZJb0T0gVqZoXExoz6QGVmg5EqACV8lYOTwmbI6/KGADcbMh/dJF4lj7ZmmNwXrbUzM2ifOwvVa
 5bGc7N4eIYMwLjAkPnXW0dnWMvIR4XVjo6Pbymvh0S1y4y0npMSAGAKTu8sJ9vA3D6vd2xGjc58
 aRR5MNjy8XOT3H1gjy31HsRuF4LUfG+/au7kzZJHqSofmYXfcQNKkBf/n4qKHYQnlQ/GojCFMjZ
 0xhD5xemaPvg+0JqNaVr/PkDe4Zot2MWQNMKIjJdXSqsY8Ix1hPwM4uHXM5ZMcO20HkEeZkP2bd
 HWovI9sanLv4VE/Qp+MYunVPqgMvwieY3An9iKGQJJRgVbs/pwxY1Gt1eiCBqUrKD15k496BBit
 DMQVKnLYAJPz4EQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new batch of fixes related to MPTCP for v6.5 and older.

Patches 1 and 2 fix issues with MPTCP Join selftest when manually
launched with '-i' parameter to use 'ip mptcp' tool instead of the
dedicated one (pm_nl_ctl). The issues have been there since v5.18.

Thank you Andrea for your first contributions to MPTCP code in the
upstream kernel!

Patch 3 avoids corrupting the data stream when trying to reset
connections that have fallen back to TCP. This can happen from v6.1.

Patch 4 fixes a race when doing a disconnect() and an accept() in
parallel on a listener socket. The issue only happens in rare cases if
the user is really unlucky since a fix that landed in v6.3 but
backported up to v6.1.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Andrea Claudi (2):
      selftests: mptcp: join: fix 'delete and re-add' test
      selftests: mptcp: join: fix 'implicit EP' test

Paolo Abeni (2):
      mptcp: avoid bogus reset on fallback close
      mptcp: fix disconnect vs accept race

 net/mptcp/protocol.c                            |  2 +-
 net/mptcp/protocol.h                            |  1 -
 net/mptcp/subflow.c                             | 60 ++++++++++++-------------
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  6 ++-
 4 files changed, 35 insertions(+), 34 deletions(-)
---
base-commit: 0f71c9caf26726efea674646f566984e735cc3b9
change-id: 20230803-upstream-net-20230803-misc-fixes-6-5-6046c6ca74b6

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

