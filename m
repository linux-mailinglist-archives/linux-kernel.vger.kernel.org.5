Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45B7E24EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKFN0o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 08:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjKFN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:26:39 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C9112
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:26:33 -0800 (PST)
X-UUID: 68c1e78aac2d4c9eae9324cf631b5914-20231106
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3237dc1b-63d0-413f-8adf-db743d8e797b,IP:10,
        URL:0,TC:0,Content:10,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:15
X-CID-INFO: VERSION:1.1.32,REQID:3237dc1b-63d0-413f-8adf-db743d8e797b,IP:10,UR
        L:0,TC:0,Content:10,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:15
X-CID-META: VersionHash:5f78ec9,CLOUDID:179d35fc-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231106212621OQUAH2A4,BulkQuantity:0,Recheck:0,SF:66|23|17|19|43|64|1
        02,TC:nil,Content:4,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 68c1e78aac2d4c9eae9324cf631b5914-20231106
X-User: oushixiong@kylinos.cn
Received: from laptopjrnhc6sg [(222.247.111.235)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 288226259; Mon, 06 Nov 2023 21:26:20 +0800
From:   <oushixiong@kylinos.cn>
To:     "'Maxime Ripard'" <mripard@kernel.org>
Cc:     "'Maarten Lankhorst'" <maarten.lankhorst@linux.intel.com>,
        "'Thomas Zimmermann'" <tzimmermann@suse.de>,
        "'David Airlie'" <airlied@gmail.com>,
        "'Daniel Vetter'" <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20231106073742.158905-1-oushixiong@kylinos.cn> <6yqalig6nvnlpt7loetugjdgp5z4w3qwhpqpzzsygffp5w32d6@guq6v3g2z7tq>
In-Reply-To: <6yqalig6nvnlpt7loetugjdgp5z4w3qwhpqpzzsygffp5w32d6@guq6v3g2z7tq>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBkcm0vYXRvbWljLWhlbHBlcjogQ2FsbCBzdA==?=
        =?gb2312?B?YWxsX2NoZWNrcygpIGJlZm9yZSBhbGxvY2F0ZSBkcm1fY3J0Y19jb21taXQ=?=
Date:   Mon, 6 Nov 2023 21:26:15 +0800
Message-ID: <000301da10b4$d4e90690$7ebb13b0$@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFcR3YQO3CUUdc1Zt+jjVoM53ycrQINT5JbsVhur6A=
Content-Language: zh-cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  
I think it will cause memory leaks if too many nonblock commit works return
-EBUSY.
You can try to send large number of nonblock commits by
drmModeAtomicCommit().

-----邮件原件-----
发件人: Maxime Ripard <mripard@kernel.org> 
发送时间: 2023年11月6日 18:33
收件人: oushixiong <oushixiong@kylinos.cn>
抄送: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>; Thomas
Zimmermann <tzimmermann@suse.de>; David Airlie <airlied@gmail.com>; Daniel
Vetter <daniel@ffwll.ch>; dri-devel@lists.freedesktop.org;
linux-kernel@vger.kernel.org
主题: Re: [PATCH] drm/atomic-helper: Call stall_checks() before allocate
drm_crtc_commit

Hi,

On Mon, Nov 06, 2023 at 03:37:42PM +0800, oushixiong wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> Calling stall_checks() before allocating drm_crtc_commit not after that.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Generally speaking, we need much more context than that.

What bug did you encounter that makes you say that it should be moved?
How can we reproduce it? How long has that issue been in the code? What
makes you say that this is the right solution?

Maxime

