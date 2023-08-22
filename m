Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3191B78463C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbjHVPvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbjHVPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D02E52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60E8E62063
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 15:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A91BC433C8;
        Tue, 22 Aug 2023 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692719441;
        bh=IfJrA5Tn6w+vdt3XiqV2QN8XMtDbKOAYVmHZEZoc+rM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QA2lKo6W9gA4d98IcqZP/tE7frMp4yPwC8NMYmRoOcf+Zej7PBZG46kDNrpFF2e+G
         5LWEq2SvoJ0ZZCZx3br2U3dIlHNVuHwKzaFJZX9S+GkRfrgqG+kj2kDYmEk5OiwTIL
         GkcF+HfArDPTzicJYD0wrdqTE14/Vy/uYcPIA/S8bbtZP4Xa0fqB4j/nB85UxdrjGd
         qbzbrLxcU2Ar2k0fwccBKw/KE6R5aTY4+1BBiXg2EDHqv3HPXR6entLtNQ84+Gzvk5
         QoxKNP9njeKQ9y9aTT9WxpG9oxV7MEotdGgHFOqXp7QN6iBhwZS6grozacYa/B/Em/
         2lulzhNJtQ3Qw==
Date:   Tue, 22 Aug 2023 09:50:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] nvme: host: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <ZOTZT3aWUfuSdXeQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820092139.45029-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for nvme-6.6.
