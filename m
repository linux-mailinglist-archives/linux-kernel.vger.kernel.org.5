Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB227B3CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjI2XFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 19:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:05:45 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AACDD;
        Fri, 29 Sep 2023 16:05:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-577fff1cae6so895057a12.1;
        Fri, 29 Sep 2023 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696028742; x=1696633542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO/3fjY6V7NXsX7xew0hJBkgL5vxDhdDpy1c37B9zRs=;
        b=IDvq+pIGg6ODRnzzyJJxfiZUf8iXVzBJkP9iJJdgU4wwi/QAKtHqO8DeLVUyerQP+l
         ZLNgV5bhRGI/lGNZ1/uk44vXDpoa3w386DPv/ISjZixU+g20QMdwL/L1AEW3U+wfZPCE
         gQNeN91xscqGXqtc4DmtPqxn4eP+q1gF/C0fL6cpj8LOkMZTxHwVKBSrwTp+W5pACcvw
         FzYbfZZ6Qc12WbmiV9mpxrzXRx2b9o4tt09ARogY6VxiD+u4ZkKIxbUoDy68IuEA85gH
         M9A+Ubr0TkadDYGXoG13KOzMCtRzOE/ZR+66gHNf9idCRlqFTFO2cD0dT99dLzuw73MK
         QLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696028742; x=1696633542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO/3fjY6V7NXsX7xew0hJBkgL5vxDhdDpy1c37B9zRs=;
        b=bEqqeWxJQSJKPzf1hrqCbtGzuHjbHEsj/4oFhUSnur5f2f7ycfDKqQM72cE/X2e3bV
         8qmVwWI3xkD9YbTLWu9BCFBkLU85ccrg5S5L242pyGb3qIlUEwHEpQrBD3LrcVmgc2sO
         U5t4frG0J72N/Q9DYkpDtqgowayin/gKYyHt9ARBW11aq0qPpmu3jSvP7V503soFfHp9
         ggvIIrD8n9+7p9DUUoUUYxhUlrESzDoRNAgQVQIQdJPeXFRF2S4HkWQHIjDpj8JqqLqb
         nrzcSzE2cPIIRqi1tAxrheEl4/JZ+V26sTcdGjVYHemYiu2X+nCYaRCVyEvk15TXgjDF
         /7UA==
X-Gm-Message-State: AOJu0Yzx09VdUEaKF6R8U4AC9p+OSXLmrRZ6uv+Hz8ZQwVw91V9YJO8A
        8DQTwsWCmA1PulxKX3fa1Ac=
X-Google-Smtp-Source: AGHT+IFrw1dPJE3cXJ1o6BoBTIGR8EtX662/Ps/RLmspptBTBu/hV6/hDvN+n6uvIda9Nqq5f2szqA==
X-Received: by 2002:a17:90a:b396:b0:277:422d:3a0f with SMTP id e22-20020a17090ab39600b00277422d3a0fmr8751976pjr.17.1696028742549;
        Fri, 29 Sep 2023 16:05:42 -0700 (PDT)
Received: from pek-lxu-l1.wrs.com ([36.129.58.185])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001c736746d3fsm3768151plg.271.2023.09.29.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 16:05:42 -0700 (PDT)
From:   Edward AD <twuufnxlz@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        conor@kernel.org, guoren@kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, liushixin2@huawei.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com
Subject: [PATCH] Test for riscv fixes
Date:   Sat, 30 Sep 2023 07:05:35 +0800
Message-ID: <20230929230534.45142-2-twuufnxlz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023092939-lagoon-punctual-e312@gregkh>
References: <2023092939-lagoon-punctual-e312@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 08:04:57 +0200 Greg KH wrote:
> Where are you getting your odd cc: list from?  This has nothing to do
> with serial drivers...
https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/raw

Thanks,
edward
