Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F47E8B86
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 17:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjKKQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 11:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjKKQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 11:12:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8821BEA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 08:12:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A4C433C7;
        Sat, 11 Nov 2023 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699719150;
        bh=M4cgVMDKzhYpBMH/LUO/PfNZ4j2b9ExabWjMZLqhdjs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MF5gdkzUKg0jbq0Yf0rvdUbqLntJ0gulxA/HkQ7fkQz9WAvwzLTfXIfcRASGjtC9h
         dUJMMgrxrXlp2Fy7jsnUP59X41WffIWU0wCTSfdKp56Xyr3I9VMgWOd+Kfeo47bkcJ
         DgNTQx8orJHsAqIm8lqvOy/6gKdwO0eRmzz132JyxWYMRiWoggMfEVkOYPFTPTvEp3
         IhlG3bNd68Ib84h7PZMq+0jsqohHcx7E4yZr1IEQG57NlNeuACWljIXbtKMzg1Rqej
         21BBS0U96wkJxhsSSUZHV7AHiiz8FIX2em2iFLcj5KaFM3QD4MHDTD7FTqxnvLisTV
         IC4o7l02D7XQQ==
Message-ID: <deb2c0f5-3e5e-4136-bc80-eac8bfef9228@kernel.org>
Date:   Sat, 11 Nov 2023 18:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
References: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <7a4e5c5b-e397-479b-b1cb-4b50da248f21@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 18:13, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove, just also taking care for NULL'ing the
> iep pointers.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
