Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720F97C856C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjJMMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJMMMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:12:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D70A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:12:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-405497850dbso21028395e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697199164; x=1697803964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8LGZJR/y71MrZNroBvIwe7TGxhLAIZsz9Mp4xjRfDNo=;
        b=t7ndiU+Jmv/GFGPGC1OzrGyuea3EmhVVFHZTfNqj32Q3Mj05sa+5/hpdJ9RluwZh6z
         yoHlsNJ/tCfBRc6pHNwIoJZO8hWP/Eq3oh5DtbNQ6efzlYuz4myaLXeiWYsKCjAubMzf
         PKQr7PjdPqB3KMbFlwq3gyRIZkmIIA248L2Zs0indVvABKiJS+Kqp67twc+ol4RrwsLv
         4xQiBhW+U9lgCCwy3PBFRtKZoXpq3Hk0W/OfoXucI8XpikDvsOUf5wT7CYEQgJyqIlDL
         PPyiG1I3RBT9JUJm/zYg77SuxZWJqFOoeS7JxlPZ1jWML+8GNs0l6R4SGn3CXCpwymcf
         6A2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199164; x=1697803964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LGZJR/y71MrZNroBvIwe7TGxhLAIZsz9Mp4xjRfDNo=;
        b=A2y6NitTsaFYgPH4xR1MPOwnsscW2KKuxIX0VyxU/C02aRjOuPTCnWUG993kgzJ9NU
         hsPj3WeJd8XtCZNABosNytBJNBxu/yjZHH6YLMcyjo0aa0pr7j+9qVVvU9/nF1sgGDav
         PTQw2ONuG09Mtavt8cST76RCULxEjEvZiwizO+/gxrmwJmVlQWDg7VHgGBkgcocDGQP6
         o+j0jUJ/Wg3JD+oN3Tk9A5PPk7qq48yTV50PUU4U18ybpdzjoJdY8J+mLf64TfM+duKO
         Nx4TS9BCFXB6b+wPUvXBq2ApcfwPIOBO8Li2NX6ke659kpBNpRiDkZ0nbnVjtL4bgrtH
         QpAA==
X-Gm-Message-State: AOJu0YxzApwfrbj+VIlM4RKbMZvW2sA1ANGW4R3CpsiJRaB2rJq/KeVH
        RbitwWj4V70cWG564BE0VnmBVw==
X-Google-Smtp-Source: AGHT+IFrQId3e2I2JlTBoULYCR/H7+bsaYxtMNZ1tZUYf/kvRK/eOFQV33wAqP1yoQmYpPOmpLznjA==
X-Received: by 2002:adf:e383:0:b0:320:1c4:e213 with SMTP id e3-20020adfe383000000b0032001c4e213mr23211870wrm.1.1697199164056;
        Fri, 13 Oct 2023 05:12:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i17-20020adffdd1000000b00326c952716esm20467669wrs.61.2023.10.13.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:12:43 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:12:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
References: <ZSkg7y2Y2T3midXB@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkg7y2Y2T3midXB@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 01:50:23PM +0300, Calvince Otieno wrote:
> prism2sta_inf_handover() function basically calls pr_debug() to print
> a literal string. This can be done by the parent function directly.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
> Patch version v2:
> 	- Replace pr_debug() utility function with the module specific netdev_dbg()

This isn't a v2 patch, right?  This patch assumes that we applied the
v1 patch...

This patch is not white space damaged though so that's good.

regards,
dan carpenter


