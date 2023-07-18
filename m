Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9370B7574C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGRG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGRG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:58:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52D11731
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:58:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5322843f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689663514; x=1692255514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkR8qqb+tZbWWWMSMobDqmb6wWe0/8Tvk+eaJzSaNiY=;
        b=oQzkecp3eDrjKFOrzKgXnZOg5cpVEKRypTPCPmhh/sLLfK0W13xCZzcM/VI70jJFPl
         Fwa3S8NdvFQKkGQYWJAMR1zHFP5Ysl/ufyEJWlJfgVXFX+JVtc8QPkUM7g/l2DRLV0Xd
         rXUYg0ZzVPn/Its3B26G9Rh31SHyyUykKmfeL19t3QK1qBu011h7v3SY91KLqbfBHfPn
         0Vqo0UVhfKmcNde+/yF0AkJzsJTSB75UxChR9fXOS5ItLfBPwN0Ko79me9Esy27HwssM
         Dyobl8S5JWavMrJgqDtPD9FWeR5bs99rsyeUMNa7SakXrucf4MB9NCgQ6ubHIvXoLpjy
         NWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689663514; x=1692255514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkR8qqb+tZbWWWMSMobDqmb6wWe0/8Tvk+eaJzSaNiY=;
        b=OOy2KiNP3zCLYeRQK+pOPNOwZxLon4AjX81wcQZ2nyRfum9Ux8TmRrPO68ep5cklht
         zdJwqrn60w3cRF0eIWcbwb6vKTqxV+VHui6jZFSK3S7p7jupEC4DUoZEp423J/p9XVk/
         GvsQK3v32qLu7JNn4fzdr8ZPkd5tlzQPWUsuFvXV3IL82iAJAFTnTJOR78Dwj2KUvbzk
         v1cRhqHzlTXdPMhcrVKj5XHq7zXN9wE//NNymuKDYnJHXMrjZ5788osobt0I1muY8azY
         d0arKZbTXWAn0PH2XHB2ay2QwogruW5BSJExQGViI+95IP9uKQN8MrVdnYy+owFh9onE
         1mhQ==
X-Gm-Message-State: ABy/qLbc1ECjlpEVFmTjC2nhrnUrKDFZD17LjmFFIhHD5hbfgXZ1DHRs
        CMU6LzcbZYoKOkVq6Q7w0TmzaA==
X-Google-Smtp-Source: APBJJlED6jt8xHaJu7Q+cJhP4iZsf33uSnbrn3oqSpD8pTr55ZYfnUl37FR46MpOM2b5hdLAdZh5/Q==
X-Received: by 2002:a5d:4b07:0:b0:315:930a:a962 with SMTP id v7-20020a5d4b07000000b00315930aa962mr14378852wrq.59.1689663514061;
        Mon, 17 Jul 2023 23:58:34 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r15-20020adff10f000000b0031437299fafsm1449736wro.34.2023.07.17.23.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:58:31 -0700 (PDT)
Date:   Tue, 18 Jul 2023 09:58:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: mediatek: vcodec: Fix an error handling path in
 vdec_msg_queue_init()
Message-ID: <1dcd0fab-eee3-4693-a7d2-4a72baef5c97@kadam.mountain>
References: <efa0d4910998931a2ec9d933117fa71482d7b33a.1689624542.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa0d4910998931a2ec9d933117fa71482d7b33a.1689624542.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:09:19PM +0200, Christophe JAILLET wrote:
> All errors go to the error handling path, except this one. Be consistent
> and also branch to it.
> 
> Fixes: 2f5d0aef37c6 ("media: mediatek: vcodec: support stateless AV1 decoder")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

I sent this one a month ago but it hasn't been applied.

https://lore.kernel.org/all/b8948d9a-65bc-4f3f-aa90-60addd064819@moroto.mountain/

regards,
dan carpenter

