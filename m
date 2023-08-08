Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED615773EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHHQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjHHQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:37:44 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779D414FC7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:53:37 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b70357ca12so19796311fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509972; x=1692114772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IE+cQYrLbzbuiiR055HvYGpi3UVMCeFENxlo5dC5k5w=;
        b=cj1bwQ0m0F5hDbKOn0WSJqw4p69i6VNjUil2uL9BzvHbxvrZ87P+XBESeyLZXtXcYQ
         +bB6mAqNbljn/VEHN/Zxz90zi7goN8R8q7+Sr6U1tHiX8VCGxpXN4Nc2tQS2d7yLtxo1
         W4JhSH1/QwpWhLnJsWIhSowjSmwmAqYk/DkPR5Tot7E5TdRZ2InTLDU/T5faAzATsTVD
         CpKhxVbHUnQbAI3b6b1eh0UlKLqfZbtMaa9aXyb6p2YDCwdR68XSP3Br5bgSm0w1oDQN
         vhkIbtG4j7Hpe/P16zOwZvKMg6vGZoRriurnRgD26IlXHke0a4DTA6ZY3DCj2DIeEd1l
         61hg==
X-Gm-Message-State: ABy/qLadklrETGFbNBpJQfEFhl8+DmOzpadeYLrpuTYLpjDxr8h48RoJ
        mXoBc+dsPySa51AwwMgigNGu/R3nx98=
X-Google-Smtp-Source: APBJJlG4LDvxeTCVtTRK5ag4k0ARoHjKSEheRUpF87XGkzeWpDSuk6i1u1K5hwjweUKyMIwTiJ12Xg==
X-Received: by 2002:a17:906:519d:b0:99b:d682:f306 with SMTP id y29-20020a170906519d00b0099bd682f306mr20659333ejk.4.1691484435936;
        Tue, 08 Aug 2023 01:47:15 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ot29-20020a170906ccdd00b00991d54db2acsm6298299ejb.44.2023.08.08.01.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:47:15 -0700 (PDT)
Message-ID: <e33c1a36-2b8e-8331-5f36-54dc47ab02d1@grimberg.me>
Date:   Tue, 8 Aug 2023 11:47:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme v2 2/2] fabrics: Do not pass disable_sqflow if not
 supported
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Caleb Sander <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
References: <20230808070907.18834-1-dwagner@suse.de>
 <20230808070907.18834-3-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808070907.18834-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Only retry a connect attempt with disable_sqflow if the kernel
> actually supports this option.
> 
> Reported-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   src/nvme/fabrics.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 9725eeb3cda8..f0e85d3b766d 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -1043,7 +1043,8 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
>   	if (!ret)
>   		return c;
>   
> -	if (errno == EINVAL && c->cfg.disable_sqflow) {
> +	if (errno == EINVAL && c->cfg.disable_sqflow &&
> +	    nvmf_check_option(h->r, disable_sqflow)) {
>   		errno = 0;
>   		/* disable_sqflow is unrecognized option on older kernels */
>   		nvme_msg(h->r, LOG_INFO, "failed to connect controller, "

I think you want to check this before the initial call
and avoid the retry altogether.
--
-       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
+           nvmf_check_option(h->r, disable_sqflow))
                 c->cfg.disable_sqflow = true;
+       else
+               c->cfg.disable_sqflow = false;

         if (e->trtype == NVMF_TRTYPE_TCP &&
             (e->treq & NVMF_TREQ_REQUIRED ||
--
