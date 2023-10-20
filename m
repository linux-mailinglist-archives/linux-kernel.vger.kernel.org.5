Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D877D11DD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377597AbjJTOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377537AbjJTOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:51:54 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 07:51:51 PDT
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63409CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697813509;
        bh=OfnmEDS6+/ExGqWRIUUR2lwCKkzZhCSYoiR9KU8upQ8=;
        h=From:To:Subject:Date;
        b=V/V62EYa4PnQ7YU9Mb3L7RGjHul0DRN7LsupW7oPzE+GZ8/+CgQIP43vK4DH5CGHr
         g3Gmuyy/Mqt3pbVyhOGLM0dKSYKCo2526QJcYB7KHt48lU8Ipbe6L8GIDr3eWPPkvm
         WDdXr0HvNt7+jaTdtY1rWF7cYelKYf8lyZUvioZo=
Received: from rtoax.lan ([120.245.114.36])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id AE3AEEEC; Fri, 20 Oct 2023 22:43:35 +0800
X-QQ-mid: xmsmtpt1697813015thc297b1d
Message-ID: <tencent_6C0CC401036E21982C88CB2615D357E5D107@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPOa4P5MySVBADLO7ozZCgckOnnuNah+YBv7r5dRXP8QodJ80UraB
         j833jPGKo6vOKJoLzHhvNwin8OEXXZXVFGsfhHAeFYS1o/m4a7VWVoQFRlNlACY4VkyIh0JNCxGx
         3eMgIvalZYNOPRDZ77UpxVu7XjVnuUiVDA5+6RmMgE88rOhwMRWWXqwYXjl0jJCVsP7J2Td/Yfkw
         ud0i6i/3ooc2L5H0MfdbvUonR+39uNcJhUbXR8fSEZEY8/V6HJH2lGoNX6woYKP1KhQyHWZ0mIvl
         Ht36aKywzpBUq7jO88zeaUjAge0crV4wcYGk9LZjOJztJ1y73SvBV0E6ifFT2//7gI8mhP9zrmw+
         Ve0Nr+y/WBGL/Vyjlk60ACdfa36qYNH1+acoHti6DoeW3X2Kt80kwuLLFubmkuqm2uOZxsIYof3y
         zkP83QWO/4jCIjBONXj7xUqSZPo9YTEzM/KUt3HZJql5S5AXztyfcLRH3+owBvnB7SUGYZq43eNY
         cdCvfj9pMIjtKnzzZd7MB1lv2vy/w5u0knRCKSGJLZ4JeRkETIQYWjEe78lIhXAW5SLxxqkCftG9
         FoHRJMQc26dwZyvEerHxGA8lKnKwArWczGo47WH+I1L6MIhfA+v0Fn7r4A4L7eHlwx4gu4HMWAcb
         zb/cGDkf8Z5NjXUD+sI1hk/xEWaHiJITY0fHTyCAXt2i0bQK7LNoZ+We7++HSoPc55ItqVge0tx2
         G6wiDWCUQbto06VC1UfScQ3Ly8ZFnTKE9ujNisRl4He+hCTkhEvi/cDWRX40FfiGSjKaqXWnLIWl
         /4sfcimS8idmdqFbeCjFvpAm+u4itVw1lt2Du/NLYnUvythJ4pbqfLVRg1JZZkCmn7bZbtRV9Tu/
         oO9lVN4vA1oyXx2PYA2sApWQ+LZN6ULOTkBi3QGVMpHAhz/s/hQE9nmA0vfXMtXqW1165KuR9ET+
         NYNnyZf39h9AETx4UniT2Rs51wKGfoxPMlEtA8i3DiZNyKHgkj/AuynedizFttMjVDyW859AeQVk
         pL9apdsw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, elver@google.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        rongtao@cestc.cn, rtoax@foxmail.com, tglx@linutronix.de
Subject: [PATCH 0/2] Clear multi_stop_data::state atom use
Date:   Fri, 20 Oct 2023 22:43:32 +0800
X-OQ-MSGID: <cover.1697811159.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Clear multi_stop_data::state atomic use, which does not pose a risk of
misreading multi_stop_data::state, and add comments to
smp_store_release.

Rong Tao (2):
  stop_machine: Use non-atomic read multi_stop_data::state clearly
  stop_machine: Apply smp_store_release() to multi_stop_data::state

 kernel/stop_machine.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.41.0

