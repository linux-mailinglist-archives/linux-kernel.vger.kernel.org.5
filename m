Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6357685A2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjG3NeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG3NeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 09:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83071170D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 06:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2147E60C80
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D7EC433C9;
        Sun, 30 Jul 2023 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690724037;
        bh=lwVGJ9+3Te0pa2QRIC66+V0cTNt3FbPt7biwJ3NXE+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3wNhH/1RwNVYMYns+qb7Gfp7d2vvMXRpiJkSV1FROj4NYWSCKWAALlDfcPTziE/5
         h5ZL/piJE+cMeo5EhzaUJJ4IUO/OC7dJnTOvIaLrgwN1SihGCmz6OFbmitx9cWaaeN
         GIzbkCqqFb3vHhBI/S5su6wrOl0soxxGW7TQepYBjOpvTKoWsKxKz7jwbztH+Fr0F9
         cclfy18JUnfX2u9d0FAYJD8fqyhno2SkzXS9Qc4Mr1ABZ5hRVMUU6jAiVaVVaGDG7K
         pCGOi14OW0lxeOFAPKUAuxX9+bMIGw/bgfcLt19kmS1g+yhRMBCkRr7ZnnlqGchY3h
         58WeETZ5Om1XA==
Date:   Sun, 30 Jul 2023 16:33:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] xfrm: Remove unused function declarations
Message-ID: <20230730133353.GH94048@unreal>
References: <20230729122858.25776-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122858.25776-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:28:58PM +0800, Yue Haibing wrote:
> commit a269fbfc4e9f ("xfrm: state: remove extract_input indirection from xfrm_state_afinfo")
> left behind this.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/xfrm.h | 2 --
>  1 file changed, 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
