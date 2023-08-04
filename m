Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731CF76FF2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHDLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHDLCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:02:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50F10CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:02:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-521caf0d7a6so558819a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691146945; x=1691751745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUD5hbyWC5PVi2AdsMEc5JXjXGKjisxD+lMbwsoTETQ=;
        b=jXtQMM3lrs2JcbJJZ/enJk0VMeiygqg9X8KuObw0dNSguygt04qJK4sOmydM99sTq2
         F+dDbviCNik6VMWtsgtnb/OgAXew8VtA5DGGmCF1iXWWrkvJCEjNsP4AT1eQzuGovQDs
         kiSJhzDaK8wi0sJYJWGzZTPWZZ1RpLpGL6GBJQzpis+bL83Hm7D9jU4lz7M9FJ/OBYri
         hOcT/EUTikzoGPFkGhaVB1NFteb+iI2ELH7JxDEC8FW8sSV3Uxp+XlvE1MPVjl2rQ5xi
         wXk6zfI1YFFmTL5yC07MB0xydIqFGL8wC/vby3QNa7ycajvoIg3k/+9kBoTkuBWRiU5E
         HAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691146945; x=1691751745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUD5hbyWC5PVi2AdsMEc5JXjXGKjisxD+lMbwsoTETQ=;
        b=EwScpNGNup2t+wpQ/YndH1EqaAyN2YAvYEONxBG53o7yM5MxFJlUnTmSn4WT2unaWv
         yET3bcM+jPp40pWRCDyMOjyIX/ebbx5+bDtcTGEOal0kbgBWPQ7Pnmub1aDJ4PKNhu/v
         q1jcXG1SqTUfGuUjJTFsiTS/AA/+O6SgheOpwhqch+f/YXBJya0ukRL8+ifIW/7ZrXvF
         Hdx7Zq1WFR6fvNcZhs/RL7fHvA88ZEzApy18BXW9dLAPokZy4CDKJXL6ui5YTSSNh+F5
         QkQ9oJCHw0VvU4saxWLv75nwIxA3m3dwrJTSLK5d4nsLyiPUynPQlHPMMqpzWKT/OdIG
         OacQ==
X-Gm-Message-State: ABy/qLbjvGY/3WM5tlT/ygnQN+NlE1EhEnUvvOc6qHnVlZeXdVwt44bv
        NeSputduajUhDgL11Lzq4AbePmud4KdKIo8U
X-Google-Smtp-Source: APBJJlHc21FOa2c9RfVnuxEJguBDZ7h3LdPtKK/KVBHSIFLbmu3wERDXVFZgqZ7+UQ6eU2hAOuBS+Q==
X-Received: by 2002:a05:6402:2813:b0:514:971b:7f36 with SMTP id h19-20020a056402281300b00514971b7f36mr19962598ede.3.1691146944940;
        Fri, 04 Aug 2023 04:02:24 -0700 (PDT)
Received: from [10.10.19.213] ([178.160.196.94])
        by smtp.gmail.com with ESMTPSA id z22-20020aa7c656000000b0052302c27de2sm1087680edr.10.2023.08.04.04.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 04:02:24 -0700 (PDT)
Message-ID: <55220186-5dbe-6f44-45eb-10a00a1cf777@gmail.com>
Date:   Fri, 4 Aug 2023 15:02:22 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: pcmtest: Move buffer iterator initialization to
 prepare callback
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230803152824.7531-1-ivan.orlov0322@gmail.com>
 <87msz79jac.wl-tiwai@suse.de>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87msz79jac.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 14:46, Takashi Iwai wrote:
> A blank line removal is OK, but other changes are too much to fold
> into.  Please split.
> 

Hi Takashi,

Thank you for the review, I'll split the changes and send them as a 
patch series in a few minutes.

--
Kind regards,
Ivan Orlov

