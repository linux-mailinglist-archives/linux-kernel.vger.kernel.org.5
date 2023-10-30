Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0CD7DC267
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjJ3WY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJ3WYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:24:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD606C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 15:24:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9ACC433C7;
        Mon, 30 Oct 2023 22:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698704663;
        bh=MR+1/oYTaYE15KLl3mC85XVqFKu26po+e+b4d/I/rYc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=i4KH8yztodQMMJp8IT60QoawA7fxEjiSlmRC/Qg/h2UbFccmW+6qLsbMfL8LQwHXo
         FZB76EzoMcvBjWswqQUedtsTtjbEFycEsZrC6ovOGLvRkOlthnIj57EXQAbQY4Pb9O
         9M11+Cd+Ow+9QvunvI8w8nYRTW2ea6cv2wbbMWtLryNLLPGrIfCQUcuv7xhLrmPRPs
         rdgxZDkV1R9qGZC9tQMo/cdF/7uD8x5EYWB7v8glRYtIj3N4uj1Hvh7TEIAq8/1obE
         R+OE+mHHIgjW8tdFjidOtl12PvfycjBjolvIrFoTkayKNGRU91Cv6Idc7ji8gm3vEz
         F30h0EzWFgjzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1AE80CE0BDD; Mon, 30 Oct 2023 15:24:23 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:24:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joel@joelfernandes.or
Subject: [GIT PULL] LKMM changes for v6.7
Message-ID: <34c6ec4d-84f9-4009-96a5-98e5d3ff6dba@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linux,

Please pull this LKMM update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2023.10.28a

  # HEAD: 1566bf4b13daa66e3de6fdbc77ee3995df5a9064: docs: memory-barriers: Add note on compiler transformation and address deps (2023-10-09 09:40:53 -0700)

----------------------------------------------------------------
LKMM updates for v6.7

This update adds paragraphs to the portions of memory-barriers.txt that
have been marked historical due to changes in the way that the Linux
kernel handles DEC Alpha.  These paragraphs includes information on
where to find the corresponding up-to-date information.

----------------------------------------------------------------
Joel Fernandes (Google) (1):
      docs: memory-barriers: Add note on compiler transformation and address deps

 Documentation/memory-barriers.txt | 7 +++++++
 1 file changed, 7 insertions(+)
