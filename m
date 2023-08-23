Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B161785BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjHWPUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbjHWPUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A473E1729
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5D6664A0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7090C433C9;
        Wed, 23 Aug 2023 15:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692803965;
        bh=yPk7RE7fDmhbTm/h73JvDxMeMa0VQPtvf24eDg4FV3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e3ho5g1YIyt6qPaUI0s/EofNbLKeoOCvt0z5Swobylz4Em9VZ2re73wmGxjU7xwTT
         GJZCIuUq8IDKoMrn35U1W5jgA8BpQQdOxHK07wGnT+xvUK4h0CsVWv/nHbMIUsYF/b
         Zy4dumevm791MsQLDUCiIrSOxN1cwg2/+c7i12JMZiMs0HRJKTzfZFdx1nFiYeiJ0v
         X13wYPfMY9tdkdOOyo1uceN3o+Zbet78ot1VH/tBLybE+yLdZTctr+rVCHOx6mz6lc
         EcKRFz0msxb+UUmEyL4/WhYwyoZJm9Ho1ZhjEvei8I3+MZ0xkNyvwkqc6JOebmG1ZN
         fWSa3o9H0UwKQ==
Message-ID: <2f1bb2f9-b383-cd9e-f351-1428366974e0@kernel.org>
Date:   Wed, 23 Aug 2023 23:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] erofs: drop z_erofs_page_mark_eio()
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
 <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230817082813.81180-5-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/17 16:28, Gao Xiang wrote:
> It can be folded into z_erofs_onlinepage_endio() to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
