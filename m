Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29297B6AC6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjJCNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjJCNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:42:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F92EA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:42:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F7AC433C7;
        Tue,  3 Oct 2023 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696340539;
        bh=HvH1Q1z92W9hdqkCNnVvSV1dvkn66o/wVbN4IpbbyWo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=grYxISXlNYov8M8r0twN1gillga5LQqMIC24ujlJP/o8k/u0/3PpkWscYWy4n4AEK
         PsK3V+Cd46gw2XaSa9kOWFdHRop1w9xqBpaSBSQ5V1aZ8BGeX//N48ROpmy4mm7ic5
         0qM0lbJoGLqG5je2PqIQRNaXeuUOd36yALjX5obugnCRK+U3xU9DwZA1StdtEtC3US
         SegqiqX/LaBsRtxX68KlsDlKrRkSRKFhBwOvTI5oqDCYLe/ISNZrzrmMJxbp9k+94F
         jVwurMYMNfLAzBAjr6bD8nGpsYiUj9RAkSs/LuDIF7mZAHwwqMfwAENFh0D3lEESpj
         lQ5IY7xOndrOA==
Date:   Tue, 3 Oct 2023 06:42:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Woojung Huh <woojung.huh@microchip.com>,
        Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20231003064213.4886626f@kernel.org>
In-Reply-To: <20231003145106.3cd5a19f@wsk>
References: <20230922133108.2090612-1-lukma@denx.de>
        <20230926225401.bganxwmtrgkiz2di@skbuf>
        <20230928124127.379115e6@wsk>
        <20231003095832.4bec4c72@wsk>
        <20231003104410.dhngn3vvdfdcurga@skbuf>
        <20231003145106.3cd5a19f@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 14:51:06 +0200 Lukasz Majewski wrote:
> I've just noticed that there is a WARNING:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230922133108.2090612-6-lukma@denx.de/
> 
> but then on the newest kernel checkpatch.pl is silent:
> ./scripts/checkpatch.pl
> 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch total: 0
> errors, 0 warnings, 0 checks, 277 lines checked
> 
> 0005-net-dsa-microchip-Enable-HSR-offloading-for-KSZ9477.patch has no
> obvious style problems and is ready for submission.
> 
> Does the checkpatch for patchwork differs in any way from mainline?

We run:

checkpatch with --strict --max-line-length=80

https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh

The "multiple new lines" warning on patch 2 looks legit, no?
