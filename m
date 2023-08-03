Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4D976E017
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHCGSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjHCGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:17:57 -0400
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 23:17:55 PDT
Received: from steel-ceridwen.relay-egress.a.mail.umich.edu (relay-egress-host.us-east-2.a.mail.umich.edu [18.216.144.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B060C9B;
        Wed,  2 Aug 2023 23:17:55 -0700 (PDT)
Received: from commutual-kasha.authn-relay.a.mail.umich.edu (ip-10-0-74-76.us-east-2.compute.internal [10.0.74.76])
        by steel-ceridwen.relay-egress.a.mail.umich.edu with ESMTPS
        id 64CB43B8.3759BB55.77A2AA2B.2951912;
        Thu, 03 Aug 2023 02:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2018-08-29; t=1691042739;
        bh=R7ingS6oT8zLA0eDC8Bu86VAmtRdJGw55fyBSnV0OEQ=;
        h=From:To:Cc:Subject:Date;
        b=cx0zCQ+F3/m54ilrxw9AQWcdBptnnQUDShlPWX+fRhbvYXJq/5Jl2d9uUWoyN/143
         r0ZwSzpsHe0WlWL89dqtgRYRdJjrMQSdoy3jFXtcEVQJrEFDLbuSW+4rI3wSSkhrgO
         TtNYiXDNFVRCIKGC00G8u7t8rXjWB08YS5McpwdYgRXWRsbFaqGWVcdAuXtv2Ui0lU
         F75HrM4jYGyT4Nr14p9y9/tCECybAou+YnDJZEyxK6lVZmd3f9bOyHq6HmnT1QcXnS
         NtxNyN7u+hMMLRHFyyEAGE22aa+SUpaEHBvh5rndpFGz8Tdke5I57GEDRZnY7A1U5E
         UD9C8QNyIdibA==
Authentication-Results: commutual-kasha.authn-relay.a.mail.umich.edu; 
        iprev=permerror policy.iprev=68.32.216.219 (unknown);
        auth=pass smtp.auth=tmgross
Received: from localhost.localdomain (unknown [68.32.216.219])
        by commutual-kasha.authn-relay.a.mail.umich.edu with ESMTPSA
        id 64CB43B2.276DEEB1.2290A92.2496870;
        Thu, 03 Aug 2023 02:05:39 -0400
From:   Trevor Gross <tmgross@umich.edu>
To:     ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com
Cc:     boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        benno.lossin@proton.me, corbet@lwn.net, yakoyoku@gmail.com,
        aliceryhl@google.com, tmgross@umich.edu, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] docs: rust: update instructions for obtaining 'core' source
Date:   Thu,  3 Aug 2023 02:04:35 -0400
Message-Id: <20230803060437.12157-1-tmgross@umich.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes the suggested method of obtaining Rust's source to using the
tarball rather than a full clone, and adds a clarification about 'rustup
override'.

v1: https://lore.kernel.org/rust-for-linux/CANiq72=L+_1OctE_fgeXfmzL2PCZmmMLW9i0GJZyCcf=B_=pRQ@mail.gmail.com/T/#me4f16f7383491549da9fe73a0274d8e7caacab0d

v1 -> v2:
- Added quotes as suggested by Alice [1]
- Reword commit messages as suggested by Miguel [2]

[1]: https://lore.kernel.org/rust-for-linux/20230720134428.3547917-1-aliceryhl@google.com/
[2]: https://lore.kernel.org/rust-for-linux/CANiq72=L+_1OctE_fgeXfmzL2PCZmmMLW9i0GJZyCcf=B_=pRQ@mail.gmail.com/#t

(Sorry for those who got this twice, I accidentally got the reviewers with
my test email.)

Trevor Gross (2):
  docs: rust: update instructions for obtaining 'core' source
  docs: rust: clarify what 'rustup override' does

 Documentation/rust/quick-start.rst | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.34.1
