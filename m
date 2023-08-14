Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9F77B293
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHNHeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjHNHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E2610E2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:33:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C5962FD3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0E0C433CA;
        Mon, 14 Aug 2023 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691998424;
        bh=JkB+gn7TUvdkscEzzhGD4nxnOVfoiK8M/8pot+rQxjA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E0hQSBoIplR3tvqH4TwYJxKLt6RPldcik5v0ZG9kzTbkeDhac3ivVa56sE3p82Ay4
         0axYNLQeymiGFzoeZs+jgLSfnfsS7nzNW0yz/CpTZgLttZMwRUqGoAW5X+/x5mWYcN
         Ax12PAIkBFw2+pQDABejb1fxqmeHV73w8oz4nGe0zIctGU1xbazL+0mW/FO0w8FBhR
         QXvvZhSfUNpdOplOE7MDzVB2o0IGHjNoi2tnyvGJYhfGLMru57LqNp9gEwID47LOGE
         ThCBzOe03vxj1Tyn7NKtsmbUeMZ1AUrOocOH/AnGGrWHX4HSccyzIA/7agbGu16a9G
         YEUhwx0dXPUfg==
Message-ID: <bc5a1d8f-0630-9b4a-81db-6bf17cdb07e7@kernel.org>
Date:   Mon, 14 Aug 2023 09:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: arm: mediatek: convert audsys to yaml
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230810133602.48024-1-eugen.hristev@collabora.com>
 <20230810-syrup-matador-f00ec8ad381d@spud>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230810-syrup-matador-f00ec8ad381d@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 21:24, Conor Dooley wrote:
> On Thu, Aug 10, 2023 at 04:36:02PM +0300, Eugen Hristev wrote:
>> +  audio-controller:
>> +    #  $ref: /schemas/sound/mt2701-afe-pcm.yaml#
>> +    type: object
> 
> Other than this "informative" reference, which really feels like it
> should be a second patch in a series with this one, this looks good to
> me. You can add a
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> when the reference is a real one.


For the record - this wasn't tested, so even though patch was reviewed,
should not be applied till it is tested.

Best regards,
Krzysztof

