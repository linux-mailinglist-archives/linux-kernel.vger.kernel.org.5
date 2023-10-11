Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F21D7C4AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345864AbjJKGvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344090AbjJKGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:51:43 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E29AF;
        Tue, 10 Oct 2023 23:51:40 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S53Mq49k3z4xPG7;
        Wed, 11 Oct 2023 14:51:35 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 39B6pSWG050437;
        Wed, 11 Oct 2023 14:51:28 +0800 (+08)
        (envelope-from cheng.lin130@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 11 Oct 2023 14:51:30 +0800 (CST)
Date:   Wed, 11 Oct 2023 14:51:30 +0800 (CST)
X-Zmail-TransId: 2b07652645f262b-b1bce
X-Mailer: Zmail v1.0
Message-ID: <202310111451303518442@zte.com.cn>
In-Reply-To: <ZST117zXotVPXGEQ@infradead.org>
References: 202310101009011817522@zte.com.cn,ZST117zXotVPXGEQ@infradead.org
Mime-Version: 1.0
From:   <cheng.lin130@zte.com.cn>
To:     <hch@infradead.org>
Cc:     <david@fromorbit.com>, <djwong@kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.yong5@zte.com.cn>, <wang.liang82@zte.com.cn>,
        <liu.dong3@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2Nl0geGZzOiBpbnRyb2R1Y2UgcHJvdGVjdGlvbiBmb3IgZHJvcCBubGluaw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 39B6pSWG050437
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 652645F7.000/4S53Mq49k3z4xPG7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Oct 10, 2023 at 10:09:01AM +0800, cheng.lin130@zte.com.cn wrote:
> > From: Cheng Lin <cheng.lin130@zte.com.cn>
> > 
> > When abnormal drop_nlink are detected on the inode,
> > return error, to avoid corruption propagation.
> I know this has been through a few cycles, but wouldn't it be useful
> to have at least a little description here how that case could happen?
Unfortunately, I don't know how the underflow happened. The purpose
of this patch is to prevent the situation from getting worse and provide
users can repair it at the appropriate moment afterwards.
