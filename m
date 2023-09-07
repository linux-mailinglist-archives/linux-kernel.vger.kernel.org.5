Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B558797965
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbjIGRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbjIGRMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:12:39 -0400
Received: from mail.gnu-linux.rocks (unknown [82.165.184.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B1E199;
        Thu,  7 Sep 2023 10:12:11 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfa48.dynamic.kabel-deutschland.de [95.91.250.72])
        by mail.gnu-linux.rocks (Postfix) with ESMTPSA id 270EF3FED4;
        Thu,  7 Sep 2023 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnu-linux.rocks;
        s=mail; t=1694104889;
        bh=hbGgVV8ufhBZzB/y/KKKMs57iYcXQneWaC05xDLM3Zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOHwebvX6zsC3qWyz6ayYQwkHpVNBCghwdIbKTH2SA0vSsNylDEcSqNnFbrHYblO8
         IQXRFPeqYaF2gCWCvqxDy6gtO+0paxZNOK2wyMbhP92F07bIl3zZBPFDi17XrGKEz8
         dTHw2zKJOhQHgonsjR4wzNtEfm80bFeQWUb7fIAjpMMEXRrLAgSbTegYDqYMT6ZRBs
         8gMRNwLN9X0e65tfkdMPlKGFg/952Sjy1OCY32wUwC8f4AMwQf5IBXfrO4Qm3yHW/R
         9RBH+etlQ3RvvNwM4Zs/ne5qTDM7797d0jsPn3ANdG08yB3v69YT2RbD+ndRAOFoH0
         fQEVOYFtL86mg==
From:   Johannes Roith <johannes@gnu-linux.rocks>
To:     sergeantsagara@protonmail.com
Cc:     ak@it-klinger.de, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        jikos@kernel.org, johannes@gnu-linux.rocks,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v5] hid-mcp2200: added driver for GPIOs of MCP2200
Date:   Thu,  7 Sep 2023 18:41:21 +0200
Message-ID: <20230907164121.21092-1-johannes@gnu-linux.rocks>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <87ledpvhgm.fsf@protonmail.com>
References: <87ledpvhgm.fsf@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

thank you for the explanation, now I got it.

I have added hid_hw_stop and hid_hw_close to my remove function and removed the
devm_add_action_or_reset. The driver still worked well.

So, if it is okay for you, I would go this way and generate a new patch.


Best regards,
Johannes



