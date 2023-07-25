Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD3761A23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjGYNi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjGYNiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:38:55 -0400
X-Greylist: delayed 96650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jul 2023 06:38:54 PDT
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43028B1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690292332;
        bh=AdfHt3Mj4blctd0g0eDARZn1RH+CByTruNyU6BaefNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eHPRp4ArdsmL7+CbDyT5EYJUA/FsY1EB0zTtz+uHBFxbJHDWBOT/VBl6WWWNsawyZ
         hR+XbxE0/bidXnLoT+4UdSu+IbiIFi8iA6hTsae9k1gLqwpQNxEcuUibKxloeZkr7Z
         k72jVdthnmkI5x80iV32yzFarqKcku4T4Nach8q0=
Received: from rtoax.. ([124.126.138.181])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 9B0A70F7; Tue, 25 Jul 2023 21:38:48 +0800
X-QQ-mid: xmsmtpt1690292328tl7kbwypm
Message-ID: <tencent_B02B6BED124665ED9563140A71C1004D0805@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6i501fQFuXPjAv5bioexygK3kaUoT7EBKjZlraf5185vqqQB0Bi
         BR82zgob0IMDs+KFNM1MyYCiKKj2ved7L4H8Mk3H/cZY2nE/jZDceBnlne3COcl6VcRWqQ0qahCl
         2Syh1CO8xwvE4jgS7zjFqrNrSlYeVcOlulkLl3/5FW8J45klOB43aXBG+/7CzgmSyH1FtYDrfjNk
         WPZZ5AymWSyUot76xJDXtcVVHTzedrXiZUgA6oH6QYz3SEou6HHV6sveu2iVR8xYMfey+AzidCWw
         UFLeYV3KZAjo0MJDJZIcqaII7cvu046f0TkQ8ihygds+BypSoLZehk+dBROCV9OCFwdHvt87TXyX
         aDMv5kmk+Yk4JQZd87mMUXMh1MlAyywZVk7io8YfhxI1ywfP3JcMYT9MYh2TMR69vS1rzudwwfi0
         7hsu74JRsnJ7KKz1afqc2k5fwmN9NVojzqRy7P5E+UoqXMDA4imM4jaZ9MGoED3OTXtd4jFFwmd8
         eP+XEawVvuqyJXDXvX5qWznRER1JSjU1mMl7CIhsNca2tLfLFPh0ge4Ew1lNCv0BDJtYt27IwLFo
         kMOSAxr2vb9KM3ZT1Xwc5sDs9olzNqH4WYsDxD+XzcsfdHBiPCRxKnCFsBWR7tmkUhNZ6gFKvCMo
         JpqiyBtimDNfX2SqjVgBbSZmhZWql3Etq0sHcsDXKf9vVXsw2RWnq+xXrpwa422g/gQ91m1c2Wu9
         Q1uSWf2mgDgrzH4H8MPbyit9y8iV93ZwwfI7GRNYfgP+jBjVX7VDR0L4mdC0Fd0EzMekzWRx6i8i
         iQDd5qnQ92HVOc7FaDvxacZrRuSxl0U8y/BiSPX/Ob6pVj++gxOGZ+vrVC81lzhzrFj9aTR75GQB
         eBFu02t52IqZ9hsqlQYTTqGQ0uMXI1+YIWISbSzthB022X6zlAx/Ssz539mx8OCavax+211yGlYe
         6k7J3APue2E4KnZ+mJCvVPZlfVB7j4Rb+DgKZrX6gejyNJQbzsQLDYSu4hcjT3
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Rong Tao <rtoax@foxmail.com>
To:     mcgrof@kernel.org
Cc:     ast@kernel.org, frederic@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, mhiramat@kernel.org,
        pmladek@suse.com, prasad@linux.vnet.ibm.com, qperret@google.com,
        rongtao@cestc.cn, rtoax@foxmail.com, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH] samples/hw_breakpoint: Fix kernel BUG 'invalid opcode: 0000'
Date:   Tue, 25 Jul 2023 21:38:48 +0800
X-OQ-MSGID: <20230725133848.3869-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZL7OJQBXBz1a3Sk3@bombadil.infradead.org>
References: <ZL7OJQBXBz1a3Sk3@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis

The 'kernel test robot' report an error [0]:

	>> samples/hw_breakpoint/data_breakpoint.c:73:2: error: call to undeclared function '__symbol_put'; 
	ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
	           __symbol_put(ksym_name);
	           ^
	   samples/hw_breakpoint/data_breakpoint.c:73:2: note: did you mean '__symbol_get'?
	   include/linux/module.h:301:7: note: '__symbol_get' declared here
	   void *__symbol_get(const char *symbol);
	         ^
	   1 error generated.

Do I need to do something? It seems that no changes need to be made from the
mainline code.

[0] https://lore.kernel.org/oe-kbuild-all/202307250926.06DQZjVe-lkp@intel.com/

Rong

