Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629579D882
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbjILSQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237204AbjILSQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:16:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A4115;
        Tue, 12 Sep 2023 11:16:39 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E803D66072BA;
        Tue, 12 Sep 2023 19:16:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694542598;
        bh=T4CTnt3171lkEG7tjYGi/cg2CuSvBVr1yDODyvXjNSg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jBbrMzWXfqW9mhE1VCw30jKHg0Sbl4nFivnCXyMBAJ3JYsb75qdQBXOcwns0O7XBY
         vz5RiTZrIiE+Q6R2AanpGx9PPvpIgE97eS0jWbfyiTWkmoCWrTfLCn6EuSB3CiBoXj
         8YRaegFE5h+6WfwZjLCnm470iCS5JmH76YN9MeRJ9s4JjE4RTtHAoxEvoZ3eHueolc
         R8smmoddGXin0Y8mMcAR91XZ1j1UibDRQFGQNK5e43wpHiGg1ZCJU+D1P6XLHFa6yA
         M9i9LOE/xHQH6c/Wv/qjC70Q7rKjXGq5noS4EwtYcrkW3Vge6RBuAHIMYOnky4cbPh
         gXjn0mmR9PZjg==
Received: by mercury (Postfix, from userid 1000)
        id 90B5C106098A; Tue, 12 Sep 2023 20:16:34 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     sre@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bmasney@redhat.com
In-Reply-To: <20230817214218.638846-1-ahalaney@redhat.com>
References: <20230817214218.638846-1-ahalaney@redhat.com>
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: quiet some device
 deferrals
Message-Id: <169454259457.484856.798048052041147110.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 20:16:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Aug 2023 16:41:57 -0500, Andrew Halaney wrote:
> Some errors are being logged that are really due to deferrals,
> which is confusing to users. Use dev_err_probe() to handle when to log
> at error level versus debug. This also has the added bonuses of logging
> to devices_deferred and printing the error value.
> 
> 

Applied, thanks!

[1/1] power: reset: nvmem-reboot-mode: quiet some device deferrals
      commit: 8e511f42ac9cdab84c692bcd0f9e0c55c75b1856

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

