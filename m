Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF797697E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGaNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGaNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:44:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3809D1709;
        Mon, 31 Jul 2023 06:44:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25e847bb482so835202a91.1;
        Mon, 31 Jul 2023 06:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690811085; x=1691415885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv4eEdzpRIyrH/+IfcFPu37k/d42alZPDTBwvhPALFI=;
        b=Y4KZTJf6Zg4vd+GQMSfuZlbfhlt/uPZD/ssdSq5/j+48h4t+kiT5ixSs5Wk5Y0c3GI
         WUXxVX1OA69hw9n2c1MDsyYCKAT61tO2bp9T0N0JhG7DRc3Mbh0Abpc69l9GrTNbzBAv
         zJRWpX5aE/xeDuEW08utVJaESYyR7zVg0vQHKMVRGgC6OeMqKv97iuTPuX9OouHSQCwT
         05w/0lHYYu2x4BLHmyR2PWPVILkarG/vv/oF1S6+SFLND5Gq2hSjcFQcAvnrTFqPCmEb
         mZw/is82u6ExYSGtHh63NQxQdXAloVbkBcP5s4RQAnDkMT10tECPF2AdvdKdtG5wim6L
         5lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811085; x=1691415885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv4eEdzpRIyrH/+IfcFPu37k/d42alZPDTBwvhPALFI=;
        b=LUNVTHFbnuAT/jZ7Q7YKecmyD8DbBpyXQ8wJz1UEDy5oDSvraa1iVe3JS0Am/FxHN4
         fLuJUW+musBZMq/ekxgP9uCb6qT3VsPsR2gqZjcYU6QtH6bkKo9rjCtEv7SQ10CfAY+d
         z5rBxzSW+ZFb6gJjoom92vhPlJYaSafUbhY4Dieh57fq/tIz/KoFxAF6FY8ztjj1/q8K
         9lpmkJ1Bcs1+75UmqkA1EdvG+uHEa7p2thEhGreokNUa6TdLUUAFcYSh/GqWRL0n9u+Y
         5LWVjFsEz2Wm5OBCzckvw6JClsLO9/c6rK6CrTqy1mmlHfw6R+i1e9MtqU0ddfh5teWv
         zndA==
X-Gm-Message-State: ABy/qLbwbii0Wym1qo1DeGMDXacTgqAfHwwOcrh1KiAuooHwolVSv1f0
        fvz+WOyB/PauXvMgJ51LJj+eVUDBWOI=
X-Google-Smtp-Source: APBJJlGwSw362RvhOsN/krp5kQpm7PrncDbtm9pJqXyP9PAQ0wbCdJ/rJiKLdsCDXDotQyhiu/4Ymg==
X-Received: by 2002:a17:90a:6c97:b0:263:730b:f568 with SMTP id y23-20020a17090a6c9700b00263730bf568mr6001069pjj.3.1690811085473;
        Mon, 31 Jul 2023 06:44:45 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b001b9dadf8bd2sm8607834plb.190.2023.07.31.06.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:44:44 -0700 (PDT)
Date:   Mon, 31 Jul 2023 06:44:42 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] net: stmmac: correct MAC propagation delay
Message-ID: <ZMe6ykS6s9a/en8r@hoboy.vegasvil.org>
References: <20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de>
 <ZMGIuKVP7BEotbrn@hoboy.vegasvil.org>
 <729dd79e-83aa-0237-1edd-1662a6ae28cd@pengutronix.de>
 <ZMJy6yt4CL250x6Q@hoboy.vegasvil.org>
 <de822fa6-16ca-381c-2cdf-7e983f29945b@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de822fa6-16ca-381c-2cdf-7e983f29945b@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:00:29AM +0200, Johannes Zink wrote:

> I cannot tell for sure either, since I have datasheets for the i.MX8MP only.
> Maybe Kurt has some insights here, as he has additional hardware available
> for testing?

Maybe give the folks who make the dwc a call to clarify?
 
> Nevertheless, I am going to add a guard to only use the correction codepath
> on i.MX8MP in v3 for the time being, we can add other hardware later
> trivially if they support doing this.

Sure.

Thanks,
Richard
