Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B037C825C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjJMJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjJMJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:42:00 -0400
X-Greylist: delayed 8011 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 13 Oct 2023 02:41:13 PDT
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D48121;
        Fri, 13 Oct 2023 02:41:12 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S6M2Q36gSz4xVbr;
        Fri, 13 Oct 2023 17:41:02 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 39D9esWV078823;
        Fri, 13 Oct 2023 17:40:54 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp07[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 13 Oct 2023 17:40:57 +0800 (CST)
Date:   Fri, 13 Oct 2023 17:40:57 +0800 (CST)
X-Zmail-TransId: 2b09652910a934b-6def0
X-Mailer: Zmail v1.0
Message-ID: <202310131740571821517@zte.com.cn>
In-Reply-To: <20231013-tyrannisieren-umfassen-0047ab6279aa@brauner>
References: 202310131527303451636@zte.com.cn,20231013-tyrannisieren-umfassen-0047ab6279aa@brauner
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <brauner@kernel.org>
Cc:     <viro@zeniv.linux.org.uk>, <djwong@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtSRkMgUEFUQ0hdIGZzOiBpbnRyb2R1Y2UgY2hlY2sgZm9yIGRyb3AvaW5jX25saW5r?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39D9esWV078823
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652910AE.000/4S6M2Q36gSz4xVbr
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 13, 2023 at 03:27:30PM +0800, cheng.lin130@zte.com.cn wrote:
> > From: Cheng Lin <cheng.lin130@zte.com.cn>
> >
> > Avoid inode nlink overflow or underflow.
> >
> > Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > ---
> I'm very confused. There's no explanation why that's needed. As it
> stands it's not possible to provide a useful review.
> I'm not saying it's wrong. I just don't understand why and even if this
> should please show up in the commit message.
In an xfs issue, there was an nlink underflow of a directory inode. There
is a key information in the kernel messages, that is the WARN_ON from
drop_nlink(). However, VFS did not prevent the underflow. I'm not sure
if this behavior is inadvertent or specifically designed. As an abnormal
situation, perhaps prohibiting nlink overflow or underflow is a better way
to handle it.
Request for your comment.
