Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E027E07CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjKCR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:55:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE7D44;
        Fri,  3 Nov 2023 10:55:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54366784377so3785083a12.3;
        Fri, 03 Nov 2023 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699034153; x=1699638953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SelOsO4e7GQx4YbT87ZuQxwsrQ0BMcUUcVqEb+J9ljQ=;
        b=KcmXVTpKamYccmaCVCqm2XmsgsbX9wCA88bH2cS+o+2rC8hxHo7kbMdZKWbpccEtuE
         M24Rqman/uZ2iucQMDiJ3LeMk+ju+08itQOSoXk2AUEXZYv+0VhjjO+ZxumfCjV2zm7W
         txYa1LHqjB1P+kfGStPLDohxSCJzBFmfA8HHuHUsQT/6ZzTxbvsIJPTdfKEUduBgqaSz
         UJCLGIdNRHvVy8gSUKlK056ZHCaju2scPRctU/WvGpkI9aj/5sRUuT+o3DwFVIbUeEIj
         Nzft2SA8+6KboxJzveO6uLPdIDjk+mgIV0Ge3Bzc3nDPJxRuyeaJRatTWmcme25V9P3h
         pRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699034153; x=1699638953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SelOsO4e7GQx4YbT87ZuQxwsrQ0BMcUUcVqEb+J9ljQ=;
        b=pe09NGcLED9mqI0vvk9srZJPpHR1bf42CaQ2M2qgskM2HzvyHv5KF5tJ3wRhuf/gCd
         ABJZ6gxKGt+OY5dnLhMBk4/qWIBMDfEigO+KNZxGbV6yYxDWIajMFJ13ConzTOSr4eiS
         lriedq7K82C8OEQ5ZWgyjENQ2AQP3yUPo+sf/0wjpQXEc3vdwNHFQ3dOXWEO7Y2AO2JU
         oXaklDyBLlX8QYo0aczfPVdfMMwHoEDz6dEUWXb72U1IW6ux7Yi8jw/WhWvgNF+muyye
         ecLIsfzhQxm8w4pSmjvEtLZaRx/HXFznlQxei40ESq6jjbNdXRiDKKWC23xgyNzvnSVL
         cBfw==
X-Gm-Message-State: AOJu0YwdOzTcI2U/K6j57Zsda6VjGOPH/S9jhvIhrvFGj4vGfYaKgxV8
        9TYPOjWAGFJXPJRVlWAgBlHewKbMQHhpfw==
X-Google-Smtp-Source: AGHT+IHtBfN5qqilHam3HPfW97af6GjBiqTqanKMhhWgWDVGR9JFL8UGu7zLUnI5jEJnj7wKSgSvCA==
X-Received: by 2002:a17:906:c14f:b0:9bd:f155:eb54 with SMTP id dp15-20020a170906c14f00b009bdf155eb54mr7760058ejc.6.1699034153179;
        Fri, 03 Nov 2023 10:55:53 -0700 (PDT)
Received: from fedora.. (host-62-211-113-16.retail.telecomitalia.it. [62.211.113.16])
        by smtp.gmail.com with ESMTPSA id wj6-20020a170907050600b009ddf1a84379sm80306ejb.51.2023.11.03.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:55:52 -0700 (PDT)
From:   f.storniolo95@gmail.com
To:     luigi.leonardi@outlook.com, kvm@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, mst@redhat.com,
        imbrenda@linux.vnet.ibm.com, kuba@kernel.org, asias@redhat.com,
        stefanha@redhat.com, pabeni@redhat.com, sgarzare@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Filippo Storniolo <f.storniolo95@gmail.com>
Subject: [PATCH net 0/4] vsock: fix server prevents clients from reconnecting
Date:   Fri,  3 Nov 2023 18:55:47 +0100
Message-ID: <20231103175551.41025-1-f.storniolo95@gmail.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Storniolo <f.storniolo95@gmail.com>

This patch series introduce fix and tests for the following vsock bug:
If the same remote peer, using the same port, tries to connect
to a server on a listening port more than once, the server will
reject the connection, causing a "connection reset by peer"
error on the remote peer. This is due to the presence of a
dangling socket from a previous connection in both the connected
and bound socket lists.
The inconsistency of the above lists only occurs when the remote
peer disconnects and the server remains active.
This bug does not occur when the server socket is closed.

More details on the first patch changelog.
The remaining patches are refactoring and test.

Filippo Storniolo (4):
  vsock/virtio: remove socket from connected/bound list on shutdown
  test/vsock fix: add missing check on socket creation
  test/vsock: refactor vsock_accept
  test/vsock: add dobule bind connect test

 net/vmw_vsock/virtio_transport_common.c | 16 +++--
 tools/testing/vsock/util.c              | 87 +++++++++++++++++++++----
 tools/testing/vsock/util.h              |  3 +
 tools/testing/vsock/vsock_test.c        | 50 ++++++++++++++
 4 files changed, 139 insertions(+), 17 deletions(-)

-- 
2.41.0

