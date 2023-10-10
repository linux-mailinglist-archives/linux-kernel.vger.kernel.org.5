Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB347BF2D6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442218AbjJJGRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442183AbjJJGRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:17:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9568E9D;
        Mon,  9 Oct 2023 23:17:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2197C433C8;
        Tue, 10 Oct 2023 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696918658;
        bh=h9CQdICcdTHsa/KeLMNYowXLwDNi+8QMgSiaxa80wo4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OaW38fiWbCpjKJ29idyZEI7/RIt1LUKvUgreoSf6oZilIa4q8T8h72Y+V0h7I37zM
         LLsP9YrEXsxMay67paITpYl/Ub626lejzaDLtfiy0NrlIVMxzmrKpO7KQwg4kICxov
         UH2l6a2EOaVI7wR37HfAy68QjwIpFmIDhE27dec2C4510HQm/W/AO6r1Ba3W7qZ2a1
         6RxxvBN+tn+EbaSorn/135go0Mtzq7ki+5YUal576uhp26B/MA9f1H5DkaZ7Tfrodn
         5VVUYPtL+XnINVnHuVA2ZU40yqp/oArel3qTXsTUYjhmECkAywYLSrio0UuuVwSCt0
         65KoGNTBklfGA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
References: <ZSRXXvWMMkm7qqRW@work> <202310091253.665A9C9@keescook>
        <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
        <202310091341.74A2D82BB@keescook>
Date:   Tue, 10 Oct 2023 09:17:34 +0300
In-Reply-To: <202310091341.74A2D82BB@keescook> (Kees Cook's message of "Mon, 9
        Oct 2023 13:42:12 -0700")
Message-ID: <877cnv57cx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

>> > Should this be considered a v2 of:
>> > https://lore.kernel.org/linux-hardening/94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com/
>> > 
>> > ?
>> 
>> Oops... sorry, I forgot I had reviewed this patch of yours.
>> 
>> > 
>> > Yours is more complete since it includes the struct_size() change...
>> > 
>> 
>> Should I resend this explicitly marking it as a v2?
>
> I defer to Kalle -- your Subject is more accurate, so perhaps let's just
> let this stand?

No need to resend. I marked Kees' version as Superseded so that I don't
accidentally take the wrong version.

In the title "wifi:" is missing but I can add that during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
