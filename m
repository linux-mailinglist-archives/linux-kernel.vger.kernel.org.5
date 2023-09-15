Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBD7A2757
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjIOTol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbjIOToY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:44:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DED1FC9;
        Fri, 15 Sep 2023 12:44:18 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE421660297B;
        Fri, 15 Sep 2023 20:44:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694807056;
        bh=UfM/WY+yZp82kwRj0FLayuIAOI8JPsZwqB6MaXzG7lM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=boot5EGykAUi+bHQCndXM29YiNOme+TkKVg9opL1ziJiIcD217+cxxdSBX4RmfEzs
         gZkDqW0UVJ7B2UQ6ntqtpb5l8NemESngzepR9K+8kzM7aeNkzVOXebtE3ZUT04yaiz
         vgF9I8qQE1W+PqTwux7FsZ8o20F86kzmfdGYLmH4yeYNiIx3FOcx5b+YcrEAYC+FIu
         f6KSNLB40GiiSo4yf4TY7a2TvWIW7/Yrqy+v9XdI8xQSWNew8vxX3FV4BiphVSMg+v
         WC4N/xs35xdD/5EJTHIaFLidYtP3VT9S5vWJSuUTif9tvgpcIzolrTOANhcPdUNvek
         X/9V61/Wi/lgg==
Received: by mercury (Postfix, from userid 1000)
        id 7437E106044B; Fri, 15 Sep 2023 21:44:14 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
In-Reply-To: <20230915-power-of-v2-1-ca54c441867e@axis.com>
References: <20230915-power-of-v2-1-ca54c441867e@axis.com>
Subject: Re: [PATCH v2] power: supply: Propagate of_node to child device
Message-Id: <169480705445.566362.8727206650054420020.b4-ty@collabora.com>
Date:   Fri, 15 Sep 2023 21:44:14 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 09:02:14 +0200, Vincent Whitchurch wrote:
> Ensure that the dynamically created power supply device sets its
> ->of_node if the driver supplies one.  This brings it in line with
> several other subsystems (see git grep 'of_node =.*parent.*of_node') and
> allows easier identification of the device from udev rules and similar.
> 
> Before this patch:
> 
> [...]

Applied, thanks!

[1/1] power: supply: Propagate of_node to child device
      commit: 58e4aacb746321d8692996f40a1dcfb9e8b34c23

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

