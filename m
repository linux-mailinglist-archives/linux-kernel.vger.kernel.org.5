Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE117A334C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjIPWzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjIPWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:55:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92791180;
        Sat, 16 Sep 2023 15:55:21 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D4EA66072F0;
        Sat, 16 Sep 2023 23:55:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694904920;
        bh=rym7i+/bnLUNecF557f+naHud8wV85aJyNjDGIFeFn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RBAEVvv0Xq41xuc/xCrQvZ0mLaogEc3VjcFEXPwA7fXU7z4OaDz371ESoi+CdDlWI
         3J/6U63EaIgHZSkd0pKu3BZfdnhkYo2pY9W0k11NhEMQ4Az8t8/eNgUwAxytxfK7Tg
         ajBaUXtbcfQxAhTHewL9bvekvivh8gGV29ZrDkO6KLInd//pA1Oqv5ZBx678Rd2Pcn
         gR6szFcv58QjHVwn8K/CU6+ViStyFrc09OTpsB358+urzDQQhv6YGm3UlJPQ+xy0Ux
         EnCOKWj8XUiaZQc/QnvF2vk4pRFCN7cTaF72dMA5BXFkppTJphn+Z7fGYNmMeOeESV
         EZm4kC6jOkjng==
Received: by mercury (Postfix, from userid 1000)
        id DA6541060450; Sun, 17 Sep 2023 00:55:17 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230913133900.591637-1-sebastian.reichel@collabora.com>
References: <20230913133900.591637-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: supply: core: Don't export
 power_supply_notifier
Message-Id: <169490491787.915550.2039949073405607589.b4-ty@collabora.com>
Date:   Sun, 17 Sep 2023 00:55:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Sep 2023 15:39:00 +0200, Sebastian Reichel wrote:
> power_supply_notifier can be internal, since all users are going
> through power_supply_reg_notifier()/power_supply_unreg_notifier().
> 
> 

Applied, thanks!

[1/1] power: supply: core: Don't export power_supply_notifier
      commit: 12e94aee074ce1c5ffdb8f2246a8c4a095b6aa8a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

