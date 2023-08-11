Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5F27793BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHKQCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjHKQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:02:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2E26A0;
        Fri, 11 Aug 2023 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691769750; x=1692374550; i=deller@gmx.de;
 bh=iqnZU8mU7l4QzSUyGuAE8+gkYIPMNUxpXam1GvezFL0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=gurEsYiCx5h6JS7/3E7TPINnChnbpJXgenK2gid4u1fOoY03aXbqBS87XMcUMvTfvgDtklY
 P7l3ZBhcWjXPZSeBXOfLLsnyvDae63pVkMSSLBI43bC655NoV+7UHypumTm7PXyI7urtAl9Ho
 pGL04kP3y7XegtUkLyVyYWPragvEvAFodzTyc6kgvzVmPw3PsR4hjH5MR2GmC34M07MPCEFEu
 MwdOdUsZYEkCQFmjXUme+r2KxJsX1PRN+JJKzWSlgcOyhcrZ1IjSIj10UKXCnEU7UpYPWszep
 s/Hkj6oZMe0xaArxeq3gTQjqRRgCphcX4zi4lREbRKrAyYuQex5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.154.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwUw-1perNa3bQ4-00uLvy; Fri, 11
 Aug 2023 18:02:30 +0200
Date:   Fri, 11 Aug 2023 18:02:29 +0200
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH] devtmpfs: Add missing lockdep annotation
Message-ID: <ZNZblen+NXOrW9wE@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:5h8fVYMFGB3PYIxsCO6QS49v1wEkt43agtMG/34iq//pZ9V5LAb
 YkF0bhNu1iaP+ZrhLiiYwU0uwHPhPuhkR+J+KERMja230XstP/5Eaz4rguFxCD8fkur+KHe
 onAWIFvnQYGX0CmvhIjx1hLHh78WLKWtExr+sQilpTqGnSapM4TrgWyWTvfiQ6CgOYj5IM9
 M7UCHO2bJlB6p9/JpNPaw==
UI-OutboundReport: notjunk:1;M01:P0:Wh+Orez885M=;MFgRI0gzaXo5p21CWVsTeBAZuwV
 VQCDA3Tggab/iTa7pkAKkKDBZbNs5+ZzXJ5epLopSII9JFJgZsIg7MQAf9GKDSBeOiIYYdGbB
 iDkRZfLK7omF+F40gOPNQab5gQLX/yr3zk7LqO3mjz5ZidnDXIodN3kmX4AvIsY4swpwcDbPv
 43tut8annuXC3agK2vpMoYi7dXlgj266zXNCNKh/WIDTqFXs5jig1l1Di8xY5/EJeweHnpEsw
 +vbUwiXFTqu0Os8zESHksew/PgVTw4MXPYqkVwXUVVlCFs9Mrz2kU5KB7jjco7tgdNS24rMYQ
 rxU14jEM2tVOwYrwE1HtDvOJTDyupY7aOIOGiYw5qFQs0SySkQmtT6dDQ98RK7dt9qqcIcLhF
 hP8JMsL7n2A5OBUzA0LM8d9OY/Q7Z7voo+CtLgYX8z+akobNYSUPyjlDzsxPCL7t/ks6dSuqP
 /ZQUCZ/4vkSVW+iZdTc8WlU7jZ/Deuu9Cc+yCjPb664kxIbb74S6f9t21cdKOGSgHYM+Q3MCt
 4gkBQ7eKzaytJ47rXCrk7HhTmLbXiMTy48wyOdWpfj7QRNY9aRgqSBrv4KBw+yOR25xj1+3Ob
 BgYmPq0VqYJAjhVMfEVSOHYtiAl08HBfZmvTIgWfZ5cqHYCfHSHTe/+E9rwAlGKrF0TeUTXuq
 8JlWh0dOwVca/boqBfqDVGSLpNU6VFskggvRoT3PpohzM3IOvsEn8aERDZuMfKYC5ga8oJqLA
 exh8rEBuo0m5SL+K5boPCp8wEa43GOeCDehy+EdYghz/Y+QjTMTj8Dvt2giNk97bCg5OiJMxM
 7DqYcVKFQl5Zqm46R/mH1OlvIdM/u6vBvDv0sxkUWznHsMH/4AFRIa7ZF34x9EJMF5FVbjg7R
 7H8eutYsLbRS0e7nc9Nrecqc0uzaqpd7oUxBCHsUeFzDJzcQUJN5uBnWh6srygHYIfkkdm/S3
 hNG41XU1OuESyInIAXLOMst3zus=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the lockdep annotation to the setup_done completer to avoid this
kernel warning:

 Backtrace:
  [<000000004030bcd0>] show_stack+0x74/0xb0
  [<000000004146c63c>] dump_stack_lvl+0x104/0x180
  [<000000004146c6ec>] dump_stack+0x34/0x48
  [<000000004040e5b4>] register_lock_class+0xd24/0xd30
  [<000000004040c21c>] __lock_acquire.isra.0+0xb4/0xac8
  [<000000004040cd60>] lock_acquire+0x130/0x298
  [<000000004147095c>] _raw_spin_lock_irq+0x60/0xb8
  [<0000000041474a4c>] wait_for_completion+0xa0/0x2d0
  [<000000004015d9f4>] devtmpfs_init+0x1e0/0x2b8
  [<000000004015d0e4>] driver_init+0x68/0x1b8
  [<0000000040102b68>] kernel_init_freeable+0x4ac/0x7f0
  [<000000004146df68>] kernel_init+0x64/0x3a8
  [<0000000040302020>] ret_from_kernel_thread+0x20/0x28

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef018..f98d58b0225c 100644
=2D-- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -462,6 +462,7 @@ int __init devtmpfs_init(void)
 		return err;
 	}

+	init_completion(&setup_done);
 	thread =3D kthread_run(devtmpfsd, &err, "kdevtmpfs");
 	if (!IS_ERR(thread)) {
 		wait_for_completion(&setup_done);
