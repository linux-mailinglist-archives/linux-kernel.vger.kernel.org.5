Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554AE7F379C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjKUUi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:38:54 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1211F10C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:38:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so7016538276.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700599130; x=1701203930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o5WQccnjZgaS7AdFyMCtckY+Ntl4rQUUFl7+OMDJuQI=;
        b=ep9jzMG0t2pztHoCG1p/gQT/Ou6OVGTYlhil29P+77lhphqXcj4Z4Ur38hYQxze0ZV
         t7lulJt7bR5hoZ9h0xlmAXKBIAgHam3HL00dya861MqrK44lrH4TmNJs4ySkaPtgUuBP
         sEe4lbZdn6o5AWuZCmVnh6npMNx4zEdyrjBKGigCvzWIbnwVm1ibj8APi5IWq37q+5IR
         9QtIeJbInaZ2Ck6n7wcYXOFQRzd6Yy6CGljqnucI0HH40pwvnDmEMKCapHqr64qEL9M+
         SWO3U0xSHMmJTcQEP4bBdw3jfXA1KX6tPuRWAuFTWteBJgEQiO955U50zuVNdXrtUGqQ
         1FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700599130; x=1701203930;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o5WQccnjZgaS7AdFyMCtckY+Ntl4rQUUFl7+OMDJuQI=;
        b=LMB6T4zgMl3i0K467Jko/thDDmGBzluZeN077tLmhAl5zXM/H7vIu+vk6robaQt/u8
         qaMqvoHjfjKlzPvmq90CVfLeqp2x5iEVW9Ff0/Hk4bM09qKvo3d4zXRouB8x6J5duyF4
         FkaiqD/luZLaFykxleJsBYEH7tVf7TY2/T65YuHAdpSFLmnaISvDt4/SBvZT+yi1+WfN
         umapB+VwGuT3e+r54OSAmvsqNzkiXwD9xSXXPDVivCCWir7K8Nq2BNctsGVDkvhVcwG+
         Dy45uqMTNG0RaQgwWq5Awz99e8jFwOzNKm1dCktaKzvI4QYwkLzVSvSxwsB5q0QBOUW7
         n6IA==
X-Gm-Message-State: AOJu0YyREjUH4oi++at4iU+4c+fEJzDv+QIZkkpS4WaZDhC9Jjttovx5
        N8t+Q8Xo7cELidwuOLKWDWiU03jeUmSXt1g=
X-Google-Smtp-Source: AGHT+IHCTQTIAMoy10E+nvzy7nHVvGzyzQV56a5uGSOpbDPWo9CwIH27+2EkbE2yhxm9W4XjY44lbDYDgKxz7cE=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:8741:0:b0:d9b:e3f6:c8c6 with SMTP id
 e1-20020a258741000000b00d9be3f6c8c6mr2166ybn.4.1700599130296; Tue, 21 Nov
 2023 12:38:50 -0800 (PST)
Date:   Tue, 21 Nov 2023 20:38:46 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=rdbabiera@google.com;
 h=from:subject; bh=ZYsgqVxALhhygiFNzzMFz0Ybgo3pXY9d4YO+IaLS/I8=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmxoqFP41Kf3b0/dd1cpoSr2iu81Q/d771b+Hb7Q/0yx
 qklMkybO0pZGMQ4GGTFFFl0/fMMblxJ3TKHs8YYZg4rE8gQBi5OAZjI+YkM/1Sjb1tNkLcWsrda
 1nlTTG27RtreHR3bJzmfdw7ivlGsm8jwP2mBh7jW+h/aj2L/6GWIsvudsvx0wMkidRXrjiMbEvV y2AA=
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231121203845.170234-4-rdbabiera@google.com>
Subject: [PATCH v1 0/2] usb: typec: handle tcpc vconn oc fault by triggering
 tcpm error recovery
From:   RD Babiera <rdbabiera@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        badhri@google.com, RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a Vconn swap results in a Vconn over current fault, typec port
interoperability is affected and cannot be recovered unless the connection
is reset and restablished.

The tcpm currently does not have an export symbol to set the port to the
error recovery state in the event of tcpc faults. This patch set adds
tcpm_port_error_recovery for tcpci drivers to use when a fault should
result in a connection reset. Vconn over current fault handling is added
to the maxim tcpci driver.

RD Babiera (2):
  usb: typec: tcpm: add tcpm_port_error_recovery symbol
  usb: typec: tcpci: add vconn over current fault handling to maxim_core

 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 20 +++++++++++++++++++-
 drivers/usb/typec/tcpm/tcpm.c             | 14 ++++++++++++++
 include/linux/usb/tcpci.h                 |  5 ++++-
 include/linux/usb/tcpm.h                  |  1 +
 4 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog

