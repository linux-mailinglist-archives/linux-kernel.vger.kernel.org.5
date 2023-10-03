Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B87B7B71FA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbjJCTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240955AbjJCTqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:46:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C92AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:45:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a22029070bso21262737b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696362354; x=1696967154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=viodXw7fUNfO/LRa8b1+fBrUho8mNoQloTZPtSZSDRw=;
        b=3iw7OeSMlok5fWAsQ3kzXk8gjk93xJV/CYmLAXoVpXCpl6Nr0CJPYZl3n74zJFa69I
         4WfG4atV7WTdsAOpuzpKucANzacVek9OBJmRVsYf26ynV47+qf3KzcHkJqinzIiIQj4z
         KaILlLwxqf4eDiuW3/rfAC0fw+1dBvhkkyShs3u56z7P0Ow4bhn/iB+WRbXkfucn8M5Y
         IM0pK8tKn9qX1REtLsHwaT1KNinPNrwJqiJhsmuJltnCAQgosFVxZg/ftxQRAJq/mmuD
         l1L8EkNOnn9TZ8Y/5InYgByLZNJGTr1cCP/yFyk+7Gza19XG0jqvqReUNKUZIesgGPlf
         07wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362354; x=1696967154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viodXw7fUNfO/LRa8b1+fBrUho8mNoQloTZPtSZSDRw=;
        b=NdDbSNNfo1qmEdfIGQ9ZBOU9F5vQV0nEikksTIr7e0VgFuepQ5+IPVp3tulSyRA1IS
         zUPQ81yF7saGjXAnkCEda0ugFurppeeVz9uQuuoE1y6Q3nJULbF84cczPzOP2VjsaqhS
         pFaW05Zi8i3TqM4SmMqM2mIqL7rFidfvkmgIDDv+5l0wAixgcjRN0Sh+kyVFFZdnhvLs
         mBzoSuZJWmleBjQVJlQa+VZ6xzcEkPJ2GsDpHOLAGpIxTBU1ZsvIFh6Z6mNMc8DQTkMA
         FWsHudbLgvSWF6Ya/6/nzvluh9sFfniFrnFkZi7mXx4f7oF22io0SrzWx3ghYl7BfGo9
         fc+w==
X-Gm-Message-State: AOJu0Yz/vBveGKkqxxKyf7MFDBoe85l9CI2cA1WjDTnbK0br4HwIhvEo
        CGOPqogjsXzR1C5ITd88ull/Upfmze+A2vb8P23k
X-Google-Smtp-Source: AGHT+IE1qDM9+kU7Ss8mySYaAf902Q/5KzDumW0lXdocj5baqcxCFc8Tn3xnpSAJmfEEpIjlChC5Hmp+tjwfE2JiWuwX
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:6577:b8c1:dd2d:1c93])
 (user=axelrasmussen job=sendgmr) by 2002:a25:c785:0:b0:d85:b46f:4375 with
 SMTP id w127-20020a25c785000000b00d85b46f4375mr3284ybe.6.1696362354244; Tue,
 03 Oct 2023 12:45:54 -0700 (PDT)
Date:   Tue,  3 Oct 2023 12:45:42 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231003194547.2237424-1-axelrasmussen@google.com>
Subject: [PATCH v2 0/5] userfaultfd man page updates
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes only the remaining patches not applied from v1, with
review comments addressed. This series is based on the "contrib" branch.

Changelog:

v1->v2:
 - In patch 1 (patch 5 in v1), change "after" to "since" for consistency and to
   be clear that we mean 4.11+ (inclusive).
 - In patch 2 (patch 7 in v1), reorder error codes alphabetically (EINVAL then
   EPERM).
 - In patch 3 (patch 8 in v1), resolve conflicts with earlier review comments.

Original cover letter:

Various updates for userfaultfd man pages. To summarize the changes:

- Correctly / fully describe the two-step feature support handshake process.
- Describe new UFFDIO_POISON ioctl.
- Other small improvements (missing ioctls, error codes, etc).

Axel Rasmussen (5):
  ioctl_userfaultfd.2: describe two-step feature handshake
  ioctl_userfaultfd.2: correct and update UFFDIO_API ioctl error codes
  ioctl_userfaultfd.2: clarify the state of the uffdio_api structure on
    error
  ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER error code list
  ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl

 man2/ioctl_userfaultfd.2 | 226 +++++++++++++++++++++++++++++++--------
 1 file changed, 181 insertions(+), 45 deletions(-)

--
2.42.0.609.gbb76f46606-goog

