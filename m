Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720A77C495
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjHOAn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjHOAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:43:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E1DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:43:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9580D61FA9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1138C433C8;
        Tue, 15 Aug 2023 00:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060187;
        bh=CAc6ccKaUu5JgeNO7cRAaq04afyml8lpGLAg7ZKwFNQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WCiwDLunB25fBtAq6vETjoBeU4EhoEm9Pu0agaDP71anN6hSFajZor/453kadkoOj
         ItKLP0GTFzrd2zCQb+7EMqIpOLlgK6uUtQolINsZIbUt2bWWMZJyHxke2QKzhSgqOS
         llwIclOzxW+GjS3UB2H8X4ET7y/iaUh5BnA9GHB1W00EeXxCM8n+1TcfaqAuEYYSCv
         UkD6Zbc8e/kfy+Sgn7r+jAtqj2n3th7semC4GPNC7gHwvAxSfSUtcfAKpMDDzIQzay
         v46Vb/pXmDJLFp5vmAL/hU70ynOXqEIEVRvhJDSYM1cyQmdLbmpx6HXneGu0aGi/di
         Bru3DIMedoGsQ==
Message-ID: <affd02d0-f0e0-cf09-7825-94c2bcc1f896@kernel.org>
Date:   Mon, 14 Aug 2023 17:43:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARC: -Wmissing-prototype warning fixes
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <20230813191655.474577-1-vgupta@kernel.org>
 <961b0945-f783-4a0e-a108-4549ec702d22@app.fastmail.com>
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <961b0945-f783-4a0e-a108-4549ec702d22@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/23 12:18, Arnd Bergmann wrote:
> On Sun, Aug 13, 2023, at 21:16, Vineet Gupta wrote:
>> Anrd reported [1] new compiler warnings due to -Wmissing-protype.
>> These are for non static functions mostly used in asm code hence not
>> exported already. Fix this by adding the prototypes.
>>
>> [1] https://lore.kernel.org/lkml/20230810141947.1236730-1-arnd@kernel.org
>>
>> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> Looks good to me,
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thx, Arnd.

Added to for-curr.

-Vineet
