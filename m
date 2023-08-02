Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9644876D02C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjHBOhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHBOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:37:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9926AD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5843fed1e88so83552267b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690987041; x=1691591841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh44kcN2L1UjW2d236z/dW96COQp2RpPkwasv4Ct03k=;
        b=solpYabpJoxxcUf2ZdHYCAK324c6Hnjugch4TbZtxln8sUYbTHoGtdk8Wn6YBDE60X
         0FzHiWKZnXaqyC8Aw/BF4W2BNYChwQEUbIM2b49uIa4Kc+6sc18dBrGE4cCexzRdn5Kd
         PEyLWe3XOmEVakP2CARIzK3D7hHk/pyvvn4WOzP9kPaxLZiks5C6gTbD4DvzayRnx9HI
         NRxqpm8UQTUYwaQdI1wf3t/TxZF6r9PWW5Gp4q5PP/647grj7xe6HsjoUcLYv3IibfzP
         TFOE0/xXRphvjEgYwdhctHnhor+JZNEhT5izbbSt8WfQZfTjBlI2x0c4mWMHLR3akqtQ
         Cj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690987041; x=1691591841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh44kcN2L1UjW2d236z/dW96COQp2RpPkwasv4Ct03k=;
        b=BhJEqG3kNyBRo4uR6pVbS0bwpgcCyrr023H64KlpVKZZBYCdEZa+NpCBpFRYHx8a92
         tWAzeDz720RXtSXGOaq6T+qZbikE3he0nJGnQiqaFcmk0kCUuDdKWz3jMVmjsyzFvp4E
         pqm2za2DDJ93NRq774jxBitMjPsCxJO+oLXWJQUm2fEbSUTd3FCTNL8QQ2FfNXyfVAkD
         kaxSxZMyG0HqQ3WBtLHMFt/aLK8x7UZXInN1UltV5FhoOc8mbNhjJaTyEZJr6jr5Hcf4
         esj+YKwWrBMxElamv6ALVVqasq8oyEbkvQhVxoE7VQI16BzZVlg4JB6meG/66dJN/evj
         W4TA==
X-Gm-Message-State: ABy/qLYx6q6MqU858CjlW/YYfiwP9hw3d+q0ZP0Q3SDk9QtYCnFrNR7C
        ygrKBamLWuQctadQskq2DSH/PC6Qsj4=
X-Google-Smtp-Source: APBJJlFcNKBE+fQtiqnMX4zOWRtyVHD50/N/ufHga/uLpmWkC+Nr+CqQWcqlslOh6zPqH6nfuUxzG6CvJnw=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:4e82:f399:74c:8968])
 (user=nogikh job=sendgmr) by 2002:a81:b245:0:b0:586:5d03:67c8 with SMTP id
 q66-20020a81b245000000b005865d0367c8mr56576ywh.3.1690987041006; Wed, 02 Aug
 2023 07:37:21 -0700 (PDT)
Date:   Wed,  2 Aug 2023 16:37:18 +0200
In-Reply-To: <000000000000b19f990601ad84fd@google.com>
Mime-Version: 1.0
References: <000000000000b19f990601ad84fd@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802143718.1583379-1-nogikh@google.com>
Subject: Re: Re: [syzbot] WARNING in class_register
From:   Aleksandr Nogikh <nogikh@google.com>
To:     syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com
Cc:     dvyukov@google.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This bug is marked as fixed by commit:
> driver core: class : fix slab-use-after-free Read in class_register()

> But I can't find it in the tested trees[1] for more than 90 days.

#syz fix: driver core: class: fix slab-use-after-free Read in class_register()
