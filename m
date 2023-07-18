Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EDF757382
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjGRGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjGRGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:01:38 -0400
X-Greylist: delayed 806 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 23:01:37 PDT
Received: from germane-culhwch.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.217.159.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A86D1;
        Mon, 17 Jul 2023 23:01:37 -0700 (PDT)
Received: from jacinth-ogre.authn-relay.a.mail.umich.edu (ip-10-0-74-216.us-east-2.compute.internal [10.0.74.216])
        by germane-culhwch.relay-egress.a.mail.umich.edu with ESMTPS
        id 64B62710.358527D2.3204439.1115262;
        Tue, 18 Jul 2023 01:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1689659147;
        bh=2WcBa6hvCUyIKLeQ3dqyKpup6xZvM3u4Au4ese4aI+A=;
        h=From:To:Cc:Subject:Date;
        b=DvK9+w97ouHhFh0Lp3TMcQyJqjlrG+0wg7cC3kCDsgCUUfEcS3m1JRJGivZ+mTb55
         fiXPY+7yG9eX2o81OhnZ1procAQKujr8tdVYCC5fTsLDqWGK2qHfYg1Au0Kw5Th7bk
         h88fBEt/QTNy25mCYaMXAgjuzKO+HMFgtv2JUIg73wj9Zq5lGfNFi6XYK1swB9L6l1
         oNIyMMDfFLn4vpUpOy5FEF9iWcGLT7DupLd5TQ/JKUlJDG/ugwTYiPVVAMv5ObcKlr
         qmNlVeq7bHGY8VXKMb/fi1XjmND+v8AY0+uqx8bJKPenO0XboxXAjSXmo/7ZVMSH5v
         XzwMFkVhLaIPw==
Authentication-Results: jacinth-ogre.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by jacinth-ogre.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64B6270A.2B56E19C.5B587AC6.46279;
        Tue, 18 Jul 2023 01:45:47 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>
Subject: [PATCH 0/2] docs: rust: update instructions on obtaining 'core' source
Date:   Tue, 18 Jul 2023 01:44:14 -0400
Message-Id: <20230718054416.861412-1-tmgross@umich.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the suggested method of obtaining Rust's source to using the
tarball rather than a full clone, and adds a clarification about 'rustup
override'.

Trevor Gross (2):
  docs: rust: update instructions for obtaining 'core' source
  docs: rust: clarify what 'rustup override' does

 Documentation/rust/quick-start.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1

