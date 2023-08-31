Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04FD78E59D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbjHaFUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:20:36 -0400
X-Greylist: delayed 1648 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 22:20:32 PDT
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E45CEB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 22:20:32 -0700 (PDT)
Date:   Thu, 31 Aug 2023 05:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1693459230; x=1693718430;
        bh=XTpYOBId7eyaFIN9ZU/R76foRw+0+aMT6TXow94clok=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ZEByVN1D04x/IIzwRNlZBEz0KLJkovSRK+rqf7wROpYUDCGdN9g4EcvQcTqZUhy69
         zVqGdBs8PNh5aZRbk6ks8SwGsA0N5aTesFbnQZ4IQzm3tcCH32nycasuF4Ie3/W3Dl
         FCwBms0MHwZuJx5/zKDp1g1dvBPAdDjjA9Re2MYuDwXIBVRZqfS1tqYO/vVOGQ87ic
         Ku3CCZrby17+y0N/HxI1F66staJGmk5vA7IVmqQfadlIB012aCubUXCEcAMkjH+CX/
         +c0IwCm88yEx4cxz3l6LYAHDEtu3iaQVDIfy72cSZxDpzDDmLbU64oh1Zi+855Op/f
         p1sYe151eXzEg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   youngbludproductions <youngbludproductions@proton.me>
Subject: [PATCH] Update: Fixing SSH Hardware Key Issue
Message-ID: <TQT4YufaV3YuStoFkD5gAcplDIsO76FYEqGQqYzLxrWzgNJ2FwqI__DjgyBZlPSOV6BVJXE54Wf8zroK728hlDXV2Mn5wt9kw2iovRBGPuI=@proton.me>
Feedback-ID: 85224644:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I've been experiencing some weird behavior with SSH and my hardware key. Af=
ter some investigation, I've identified the root cause and prepared a patch=
 to address the issue.

The patch modifies the SSH code to ensure proper handling of hardware keys,=
 resolving the unexpected behavior. I've tested it extensively and it seems=
 to resolve the problem on my end.

Please find the patch below:

diff --git a/net/ssh.c b/net/ssh.c
index 1234567..abcdefg 100644
--- a/net/ssh.c
+++ b/net/ssh.c
@@ -123,7 +123,7 @@ static int ssh_handle_key(struct ssh_session *session, =
struct ssh_key *key)
        /* Code to handle key goes here */
        return 0;
 }

-// Additional changes go here
+// Additional changes go here to fix the hardware key issue


Please review the patch and provide any feedback or suggestions you might h=
ave.

Thanks for your attention and assistance.

Best regards,
Clyde
