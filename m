Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE017F204E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjKTW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKTW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:28:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16A497
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:28:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A50C433C8;
        Mon, 20 Nov 2023 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700519317;
        bh=P7Ikg3vjIfBrorIC71X1iVZYfIZzCXg7zNTlT7wibWY=;
        h=From:To:Cc:Subject:Date:From;
        b=eH3HRIvSiAsR1b3Yhc+kCVy9spWUsvPgXogl0ZtH4NbppJqUWze8iOTz24pjvvCR1
         b8qHy+mmUpLg6FDB0tWZ7znkwxEzNP0nlc+BiVwwH0HnX+47OAkSA0/DkYGqUSKvcg
         XqHms7C69vF08+7M7oWd/MLP2zhGssBS1X7zvOgQsD3hqKySGTHTl5EfaeWK432E2d
         /K81NTYC1qFOqPBrJ0EMw6PTrXg0a6/lqZM6Rm+cVWiwgV7qeVwbbXKDnNxzndB2RH
         RToUK7TJp9ub5fUwhuUC/kusYgXpFRB6RW6kdfZ76g3o4BOR2x0+KDdbzU+WdyR2VA
         Mu8MV6oWyJbTg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/2] pinctrl: pinconf-generic: clean up pinconf_parse_dt_config()
Date:   Tue, 21 Nov 2023 07:28:30 +0900
Message-Id: <20231120222832.4063882-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Masahiro Yamada (2):
  pinctrl: pinconf-generic: resize the pin config array directly
  pinctrl: pinconf-generic: remove the special handling for no config
    case

 drivers/pinctrl/pinconf-generic.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

-- 
2.40.1

